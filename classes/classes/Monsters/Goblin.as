package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Goblin extends Monster
	{
		

		public function Goblin(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Goblin Constructor!");
			init1Names("the ", "goblin", "goblin", "The goblin before you is a typical example of her species, with dark green skin, pointed ears, and purple hair that would look more at home on a punk-rocker.  She's only about three feet tall, but makes up for it with her curvy body, sporting hips and breasts that would entice any of the men in your village were she full-size.  There isn't a single scrap of clothing on her, just lewd leather straps and a few clinking pouches.  She does sport quite a lot of piercings – the most noticeable being large studs hanging from her purple nipples.  Her eyes are fiery red, and practically glow with lust.  This one isn't going to be satisfied until she has her way with you.  It shouldn't be too hard to subdue such a little creature, right?");
			init2Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL, 40);
			init3BreastRows("E");

			this.temperment = 2;
			//Regular attack
			this.special1 = 5087;
			//Lust attack
			this.special2 = 5088;


			//Clothing/Armor
			this.armorName = "leather straps";
			this.weaponName = "fists";
			this.weaponVerb = "tiny punch";

			//Primary stats
			this.str = 12;
			this.tou = 13;
			this.spe = 35;
			this.inte = 42;
			this.lib = 45;
			this.sens = 45;
			this.cor = 60;

			//Combat Stats

			this.HP = eMaxHP();

			this.lust = 50;

			//Level Stats
			this.level = 1;
			this.XP = this.totalXP(mainClassPtr.player.level);
			this.gems = rand(5) + 5;

			//Appearance Variables
			this.tallness = 35 + rand(4);
			this.hairColor = "purple";
			this.hairLength = 4;

			this.skinTone = "dark green";
			this.skinDesc = "skin";

			this.wingType = WING_TYPE_NONE;

			this.hipRating = 8;

			this.buttRating = 8;
			//Create goblin sex attributes
			init4Ass(1,0,30);

		}

	}

}