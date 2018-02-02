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
			if (evade == EVASION_SPEED)
			{
				outputText("and you successfully dodge her tentacles!");
			}
			else if (evade != null)
			{
				outputText("and you successfully dodge her tentacles thanks to your superior evasion!");
			}
			else
			{
				outputText("but you fail and get hit instead! The feel of the tentacles left your groin slightly warmer. ");
				var damage:int = (eBaseStrengthDamage() + rand(50));
				player.dynStats("lust", rand(5) + 5);
				player.takePhysDamage(damage, true);
			}
		}
		
		public function tentacleRape():void {
			
			outputText("You spot barrage of tentacles coming your way! The tentacles are coming your way, aiming for your groin! ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED)
			{
				outputText("You manage to successfully run from her tentacles! ");
			}
			else if (evade != null)
			{
				outputText("You manage to avoid her tentacles thanks to your superior evasion!");
			}
			else
			{
				outputText("You attempt to slap away the tentacles but it's too late! The tentacles tickle your groin and you can feel your [ass] being teased! \"<i>You know you want me!</i>\" Marae giggles. ");
				var lustDmg:int = (20 + rand(player.cor / 10) + rand(player.sens / 5) + rand(player.lib / 10) + rand(10)) * (EngineCore.lustPercent() / 100);
				player.dynStats("lust", lustDmg, "scale", false);
				outputText("(+" + lustDmg + " lust)");
				
			}
		}
		
		//Pure Marae's specials
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
				var damage:int = 100 + eBaseIntelligenceDamage() + eBaseWisdomDamage() + (player.cor * 5);
				player.takeMagicDamage(damage, true);
			}
			if (hasStatusEffect(StatusEffects.Uber)) removeStatusEffect(StatusEffects.Uber);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.boat.marae.winAgainstMarae();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.boat.marae.loseAgainstMarae();
		}
		
		override public function doAI():void {
			if (hasStatusEffect(StatusEffects.Stunned)) {
				outputText("Your foe is too dazed from your last hit to strike back!");
				if (hasStatusEffect(StatusEffects.Uber)) {
					outputText(" You've managed to interrupt her smite attack!");
					removeStatusEffect(StatusEffects.Uber);
				}
				if (statusEffectv1(StatusEffects.Stunned) <= 0) removeStatusEffect(StatusEffects.Stunned);
				else addStatusValue(StatusEffects.Stunned, 1, -1);
				return;
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				EngineCore.outputText("\"<i>You think I'm afraid of anything? Foolish mortal.</i>\" Marae snarls.\n\n");
				removeStatusEffect(StatusEffects.Fear);
			}
			var chooser:int = rand(10);
			if (hasStatusEffect(StatusEffects.Uber)) {
				smiteHit();
				return;
			}
			if (chooser < 4) {
				eAttack();
				return
			}
			else if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
				if (chooser >= 4 && chooser < 7) eAttack();
				if (chooser >= 7 && chooser < 10) smite();
			}
			else if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				if (chooser >= 4 && chooser < 7) tentacleAttack();
				if (chooser >= 7 && chooser < 10) tentacleRape();
			}
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
				initStrTouSpeInte(300, 300, 170, 180);
				initWisLibSensCor(180, 150, 25, 100);
				this.weaponName = "tentacles";
				this.weaponVerb="slap";
				this.armorDef = 1000;
				this.weaponAttack = 100;
				this.bonusLust += 300;
				this.additionalXP = 3000;
				this.special1 = tentacleAttack;
				this.special2 = tentacleRape;
				this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			}
			else {
				this.long = "This being is known as the goddess of Mareth. She is no longer corrupted thanks to your actions at the factory. She's white all over and textured with bark. Her breasts are modestly sized.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("DD"));
				initStrTouSpeInte(380, 380, 220, 260);
				initWisLibSensCor(260, 30, 25, 0);
				this.weaponName = "fists";
				this.weaponVerb="wrathful punch";
				this.weaponAttack = 150;
				this.bonusHP += 5000;
				if (game.flags[kFLAGS.MINERVA_TOWER_TREE] > 0) {
					this.armorDef = 2000;
					this.str += 120;
					this.tou += 120;
					this.bonusHP += 4000;
					this.additionalXP = 6000;
					this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
				}
				else {
					this.armorDef = 1400;
					this.additionalXP = 4000;
				}
				this.special1 = smite;
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
			this.bonusLust = 100;
			this.lust = 30;
			this.lustVuln = .04;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 99;
			this.drop = NO_DROP;
			this.gems = 1000;
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
