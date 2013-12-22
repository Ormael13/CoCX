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


	public class GreenSlime extends Monster
	{
		

		public function GreenSlime(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("GreenSlime Constructor!");
			init1Names("a ", "green slime", "greenslime", "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.");
			init2Male(new Cock(18,2,CockTypesEnum.HUMAN),0,1,3,20);
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init5Body(rand(8) + 80,HIP_RATING_AMPLE,BUTT_RATING_LARGE);

			this.temperment = 3;
			this.special1 = 5040;
			this.special2 = 5039;
			this.special3 = 5039;


			//Clothing/Armor
			this.armorName = "gelatinous skin";
			this.weaponName = "hands";
			this.weaponVerb = "slap";

			//Primary stats
			this.str = 25;
			this.tou = 20;
			this.spe = 10;
			this.inte = 5;
			this.lib = 50;
			this.sens = 60;
			this.cor = 20;

			//Combat Stats
			this.bonusHP = 30;
			this.HP = eMaxHP();
			this.lust = 30;

			//Level Stats
			this.level = 2;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5)+1;

			//Appearance Variables
			this.hairColor = "green";
			this.hairLength = 0;

			this.skinTone = "green";
			this.skinDesc = "skin";

		}

	}

}