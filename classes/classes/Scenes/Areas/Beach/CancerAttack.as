/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Beach
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.CombatUI;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

import coc.view.CoCButton;

public class CancerAttack extends Monster
	{
		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.CancerMonsterGrab)) {
				btnStruggle.call(cancerGrabStruggle);
				btnBoundWait.call(cancerGrabWait);
			}
		}
		override protected function performCombatAction():void {
			if (player.hasStatusEffect(StatusEffects.MonsterDig)) {
				if (player.statusEffectv1(StatusEffects.MonsterDig) > 0) {
					CancerWait();
				}
				else if (player.statusEffectv1(StatusEffects.MonsterDig) == 0) {
					Grab();
				}
			} else if (player.hasStatusEffect(StatusEffects.CancerMonsterGrab)) {
				Guillotine();
			} else {
				var choiceList:Array = [Dig,Dig];
				if (!player.isFlying()) choiceList.push(Slam,Slam,Slam,Slam,Slam);
				if (!player.hasStatusEffect(StatusEffects.Blind)) choiceList.push(BubbleSplash,BubbleSplash);
				var choice:Function = randomChoice(choiceList);
				choice();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.beach.cancerScene.defeat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
            SceneLib.beach.cancerScene.rape();
		}

		private function Dig():void {
			if (this.hasStatusEffect(StatusEffects.AlrauneEntangle))
				outputText("The cancer would love to dig a path away from you but is currently entangled in your vines!");
			else{
				outputText("The cancer digs [monster his] way underground, disappearing from view.");
				if (!player.hasStatusEffect(StatusEffects.MonsterDig)) player.createStatusEffect(StatusEffects.MonsterDig, 1 + rand(3), 0, 0, 0);
				if (!player.hasStatusEffect(StatusEffects.MonsterInvisible)) player.createStatusEffect(StatusEffects.MonsterInvisible, 0, 0, 0, 0);
			}
		}

		private function Grab():void {
			if (Combat.playerWaitsOrDefends()){
				outputText("By observing your environment and staying alert, you manage to dodge just in time as the pincer digs its way back up from under you. \n\n");
			} else if (player.isFlying()) {
				outputText("You can’t help but chuckle at the cancer's futile attempts to ambush you from beneath, simply flying well out of its reach. You taunt [monster him] still chuckling.\n\n" +
						"<i>\"Hey, idiot! How do you plan to dig under and surprise that which does not even touch the ground!\"</i>\n\n");
			} else {
				outputText("The Cancer surges out of the sand beneath you, grabbing you in its pincer as [monster he] flatly adds.\n\n" +
						"<i>\"Gotcha… You struggled, I don’t like it when they struggle, so I will crush you until you stop struggling.\"</i>\n\n");
				player.createStatusEffect(StatusEffects.CancerMonsterGrab, 2 + rand(5), 0, 0, 0);
			}
			player.removeStatusEffect(StatusEffects.MonsterDig);
			player.removeStatusEffect(StatusEffects.MonsterInvisible);
		}

		private function CancerWait():void {
			outputText("You hear the soil grumbling as your opponent dig around underground.");
			player.addStatusValue(StatusEffects.MonsterDig, 1, -1);
		}

		//(Struggle)
		public function cancerGrabStruggle():void {
			clearOutput();
			if ((player.statusEffectv1(StatusEffects.CancerMonsterGrab) - 1 <= 0) || player.hasPerk(PerkLib.FluidBody)) {
				outputText("You manage to break out of the cancer death grip still gasping for air.");
				player.removeStatusEffect(StatusEffects.CancerMonsterGrab);
				//return;
			} else {
				outputText("You struggle to break out of the cancer grip to no result.");
				player.addStatusValue(StatusEffects.CancerMonsterGrab, 1, -1);
			}
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
		}

		//(Wait)
		public function cancerGrabWait():void {
			clearOutput();
			outputText("Why bother resisting?  Theres no way you can escape this iron grip anyway.");
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
		}

		private function Guillotine():void {
			var damage:Number = rand(weaponAttack);
			outputText("The cancer begins to crush you inside [monster his] pincers. It hurts!! You can almost hear your bones breaking!");
			damage += eBaseStrengthDamage() * 2;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			statScreenRefresh();
		}

		private function Slam():void {
			var damage:Number = rand(weaponAttack)
			outputText("The cancer slams [monster his] giant pincer on you like a hammer.");
			damage += eBaseStrengthDamage() * 2;
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			statScreenRefresh();
		}

		private function BubbleSplash():void {
			if (this.hasVagina()) outputText("The cancer gasps in pleasure as her mandibles open, revealing her pussy. Out of nowhere, she suddenly splashes you right in the face with a powerful gushing jet of foaming juices. <b>You’re blinded!</b>\n\n");
			if (this.hasCock()) outputText("The cancer gasps in pleasure as his mandibles open, revealing his cock. Out of nowhere, he suddenly splashes you right in the face with a powerful gushing jet of foaming juices. <b>You’re blinded!</b>\n\n");
			player.createStatusEffect(StatusEffects.Blind, 6, 0, 0, 0);
		}
		
		public function CancerAttack(IsFemale:Boolean)
		{
			this.a = "the ";
			this.short = "cancer";
			this.imageName = "cancer";
			this.long= "You are fighting a cancer, a centaur-like creature with the upper body of a human and the lower body of a large crab. " +
					"Its pincers stand at the ready, looking for the opportunity for a swift and likely fatal grapple. " +
					"While your opponent's torso is mostly bare, it’s obvious the crab part is sturdier than any steel plating. " +
					"The creepiest thing about all of this is that "+(IsFemale ? "her":"his")+" facial expression seems frozen in a constant blank state.";
			if (IsFemale) {
				this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
				this.createBreastRow(1);
			}
			if (!IsFemale)
			{
				this.createBreastRow(0);
				this.createCock(7.5,1,CockTypesEnum.CANCER)
				this.balls = 2;
				this.ballSize = 1;
				this.cumMultiplier = 3;
			}
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "light";
			this.hairColor = "pale brown";
			this.hairLength = 15;
			initStrTouSpeInte(167, 185, 149, 42);
			initWisLibSensCor(41, 144, 82, -40);
			this.weaponName = "pincers";
			this.weaponVerb="pincer";
			this.weaponAttack = 69;
			this.armorName = "chitin";
			this.armorDef = 90;
			this.armorMDef = 10;
			this.bonusHP = 200;
			this.bonusLust = 263;
			this.lust = 30;
			this.level = 37;
			this.gems = rand(40)+40;
			this.drop = new WeightedDrop().addMany(1, consumables.BUBBLEG);
			this.tailType = Tail.NONE;
			checkMonster();
		}
		
	}

}
