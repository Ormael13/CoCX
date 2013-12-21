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
			init1Names("the ","harpy horde","harpymob","You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.");
			this.plural = true;

			this.temperment = 3;
			//Regular attack

			//Lust attack

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

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