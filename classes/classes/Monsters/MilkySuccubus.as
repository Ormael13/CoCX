package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class MilkySuccubus extends Monster 
	{
		
		public function MilkySuccubus(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "milky succubus", "milkysuccubus", "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.");
			init2Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,300);
			init3BreastRows("G");
			init4Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init5Body(rand(9) + 60,HIP_RATING_CURVY,BUTT_RATING_LARGE+1,LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS);
			init6Skin("blue");
			init7Hair("black",13);

			this.temperment = 3;
			//Regular attack
			this.special1 = 11020;
			//Lust attack
			this.special2 = 11021;
			this.special3 = 11022;

			//Clothing/Armor
			this.armorName = "demonic skin";
			this.weaponName = "whip";
			this.weaponVerb = "whipping";
			this.armorDef = 10;

			this.weaponAttack = 10;

			this.weaponValue = 150;

			//Primary stats
			this.str = 75;
			this.tou = 50;
			this.spe = 125;
			this.inte = 95;
			this.lib = 90;
			this.sens = 60;
			this.cor = 99;

			//Combat Stats
			this.bonusHP = 700;
			this.HP = eMaxHP();
			this.lustVuln = .3;
			this.lust = 40;

			//Level Stats
			this.level = 16;
			this.XP = totalXP() + 50;
			this.gems = rand(25)+10;


			this.hornType = HORNS_DRACONIC_X2;
			this.wingDesc = "tiny hidden";


			this.tailType = TAIL_TYPE_DEMONIC;

		}
		
	}

}