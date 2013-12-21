package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class FetishZealot extends Monster
	{
		

		public function FetishZealot(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("FetishZealot Constructor!");
		
			this.short="fetish zealot";
			this.imageName="fetishzealot";

			this.long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
			this.a ="the ";

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5103;
			this.special2 = 5104;

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "religious clothes";
			this.weaponName = "wavy dagger";
			this.weaponVerb = "stab";
			this.armorDef = 5;

			this.weaponAttack = 3;

			//Primary stats
			this.str = 35;
			this.tou = 35;
			this.spe = 30;
			this.inte = 1;
			this.lib = 75;
			this.sens = 80;
			this.cor = 90;

			//Combat Stats
			this.HP = eMaxHP();
			this.lust = 25;
			this.lustVuln = 0.75;

			//Level Stats
			this.level = 5;
			this.gems = 5+rand(10);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 72;
			this.hairColor = "black";
			this.hairLength = 4;

			this.skinTone = "tan";
			this.skinDesc = "skin";

			this.hipRating = 1;

			this.buttRating = 2;
			//Create goblin sex attributes
			this.ass.analLooseness = 3;
			this.createStatusAffect("Bonus aCapacity",40,0,0,0);
			this.ass.analWetness = 0;
			this.createCock();
			this.cocks[0].cockLength = 7;
			this.cocks[0].cockThickness = 1.5;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}