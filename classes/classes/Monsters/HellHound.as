package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class HellHound extends Monster
	{
		

		public function HellHound(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("HellHound Constructor!");
		init1Names("the ", "hellhound", "hellhound", "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.");

			this.temperment = 3;
			//Regular attack
			this.special1 = 5066;
			//Lust attack
			this.special2 = 5067;

			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "thick fur";
			this.weaponName = "claws";
			this.weaponVerb = "claw";

			this.weaponAttack = 10;

			//Primary stats
			this.str = 55;
			this.tou = 60;
			this.spe = 40;
			this.inte = 1;
			this.lib = 95;
			this.sens = 20;
			this.cor = 100;

			//Combat Stats
			this.HP = eMaxHP();
			this.lust = 25;

			//Level Stats
			this.level = 5;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = 10+rand(10);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 47;
			this.hairColor = "red";
			this.hairLength = 3;

			this.skinTone = "black";
			this.skinDesc = "fur";

			this.tailType = TAIL_TYPE_DOG;

			this.hipRating = 4;

			this.buttRating = 5;
			//Create imp sex attributes
			this.balls = 2;
			this.ballSize = 4;
			this.createCock();
			this.createCock();
			this.cocks[0].cockLength = 8;
			this.cocks[1].cockLength = 8;
			this.cocks[0].cockThickness = 2;
			this.cocks[1].cockThickness = 2;
			this.cumMultiplier = 5;
			this.ass.analLooseness = 2;
			this.ass.analWetness = 1;

		}

	}

}