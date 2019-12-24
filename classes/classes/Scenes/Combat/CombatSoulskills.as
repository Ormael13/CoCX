/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.BodyParts.Arms;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Monster;
import classes.Items.ShieldLib;
import classes.Items.WeaponLib;
import classes.PerkLib;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class CombatSoulskills extends BaseCombatContent {
	public function CombatSoulskills() {
	}
	//------------
	// S. SPECIALS
	//------------
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		if (player.hasPerk(PerkLib.CleansingPalm)) {
			bd = buttons.add("C.Palm", CleansingPalm).hint("Unleash the power of your cleansing aura! More effective against corrupted opponents. Doesn't work on the pure.  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("<b>Your current soulforce is too low.</b>");
			} else if (player.cor >= (10 + player.corruptionTolerance())) {
				bd.disable("You are too corrupt to use this ability!");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIceFist)) {
			bd = buttons.add("Ice Fist", IceFist).hint("A chilling strike that can freeze an opponent solid, leaving it vulnerable to shattering soul art and hindering its movement.  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.findPerk(PerkLib.FireAffinity) >= 0) {
				bd.disable("Try as you want, you can’t call on the power of this technique due to your close affinity to fire.");
			} else if (!player.isFistOrFistWeapon()) {
				bd.disable("<b>Your current used weapon not allow to use this technique.</b>");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("<b>Your current soulforce is too low.</b>");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsFirePunch)) {
			bd = buttons.add("Fire Punch", FirePunch).hint("Ignite your opponents dealing fire damage and setting them ablaze.  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (!player.isFistOrFistWeapon()) {
				bd.disable("<b>Your current used weapon not allow to use this technique.</b>");
			} else if (player.findPerk(PerkLib.ColdAffinity) >= 0) {
				bd.disable("Try as you want, you can’t call on the power of this technique due to your close affinity to cold.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHurricaneDance)) {
			bd = buttons.add("Hurricane Dance", HurricaneDance).hint("Take on the aspect of the wind dodging attacks with aerial graces for a time.  \n\nWould go into cooldown after use for: 10 rounds  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownHurricaneDance)) {
				bd.disable("You need more time before you can use Hurricane Dance again.");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsEarthStance)) {
			bd = buttons.add("Earth Stance", EarthStance).hint("Take on the stability and strength of the earth gaining 30% damage reduction for the next 3 rounds.  \n\nWould go into cooldown after use for: 10 rounds  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownEarthStance)) {
				bd.disable("You need more time before you can use Earth Stance again.");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsPunishingKick)) {
			bd = buttons.add("Punishing Kick", PunishingKick).hint("A vicious kick that can daze an opponent, reducing its damage for a while.  \n\nWould go into cooldown after use for: 10 rounds  \n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownPunishingKick)) {
				bd.disable("You need more time before you can use Punishing Kick again.");
			} else if (player.isDrider() || player.isGoo() || player.isNaga() || player.isScylla() || player.isAlraune()) {
				bd.disable("<b>Your legs not allow to use this technique.</b>");
			} else if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsSoulBlast)) {
			bd = buttons.add("Soul Blast", SoulBlast).hint("Take in your reserve of soul force to unleash a torrent of devastating energy and obliterate your opponent.  \n\nWould go into cooldown after use for: 15 rounds  \n\nSoulforce cost: " + 100 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownSoulBlast)) {
				bd.disable("You need more time before you can use Soul Blast again.");
			} else if (player.soulforce < 100 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsOverlimit)) {
			if (player.hasStatusEffect(StatusEffects.Overlimit)) {
				bd = buttons.add("Overlimit(Off)", deactivaterOverlimit).hint("Deactivate Overlimit.");
			} else {
				bd = buttons.add("Overlimit(On)", activaterOverlimit).hint("Strain your body to its limit to increase melee damage dealt by 100% at the cost of hurting yourself. This also increases lust resistance.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsTripleThrust)) {
			bd = buttons.add("Triple Thrust", TripleThrust).hint("Use a little bit of soulforce to infuse your weapon and thrust three times toward your enemy.\n\nSoulforce cost: " + 30 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 30 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsSextupleThrust)) {
			bd = buttons.add("Sextuple Thrust", SextupleThrust).hint("Use a little bit of soulforce to infuse your weapon and thrust six times toward your enemy.  \n\nWould go into cooldown after use for: 1 round  \n\nSoulforce cost: " + 70 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownSextupleThrust)) {
				bd.disable("You need more time before you can use Sextuple Thrust again.");
			} else if (player.soulforce < 70 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsNonupleThrust)) {
			bd = buttons.add("Nonuple Thrust", NonupleThrust).hint("Use a little bit of soulforce to infuse your weapon and thrust nine times toward your enemy.  \n\nWould go into cooldown after use for: 2 rounds  \n\nSoulforce cost: " + 150 * soulskillCost() * soulskillcostmulti());
			if (player.hasStatusEffect(StatusEffects.CooldownNonupleThrust)) {
				bd.disable("You need more time before you can use Nonuple Thrust again.");
			} else if (player.soulforce < 150 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDracoSweep)) {
			bd = buttons.add("Draco Sweep", DracoSweep).hint("Use a little bit of soulforce to infuse your weapon and then sweep ahead hitting as many enemies as possible.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsFlamesOfLove)) {
			bd = buttons.add("Flames of Love", combat.flamesOfLove).hint("Use a little bit of lust to transform it into flames of love that you throw at enemy.  \n\nWould go into cooldown after use for: 3 rounds  \n\nLust cost: 90% of current lust");
			if (player.hasStatusEffect(StatusEffects.CooldownFlamesOfLove)) {
				bd.disable("You need more time before you can use Flames of Love again.");
			} else if (player.lust < 50) {
				bd.disable("Your current lust is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIciclesOfLove)) {
			bd = buttons.add("Icicles of Love", combat.iciclesOfLove).hint("Use a little bit of lust to transform it into icicles of love that you throw at enemy.  \n\nWould go into cooldown after use for: 3 rounds  \n\nLust cost: 90% of current lust");
			if (player.hasStatusEffect(StatusEffects.CooldownIciclesOfLove)) {
				bd.disable("You need more time before you can use Icicles of Love again.");
			} else if (player.lust < 50) {
				bd.disable("Your current lust is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeavensDevourer)) {
			bd = buttons.add("Devourer", combat.heavensDevourer).hint("Form a small sphere inscribed by symbols to drain from enemy a bit of lust and/or wrath.  \n\nWould go into cooldown after use for: 3 rounds");
			if (player.hasStatusEffect(StatusEffects.CooldownHeavensDevourer)) {
				bd.disable("You need more time before you can use Devourer again.");
			}
		}
		if (player.weapon == weapons.WGSWORD) {
			bd = buttons.add("Beat of War", BeatOfWar).hint("Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.weapon == weapons.WDBLADE) {
			bd = buttons.add("Blade Dance", BladeDance).hint("Attack twice (four times if double attack is active, six times if triple attack is active and etc.).\n\nSoulforce cost: " + 50 * soulskillCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE]));
			if (player.soulforce < 50 * soulskillCost() * (1 + flags[kFLAGS.DOUBLE_ATTACK_STYLE])) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.weapon == weapons.WDSTAFF) {
			bd = buttons.add("AvatarOfTheSong", AvatarOfTheSong).hint("Doublecast Charged Weapon and Might. Casts blind if charged weapon is already active. Casts Heal if Might is already active.\n\nSoulforce cost: 200");
			if (player.soulforce < 200) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
		}
		if (player.weaponRangeName == "Warden’s bow") {
			bd = buttons.add("ResonanceVolley", ResonanceVolley).hint("Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.\n\nSoulforce cost: 150");
			if (player.soulforce < 150) {
				bd.disable("Your current soulforce is too low.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManyBirds)) {
			bd = buttons.add("Many Birds", ManyBirds).hint("Project a figment of your soulforce as a crystal traveling at extreme speeds.\n\nSoulforce cost: " + 10 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsComet)) {
			bd = buttons.add("Comet", Comet).hint("Project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.\n\nSoulforce cost: " + 60 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 60 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHailOfBlades)) {
			bd = buttons.add("Hail of Blades", HailOfBlades1).hint("Form six weapons from your soulforce traveling at extreme speeds.\n\nSoulforce cost: " + 50 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 50 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsGrandioseHailOfBlades)) {
			bd = buttons.add("G.Hail of Blades", HailOfBlades2).hint("Form eighteen weapons from your soulforce traveling at extreme speeds.  \n\nWould go into cooldown after use for: 3 rounds  \n\nSoulforce cost: " + 200 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 200 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownGrandioseHailOfBlades)) {
				bd.disable("You need more time before you can use Grandiose Hail of Blades again.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsGrandioseHailOfMoonBlades)) {
			bd = buttons.add("G.Hail of M.Blades", HailOfBlades3).hint("Form fifty four weapons from your soulforce traveling at extreme speeds.  \n\nWould go into cooldown after use for: 9 rounds  \n\nSoulforce cost: " + 800 * soulskillCost() * soulskillcostmulti());
			if (player.soulforce < 800 * soulskillCost() * soulskillcostmulti()) {
				bd.disable("Your current soulforce is too low.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownGrandioseHailOfMoonBlades)) {
				bd.disable("You need more time before you can use Grandiose Hail of Moon Blades again.");
			} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
				bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsVioletPupilTransformation)) {
			if (player.hasStatusEffect(StatusEffects.VioletPupilTransformation)) {
				bd = buttons.add("Deactiv VPT", DeactivateVioletPupilTransformation)
					   .hint("Deactivate Violet Pupil Transformation.");
			} else {
				bd = buttons.add("V P Trans", VioletPupilTransformation).hint("Violet Pupil Transformation is a regenerating oriented soul art that at the cost of constant using fixed amount of soulforce would be healing user.\n\nSoulforce cost: <i>100 soulforce</i> regenerating <b>200 HP</b> per turn. (with some perks or races it could be more than 200)");
				if (player.soulforce < 100) {
					bd.disable("<b>Your current soulforce is too low.</b>");
				}
			}
		}
		if (player.findPerk(PerkLib.Trance) >= 0) {
			if (!player.hasStatusEffect(StatusEffects.TranceTransformation)) {
				bd = buttons.add("Trance", TranceTransformation).hint("Activate Trance state, whcih enhancing physical and mental abilities at constant cost of soulforce.\n\nCost: 100 soulforce on activation and 50 soulforce per turn)");
				if (player.soulforce < 100) {
					bd.disable("Your current soulforce is too low.");
				} else if (player.hasStatusEffect(StatusEffects.OniRampage)) {
					bd.disable("You are too angry to think straight. Smash your puny opponents first and think later.");
				}
			} else {
				bd = buttons.add("DeActTrance", DeactivateTranceTransformation).hint("Deactivate Trance.");
			}
		}
	}

	public function TripleThrust():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		if (monster.hasStatusEffect(StatusEffects.Frozen)) {
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			monster.spe += monster.statusEffectv1(StatusEffects.Frozen);
			monster.removeStatusEffect(StatusEffects.Frozen);
			outputText(" damage!");
		}
		else {
			outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ",");
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
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
		outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownSextupleThrust, 1, 0, 0, 0);
		if (monster.hasStatusEffect(StatusEffects.Frozen)) {
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			monster.spe += monster.statusEffectv1(StatusEffects.Frozen);
			monster.removeStatusEffect(StatusEffects.Frozen);
			outputText(" damage!");
		}
		else {
			outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ",");
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
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
		outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownNonupleThrust, 2, 0, 0, 0);
		if (monster.hasStatusEffect(StatusEffects.Frozen)) {
			outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			monster.spe += monster.statusEffectv1(StatusEffects.Frozen);
			monster.removeStatusEffect(StatusEffects.Frozen);
			outputText(" damage!");
		}
		else {
			outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ",");
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			MultiThrustD();
			outputText(" damage!");
		}
		outputText("\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	private function MultiThrustD():void {
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
		else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		//All special weapon effects like...fire/ice
		if (player.weapon == weapons.L_WHIP) {
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (player.haveWeaponForJouster()) {
			if (player.isMeetingNaturalJousterReq()) damage *= 3;
			if (player.isMeetingNaturalJousterMasterGradeReq()) damage *= 5;
		}
		if (player.weapon == weapons.NPHBLDE || player.weapon == weapons.MASAMUN || player.weapon == weapons.SESPEAR || player.weapon == weapons.WG_GAXE || player.weapon == weapons.KARMTOU) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (player.weapon == weapons.EBNYBLD || player.weapon == weapons.BLETTER || player.weapon == weapons.DSSPEAR || player.weapon == weapons.DE_GAXE || player.weapon == weapons.YAMARG) {
			if (monster.cor >= 66) damage = Math.round(damage * 1.0);
			else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
			else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
			else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 10;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 4;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.4;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			var damage1:Number = damage;
			if (monster.hasPerk(PerkLib.IceNature)) damage1 += (damage1 * 0.5);
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage1 += (damage1 * 0.2);
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage1 += (damage1 * 0.05);
			if (monster.hasPerk(PerkLib.FireNature)) damage1 += (damage1 * 0.02);
			if (player.hasPerk(PerkLib.FireAffinity)) damage1 *= 2;
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage += damage1;
		}
		//soulskill mod effect
		damage *= combat.soulskillPhysicalMod();
		//other bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		if (monster.hasStatusEffect(StatusEffects.Frozen)) damage *= 2;
		var d2:Number = 0.9;
		d2 += (rand(21) * 0.01);
		damage *= d2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.isSwordTypeWeapon()) critChance += 10;
		if (player.isDuelingTypeWeapon()) critChance += 20;
		critChance += combat.combatPhysicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText(" ");
		if ((player.weapon == weapons.RCLAYMO || player.weapon == weapons.RDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doFireDamage(damage, true, true);
		else if ((player.weapon == weapons.SCLAYMO || player.weapon == weapons.SDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doIceDamage(damage, true, true);
		else if ((player.weapon == weapons.TCLAYMO || player.weapon == weapons.TODAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doLightingDamage(damage, true, true);
		else if ((player.weapon == weapons.ACLAYMO || player.weapon == weapons.ADAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doDarknessDamage(damage, true, true);
		else damage = doDamage(damage, true, true);
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
		if (player.hasStatusEffect(StatusEffects.EruptingRiposte)) flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] += monster.tou + monster.inte + monster.wis;
	}

	public function DracoSweep():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		outputText("You ready your [weapon] and prepare to sweep it towards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = player.str;
		damage += scalingBonusStrength() * 0.5;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
		else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		//All special weapon effects like...fire/ice
		if (player.weapon == weapons.L_WHIP) {
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		if (player.haveWeaponForJouster()) {
			if (player.isMeetingNaturalJousterReq()) damage *= 3;
			if (player.isMeetingNaturalJousterMasterGradeReq()) damage *= 5;
		}
		if (player.weapon == weapons.NPHBLDE || player.weapon == weapons.MASAMUN || player.weapon == weapons.SESPEAR || player.weapon == weapons.WG_GAXE || player.weapon == weapons.KARMTOU) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (player.weapon == weapons.EBNYBLD || player.weapon == weapons.BLETTER || player.weapon == weapons.DSSPEAR || player.weapon == weapons.DE_GAXE || player.weapon == weapons.YAMARG) {
			if (monster.cor >= 66) damage = Math.round(damage * 1.0);
			else if (monster.cor >= 50) damage = Math.round(damage * 1.1);
			else if (monster.cor >= 25) damage = Math.round(damage * 1.2);
			else if (monster.cor >= 10) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 10;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 4;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.4;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			var damage1:Number = damage;
			if (monster.hasPerk(PerkLib.IceNature)) damage1 += (damage1 * 0.5);
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage1 += (damage1 * 0.2);
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage1 += (damage1 * 0.05);
			if (monster.hasPerk(PerkLib.FireNature)) damage1 += (damage1 * 0.02);
			if (player.hasPerk(PerkLib.FireAffinity)) damage1 *= 2;
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage += damage1;
		}
		//soulskill mod effect
		damage *= combat.soulskillPhysicalMod();
		//group enemies bonus
		if (monster.plural == true) damage *= 5;
		//other bonuses
		if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
		if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
		if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= combat.historyFighterBonus();
		if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
		if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
		if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
		if (player.hasStatusEffect(StatusEffects.OniRampage)) damage *= combat.oniRampagePowerMulti();
		if (player.hasStatusEffect(StatusEffects.Overlimit)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.isSwordTypeWeapon()) critChance += 10;
		if (player.isDuelingTypeWeapon()) critChance += 20;
		critChance += combat.combatPhysicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText("Your [weapon] sweeps against " + monster.a + monster.short + ", dealing ");
		if ((player.weapon == weapons.RCLAYMO || player.weapon == weapons.RDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doFireDamage(damage, true, true);
		else if ((player.weapon == weapons.SCLAYMO || player.weapon == weapons.SDAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doIceDamage(damage, true, true);
		else if ((player.weapon == weapons.TCLAYMO || player.weapon == weapons.TODAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doLightingDamage(damage, true, true);
		else if ((player.weapon == weapons.ACLAYMO || player.weapon == weapons.ADAGGER) && player.hasStatusEffect(StatusEffects.ChargeWeapon)) damage = doDarknessDamage(damage, true, true);
		else damage = doDamage(damage, true, true);
		outputText(" damage! ");
		if (crit == true) {
			outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (crit == false && player.findPerk(PerkLib.Rage) >= 0 && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 50) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function ManyBirds():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		if (silly ()) outputText("You focus your soulforce, projecting it as an aura around you.  As you concentrate, dozens, hundreds, thousands of tiny, ethereal birds shimmer into existence.  As you raise your hand up, more and more appear, until the area around you and " + monster.a + monster.short + "  is drowned in spectral flappy shapes.  ");
		else {
			outputText("You thrust your hand outwards with deadly intent, and in the blink of an eye a crystal shoots towards " + monster.a + monster.short + ".  ");
			if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
				if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids crystal!");
				if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges crystal with superior quickness!");
				if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids crystal.");
				enemyAI();
				return;
			}
		}
		var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = scalingBonusWisdom();
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		damage = doDamage(damage);
		if (silly ()) {
			outputText("You snap your fingers, and at once every bird lends their high pitched voice to a unified, glass shattering cry:");
			outputText("\n\n\"<i>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</i>\" (" + monster.a + monster.short + " take ");
			damage = doMagicDamage(damage, true, true);
			outputText(" damage) ");
		}
		else {
			outputText("Crystal hits " + monster.a + monster.short + ", dealing ");
			damage = doMagicDamage(damage, true, true);
			outputText(" damage! ");
		}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function Comet():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("You focus for a moment, projecting a fragment of your soulforce above you.  A moment later, a prismatic comet crashes down on your opponents " + monster.a + monster.short + ".  ");
		if (monster.plural == true) outputText("Shattering into thousands of fragments that shower anything and everything around you.  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids comet fragments!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges comet fragments with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids comet fragments.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 60 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var damage:Number = scalingBonusWisdom();
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//group enemies bonus
		if (monster.plural == true) damage *= 5;
		//other bonuses
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		outputText("Comet fragments hits " + monster.a + monster.short + ", dealing ");
		damage = doMagicDamage(damage, true, true);
		outputText(" damage! ");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function HailOfBlades1():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("Letting soulforce leak out around you, you form six ethereal two meter long weapons. You thrust your hand outwards and in the blink of an eye, weapons shoot forwards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe - player.spe) / 4) + 80)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids weapons!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges weapons with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids weapons.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		outputText("Weapons hits " + monster.a + monster.short + ", dealing ");
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		outputText(" damage!\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function HailOfBlades2():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("Letting soulforce leak out around you, you form eighteen ethereal two meter long weapons in two rows. You thrust your hand outwards and in the blink of an eye, weapons shoot forwards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 10 && int(Math.random() * (((monster.spe - player.spe) / 5) + 70)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids weapons!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges weapons with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids weapons.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 200 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownGrandioseHailOfBlades, 3, 0, 0, 0);
		outputText("Weapons hits " + monster.a + monster.short + ", dealing ");
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		outputText(" damage!\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function HailOfBlades3():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		outputText("Letting soulforce leak out around you, you form fifty four ethereal two meter long weapons in four rows. You thrust your hand outwards and in the blink of an eye, weapons shoot forwards " + monster.a + monster.short + ".  ");
		if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 20 && int(Math.random() * (((monster.spe - player.spe) / 6) + 60)) > 80)) {
			if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids weapons!");
			if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges weapons with superior quickness!");
			if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids weapons.");
			enemyAI();
			return;
		}
		var soulforcecost:int = 800 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		player.createStatusEffect(StatusEffects.CooldownGrandioseHailOfMoonBlades, 9, 0, 0, 0);
		outputText("Weapons hits " + monster.a + monster.short + ", dealing ");
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		BladesD();
		outputText(" damage!\n\n");
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	private function BladesD():void {
		var damage:Number = player.wis * 0.5;
		damage += scalingBonusWisdom() * 0.5;
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= combat.soulskillMagicalMod();
		//other bonuses
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
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
		damage = doDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
		if (player.hasStatusEffect(StatusEffects.EruptingRiposte)) flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] += monster.tou + monster.inte + monster.wis;
	}

	public function CleansingPalm():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
//This is now automatic - newRound arg defaults to true:	menuLoc = 0;
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		if (monster.short == "Jojo") {
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
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 10;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 4;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.4;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			var damage1:Number = damage;
			if (monster.hasPerk(PerkLib.IceNature)) damage1 += (damage1 * 0.5);
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage1 += (damage1 * 0.2);
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage1 += (damage1 * 0.05);
			if (monster.hasPerk(PerkLib.FireNature)) damage1 += (damage1 * 0.02);
			if (player.hasPerk(PerkLib.FireAffinity)) damage1 *= 2;
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage += damage1;
		}
		damage *= soulskillMod();
		damage *= corruptionMulti;
		if (player.findPerk(PerkLib.PerfectStrike) >= 0 && (monster.hasStatusEffect(StatusEffects.Frozen) || monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.FreezingBreathStun))) damage *= 1.5;
		if (damage > 0) {
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", tossing");
			if ((monster as Monster).plural == true) outputText(" them");
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
			if (player.findPerk(PerkLib.FlurryOfBlows) >= 0) damage *= 2;
			outputText(monster.capitalA + monster.short + " takes <b><font color=\"#800000\">" + damage + "</font></b> damage.\n\n");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		else {
			damage = 0;
			outputText("You thrust your palm forward, causing a blast of pure energy to slam against " + monster.a + monster.short + ", which they ignore. It is probably best you don’t use this technique against the pure.\n\n");
		}
		monster.HP -= damage;
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function IceFist():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
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
		if (player.findPerk(PerkLib.PerfectStrike) >= 0 && (monster.hasStatusEffect(StatusEffects.Frozen) || monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.FreezingBreathStun))) damage *= 1.5;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		if (combat.wearingWinterScarf()) damage *= 1.2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		if (player.findPerk(PerkLib.FlurryOfBlows) >= 0) damage *= 2;
		monster.spe -= 20;
		outputText("Air seems to lose all temperature around your fist as you dash at " + monster.a + monster.short + " and shove your palm on " + monster.pronoun2 + ", " + monster.pronoun3 + " body suddenly is frozen solid, encased in a thick block of ice! ");
		damage = doIceDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (monster.hasStatusEffect(StatusEffects.Frozen)) {
			if (monster.spe - 20 >= 0) {
				monster.addStatusValue(StatusEffects.Frozen, 1, 20);
				monster.spe -= 20;
			}
			else {
				monster.addStatusValue(StatusEffects.Frozen, 1, monster.spe);
				monster.spe -= monster.spe;
			}
		}
		else {
			monster.createStatusEffect(StatusEffects.Frozen, 0, 0, 0, 0);
			if (monster.spe - 20 >= 0) {
				monster.addStatusValue(StatusEffects.Frozen, 1, 20);
				monster.spe -= 20;
			}
			else {
				monster.addStatusValue(StatusEffects.Frozen, 1, monster.spe);
				monster.spe -= monster.spe;
			}
		}
		if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		else {
			outputText("  <b>" + monster.capitalA + monster.short + " ");
			if(!monster.plural) outputText("is ");
			else outputText("are");
			outputText("too resolute to be frozen by your attack.</b>");
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		outputText("\n\n");
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function FirePunch():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
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
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
		}
		//other bonuses
		if (player.findPerk(PerkLib.PerfectStrike) >= 0 && (monster.hasStatusEffect(StatusEffects.Frozen) || monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.FreezingBreathStun))) damage *= 1.5;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		if (player.findPerk(PerkLib.FlurryOfBlows) >= 0) damage *= 2;
		monster.createStatusEffect(StatusEffects.FirePunchBurnDoT,16,0,0,0);
		outputText("Setting your fist ablaze, you rush at " + monster.a + monster.short + " and scorch " + monster.pronoun2 + " with your searing flames. ");
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage += Math.round(damage * 0.1);
			damage = doFireDamage(damage, true, true);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage = Math.round(damage * 1.1);
		}
		else damage = doFireDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		outputText("\n\n");
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function HurricaneDance():void {
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		outputText("Your movement becomes more fluid and precise, increasing your speed and evasion.\n\n");
		player.createStatusEffect(StatusEffects.HurricaneDance, 5, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownHurricaneDance, 10, 0, 0, 0);
		enemyAI();
	}

	public function EarthStance():void {
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		outputText("Your body suddenly hardens like rock. You will be way harder to damage for a while.\n\n");
		player.createStatusEffect(StatusEffects.EarthStance, 3, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownEarthStance, 10, 0, 0, 0);
		enemyAI();
	}

	public function PunishingKick():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
		clearOutput();
		var soulforcecost:int = 30 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
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
			if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI && (player.jewelryName == "Infernal Mouse ring" || player.jewelryName2 == "Infernal Mouse ring" || player.jewelryName3 == "Infernal Mouse ring" || player.jewelryName4 == "Infernal Mouse ring")) damage *= 2.2;
			else damage *= 2;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 10;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 4;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.4;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
		}
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			var damage1:Number = damage;
			if (monster.hasPerk(PerkLib.IceNature)) damage1 += (damage1 * 0.5);
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage1 += (damage1 * 0.2);
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage1 += (damage1 * 0.05);
			if (monster.hasPerk(PerkLib.FireNature)) damage1 += (damage1 * 0.02);
			if (player.hasPerk(PerkLib.FireAffinity)) damage1 *= 2;
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1);
			damage += damage1;
		}
		//other bonuses
		if (player.findPerk(PerkLib.PerfectStrike) >= 0 && (monster.hasStatusEffect(StatusEffects.Frozen) || monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.FreezingBreathStun))) damage *= 1.5;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		if (player.findPerk(PerkLib.FlurryOfBlows) >= 0) damage *= 2;
		damage = doDamage(damage);
		monster.createStatusEffect(StatusEffects.PunishingKick, 5, 0, 0, 0);
		player.createStatusEffect(StatusEffects.CooldownPunishingKick, 10, 0, 0, 0);
		outputText("You lash out with a devastating kick, knocking your opponent back and disorienting it. " + monster.capitalA + monster.short + " will have a hard time recovering its balance for a while. <b><font color=\"#800000\">" + damage + "</font></b> damage!");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		outputText("\n\n");
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

	public function SoulBlast():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		var soulforcecost:int = 100 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
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
		if (player.findPerk(PerkLib.PerfectStrike) >= 0 && (monster.hasStatusEffect(StatusEffects.Frozen) || monster.hasStatusEffect(StatusEffects.Stunned) || monster.hasStatusEffect(StatusEffects.StunnedTornado) || monster.hasStatusEffect(StatusEffects.FreezingBreathStun))) damage *= 1.5;
		if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		damage *= (monster.damagePercent() / 100);
		player.createStatusEffect(StatusEffects.CooldownSoulBlast, 15, 0, 0, 0);
		outputText("You wave the sign of the gate, tiger and serpent as you unlock all of your soulforce for an attack. " + monster.capitalA + monster.short + " can’t figure out what you are doing until a small sphere of energy explodes at the end of your fist in a massive beam of condensed soulforce. ");
		damage = doMagicDamage(damage, true, true);
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		if (monster.findPerk(PerkLib.Resolute) < 0) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		else {
			outputText("  <b>" + monster.capitalA + monster.short + " ");
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
		outputText("You let your rage cool down, feeling relieved as the stress in your body diminish along with your power.\n\n");
		player.removeStatusEffect(StatusEffects.Overlimit);
		enemyAI();
	}

	public function VioletPupilTransformationHealing():Number {
		var modvpth:Number = 200;
		//if () modvpth += 5;
		//if (player.findPerk(PerkLib.) >= 0 || player.findPerk(PerkLib.) >= 0) modvpth *= 1.3;
		return modvpth;
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
			if (player.findPerk(PerkLib.JobSorcerer) >= 0 && player.inte >= 25) TranceBoost += 5;
			if (player.findPerk(PerkLib.Spellpower) >= 0 && player.inte >= 50) TranceBoost += 5;
			if (player.findPerk(PerkLib.Mage) >= 0 && player.inte >= 50) TranceBoost += 10;
			if (player.findPerk(PerkLib.FocusedMind) >= 0 && player.inte >= 50) TranceBoost += 10;
			if (player.findPerk(PerkLib.Channeling) >= 0 && player.inte >= 60) TranceBoost += 10;
			if (player.findPerk(PerkLib.Archmage) >= 0 && player.inte >= 75) TranceBoost += 15;
			if (player.findPerk(PerkLib.GrandArchmage) >= 0 && player.inte >= 100) TranceBoost += 20;
			if (player.findPerk(PerkLib.GreyMage) >= 0 && player.inte >= 125) TranceBoost += 25;
			if (player.findPerk(PerkLib.GreyArchmage) >= 0 && player.inte >= 150) TranceBoost += 30;
			if (player.findPerk(PerkLib.JobEnchanter) >= 0 && player.inte >= 50) TranceBoost += 5;
			if (player.findPerk(PerkLib.Battleflash) >= 0 && player.inte >= 50) TranceBoost += 15;
			if (player.findPerk(PerkLib.JobSwordsman) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.JobBrawler) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.JobDervish) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.IronFistsI) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.JobMonk) >= 0) TranceBoost -= 15;
			if (player.findPerk(PerkLib.Berzerker) >= 0) TranceBoost -= 15;
			if (player.findPerk(PerkLib.Lustzerker) >= 0) TranceBoost -= 15;
			if (player.findPerk(PerkLib.WeaponMastery) >= 0) TranceBoost -= 15;
			if (player.findPerk(PerkLib.WeaponGrandMastery) >= 0) TranceBoost -= 25;
			if (player.findPerk(PerkLib.HeavyArmorProficiency) >= 0) TranceBoost -= 15;
			if (player.findPerk(PerkLib.AyoArmorProficiency) >= 0) TranceBoost -= 20;
			if (player.findPerk(PerkLib.Agility) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.LightningStrikes) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.StarlightStrikes) >= 0) TranceBoost -= 10;
			if (player.findPerk(PerkLib.BodyCultivator) >= 0) TranceBoost -= 5;
		//	TranceBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (TranceBoost < 10) TranceBoost = 10;
		//	if (player.findPerk(PerkLib.JobEnchanter) >= 0) TranceBoost *= 1.2;
		//	TranceBoost *= spellModBlack();
			TranceBoost = FnHelpers.FN.logScale(TranceBoost,TranceABC,10);
			TranceBoost = Math.round(TranceBoost);
			tempStrTou = TranceBoost;
			player.createStatusEffect(StatusEffects.TranceTransformation, 0, 0, 0, 0);
			player.changeStatusValue(StatusEffects.TranceTransformation, 1, tempStrTou);
			mainView.statsView.showStatUp('str');
			// strUp.visible = true;
			// strDown.visible = false;
			mainView.statsView.showStatUp('tou');
			// touUp.visible = true;
			// touDown.visible = false;
			player.str += player.statusEffectv1(StatusEffects.TranceTransformation);
			player.tou += player.statusEffectv1(StatusEffects.TranceTransformation);
			statScreenRefresh();
		};
		var tempStrTou:Number = 0;
		var tempSpe:Number = 0;
		var tempInt:Number = 0;
		outputText("You focus the power of your mind and soul, letting the mystic energy fill you. Your [skin] begins to crystalize as the power within you takes form. The power whirls within you like a hurricane, the force of it lifting you off your feet. This power...  You will use it to reach victory!\n");
		doEffect.call();
		enemyAI();
	}
	public function DeactivateTranceTransformation():void {
		clearOutput();
		outputText("You disrupt the flow of power within you, softly falling to the ground as the crystal sheathing your [skin] dissipates into nothingness.");
		player.dynStats("str", -player.statusEffectv1(StatusEffects.TranceTransformation));
		player.dynStats("tou", -player.statusEffectv1(StatusEffects.TranceTransformation));
		player.removeStatusEffect(StatusEffects.TranceTransformation);
		enemyAI();
	}

	public function BeatOfWar():void {
		clearOutput();
		var tempStr:Number = 0;
		var soulforcecost:int = 50 * soulskillCost() * soulskillcostmulti();
		player.soulforce -= soulforcecost;
		var BeatOfWarBoost:Number = (player.str - player.statusEffectv1(StatusEffects.BeatOfWar)) * 0.15;
		if (BeatOfWarBoost < 1) BeatOfWarBoost = 1;
		BeatOfWarBoost = Math.round(BeatOfWarBoost);
		if (!player.hasStatusEffect(StatusEffects.BeatOfWar)) player.createStatusEffect(StatusEffects.BeatOfWar,0,0,0,0);//player.addStatusValue(StatusEffects.BeatOfWar, 1, BeatOfWarBoost);
		tempStr = BeatOfWarBoost;
		player.addStatusValue(StatusEffects.BeatOfWar,1,tempStr);
		mainView.statsView.showStatUp('str');
		player.str += BeatOfWarBoost;			//player.statusEffectv1(StatusEffects.BeatOfWar);
		statScreenRefresh();
		outputText("You momentarily attune yourself to the song of the mother tree, and prepare to add a note of your own to it’s rhythm. You feel the beat shift the song’s tempo slightly, taking a twist towards the ominous. This attunement augments your strength.\n\n");
		combat.basemeleeattacks();
	}
	public function BladeDance():void {
		clearOutput();
		outputText("You momentarily attune yourself to the song of the mother tree, and dance forward, darting your blade around your enemy.\n\n");
		player.createStatusEffect(StatusEffects.BladeDance,0,0,0,0);
		combat.basemeleeattacks();
	}
	public function ResonanceVolley():void {
		clearOutput();
		outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
	}
	public function AvatarOfTheSong():void {
		clearOutput();
		outputText("You feel the song of the mother tree all around you, and using your staff as a beacon, you unify it with the flow of magic through your body,");
		if (!player.hasStatusEffect(StatusEffects.Might)) {
			outputText("drawing strength from it");
			combat.magic.spellMight(true);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
		}
		else {
			outputText("feeling it mend your wounds");
			fatigue(30, USEFATG_BLACK_NOBM);
			combat.magic.spellHealEffect();
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
		}
		if (!monster.hasStatusEffect(StatusEffects.Blind)) {
			outputText(". The residual power ");
			if (!player.hasStatusEffect(StatusEffects.ChargeWeapon)) {
				outputText("makes your staff glow with barely contained energy");
				combat.magic.spellChargeWeapon(true);
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
			}
			else {
				outputText("makes your staff flare up, as the energy escapes as a radiant flash");
				combat.magic.spellBlind();
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
			}
		}
		outputText(".\n\n");
		enemyAI();
	}
	/*
	 //Mantis Omni Slash (AoE attack) - przerobić to na soulskilla zużywającego jak inne soulforce z rosnącym kosztem im wyższy lvl postaci ^^ owinno wciąż jakoś być powiązane z posiadaniem mantis arms czy też ulepszonych mantis arms (czyt. versji 2.0 tych ramion z TF bdącego soul evolution of Mantis) ^^
	 public function mantisOmniSlash():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
	 clearOutput();
	 if (monster.plural) {
	 if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " " + monster.short + ".");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 else {
	 if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " " + monster.short + ".");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 if (monster.plural) {
	 fatigue(60, USEFATG_PHYSICAL);
	 }
	 else fatigue(24, USEFATG_PHYSICAL);
	 //Amily!
	 if(monster.hasStatusEffect(StatusEffects.Concentration)) {
	 outputText("Amily easily glides around your attacks thanks to her complete concentration on your movements.\n\n");
	 enemyAI();
	 return;
	 }
	 outputText("You ready your wrists mounted scythes and prepare to sweep them towards " + monster.a + monster.short + ".\n\n");
	 if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attacks!\n\n");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attacks with superior quickness!\n\n");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attacks.\n\n");
	 enemyAI();
	 return;
	 if (monster.plural) {
	 if (player.findPerk(PerkLib.MantislikeAgility) >= 0) {
	 if (player.findPerk(PerkLib.MantislikeAgilityEvolved) >= 0 && player.findPerk(PerkLib.TrachealSystemEvolved) >= 0) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
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
	 if (player.findPerk(PerkLib.MantislikeAgility) < 0) damage *= 0.6;
	 //bonuses if fighting multiple enemies
	 if (monster.plural) {
	 if (player.findPerk(PerkLib.MantislikeAgility) < 0 && player.findPerk(PerkLib.TrachealSystemEvolved) < 0) damage *= 1.1;
	 if (player.findPerk(PerkLib.MantislikeAgility) >= 0 && player.findPerk(PerkLib.TrachealSystemEvolved) >= 0) damage *= 1.5;
	 }
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
	 if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.armor == armors.SPKIMO) damage *= 1.2;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //Determine if critical hit!
	 var crit:Boolean = false;
	 var critChance:int = 5;
	 if (player.findPerk(PerkLib.Tactician) >= 0 && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 1;
	 }
	 if (player.hasPerk(PerkLib.ElvenSense) && && player.inte >= 50) critChance += 5;
	 if (monster.isImmuneToCrits() && player.findPerk(PerkLib.EnableCriticals) < 0) critChance = 0;
	 if (rand(100) < critChance) {
	 crit = true;
	 damage *= 1.75;
	 }
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 damage = doDamage(damage);
	 outputText("Your scythes swiftly sweeps against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
	 if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	 outputText("\n");
	 checkAchievementDamage(damage);
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
	 outputText("You ready your [weapon] and prepare to thrust it towards " + monster.a + monster.short + ".  ");
	 if ((player.hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
	 enemyAI();
	 return;
	 }
	 var soulforcecost:int = 10 * soulskillCost() * soulskillcostmulti();
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
	 if (player.findPerk(PerkLib.HoldWithBothHands) >= 0 && player.weapon != WeaponLib.FISTS && player.shield == ShieldLib.NOTHING && !isWieldingRangedWeapon()) damage *= 1.2;
	 if (player.findPerk(PerkLib.ThunderousStrikes) >= 0 && player.str >= 80) damage *= 1.2;
	 if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.findPerk(PerkLib.JobWarrior) >= 0) damage *= 1.05;
	 if (player.findPerk(PerkLib.Heroism) >= 0 && (monster.findPerk(PerkLib.EnemyBossType) >= 0 || monster.findPerk(PerkLib.EnemyGigantType) >= 0)) damage *= 2;
	if (player.armor == armors.SPKIMO) damage *= 1.2;
	if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //triple strike bonus
	 damage *= 3;
	 //soulskill mod effect
	 damage *= combat.soulskillPhysicalMod();
	 //final touches
	 damage *= (monster.damagePercent() / 100);
	 damage = doDamage(damage);
	 outputText("Your [weapon] hits thrice against " + monster.a + monster.short + ", dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
	 checkAchievementDamage(damage);
	 outputText("\n\n");
	 if (monster.HP <= monster.minHP()) doNext(endHpVictory);
	 else enemyAI();
	 }*/
}
}
