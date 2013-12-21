package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Kitsune extends Monster 
	{
		
		public function Kitsune(mainClassPtr:*,hairColor:String) 
		{
			super(mainClassPtr);
			this.hairColor = hairColor;
			this.short="kitsune";
			this.imageName="kitsune";

			this.long = "A kitsune stands in front of you, about five and a half feet tall.  She has a head of ";

			if(hairColor == "blonde") this.long += "long flaxen";
			else if(hairColor == "black") this.long += "lustrous, ass-length black";
			else this.long += "unkempt, shoulder-length reddish";
			this.long += " hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.";
			if(rand(3) != 2) mainClassPtr.flags[kFLAGS.redheadIsFuta] = 1;
			this.a ="a ";

			this.temperment = 1;
			this.special1 = 5029;

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "claws";
			this.weaponVerb = "punch";

			//Primary stats
			this.str = 35;
			this.tou = 45;
			this.spe = 90;
			this.inte = 95;
			this.lib = 60;
			this.sens = 65;
			this.cor = 45;

			this.lust = 20;

			this.lustVuln = 0.9;
			//Combat Stats
			this.bonusHP = 120;
			this.HP = eMaxHP();

			//Level Stats
			this.level = 6;
			this.XP = totalXP();
			this.gems = rand(10) + 10;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			if(mainClassPtr.flags[kFLAGS.redheadIsFuta] == 1) this.gender == 3;
			this.tallness = rand(24) + 60;

			this.hairLength = 13+rand(20);

			this.skinTone = "pale";
			this.skinDesc = "skin";

			//3 - cowface
			this.faceType = FACE_COW_MINOTAUR;

			//7 - cow!
			this.tailType = TAIL_TYPE_FOX;

			this.hipRating = 6;

			this.buttRating = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 4;
			this.breastRows[0].nipplesPerBreast = 1;
			if(hairColor == "red") {
				this.createCock();
				this.cocks[0].cockLength = rand(13) + 14;
				this.cocks[0].cockThickness = 1.5 + rand(20)/2;
				this.cocks[0].cockType = CockTypesEnum.HUMAN;
				this.balls = 2;
				this.cumMultiplier = 1.5;
				this.ballSize = 2 + rand(13);
				this.hoursSinceCum = mainClassPtr.player.ballSize * 10;
			}
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.createStatusAffect("Bonus aCapacity",20,0,0,0);
			this.createStatusAffect("Bonus vCapacity",20,0,0,0);			
		}
		
	}

}