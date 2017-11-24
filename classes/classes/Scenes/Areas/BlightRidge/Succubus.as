/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Monsters.AbstractSuccubus;
import classes.internals.*;

use namespace CoC;
	
	public class Succubus extends AbstractSuccubus
	{
		public var TrueDemons:DemonScene = new DemonScene();
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			TrueDemons.defeatSuccubus();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			TrueDemons.loseToASuccubus();
		}
		
		public function Succubus()
		{
			this.a = "the ";
			this.short = "succubus";
			this.imageName = "succubus";
			this.long = "She stands about six feet tall and is hugely voluptuous, her impressive breasts wobble delightfully as she moves.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  She is wearing rags that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.  She's using a leather whip as a weapon.";
			// this.plural = false;
			this.createVagina(false, AppearanceDefs.VAGINA_WETNESS_SLAVERING, AppearanceDefs.VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = 72;
			this.hipRating = AppearanceDefs.HIP_RATING_CURVY;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE+1;
			this.lowerBody = AppearanceDefs.LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			this.skinTone = "blue";
			this.hairColor = "black";
			this.hairLength = 13;
			initStrTouSpeInte(140, 100, 110, 115);
			initWisLibSensCor(115, 120, 60, 100);
			this.weaponName = "whip";
			this.weaponVerb="whipping";
			this.weaponAttack = 16;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 18;
			this.bonusHP = 480;
			this.bonusLust = 40;
			this.lust = 30;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 26;
			this.gems = rand(30)+15;
			this.additionalXP = 50;
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(weapons.WHIP, 2).
					add(consumables.SUCMILK,12);
			this.wingType = AppearanceDefs.WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			this.tailType = AppearanceDefs.TAIL_TYPE_DEMONIC;
			this.special1 = kissAttack;
			this.special2 = seduceAttack;
			this.special3 = whipAttack;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
	