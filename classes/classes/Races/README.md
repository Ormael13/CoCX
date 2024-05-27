# New Race system

## Architecture

Each **Race** consists of:
* **RacialRequirement**'s. Requirements are single checks that add/deduct racial score points. They have: 
  * name (ex. "fox ears") or name function (to compute the name when the requirement is shown), displayed in race DB page
  * check function (`player.ears.type == Ears.FOX`)
  * pass score (ex. +1), granted if check function passes
  * fail score (ex. -1, default 0), applied if check function fails
  * min score for this requirement to be applied (ex. "if kitsune score >= 5, give +1 for plain skin")
* **RacialTier**'s. Tier is a milestone on the racial score scale with its own name, bonuses, and requirements. They have:
  * name function (ex. "nine-tailed kitsune/kitsune-taur") that generates a displayed racial name for particular body.
  * minimum score (ex. 16) player has to have to qualify for tier.
  * custom requirements (ex. "have nine tails")
  * buffs (ex. "-35% Strength, +75% Wisdom...") given to qualified player.
  * extra non-buff bonuses to be displayed (ex. "+1 Armor")
* Several extra properties:
  * name
  * "hidden" flag (do not display race, but apply bonuses)
  * "disabled" flag (do not display or apply bonuses)
  * optional list of bloodline perks
  * optional list of mutation perks
  * a debug collection of forms to transform into that race from a cheat menu

Notes:
* If player qualifies for a higher tier, they don't get lower tier bonuses.
* By default, lower tier custom requirements are not copied to higher tier. Use `.requirePreviousTier()` if needed.

## BodyData class

`BodyData` class stores a copy of most important player body data (body part types, colors, sizes). It can be used to quickly check if player has been transformed. It also holds a reference to player to check for perks and other parts not stored in `BodyData` itself.

All `BodyData` information is stored in a single array, its indices are called "slots".

### Difference from Player properties

1. "legs" is used instead of "lower body".
2. If player has no coat, coat-related slots like `body.skinCoatType` have invalid values. Therefore, you can simplify check "if has coat and coat type/color is X" to "if coat type/color is X". 
3. Similarly, if player has no vagina, `body.vaginaType` holds invalid value, and "if has vagina and its type is X" check can be simplified to "if vagina type is X". 

## Overview of new & replaced functions

To get racial score and check if it is enough:
* Old: `player.dragonScore()` - some of these functions were deleted
* New: `player.racialScore(Races.DRAGON)`
* Old: `player.dragonScore() >= 16` (is lowest dragon tier)
* New: `player.isRace(Races.DRAGON)`
* New: `player.isRace(Races.DRAGON, 1)`
* Old: `player.dragonScore() < 16` (is not a dragon)
* New: `!player.isRace(Races.DRAGON)`
* Old: `player.dragonScore() >= 24` (is dragon tier 2, "elder dragon")
* New: `player.isRace(Races.DRAGON, 2)`

`player.racialTier(Races.DRAGON)` returns 0 for score 0..15, 1 for 16..23, 2 for 24..31, 3 for 32+.

# Adding new races

Steps:

1. Create a class in `classes/classes/Races` directory from a template.
2. Add score calculation code.
3. Add tiers.
4. Add race into `Races` library class.
5. Add race into `RaceMem` class

## New race file template

```as
package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class ZzzRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];
        
    public function ZzzRace(id:int) {
        super("Zzz", id, RaceBody);
    }
    
    public override function setup():void {
        addScores()
                .//start ctrl-spacing here
                ;

        buildTier(1000, "tierName")
                .buffs({
                        "str.mult": +0.00,
                        "tou.mult": +0.00,
                        "spe.mult": +0.00,
                        "int.mult": +0.00,
                        "wis.mult": +0.00,
                        "lib.mult": +0.00,
                        "sens": +0
                    })
                .end();
    }
}
}
```

Things you could add to the constructor:
* `disabled = true`/`hidden=true` to make race disabled/hidden.
* `chimeraTier = 0; grandChimeraTier = 0;` to disabled adding points to chimera/grand chimera.
* `chimeraTier = <N>; grandChimeraTier = <N+1>;` to change default chimera/grand chimera min tiers from default 1 and 2.
* `mutationThreshold = <N>;` By default you get bonuses from mutations only after 3 points from other sources. You can change that number.

## Score calculation

Racial scores are made with `RaceScoreBuilder` class. Start by adding one of `addScores()` functions in the `setup()` function, and write a method chain.

Most builder methods have a signature `bodyPart(value, passScore, failScore=0, customName="")`. `customName` can be used to replace auto-generated requirement name.

Examples:
* `.eyeType(Eyes.FOX, +1)` -> "fox eyes (+1)"
* `.earType(Ears.FOX, +1, -1)` -> "fox ears (+1) (-1 penalty)"

The `value` argument can take special "operator" constructs created with `NOT`,`ANY`,`NONE`,`LESS_THAN`,`GREATER_THAN`,`AT_LEAST`,`AT_MOST`.

Examples:
* `.legType(NOT(LowerBody.FROSTWYRM), 0, -1000)` -> "not frost wyrm legs (0) (required)"
* `.armType(ANY(Arms.HUMAN, Arms.KITSUNE, Arms.FOX), +1)` -> "human, kitsune or fox arms (+1)"
* `.faceType(NONE(Face.CHESHIRE,Face.CHESHIRE_SMILE), 0, -7)` -> "neither cheshire nor cheshire smile face (0) (-7 penalty)"
* `.height(LESS_THAN(48), +2)` -> "height less than 4 feet (+2)"

### Custom requirements

If you need to add a requirement that doesn't have fitting built-in function, use `.customRequirement`:

```as
.customRequirement(
        "skin", 
        "fur or magical tatoo",
        function (body:BodyData):Boolean {
            return body.skinCoatType == Skin.FUR
                    || body.skinBasePattern == Skin.PATTERN_MAGICAL_TATTOO
        }, 
        +1)
```

Arguments:
* group name (not used yet)
* displayed name
* function, return true if requirement fulfilled
* pass score
* (optional) fail score, default 0

### Custom score requirements

You can add a requirement that gives varying bonus with `customScoreRequirement`:

```as
.customScoreRequirement(
        "tail", 
        "multiple fox tails, +1 per tail",
        function (body:BodyData):Boolean {
            return body.tailType == Tail.FOX && body.tailCount >= 2;
        },
        function (body:BodyData):int {
            return body.tailCount;
        },
        -7
)
```
Arguments - same as `customRequirement()` but pass score is a function.

### Group wrappers

To gate a requirement(s) behind minimum score from previous requirements, use `addScoresAfter()`:

```as
addScoresAfter(4)
  .faceType(Face.FOX, +1);

=> +1 score for fox face, but only if already has score 4 
```

You can also add a common condition to multiple requirements with `addConditionedScores()`:

```as
addConditionedScores(
        function (body:BodyData):Boolean {
            return body.player.hasPlainSkinOnly();
        },
        "plain skin; "
)
        .armType(Arms.HUMAN, +1)
        .legType(LowerBody.HUMAN, +1)
```

would add requirements:
* plain skin; human arms (+1)
* plain skin; human legs (+1)

### Mutations and bloodline bonuses

Mutation and bloodline bonuses are configured with a special `addMutation` and `addBloodline` methods outside `addScores()` chain. The default mutation bonus is +1 per stage could be overriden.

```as
addBloodline(PerkLib.KitsunesDescendant, PerkLib.BloodlineKitsune);
addMutation(IMutationsLib.KitsuneThyroidGlandIM);
addMutation(IMutationsLib.TwinHeartIM, +2);
```

To gate mutation/bloodline bonuses behing score different than default 5, set `mutatonThreshold` in the constructor. 

### finalizeScore

`Race.finalizeScore` contains code that applies bonuses common to all races, or resets score to zero in certain conditions.

Races don't need to override it; its superclass implementation contains the shared code.

Possible scenario when you want to override it is varying fail score requirements (see HumanRace for example).

By default, having Racial Paragon, being a gargoyle, or fusing with elemental (at the moment) sets the score to 0. You can disable this by setting `checkRP` to false.

## Tiers

Racial tiers are configured in `setup()` function. They SHOULD be written in ascending order.

Tier configuration starts with `buildTier(minScore, name)` followed by a method chain. It MUST end with `.end()` function.

### Extra requirements

When a tier requires more than having a score, use a `.requireXXXX()/.require()` functions.

Example:
```
buildTier(16, "nine-tailed kitsune")
        .requireTailCount(9)
```
```
buildTier(9, "kitsune")
        .require("2+ fox tails", function (body:BodyData):Boolean {
            return body.tailType == Tail.FOX && body.tailCount >= 2
        })
```

Note that requirements are not propagated by default to higher tiers. To do that, add a `.requirePreviousTier()` to the higher tier declaration.

### Naming function

By default, a second argument of the `buildTier` function would be used to name a player. You can configure different names for differently shaped/gendered player using one of these functions:
* `namesTauric(nonTaurName, taurName)`
* `namesMaleFemale(maleName, femaleName)`
* `namesMaleFemale(maleNonTaurName, femaleNonTaurName, maleTaurName[, femaleTaurName])` - if female taur name is omitted, it's same as male
* `namesMaleFemaleMorph(maleName, femaleName, morphName)` - will use `maleName/femaleName` if player has human-shaped face, otherwise `morphName`
* `namesMaleFemaleMorphTaur(maleName, femaleName, morphName, taurName)` - special name for taurs, otherwise same as above
* `customNamingFunction` - when everything else is not flexible enough.

### Buffs

Buffs that are granted by a racial tier are configured with `.buffs(buffObject)` function. Note that lower-tier buffs are not applied, so for higher-tier buffs a total value must be provided and not an extra bonus.

Example:
```as
buildTier(9, "kitsune")
        .buffs({
            "str.mult": -0.35,
            "spe.mult": +0.25,
            "int.mult": +0.60,
            "wis.mult": +0.75,
            "lib.mult": +0.30,
            "sens": +20,
            "maxsf_mult": +0.20,
            "maxfatigue_base": +100
        })
```

#### Extra bonuses

When a racial tier gives a bonus that is not a buff, you can add its description with `withExtraBonuses` so player would know about its existence.

Example:
```as
buildTier(14, "orca")
        .withExtraBonuses("+35 Max Hunger")
```

#### Dynamic buffs

When buffs depend on some other properties, you can use `withDynamicBuffs` function.

For example, see Gargoyle and Elemental Fusion races.

### Racial forms

For racial forms that don't have clear tier order (for example, Gargoyle materials), there are two ways of implementing them.

1. Different tiers.
Pros: Integrates well into existing scheme. Better auto-generated description.
Cons: This might mess the concept of "tier number" for that race.

2. Single tier with dynamic buffs & naming.
Pros: Preserves tier numbering. Most flexible way.
Cons: Requires more complex code. Buffs and requirements won't properly show in race DB menu.

There is no "best way" to do it; currently such races - Gargoyle, Alicorn, Elemental - use (2).

## Debug forms

_This is for easier debugging/testing._ You can define "debug forms" - lists of transformations/perks/statuses to quickly apply from `[Appearance] > [Racial Scores]` menu under that race.

To do that, overwrite a `debugForms` race with a map. Each element is a debug form, its key is its name. A value should be a list of one of these objects:
* transformations from TransformationLib (accessed via `game.transformations`)
* StatusEffectType - added with zero values. To add a status effect with custom values, add a nested 5-element array `[effect type, value1, value2, value3, value4]`
* IMutationPerkType - added with max stage. To add a different stage, add a nested 2-element array `[mutation type, stage]`
* PerkType - added with zero values. To add a perk with custom values, add a nested 5-element array `[perk type, value1, value2, value3, value4]`.
* functions with signature `function(player:Player):void`

See Kitsune and Human races for example.

## Recommendations

Fail score of -1000 means that this is an absolute requirement. They are displayed is a special way in racial menu.

Racial requirements are printed and applied in the order of their declaration.

To penalize race for having certain part, it is better to add `NOT`-requirement with `0` score and negative `failScore`.

Color lists that can be shared between race check and mutation should be stored in race subclass as public static members (see for example `KitsuneRace.BasicKitsuneHairColors`).

Checking other racial score should be avoided. If race AAA should check for being partially a race BBB and penalize for it, add a `BBB.isBbbLike(body:BodyData):Boolean` function and use it in AAA. See for example Gorgon and other snake-like races.  
