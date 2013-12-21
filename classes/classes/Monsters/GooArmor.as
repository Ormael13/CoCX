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

			this.temperment = 3;
			//Regular attack

			//Lust attack

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

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
			this.createVagina();
			this.vaginas[0].virgin = false;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING_WIDE;

			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;			
		}
		
	}

}