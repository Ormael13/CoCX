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

	public class Hydra extends Monster
	{
		private function hydraGrowHead():void {
			outputText("As if to cope with the damage you dealt, the hydra’s lower body suddenly split again, growing a new angry hissing head.");
			createStatusEffect(StatusEffects.AbilityCooldown2, 3, 0, 0, 0);
			this.HP = this.maxHP();
			this.addStatusValue(StatusEffects.HydraTails, 1, 1);
			this.removePerk(PerkLib.HydraRegeneration);
			this.createPerk(PerkLib.HydraRegeneration, this.statusEffectv1(StatusEffects.HydraTails), 0, 0, 0);
		}
		
		private function hydraOmniBreathWeapon():void
		{
			outputText("The hydra’s many snake heads opens their maw and you can see green drips from their open maws before it comes as each of them douses you in acid! ");
            for (var i:int = 0; i < 12; ++i)
			    hydraOmniBreathWeaponD();
            createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
			outputText("\n\n");
		}
		private function hydraOmniBreathWeaponD():void {
			var damage:Number = this.inte * 0.2;
			damage += eBaseIntelligenceDamage() * 0.2;
			damage = Math.round(damage);
			damage = player.takeAcidDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 2, 10); //More heads will produce more potent acid
			else player.createStatusEffect(StatusEffects.AcidDoT, 6, 10, 0, 0);
		}
		
		private function hydraOmnibites():void
		{
			outputText("The hydra’s many heads hiss and dart out to bite you, venom dripping from their fangs. ");
			for (var i:int = 0; i < 12; ++i)
			    hydraOmnibitesD();
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
				var multiplier:Number = this.tailCount; //more heads -> more venom
				player.createStatusEffect(StatusEffects.Poison, 0, multiplier, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (HPRatio() < .75 && this.statusEffectv1(StatusEffects.HydraTails) < 12 && !hasStatusEffect(StatusEffects.AbilityCooldown2)) hydraGrowHead();
			else {
				if (!hasStatusEffect(StatusEffects.AbilityCooldown1) && rand(3) == 0)
					hydraOmniBreathWeapon();
				else
                    hydraOmnibites();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.hydraScene.defeat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.hydraScene.defeatedBy();
		}
		
		public function Hydra() 
		{
            var mod:int = inDungeon ? SceneLib.dungeons.ebonlabyrinth.enemyLevelMod : 0;
			initStrTouSpeInte(136 + 38*mod, 250 + 40*mod, 158 + 28*mod, 142 + 21*mod);
            initWisLibSensCor(150 + 22*mod, 255 + 25*mod, 160 + 20*mod, 40);
            this.armorDef = 80 + 20*mod;
            this.armorMDef = 80 + 20*mod;
            this.bonusHP = 1000 + 1000*mod;
            this.bonusLust = 480 + 50*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 50 ? 0 : Math.floor((2000 + rand(400)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 50 ? 0 : Math.floor(9000 * Math.exp(0.3*mod));

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
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.drop = new WeightedDrop(consumables.HYDRASC, 1);
			this.createStatusEffect(StatusEffects.HydraTails, 5, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.HydraRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}