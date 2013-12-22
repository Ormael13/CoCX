package classes.Monsters
{
	import classes.Cock;
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
		
			init1Names("the ", "fetish zealot", "fetishzealot", "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.");
			init2Male(new Cock(7,1.5));
			init4Ass(ANAL_LOOSENESS_LOOSE,ANAL_WETNESS_DRY,40);
			init5Body("6'",HIP_RATING_BOYISH+1,BUTT_RATING_TIGHT);

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
			this.hairColor = "black";
			this.hairLength = 4;

			this.skinTone = "tan";
			this.skinDesc = "skin";


			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}