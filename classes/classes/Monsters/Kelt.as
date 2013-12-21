package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Kelt extends Monster 
	{
		
		public function Kelt(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("","Kelt","kelt","Kelt has changed for the worse since your first meeting.  Gone is his muscular, barrel chest.  In its place is a softer frame, capped with tiny boobs - remnants of your last treatment.  His jaw is fairly square and chiselled (though less than before).  From the waist down, he has the body of a horse, complete with fairly large pair of balls and a decent-sized dong.  Both are smaller than they used to be, however.  He has his bow strung and out, clearly intent on defending himself from your less than gentle touches."+(mainClassPtr.flags[kFLAGS.KELT_BREAK_LEVEL] == 2?"Kelt is looking less and less like the burly centaur from before, and more and more like a woman.  He looks more like an odd, androgynous hybrid than the beautiful woman you had turned him into.  He currently sports roughly b-cup breasts and a smallish, miniature horse-cock.  There's barely any hair on his human body, aside from a long mane of hair.  Each treatment seems to be more effective than the last, and you can't wait to see what happens after you tame him THIS time.":""));

			this.temperment = 1;

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "tough skin";
			this.weaponName = "fist";
			this.weaponVerb = "punch";
			this.armorDef = 4;

			this.weaponAttack = 10;

			//Primary stats
			this.str = 60;
			this.tou = 70;
			this.spe = 40;
			this.inte = 20;
			this.lib = 40;
			this.sens = 25;
			this.cor = 55;

			this.lust = 40;
			this.lustVuln = 0.83;
			//Combat Stats
			this.bonusHP = 200;
			this.HP = eMaxHP();
			//Level Stats
			this.level = 6;
			this.XP = totalXP();
			this.gems = rand(5) + 5;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 84;
			//randomly assign hair color
			if(rand(2) == 0) this.hairColor = "black";
			else this.hairColor = "brown";
			this.hairLength = 3;

			this.skinTone = "tan";
			this.skinDesc = "skin";

			//3 - cowface

			this.lowerBody = LOWER_BODY_TYPE_CENTAUR;

			//7 - cow!
			this.tailType = TAIL_TYPE_HORSE;

			this.hipRating = 4;

			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 1;
			this.createCock();
			this.cocks[0].cockLength = 36;
			this.cocks[0].cockThickness = 3.5;
			this.cocks[0].cockType = CockTypesEnum.HORSE;
			this.balls = 2;
			this.cumMultiplier = 1.5;
			this.ballSize = 2 + rand(13);
			this.hoursSinceCum = mainClassPtr.player.ballSize * 10;
			this.ass.analLooseness = 2;
			this.ass.analWetness = 0;
			this.createStatusAffect("Bonus aCapacity",50,0,0,0);			
		}
		
	}

}