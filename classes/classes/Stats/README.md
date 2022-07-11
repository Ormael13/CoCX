# Stats cheatsheet

## Terms & formulas

**Buff** - positive or negative modification of stat. Holds value, duration, tag, text, and other options.

**Tag** - unique ID of buff.

**Tick** - time unit of buff.

Str,Tou,Spe,Int,Wis,Lib are all "Primary stats".

**Primary Stat** - a complex stat, consisting of:
* core - counter for levelup points and training. 1-100(*). Cannot hold buffs.
* bonus - part with additive buffs.
* mult - part with multiplicative buffs.

(*) Max value of 100 can be raised by perks. No max for monsters.

**Primary Stat total value = Core * Multiplier + Bonus**, minimum 1.

**Bonus total value = sum of buffs**, uncapped.

**Multiplier total value = 1.0 + sum of multiplier buffs**, lower cap is 0.

#### Short example

```js
// set core part
player.strStat.core.value = 20;
// add curse debuff
player.addCurse("str", 5);
// add buff for 2 combat rounds
player.buff("Might").addStat("str", +20).withText("Might spell").combatTemporary(4);
// add racial buff to multiplier to multiple stats
player.buff("Racials").setStats({"str.mult": +0.2, "tou.mult": +0.4}).withText("Racial").permanent();
```
After that, total value of `player.str` would be calculated as:
* str.core = 20
* str.bonus = 15
  - -5 from "Curse" buff
  - +20 from "Might" buff
* str.mult = 1.2
  - 1.0 initial value
  - 0.2 from "Racial" buff

Total = 20 * 1.2 + 15 = 24 + 15 = 39

## Stat names

Correct buffable stat names are:
* `"str"`, `"str.mult"`
* `"tou"`, `"tou.mult"`
* `"spe"`, `"spe.mult"`
* `"int"`, `"int.mult"`
* `"wis"`, `"wis.mult"`
* `"lib"`, `"lib.mult"`
* `"sens"`

See `_stats` definition in Creature.as for actual list.

(Techincally, for primary stats, you should buff "xxx.bonus" instead of "xxx", but short form is allowed and preferred for simplicity).

## BuffBuilder

Function `buff("tag")`, accessible in Creatures. It gives a "builder" object you chain methods on.

Typically, you set up stats, text, and duration.

**Example**: Create a 4-hour str&spe -10 debuff on player:

```js
player.buff("Poison")
      .setStats( { "str": -10, "spe": -10 })
      .withText("Poisoned!")
      .forHours(4);
```

### Functions to adjust stats

```js
player.buff("Poison").addStat("str", -10);
player.buff("Poison").addStat("str", -10, -50, 0);
```
Buff the stat. If buff already present, **increase** it.

Optional `min` and `max` arguments control the limits of total buff value. Buff is removed if its value becomes 0.

----

```js
player.buff("Poison").setStat("str", -10);
```
Buff the stat. If buff already present, **reset** it.

----

```js
player.buff("Poison").addStats( {"str": -10, "spe": -10} );
```
Buff multiple stats. If buff already present, **increase** it.

----

```js
player.buff("Poison").subtractStats( {"str": -10, "spe": -10} );
// same as
player.buff("Poison").addStats( {"str": 10, "spe": 10} );
```
Un-buff multiple stats (apply reverse numbers).

----

```js
player.buff("Poison").setStats( {"str": -10, "spe": -10} );
```
Buff multiple stats. If buff already present, **reset** it.

Will not remove buffs from other stats! Example:
```js
player.buff("Poison").setStats( {"str": -10, "spe": -10} );
player.buff("Poison").setStats( {"str": -20, "int": -20} );
// will NOT clear "spe" debuff!
// total buff will be { "str": -20, "spe": -10, "int": -20 }
```


### Duration

**If you don't specify duration, the buff will be permanent** (not affected by time, still can be removed in code).

----

```js
player.buff("Curse").permanent();
```
Make this buff permanent.

----

```js
player.buff("Poison").forHours(4);
```
Make this buff last specified amount of hours.

----

```js
player.buff("Poison").forDays(7);
```
Make this buff last specified amount of days.

----

```js
player.buff("Poison").combatTemporary(3);
```
Make this buff last specified amount of combat rounds. Will remove itself after combat.

----

```js
player.buff("Poison").combatPermanent();
```
Make this buff last until end of the combat.

----

```js
player.buff("Poison").addDuration(3);
```
For temporary buffs, increase duration by this number of "ticks" (hours/days/rounds, depending on how buff was created).


### Other buff options

```js
player.buff("Poison").withText("Poisoned!");
```
Set displayable text (visible when hovering over stat).

----

```js
player.buff("HiddenCurse").withOptions( {show:false} );
```
Make buff display as "<b>Unknown Sources:</b> ±??", not revealing details.

### Removing

```js
player.buff("Poison").remove();
````
Remove this buff, if present.

----

```js
player.buff("Poison").removeFromStat("int");
````
Remove this buff, if present, but only from one stat.

### Buff testing

These functions are **non-chainable**, they must be only or last item in chain.

----

```js
var isPoisoned:Boolean = player.buff("Curse").isPresent()
// isPoisoned = true
```
Returns `true`, if creature has buff with this tag (to any stat).

----

```js
var duration:int = buff("Poison").getRemainingTicks();
// duration = 4
```
For temporary buffs, return number of ticks remaining. For permanent, returns 0.

----

```js
var currentSpeDebuff: Number = buff("Poison").getValueOfStatBuff("spe");
// currentSpeDebuff = -10
```
If this buff is present on stat, return its value; otherwise return 0.

### Notes on using BuffBuilder

Whenever possible, these function should be chained.

```js
// BAD
player.buff("Poison").setStats( { "str": -10, "spe": -10 });
player.buff("Poison").withText("Poisoned!");
player.buff("Poison").forHours(4);
// GOOD
player.buff("Poison")
      .setStats( { "str": -10, "spe": -10 })
      .withText("Poisoned!")
      .forHours(4);
```

You can skip that if you change options on condition:

```js
player.buff("Poison")
      .setStats( { "str": -10, "spe": -10 })
      .withText("Poisoned!");
if (longTermPoison) {
    player.buff("Poison").forDays(4);
} else {
    player.buff("Poison").forHours(4);
}
```

You MUST specify all options when buffing new stat.

```js
// WRONG
player.buff("Poison")
      .setStats( { "str": -10, "spe": -10 })
      .withText("Poisoned!")
      .forHours(4);
if (poisonAffectInt) {
    player.buff("Poison").setStat("int", -10);
    // Will create a permanent debuff without text
}

// CORRECT
player.buff("Poison")
      .setStats( { "str": -10, "spe": -10 })
      .withText("Poisoned!")
      .forHours(4);
if (poisonAffectInt) {
      player.buff("Poison")
            .setStats( { "int": -10 })
            .withText("Poisoned!")
            .forHours(4);
}

// BEST SOLUTION
var poisonDebuffs:Object = { "str": -10, "spe": -10 };
if (poisonAffectInt) {
    poisonDebuffs["int"] = -10;
}
player.buff("Poison")
      .setStats(poisonDebuffs)
      .withText("Poisoned!")
      .forHours(4);
```

## Creature utilities

### Training

```js
player.trainStat("str", +5, 90);
```

Will increase `str` core value by +5 up to maximum of 90.

### Curses

"Curses" are permanent debuffs with special tag and text.

```js
player.addCurse("spe", 10);
```
Will add a -10 debuff to speed.

----

```js
player.removeCurse("wis", 20);
```
Will reduce power of wisdom Curse debuff by 20. If current wisdom curse power is <= 20, wisdom curse will be removed completely.

----

Sensitivity is "bad" stat, and sensitivity curses will increase it instead.

#### dynStats

In the new system dynStats translates to addCurse/removeCurse.

**Example**:
```js
player.dynStats("int", -10, "str", +20);
```
will translate to
```js
player.addCurse("int", 10);
player.removeCurse("str", 20);
```

### MutagenBonus, AlchemyBonus, KnowledgeBonus

(Player only).

Give a cumulative 1% bonus to stat multiplier, capped at 20% (in each category). Also reduce curse power to stat. Negative values decrease it down to -20%.

**Example**:
```js
player.MutagenBonus("int", 5);
```
If "Mutagen" buff to "int.mult" is < 0.20, increase by 0.01.

## StatStore

Every creature has `statStore` that keeps all stats under unique names, and has functions to manipulate them. It provides "lower-level" access to buff system, **and it is preferable to use BuffBuilder instead**.

However, some functions are available at StatStore only.

### advanceTime(rate: int, tick: int)

Advance time-tracking buffs by `ticks` units, unit type is defined by `rate`
Buffs with their countdown expired are removed.

Will reset & populate `recentlyRemovedTags`

**Example**
```js
player.statStore.advanceTime(Buff.RATE_HOURS,1);
```
All buffs with "hours" timers will have duration decreased by 1.
Those whose duration hits 0, will be removed.

### removeCombatRoundTrackingBuffs()

Remove all combat buffs.

Will reset & populate `recentlyRemovedTags`.

### recentlyRemovedTags

A collection of tags of buffs that were removed _just now_. After advancing time, you should check it ASAP.

**Example**
```js
player.statStore.advanceTime(Buff.RATE_HOURS,1);
if (player.statStore.recentlyRemovedTags["Blessing"]) {
    outputText("Your blessing fades.")
}
if (player.statStore.recentlyRemovedTags["Poison"]) {
    outputText("You are no longer poisoned.")
}
```

### removeBuffs(tag:String)

Remove all buffs with that tag from all stats.

### hasBuff(tag:String)

`true` is any stat has buff with this tag.

### addBuff(stat:String, amount:Number, tag:String, options:*)

Adds a buff to stat. If already exists, increase it.

Options are
 * `text`, displayed text in buff description
 * `show`, default true. If false, then the buff will be hidden in detalization. You'll still see total value but not the reason.
 * `save`, default true. If false, then the buff will not be saved. It is useable for buffs from races, perks, and items - they should be auto-added
 * `rate`, default Buff.RATE_PERMANENT. Other options are: RATE_ROUNDS, RATE_HOURS, RATE_DAYS. Used with ticks, see below.
 * `tick`, default 0. How many units of time (see rate) the buff will last until it will be auto-removed

**Example**
```js
player.statStore.addBuff("str",-amount,"Poison", {text:"Poisoned!",rate:Buff.RATE_HOURS, tick:4})
```

**BE CAREFUL**. Option names **ARE NOT CHECKED**. If you type `ticks: 4` or `Text: "Buff"` it will compile but **WON'T WORK PROPERLY**. Therefore, it is highly recommended to use BuffBuilder instead.

### addBuffObject(buffs:Object, tag:String, options:*)

Add multiple buffs to stats, increasing those which exist.

**Example**
```js
player.statStore.addBuffObject(
    {"str":-2,"tou":-2,"spe":-2,"int":-1},
    "Poison",
    {text:"Poisoned!",rate:Buff.RATE_HOURS, tick:4}
);
```

**SAME WARNING APPLIES** as with `addBuff`

### replaceBuffObject(buffs:Object, tag:String, options:*)

Add multiple buffs to stats, replacing those which exist. **Will not remove stats buffed earlier**

**Example**
```js
player.statStore.replaceBuffObject(
    {"wis.mult":0.10,"int.mult":0.10},
    "KitsuneShrine",
    {text:"Kitsune shrine Meditation", rate:Buff.RATE_DAYS, tick:7}
);
```

**SAME WARNING APPLIES** as with `addBuff`

## Primary stats

Primary stat objects are kept `strStat`, `touStat` and other variables in Creature. Use them to manage primary stat directly, if needed. `str`, `tou` etc are used to get **current total value**.

### Core value

Core value is accessible by `xxxStat.core.value` and read or written as any other variable.

**Example**
```js
if (player.intStat.core.value < 20)
    player.intStat.core.value += 1;
```

### Mins and maxes

TODO maybe write about that too

### Functional values

TODO maybe write about that too
