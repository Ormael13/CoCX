package classes.Scenes.Areas.Desert
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;
import classes.internals.*;

import coc.view.CoCButton;

public class SandWorm extends Monster
	{

		private function Sting():void {
			outputText("The sand worm stinger surges from the sands beneath you.");
			if (player.getEvasionRoll()) {
				outputText("You manage to roll out of the way just in time[if (hasarmor), the stinger scraping against your [armor]].");
			} else {
				outputText(" You are mercilessly stung by the spear sized appendage! Ugh just as you though it couldn't get worse, you begin feeling weak as the worm deadly venom saps your strength.");
				var dmg1:Number = this.inte * 0.2;
				dmg1 += eBaseIntelligenceDamage() * 0.2;
				dmg1 = Math.round(dmg1);
				dmg1 = player.takeAcidDamage(dmg1, true);
				if (!player.immuneToAcid()) {
					if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 1, 1);
					else player.createStatusEffect(StatusEffects.AcidDoT, 5, 10, 0, 0);
				}
			}
		}

		private function Bite():void {
			outputText("The sandworm lunges forward and attempts to bites you.");
			if (player.getEvasionRoll()) {
				outputText(" You narrowly manage to dodge to the side as the sandworm goes ploughing through the spot where you stood, leaving a trail of spittle on the sand which starts smoking.");
			} else {
				outputText(" Its bite is about as vicious as expected, if not worse as the worm's corrosive acids begins its nasty work.");
				var dmg1:Number = this.inte * 0.2;
				dmg1 += eBaseIntelligenceDamage() * 0.2;
				dmg1 = Math.round(dmg1);
				dmg1 = player.takeAcidDamage(dmg1, true);
				if (!player.immuneToAcid()) {
					if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 2, 1);
					else player.createStatusEffect(StatusEffects.AcidDoT, 5, 10, 0, 0);
				}
			}
		}

		private function Dig():void {
			if (this.hasStatusEffect(StatusEffects.AlrauneEntangle))
				outputText("The sand worm would love to dig a path away from you but is currently entangled in your vines!");
			else{
				outputText("The sandworm vanishes underground, no doubt tunneling to a new position to surprise you.");
				if (!player.hasStatusEffect(StatusEffects.MonsterDig)) player.createStatusEffect(StatusEffects.MonsterDig, 1 + rand(3), 0, 0, 0);
				if (!player.hasStatusEffect(StatusEffects.MonsterInvisible)) player.createStatusEffect(StatusEffects.MonsterInvisible, 0, 0, 0, 0);
			}
		}

		private function SandWormWait():void {
			outputText("You hear the soil grumbling as your opponent dig around underground.");
			player.addStatusValue(StatusEffects.MonsterDig, 1, -1);
		}

		private function Resurface():void {
			outputText("The sandworm resurfaces and sucks in great gulps of air.");
			player.removeStatusEffect(StatusEffects.MonsterDig);
		}

		private function Devour():void {
			outputText("The worm leaps out the ground next to you, its maw wide open as it plunges to take you in. ")
			if (Combat.playerWaitsOrDefends()){
				outputText("By observing your environment and staying alert, you manage to dodge just in time as the great worm plunges back into the sands. \n\n");
			} else if (player.isFlying()) {
				if (rand(3) == 0) {
					outputText("Surprising you, the sand worm surges even higher, swallowing you where you hover before you even have the chance to react!\n\n")
					player.createStatusEffect(StatusEffects.Devoured, 2 + rand(5), 0, 0, 0);
				} else {
					outputText("You can’t help but chuckle at the sand worm's futile attempts to ambush you from beneath, simply flying way out of its reach. You taunt [monster him] still chuckling.\n\n" +
							"<i>\"Hey, idiot! How do you plan to dig under and surprise that which does not even touch the ground!\"</i>\n\n");
				}
			} else {
				outputText("Unable to dodge in time you are swallowed whole and dragged in for the ride!\n\n");
				player.createStatusEffect(StatusEffects.Devoured, 2 + rand(5), 0, 0, 0);
			}
			player.removeStatusEffect(StatusEffects.MonsterDig);
			player.removeStatusEffect(StatusEffects.MonsterInvisible);
		}

		//(Struggle)
		public function sandWormDevourStruggle():void {
			clearOutput();
			if ((player.statusEffectv1(StatusEffects.Devoured) - 1 <= 0) || (rand(10) > 0 && player.str100/5 + rand(20) < 23)) {
				outputText("Desperately punching around to get free from the fleshy tentacle hell that is the insides of the sand worm, you finally strikes a weak spot forcing it to spit you out as it contorts from the discomfort. ");
				player.removeStatusEffect(StatusEffects.Devoured);
				//return;
			} else if (player.hasPerk(PerkLib.FluidBody)) {
				outputText("Thanks to your fluid body you manage to slip free from the tentacles and squirm toward the mouth hole but are unable to leave because the worm is burrowing underground. Dismayed, the tentacles find you and once again drag you deeper inside. ");
			} else {
				outputText("You struggle to break free from the sand worm's maw but fail to have any effect.");
				player.addStatusValue(StatusEffects.Devoured, 1, -1);
			}
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
		}

		private function devourTease():void {
			outputText("The many fleshy tentacles lining the sand worm's inner walls slither around you, seeking out and caressing your vulnerable endowments as they insidiously try to draw you closer to cumming. ");
			player.takeLustDamage(this.lib/3 + rand(200) + player.lib/5, true);
		}

		//(Wait)
		public function sandWormDevourWait():void {
			clearOutput();
			outputText("Why bother resisting?  Theres no way you can escape this fleshy grip anyway.\n\n");
			player.addStatusValue(StatusEffects.Devoured, 1, -1);
			SceneLib.combat.enemyAIImpl();
		}

		public function Tremor():void {
			clearOutput();
			if (player.isFlying()) {
				outputText("The ground quakes but you are high up in the air out of reach.\n\n");
			} else {
				outputText("The ground quakes sending you to the ground.\n\n");
				player.takePhysDamage(eBaseToughnessDamage(), true);
				if(rand(4) == 0) {
					if (player.hasPerk(PerkLib.Resolute))
						outputText("You manage to rise to your feet quickly thanks to your incredible battle focus.");
					else {
						player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
						outputText("<b>You are stunned!</b>  ");
					}
				}
			}
			player.addStatusValue(StatusEffects.MonsterDig, 1, -1);
		}

		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.Devoured)) {
				btnStruggle.call(sandWormDevourStruggle);
				btnBoundWait.call(sandWormDevourWait);
			}
		}

		override protected function performCombatAction():void
		{
			if (player.hasStatusEffect(StatusEffects.MonsterDig)) {
				if (player.statusEffectv1(StatusEffects.MonsterDig) > 0) {
					if (rand(3) == 0)
						Tremor();
					else SandWormWait();
				}
				else if (player.statusEffectv1(StatusEffects.MonsterDig) == 0) {
					if (player.tallness < (11*12))
						Devour();
					else Resurface();
				}
			} else if (player.hasStatusEffect(StatusEffects.Devoured)) {
				devourTease();
				if (player.statusEffectv1(StatusEffects.Devoured) == 0) {
					outputText("\nThe sand worm finally rises to the surface to breathe, and spits you out.\n");
					player.removeStatusEffect(StatusEffects.Devoured)
				}
			} else {
				var actionChoices:WeightedAction = new WeightedAction()
						.add(Dig, 40)
						.add(Bite, 40)
						.add(Sting, 30)
						.add(eAttack, 20);

				actionChoices.exec();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.desert.sandWormScene.beatSandWorm();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.desert.sandWormScene.loseToSandWorm();
		}

		public function SandWorm()
		{
			this.a = "the ";
			this.short = "sand worm";
			this.long = "You are fighting one of the dreaded sand worms. A calamity in its own this right, massive creature can swallow a cart, horse and rider whole in one chomp, not to mention its hardened chitin armor and deadly poison stinger, you're in for one hell of a fight! Most of its body is always underground even when the head isn't.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.tallness = 15*12;
			this.bodyColor = "light pink";
			this.hairColor = "pink";
			this.hairLength = 15;
			this.lowerBody = LowerBody.SANDWORM;
			initStrTouSpeInte(450, 420, 190, 190);
			initWisLibSensCor(150, 450, 245, 0);
			this.weaponName = "body";
			this.weaponVerb="slam";
			this.weaponAttack = 300;
			this.armorName = "chitin";
			this.armorDef = 1000;
			this.armorMDef = 100;
			this.bonusHP = 2000;
			this.bonusLust = 752;
			this.lust = 80;
			this.lustVuln = .60;
			this.level = 57;
			this.gems = 5 + rand(5);
			this.drop = new ChainedDrop(consumables.OVIELIX);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
