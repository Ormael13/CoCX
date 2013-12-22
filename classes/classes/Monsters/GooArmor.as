package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class GooArmor extends Monster 
	{
		
		public function GooArmor(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("a ", "Goo Armor", "gooarmor", "Before you stands a suit of plated mail armor filled with a bright blue goo, standing perhaps six feet off the ground.  She has a beautiful, feminine face, and her scowl as she stands before you is almost cute.  She has formed a mighty greatsword from her goo, and has assumed the stance of a well-trained warrior.");
			init2Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING_WIDE);
			this.gender = 3;
			this.cumMultiplier = 3;
			this.ballSize = 1;
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init5Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);

			this.temperment = 3;
			//Regular attack

			//Lust attack

			//Clothing/Armor
			this.armorName = "armor";
			this.weaponName = "claws";
			this.weaponVerb = "claws";
			this.armorDef = 50;

			this.weaponAttack = 60;

			//Primary stats
			this.str = 60;
			this.tou = 50;
			this.spe = 50;
			this.inte = 40;
			this.lib = 60;
			this.sens = 35;
			this.cor = 50;

			this.lustVuln = .35;

			//Combat Stats
			this.bonusHP = 500;
			this.HP = eMaxHP();
			this.lust = 0;

			//Level Stats
			this.level = 16;
			this.XP = totalXP();
			this.gems = rand(25)+40;

			//Appearance Variables
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			//Create imp sex attributes
		}
		
	}

}