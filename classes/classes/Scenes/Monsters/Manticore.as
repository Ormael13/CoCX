/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.Scenes.NPCs.EtnaFollower;
import classes.internals.*;

use namespace CoC;

	public class Manticore extends Monster
	{
		public var etnaScene:EtnaFollower = SceneLib.etnaScene;
		
		public function moveClawCombo():void {
			createStatusEffect(StatusEffects.Attacks, 2, 0, 0, 0);
			eAttack();
		}
		
		public function moveTailSpike():void {
			outputText("The manticore's tail curls over and shoots a spike at you. The bony spike ");
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
		}
		
		public function moveTakeFlight():void {
			outputText("The manticore takes flight, aiming with her tail as she prepares to unleash a volley of spikes at you!");
			createStatusEffect(StatusEffects.Flying,7,0,0,0);
		}
		
		public function moveBoobCrash():void {
			outputText("The flying manticore dives in your direction crashing into you breasts first! For a few seconds you go red in confusion and arousal as your face is lost in her cleavage then she pulls off leaving you dazed and aroused as she readies her next attack!");
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
			outputText("The manticore bites into your ");
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
			etnaScene.etnaRapeIntro();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			etnaScene.etnaRapesPlayer();
		}
		
		override public function get long():String {
			var str:String = "";
			if (hasStatusEffect(StatusEffects.Flying)) str += "The manticore is circling you in the air readying a salvo of spike to throw at you.";
			else str += "The manticore is currently circling you looking for an opening to strike. She’s actually good on the eye and you would give her more attention if not for the fact she’s trying to beat you down and rape you.";
			return str;
		}
		
		public function Manticore() 
		{
			this.a = "the ";
			this.short = "manticore";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,50,0,0,0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,15,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 1;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(100, 150, 240, 170);
			initWisLibSensCor(170, 170, 80, 80);
			this.weaponAttack = 36;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "skimpy black bikini";
			this.armorDef = 10;
			this.armorMDef = 2;
			this.bonusHP = 100;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 30;
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
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}