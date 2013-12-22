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
			init2Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,40);
			init3BreastRows("C");
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init5Body("5'10",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_GOO);

			this.temperment = 2;
			//Lusty teases
			this.special1 = 5109;
			this.special2 = 5110;
			this.special3 = 5111;

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
			this.hairColor = "brown";
			this.hairLength = 16;

			this.skinTone = "mediterranean-toned";
			this.skinDesc = "skin";

			//Create goblin sex attributes

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}