How to work with refactored Scenes, Monsters, and Items?
==============================================================

# Monster classes

`Monster` class represents something player combats with. Its fields are combat params, its methods are attacks and AI.

## Creating new monster

### Basics

Go to Monster constructor, copy its contents, uncomment, and follow the instructions.
There is a number of fields that **MUST** be initialized. If you miss them, you will get a **/!\\BUG** message during
 the combat.

The resulting monster will have a default AI (which is randomly choose between physical attack or one of specials),
will not have any victory/loss rape scenes (but still will drop gems and xp / take gems and 8 hours).

To start the combat with that monster in the scene, just call `startCombat(new MyMonster());`. You can also assign
monster to a variable and modify it.

You also should add the monster to `Scenes/Explore/ExploreDebug.allMonsters` array, so it will be combated in that debug
scene. You can put it in the beginning of the array to quicky test it in debug mode. In that test also check the
inspection and compare it with description.

### Special attacks

Default monsters can have up to 3 special attacks stored in fields `special1`, `special2`, `special3`.
Values could be either 5xxx event codes (old-style, use **ONLY** for existing special) or function references.

Any special attack at all the return points should call `combatRoundOver()` to mark end of monster action.

### Scenes: approach, defeated, won

You might want to write a special Scene class for the monster, which will contain

* approach scene that describes how monster attacks the player and calls `startCombat(new MyMonster())`;
* player victory scene that shows victory rape options.
  Don't forget to call `cleanupAfterCombat()`, `awardPlayer()`, or `finishCombat()` in the end (after the rape/leave).
  The difference is:
    - `cleanupAfterCombat()` calls `awardPlayer()`.
    - `finishCombat()` displays _"You defeat..."_ message and calls `awardPlayer()`.
    - `awardPlayer()` gives player XP and gems, displays messages about it, and resets `gameState` to 0.
* monster victory scene when player is defeated and raped by monster.
  Don't forget to call `cleanupAfterCombat()` in the end (after the rape).

### Overriding AI

To better understand which function to override for monster behaviour customization, here combat call flow is shown:

1. Player selects some combat action (`event 5000`).
2. `enemyAI()` is called, which just contains call to...
    1. `monster.doAI()`, and this method could be overriden. By default:
    2. If monster is stunned, frightened, constricted or otherwise has chance to skip its turn, `monster.handleStun()`,
         `handleFear()`, `handleConstricted()` methods are called. If they `return true`, said effect is ignored.
         1. Their default implementations just
            * display messages like _"your foe is stunned"_ etc;
            * decrease statusAffect round counter by one and until it reaches zero;
            * `return false;` (skip turn).
    3. Somewhere here Exgartuan (if present) gets his chance to comment the situation by `game.exgartuan.exgartuanCombatUpdate()`
    4. From this point monster should decide its action and `Monster.performCombatAction()` (overrideable) is called.
         By default:
    5. A (evenly distributed) random action is chosen from `Monster.eAttack()` and all non-null non-zero `special`1..3.
    6. Description of `special`s was given before, supppose, `Monster.eAttack()` was called from `performCombatAction()`.
         By default:
    7. In case the monster represents a mob, `statusAffectv1(StatusAffects.attacks)` is checked for number of attacks to perform.
         For each attack:
         1. An `Monster.attackSucceeded()` is called, which by default:
            1. If monster is blind, try `Monster.handleBlind()` (`true` means continue attack). Default implementation
                of `handleBlind()` is 2/3 chance to miss and print some message.
            2. Checks `Monster.playerDodged()` which <sub>should probably reside in Player class</sub>
                1. checks and rolls for `player.speedDodge(monster)`. If `true`, `outputPlayerDodged()`,
                2. checks and rolls for player perks **"Evade"**, **"Misdirection"**, **"Flexibility"**.
         2. If `attackSucceeded()`, do damage with `eOneAttack()`, by default:
            1. Call `calcDamage()`, by default `calcDamage()=player.reduceDamage(eBaseDamage())`
                1. By default, `eBaseDamage()=str+weaponAttack`.
            2. Call `player.takeDamage(damage)`
         3. Call `outputAttack(damage)` to print how severely player is damaged
         4. Call `postAttack(damage)` to perform any post-attack effects
                (currently just raises monster lust if player wears _"barely-decent bondage straps"_).
    8. Finally, `eAttack()` removes status affect **"attacks"**, that means it should be manually set by monster AI
         each round.
    9. Finally finally if combat is not over, show _"Next"_ button.
3. Repeat steps 1-2 until combat is finished. Options are:
    1. `Monster.won()`.
    2. `Monster.defeated()`.
    3. Player flees (`gameState` is reset to 0).
    4. Game over.

#### ^^ WAS TL;DR JUST TELL ME WHAT TO OVERRIDE

See examples:

1. `Imp` for very simple monster with specials
2. `ImpLord extends Imp` for monster that uses special from other monster
3. `GoblinAssassin` for monster with >3 specials
4. `Kiha` for monster that handles fear and blind.
5. `LustyDemons` for mob of monsters with different attacks
6. `Anemone` for monster that deals non-reducable poison damage
7. `Harpy` for monster that display different message for attack blocked by player

## Monster hierarchy

Generally 99% of monsters should subclass classes.Monster directly. However there are cases when several monsters
 share special attacks etc (like male and female spider morphs, also succubi). In that case you can...

1. create abstract
 class with common methods and subclass it (see Scenes/Monsters/AbstractSuccubus and its subclasses MilkySuccubus and
 SecretarialSuccubus.
2. ...however, sometimes you have already configured monster class and you want to add a new variation (example: InfestedHellhound
 extends HellHound). In that case extracting superclass is PITA so I do that thing: I add a to superclass constructor a
 parameter like `noInit:Boolean=false` and if it is `true`, no (or partial) `initXXXX` methods are called. In subclass
 I call `super(true)` and re-init it as I want.
3. The other approach (when monster is a *very* slight modification of another) is just subclass the parent monster
 and after `super()` change some properties/fields to update it. Don't forget to a) change the name. b) to **change**
 gender, you need first call `initGenderless()` to kill the genitals created in superclass and then setup the gender.

## Monster event hooks

If you want to You can set up event hooks that replace default behaviour by setting properties in monster instance.
These hooks are:
* `monster.onWon = Function(hpVictory:Boolean,pcCameWorms:Boolean)` to replace monster-won code. If the field is not null,
 default behaviour is canceled, and you have to finish the combat manually.
* `monster.onDefeated = Function(hpVictory:Boolean)` to replace monster-defeated code. Same as with `onWon`.
* `monster.onPcRunAttempt = Function()` to replace various checks and possible combat end when player hits "Run".

See property docs for more details.

### Note

Event hooks should be used in scenes to modify default monsters, and not in monster classes themselves. Monster classes
should override the functions `won`, `defeated` to change behaviour from default.

# Item classes

Shortname fields and lookups are replaced with `ItemType` instances. Its members are:
* `id`: An unique across all `ItemType`s 7-character identifier that should be kept unchanged in future game versions.
* `shortName`: Currently just a copy of an `id`, but this field is intended to store very short name of the item that could be displayed on buttons instead of id.
* `longName`: Full name of an item.
* `description` A description of an item; currently used in tooltips.
* `value`: Item price.

Remember: **For each item type there should be one and only one instance of `ItemType` class with unique `id`**.
An error will be reported in `trace` if items with same `id`s are created.
`ItemType` instances are usually `const` fields of item libraries (see below).

Saving and loading are done using `id`. To get ItemType by `id`, use `ItemType.lookupItem(id:String):ItemType`.

**Every comparison "is it *that* item?" that looks like `shortName == "ThatItm"` should be
replaced with `itype == library.THATITM` where `library` is item library (see below)**.

## Class hierarchy

1. `ItemType` is superclass for every item. It could be placed into player's inventory or chest.
2. `CommonItem` contains handy methods `outputText`, `clearOutput` and a `game` property to use when performing item
   effects.
3. `Useable` has new method `useItem(player,output,external)` that **MUST** be overriden in subclasses. It is called
   whenever player uses this item, via inventory or *"Use Now"* button. To distinguish these cases, `external` property
   is added: it is `true` when item used not from player's inventory.
    1. `SimpleUseable` is `Useable` defined by constructor parameter `effect`, which is `function(player:Player):void`.
        Examples of such items are armor crafting ingredients and kitsune statue, which display text when used.
4. `Consumable` is a `Useable` that has certain requirements, whether or not it could be used; and if it could (and it is
    not `external`, it removes 1 instance of itself from `player`'s inventory. The superclass method `useItem` is already
    overrided and **MUST NOT** be overriden. Instead, `doEffect(player:Player,output:Boolean)` **MUST** be overriden;
    `canUse(player:Player,output:Boolean)` **COULD** be overriden (default: `return true`).
    1. `SimpleConsumable` is `Consumable` defined by constructor parameter `effect`, which is `function(player:Player):void`.
        \~95% of consumables are instances of `SimpleConsumables`; the rest has custom `canUse`.
5. `Equipable` is a special kind of `Consumable` that is wielded/worn by player. Special effects could be done when
    player equips/unequips `Equipable`. You **MUST NOT** override `doEffect`. Instead, you **MUST** override methods
    * `equip(player:Player,output:Boolean)` that should check whether item could be equipped by player by calling 
        `canUse`, unequip item already equipped in that slot, put itself into the slot, and call `equipped(player,output)` 
        to call possible equip effect
    * `unequip(player:Player,output:Boolean)` that should remove itself from player's slot and call `unequipped(player,output)`
        to call possible unequip effect.
    
    Also you **CAN** override methods `equipEffect(player,output)` and `unequipEffect(player,output)` to display
    some messages or add/remove PerkLib. Overrideable method `unequipReturnItem` returns item that should be placed into
    inventory on unequip, or `null` if item simply disappears. Example cases when you need to override this method are:

    * `ComfortableUnderclothes`, `Fists`, and `GooArmor` that return `null`
    * `ComfortableClothes` that return `this` but if the clothes were transformed into others by fetish cultists/zealots
        (which is done by `player.modArmorName`), displays message of them turning into comfortable clothes.
    * Urta's `LeatherArmorSegments` turns into default leather armor on unequip.

    You cannot instantiate `Equipable`, instead, you should use one of the subclasses:

    1. `Armor`. Armor has 3 more properties: `name` (displayable name, shorter than `longName`), `def`, and `perk`.
        `perk` defines armor class: `"Light"`/`"Medium"`/`"Heavy"` but could be empty string.
        Armor is equipped in `player.armor` slot, and when unequipped, is replaced by _"comfortable underclothes"_.
        You can create instances of this class, specify everything you need in the constructor. That armor will have
        no `equipEffect`/`unequipEffect` and could be equipped by anyone.

        * `ArmorWithPerk` is a subclass of `Armor` that adds a player perk on equip and removes in on unequip. Perk
            name and properties are set up in the constructor.
        
        To fine-tune armor with custom `equipEffect`/`unequipEffect`/`canUse`, or situation-dependent properties,
        subclass it.

    2. `Weapon`. Weapon has 3 more properties: `name` (displayable name, shorter than `longName`), `verb` (like _"hit"_,
        _"slash"_ to use in constructs like `"You "+weapon.verb+" "+monster.name+" with your "+weapon.name`, `attack`,
        and `perk`. `perk` defines weapon class: `"Light"`/`"Heavy"` but could be empty string.
        Weapon is equipped in `player.weapon` slot, and when unequipped, is replaced by _"fists"_.
        You can create instances of this class, specify everything you need in the constructor. That weapon will have
        no `equipEffect`/`unequipEffect` and could be equipped by anyone.

        To fine-tune weapon with custom `equipEffect`/`unequipEffect`/`canUse`, or situation-dependent propertiesm
        subclass it.

Note: `WingStick` though being a weapon, technically is a `Consumable`. Remember that when you check if item is a weapon;
 simple `itype is Weapon` might not be enough. **TODO** `ConsumableWeapon` for javelins, throwing daggers, grenades,
 spell scrolls?

## Item libraries

As mentioned before, only **one** instance of each `ItemType` should be created. Current game architecture suggests them
being `public const` fields of item library classes, and each item library is a `public` field of `CoC` game class.

For examples, see `ConsumableLib` and `CoC.consumables`, `WeaponLib` and `CoC.weapons` etc.

Item libraries usually subclass `BaseContent` to get access to handy methods and create their own handy methods to
 quickly create `ItemType`s for the library. See below.

## Adding new item

### Adding new armor

`ArmorLib` has methods
 `mk(id,shortName,name,longName,def,value,description,perk="")` to create `Armor` and
 `mk2(id,shortName,name,longName,def,value,description,perk,playerPerkName,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4,playerPerkDesc)` to create `ArmorWithPerk`.

See examples.

TODO moar on custom armorz

### Adding new weapon

`WeaponLib` has method
 `mk(id,shortName,name,longName,verb,attack,value,description,perk="")` to create `Weapon`.

See examples.

TODO moar on custom weaponz

### Adding new consumable

`ConsumableLib` has method
 `mk(id,shortName,longName,effect,description,value=DEFAULT_VALUE)` to create `SimpleConsumable`.
`effect` should be `function(player:Player):void`.
Legacy consumable effects are stored in `Mutations` class, which is accessible via `m` property.
If you want to have one function to handle different consumables
 (like, `succubiMilk` for both tainted and pure versions),
 declare it with parameters and **`player` argument last**;
 then use `curry` function (see bottom of this readme) to create partial function call
  (e.g. `curry(m.succubiMilk,true)` will return `function(player:Player){m.succubiMilk(true,player)}`.

See examples.

TODO moar on custom consumablez

### Adding new other item

`UseableLib` holds items that are useable but not consumed when used (reagents, kitsune statue).
It has method `mk(id,shortName,longName,effect,description,value=DEFAULT_VALUE)` to create `SimpleUseable`.
`effect` should be `function(player:Player):void`.

See examples.

`MiscItemLib` is currently empty and probably should contain all other kinds of items.

# Scene classes

## Class hierarchy

These are not strict rules but a general directions.

All scenes should be put it BaseContent subclasses. How many classes per event it developer to decide.

An instance of this scene class should be available from `CoC` (declared as field and instantiated in the declaration),
but not necessarily directly. It is preferable that location-specific scenes should be fields of corresponding location
scenes. In code referencing a "foreign" scene to call an event could be something like
`doNext(kGAMECLASS.telAdre.bakeryScene.bakeryuuuuuu);` . For such location-specific scenes it is good to subclass them
from common superclass containing handy methods to access instance of their parent and other helpy stuff (see
_Scenes/Places/TelAdre/TelAdreAbstractContent.as_ )

Due to legacy reasons, if a NPC is combatable, its Monster subclass should be named after him (`Npcname`), and its BaseContent
subclass should be named `Npcname+"Scene"`. However, if a non-combatable NPC (with BaseContent subclass named `npcname`)
becomes combatable in future releases, either its Monster subclass should be named `Npcname+"Combat"`, or the original
`Npcname` should be renamed to `NpcnameScene` and its Monster subclass should be named `Npcname`. Messy.

## Class members

1. Remember that all variables declared in the Scene will not be saved/loaded in any way, or even resetted after save/load
   unless there is specific code for that in global save/load/newgame method.
2. Please keep methods as invisible as possible; a good start would be declare every function private and make them
   public/internal when needed.
3. For debugging purposes methods of all classes in package _classes/Scenes/_ or its subpackages are listed in
   name-by-ref dictionary `funcLookups`, see _engineCore.as_ (Before that only CoC methods were saved in that dictionary).
   If for whatever reason your scene is in another package, add an `[Scene]` metadata to it (see declaration of
   `testContent` in `CoC` for example.

# File placement

## Locations

A **Location** is either **Camp**, **Area**, **Place**, **Dungeon**, or **Quest**.

1. An **Area** is package, which main scene is directly available from **Explore** menu.
2. A **Place** is package, which main scene is available from **Explore** -> **Places** menu, but is not a **Dungeon**.
3. A definitions of **Dungeon** and **Quest** assumed obvious.
4. A BaseContent subclass for general **Area** or **Place** should be placed in either _Scenes/Areas_ or _Scenes/Places_,
   correspondingly.

### Notes

1. **Locations** that share many common scenes could be joined in one package, like **Forest** and **Deepwoods**.
2. Events for **Explore** -> **Explore** should be placed into _Scenes/Explore_.

## NPCs

1. If a **NPC** cannot be discovered directly by visiting **Location**, put it in _Scenes/NPCs_.
2. If a **NPC** can be made a follower/slave/lover/etc, or contains highly detailed dialogue/scene,
   put it in _Scenes/NPCs_.
1. If a **NPC** can be met in a specific **Place** or **Dungeon**, put it in its corresponding package.
3. Else put it in corresponding **Area** package.

## Monsters

1. **Monster** classes that are related to **NPCs** should be placed in same package as corresponding **NPCs**.
2. **Monsters** that mostly could be found in one **Location** should be placed in that **Location** package.
3. Else put it in _Scenes/Monsters_.

## Other scenes

If it does not fit **Camp** scenes, put it whatever it seems logial and where similar scenes may appear.

# Utility functions

During all these refucktorings, I've found `createCallBackFunction` not enough (also, I've moved it to new `Utils` class)
So I've added more functions, (`curry` is enough for most cases):

* `curry(func,...args)` is a partial function call. It returns a function, that will call `func` with first
    arguments already applied: `curry(func,arg1,...,argN)(arg2_1,...,arg2_M) = func(arg1,...,argN,arg2_1,...arg2_M)`.
    For example, `SimpleUseable` accepts `function(player:Player)`, but some of the mutations are parametrized, e.g.
    Incubi Draft could be purified. So we make `function incubiDraft(purified:Boolean,player:Player)`, and to make
    a function reference to impure draft, we use `f=curry(incubiDraft,false)`, and `f(player)` will call
    `incubiDraft(false,player)`.
* `curry(func,arg)` is equivalent of `createCallBackFunction(func,arg)`.
* `lazyIndex(obj,...args)` is a lazy property access. It returns a function, that will dig into `obj`'s `args`
    and return whatever is last: `lazyIndex(obj,arg1,...,argN)()=obj["arg1"]..["argN"]`.
    For example, in cases when `game.telAdre` is not yet initialized (but `game` is), and
    you need to access function reference `game.telAdre.doSomething`, you can use `lazyIndex(game,"telAdre","doSomething")`.
* `lazyCallIndex(func,...args)` is a lazy property access of an unavailable object. It returns a function, that will call
    `func` and dig into result's properties specified by `args`:
    `lazyCallIndex(func,arg1,...,argN)() = func()["arg1"]..["argN"]`.
    Let us enhance previous example and suppose that we need to access same function reference `game.telAdre.doSomething`,
    but even `game` is not initialized. So we make `function getGame(){return game}` and use `lazyCallIndex`:
    `lazyCallindex(getGame,"telAdre","doSomething")`.
* `lazyCallIndexCall(func,...args1)` is the ultimate case when the returned function accepts arguments:
    `lazyCallIndexCall(func,args1_1,...,args1_N)(args2_1,...args2_M) = func()["args1_1"]...["args1_N"](args2_1,...,args2_M)`.
    Example how to use this monstrosity. Previous example, suppose `game.telAdre.doSomething` accepts argument.
    So we can do `f=lazyCallIndexCall(getGame,telAdre,doSomething)` and then `f(bar)` will call `getGame().telAdre.doSomething(bar)`.
* That above example is not type-safe or any kind of safe, so I prefer to use `f=function(bar:Bar){game.telAdre.doSomething(bar)}`
