/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class HellfireSnail extends Monster
	{
		
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
				this.armorDef = 150;
				this.armorMDef = 150;
				this.bonusHP = 12500;
				this.level = 65;
				this.gems = 200 + rand(80);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 70) {
				initStrTouSpeInte(120, 350, 110, 180);
				initWisLibSensCor(180, 310, 200, 10);
				this.armorDef = 200;
				this.armorMDef = 200;
				this.bonusHP = 25000;
				this.level = 70;
				this.gems = 250 + rand(90);
			}
			if (player.statusEffectv1(StatusEffects.EbonLabyrinthBoss) == 75) {
				initStrTouSpeInte(140, 400, 140, 210);
				initWisLibSensCor(210, 360, 200, 10);
				this.armorDef = 250;
				this.armorMDef = 250;
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
			this.tallness = 120;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			//this.lowerBody = LowerBody.HYDRA;
			//this.faceType = Face.SNAKE_FANGS;
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
			//this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			checkMonster();
		}
	}
}