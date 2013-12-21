package classes.Monsters 
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class ImpHorde extends Monster
	{
		

		public function ImpHorde(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("ImpHorde Constructor!");
			this.short="imp horde";
			this.imageName="impmob";
			this.plural = true;
			this.long = "Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!";
			this.a ="the ";

			this.temperment = 2;
			//Uber

			//Lust attack

			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";

			//Clothing/Armor
			this.armorName = "skin";
			this.weaponName = "fists";
			this.weaponVerb = "punches";

			//Primary stats
			this.str = 20;
			this.tou = 10;
			this.spe = 25;
			this.inte = 12;
			this.lib = 45;
			this.sens = 45;
			this.cor = 100;

			this.lustVuln = .5;

			//Combat Stats
			//int(player.statusAffectv2("Tamani")/2)
			this.bonusHP = 450;
			this.HP = eMaxHP();

			this.lust = 10;

			//Level Stats
			this.level = 10;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = 20 + rand(25);

			//Appearance Variables
			//Gender 1M, 2F, 3H
			this.gender = 1;
			this.tallness = 36;
			this.hairColor = "black";
			this.hairLength = 1;

			this.skinTone = "red";
			this.skinDesc = "skin";

			this.wingDesc = "imp wings";

			this.hipRating = 2;

			this.buttRating = 2;
			//Create goblin sex attributes
			this.createBreastRow();
			this.breastRows[0].breastRating = 0;
			this.ass.analLooseness = 1;
			this.createStatusAffect("Bonus aCapacity",10,0,0,0);
			this.ass.analWetness = 0;
			this.createCock();
			this.cocks[0].cockLength = 12;
			this.cocks[0].cockThickness = 2;

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}