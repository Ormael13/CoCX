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

	public class GlacialMaleTroll extends Monster
	{
		public function glacialTrollGrabs():void {
			outputText("The troll rushes inward, arms outstretched as he attempts to grab hold of you. ");
			if (player.getEvasionRoll()) outputText("You manage to dodge his assault.");
			else {
				outputText("You can’t dodge quickly enough as he hoists you above the ground, you are trapped within his clutches. The burly troll has you in his clutches!");
				player.createStatusEffect(StatusEffects.TrollHold,1,0,0,0);
			}
			statScreenRefresh();
		}
		
		public function glacialTrollGoreWithTusks():void {
			outputText("The troll barrels towards you but he feints as he tries to gore your face with his tusks. ");
			if (player.getEvasionRoll()) outputText("You manage to avoid his tusks.");
			else {
				var damage:Number = 0;
				damage = int(((str + 100 + weaponAttack) * 2) - Math.random()*(player.tou) - player.armorDef);
				outputText("You are caught off guard as he cuts you, dealing ");
				damage = player.takePhysDamage(damage, true);
				outputText(" damage.");
				if (rand(3) == 0 && !player.hasPerk(PerkLib.Resolute)) {
					outputText(" You are disoriented from the blow, needing a moment to recover your wits.");
					player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				}
			}
			statScreenRefresh();
		}
		
		public function glacialTrollPunch():void {
			outputText("The troll tumbles barrels toward you with his massive body. ");
			if (player.getEvasionRoll()) outputText("You react quickly, evading his charge as he tumbles onto the snow.");
			else {
				var damage:Number = 0;
				damage = int(((str + 100 + weaponAttack) * 1.5) - Math.random()*(player.tou) - player.armorDef);
				outputText("You don’t have enough time to dodge as he bashes into you. ");
				damage = player.takePhysDamage(damage, true);
			}
			statScreenRefresh();
		}
		
		public function glacialTrollGrabsFinisher():void {
			outputText("\n\nAs you squirm around in his grasp, he lifts you over his head before slamming you directly into the ground. ");
			if (player.hasPerk(PerkLib.Resolute)) outputText("You quickly spring to your feet, ready to continue fighting. ");
			else {
				outputText("You’re seeing stars as you try to shake yourself from the brutal throw. ");
				player.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
			}
			player.removeStatusEffect(StatusEffects.TrollHold);
			var throwDMG:Number = eBaseDamage() * 2;
			player.takePhysDamage(throwDMG, true);
		}
		
		override protected function performCombatAction():void
		{
			if (player.statusEffectv1(StatusEffects.TrollHold) >= 2) glacialTrollGrabsFinisher();
			else {
				var choice:Number = rand(3);
				if (choice == 0) glacialTrollPunch();
				if (choice == 1) {
					if (!player.hasStatusEffect(StatusEffects.Stunned) && rand(2) == 0) glacialTrollGoreWithTusks();
					else glacialTrollPunch();
				}
				if (choice == 2) {
					if (!player.hasStatusEffect(StatusEffects.TrollHold) && rand(2) == 0) glacialTrollGrabs();
					else glacialTrollPunch();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.trollScene.encounterAdultGlacialMaleTrollLost();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You fall to the ground, "+(player.HP <= player.minHP() ? "wounded from combat, unable to fight any longer":"your arousal has bested you")+".\n\n");
			SceneLib.trollScene.encounterAdultGlacialMaleTrollWon();
		}
		
		public function GlacialMaleTroll() 
		{
			this.a = "the ";
			this.short = "glacial troll male";
			this.imageName = "glacialtrollmale";
			this.long = "You are fighting what appears to be an glacial troll male. He is just over 9 feet tall, covered in white fur and has a large, muscular, yet stout build. He has tusks protruding from his mouth each about 8 inches long curving upwards. Like all ice trolls, his hands and feet end in sharp claws ready to grip and tear through anything. He is wearing fur armor that conceals most of his body.";
			// this.plural = false;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.createCock(10, 2, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 2;
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 112 + rand(2);
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			initStrTouSpeInte(414, 392, 378, 344);
			initWisLibSensCor(362, 286, 100, 15);
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
			this.bonusLust = 480;
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