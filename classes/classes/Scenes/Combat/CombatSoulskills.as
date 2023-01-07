/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapons.Tidarion;
import classes.Monster;
import classes.PerkLib;
import classes.Races;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Jojo;
import classes.Scenes.NPCs.JojoScene;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class CombatSoulskills extends BaseCombatContent {
	private var multiTrustDNLag:Number = 0;
	public function CombatSoulskills() {
	}
	//------------
	// S. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bloodForBloodGod:Number = (player.HP - player.minHP());
		var bd:ButtonData;
		var isEnemyInvisible:Boolean = combat.isEnemyInvisible;
		if (player.hasPerk(PerkLib.CleansingPalm)) {
			bd = buttons.add("C.Palm", CleansingPalm).hint("Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if (player.cor >= (10 + player.corruptionTolerance)) {
				bd.disable("You are too corrupt to use this ability!");
			} else if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("<b>Your current soulforce is too low.</b>");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIceFist)) {
			bd = buttons.add("Ice Fist", IceFist).hint("A chilling strike that can freeze an opponent solid, leaving it vulnerable to shattering soul art and hindering its movement.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) {
				bd.disable("When you try to use this technique, you shudder in revulsion. Ice, that close to your body? You're a creature of fire!");
			} else if (!player.isFistOrFistWeapon()) {
				bd.disable("<b>Your [weapon] can't be used with this soulskill.</b>");
			} else if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("<b>Your current soulforce is too low.</b>");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsFirePunch)) {
			bd = buttons.add("Fire Punch", FirePunch).hint("Ignite your opponents dealing fire damage and setting them ablaze.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if (player.hasPerk(PerkLib.ColdAffinity)) {
				bd.disable("You call upon the power of flame...and you begin to sweat. You aren't built for the heat, and your body knows it. ");
			} else if (!player.isFistOrFistWeapon()) {
				bd.disable("<b>Your [weapon] can't be used with this soulskill.</b>");
			} else if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHurricaneDance)) {
			bd = buttons.add("Hurricane Dance", HurricaneDance).hint("Take on the aspect of the wind, dodging attacks like a leaf in the wind.  \n\nWould go into cooldown after use for: 10 rounds  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownHurricaneDance)) {
				bd.disable("You need more time before you can use Hurricane Dance again.");
			} else if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsEarthStance)) {
			bd = buttons.add("Earth Stance", EarthStance).hint("Take on the stability and strength of the earth, gaining 30% damage reduction for the next 3 rounds.  \n\nWould go into cooldown after use for: 10 rounds  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownEarthStance)) {
				bd.disable("You need more time before you can use Earth Stance again.");
			} else if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsPunishingKick)) {
			bd = buttons.add("Punishing Kick", PunishingKick).hint("A vicious kick that can daze an opponent, reducing its damage for a while.  \n\nWould go into cooldown after use for: 10 rounds  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownPunishingKick)) {
				bd.disable("You need more time before you can use Punishing Kick again.");
			} else if (player.isDrider() || player.isGoo() || player.isNaga() || player.isScylla() || player.isAlraune()) {
				bd.disable("<b>Your legs not allow to use this technique.</b>");
			} else if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsSoulBlast)) {
			bd = buttons.add("Soul Blast", SoulBlast).hint("Focus your reserves of soul force to unleash a torrent of devastating energy and obliterate your opponent.  \n\nWould go into cooldown after use for: 15 rounds  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(100 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownSoulBlast)) {
				bd.disable("You need more time before you can use Soul Blast again.");
			} else if ((player.soulforce < 100 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (100 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsOverlimit)) {
			if (player.hasStatusEffect(StatusEffects.Overlimit)) {
				bd = buttons.add("Overlimit(Off)", deactivaterOverlimit).hint("Deactivate Overlimit.");
			} else {
				bd = buttons.add("Overlimit(On)", activaterOverlimit).hint("Double your melee damage for a time, by ignoring your body's limits, pushing past them. This technique inflicts damage to you, but also increases lust resistance.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsTripleThrust)) {
			bd = buttons.add("Triple Thrust", TripleThrust).hint("Use a little bit of soulforce to infuse your weapon with power, striking your foe three times.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(30 * soulskillCost() * soulskillcostmulti()));
			if ((player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (30 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsSextupleThrust)) {
			bd = buttons.add("Sextuple Thrust", SextupleThrust).hint("Use a little bit of soulforce to infuse your weapon with power, thrusting six times into your foe.  \n\nWould go into cooldown after use for: 1 round  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(70 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownSextupleThrust)) {
				bd.disable("You need more time before you can use Sextuple Thrust again.");
			} else if ((player.soulforce < 70 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (70 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsNonupleThrust)) {
			bd = buttons.add("Nonuple Thrust", NonupleThrust).hint("Use a little bit of soulforce to infuse your weapon with power and thrust nine times toward your enemy.  \n\nWould go into cooldown after use for: 2 rounds  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(150 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownNonupleThrust)) {
				bd.disable("You need more time before you can use Nonuple Thrust again.");
			} else if ((player.soulforce < 150 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (150 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDracoSweep)) {
			bd = buttons.add("Draco Sweep", DracoSweep).hint("Use a little bit of soulforce to empower your weapon, then sweep ahead hitting as many enemies as possible.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(50 * soulskillCost() * soulskillcostmulti()));
			if ((player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (50 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsFlamesOfLove)) {
			bd = buttons.add("Flames of Love", combat.flamesOfLove).hint("Enfuse your magic with your burning lust, transfering it to your enemy as a barrage of flames.  \n\nWould go into cooldown after use for: 1 round  \n\nLust cost: 30% of current lust");
			if (player.hasStatusEffect(StatusEffects.CooldownFlamesOfLove)) {
				bd.disable("You need more time before you can use Flames of Love again.");
			} else if (player.lust < 50) {
				bd.disable("Your current lust is too low.");
			}
		}/*
		if (player.hasStatusEffect(StatusEffects.KnowsFlamesOfLove)) {
			bd = buttons.add("Flames of Love", combat.flamesOfLove).hint("Enfuse your magic with your burning lust, transfering it to your enemy as a barrage of flames.  \n\nWould go into cooldown after use for: 3 rounds  \n\nLust cost: 90% of current lust");
			if (player.hasStatusEffect(StatusEffects.CooldownFlamesOfLove)) {
				bd.disable("You need more time before you can use Flames of Love again.");
			} else if (player.lust < 50) {
				bd.disable("Your current lust is too low.");
			}
		}*/
		if (player.hasStatusEffect(StatusEffects.KnowsIciclesOfLove)) {
			bd = buttons.add("Icicles of Love", combat.iciclesOfLove).hint("Weaponize your lust, crystalizing it into cold, sharp icicles.  \n\nWould go into cooldown after use for: 1 round  \n\nLust cost: 30% of current lust");
			if (player.hasStatusEffect(StatusEffects.CooldownIciclesOfLove)) {
				bd.disable("You need more time before you can use Icicles of Love again.");
			} else if (player.lust < 50) {
				bd.disable("Your current lust is too low.");
			}
		}/*
		if (player.hasStatusEffect(StatusEffects.KnowsIciclesOfLove)) {
			bd = buttons.add("Icicles of Love", combat.iciclesOfLove).hint("Weaponize your lust, crystalizing it into cold, sharp icicles.  \n\nWould go into cooldown after use for: 3 rounds  \n\nLust cost: 90% of current lust");
			if (player.hasStatusEffect(StatusEffects.CooldownIciclesOfLove)) {
				bd.disable("You need more time before you can use Icicles of Love again.");
			} else if (player.lust < 50) {
				bd.disable("Your current lust is too low.");
			}
		}*/
		if (player.hasStatusEffect(StatusEffects.KnowsStormOfSisterhood)) {
			bd = buttons.add("Storm of Sisterhood", combat.stormOfSisterhood).hint("Transform your wrath into an electric storm, empowered by sisterhood.  \n\nWould go into cooldown after use for: 1 round  \n\nWrath cost: 30% of current wrath");
			if (player.hasStatusEffect(StatusEffects.CooldownStormOfSisterhood)) {
				bd.disable("You need more time before you can use Storm of Sisterhood again.");
			} else if (player.wrath < 50) {
				bd.disable("Your current wrath is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsNightOfBrotherhood)) {
			bd = buttons.add("Night of Brotherhood", combat.nightOfBrotherhood).hint("Let your wrath darken into a burst of darkness, fuelled by your brotherhood.  \n\nWould go into cooldown after use for: 1 round  \n\nWrath cost: 30% of current wrath");
			if (player.hasStatusEffect(StatusEffects.CooldownNightOfBrotherhood)) {
				bd.disable("You need more time before you can use Night of Brotherhood again.");
			} else if (player.wrath < 50) {
				bd.disable("Your current wrath is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeavensDevourer)) {
			bd = buttons.add("Devourer", combat.heavensDevourer).hint("Form a small sphere inscribed by symbols to drain from enemy a bit of lust and/or wrath.  \n\nWould go into cooldown after use for: 3 rounds");
			if (player.hasStatusEffect(StatusEffects.CooldownHeavensDevourer)) {
				bd.disable("You need more time before you can use Devourer again.");
			}
		}
		if (player.weapon == weapons.WGSWORD) {
			bd = buttons.add("Beat of War", BeatOfWar).hint("Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(50 * soulskillCost() * soulskillcostmulti()));
			if ((player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (50 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.weapon == weapons.WDBLADE) {
			bd = buttons.add("Blade Dance", BladeDance).hint("Attack twice (four times if double attack is active, six times if triple attack is active and etc.). \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(50 * soulskillCost() * (1 + flags[kFLAGS.MULTIATTACK_STYLE])));
			if ((player.soulforce < 50 * soulskillCost() * (1 + flags[kFLAGS.MULTIATTACK_STYLE])) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (50 * soulskillCost() * (1 + flags[kFLAGS.MULTIATTACK_STYLE]))) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.weapon == weapons.WDSTAFF) {
			bd = buttons.add("AvatarOfTheSong", AvatarOfTheSong).hint("Doublecast Charged Weapon and Might. Casts blind if charged weapon is already active. Casts Heal if Might is already active.  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: 200");
			if (player.soulforce < 200) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
		}
		if (player.weaponRangeName == "Warden’s bow") {
			bd = buttons.add("ResonanceVolley", ResonanceVolley).hint("Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.  \n\n(PHYSICAL SOULSKILL)  \n\nSoulforce cost: 150");
			if (player.soulforce < 150) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManyBirds)) {
			bd = buttons.add("Many Birds", ManyBirds).hint("Project a figment of your soulforce as a crystal traveling at extreme speeds.  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(10 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			} else if ((player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (10 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsComet)) {
			bd = buttons.add("Comet", Comet).hint("Project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(60 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			} else if ((player.soulforce < 60 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (60 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHailOfBlades)) {
			bd = buttons.add("Hail of Blades", HailOfBlades1).hint("Form six weapons from your soulforce traveling at extreme speeds.  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(50 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			} else if ((player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (50 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsGrandioseHailOfBlades)) {
			bd = buttons.add("G.Hail of Blades", HailOfBlades2).hint("Form eighteen weapons from your soulforce traveling at extreme speeds.  \n\nWould go into cooldown after use for: 3 rounds  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(200 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownGrandioseHailOfBlades)) {
				bd.disable("You need more time before you can use Grandiose Hail of Blades again.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			} else if ((player.soulforce < 200 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (200 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsGrandioseHailOfMoonBlades)) {
			bd = buttons.add("G.Hail of M.Blades", HailOfBlades3).hint("Form fifty six weapons from your soulforce traveling at extreme speeds.  \n\nWould go into cooldown after use for: 9 rounds  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: " + Math.round(800 * soulskillCost() * soulskillcostmulti()));
			if (player.hasStatusEffect(StatusEffects.CooldownGrandioseHailOfMoonBlades)) {
				bd.disable("You need more time before you can use Grandiose Hail of Moon Blades again.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			} else if ((player.soulforce < 800 * soulskillCost() * soulskillcostmulti()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.BloodCultivator) && (bloodForBloodGod - 1) < (800 * soulskillCost() * soulskillcostmulti())) {
				bd.disable("Your hp is too low to use this soulskill.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
			if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
				bd = buttons.add("Deactiv VPT", DeactivateVioletPupilTransformation)
					   .hint("Deactivate Violet Pupil Transformation.");
			} else {
				bd = buttons.add("V P Trans", VioletPupilTransformation).hint("Violet Pupil Transformation is a regenerating oriented soul art. While it drains your SoulForce constantly, it allows one to rapidly heal their injuries.  \n\n(MAGICAL SOULSKILL)  \n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>200 HP</b> per turn. (with some perks or races it could be more than 200)");
				if (player.soulforce < 100) {
					bd.disable("<b>Your current soulforce is too low.</b>");
				}
			}
		}
		if (player.hasPerk(PerkLib.Trance)) {
			if (!player.statStore.hasBuff("TranceTransformation")) {
				bd = buttons.add("Trance", TranceTransformation).hint("Activate Trance state, which enhances your physical and mental abilities.  \n\n(MAGICAL SOULSKILL)  \n\nCost: 100 soulforce on activation and 50 soulforce per turn)");
				if (player.soulforce < 100) {
					bd.disable("Your current soulforce is too low.");
				} else if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
					bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
				}
			} else {
				bd = buttons.add("DeActTrance", DeactivateTranceTransformation).hint("Deactivate Trance.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodSwipe)) {
			bd = buttons.add("Blood Swipe", bloodSwipe)
					.hint("Blood Swipe will fire three red lines of blood energy from your hand.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(60) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(60)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodSwipe)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodSwipeSF)) {
			bd = buttons.add("Blood Swipe (SF)", bloodSwipeSF)
					.hint("(Soulforce infused) Blood Swipe, infused by a small amount of soulforce. This skill will fire three red lines of blood energy from your hand.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(60) + "\n\nSoulforce cost: " + Math.round(60 * soulskillCost() * soulskillcostmulti()));
			if ((bloodForBloodGod - 1) < spellCostBlood(60)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.soulforce < 60 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodSwipeSF)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeartSeeker)) {
			bd = buttons.add("Heart Seeker", heartSeeker)
					.hint("Heart Seeker will strike the vital points of your enemy, dealing true damage.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(120) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(120)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellHeartSeeker)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeartSeekerSF)) {
			bd = buttons.add("Heart Seeker (SF)", heartSeekerSF)
					.hint("(Soulforce infused) Heart Seeker, infused by a small amount of soulforce. This skill will hit the vital points of your foe.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(120) + "\n\nSoulforce cost: " + Math.round(120 * soulskillCost() * soulskillcostmulti()));
			if ((bloodForBloodGod - 1) < spellCostBlood(120)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.soulforce < 120 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellHeartSeekerSF)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodDewdrops)) {
			bd = buttons.add("Blood Dewdrops", bloodDewdrops)
					.hint("Blood Dewdrops will fire many bloody droplets from your hand.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(240) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(240)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodDewdrops)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodDewdropsSF)) {
			bd = buttons.add("Blood Dewdrops (SF)", bloodDewdropsSF)
					.hint("(Soulforce infused) Blood Dewdrops, infused by a small amount of soulforce. Blood Dewdrops will fire many blood droplets from your hand.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(240) + "\n\nSoulforce cost: " + Math.round(240 * soulskillCost() * soulskillcostmulti()));
			if ((bloodForBloodGod - 1) < spellCostBlood(240)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.soulforce < 240 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodDewdropsSF)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodRequiem)) {
			bd = buttons.add("Blood Requiem", bloodRequiem)
					.hint("Blood Requiem will create pillars of blood, dealing damage and reducing the recovery rate of enemies for a short time.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(150) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(150)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodRequiem)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodRequiemSF)) {
			bd = buttons.add("Blood Requiem (SF)", bloodRequiemSF)
					.hint("(Soulforce infused) Blood Requiem, infused by a small amount of soulforce to enhance its power, will create pillars of blood that would deal damage and reduce the recovery rate of enemies for a short time.  " +
							"\n\n(PHYSICAL/MAGICAL SOULSKILL)  \n\nBlood Cost: " + spellCostBlood(150) + "\n\nSoulforce cost: " + Math.round(150 * soulskillCost() * soulskillcostmulti()));
			if ((bloodForBloodGod - 1) < spellCostBlood(150)) {
				bd.disable("Your hp is too low to cast this soulskill.");
			} else if (player.soulforce < 150 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodRequiemSF)) {
				bd.disable("You need more time before you can cast this soulskill again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff soulskills while underground.");
			} else if (isEnemyInvisible) {
				bd.disable("You cannot use offensive soulskills against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood soulskills if you don't have blood at all.");
			}
		}
	}
	private function monsterDodgeSkill(skillName:String):Boolean {
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe))) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids your " + skillName + "!");
			else if (monster.spe-player.spe < 20) outputText("[Themonster] dodges your " + skillName + " with superior quickness!");
			else outputText("[Themonster] deftly avoids your slow " + skillName + ".");
			enemyAI();
			return true;
		}
		return false;
	}

	public function TripleThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to thrust it towards [themonster].  ");
		if (monsterDodgeSkill("attack")) return;
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		multiTrustDNLag = 0;
		var triTru:Number = 3;
		if (player.hasPerk(PerkLib.FlurryOfBlows) && player.isFistOrFistWeapon()) triTru += 6;
		if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) {
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			while (triTru-->0) MultiThrustD();
			monster.statStore.removeBuffs("FrozenSolid");
			monster.removeStatusEffect(StatusEffects.FrozenSolid);
			outputText(" damage!");
		}
		else {
			outputText("Your [weapon] hits thrice against [themonster],");
			while (triTru-->0) MultiThrustD();
			outputText(" damage!");
		}
		outputText("\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		enemyAI();
	}
	public function SextupleThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to thrust it towards [themonster].  ");
		if (monsterDodgeSkill("attack")) return;
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		multiTrustDNLag = 0;
		var sexTru:Number = 6;
		if (player.hasPerk(PerkLib.FlurryOfBlows) && player.isFistOrFistWeapon()) sexTru += 12;
		player.createStatusEffect(StatusEffects.CooldownSextupleThrust, 1, 0, 0, 0);
		if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) {
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			while (sexTru-->0) MultiThrustD();
			monster.statStore.removeBuffs("FrozenSolid");
			monster.removeStatusEffect(StatusEffects.FrozenSolid);
			outputText(" damage!");
		}
		else {
			outputText("Your [weapon] hits sixfold against [themonster],");
			while (sexTru-->0) MultiThrustD();
			outputText(" damage!");
		}
		outputText("\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		enemyAI();
	}
	public function NonupleThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to thrust it towards [themonster].  ");
		if (monsterDodgeSkill("attack")) return;
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		multiTrustDNLag = 0;
		var nonTru:Number = 9;
		if (player.hasPerk(PerkLib.FlurryOfBlows) && player.isFistOrFistWeapon()) nonTru += 18;
		player.createStatusEffect(StatusEffects.CooldownNonupleThrust, 2, 0, 0, 0);
		if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) {
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			while (nonTru-->0) MultiThrustD();
			monster.statStore.removeBuffs("FrozenSolid");
			monster.removeStatusEffect(StatusEffects.FrozenSolid);
			outputText(" damage!");
		}
		else {
			outputText("Your [weapon] hits ninefold against [themonster],");
			while (nonTru-->0) MultiThrustD();
			outputText(" damage!");
		}
		outputText("\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	private function MultiThrustDSingle():Number {
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		damage = combat.weaponAttackModifierSpecial(damage);
		//All special weapon effects like...fire/ice
		if (player.weapon == weapons.L_WHIP || player.weapon == weapons.TIDAR) {
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (player.weapon == weapons.TIDAR) (player.weapon as Tidarion).afterStrike();
		if (combat.isPureWeapon()) {
			damage = combat.monsterPureDamageBonus(damage);
		}
		if (combat.isCorruptWeapon()) {
			damage = combat.monsterCorruptDamageBonus(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			damage = combat.FireTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			var damage1:Number = damage;
			damage = combat.FireTypeDamageBonus(damage);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
			damage += damage1;
			damage *= 1.1;
		}
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.weapon.isNothing && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
		damage = combat.itemsBonusDamageDamage(damage);
		damage = combat.statusEffectBonusDamage(damage);
		if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) damage *= 2;
		return damage;
	}
	private function MultiThrustD():void {
		var damage:Number = 0;
		if (multiTrustDNLag != 0) damage += multiTrustDNLag;
		else {
			multiTrustDNLag += MultiThrustDSingle();
			damage += MultiThrustDSingle();
		}
		var d2:Number = 0.9;
		d2 += (rand(21) * 0.01);
		damage *= d2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.isSwordTypeWeapon()) critChance += 10;
		if (player.isDuelingTypeWeapon()) critChance += 20;
		critChance += combat.combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			damage *= (1.75 + buffMultiplier);
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText(" ");
		if (combat.isFireTypeWeapon()) {
			if (player.flameBladeActive()) damage += scalingBonusLibido() * 0.20;
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		else if (combat.isIceTypeWeapon()) {
			damage = Math.round(damage * combat.iceDamageBoostedByDao());
			doIceDamage(damage, true, true);
		}
		else if (combat.isLightningTypeWeapon()) {
			damage = Math.round(damage * combat.lightningDamageBoostedByDao());
			doLightingDamage(damage, true, true);
		}
		else if (combat.isDarknessTypeWeapon()) {
			damage = Math.round(damage * combat.darknessDamageBoostedByDao());
			doDarknessDamage(damage, true, true);
		}
		else if (player.weapon == weapons.MGSWORD) doMagicDamage(damage, true, true);
		else if (player.weapon == weapons.MCLAWS) doMagicDamage(damage, true, true);
		else {
			doDamage(damage, true, true);
			if (player.weapon == weapons.DAISHO) doDamage(Math.round(damage * 0.5), true, true);
		}
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
		if (player.hasStatusEffect(StatusEffects.EruptingRiposte)) flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] += monster.tou + monster.inte + monster.wis;
	}

	public function DracoSweep():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to sweep it towards [themonster].  ");
		if (monsterDodgeSkill("attack")) return;
		var soulforcecost:Number = 50 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		damage = combat.weaponAttackModifierSpecial(damage);
		//All special weapon effects like...fire/ice
		if (player.haveWeaponForJouster()) {
			if (player.isMeetingNaturalJousterReq()) damage *= 3;
			if (player.isMeetingNaturalJousterMasterGradeReq()) damage *= 5;
		}
		if (combat.isPureWeapon()) {
			damage = combat.monsterPureDamageBonus(damage);
		}
		if (combat.isCorruptWeapon()) {
			damage = combat.monsterCorruptDamageBonus(damage);
		}
		if (player.weapon == weapons.L_WHIP || player.weapon == weapons.TIDAR) {
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (player.weapon == weapons.TIDAR) (player.weapon as Tidarion).afterStrike();
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			damage = combat.FireTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = combat.FireTypeDamageBonus(damage);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
			damage *= 1.1;
		}
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//group enemies bonus
		if (monster.plural) damage *= 5;
		//other bonuses
		if (player.hasPerk(PerkLib.HoldWithBothHands) && !player.weapon.isNothing && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
		if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
		damage = combat.itemsBonusDamageDamage(damage);
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.isSwordTypeWeapon()) critChance += 10;
		if (player.isDuelingTypeWeapon()) critChance += 20;
		critChance += combat.combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			damage *= (1.75 + buffMultiplier);
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText("Your [weapon] sweeps against [themonster], dealing ");
		if (((player.weapon == weapons.RCLAYMO || player.weapon == weapons.RDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) || (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) || (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) || player.flameBladeActive()) {
			if (player.flameBladeActive()) damage += scalingBonusLibido() * 0.20;
			damage = Math.round(damage * combat.fireDamageBoostedByDao());
			doFireDamage(damage, true, true);
		}
		else if (combat.isIceTypeWeapon()) {
			damage = Math.round(damage * combat.iceDamageBoostedByDao());
			doIceDamage(damage, true, true);
		}
		else if (combat.isLightningTypeWeapon()) {
			damage = Math.round(damage * combat.lightningDamageBoostedByDao());
			doLightingDamage(damage, true, true);
		}
		else if (combat.isDarknessTypeWeapon()) {
			damage = Math.round(damage * combat.darknessDamageBoostedByDao());
			doDarknessDamage(damage, true, true);
		}
		else if (player.weapon == weapons.MGSWORD) doMagicDamage(damage, true, true);
		else if (player.weapon == weapons.MCLAWS) doMagicDamage(damage, true, true);
		else {
			doDamage(damage, true, true);
			if (player.weapon == weapons.DAISHO) doDamage(Math.round(damage * 0.5), true, true);
			if (player.hasPerk(PerkLib.FlurryOfBlows) && player.isFistOrFistWeapon()) {
				doDamage(damage, true, true);
				doDamage(damage, true, true);
				damage *= 3;
			}
		}
		outputText(" damage! ");
		if (crit) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		endTurnBySpecialHit(damage);
	}

	public function ManyBirds():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (silly ()) outputText("You focus your soulforce, projecting it as an aura around you.  As you concentrate, dozens, hundreds, thousands of tiny, ethereal birds shimmer into existence.  As you raise your hand up, more and more appear, until the area around you and [themonster]  is drowned in spectral flappy shapes.  ");
		else {
			outputText("You thrust your hand outwards with deadly intent, and in the blink of an eye a crystal shoots towards [themonster].  ");
			if (monsterDodgeSkill("crystal")) return;
		}
		var soulforcecost:Number = 10 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = scalingBonusWisdom();
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		if (silly ()) {
			outputText("You snap your fingers, and at once every bird lends their high pitched voice to a unified, glass shattering cry:");
			outputText("\n\n\"<i>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</i>\" ([themonster] takes ");
			doMagicDamage(damage, true, true);
			outputText(" damage) ");
		}
		else {
			outputText("Crystal hits [themonster], dealing ");
			doMagicDamage(damage, true, true);
			outputText(" damage! ");
		}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function Comet():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You focus for a moment, projecting a fragment of your soulforce above you.  A moment later, a prismatic comet crashes down on your opponents [themonster].  ");
		if (monster.plural) outputText("Shattering into thousands of fragments that shower anything and everything around you.  ");
		if (monsterDodgeSkill("comet fragments")) return;
		var soulforcecost:Number = 60 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = scalingBonusWisdom();
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//group enemies bonus
		if (monster.plural) damage *= 5;
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText("Comet fragments hits [themonster], dealing ");
		doMagicDamage(damage, true, true);
		outputText(" damage! ");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function HailOfBlades1():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("Letting soulforce leak out around you, you form six ethereal weapons, each measuring two meters long. You thrust your hand outwards, and in the blink of an eye, the weapons shoot towards [themonster].  ");
		if (monsterDodgeSkill("weapons")) return;
		var soulforcecost:Number = 50 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		outputText("Weapons hits [themonster], dealing ");
		var hob1:Number = 6;
		while (hob1-->0) BladesD();
		outputText(" damage!\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function HailOfBlades2():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("Letting soulforce leak out around you, you form eighteen ethereal two meter long weapons in two rows. You thrust your hand outwards and in the blink of an eye, weapons shoot forwards [themonster].  ");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 10 && int(Math.random() * (((monster.spe - player.spe) / 5) + 70)) > 80)) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids weapons!");
			else if (monster.spe-player.spe < 20) outputText("[Themonster] dodges weapons with superior quickness!");
			else outputText("[Themonster] deftly avoids weapons.");
			enemyAI();
			return;
		}
		var soulforcecost:Number = 200 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownGrandioseHailOfBlades, 3, 0, 0, 0);
		outputText("Weapons hits [themonster], dealing ");
		var hob2:Number = 9;
		while (hob2-->0) BladesD(2);
		outputText(" damage!\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function HailOfBlades3():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("Letting soulforce leak out around you, you form fifty-six ethereal two meter long weapons in four rows. You thrust your hand outwards and in the blink of an eye, weapons shoot forwards [themonster].  ");
		if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 20 && int(Math.random() * (((monster.spe - player.spe) / 6) + 60)) > 80)) {
			if (monster.spe - player.spe < 8) outputText("[Themonster] narrowly avoids weapons!");
			else if (monster.spe-player.spe < 20) outputText("[Themonster] dodges weapons with superior quickness!");
			else outputText("[Themonster] deftly avoids weapons.");
			enemyAI();
			return;
		}
		var soulforcecost:Number = 800 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownGrandioseHailOfMoonBlades, 9, 0, 0, 0);
		outputText("Weapons hits [themonster], dealing ");
		var hob3:Number = 19;
		while (hob3-->0) BladesD(4);
		outputText(" damage!\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	private function BladesD(hits:Number = 1):void {
		var damage:Number = player.wis * 0.5;
		damage += scalingBonusWisdom() * 0.5;
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		var d2:Number = 0.9;
		d2 += (rand(21) * 0.01);
		damage *= d2;
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText(" ");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		if (hits == 2) {
			outputText(" ");
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			damage *= 2;
		}
		if (hits == 4) {
			outputText(" ");
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
			doMagicDamage(damage, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			damage *= 4;
		}
		checkAchievementDamage(damage);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
		if (player.hasStatusEffect(StatusEffects.EruptingRiposte)) flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] += monster.tou + monster.inte + monster.wis;
	}

	public function CleansingPalm():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		if (monster is Jojo) {
			// Not a completely corrupted monkmouse
			if (JojoScene.monk < 2) {
				outputText("You thrust your palm forward, sending a blast of pure energy towards Jojo. At the last second he sends a blast of his own against yours canceling it out\n\n");
				enemyAI();
				return;
			}
		}
		if (monster is LivingStatue) {
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against the giant stone statue- to no effect!");
			enemyAI();
			return;
		}
		var corruptionMulti:Number = (monster.cor - 20) / 25;
		if (corruptionMulti > 1.5) {
			corruptionMulti = 1.5;
			corruptionMulti += ((monster.cor - 57.5) / 100); //The increase to multiplier is diminished.
		}
		var damage:Number = int(10 + (player.wis / 3 + rand(player.wis / 2)));
		damage += unarmedAttack();
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			damage = combat.FireTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = combat.FireTypeDamageBonus(damage);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
			damage *= 1.1;
		}
		damage *= soulskillMod();
		damage *= corruptionMulti;
		if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
		if (damage > 0) {
			outputText("You thrust your palm forward, creating a blast of pure energy that erupts from your palm, slamming into [themonster], tossing");
			if ((monster as Monster).plural) outputText(" them");
			else outputText((monster as Monster).mfn(" him", " her", " it"));
			outputText(" back a few feet.\n\n");
			if (silly() && corruptionMulti >= 1.75) outputText("It's super effective!  ");
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.combatPhysicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			outputText("[Themonster] takes ");
			doMagicDamage(damage, true, true);
			if (player.hasPerk(PerkLib.FlurryOfBlows)) {
				doMagicDamage(damage, true, true);
				doMagicDamage(damage, true, true);
				damage *= 3;
			}
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText("damage \n\n");
		}
		else outputText("You thrust your palm forward, causing a blast of pure energy to slam against [themonster], which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function IceFist():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += scalingBonusStrength();
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
			damage += player.str;
			damage += scalingBonusStrength();
		}
		damage += player.wis;
		damage += scalingBonusWisdom();
		//other bonuses
		if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (combat.wearingWinterScarf()) damage *= 1.2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		monster.buff("FrozenSolid").addStats({spe:-20}).withText("Frozen Solid").combatTemporary(1);
		outputText("The air around your fist seems to lose all heat as you dash at [themonster]. You place your palm on [monster him], [monster his] body suddenly is frozen solid, encased in a thick block of ice! ");
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		doIceDamage(damage, true, true);
		if (player.hasPerk(PerkLib.FlurryOfBlows)) {
			doIceDamage(damage, true, true);
			doIceDamage(damage, true, true);
			damage *= 3;
		}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		//stun
		if (monster.hasPerk(PerkLib.Resolute)) {
			outputText("  <b>[Themonster] ");
			if(!monster.plural) outputText("is ");
			else outputText("are ");
			outputText("too sturdy to be frozen by your attack.</b>");
		}
		else if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) monster.addStatusValue(StatusEffects.FrozenSolid, 1, 2);
		else monster.createStatusEffect(StatusEffects.FrozenSolid, 2, 0, 0, 0);
		//speed debuff
		if (monster.buff("FrozenSolid").isPresent()) monster.buff("FrozenSolid").addStats({spe: -20}).addDuration(2);
		else monster.buff("FrozenSolid").addStats({spe: -20}).withText("Frozen Solid").combatTemporary(2);
		checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		outputText("\n\n");
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function FirePunch():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += scalingBonusStrength();
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
			damage += player.str;
			damage += scalingBonusStrength();
		}
		damage += player.wis;
		damage += scalingBonusWisdom();
		if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
		}
		//other bonuses
		if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		monster.createStatusEffect(StatusEffects.FirePunchBurnDoT,16,0,0,0);
		outputText("Setting your fist ablaze, you rush at [themonster] and scorch [monster him] with your searing flames. ");
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage += Math.round(damage * 0.1);
			doFireDamage(damage, true, true);
			if (player.hasPerk(PerkLib.FlurryOfBlows)) {
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				damage *= 3;
			}
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
			damage = Math.round(damage * 1.1);
		}
		else {
			doFireDamage(damage, true, true);
			if (player.hasPerk(PerkLib.FlurryOfBlows)) {
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				damage *= 3;
			}
		}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		endTurnBySpecialHit(damage);
	}

	public function HurricaneDance():void {
		clearOutput();
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		outputText("Your movement becomes more fluid and precise, increasing your speed and evasion.\n\n");
		player.createStatusEffect(StatusEffects.HurricaneDance, 5, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownHurricaneDance, 10, 0, 0, 0);
		enemyAI();
	}

	public function EarthStance():void {
		clearOutput();
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		outputText("Your body suddenly hardens like rock. You will be way harder to damage for a while.\n\n");
		player.createStatusEffect(StatusEffects.EarthStance, 3, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownEarthStance, 10, 0, 0, 0);
		enemyAI();
	}

	public function PunishingKick():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		var soulforcecost:Number = 30 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = unarmedAttack();
		damage += player.str;
		damage += scalingBonusStrength();
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
			damage += player.str;
			damage += scalingBonusStrength();
		}
		damage += player.wis;
		damage += scalingBonusWisdom();
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			damage = combat.FireTypeDamageBonusLarge(damage);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = combat.FireTypeDamageBonus(damage);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
			damage *= 1.1;
		}
		//other bonuses
		if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = Math.round(damage);
		monster.createStatusEffect(StatusEffects.PunishingKick, 5, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownPunishingKick, 10, 0, 0, 0);
		outputText("You lash out with a devastating kick, knocking your opponent back and disorienting it. [Themonster] is knocked off balance by the ferocious blow! ");
		doDamage(damage, true, true);
		if (player.hasPerk(PerkLib.FlurryOfBlows)) {
			doDamage(damage, true, true);
			doDamage(damage, true, true);
			damage *= 3;
		}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		endTurnBySpecialHit(damage);
	}

	public function SoulBlast():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:Number = 100 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 1.8;
		damage += player.inte;
		damage += scalingBonusIntelligence() * 1.8;
		damage += player.wis;
		damage += scalingBonusWisdom() * 1.8;
		if (damage < 10) damage = 10;
		damage *= spellMod();
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		player.createStatusEffect(StatusEffects.CooldownSoulBlast, 15, 0, 0, 0);
		outputText("You wave the sign of the gate, tiger and serpent as you unlock all of your soulforce for an attack. [Themonster] can’t figure out what you are doing until a small sphere of energy explodes at the end of your fist in a massive beam of condensed soulforce. ");
		damage = Math.round(damage);
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		else {
			outputText("  <b>[Themonster] ");
			if(!monster.plural) outputText("is ");
			else outputText("are ");
			outputText("too resolute to be stunned by your attack.</b>");
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function activaterOverlimit():void {
		clearOutput();
		outputText("You let out a primal roar of pain and fury, as you push your body beyond its normal capacity, a blood red aura cloaking your form.\n\n");
		player.createStatusEffect(StatusEffects.Overlimit, 0, 0, 0, 0);
		enemyAI();
	}
	public function deactivaterOverlimit():void {
		clearOutput();
		outputText("You let your rage fade, your red aura and manic strength vanishing along with it. You wince, feeling the strain you put your body through. You \n\n");
		player.removeStatusEffect(StatusEffects.Overlimit);
		enemyAI();
	}

	public function VioletPupilTransformation():void {
		clearOutput();
		outputText("Deciding you need additional regeneration during current fight you spend moment to concentrate and activate Violet Pupil Transformation.  Your eyes starting to glow with a violet hua and you can feel refreshing feeling spreading all over your body.\n");
		player.createStatusEffect(StatusEffects.VioletPupilTransformation,0,0,0,0);
		enemyAI();
	}
	public function DeactivateVioletPupilTransformation():void {
		clearOutput();
		outputText("Deciding you not need for now to constantly using Violet Pupil Transformation you concentrate and deactivating it.");
		player.removeStatusEffect(StatusEffects.VioletPupilTransformation);
		enemyAI();
	}
	
	private static const TranceABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
	public function TranceTransformation():void {
		clearOutput();
		var doEffect:Function = function():* {
			var TranceBoost:Number = 10;
			if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) TranceBoost += 5;
			if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) TranceBoost += 5;
			if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) TranceBoost += 10;
			if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) TranceBoost += 10;
			if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) TranceBoost += 10;
			if (player.hasPerk(PerkLib.Archmage) && player.inte >= 75) TranceBoost += 15;
			if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 100) TranceBoost += 20;
			if (player.hasPerk(PerkLib.GreyMageApprentice) && player.inte >= 75) TranceBoost += 10;
			if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) TranceBoost += 15;
			if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 175) TranceBoost += 20;
			if (player.hasPerk(PerkLib.GrandGreyArchmage) && player.inte >= 225) TranceBoost += 25;
			if (player.hasPerk(PerkLib.GrandGreyArchmage2ndCircle) && player.inte >= 275) TranceBoost += 30;
			if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) TranceBoost += 5;
			if (player.hasPerk(PerkLib.Battleflash) && player.inte >= 50) TranceBoost += 15;
			if (player.hasPerk(PerkLib.JobSwordsman)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.JobBrawler)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.JobDervish)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.IronFistsI)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.JobMonk)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.Berzerker)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.Lustzerker)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponMastery)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponGrandMastery)) TranceBoost -= 25;
			if (player.hasPerk(PerkLib.HeavyArmorProficiency)) TranceBoost -= 15;
			if (player.hasPerk(PerkLib.AyoArmorProficiency)) TranceBoost -= 20;
			if (player.hasPerk(PerkLib.Agility)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.LightningStrikes)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.StarlightStrikes)) TranceBoost -= 10;
			if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) TranceBoost -= 5;
		//	TranceBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (TranceBoost < 10) TranceBoost = 10;
		//	if (player.hasPerk(PerkLib.JobEnchanter)) TranceBoost *= 1.2;
		//	TranceBoost *= spellModBlack();
			TranceBoost = FnHelpers.FN.logScale(TranceBoost,TranceABC,10);
			TranceBoost = Math.round(TranceBoost);
			tempStrTou = TranceBoost;
			mainView.statsView.showStatUp('str');
			// strUp.visible = true;
			// strDown.visible = false;
			mainView.statsView.showStatUp('tou');
			// touUp.visible = true;
			// touDown.visible = false;
			player.buff("TranceTransformation").addStats({str:TranceBoost,tou:TranceBoost}).withText("Trance Transformation").combatPermanent();
			statScreenRefresh();
		};
		var tempStrTou:Number = 0;
		outputText("You focus the power of your mind and soul, letting the mystic energy fill you. Your [skin] begins to crystalize as the power within you takes form. The power whirls within you like a hurricane, the force of it lifting you off your feet. This power...  You will use it to reach victory!\n");
		doEffect.call();
		enemyAI();
	}
	public function DeactivateTranceTransformation():void {
		clearOutput();
		outputText("You disrupt the flow of power within you, softly falling to the ground as the crystal sheathing your [skin] dissipates into nothingness.");
		player.statStore.removeBuffs("TranceTransformation");
		enemyAI();
	}

	public function BeatOfWar():void {
		clearOutput();
		var soulforcecost:Number = 50 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		if (!player.statStore.hasBuff("BeatOfWar"))
		mainView.statsView.showStatUp('str');
		player.buff("BeatOfWar").addStats({"str.mult":0.15}).withText("Beat of War").combatPermanent();
		statScreenRefresh();
		outputText("You momentarily attune yourself to the song of the mother tree, and prepare to add a note of your own to it’s rhythm. You feel the beat shift the song’s tempo slightly, taking a twist towards the ominous. This attunement augments your strength.\n\n");
		combat.basemeleeattacks();
	}
	public function BladeDance():void {
		clearOutput();
		var soulforcecost:Number = 50 * soulskillCost() * (1 + flags[kFLAGS.MULTIATTACK_STYLE]);
		soulforcecost = Math.round(soulforcecost);
		if (player.hasStatusEffect(StatusEffects.BloodCultivator)) player.takePhysDamage(soulforcecost);
		else player.soulforce -= soulforcecost;
		outputText("You momentarily attune yourself to the song of the mother tree, and dance forward, darting around your enemy, your blade slicing the air and foe alike.\n\n");
		player.createStatusEffect(StatusEffects.BladeDance,0,0,0,0);
		combat.basemeleeattacks();
	}
	public function ResonanceVolley():void {
		clearOutput();
		player.soulforce -= 150;
		outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
	}
	public function AvatarOfTheSong():void {
		clearOutput();
		player.soulforce -= 200;
		outputText("You feel the song of the mother tree all around you. Using your staff as a beacon, you unify it with the flow of magic through your body,");
		if (!player.statStore.hasBuff("Might")) {
			outputText("drawing strength from it");
			CombatAbilities.Might.backfireEnabled = false;
			CombatAbilities.Might.doEffect(false);
			CombatAbilities.Might.backfireEnabled = true;
		}
		else {
			outputText("feeling it mend your wounds");
			CombatAbilities.Heal.doEffect(false);
			spellPerkUnlock();
		}
		if (!monster.hasStatusEffect(StatusEffects.Blind)) {
			outputText(". The residual power ");
			if (!player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
				outputText("makes your staff glow with barely contained energy");
				CombatAbilities.ChargeWeapon.doEffect(false);
			}
			else {
				outputText("makes your staff flare up, as the energy escapes in a radiant flash");
				CombatAbilities.Blind.doEffect(false);
			}
		}
		outputText(".\n\n");
		enemyAI();
	}
	
	public function bloodSwipe():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(60), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodSwipe,2,0,0,0);
		outputText("You concentrate, focusing on the power of your blood. You swipe your hand across your chest. Three trails of blood pour from your fingertips, condensing into thin crimson blades. You point your clawlike blades at your foe, and they detach with a small crunch, flying toward [themonster].\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood();
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");

		endTurnByBloodSkillUse(damage);
	}
	public function bloodSwipeSF():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(60), false);
		var soulforcecost:Number = 60 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownSpellBloodSwipeSF,3,0,0,0);
		outputText("You concentrate, focusing on the power of your blood. You infuse a bit of soulforce into the blood, before swiping your hand across your chest. Three trails of blood pour from your fingertips, condensing into thin crimson blades. You point your clawlike blades at your foe, and they detach with a small crunch, flying toward [themonster].\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 3;
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		endTurnByBloodSkillUse(damage);
	}
	
	public function heartSeeker():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(120), false);
		player.createStatusEffect(StatusEffects.CooldownSpellHeartSeeker,3,0,0,0);
		outputText("You concentrate, focusing on the power of your blood. You infuse a bit of soulforce into the blood, spreading your fingers wide. Within an instant, a large blood dripping spear forms in your hand. You motion, sending the spear flying toward [themonster]'s vitals.\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 2;
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doTrueDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		endTurnByBloodSkillUse(damage);
	}
	public function heartSeekerSF():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(120), false);
		var soulforcecost:Number = 120 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownSpellHeartSeekerSF,4,0,0,0);
		outputText("You concentrate, focusing on the power of your blood. You infuse a bit of soulforce into the blood, spreading your fingers wide. Within an instant, a large blood dripping spear forms in your hand. You motion, sending the spear flying toward [themonster]'s vitals.\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6;
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doTrueDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		endTurnByBloodSkillUse(damage);
	}
	
	public function bloodDewdrops():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(240), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodDewdrops,2,0,0,0);
		outputText("You concentrate, focusing on the power of your blood before opening your hand and pointing it toward the enem"+(monster.plural?"ies":"y")+". Blood spurts from your fingertips, beads of crimson darkening as they harden. You flick your wrist, sending the blood pellets flying towards [themonster].\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 0.5;
		if (damage < 10) damage = 10;
		if (monster.plural) damage *= 5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		endTurnByBloodSkillUse(damage);
	}
	public function bloodDewdropsSF():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(240), false);
		var soulforcecost:Number = 240 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownSpellBloodDewdropsSF,3,0,0,0);
		outputText("You concentrate, focusing on the power of your blood before opening your hand and pointing it toward the enem"+(monster.plural?"ies":"y")+". Blood spurts from your fingertips, beads of crimson darkening as they harden. You close your eyes for a moment, sending soulforce into the pellets. You flick your wrist, sending the blood pellets flying towards [themonster].\n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 1.5;
		if (damage < 10) damage = 10;
		if (monster.plural) damage *= 5;
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		endTurnByBloodSkillUse(damage);
	}
	
	public function bloodRequiem():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(150), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodRequiem,4,0,0,0);
		outputText("You concentrate, focusing on the power of your blood before starting making gestures with your hands, precise movements sending power blazing through your body. Within an instant, large, blood dripping pillars form above [themonster]. The pillars begin to fall, and [themonster] looks up in shock, too late to dodge such a large projectile. \n\n");
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 2;
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		if (monster.hasStatusEffect(StatusEffects.BloodRequiem)) monster.addStatusValue(StatusEffects.BloodRequiem, 1, 2);
		else monster.createStatusEffect(StatusEffects.BloodRequiem,2,0,0,0);
		endTurnByBloodSkillUse(damage);
	}
	public function bloodRequiemSF():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(150), false);
		var soulforcecost:Number = 150 * soulskillCost() * soulskillcostmulti();
		soulforcecost = Math.round(soulforcecost);
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownSpellBloodRequiemSF,5,0,0,0);
		outputText("You concentrate, focusing on the power of your blood before starting making gestures with your hands, precise movements sending power blazing through your body. You pour Soulforce into your hands, and they glow blue with each gesture, power pulsing with your heartbeat. Within an instant, large, blood dripping pillars form above [themonster]. The pillars begin to fall, and [themonster] looks up in shock, too late to dodge such a large projectile. \n\n");
		
		var damage:Number = scalingBonusWisdom() * spellModBlood() * 6;
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText("[Themonster] takes ");
		doDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		if (monster.hasStatusEffect(StatusEffects.BloodRequiem)) monster.addStatusValue(StatusEffects.BloodRequiem, 1, 4);
		else monster.createStatusEffect(StatusEffects.BloodRequiem,4,0,0,0);
		endTurnByBloodSkillUse(damage);
	}


	private function endTurnBySpecialHit(damage:Number):void {
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	private function endTurnByBloodSkillUse(damage:Number):void {
		if (rand(20) < 4) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.removeStatusEffect(StatusEffects.Hemorrhage);
			monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
			outputText(" The attack leaves many bloody gashes.");
		}
		outputText("\n\n");
		checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(15);
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	/*
	public function spellMight(silent:Boolean = false):void {
		var doEffect:Function = function():* {
			var MightBoostCap:Number = 1.5;
			MightBoostCap *= player.intStat.core.max;
			MightBoostCap = Math.round(MightBoostCap);
			var MightBoost:Number = player.intStat.core.value;
			//MightBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus / warock / inny związany z spells
			if (MightBoost < 10) MightBoost = 10;
			if (player.hasPerk(PerkLib.JobEnchanter)) MightBoost *= 1.2;
			MightBoost *= spellModBlack();
			//MightBoost = FnHelpers.FN.logScale(MightBoost,MightABC,10);
			MightBoost = Math.round(MightBoost);
			if (MightBoost > MightBoostCap) MightBoost = MightBoostCap;
			var MightDuration:Number = 5;
			if (player.hasPerk(PerkLib.LongerLastingBuffsI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.EverLastingBuffs)) MightDuration += 5;
			if (player.hasPerk(PerkLib.EternalyLastingBuffs)) MightDuration += 5;
			tempTou = MightBoost;
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) tempInt = Math.round(MightBoost * 1.25);
			else tempStr = MightBoost;
			var oldHPratio:Number = player.hp100/100;
			var buffValues:Object = {"tou.mult":tempTou/100};

			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				buffValues["int.mult"] = Math.min( tempInt/100, player.intStat.mult.value/2);
			} else {
				buffValues["str.mult"] = Math.min( tempStr/100, player.strStat.mult.value/2);
			}
			player.buff("Might").setStats(buffValues).combatTemporary(MightDuration);
			player.HP = oldHPratio*player.maxHP();
			statScreenRefresh();
		};

		if (silent)	{ // for Battlemage
			doEffect.call();
			return;
		}

		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (50 * spellMightCostMultiplier())) player.HP -= (50 * spellMightCostMultiplier());
		else useMana((50 * spellMightCostMultiplier()),6);
		var tempStr:Number = 0;
		var tempTou:Number = 0;
		var tempInt:Number = 0;
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		if(rand(100) < backfire) {
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxOverLust()) doNext(endLustLoss);
		else enemyAI();
	}*/
	/*
	 //Mantis Omni Slash (AoE attack) - przerobić to na soulskilla zużywającego jak inne soulforce z rosnącym kosztem im wyższy lvl postaci ^^ owinno wciąż jakoś być powiązane z posiadaniem mantis arms czy też ulepszonych mantis arms (czyt. versji 2.0 tych ramion z TF bdącego soul evolution of Mantis) ^^
	 public function mantisOmniSlash():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
	 clearOutput();
	 if (monster.plural) {
	 if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " [monster name].");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 else {
	 if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " [monster name].");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 if (monster.plural) {
	 fatigue(60, USEFATG_PHYSICAL);
	 }
	 else fatigue(24, USEFATG_PHYSICAL);
	if (combat.checkConcentration()) return; //Amily concentration
	 outputText("You ready your wrist-mounted scythes and prepare to sweep them towards [themonster].\n\n");
	 if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attacks!\n\n");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attacks with superior quickness!\n\n");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attacks.\n\n");
	 enemyAI();
	 return;
	 if (monster.plural) {
	 if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) {
	 if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2 && player.hasPerk(PerkLib.TrachealSystemEvolved)) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 6;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 3;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
	 mantisMultipleAttacks();
	 }
	 public function mantisMultipleAttacks():void {
	 var damage:Number = player.spe;
	 damage += speedscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
	 if (!player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) damage *= 0.6;
	 //bonuses if fighting multiple enemies
	 if (monster.plural) {
	 if (!player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && !player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.1;
	 if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.5;
	 }
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.armor == armors.SPKIMO) damage *= 1.2;
	 if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //Determine if critical hit!
	 var crit:Boolean = false;
	 var critChance:int = 5;
	 if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 1;
	 }
	 if (player.hasPerk(PerkLib.ElvenSense) && && player.inte >= 50) critChance += 5;
	 if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
	 if (rand(100) < critChance) {
	 crit = true;
	 damage *= 1.75;
	 }
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 doDamage(damage);
	 outputText("Your scythes swiftly sweeps against [themonster], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
	 if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	 outputText("\n");
	 checkAchievementDamage(damage);
	 combat.heroBaneProc(damage);
	 combat.WrathGenerationPerHit2(5);
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 0) {
	 outputText("\n");
	 enemyAI();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 1) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 2) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 3) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 4) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 5) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 6) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 7) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 8) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 9) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 }

	 public function tripleThrust():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;//fizyczny atak
	 clearOutput();
	 if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
	 outputText("<b>Your current soulforce is too low.</b>");
	 doNext(combatMenu);
	 return;
	 }
	 outputText("You ready your [weapon] and prepare to thrust it towards [themonster].  ");
	 if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
	 enemyAI();
	 return;
	 }
	 var soulforcecost:Number = 10 * soulskillCost() * soulskillcostmulti();
	 soulforcecost = Math.round(soulforcecost);
	 player.soulforce -= soulforcecost;
	 var damage:Number = player.str;
	 damage += strenghtscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.hasPerk(PerkLib.HoldWithBothHands) && player.weapon != WeaponLib.FISTS && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) damage *= 1.2;
	 if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
	 if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
	if (player.armor == armors.SPKIMO) damage *= 1.2;
	if (player.hasPerk(PerkLib.OniTyrantKimono || PerkLib.OniEnlightenedKimono)) damage *= 1.4;
	if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //triple strike bonus
	 damage *= 3;
	 //soulskill mod effect
	 damage *= soulskillPhysicalMod();
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 doDamage(damage);
	 outputText("Your [weapon] hits thrice against [themonster], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
	 checkAchievementDamage(damage);
	 combat.WrathGenerationPerHit2(5);
	 combat.heroBaneProc(damage);
	 outputText("\n\n");
	 if (monster.HP <= monster.minHP()) doNext(endHpVictory);
	 else enemyAI();
	 }*/
}
}
