package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Gnoll extends Monster 
	{
		
		public function Gnoll(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "gnoll", "gnoll", "This lanky figure is dappled with black spots across rough, tawny fur. Wiry muscle ripples along long legs and arms, all of it seeming in perpetual frenetic motion: every moment half flinching and half lunging.  The head bears a dark muzzle curled in a perpetual leer and bright orange eyes watching with a savage animal cunning.  Between the legs hang what appears at first to be a long, thin dong; however, on closer inspection it is a fused tube of skin composed of elongated pussy lips and clitoris.  The hyena girl is sporting a pseudo-penis, and judging by the way it bobs higher as she jinks back and forth, she's happy to see you!\n\nShe wears torn rags scavenged from some other, somewhat smaller, creature, and in one hand clutches a twisted club.");

			this.temperment = 2;
			//Lusty teases

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "twisted club";
			this.weaponVerb = "smash";
			this.armorDef = 2;

			this.weaponValue = 25;

			//Primary stats
			this.str = 80;
			this.tou = 70;
			this.spe = 75;
			this.inte = 60;
			this.lib = 65;
			this.sens = 25;
			this.cor = 60;

			this.lustVuln = .35;

			//Combat Stats
			this.bonusHP = 250;
			this.HP = eMaxHP();

			this.lust = 30;
		
			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = 10 + rand(5);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 72;
			this.hairColor = "black";
			this.hairLength = 22;

			this.skinTone = "tawny";
			this.skinDesc = "fur";

			this.hipRating = 6;

			this.buttRating = 2;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 3;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 4;
			this.createStatusAffect("Bonus aCapacity",25,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}