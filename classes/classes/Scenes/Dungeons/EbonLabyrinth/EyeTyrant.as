/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class EyeTyrant extends Monster
	{
		private function eyeTyrantDominationGaze():void {
			outputText("The eyes gaze bore deep within your very mind with a single order.\n\n");
			outputText("\"<i>Stand… still</i>\"\n\n");
			outputText("You suddenly panic as you are held in place, fighting against the mind control as the thing takes aim.\n\n");
			createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0);
			player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		
		private function eyeTyrantOmnicast():void {
			outputText("The gazer suddenly fixates you with all of its eye unleashing a barrage of rays at you! ");
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			if (!player.getEvasionRoll() || player.hasStatusEffect(StatusEffects.Stunned)) eyeTyrantOmnicastD();
			outputText("\n\n");
		}
		private function eyeTyrantOmnicastD():void {
			var damage:Number = eBaseIntelligenceDamage() * 0.1;
			damage += eBaseWisdomDamage() * 0.1;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) eyeTyrantDominationGaze();
			else eyeTyrantOmnicast();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatEyeTyrant();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatedByEyeTyrant();
		}
		
		public function EyeTyrant()
		{
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 80) {
				initStrTouSpeInte(134, 350, 157, 342);
				initWisLibSensCor(175, 250, 150, 40);
				this.armorDef = 80;
				this.armorMDef = 300;
				this.bonusHP = 5000;
				this.bonusLust = 480;
				this.level = 80;
				this.gems = 350 + rand(110);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 85) {
				initStrTouSpeInte(168, 390, 184, 363);
				initWisLibSensCor(196, 280, 190, 40);
				this.armorDef = 100;
				this.armorMDef = 350;
				this.bonusHP = 7500;
				this.bonusLust = 555;
				this.level = 85;
				this.gems = 400 + rand(120);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 90) {
				initStrTouSpeInte(204, 430, 211, 384);
				initWisLibSensCor(217, 310, 230, 40);
				this.armorDef = 120;
				this.armorMDef = 400;
				this.bonusHP = 10000;
				this.bonusLust = 630;
				this.level = 90;
				this.gems = 450 + rand(130);
			}
			this.a = "";
			this.short = "Eye Tyrant";
			this.imageName = "gazer";
			this.long = "You are fighting a Gazer. This powerful creature would look like a human woman save for the tar-like substance dripping from her body the mono all encompassing eye in her head, sharp teeth and ten eye mounted stalks expending from her back. While she does have legs she moves by levitating around instead. She has already proven to have dangerous mind control power so you suspect she also can deal quite a bit of magical damage.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 10*12+10;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE + 1;
			//this.lowerBody = LowerBody.HYDRA;
			//this.faceType = Face.SNAKE_FANGS;
			this.skinTone = "light grey";
			this.hairColor = "black";
			this.hairLength = 16;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "skin";
			this.lustVuln = .75;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.drop = NO_DROP;
			//this.drop = new WeightedDrop(consumables.HYDRASC, 1);
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}