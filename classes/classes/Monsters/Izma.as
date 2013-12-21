package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Izma extends Monster 
	{
		
		public function Izma(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Izma", "izma", "Izma the tigershark stands a bit over 6' tall, with orange skin bearing horizontal stripes covering most of her body.  Her silver-white hair cascades past her shoulders, draping over an impressive pair of DD-cup breasts barely restrained by a skimpy black bikini top.  Under the knee-length grass skirt below them rustles her beastly fifteen-inch penis and four-balled sack; you catch occasional glimpses of them as she moves.  She's tucked her usual reading glasses into her locker at the moment.");
			init2Male(new Cock(15,2.2));
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE,45);

			this.temperment = 2;
			//Lusty teases


			//Clothing/Armor
			this.armorName = "bikini and grass skirt";
			this.weaponName = "clawed gauntlets";
			this.weaponVerb = "clawed punches";
			this.armorDef = 8;

			this.weaponAttack = 45;

			//Primary stats
			this.str = 80;
			this.tou = 90;
			this.spe = 85;
			this.inte = 65;
			this.lib = 75;
			this.sens = 25;
			this.cor = 40;

			this.lustVuln = .20;

			//Combat Stats
			this.bonusHP = 330;
			this.HP = eMaxHP();

			this.lust = 20;

			//Level Stats
			this.level = 15;
			this.XP = totalXP();
			this.gems = rand(5) + 1;

			//Appearance Variables
			this.tallness = 66;
			this.hairColor = "silver";
			this.hairLength = 20;

			this.skinTone = "striped orange";
			this.skinDesc = "skin";

			this.hipRating = 10;

			this.buttRating = 6;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 7;
			this.ass.analLooseness = 2;
			this.createStatusAffect("Bonus aCapacity",30,0,0,0);
			this.ass.analWetness = 0;
		}
		
	}

}