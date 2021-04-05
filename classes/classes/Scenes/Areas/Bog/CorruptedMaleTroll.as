/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.Areas.Bog 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class CorruptedMaleTroll extends Monster
	{
		public function trollGrabs():void {
			outputText("The troll rushes inward, arms outstretched as he attempts to grab hold of you. ");
			if (player.getEvasionRoll()) outputText("You manage to dodge his assault.");
			else {
				outputText("You can’t dodge quickly enough as he hoists you above the ground, you are trapped within his clutches.");
				player.createStatusEffect(StatusEffects.TrollHold,0,0,0,0);
			}
			statScreenRefresh();
		}
		
		public function trollGoreWithTusks():void {
			outputText("The troll barrels towards you but he feints as he tries to gore your face with his tusks. ");
			if (player.getEvasionRoll()) outputText("You manage to avoid his tusks.");
			else {
				var damage:Number = 0;
				damage = int(((str + 60 + weaponAttack) * 1.2) - Math.random()*(player.tou) - player.armorDef);
				outputText("You are caught off guard as he cuts you, dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
				if (rand(3) == 0 && !player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			}
			statScreenRefresh();
		}
		
		public function trollPunch():void {
			outputText("The troll tumbles forward quickly. He is fast, very fast. ");
			if (player.getEvasionRoll()) outputText("You react quickly, evading his fists.");
			else {
				var damage:Number = 0;
				damage = int((str + 60 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
				outputText("You don’t have enough time to dodge as he lands a swift punch to your face dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
			}
			statScreenRefresh();
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) trollPunch();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Stunned) && rand(2) == 0) trollGoreWithTusks();
				else trollPunch();
			}
			if (choice == 2) {
				if (!player.hasStatusEffect(StatusEffects.TrollHold) && rand(2) == 0) trollGrabs();
				else trollPunch();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.trollScene.encounterAdultMaleTrollLost();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You fall to the ground, "+(player.HP <= player.minHP() ? "wounded from combat, unable to fight any longer":"your arousal has bested you")+".\n\n");
			SceneLib.trollScene.encounterAdultMaleTrollWon();
		}
		
		public function CorruptedMaleTroll() 
		{
			this.a = "the ";
			this.short = "corrupted troll (m)";
			this.imageName = "trollmale";
			this.long = "You are fighting what appears to be an corrupted troll male. He is just over 7 feet tall, covered in green fuzz and has a lithe, yet notably muscular build. He has tusks protruding from his mouth each about 8 inches long curving upwards. While most trolls are calm and relaxed, he hunches over, shaky and ready to pounce. His tail unfurls outward toward you, almost as if it were ready to pierce you. Unlike most trolls, he has fallen into corruption, which is apparent by his lusty gaze towards you. His erection pokes towards you, you can practically feel his arousal in the air as he awaits your next move, biding his time for a chance to subdue you.";
			// this.plural = false;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.createCock(9, 2, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 2;
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 84 + rand(2);
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			initStrTouSpeInte(207, 196, 189, 172);
			initWisLibSensCor(181, 143, 50, 80);
			this.weaponAttack = 60;
			this.armorDef = 60;
			this.armorMDef = 240;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "skin";
			this.hairColor = "green";
			this.hairLength = 2;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.armorName = "green fuzz";
			this.bonusHP = 350;
			this.bonusLust = 231;
			this.lust = 20;
			this.lustVuln = .7;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 38;
			this.additionalXP = 125;
			this.gems = 70 + rand(80);
			this.drop = new WeightedDrop().add(consumables.TROLFIG, 5)
					.add(consumables.HEALHERB, 2);
			this.createPerk(PerkLib.HydraRegeneration, 3, 0, 0, 0);
			this.createPerk(PerkLib.TrollResistance, 0, 0, 0, 0);
			checkMonster();
		}
	}
}