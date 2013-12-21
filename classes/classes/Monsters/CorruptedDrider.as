package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CorruptedDrider extends Monster 
	{
		
		public function CorruptedDrider(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="corrupted drider";
			this.imageName="corrupteddrider";

			this.a ="the ";

			this.temperment = 2;
			//Lusty teases

			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "carapace";
			this.weaponName = "claws";
			this.weaponVerb = "claw";
			this.armorDef = 55;

			this.weaponAttack = 30;

			this.armorValue = 70;
			//Primary stats
			this.str = 100;
			this.tou = 50;
			this.spe = 70;
			this.inte = 100;
			this.lib = 80;
			this.sens = 50;
			this.cor = 90;

			this.lustVuln = .4;

			//Combat Stats
			this.bonusHP = 250;
			this.HP = eMaxHP();

			this.lust = 30;

			//Level Stats
			this.level = 14;
			this.XP = totalXP();
			this.gems = rand(10) + 20;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 3;
			this.tallness = 120;
			var temp:int = rand(3);
			if(temp == 0) this.hairColor = "red";
			else if(temp == 1) this.hairColor = "orange";
			else if(temp == 2) this.hairColor = "green";
			this.hairLength = 24;

			//SKINTONE USED FOR EYES ON DRIDAH!
			temp = rand(4);
			if(temp == 0) this.skinTone = "yellow";
			else if(temp == 1) this.skinTone = "purple";
			else if(temp == 2) this.skinTone = "red";
			else if(temp == 3) this.skinTone = "turquoise";
			this.skinDesc = "scales";

			this.tailRecharge = 0;

			this.hipRating = 12;

			if(rand(2) == 0) {
				this.nipplesPierced = 1;
				this.lustVuln = .25;
				//Combat Stats
				this.bonusHP = 325;
				this.HP = eMaxHP();
				this.lust = 35;
				//Level Stats
				this.level = 15;
				this.XP = totalXP();
				this.gems = rand(10) + 30;

			}
			this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, D-cup breasts with their shiny black nipples.  ";
			if(this.nipplesPierced > 0) this.long += "Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ";
			this.long += "On her face and forehead, a quartet of lust-filled, " + this.skinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + this.hairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and " + this.hairColor + " stripes - a menacing display if ever you've seen one.";
			this.buttRating = 9;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 5;
			this.createCock();
			this.cocks[0].cockLength = 9;
			this.cocks[0].cockThickness = 2;
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_DROOLING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",70,0,0,0);
			this.createStatusAffect("Bonus vCapacity",70,0,0,0);
			this.ass.analWetness = 0;			
		}
		
	}

}