package classes.Monsters 
{
	import classes.Monster;
	/**
	 * ...
	 * @author aimozg
	 */
	public class GooGirl extends Monster
	{
		
		public function GooGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			this.short="goo-girl";
			this.imageName="googirl";

			this.long = "The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow.";
			if(mainClassPtr.player.biggestTitSize() >= 3) this.long += "  She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + mainClassPtr.biggestBreastSizeDescript()+ ".";
			this.a ="the ";

			this.temperment = 3;
			this.special1 = 5040;
			this.special2 = 5039;
			this.special3 = 5039;
			this.pronoun1 = "she";
			this.pronoun2 = "her";
			this.pronoun3 = "her";

			//Clothing/Armor
			this.armorName = "gelatinous skin";
			this.weaponName = "hands";
			this.weaponVerb = "slap";

			//Primary stats
			this.str = 25;
			this.tou = 25;
			this.spe = 20;
			this.inte= 30;
			this.lib = 50;
			this.sens= 40;
			this.cor = 10;

			//Combat Stats
			this.bonusHP = 40;
			this.HP = eMaxHP();
			this.lust = 45;

			//Level Stats
			this.level = 3;
			this.XP = totalXP();
			this.gems = rand(5)+1;
			this.lustVuln = .75;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 2;
			this.tallness = rand(8) + 70;

			this.hairLength = 0;

			var temp:int = rand(3);
			if(temp == 0) this.skinTone = "blue";
			else if(temp == 1) this.skinTone = "purple";
			else this.skinTone = "crystal";
			this.hairColor = this.skinTone;
			this.skinDesc = "skin";

			this.hipRating = 6;

			this.buttRating = 8;
			//Create imp sex attributes
			this.createVagina();
			this.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLAVERING;
			this.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;

			this.ass.analLooseness = 1;
			this.ass.analWetness = 5;
			this.createStatusAffect("Bonus aCapacity",9001,0,0,0);
			this.createStatusAffect("Bonus vCapacity",9001,0,0,0);			
		}
		
	}

}