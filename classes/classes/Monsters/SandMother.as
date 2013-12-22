package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SandMother extends Monster 
	{
		
		public function SandMother(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "Sand Mother", "sandmother", "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.");
			init2Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_LOOSE,70);
			init3BreastRows(["DD"],["DD"]);
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL,50);
			init5Body("8'6",HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init6Skin("bronzed");
			init7Hair("platinum-blonde",15);

			this.temperment = 3;
			//Regular attack
			this.special1 = 11020;
			//Lust attack
			this.special2 = 11021;
			this.special3 = 11022;

			//Clothing/Armor
			this.armorName = "robes";
			this.weaponName = "fists";
			this.weaponVerb = "punches";
			this.armorDef = 1;

			this.weaponValue = 150;

			//Primary stats
			this.str = 55;
			this.tou = 55;
			this.spe = 35;
			this.inte = 45;
			this.lib = 55;
			this.sens = 40;
			this.cor = 30;

			//Combat Stats
			this.bonusHP = 130;
			this.HP = eMaxHP();
			this.lustVuln = .6;
			this.lust = 20;

			//Level Stats
			this.level = 7;
			this.XP = totalXP();
			this.gems = rand(15) + 55;



			//Create imp sex attributes
			this.createPerk("Resolute",0,0,0,0);
			this.createPerk("Focused",0,0,0,0);
		}
		
	}

}