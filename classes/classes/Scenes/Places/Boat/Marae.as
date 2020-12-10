package classes.Scenes.Places.Boat 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;

public class Marae extends Monster
	{
		//Corrupted Marae's specials
		public function tentacleAttack():void {
			outputText("You spot barrage of tentacles coming your way! You attempt to dodge your way out ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED) outputText("and you successfully dodge her tentacles!");
			else if (evade != null) outputText("and you successfully dodge her tentacles thanks to your superior evasion!");
			else {
				outputText("but you fail and get hit instead! The feel of the tentacles left your groin slightly warmer. ");
				var damage:int = (eBaseStrengthDamage() + rand(str));
				damage = Math.round(damage);
				player.dynStats("lust", rand(15) + 75);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
			}
		}
		public function tentacleRape():void {
			outputText("You spot barrage of tentacles coming your way! The tentacles are coming your way, aiming for your groin! ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED) outputText("You manage to successfully run from her tentacles! ");
			else if (evade != null) outputText("You manage to avoid her tentacles thanks to your superior evasion!");
			else {
				outputText("You attempt to slap away the tentacles but it's too late! The tentacles tickle your groin and you can feel your [ass] being teased! \"<i>You know you want me!</i>\" Marae giggles. ");
				var lustDmg:int = (100 + rand(player.cor / 5) + rand(player.effectiveSensitivity() / 5) + rand(player.lib / 5) + rand(50)) * (EngineCore.lustPercent() / 100);
				player.dynStats("lust", lustDmg, "scale", false);
				outputText("(+" + lustDmg + " lust)");
				
			}
		}
		public function maraePollenCloud():void {
			outputText("marae giggles as she unleashes a thick cloud of pollen in your general direction.\n\n");
			outputText("\"<i>Just give in to me. I will make it so pleasurable for you.</i>\"\n\n");
			outputText("There is no way you will be able to not breathe it in and you feel your desire rise as the insidious aphrodisiac does its dirty work.\n\n");
			createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
		}
		
		//Pure Marae's specials
		public function vinesAttack():void {
			outputText("You spot barrage of vines coming your way! You attempt to dodge your way out ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED) outputText("and you successfully dodge her vines!");
			else if (evade != null) outputText("and you successfully dodge her vines thanks to your superior evasion!");
			else {
				outputText("but you fail and get hit instead! ");
				var damage:int = (eBaseStrengthDamage() + rand(str));
				damage = Math.round(damage);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
			}
		}
		public function smite():void {
			outputText("Marae mouths a chant. The clouds gather and quickly darkens. <b>It looks like a lightning might strike you!</b>");
			createStatusEffect(StatusEffects.Uber, 1, 0, 0, 0);
		}
		public function smiteHit():void {
			if (game.flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
				outputText("You look up in the sky to see the lightning incoming! Thanks to your preparedness, you manage to leap away before the lightning hits you! ");
			}
			else {
				outputText("Without warning, the lightning hits you! Surge of electricity rushes through you painfully. ");
				if (player.cor >= 50) outputText("The intensity of the pain is unbearable. ");
				var damage:int = (1100 + rand(150) + eBaseIntelligenceDamage() + eBaseWisdomDamage() + (player.cor * 20)) * 2.5;
				damage = Math.round(damage);
				player.takeLightningDamage(damage, true);
			}
			if (hasStatusEffect(StatusEffects.Uber)) removeStatusEffect(StatusEffects.Uber);
		}
		public function maraeStrangulate():void {
			outputText("Marae’s vines suddenly wrap tight around your neck and strangle you, preventing you from pronouncing any incantations. The godess woman gives you an annoyed glare.");
			outputText("\"<i>I’m done with your magic. Be a good " + player.mf("boy", "girl") + " and just give in.</i>\"");
			player.removeStatusEffect(StatusEffects.CastedSpell);
			player.createStatusEffect(StatusEffects.Sealed, 2, 10, 0, 0);
		}
		
		override protected function performCombatAction():void {
			var chooser:int = rand(4);
			if (hasStatusEffect(StatusEffects.Uber)) {
				smiteHit();
				return;
			}
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
				if (chooser < 2) eAttack();
				if (chooser == 2) {
					if (player.hasStatusEffect(StatusEffects.CastedSpell)) maraeStrangulate();
					else vinesAttack();
				}
				if (chooser == 3) smite();
			}
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				if (chooser < 2) {
					if (hasStatusEffect(StatusEffects.LustAura)) eAttack();
					else maraePollenCloud();
				}
				if (chooser == 2) tentacleAttack();
				if (chooser == 3) tentacleRape();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.boat.marae.winAgainstMarae();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.boat.marae.loseAgainstMarae();
		}
		
		public function Marae() 
		{
			this.a = "";
			this.short = "Marae";
			this.imageName = "marae";
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				this.long = "This being is known as the goddess of Mareth. She is corrupted due to the aftermath of the factory valves being blown up. She's white all over and textured with bark. The \"flower\" below her belly button resembles more of a vagina than a flower. Her G-cup sized breasts jiggle with every motion.";
				this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("G"));
				initStrTouSpeInte(400, 400, 370, 260);
				initWisLibSensCor(260, 600, 410, 100);
				this.weaponName = "tentacles";
				this.weaponVerb="slap";
				this.armorDef = 1500;
				this.armorMDef = 1500;
				this.weaponAttack = 100;
				this.bonusHP += 7500;
				this.bonusLust = 1115;
				this.additionalXP = 3000;
				this.special1 = tentacleAttack;
				this.special2 = tentacleRape;
				this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
				this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			}
			else {
				this.long = "This being is known as the goddess of Mareth. She is no longer corrupted thanks to your actions at the factory. She's white all over and textured with bark. Her breasts are modestly sized.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("DD"));
				initStrTouSpeInte(540, 540, 420, 310);
				initWisLibSensCor(310, 120, 290, 0);
				this.weaponName = "fists";
				this.weaponVerb="wrathful punch";
				this.armorDef = 2100;
				this.armorMDef = 2100;
				this.weaponAttack = 150;
				this.bonusHP += 30000;
				this.bonusLust = 515;
				this.additionalXP = 4000;
				this.special1 = smite;
				if (game.flags[kFLAGS.MINERVA_TOWER_TREE] > 0) {
					this.armorDef = 900;
					this.armorMDef = 900;
					this.strStat.core.value += 260;
					this.touStat.core.value += 260;
					this.bonusHP += 20000;
					this.additionalXP += 2000;
					this.createPerk(PerkLib.MonsterRegeneration, 9, 0, 0, 0);
				}
				else this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			}
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.tallness = 10*12;
			this.hips.type = 10;
			this.butt.type = 8;
			this.skin.base.color = "white";
			this.hairColor = "green";
			this.hairLength = 36;
			this.weaponPerk = "";
			this.weaponValue = 70;
			this.armorName = "bark";
			this.bonusHP = 5000;
			this.lust = 30;
			this.lustVuln = .04;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 105;
			this.drop = NO_DROP;
			this.gems = 1000;
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}