/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	use namespace kGAMECLASS;
	
	public class Etna extends Monster 
	{
		public var etnaScene:EtnaFollower = new EtnaFollower();
		
		public function moveClawCombo():void {
			createStatusAffect(StatusAffects.Attacks,2,0,0,0);
			eAttack();
		}
		
		public function moveTailSpike():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText("'s tail curls over and shoots a spike at you. ");
			if (rand(100) < (this.spe - player.spe) / 2) {
				var tailspikedmg:Number = Math.round(this.str / 16);
				var lustdmg:Number = Math.round(this.lib / 6);
				if (player.findStatusAffect(StatusAffects.BasiliskSlow) >= 0) {
					player.addStatusValue(StatusAffects.BasiliskSlow, 1, 2);
					player.spe -= 2;
				}
				else {
					player.createStatusAffect(StatusAffects.BasiliskSlow, 3, 0, 0, 0);
					player.spe -= 3;
				}
				showStatDown( 'spe' );
				outputText("The bony spike hits the mark dealing ");
				player.takeDamage(tailspikedmg, true);
				outputText(" damage and poisoning you. Your movements slow down and you feel extremely aroused. ");
				game.dynStats("lus", lustdmg, "resisted", false);
				outputText(" <b>(<font color=\"#ff00ff\">" + lustdmg + "</font>)</b>");
			}
			else {
				outputText("The bony spike miss the mark.");
			}
		}
		
		public function moveTakeFlight():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText(" takes flight aiming with her tail as she prepare to unleash a volley of spikes at you!");
			createStatusAffect(StatusAffects.Flying,7,0,0,0);
		}
		
		public function moveBoobCrash():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna fly down");
			else outputText("The flying manticore dive");
			outputText(" in your direction crashing into you breast first! For a few seconds you go red in confusion and arousal as your face is lost in her cleavage then she pulls off leaving you dazed and aroused as she ready her next attack!");
			var boobcrashdmg:Number = Math.round(this.str / 8);
			var lustdmg:Number = Math.round(this.lib / 3);
			game.dynStats("lus", lustdmg, "resisted", false);
			outputText(" <b>(<font color=\"#ff00ff\">" + lustdmg + "</font>)</b>");
			player.takeDamage(boobcrashdmg, true);
			player.createStatusAffect(StatusAffects.Stunned,1,0,0,0);
			removeStatusAffect(StatusAffects.Flying);
		}
		
		public function moveBite():void {
			var bitedmg:Number = Math.round(this.str / 25);
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText(" bites into your ");
			if (player.lowerBody == 26) outputText("tentacle");
			else outputText("tail");
			outputText(" making you yelp in surprise. She breaks out of the grapple grinning. You took ");
			player.takeDamage(bitedmg, true);
			outputText(" damage!");
			if (findStatusAffect(StatusAffects.Constricted) >= 0) removeStatusAffect(StatusAffects.Constricted);
			if (findStatusAffect(StatusAffects.ConstrictedScylla) >= 0) removeStatusAffect(StatusAffects.ConstrictedScylla);
		}
		
		override protected function performCombatAction():void
		{
			if (findStatusAffect(StatusAffects.Constricted) >= 0 || findStatusAffect(StatusAffects.ConstrictedScylla) >= 0) {
				moveBite();
			}
			else if (statusAffectv1(StatusAffects.Flying) == 3) {
				moveBoobCrash();
			}
			else if (findStatusAffect(StatusAffects.Flying) >= 0) {
				moveTailSpike();
			}
			else {
				var choice:Number = rand(10);
				if (choice < 5) moveClawCombo();
				if (choice > 4 && choice < 8) moveTailSpike();
				if (choice > 7) moveTakeFlight();
			}
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.ETNA_FOLLOWER] >= 2) etnaScene.etnaRapeIntro2();
			else if (flags[kFLAGS.ETNA_AFFECTION] > 75) etnaScene.etnaReady2Come2Camp();
			else if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] < 1 && flags[kFLAGS.ETNA_AFFECTION] > 15) etnaScene.etnaRape3rdWin();
			else etnaScene.etnaRapeIntro();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2) etnaScene.etnaRapeYandere();
			etnaScene.etnaRapesPlayer();
		}
		
		public function Etna() 
		{
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Etna";
				if (findStatusAffect(StatusAffects.Flying) >= 0) this.long = "Etna is circling you in the air readying a salvo of spike to throw at you.";
				else this.long = "Etna is currently circling you looking for an oppening to strike. She's actualy good on the eye and you would give her body more attention if not for the fact she's trying to beat you down and rape you.";
			}
			else {
				this.a = "the ";
				this.short = "manticore";
				if (findStatusAffect(StatusAffects.Flying) >= 0) this.long = "The manticore is circling you in the air readying a salvo of spike to throw at you.";
				else this.long = "The manticore is currently circling you looking for an oppening to strike. She's actualy good on the eye and you would give her body more attention if not for the fact she's trying to beat you down and rape you.";
			}
			createVagina(true,VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_TIGHT);
			this.createStatusAffect(StatusAffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusAffect(StatusAffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hipRating = HIP_RATING_CURVY+2;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(100, 150, 240, 170);
			initLibSensCor(170, 80, 80);
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 36 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "skimpy black bikini";
			this.armorDef = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
					add(armors.S_SWMWR,1/12).
					add(consumables.L_DRAFT,1/4).
					add(consumables.MANTICV,0.7);
			this.wingType = WING_TYPE_MANTICORE_LIKE_LARGE;
			this.rearBody = REAR_BODY_LION_MANE;
			this.armType = ARM_TYPE_LION;
			this.lowerBody = LOWER_BODY_TYPE_LION;
			this.tailType = TAIL_TYPE_MANTICORE_PUSSYTAIL;
			this.tailRecharge = 0;
			if (flags[kFLAGS.ETNA_FOLLOWER] > 1 || flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 72 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 51 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 51 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 9960;
			checkMonster();
		}
		
	}

}