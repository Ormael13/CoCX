package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class SharkGirl extends Monster
	{
		
		public function SharkGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("SharkGirl Constructor!");
			init1Names("the ", "shark-girl", "sharkgirl", "The shark girl stands just over 5'5\", with grey skin shimmering from water droplets catching the sunlight and slender muscles built for swimming.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts and tight snatch.");
			init2Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_NORMAL,15);
			init3BreastRows("D");
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,40);
			init5Body("5'5",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			this.temperment = 2;
			//Lusty teases
			this.special1 = 5097;
			this.special2 = 5097;

			//Clothing/Armor
			this.armorName = "tough skin";
			this.weaponName = "shark teeth";
			this.weaponVerb = "bite";
			this.armorDef = 5;

			this.weaponAttack = 3;

			//Primary stats
			this.str = 40;
			this.tou = 40;
			this.spe = 55;
			this.inte = 42;
			this.lib = 75;
			this.sens = 35;
			this.cor = 40;

			//Combat Stats
			this.bonusHP = 20;
			this.HP = eMaxHP();
			this.lustVuln = .9;

			this.lust = 40;

			//Level Stats
			this.level = 4;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(15) + 5;

			//Appearance Variables
			this.hairColor = "silver";
			this.hairLength = 16;

			this.skinTone = "gray";
			this.skinDesc = "skin";

			//Create goblin sex attributes

		}

	}

}