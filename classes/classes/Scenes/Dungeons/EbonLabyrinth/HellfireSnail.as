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
			if (!player.hasPerk(PerkLib.FireAffinity) && !player.hasPerk(PerkLib.AffinityIgnis)) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,3,0.05,0,0);
				outputText(" You’re on fire!!!");
			}
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			this.addStatusValue(StatusEffects.RisingInferno, 1, 1);
			super.performCombatAction();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.hellfireSnailScene.defeat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.hellfireSnailScene.defeatedBy();
		}
		
		public function HellfireSnail() 
		{
            var mod:int = inDungeon ? SceneLib.dungeons.ebonlabyrinth.enemyLevelMod : 0;
            initStrTouSpeInte(100 + 20*mod, 300 + 50*mod, 80 + 30*mod, 150 + 30*mod);
            initWisLibSensCor(150 + 30*mod, 260 + 50*mod, 200, 10);
            this.armorDef = 225 + 75*mod;
            this.armorMDef = 225 + 75*mod;
            this.bonusHP = 12500 + 10000*mod; //THICC
            this.bonusLust = 525 + 55*mod;
            this.level = 60 + 5*mod; //starts from 65 due to EL levelMod calculations;
            this.gems = mod > 50 ? 0 : Math.floor((1000 + rand(200)) * Math.exp(0.3*mod));
            this.additionalXP = mod > 50 ? 0 : Math.floor(5000 * Math.exp(0.3*mod));
			
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
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.drop = new WeightedDrop(consumables.FSNAILS, 1);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.RisingInferno, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.EruptingRiposte, 0, 0, 0, 0);
			this.abilities = [
				{ call: hellfireSnailSpitMagma, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_FLUID,]},
				{ call: hellfireSnailEngulph, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_FLUID], condition: function():Boolean { return !player.hasStatusEffect(StatusEffects.GooBind) }},
				{ call: hellfireSnailBurningEmbrace, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_FLUID], condition: function():Boolean { return player.hasStatusEffect(StatusEffects.GooBind) }, weight:Infinity}
			]
			checkMonster();
		}
	}
}