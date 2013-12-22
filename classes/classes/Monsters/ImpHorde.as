package classes.Monsters
{
	import classes.Cock;
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
			init1Names("the ","imp horde","impmob","Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!",true);
			init2Male(new Cock(12,2));
			init3BreastRows(0);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init5Body(36,HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
			init6Skin("red");
			init7Hair("black",1);

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


			this.wingDesc = "imp wings";

			//Create goblin sex attributes

			this.XP = this.totalXP(mainClassPtr.player.level);
		}

	}

}