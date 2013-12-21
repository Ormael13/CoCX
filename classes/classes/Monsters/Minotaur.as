package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.Cock;
	import classes.Appearance;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Minotaur extends Monster
	{
		

		public function Minotaur(mainClassPtr:*,hairColor:String)
		{
			super(mainClassPtr);
			trace("Minotaur Constructor!");
			trace(mainClassPtr.flags);

			var hasAxe:Boolean = rand(3)==0;
			init1Names("the ","minotaur","minotaur","An angry-looking minotaur looms over you.  Covered in shaggy " + hairColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. ");
			if (hasAxe) this.long += "<b>This minotaur seems to have found a deadly looking axe somewhere!</b>";
			init2Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2,2+rand(13),1.5,mainClassPtr.player.ballSize * 10);
			if(this.ballSize > 4)
				 this.long += "  Barely visible below the tattered shreds of loincloth are " + Appearance.ballsDescription(true, true, this) + ", swollen with the minotaur's long pent-up need.";
			this.hairColor = hairColor;
			this.temperment                            = 1;
			this.special1                              = 5029;

			//Clothing/Armor
			this.armorName                             = "thick fur";
			this.weaponName                            = "axe";
			this.weaponVerb                            = "cleave";
			//Primary stats
			this.str                                   = 75;
			this.tou                                   = 60;
			this.spe                                   = 30;
			this.inte                                  = 20;
			this.lib                                   = 40;
			this.sens                                  = 15;
			this.cor                                   = 35;
			this.fatigue                               = 0;

			//Most times they dont have an axe
			if(!hasAxe) {
				this.weaponName                        = "fist";
				this.weaponVerb                        = "punch";
				this.str                              -= 25;
				this.lustVuln                          = 0.87;
			}
			else this.lustVuln                         = 0.84;
			//Combat Stats
			this.HP                                    = this.eMaxHP();

			//Level Stats
			this.level                                 = 6;
			this.XP                                    = this.totalXP(mainClassPtr.player.level);
			if(this.weaponName == "fist")
				this.level   = 5;
			this.gems                                  = rand(5) + 5;

			//Appearance Variables
			this.tallness                              = rand(37) + 84;
			//randomly assign hair color
			if(rand(2) == 0) 
				this.hairColor                         = "black";
			else 
				this.hairColor                         = "brown";
			this.hairLength                            = 3;

			this.skinType                              = SKIN_TYPE_FUR;
			this.skinTone                              = "red";
			this.skinDesc                              = "shaggy fur";

			//3 - cowface
			this.faceType                              = FACE_COW_MINOTAUR;
			this.wingDesc                              = "non-existant";

			this.lowerBody                             = LOWER_BODY_TYPE_HOOFED;

			//7 - cow!
			this.tailType                              = 7;
			this.hipRating                             = 4;
			this.buttRating                            = 5;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating            = 0;
			this.breastRows[0].nipplesPerBreast        = 1;
			this.ass.analLooseness                     = 4;
			this.ass.analWetness                       = 1;
			this.createStatusAffect("Bonus aCapacity",30,0,0,0);
			this.lib                                  += this.ballSize * 2;
			this.lust                                 += this.ballSize * 3;
			this.sens                                 += this.ballSize * 2;
			//Extra ball description!
			this.lust                                  = 20 + rand(this.ballSize*2);

		}

	}

}