package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.Scenes.Monsters.Imp;
	import classes.GlobalFlags.kFLAGS;
	
	public class Scruffy extends Imp
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.prison.scruffyScene.prisonCaptorRandomEventJizzJanitorBeatenUp();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.prison.scruffyScene.prisonCaptorRandomEventJizzJanitorLoss();
		}
		
		public function Scruffy() 
		{
			this.a = "";
			this.short = "Scruffy";
			this.imageName = "scruffy";
			this.long = "Scruffy is a skinny imp. He has the typical features of an imp: red skin, curved horns, bat-like wings, and spaded tail. He's wearing a janitor's scrub top with a nametag that reads \"Scruffy\" and he's naked from the waist down, his large cock flopping freely. He's wielding his mop as a weapon.";
			// this.plural = false;
			this.createCock(11, 2.5, CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 40;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			initStrTouSpeInte(40, 30, 40, 28);
			initLibSensCor(45, 45, 90);
			this.weaponName = "mop";
			this.weaponVerb = "thwack";
			this.weaponAttack = 10 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "leathery skin";
			this.armorDef = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusLust = 30;
			this.lust = 40;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 7;
			this.gems = rand(5) + 25;
			this.drop = NO_DROP;
			this.special1 = lustMagicAttack;
			this.wingType = WING_TYPE_IMP;
			checkMonster();
		}
		
	}

}