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

	public class CorruptedFemaleTroll extends Monster
	{
		public function femaleTrollPassive():void {
			outputText("Her pheromone cloud is getting to you, causing your manhood to stiffen with each passing moment, if you don’t finish this quickly you’ll eventually cave in! ");
			var passivelust:Number = (lib / 6) + rand(8);
			passivelust = Math.round(passivelust);
			player.dynStats("lus", passivelust, "scale", false);
			statScreenRefresh();
		}
		
		public function femaleTrollGoreWithTusks():void {
			outputText("The troll barrels towards you but she feints as she tries to gore your face with her tusks. ");
			if (player.getEvasionRoll()) outputText("You manage to avoid her tusks.");
			else {
				var damage:Number = 0;
				damage = int(((str + 60 + weaponAttack) * 1.2) - Math.random()*(player.tou) - player.armorDef);
				outputText("You are caught off guard as she cuts you, dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
				if (rand(3) == 0 && !player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			}
			statScreenRefresh();
		}
		
		public function femaleTrollPunch():void {
			outputText("The troll tumbles forward quickly. She is fast, very fast. ");
			if (player.getEvasionRoll()) outputText("You react quickly, evading her fists.");
			else {
				var damage:Number = 0;
				damage = int((str + 60 + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
				outputText("You don’t have enough time to dodge as she lands a swift punch to your face dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
			}
			statScreenRefresh();
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice < 2) femaleTrollPunch();
			if (choice == 2) {
				if (!player.hasStatusEffect(StatusEffects.Stunned) && rand(2) == 0) femaleTrollGoreWithTusks();
				else femaleTrollPunch();
			}
			if (player.hasCock()) femaleTrollPassive();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.trollScene.encounterAdultFemaleTrollLost();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You fall to the ground, "+(player.HP <= player.minHP() ? "wounded from combat, unable to fight any longer":"your arousal has bested you")+".\n\n");
			SceneLib.trollScene.encounterAdultFemaleTrollWon();
		}
		
		public function CorruptedFemaleTroll() 
		{
			this.a = "the ";
			this.short = "corrupted troll (f)";
			this.imageName = "trollfemale";
			this.long = "You are fighting what appears to be an corrupted troll female. She is nearly 7 feet tall, covered in green fuzz and has a lithe, yet slightly muscular build. She has tusks protruding from her mouth each about 5 inches long curving upwards. While most trolls are calm and relaxed, she hunches over, shaky and ready to pounce. Unlike most trolls, she has fallen into corruption, which is apparent by her lusty gaze towards you. She is completely naked. She sticks her tongue out tauntingly, her arousal is dense as her pheromones coat the air, almost blinding you with her lusty aura.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 80 + rand(2);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			initStrTouSpeInte(200, 191, 183, 179);
			initWisLibSensCor(189, 147, 50, 80);
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
			this.bonusLust = 235;
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