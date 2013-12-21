﻿package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Harpy extends Monster
	{
		

		public function Harpy(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Harpy Constructor!");
			init1Names("the ", "harpy", "harpy", "You are fighting a tall, deranged harpy. She appears very human, about six feet six inches tall but covered in a fine layer of powder-blue down. Her arms are sinewy and muscular, with a long web connecting them to her ample hips, covered in stringy blue feathers to aid her flight. A larger pair of powdery-blue wings also protrudes from her shoulder blades, flapping idly. She appears quite deranged as she circles you, approaching and backing away erratically. Her face is quite beautiful, with fine lilac makeup adorning the features of a handsome woman, and her lips are traced with rich golden lipstick. As she circles you, squawking frantically and trying to intimidate you, your eyes are drawn to her slender torso and small, pert breasts, each the size of a small fruit and covered in a layer of the softest feathers which ripple and move with the gusts from her wings. As astounding as her breasts are, her egg-bearing hips are even more impressive.  They're twice as wide as her torso, with enormous, jiggling buttocks where her huge, meaty thighs are coming up to meet them. Her legs end in three-pronged talons; their shadowy black curves glinting evilly in the light.");
			init2Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_GAPING_WIDE,40);

			this.temperment = 2;
			//Uber
			this.special1 = 5136;
			//Lust attack
			this.special2 = 5137;


			//Clothing/Armor
			this.armorName = "feathers";
			this.weaponName = "talons";
			this.weaponVerb = "slashing talons";
			this.armorDef = 5;

			this.weaponAttack = 15;

			//Primary stats
			this.str = 60;
			this.tou = 40;
			this.spe = 90;
			this.inte = 40;
			this.lib = 70;
			this.sens = 30;
			this.cor = 80;

			this.lustVuln = .6;

			//Combat Stats
			//int(player.statusAffectv2("Tamani")/2)
			this.bonusHP = 150;
			this.HP = eMaxHP();
			this.lustVuln = .7;

			this.lust = 10;

			//Level Stats
			this.level = 10;
			this.XP = this.totalXP(mainClassPtr.player.level);;
			this.gems = 10 + rand(4);

			//Appearance Variables
			this.tallness = 78;
			this.hairColor = "blue";
			this.hairLength = 16;

			this.skinTone = "pink";
			this.skinDesc = "feathers";

			this.wingDesc = "large feathery wings";

			this.wingType = WING_TYPE_HARPY;

			this.hipRating = 20;

			this.buttRating = 13;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 2;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",20,0,0,0);
			this.ass.analWetness = 0;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}