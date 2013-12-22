package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Brigid extends Monster 
	{
		
		public function Brigid(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("", "Brigid the Jailer", "brigid", "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.");
			init2Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY);
			init5Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init6Skin("red");
			init7Hair("black",15);

			this.temperment = 3;

			//Clothing/Armor
			this.armorName = "armor";
			this.weaponName = "poker";
			this.weaponVerb = "burning stab";
			this.armorDef = 20;

			this.weaponAttack = 30;

			//Primary stats
			this.str = 90;
			this.tou = 60;
			this.spe = 120;
			this.inte = 40;
			this.lib = 40;
			this.sens = 45;
			this.cor = 50;

			this.lustVuln = .25;

			//Combat Stats
			this.bonusHP = 1000;
			this.HP = eMaxHP();
			this.lust = 20;

			//Level Stats
			this.level = 19;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+140;


			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;
		}
		
	}

}