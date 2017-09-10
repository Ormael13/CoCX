package classes.Scenes.Places.Boat 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.*;

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
				var damage:int = ((str + 100) + rand(50))
				game.dynStats("lust", rand(5) + 5);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
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
				var lustDmg:int = (20 + rand(player.cor / 10) + rand(player.sens / 5) + rand(player.lib / 10) + rand(10)) * (game.lustPercent() / 100);
				game.dynStats("lust", lustDmg, "resisted", false);
				outputText("(+" + lustDmg + " lust)");
				
			}
			combatRoundOver();
		}
		
		//Pure Marae's specials
		public function smite():void {
			outputText("Marae mouths a chant. The clouds gather and quickly darkens. <b>It looks like a lightning might strike you!</b>");
			createStatusEffect(StatusEffects.Uber, 1, 0, 0, 0);
			combatRoundOver();
		}
		public function smiteHit():void {
			if (game.flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
				outputText("You look up in the sky to see the lightning incoming! Thanks to your preparedness, you manage to leap away before the lightning hits you! ");
			}
			else {
				outputText("Without warning, the lightning hits you! Surge of electricity rushes through you painfully. ");
				if (player.cor >= 50) outputText("The intensity of the pain is unbearable. ");
				var damage:int = 100 + str + (player.cor * 5);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			if (hasStatusEffect(StatusEffects.Uber)) removeStatusEffect(StatusEffects.Uber);
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.boat.marae.winAgainstMarae();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.boat.marae.loseAgainstMarae();
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
				combatRoundOver();
				return;
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				game.outputText("\"<i>You think I'm afraid of anything? Foolish mortal.</i>\" Marae snarls.\n\n");
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
				this.long = "This being is known as the goddess of Mareth. She is corrupted due to the aftermath of the factory valves being blown up. She's white all over and textured with bark. The \"flower\" below her belly button resembles more of a vagina than a flower. Her G-cup sized breasts jiggle with every motion."
				this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("G"));
			}
			else {
				this.long = "This being is known as the goddess of Mareth. She is no longer corrupted thanks to your actions at the factory. She's white all over and textured with bark. Her breasts are modestly sized."
				this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("DD"));
			}
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.tallness = 10*12;
			this.hipRating = 10;
			this.buttRating = 8;
			this.skin.base.color = "white";
			this.hairColor = "green";
			this.hairLength = 36;
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				initStrTouSpeInte(300, 300, 170, 180);
				initLibSensCor(150, 25, 100);
				this.weaponName = "tentacles";
				this.weaponVerb="slap";
				this.weaponAttack = 100 + (21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.str += 150 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 150 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 85 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 90 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 75 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];//na lvl 75-99 +50% statów a potem +60/70% co każde przedział 25 lvl-i
				this.newgamebonusHP = 55000;//dodane this.str/tou/spe/inte/lib a nastepnie pomnożone przez 100 (dla lvl 90-99, dla każdego kolejnego przedziału 10 lvl kolejne 10 x wiecej)
			}
			else {
				initStrTouSpeInte(370, 370, 220, 260);
				initLibSensCor(30, 25, 0);
				this.weaponName = "fists";
				this.weaponVerb="wrathful punch";
				this.weaponAttack = 126 + (26 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.str += 185 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 185 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 110 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 130 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];//na lvl 75-99 +50% statów a potem +60/70% co każde przedział 25 lvl-i
				this.newgamebonusHP = 62500;//dodane this.str/tou/spe/inte/lib a nastepnie pomnożone przez 100 (dla lvl 90-99, dla każdego kolejnego przedziału 10 lvl kolejne 10 x wiecej)
			}
			this.weaponPerk = "";
			this.weaponValue = 70 + (15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "bark";
			this.armorDef = 140 + (15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 5000;
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
				this.bonusHP += 3000;
				if (game.flags[kFLAGS.MINERVA_TOWER_TREE] > 0) this.bonusHP += 1150;
			}
			this.bonusLust = 100;
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				this.bonusLust += 300;
			}
			this.lust = 30;
			this.lustVuln = .04;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 99;
			this.additionalXP = 3000;
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
				this.additionalXP += 750;
			}
			this.drop = NO_DROP;
			this.gems = 1000;
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
				this.special1 = smite;
			}
			if (game.flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				this.special1 = tentacleAttack;
				this.special2 = tentacleRape;
			}
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
