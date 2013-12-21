package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Izabella extends Monster 
	{
		
		public function Izabella(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Isabella", "isabella", "Isabella is a seven foot tall, red-headed tower of angry cow-girl.  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.");
			init2Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_GAPING,45);
			this.temperment = 2;
			//Lusty teases

			//Clothing/Armor
			this.armorName = "giant shield";
			this.weaponName = "giant shield";
			this.weaponVerb = "smash";
			this.armorDef = 8;

			this.weaponAttack = 15;

			this.armorValue = 70;
			//Primary stats
			this.str = 70;
			this.tou = 98;
			this.spe = 75;
			this.inte = 65;
			this.lib = 65;
			this.sens = 25;
			this.cor = 40;

			this.lustVuln = .35;

			//Combat Stats
			this.bonusHP = 700;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 15;
			this.XP = totalXP();
			this.gems = rand(5) + 20;

			//Appearance Variables
			this.tallness = 90;
			this.hairColor = "red";
			this.hairLength = 13;

			this.skinTone = "dusky";
			this.skinDesc = "skin";

			this.tailType = TAIL_TYPE_COW;

			this.tailRecharge = 0;

			this.hipRating = 12;

			this.buttRating = 9;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 10;
			this.ass.analLooseness = 0;
			this.createStatusAffect("Bonus aCapacity",38,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}