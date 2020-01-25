/**
 * ...
 * @author Ormael & Redcake
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
//import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class Pierce extends Monster
	{
		public function moveClawCombo():void {
			createStatusEffect(StatusEffects.Attacks, 6, 0, 0, 0);
			eAttack();
		}
		
		public function moveCleanse():void {
			outputText("The malikore stabs himself with his tail, cleansing himself from poison!");
			if (hasStatusEffect(StatusEffects.PoisonDoT)) removeStatusEffect(StatusEffects.PoisonDoT);
			if (hasStatusEffect(StatusEffects.PoisonDoTH)) removeStatusEffect(StatusEffects.PoisonDoTH);
			if (hasStatusEffect(StatusEffects.LustDoT)) removeStatusEffect(StatusEffects.LustDoT);
			if (hasStatusEffect(StatusEffects.LustDoTH)) removeStatusEffect(StatusEffects.LustDoTH);
		}
		
		override protected function performCombatAction():void
		{
			if (!monsterIsStunned() && (hasStatusEffect(StatusEffects.PoisonDoT) || hasStatusEffect(StatusEffects.PoisonDoTH) || hasStatusEffect(StatusEffects.LustDoT) || hasStatusEffect(StatusEffects.LustDoTH))) {
				moveCleanse();
			}
			else {
				moveClawCombo();
				//var choice:Number = rand(10);
				//if (choice < 5) moveClawCombo();
				//if (choice > 4 && choice < 8) moveTailSpike();
				//if (choice > 7) moveTakeFlight();
			}
		}
		
		override public function get long():String {
			var str:String = "";
			if (hasStatusEffect(StatusEffects.Flying)) str += "The malikore is circling you in the air readying a salvo of spike to throw at you.";
			else str += "The malikore is currently circling you looking for an opening to strike. He’s actually good on the eye and you would give him more attention if not for the fact he’s trying to beat you down and rape you.";
			return str;
		}
		
		public function Pierce() 
		{
			this.a = "the ";
			this.short = "alpha malikore";
			this.long = "";
			this.createCock(36,7);
			this.createCock(36,7);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 120;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(130, 195, 330, 200);
			initWisLibSensCor(200, 230, 110, 80);
			this.weaponAttack = 54;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "black shorts";
			this.armorDef = 16;
			this.armorMDef = 3;
			this.bonusHP = 200;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 39;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
					add(armors.S_SWMWR,1/12).//inne coś
					add(consumables.L_DRAFT,1/4).
					add(consumables.MANTICV,0.7);
			this.wings.type = Wings.MANTICORE_LIKE_LARGE;
			this.rearBody.type = RearBody.LION_MANE;
			this.arms.type = Arms.LION;
			this.lowerBody = LowerBody.LION;
			//this.tailType = Tail.MANTICORE_PUSSYTAIL;
			//this.tailRecharge = 0;
			this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}