package classes.Scenes.Places.Owca
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class Farmers extends Monster
	{

		override protected function performCombatAction():void
		{
			createStatusEffect(StatusEffects.Attacks,4,0,0,0);
			eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.owca.beatUpOwca();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.owca.loseToOwca();
		}

		public function Farmers()
		{
			this.a = "the ";
			this.short = "farmers";
			this.imageName = "farmers";
			this.long = "This is a group of thirty angry villagers, almost all human-looking but for the tiny horn-like protrusions growing from their heads and the white fuzz that almost passes off as hair.  They are all armed with pitchforks or other crude farming tools they use in their everyday task.  Rebecc is staring from behind them with horrified eyes at the combat, paralyzed by the sudden turn of events.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(9,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, AppearanceDefs.VAGINA_WETNESS_SLICK, AppearanceDefs.VAGINA_LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(40, 120, 110, 100);
			initWisLibSensCor(100, 35, 35, 20);
			this.weaponName = "pitchforks";
			this.weaponVerb="stab";
			this.weaponAttack = 20;
			this.armorName = "chitin";
			this.armorDef = 10;
			this.bonusHP = 300;
			this.bonusLust = 10;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 24;
			this.gems = rand(50)+100;
			this.hornType = AppearanceDefs.HORNS_DEMON;
			this.horns = 2;
			this.tailType = AppearanceDefs.TAIL_TYPE_DEMONIC;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}