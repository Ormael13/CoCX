package classes.Monsters 
{
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
			this.short="phoenix platoon";
			this.imageName="phoenixmob";
			this.plural = true;
			this.long = "You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.";
			this.a ="the ";

			this.temperment = 3;
			//Regular attack

			//Lust attack

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

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

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = rand(8) + 70;
			this.hairColor = "black";
			this.hairLength = 15;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.hornType = HORNS_DEMON;

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 8;

			this.buttRating = 8;
			//Create imp sex attributes
			this.createCock();
			this.createVagina();
			this.vaginas[0].virgin = false;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;

			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 0;			
		}
		
	}

}