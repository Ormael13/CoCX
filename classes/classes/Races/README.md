# TODO @aimozg
* write README!
* Check generated requirement names
* Check score functions checking non-tiers
* Inline `xxxxScore` functions?
* iterate in chimeras
* solve unicornkin/alicornkin races
* consider moving naming function from tier to race
* NG+ & paragon-like scale buffs in race itself
* search for `isRace(..) >=/< `
* error reporting utility
* Future:
  * racial score caching
  * `Race.onTierUp`/`onTierDown` - see `PlayerEvents:1500`
  * "Racial form" maybe? (gargoyles, alicorn/nightmare, elementals - same tier, diff. requirements/bonuses) Could be done by customizing tier number and simply renaming RaceTier -> RaceForm.
  * manifest race/tier (for testing)
  * add buffable stats: armor, magic resistance, evasion, unarmed dmg
  * finish converting elemental stuff? eh...

# New Race system

## Architecture

Each **Race** consists of:
* **RacialRequirement**'s. Requirements are single checks that add/deduct racial score points. They have: 
  * name (ex. "fox ears"), displayed in race DB page
  * check function (`player.ears.type == Ears.FOX`)
  * pass score (ex. +1), granted if check function passes
  * fail score (ex. -1, default 0), applied if check function fails
  * min score for this requirement to be applied (ex. "if kitsune score >= 5, give +1 for plain skin")
* **RacialTier**'s. Tier is a milestone on the racial score scale with its own name, bonuses, and requirements. They have:
  * name function (ex. "nine tailed kitsune/kitsune-taur") that generates a displayed racial name for particular body.
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

### Adding new slots

TODO @aimozg write me

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

## New race file template

```as
package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class ZzzRace extends Race {

    public function ZzzRace(id:int) {
        super("Zzz", id);
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

## Score calculation

Racial scores are made with `RaceScoreBuilder` class. Start with one of `addScores()` functions in the Race constructor, and write a method chain.

Most builder methods have a signature `bodyPart(value, passScore, failScore=0, customName="")`. `customName` can be used to replace auto-generated requirement name.

Examples:
* `.eyeType(Eyes.FOX, +1)` -> "fox eyes (+1)"
* `.earType(Ears.FOX, +1, -1)` -> "fox ears (+1) (-1 penalty)"

The `value` argument can take special "operator" constructs created with `NOT`,`ANY`,`NONE`,`LESS_THAN`,`GREATER_THAN`,`AT_LEAST`,`AT_MOST`.

Examples:
* `.legType(NOT(LowerBody.FROSTWYRM), 0, -1000)` -> "not frost wyrm legs (-1000 penalty)"
* `.armType(ANY(Arms.HUMAN, Arms.KITSUNE, Arms.FOX), +1)` -> "human, kitsune or fox arms (+1)"
* `.faceType(NONE(Face.CHESHIRE,Face.CHESHIRE_SMILE), 0, -7)` -> "neither cheshire nor cheshire smile face (-7 penalty)"
* `.height(LESS_THAN(48), +2)` -> "height less than 4 feet"

### Custom requirements

TODO @aimozg

### Group wrappers

To gate a requirement(s) behind minimum score from previous requirements, use `addScoresAfter()`:

```as
addScoresAfter(4)
  .faceType(Face.FOX, +1);

=> +1 score for fox face, but only if already has score 4 
```

TODO @aimozg addConditionedScores

### Mutations and bloodline bonuses

Mutation and bloodline bonuses are configured with a special `addMutation` and `addBloodline` methods outside `addScores()` chain. The default mutation bonus is +1 per stage could be overriden.

```as
addBloodline(PerkLib.KitsunesDescendant, PerkLib.BloodlineKitsune);
addMutation(IMutationsLib.KitsuneThyroidGlandIM);
addMutation(IMutationsLib.TwinHeartIM, +2);
```

## Tiers

TODO @aimozg write me

### Extra requirements

TODO 

### Naming function

TODO

### Buffs

TODO

#### Extra bonuses

TODO

#### Dynamic buffs

TODO

### Racial forms

For racial forms that don't have clear tier order (for example, Gargoyle materials), there are two ways of implementing them.

1. Different tiers.
Pros: Integrates well into existing scheme. Better auto-generated description.
Cons: This might mess the concept of "tier number" for that race.

2. Single tier with dynamic buffs & naming.
Pros: Preserves tier numbering. Most flexible way.
Cons: Requires more complex code. Buffs and requirements won't properly show in race DB menu.

There is no "best way" to do it; currently such races - Gargoyle, Alicorn, Elemental - use (2).

## Recommendations

Fail score of -1000 means that this is an absolute requirement. They are displayed is a special way in racial menu.

Racial requirements are printed and applied in the order of their declaration.

To penalize race for having certain part, it is better to add `NOT`-requirement with `0` score and negative `failScore`.

Color lists that can be shared between race check and mutation should be stored in race subclass as public static members (see for example `KitsuneRace.BasicKitsuneHairColors`).

Checking other racial score should be avoided. If race AAA should check for being partially a race BBB and penalize for it, add a `BBB.isBbbLike(body:BodyData):Boolean` function and use it in AAA. See for example Gorgon and other snake-like races.  
