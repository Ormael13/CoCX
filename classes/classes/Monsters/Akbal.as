package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Akbal extends Monster
	{
		

		public function Akbal(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Akbal Constructor!");
			this.short="Akbal";
			this.imageName="akbal";

			this.long = "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.";
			this.a ="";

			this.temperment = 1;
			this.special1 = 5125;
			this.special2 = 5126;
			this.special3 = 5127;
			this.pronoun1 = "he";
			this.pronoun2 = "him";
			this.pronoun3 = "his";

			//Clothing/Armor
			this.armorName = "shimmering pelt";
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";
			this.armorDef = 5;

			this.weaponAttack = 5;

			//Primary stats
			this.str = 55;
			this.tou = 53;
			this.spe = 50;
			this.inte = 75;
			this.lib = 50;
			this.sens = 50;
			this.cor = 100;

			//Combat Stats
			this.bonusHP = 20;
			this.HP = eMaxHP();
			this.lust = 30;
			this.lustVuln = 0.8;

			//Level Stats
			this.level = 6;
			this.totalXP(mainClassPtr.player.level)
			this.gems = 15;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 48;
			this.hairColor = "black";
			this.hairLength = 5;

			this.skinTone = "spotted";
			this.skinDesc = "fur";

			this.tailType = TAIL_TYPE_DOG;

			this.hipRating = 2;

			this.buttRating = 2;
			//Create imp sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.breastRows[0].nipplesPerBreast = 0;
			this.createCock();
			this.cocks[0].cockLength = 15;
			this.cocks[0].cockThickness = 2.5;
			this.cocks[0].cockType = CockTypesEnum.HUMAN;
			this.balls = 2;
			this.cumMultiplier = 6;
			this.ballSize = 4;
			this.hoursSinceCum = 400;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 1;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}