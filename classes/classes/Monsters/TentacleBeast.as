package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class TentacleBeast extends Monster
	{
		

		public function TentacleBeast(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("TentacleBeast Constructor!");
			this.short="tentacle beast";
			this.imageName="tentaclebeast";

			this.long = "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.";
			this.a ="the ";

			this.temperment = 3;
			//Regular attack
			this.special1 = 5072;
			//Lust attack
			this.special2 = 5073;
			this.special3 = 5072;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";

			//Clothing/Armor
			this.armorName = "rubbery skin";
			this.weaponName = "whip-tendril";
			this.weaponVerb = "thorny tendril";
			this.armorDef = 1;

			this.weaponAttack = 1;

			//Primary stats
			this.str = 58;
			this.tou = 25;
			this.spe = 45;
			this.inte = 45;
			this.lib = 90;
			this.sens = 20;
			this.cor = 100;

			//Combat Stats
			this.bonusHP = 350;
			this.HP = eMaxHP();
			this.lustVuln = 0.8;

			this.lust = 10;

			//Level Stats
			this.level = 6;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(15)+5;

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 0;
			this.tallness = rand(9) + 70;
			this.hairColor = "green";
			this.hairLength = 1;

			this.skinTone = "green";
			this.skinDesc = "bark";

			this.tailType = TAIL_TYPE_DEMONIC;

			this.hipRating = 0;

			this.buttRating = 0;
			//Create succubus sex attributes
			this.cumMultiplier = 3;
			this.createCock();
			this.cocks[0].cockLength = 40;
			this.cocks[0].cockThickness = 1.5;
			this.createCock();
			this.cocks[1].cockLength = 60;
			this.cocks[1].cockThickness = 1.5;
			this.createCock();
			this.cocks[2].cockLength = 50;
			this.cocks[2].cockThickness = 1.5;
			this.createCock();
			this.cocks[3].cockLength = 20;
			this.cocks[3].cockThickness = 1.5;
			this.ass.analLooseness = 1;
			this.ass.analWetness = 35;		

		}

	}

}