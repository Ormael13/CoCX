# TODO @aimozg
* README!
* Validate operator objects
* Check generated names
* Hidden/Disabled races
* Check scores checking non-tiers
* Inline `xxxxScore` functions
* `allRacialScores`/`allRacialTiers` functions
* fangs in `-morph/boy/girl`
* iterate in chimeras
* kill array of objects in `race()`
* alicorn tiers
* solve unicornkin/alicornkin races
* Future:
  * racial score caching
  * Race.`onTierUp`/`onTierDown`

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

Notes:
* If player qualifies for a higher tier, they don't get lower tier bonuses.
* By default, lower tier custom requirements are not copied to higher tier. Use `.requirePreviousTier()` if needed.

## New & Replaced functions

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

`player.racialTierNumber(Races.DRAGON)` returns 0 for score 0..15, 1 for 16..23, 2 for 24..31, 3 for 32+.

## New race file template

```as
package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;

public class ZzzRace extends Race {

    public function ZzzRace(id:int) {
        super("Zzz", id);
        
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
