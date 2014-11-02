package classes.Scenes.Dungeons.LethiceCastle 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class LivingStatue extends Monster
	{
	
		//override public function doAI():void
		//{
		//	giantAI();
		//}
		
		public function LivingStatue() 
		{
			this.a = "the ";
			this.short = "living statue";
			this.imageName = "livingstatue";
			this.long = "This animate marble statue shows numerous signs of wear and tear, but remains as strong and stable as the day it was carved. It's pearly, white skin is pockmarked in places from age, yet the alabaster muscles seem to move with almost liquid grace. You get the impression that the statue was hewn in the days before the demons, then brought to life shortly after. It bears a complete lack of genitalia - an immaculately carved leaf is all that occupies its loins. It wields a hammer carved from the same material as the rest of it.";
			this.balls = 0;
			this.ballSize = 0;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			this.createBreastRow(0, 0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = 360;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_BUTTLESS;
			this.skinTone = "white";
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinDesc = "smooth";
			this.hairColor = "white";
			this.hairLength = 1;
			initStrTouSpeInte(70, 150, 45, 75);
			initLibSensCor(0, 1, 45);
			this.weaponName = "marble warhammer";
			this.weaponVerb="strike";
			this.weaponAttack = 35;
			this.armorName = "marble skin";
			this.armorDef = 25;
			this.bonusHP = 350;
			this.lust = 10;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 24;
			this.gems = 250;
			this.drop = new WeightedDrop(null, 1);
			checkMonster();
		}
		
	}

}