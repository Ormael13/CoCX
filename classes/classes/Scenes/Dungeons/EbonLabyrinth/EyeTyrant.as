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
			eyeTyrantOmnicastD();
			eyeTyrantOmnicastD();
			eyeTyrantOmnicastD();
			eyeTyrantOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) eyeTyrantOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) eyeTyrantOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) eyeTyrantOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) eyeTyrantOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) eyeTyrantOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) eyeTyrantOmnicastD();
			outputText("\n\n");
		}
		private function eyeTyrantOmnicastD():void {
			var damage:Number = eBaseIntelligenceDamage() * 0.25;
			damage += eBaseWisdomDamage() * 0.25;
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
			SceneLib.dungeons.ebonlabyrinth.eyeTyrantScene.defeat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.eyeTyrantScene.defeatedBy();
		}
		
		public function EyeTyrant()
		{
            //scaled from 65 now, reduced base stats to compensate
			var mod:int = inDungeon ? SceneLib.dungeons.ebonlabyrinth.enemyLevelMod : 3;
            initStrTouSpeInte(32 + 34*mod, 279 + 21*mod, 76 + 27*mod, 270 + 40*mod);
            initWisLibSensCor(112 + 21*mod, 160 + 30*mod, 30 + 40*mod, 60);
            this.armorDef = 20 + 20*mod;
            this.armorMDef = 150 + 50*mod;
            this.bonusHP = mod == 0 ? 0 : 2500*(mod-1);
            this.bonusLust = 255 + 75*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 50 ? 0 : Math.floor((1300 + rand(260)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 50 ? 0 : Math.floor(6000 * Math.exp(0.3*mod));
            
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
			this.lowerBody = LowerBody.GAZER;
			this.faceType = Face.ANIMAL_TOOTHS;
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
			this.drop = new WeightedDrop(consumables.ME_DROP, 1);
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.abilities = [
				{ call: eyeTyrantOmnicast, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]},
				{ call: eyeTyrantDominationGaze, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[], condition: function():Boolean { return !hasStatusEffect(StatusEffects.AbilityCooldown1) }}
			]
			checkMonster();
		}
	}
}