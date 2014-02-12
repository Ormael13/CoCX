package classes.Scenes.Dungeons.DeepCave
{
	import classes.*;
	import classes.internals.*;

	public class ImpHorde extends Monster
	{


		override protected function performCombatAction():void
		{
			game.impGangAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.impGangVICTORY();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes don't seem put off enough to leave...");
				doNext(game.endLustLoss);
			} else {
				game.loseToImpMob();
			}
		}

		public function ImpHorde()
		{
			trace("ImpHorde Constructor!");
			this.a = "the ";
			this.short = "imp horde";
			this.imageName = "impmob";
			this.long = "Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusAffect(StatusAffects.BonusACapacity,10,0,0,0);
			this.tallness = 36;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 1;
			initStrTouSpeInte(20, 10, 25, 12);
			initLibSensCor(45, 45, 100);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.armorName = "skin";
			this.bonusHP = 450;
			this.lust = 10;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 10;
			this.gems = 20 + rand(25);
			this.drop = new WeightedDrop(armors.NURSECL, 1);
			this.wingType = WING_TYPE_IMP;
			this.wingDesc = "imp wings";
			checkMonster();
		}

	}

}