/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.Areas.GlacialRift 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class GlacialFemaleTroll extends Monster
	{
		public function femaleGlacialTrollClawsRend():void {
			outputText("She charges at you with her claws ");
			if (player.getEvasionRoll()) outputText("but you manage to avoid her attack.");
			else {
				var damage:Number = 0;
				damage = int(((str + 100 + weaponAttack) * 1.5) - Math.random()*((player.tou/2)));
				outputText("she slices through you [armor], rending your flesh viciously. ");
				damage = player.takePhysDamage(damage, true);
			}
			statScreenRefresh();
		}
		
		public function femaleGlacialTrollGoreWithTusks():void {
			outputText("The troll barrels towards you but she feints as she tries to gore your face with her tusks. ");
			if (player.getEvasionRoll()) outputText("You manage to avoid her tusks.");
			else {
				var damage:Number = 0;
				damage = int(((str + 100 + weaponAttack) * 2) - Math.random()*(player.tou) - player.armorDef);
				outputText("You are caught off guard as she cuts you, dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
				if (rand(3) == 0 && !player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			}
			statScreenRefresh();
		}
		
		public function femaleGlacialTrollPunch():void {
			outputText("The troll tumbles forward quickly. She is fast, very fast. ");
			if (player.getEvasionRoll()) outputText("You react quickly, evading her fists.");
			else {
				var damage:Number = 0;
				damage = int(((str + 100 + weaponAttack) * 1.5) - Math.random()*(player.tou) - player.armorDef);
				outputText("You don’t have enough time to dodge as she lands a swift punch to your face dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
			}
			statScreenRefresh();
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) femaleGlacialTrollPunch();
			if (choice == 1) femaleGlacialTrollClawsRend();
			if (choice == 2) {
				if (!player.hasStatusEffect(StatusEffects.Stunned) && rand(2) == 0) femaleGlacialTrollGoreWithTusks();
				else femaleGlacialTrollPunch();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.trollScene.encounterAdultGlacialFemaleTrollLost();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You fall to the ground, "+(player.HP <= player.minHP() ? "wounded from combat, unable to fight any longer":"your arousal has bested you")+".\n\n");
			SceneLib.trollScene.encounterAdultGlacialFemaleTrollWon();
		}
		
		public function GlacialFemaleTroll() 
		{
			this.a = "the ";
			this.short = "glacial troll female";
			this.imageName = "glacialtrollfemale";
			this.long = "You are fighting what appears to be an glacial troll female. She is nearly 9 feet tall, covered in white hair and has a bit of heft to her weight, but she seemingly remains very agile. She has tusks protruding from her mouth each about 5 inches long curving upwards. Like all ice trolls, her hands and feet end in sharp claws ready to grip and tear through anything. She is wearing fur armor that conceals the most of her body.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 104 + rand(2);
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			initStrTouSpeInte(400, 382, 366, 358);
			initWisLibSensCor(378, 294, 100, 15);
			this.weaponAttack = 120;
			this.armorDef = 150;
			this.armorMDef = 600;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "skin";
			this.hairColor = "white";
			this.hairLength = 2;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.armorName = "white fuzz";
			this.bonusHP = 2500;
			this.bonusLust = 488;
			this.lust = 20;
			this.lustVuln = .7;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 94;
			this.additionalXP = 1500;
			this.gems = 250 + rand(50);
			this.drop = new WeightedDrop().add(consumables.ICY_FIG, 5)
					.add(consumables.HEALHERB, 2);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.HydraRegeneration, 3, 0, 0, 0);
			this.createPerk(PerkLib.TrollResistance, 0, 0, 0, 0);
			checkMonster();
		}
	}
}