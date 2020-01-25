/**
 * ...
 * @author Ormael
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
import classes.Scenes.NPCs.BashemathFollower;
import classes.internals.*;

use namespace CoC;

	public class Malikore extends Monster
	{
		public var bashemathScene:BashemathFollower = SceneLib.bashemathScene;
		
		public function moveClawCombo():void {
			createStatusEffect(StatusEffects.Attacks, 6, 0, 0, 0);
			eAttack();
		}
		
		public function moveTailSpike():void {
			TailSpike();
			TailSpike();
		}
		public function TailSpike():void {
			outputText("The malikore's tail curls over and shoots a spike at you. The bony spike ");
			if (rand(100) < (this.spe - player.spe) / 2) {
				if (player.hasStatusEffect(StatusEffects.WindWall)) {
					outputText("hits wind wall doing no damage to you.");
					player.addStatusValue(StatusEffects.WindWall,2,-1);
				}
				else {
					var tailspikedmg:Number = Math.round(this.str / 12);
					var lustdmg:Number = Math.round(this.lib / 5);
					outputText("hits the mark dealing ");
					player.takePhysDamage(tailspikedmg, true);
					outputText(" damage and poisoning you. You feel extremely aroused and ");
					if (rand(2) == 0) {
						outputText("your movements slow down");
						player.addCombatBuff('spe', -3);
					}
					else {
						if (rand(2) == 0) {
							outputText("a bit more tired");
							if (player.fatigue + 25 > player.maxFatigue()) player.fatigue = player.maxFatigue();
							else player.fatigue += 25;
						}
						else {
							outputText("your manna been sapped");
							if (player.mana < 25) player.mana = 0;
							else player.mana -= 25;
						}
					}
					outputText(". You took ");
					player.dynStats("lus", lustdmg, "scale", false);
					outputText(" <b>(<font color=\"#ff00ff\">" + lustdmg + "</font>)</b> lust damage!");
				}
			}
			else {
				outputText("misses its mark.");
			}
			outputText("\n\n");
		}
		
		public function moveTakeFlight():void {
			outputText("The malikore takes flight, aiming with her tail as she prepares to unleash a volley of spikes at you!");
			createStatusEffect(StatusEffects.Flying,7,0,0,0);
		}
		
		public function moveBoobCrash():void {
			outputText("The flying malikore dives in your direction crashing into you breasts first! For a few seconds you go red in confusion and arousal as your face is lost in her cleavage then she pulls off leaving you dazed and aroused as she readies her next attack!");
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
			outputText("The malikore bites into your ");
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
		
		public function moveCleanse():void {
			outputText("The malikore stabs herself with her tail, cleansing herself from poison!");
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
			else if (hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla)) {
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
			player.removeStatusEffect(StatusEffects.WildMalikore);
			cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.WildMalikore);
			cleanupAfterCombat();
		}
		
		override public function get long():String {
			var str:String = "";
			if (hasStatusEffect(StatusEffects.Flying)) str += "The malikore is circling you in the air readying a salvo of spike to throw at you.";
			else str += "The malikore is currently circling you looking for an opening to strike. She’s actually good on the eye and you would give her more attention if not for the fact she’s trying to beat you down and rape you.";
			return str;
		}
		
		public function Malikore() 
		{
			this.a = "the ";
			this.short = "malikore";
			this.long = "";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_LARGE + 2;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(130, 195, 330, 200);
			initWisLibSensCor(200, 230, 110, 80);
			this.weaponAttack = 54;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "skimpy black bikini";
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
					add(armors.S_SWMWR,1/12).
					add(consumables.L_DRAFT,1/4).
					add(consumables.MANTICV,0.7);
			this.wings.type = Wings.MANTICORE_LIKE_LARGE;
			this.rearBody.type = RearBody.LION_MANE;
			this.arms.type = Arms.LION;
			this.lowerBody = LowerBody.LION;
			this.tailType = Tail.MANTICORE_PUSSYTAIL;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}