package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SandTrap extends Monster 
	{
		
		public function SandTrap(mainClassPtr:*) 
		{
			super(mainClassPtr);
			//1/3 have fertilized eggs!
			if(rand(3) == 0) this.createStatusAffect("Fertilized",0,0,0,0);
			init1Names("the ", mainClassPtr.silly()?"sandtrap":"sand tarp", "sandtrap", "You are fighting the sandtrap.  It sits half buried at the bottom of its huge conical pit, only its lean human anatomy on show, leering at you from beneath its shoulder length black hair with its six equally sable eyes.  You cannot say whether its long, soft face with its pointed chin is very pretty or very handsome - every time the creature's face moves, its gender seems to shift.  Its lithe, brown flat-chested body supports four arms, long fingers playing with the rivulets of powder sand surrounding it.  Beneath its belly you occasionally catch glimpses of its insect half: a massive sand-coloured abdomen which anchors it to the desert, with who knows what kind of anatomy.");
			init2Male(new Cock(10,2,CockTypesEnum.HUMAN),2,4,3);
			init3BreastRows();
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY);

			this.temperment = 3;
			//Regular attack

			//Lust attack

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "chitin";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 20;

			this.weaponAttack = 10;

			//Primary stats
			this.str = 55;
			this.tou = 10;
			this.spe = 45;
			this.inte = 55;
			this.lib = 60;
			this.sens = 45;
			this.cor = 50;

			this.lustVuln = .55;

			//Combat Stats
			this.bonusHP = 100;
			this.HP = eMaxHP();
			this.lust = 20;

			//Level Stats
			this.level = 4;
			this.XP = totalXP();
			this.gems = 2 + rand(5);

			//Appearance Variables
			this.tallness = rand(8) + 150;
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "fair";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 8;

			this.buttRating = 8;
		}
		
	}

}