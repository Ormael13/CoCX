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
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class HellfireSnail extends Monster
	{
		private function hellfireSnailBurningEmbrace():void
		{
			outputText("Your flesh begins burning as the snail embraces you with her molten body! Ironically this is both extremely hot and painful! ");
			player.takePhysDamage((.2 + (.02 * this.statusEffectv1(StatusEffects.RisingInferno))) * player.maxHP(), true);
			player.takeFireDamage((.2 + (.02 * this.statusEffectv1(StatusEffects.RisingInferno))) * player.maxHP(), true);
			outputText("\n\n");
		}
		
		private function hellfireSnailEngulph():void
		{
			outputText("Without warning the snail girl leaps on you in a sudden burst of speed, smearing you with liquid fire! You’re being grappled! The snail giggles.");
			outputText("\n\n\"<i>Got you right where I want you.</i>\"");
			if (!player.hasStatusEffect(StatusEffects.GooBind)) player.createStatusEffect(StatusEffects.GooBind, 0, 0, 0, 0);
		}
		
		private function hellfireSnailSpitMagma():void
		{
			outputText("The snail girl spits a blob of fiery magma at you! ");
			var damage:Number = this.inte * 0.5;
			damage += this.wis * 0.5;
			damage *= (1 + (this.statusEffectv1(StatusEffects.RisingInferno) * 0.1));
			var damage2:Number = 0.9;
			damage2 += (rand(21) * 0.01);
			damage *= damage2;
			damage = Math.round(damage);
			damage = player.takeFireDamage(damage, true);
			if (!player.hasPerk(PerkLib.FireAffinity)) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,3,0.05,0,0);
				outputText(" You’re on fire!!!");
			}
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			this.addStatusValue(StatusEffects.RisingInferno, 1, 1);
			if (player.hasStatusEffect(StatusEffects.GooBind)) hellfireSnailBurningEmbrace();
			else {
				if (!player.hasStatusEffect(StatusEffects.GooBind) && rand(3) == 0) hellfireSnailEngulph();
				else hellfireSnailSpitMagma();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatHellfireSnail();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.EbonLabyrinthBoss);
			SceneLib.dungeons.ebonlabyrinth.defeatedByHellfireSnail();
		}
		
		public function HellfireSnail() 
		{
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 65) {
				initStrTouSpeInte(100, 300, 80, 150);
				initWisLibSensCor(150, 260, 200, 10);
				this.armorDef = 225;
				this.armorMDef = 225;
				this.bonusHP = 12500;
				this.level = 65;
				this.gems = 200 + rand(80);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 70) {
				initStrTouSpeInte(120, 350, 110, 180);
				initWisLibSensCor(180, 310, 200, 10);
				this.armorDef = 300;
				this.armorMDef = 300;
				this.bonusHP = 25000;
				this.level = 70;
				this.gems = 250 + rand(90);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 75) {
				initStrTouSpeInte(140, 400, 140, 210);
				initWisLibSensCor(210, 360, 200, 10);
				this.armorDef = 375;
				this.armorMDef = 375;
				this.bonusHP = 37500;
				this.level = 75;
				this.gems = 300 + rand(100);
			}
			this.a = "";
			this.short = "Hellfire Snail";
			this.imageName = "snail";
			this.long = "This creature has the upper body of a woman and the lower body of a snail. Unlike a normal snail her body secretes magma and fire, her very hair ablaze as she quite literally drools liquid fire everywhere. The ground beneath her is constantly aflamme with liquid magma. Striking her with anything short of a ranged attack sounds like a terrible idea. As if this wasn't bad enough, arousal seems to progressively increase her volatility as she constantly erupts with more fire.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 132;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.FIRE_SNAIL;
			this.faceType = Face.FIRE_SNAIL;
			this.skinTone = "red";
			this.hairColor = "red";
			this.hairLength = 16;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "sticky glistering skin";
			this.bonusLust = 10;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.drop = new WeightedDrop(consumables.FSNAILS, 1);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.RisingInferno, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.EruptingRiposte, 0, 0, 0, 0);
			checkMonster();
		}
	}
}