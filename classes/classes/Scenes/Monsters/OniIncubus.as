/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
	
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class OniIncubus extends Monster
	{
		public function oniHypermode():void {
			if (hasStatusEffect(StatusEffects.Uber)) {
				removeStatusEffect(StatusEffects.Uber);
				if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FrozenSolid) || hasStatusEffect(StatusEffects.StunnedTornado) || hasStatusEffect(StatusEffects.Fear) || hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf) || hasStatusEffect(StatusEffects.EmbraceVampire) || hasStatusEffect(StatusEffects.Pounce)) {
					outputText(short+" reels in frustration as his concentration breaks under your assaults.\n\n");
				}
				else {
					outputText(short+" release a primal shout as he begins to rampage!!!\n\n");
					createStatusEffect(StatusEffects.Hypermode, 4, 10, 0, 0);
				}
			}
			else {
				outputText(short+" begins to slam his foot around in a weird dance causing the ground to shake as he grows in power. You have flashbacks of Izumi doing the same before and it'd be wise to interrupt it.");
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
		}
		
		public function oniPulverise():void {
			outputText(short + " suddenly closes his fist and slam you into the ground with enough strength to dig you into a hole. You're going to have some trouble freeing yourself.");
			player.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		}
		
		public function straightJab():void {
			outputText("Quick as a flash, "+short+" lashes out with his free hand, aiming for your head.");
			var damage:int = int((str + 175) - rand(player.tou) - player.armorDef);
			if (hasStatusEffect(StatusEffects.Hypermode)) damage *= 10;
			if (player.getEvasionRoll())
			{
				outputText("  You deftly dodge under the lightning-quick punch.");
			}
			else if (damage <= 0)
			{
				outputText("  You lash out and manage to deflect the blow before it can connect.");
			}
			else
			{
				outputText("  His fist connects with your chin with a mighty crack, sending you sailing across the cave. "+short+" smirks at you as you");
				if (player.isNaga()) outputText(" raise back up onto your [legs]");
				else outputText(" stand");
				outputText(" and dust yourself off. ");
				player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Uber)) {
				oniHypermode();
				return;
			}
			var choice:Number = rand(4);
			if (choice == 0) eAttack();
			if (choice == 1) straightJab();
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) eAttack();
				else oniPulverise();
			}
			if (choice == 3) {
				if (hasStatusEffect(StatusEffects.Hypermode)) straightJab();
				else oniHypermode();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.chichiScene.chichiSex6();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.chichiScene.chichiSex5();
		}
		
		public function OniIncubus() 
		{
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 4) {
				this.a = "";
				this.short = "Chon Lao";
				this.imageName = "chonlao";
				this.long = "If you thought Oni were immune to demonic corruption, Chon Lao the Ushi Oni is the proof that they are not. The man is easily 10 feet tall and just as strong, if not stronger than, Izumi. Massive horns dot his forehead, with 2 larger ones crowning the side like the head of a bull, and the massive 36 inches of man meat pulsing under his pants would scare the hell out of any normal woman. He glares at you, as if preparing to squash a bug.";
				initStrTouSpeInte(385, 275, 205, 170);
				initWisLibSensCor(170, 90, 55, 15);
				this.weaponAttack = 80;
				this.armorDef = 23;
				this.armorMDef = 16;
				this.bonusHP = 2000;
				this.level = 65;
				this.additionalXP = 300;
			}// this.plural = false;
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
			this.skinTone = "red";
			this.hairColor = "golden";
			this.hairLength = 25;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.armorName = "pants";
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = 0.33;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = 50 + rand(50);
			this.drop = new ChainedDrop().add(necklaces.OBNECK,1/5)
					.elseDrop(consumables.ONISAKE);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
			checkMonster();
		}
	}
}