package classes.Scenes.Places.Owca
{
	import classes.*;

	public class Farmers extends Monster
	{

		override protected function performCombatAction():void
		{
			createStatusEffect(StatusEffects.Attacks,4,0,0,0);
			eAttack();
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.owca.beatUpOwca();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.owca.loseToOwca();
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
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(40, 50, 99, 99);
			initLibSensCor(35, 35, 20);
			this.weaponName = "pitchforks";
			this.weaponVerb="stab";
			this.armorName = "chitin";
			this.bonusHP = 500;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 10;
			this.gems = rand(25) +40;
			this.hornType = HORNS_DEMON;
			this.horns = 2;
			this.tailType = TAIL_TYPE_DEMONIC;
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}