package classes.Monsters 
{
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Farmers extends Monster 
	{
		
		public function Farmers(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "farmers", "farmers", "This is a group of thirty angry villagers, almost all human-looking but for the tiny horn-like protrusions growing from their heads and the white fuzz that almost passes off as hair.  They are all armed with pitchforks or other crude farming tools they use in their everyday task.  Rebecc is staring from behind them with horrified eyes at the combat, paralyzed by the sudden turn of events.");
			this.plural = true;

			this.temperment = 3;
			//Regular attack
			this.special1 = 5043;
			//Lust attack
			this.special2 = 5044;

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

			//Clothing/Armor
			this.armorName = "chitin";
			this.weaponName = "pitchforks";
			this.weaponVerb = "stab";

			//Primary stats
			this.str = 40;
			this.tou = 50;
			this.spe = 99;
			this.inte = 99;
			this.lib = 35;
			this.sens = 35;
			this.cor = 20;

			this.lustVuln = 0;

			//Combat Stats
			this.bonusHP = 500;
			this.HP = eMaxHP();
			this.lust = 0;

			//Level Stats
			this.level = 10;
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
			this.createCock();
			this.cocks[0].cockLength = 9;
			this.cocks[0].cockThickness = 2;
			this.cocks[0].cockType = CockTypesEnum.HUMAN;
			this.createVagina();
			this.vaginas[0].virgin = false;
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;

			this.cumMultiplier = 3;
			this.ballSize = 1;
			this.ass.analLooseness = 4;
			this.ass.analWetness = 5;			
		}
		
	}

}