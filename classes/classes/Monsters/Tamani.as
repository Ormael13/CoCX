package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Tamani extends Monster 
	{
		
		public function Tamani(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="Tamani";
			this.imageName="tamani";

			this.long = "She keeps her arms folded across her " + mainClassPtr.tamaniChest() + " and glares at you.  The little thing is only about four feet tall, with pink and black dyed hair cut into a cute little 'do.  The greenish-gray skin of her breasts bulges out around her arms, supported by a few leather straps, amplifying her cleavage.  Her cunt lips are pierced multiple times, inflamed, and slightly parted.  There really isn't any clothing on her to hide them, just more of the ever-present straps wrapping around her thighs.";
			this.a ="";

			this.temperment = 2;
			//Regular attack
			this.special1 = 5087;
			//Lust attack
			this.special2 = 5088;

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "leather straps";
			this.weaponName = "fists";
			this.weaponVerb = "tiny punch";

			//Primary stats
			this.str = 32;
			this.tou = 43;
			this.spe = 55;
			this.inte = 62;
			this.lib = 65;
			this.sens = 65;
			this.cor = 50;

			//Combat Stats
			this.bonusHP = 40;
			this.HP = eMaxHP();
			this.lustVuln = 0.9;

			this.lust = 40;

			//Level Stats
			this.level = 4;
			this.XP = totalXP();
			this.gems = rand(25) + 5;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = 40;
			this.hairColor = "pink and black";
			this.hairLength = 16;

			this.skinTone = "greenish gray";
			this.skinDesc = "skin";

			this.hipRating = 8;

			this.buttRating = 8;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 7;
			this.createVagina();
			this.createStatusAffect("Bonus vCapacity",55,0,0,0);
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
			this.vaginas[0].virgin = false;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",40,0,0,0);
			this.ass.analWetness = 0;		
		}
		
	}

}