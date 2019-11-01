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

	public class Hydra extends Monster
	{
		private function hydraGrowHead():void {
			outputText("As if to cope with the damage you dealt, the hydra’s lower body suddenly split again, growing a new angry hissing head.");
			createStatusEffect(StatusEffects.AbilityCooldown2, 3, 0, 0, 0);
			this.HP = this.maxHP();
			this.addStatusValue(StatusEffects.HydraTails, 1, 1);
			this.removePerk(PerkLib.MonsterRegeneration);
			this.createPerk(PerkLib.MonsterRegeneration, this.statusEffectv1(StatusEffects.HydraTails), 0, 0, 0);
		}
		
		private function hydraOmniBreathWeapon():void
		{
			outputText("The hydra’s many snake heads opens their maw and you can see green drips from their open maws before it comes as each of them douses you in acid! ");
			hydraOmniBreathWeaponD();
			hydraOmniBreathWeaponD();
			hydraOmniBreathWeaponD();
			hydraOmniBreathWeaponD();
			hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 6) hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 7) hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 8) hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 9) hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 10) hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 11) hydraOmniBreathWeaponD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 12) hydraOmniBreathWeaponD();
			createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
			outputText("\n\n");
		}
		private function hydraOmniBreathWeaponD():void {
			var damage:Number = this.inte * 0.2;
			damage += eBaseIntelligenceDamage() * 0.2;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 2, 10); //More heads will produce more potent acid
			else player.createStatusEffect(StatusEffects.AcidDoT, 6, 10, 0, 0);
		}
		
		private function hydraOmnibites():void
		{
			outputText("The hydra’s many heads hiss and dart out to bite you, venom dripping from their fangs. ");
			hydraOmnibitesD();
			hydraOmnibitesD();
			hydraOmnibitesD();
			hydraOmnibitesD();
			hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 6) hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 7) hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 8) hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 9) hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 10) hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 11) hydraOmnibitesD();
			if (this.statusEffectv1(StatusEffects.HydraTails) >= 12) hydraOmnibitesD();
			outputText("\n\n");
		}
		private function hydraOmnibitesD():void {
			var damage:Number = this.str * 0.3;
			damage += this.spe * 0.3;
			var damage2:Number = 0.9;
			damage2 += (rand(21) * 0.01);
			damage *= damage2;
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
			if (!player.hasStatusEffect(StatusEffects.Poison)) {
				var multiplier:Number = 5; //More heads will produce more potent venom
				if (this.tailCount >= 6) multiplier += 1;
				if (this.tailCount >= 7) multiplier += 1;
				if (this.tailCount >= 8) multiplier += 1;
				if (this.tailCount >= 9) multiplier += 1;
				if (this.tailCount >= 10) multiplier += 1;
				if (this.tailCount >= 11) multiplier += 1;
				if (this.tailCount >= 12) multiplier += 1;
				player.createStatusEffect(StatusEffects.Poison, 0, multiplier, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (HPRatio() < .75 && this.statusEffectv1(StatusEffects.HydraTails) < 12 && !hasStatusEffect(StatusEffects.AbilityCooldown2)) hydraGrowHead();
			else {
				if (rand(3) == 0) {
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) hydraOmniBreathWeapon();
					else hydraOmnibites();
				}
				else hydraOmnibites();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatHydra();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatedByHydra();
		}
		
		public function Hydra() 
		{
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 65) {
				initStrTouSpeInte(136, 250, 158, 142);
				initWisLibSensCor(150, 255, 160, 40);
				this.armorDef = 80;
				this.armorMDef = 80;
				this.bonusHP = 1000;
				this.level = 65;
				this.gems = 200 + rand(80);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 70) {
				initStrTouSpeInte(174, 290, 186, 163);
				initWisLibSensCor(172, 280, 180, 40);
				this.armorDef = 100;
				this.armorMDef = 100;
				this.bonusHP = 2000;
				this.level = 70;
				this.gems = 250 + rand(90);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 75) {
				initStrTouSpeInte(212, 330, 214, 184);
				initWisLibSensCor(194, 305, 200, 40);
				this.armorDef = 120;
				this.armorMDef = 120;
				this.bonusHP = 3000;
				this.level = 75;
				this.gems = 300 + rand(100);
			}
			this.a = "";
			this.short = "Hydra";
			this.imageName = "naga";
			this.long = "This look like a giant naga at first but instead of a standard snake tail her bottom split into several coils mounted by hissing snake heads. The hydra looks horny and since its been locked in this room for god knows how many decades it has all the reasons to be. At the junction from which all her coils begins a dripping vagina big enough to engulf a grown minotaur, horns and all awaits eagerly. You expect mating with this creature would end poorly. She currently stands between you and the exit, barring any possible retreat.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 25*12+10;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.HYDRA;
			this.faceType = Face.SNAKE_FANGS;
			this.skinTone = "mediterranean-toned";
			this.hairColor = "brown";
			this.hairLength = 16;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "scales";
			this.bonusLust = 10;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.drop = new WeightedDrop(consumables.HYDRASC, 1);
			this.createStatusEffect(StatusEffects.HydraTails, 5, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}