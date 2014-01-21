How to work with refactored Scenes, Monsters, and Items?
==============================================================

# Monster classes

`Monster` class represents something player combats with. Its fields are combat params, its methods are attacks and AI.

## Creating new monster

### Basics

In the simplest case you just need to subclass Monster class and call all `init01Name()`..`init14____Drop()` functions using
function docs and existing monsters as reference and example.

Numbered `init` functions are **required** (they include basic appearance features and all core params), the ones
starting with `initX_` are optional (e.g. special attacks, horns, tails, wings etc).

The resulting monster will have a default AI (which is randomly choose between physical attack or one of specials),
will not have any victory/loss rape scenes (but still will drop gems and xp / take gems and 8 hours).

To start the combat with that monster in the scene, just call `startCombat(new MyMonster());`.

### Special attacks

Default monsters can have up to 3 special attacks which could be set up by `initX_Specials(special1:*=0,special2:*=0,special3:*=0)`.
Arguments could be either 5xxx event codes (old-style, use **ONLY** for existing special) or function references.

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
    7. In case the monster represents a mob, `statusAffectv1("attacks")` is checked for number of attacks to perform.
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
 and after `super()` call several `initXXXX` methods to update it. Don't forget to a) change the name. b) to **change**
  gender, you need first call `init02Genderless()` to kill the genitals created in superclass and then setup the gender.

# Item classes

TODO write

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
becomes combatable in future releases, its Monster subclass should be created and named `Npcname+"Monster"` or `Npcname+"Combat"`.

In distant future we may rename all monster subclasses to `Monstername+"Monster"` and their scene classes to simple `Monstername`.

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

1. If a **NPC** can not be discovered directly by visiting **Location**, put it in _Scenes/NPCs_.
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