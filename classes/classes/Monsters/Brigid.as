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
			this.short="Brigid the Jailer";
			this.imageName = "brigid";

			this.long = "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.";
			this.a ="";

			this.temperment = 3;
			//Regular attack

			//Lust attack

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

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
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;

			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 0;			
		}
		
	}

}