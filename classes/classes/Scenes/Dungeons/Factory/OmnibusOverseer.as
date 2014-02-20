package classes.Scenes.Dungeons.Factory
{
	import classes.*;
	import classes.internals.*;

	public class OmnibusOverseer extends Monster
	{

		override public function defeated(hpVictory:Boolean):void
		{
			game.omnibusVictoryEvent();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.endLustLoss);
			} else {
				game.eventParser(11046);
			}
		}

		public function OmnibusOverseer()
		{
			this.a = "the ";
			this.short = "Omnibus Overseer";
			this.imageName = "omnibusoverseer";
			this.long = "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.";
			// this.plural = false;
			this.createCock(10,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			this.skinTone = "light purple";
			this.hairColor = "purple";
			this.hairLength = 42;
			initStrTouSpeInte(65, 45, 45, 85);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 15;
			this.bonusHP = 200;
			this.lust = 20;
			this.lustVuln = 0.75;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 8;
			this.gems = rand(25)+10;
			this.drop = new WeightedDrop(null, 1);
			this.special1 = 11043;
			this.special2 = 11044;
			this.wingType = WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			this.tailType = TAIL_TYPE_DEMONIC;
			checkMonster();
		}
		
	}

}