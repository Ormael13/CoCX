package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Basilisk extends Monster 
	{
		
		public function Basilisk(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "basilisk", "basilisk", "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  It has a thin but ropy build, its tightly muscled yellow underbelly the only part of its frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind its skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at its face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.");
			init2Male([new Cock(6,2)]);
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,30);
			init5Body("7'6",HIP_RATING_SLENDER+1,BUTT_RATING_AVERAGE);

			this.temperment = 2;

			//Clothing/Armor
			this.armorName = "scales";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 10;
			this.weaponAttack = 30;

			this.armorValue = 70;
			//Primary stats
			this.str = 85;
			this.tou = 70;
			this.spe = 35;
			this.inte = 70;
			this.lib = 50;
			this.sens = 35;
			this.cor = 60;

			this.lustVuln = .5;
			this.bonusHP = 200;
			this.HP = eMaxHP();
			this.lust = 30;

			this.level = 12;
			this.XP = totalXP();
			this.gems = rand(10) + 10;

			this.hairColor = "none";
			this.hairLength = 0;

			this.skinType = SKIN_TYPE_SCALES;
			this.skinTone = "gray";
			this.skinDesc = "scales";

			this.tailType = TAIL_TYPE_COW;
			this.tailRecharge = 0;

		}
		
	}

}