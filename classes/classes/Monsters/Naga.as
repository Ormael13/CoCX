package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Naga extends Monster
	{
		

		public function Naga(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Naga Constructor!");
		init1Names("the ", "naga", "naga", "You are fighting a naga. She resembles a beautiful and slender woman from the waist up, with dark hair hanging down to her neck. Her upper body is deeply tanned, while her lower body is covered with shiny scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round C-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, poisonous fangs and a long forked tongue moving rapidly as she hisses at you.");

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5109;
			this.special2 = 5110;
			this.special3 = 5111;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "fist";
			this.weaponVerb = "punch";
			this.armorDef = 5;

			this.weaponAttack = 3;

			//Primary stats
			this.str = 28;
			this.tou = 20;
			this.spe = 35;
			this.inte = 42;
			this.lib = 55;
			this.sens = 55;
			this.cor = 40;

			//Combat Stats

			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 2;
			this.totalXP(mainClassPtr.player.level)
			this.gems = rand(5) + 8;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 70;
			this.hairColor = "brown";
			this.hairLength = 16;

			this.skinTone = "mediterranean-toned";
			this.skinDesc = "skin";

			this.lowerBody = LOWER_BODY_TYPE_GOO;

			this.hipRating = 8;

			this.buttRating = 8;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 3;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",40,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",10,0,0,0);
			this.ass.analWetness = 0;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}