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


	public class InfestedHellhound extends Monster
	{
		

		public function InfestedHellhound(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("InfestedHellhound Constructor!");
			init1Names("the ", "infested hellhound", "infestedhellhound", "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.");
			init2Male([new Cock(9,2),new Cock(9,2)],2,5,8);
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);
			this.temperment = 3;
			//Regular attack
			this.special1 = 5066;
			//Lust attack
			this.special2 = 5067;
			this.special3 = 5107;

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
			this.tallness = 47;
			this.hairColor = "red";
			this.hairLength = 3;

			this.skinTone = "black";
			this.skinDesc = "fur";

			this.tailType = TAIL_TYPE_DOG;

			this.hipRating = 4;

			this.buttRating = 5;
			//Create imp sex attributes

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}