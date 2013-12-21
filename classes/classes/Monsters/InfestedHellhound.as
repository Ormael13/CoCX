package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class InfestedHellhound extends Monster
	{
		

		public function InfestedHellhound(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("InfestedHellhound Constructor!");
		this.short="infested hellhound";
			this.imageName="infestedhellhound";

			this.long = "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.";
			this.a ="the ";
			this.temperment = 3;
			//Regular attack
			this.special1 = 5066;
			//Lust attack
			this.special2 = 5067;
			this.special3 = 5107;
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "thick fur";
			this.weaponName = "claws";
			this.weaponVerb = "claw";

			this.weaponAttack = 5;

			//Primary stats
			this.str = 65;
			this.tou = 60;
			this.spe = 50;
			this.inte = 1;
			this.lib = 95;
			this.sens = 20;
			this.cor = 100;

			//Combat Stats
			this.HP = this.tou*2 + 50;
			this.lust = 50;
			this.lustVuln = 0.87;

			//Level Stats
			this.level = 5;
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
			this.ballSize = 5;
			this.createCock();
			this.createCock();
			this.cocks[0].cockLength = 9;
			this.cocks[1].cockLength = 9;
			this.cocks[0].cockThickness = 2;
			this.cocks[1].cockThickness = 2;
			this.cumMultiplier = 8;
			this.ass.analLooseness = 2;
			this.ass.analWetness = 1;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}