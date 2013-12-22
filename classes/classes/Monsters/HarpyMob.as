package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class HarpyMob extends Monster 
	{
		
		public function HarpyMob(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ","harpy horde","harpymob","You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.",true);
			init2Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_GAPING_WIDE);
			this.gender = 3;
			this.cumMultiplier = 3;
			this.ballSize = 1;
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init5Body(rand(8) + 70,HIP_RATING_CURVY+2,BUTT_RATING_LARGE);
			init6Skin("red");
			init7Hair("black",15);

			this.temperment = 3;

			//Clothing/Armor
			this.armorName = "armor";
			this.weaponName = "claw";
			this.weaponVerb = "claw";
			this.armorDef = 20;

			this.weaponAttack = 10;

			//Primary stats
			this.str = 50;
			this.tou = 50;
			this.spe = 120;
			this.inte = 40;
			this.lib = 60;
			this.sens = 45;
			this.cor = 50;

			this.lustVuln = .2;

			//Combat Stats
			this.bonusHP = 1000;
			this.HP = eMaxHP();
			this.lust = 20;

			//Level Stats
			this.level = 18;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+140;


			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

		}
		
	}

}