/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Etna extends Monster
	{
		public var etnaScene:EtnaFollower = SceneLib.etnaScene;
		
		public function moveClawCombo():void {
			if (flags[kFLAGS.ETNA_LVL_UP] >= 8) createStatusEffect(StatusEffects.Attacks, 4, 0, 0, 0);
			else if (flags[kFLAGS.ETNA_LVL_UP] >= 4) createStatusEffect(StatusEffects.Attacks, 3, 0, 0, 0);
			else createStatusEffect(StatusEffects.Attacks, 2, 0, 0, 0);
			eAttack();
		}
		
		public function moveTailSpike():void {
			if (flags[kFLAGS.ETNA_LVL_UP] >= 9) TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 6) TailSpike();
			if (flags[kFLAGS.ETNA_LVL_UP] >= 3) TailSpike();
			TailSpike();
		}
		public function TailSpike():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText("'s tail curls over and shoots a spike at you. The bony spike ");
			if (rand(100) < (this.spe - player.spe) / 2) {
				if (player.hasStatusEffect(StatusEffects.WindWall)) {
					outputText("hits wind wall doing no damage to you.");
					player.addStatusValue(StatusEffects.WindWall,2,-1);
				}
				else {
					var tailspikedmg:Number = Math.round(this.str / 16);
					var lustdmg:Number = Math.round(this.lib / 6);
					player.addCombatBuff('spe',-2);
					outputText("hits the mark dealing ");
					player.takePhysDamage(tailspikedmg, true);
					outputText(" damage and poisoning you. Your movements slow down and you feel extremely aroused. You took ");
					player.dynStats("lus", lustdmg, "scale", false);
					outputText(" <b>(<font color=\"#ff00ff\">" + lustdmg + "</font>)</b> lust damage!");
				}
			}
			else {
				outputText("misses its mark.");
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 3) outputText("\n\n");
		}
		
		public function moveTakeFlight():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText(" takes flight, aiming with her tail as she prepares to unleash a volley of spikes at you!");
			createStatusEffect(StatusEffects.Flying,7,0,0,0);
		}
		
		public function moveBoobCrash():void {
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna flies down");
			else outputText("The flying manticore dives");
			outputText(" in your direction crashing into you breasts first! For a few seconds you go red in confusion and arousal as your face is lost in her cleavage then she pulls off leaving you dazed and aroused as she readies her next attack!");
			var boobcrashdmg:Number = Math.round(this.str / 8);
			var lustdmg:Number = Math.round(this.lib / 3);
			player.dynStats("lus", lustdmg, "scale", false);
			outputText(" <b>(<font color=\"#ff00ff\">" + lustdmg + "</font>)</b>");
			player.takePhysDamage(boobcrashdmg, true);
			player.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			removeStatusEffect(StatusEffects.Flying);
		}
		
		public function moveBite():void {
			var bitedmg:Number = Math.round(this.str / 25);
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) outputText("Etna");
			else outputText("The manticore");
			outputText(" bites into your ");
			if (hasStatusEffect(StatusEffects.Pounce)) outputText("arm");
			else if (player.lowerBody == 26) outputText("tentacle");
			else outputText("tail");
			outputText(" making you yelp in surprise. She breaks out of the grapple grinning. You took ");
			player.takePhysDamage(bitedmg, true);
			outputText(" damage!");
			if (hasStatusEffect(StatusEffects.Constricted)) removeStatusEffect(StatusEffects.Constricted);
			if (hasStatusEffect(StatusEffects.ConstrictedScylla)) removeStatusEffect(StatusEffects.ConstrictedScylla);
			if (hasStatusEffect(StatusEffects.Pounce)) removeStatusEffect(StatusEffects.Pounce);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla)) {
				moveBite();
			}
			else if (statusEffectv1(StatusEffects.Flying) == 3) {
				moveBoobCrash();
			}
			else if (hasStatusEffect(StatusEffects.Flying)) {
				moveTailSpike();
			}
			else {
				var choice:Number = rand(10);
				if (choice < 5) moveClawCombo();
				if (choice > 4 && choice < 8) moveTailSpike();
				if (choice > 7) moveTakeFlight();
			}
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
		
		override public function get long():String {
			var str:String = "";
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) {
				if (hasStatusEffect(StatusEffects.Flying)) str += "Etna is circling you in the air readying a salvo of spike to throw at you.";
				else str += "Etna is currently circling you looking for an opening to strike. She’s actually good on the eye and you would give her more attention if not for the fact she’s trying to beat you down and rape you.";
			}
			else {
				if (hasStatusEffect(StatusEffects.Flying)) str += "The manticore is circling you in the air readying a salvo of spike to throw at you.";
				else str += "The manticore is currently circling you looking for an opening to strike. She’s actually good on the eye and you would give her more attention if not for the fact she’s trying to beat you down and rape you.";
			}
			return str;
		}
		
		public function Etna() 
		{
			if (game.flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Etna";
				this.long = "";
			}
			else {
				this.a = "the ";
				this.short = "manticore";
				this.long = "";
			}
			if (flags[kFLAGS.ETNA_LVL_UP] < 1) {
				initStrTouSpeInte(100, 150, 240, 170);
				initWisLibSensCor(170, 170, 80, 80);
				this.weaponAttack = 36;
				this.armorDef = 10;
				this.armorMDef = 2;
				this.bonusHP = 100;
				this.level = 30;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 1) {
				initStrTouSpeInte(110, 165, 270, 180);
				initWisLibSensCor(180, 190, 90, 80);
				this.weaponAttack = 42;
				this.armorDef = 12;
				this.armorMDef = 2;
				this.bonusHP = 150;
				this.level = 36;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 2) {
				initStrTouSpeInte(120, 180, 300, 190);
				initWisLibSensCor(190, 210, 100, 80);
				this.weaponAttack = 48;
				this.armorDef = 14;
				this.armorMDef = 2;
				this.bonusHP = 150;
				this.level = 42;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 3) {
				initStrTouSpeInte(130, 195, 330, 200);
				initWisLibSensCor(200, 230, 110, 80);
				this.weaponAttack = 54;
				this.armorDef = 16;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.level = 48;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 4) {
				initStrTouSpeInte(140, 210, 360, 210);
				initWisLibSensCor(210, 250, 120, 80);
				this.weaponAttack = 60;
				this.armorDef = 18;
				this.armorMDef = 3;
				this.bonusHP = 200;
				this.level = 54;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 5) {
				initStrTouSpeInte(150, 225, 390, 220);
				initWisLibSensCor(220, 270, 130, 80);
				this.weaponAttack = 66;
				this.armorDef = 20;
				this.armorMDef = 4;
				this.bonusHP = 250;
				this.level = 60;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 6) {
				initStrTouSpeInte(160, 240, 420, 230);
				initWisLibSensCor(230, 290, 140, 80);
				this.weaponAttack = 72;
				this.armorDef = 22;
				this.armorMDef = 4;
				this.bonusHP = 250;
				this.level = 66;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 7) {
				initStrTouSpeInte(170, 255, 450, 240);
				initWisLibSensCor(240, 310, 150, 80);
				this.weaponAttack = 78;
				this.armorDef = 24;
				this.armorMDef = 5;
				this.bonusHP = 300;
				this.level = 72;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 8) {
				initStrTouSpeInte(180, 270, 480, 250);
				initWisLibSensCor(250, 330, 160, 80);
				this.weaponAttack = 84;
				this.armorDef = 26;
				this.armorMDef = 6;
				this.bonusHP = 300;
				this.level = 78;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 9) {
				initStrTouSpeInte(190, 285, 510, 260);
				initWisLibSensCor(260, 350, 170, 80);
				this.weaponAttack = 90;
				this.armorDef = 28;
				this.armorMDef = 7;
				this.bonusHP = 400;
				this.level = 84;
			}
			if (flags[kFLAGS.ETNA_LVL_UP] == 10) {
				initStrTouSpeInte(200, 300, 540, 270);
				initWisLibSensCor(270, 370, 180, 80);
				this.weaponAttack = 96;
				this.armorDef = 30;
				this.armorMDef = 8;
				this.bonusHP = 400;
				this.level = 90;
			}
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 13;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "skimpy black bikini";
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
					add(armors.S_SWMWR,1/12).
					add(consumables.L_DRAFT,1/4).
					add(consumables.MANTICV,0.7);
			this.wings.type = Wings.MANTICORE_LIKE_LARGE;
			this.rearBody.type = RearBody.LION_MANE;
			this.arms.type = Arms.LION;
			this.lowerBody = LowerBody.LION;
			this.tailType = Tail.MANTICORE_PUSSYTAIL;
			this.tailRecharge = 0;
			if (flags[kFLAGS.ETNA_FOLLOWER] > 1 || flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 1) this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 2) this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 3) this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 4) this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 6) this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 7) this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.HalfStepToPeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ETNA_LVL_UP] >= 9) this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 10) this.createPerk(PerkLib.HalfStepToInhumanSelfControl, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}