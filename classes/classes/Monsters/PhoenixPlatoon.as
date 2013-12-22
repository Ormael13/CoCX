package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	/**
	 * ...
	 * @author aimozg
	 */
	public class PhoenixPlatoon extends Monster 
	{
		
		public function PhoenixPlatoon(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ","phoenix platoon","phoenixmob","You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.",true);
			init2Male(new Cock(),0,1,3);
			init2Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_LOOSE);
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY);
			init5Body(rand(8) + 70, HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init6Skin("red");
			init7Hair("black",15);

			this.temperment = 3;

			//Clothing/Armor
			this.armorName = "armor";
			this.weaponName = "spears";
			this.weaponVerb = "stab";
			this.armorDef = 20;

			this.weaponAttack = 20;

			//Primary stats
			this.str = 70;
			this.tou = 60;
			this.spe = 120;
			this.inte = 40;
			this.lib = 40;
			this.sens = 45;
			this.cor = 50;

			this.lustVuln = .15;

			//Combat Stats
			this.bonusHP = 1000;
			this.HP = eMaxHP();
			this.lust = 20;

			//Level Stats
			this.level = 20;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+160;


			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			//Create imp sex attributes
		}
		
	}

}