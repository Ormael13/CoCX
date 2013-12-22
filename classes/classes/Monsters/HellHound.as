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


	public class HellHound extends Monster
	{
		

		public function HellHound(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("HellHound Constructor!");
			init1Names("the ", "hellhound", "hellhound", "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.");
			init2Male([new Cock(8,2),new Cock(8,2)],2,4,5);
			init4Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);
			init5Body(47,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1);
			init6Skin("black",SKIN_TYPE_FUR);
			init7Hair("red",3);

			this.temperment = 3;
			//Regular attack
			this.special1 = 5066;
			//Lust attack
			this.special2 = 5067;

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


			this.tailType = TAIL_TYPE_DOG;

			//Create imp sex attributes

		}

	}

}