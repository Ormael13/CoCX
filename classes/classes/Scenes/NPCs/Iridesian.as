/**
 * ...
 * @author Ormael (for now)
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Iridesian extends Monster
	{
		public function soulskillCostHailofBlades():Number {
			var cost:Number = 50;
			if (hasPerk(PerkLib.DaoistCultivator)) cost -= 5;
			return cost;
		}
		public function soulskillCostGrandioseHailofBlades():Number {
			var cost:Number = 200;
			if (hasPerk(PerkLib.DaoistCultivator)) cost -= 20;
			return cost;
		}
		public function soulskillCostGrandioseHailofMoonBlades():Number {
			var cost:Number = 800;
			if (hasPerk(PerkLib.DaoistCultivator)) cost -= 80;
			return cost;
		}
		
		public function SoulskillMod():Number {
			var mod1:Number = 1;
			if (hasPerk(PerkLib.DaoistCultivator)) mod1 += .2;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) mod1 += .4;
				if (hasPerk(PerkLib.SoulPersonage)) mod1 += .4;
				if (hasPerk(PerkLib.SoulWarrior)) mod1 += .4;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) mod1 += .6;
				if (hasPerk(PerkLib.SoulScholar)) mod1 += .6;
				if (hasPerk(PerkLib.SoulElder)) mod1 += .6;
			}
			return mod1;
		}
		
		public function castHailOfBladesSoulskillIridesian():void {
			outputText("Letting soulforce leak out around him, oculicorn form six ethereal two meter long weapons. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostHailofBlades();
			var hobI:Number = 6;
			while (hobI-->0) bladesD();
			outputText(" damage!");
		}
		public function castGrandioseHailOfBladesSoulskillIridesian():void {
			outputText("Letting soulforce leak out around her, oculicorn form eighteen ethereal two meter long weapons in two rows. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostGrandioseHailofBlades();
			createStatusEffect(StatusEffects.AbilityCooldown2, 3, 0, 0, 0);
			var ghobI:Number = 18;
			while (ghobI-->0) bladesD();
			outputText(" damage!");
		}
		public function castGrandioseHailOfMoonBladesSoulskillIridesian():void {
			outputText("Letting soulforce leak out around her, oculicorn form fifty four ethereal two meter long weapons in four rows. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostGrandioseHailofMoonBlades();
			createStatusEffect(StatusEffects.AbilityCooldown3, 9, 0, 0, 0);
			var ghombI:Number = 54;
			while (ghombI-->0) bladesD();
			outputText(" damage!");
		}
		private function bladesD():void {
			var bd:Number = 0;
			bd += this.wis * 0.5;
			bd += wisdomscalingbonus() * 0.5;
			if (bd < 10) bd = 10;
			bd *= SoulskillMod();
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.wis <= 200) critChance += this.wis / 10;
			if (this.wis > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				bd *= 1.75;
			}
			var bd2:Number = 0.9;
			bd2 += (rand(21) * 0.01);
			bd *= bd2;
			bd = Math.round(bd);
			bd = player.takeMagicDamage(bd, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
		}
		
		private function IridesianDominationGaze():void {
			outputText("The eyes gaze bore deep within your very mind with a single order.\n\n");
			outputText("\"<i>Stillness</i>\"\n\n");
			outputText("You suddenly panic as you are held in place, fighting against the mind control as the thing takes aim.\n\n");
			createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
			player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		private function IridesianOmnicast():void {
			outputText("Oculicorn suddenly fixates you with all of its eye unleashing a barrage of rays at you! ");
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			if (player.hasStatusEffect(StatusEffects.Stunned) || !player.getEvasionRoll() || rand(2) == 0) IridesianOmnicastD();
			outputText("\n\n");
		}
		private function IridesianOmnicastD():void {
			var damage:Number = eBaseIntelligenceDamage() * 0.1;
			damage += eBaseWisdomDamage() * 0.1;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 10) createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);
			if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
				if (soulforce >= 10) soulforce -= 10;
				else removeStatusEffect(StatusEffects.TranscendentSoulField);
			}
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) IridesianDominationGaze();
			else {
				var choice:Number = rand(4);
				if (choice == 0) IridesianOmnicast();
				if (choice == 1) {
					if (soulforce >= soulskillCostHailofBlades()) castHailOfBladesSoulskillIridesian();
					else IridesianOmnicast();
				}
				if (choice == 2) {
					if (soulforce >= soulskillCostGrandioseHailofBlades() && !hasStatusEffect(StatusEffects.AbilityCooldown2)) castGrandioseHailOfBladesSoulskillIridesian();
					else IridesianOmnicast();
				}
				if (choice == 3) {
					if (soulforce >= soulskillCostGrandioseHailofMoonBlades() && !hasStatusEffect(StatusEffects.AbilityCooldown3)) castGrandioseHailOfMoonBladesSoulskillIridesian();
					else IridesianOmnicast();
				}
			}
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting an Oculicorn. This powerful creature would look like a human save for the hooves, the mono all encompassing eye in his head, sharp teeth and ten eye mounted stalks expending from his back. Medium long single horn adorn his forehead ocassionaly glowing with mild white light.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmer of protective bubble surrounding him.</i>";
			}
			return str;
		}
		
		public function Iridesian() 
		{
			initStrTouSpeInte(32, 259, 97, 112);
            initWisLibSensCor(270, 160, 103, 60);
            this.armorDef = 150;
            this.armorMDef = 150;
            this.bonusHP = 2000;
            this.bonusLust = 323;
            this.bonusWrath = 500;
            this.bonusSoulforce = 1000;
            this.level = 60;
            this.gems = 1300 + rand(260);
            this.additionalXP = 6000;
			this.a = "the ";
			this.short = "Oculicorn";//Iridesian
			this.imageName = "gazer";
			this.long = "";
			// this.plural = false;
			this.createCock(12,2.5,CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2+rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = player.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 10*12+10;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.HOOFED;
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
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);//X times less dmg, +X lvl diff bonus
			//this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
			/*this.abilities = [
				{ call: eyeTyrantOmnicast, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[]},
				{ call: eyeTyrantDominationGaze, type: ABILITY_MAGIC, range: RANGE_RANGED, tags:[], condition: function():Boolean { return !hasStatusEffect(StatusEffects.AbilityCooldown1) }}
			]*/
			checkMonster();
		}
	}
}