package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Shouldra extends Monster 
	{
		
		public function Shouldra(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "plain girl", "shouldra", "Her face has nothing overly attractive about it; a splash of freckles flits across her cheeks, her brows are too strong to be considered feminine, and her jaw is a tad bit square. Regardless, the features come together to make an aesthetically pleasing countenance, framed by a stylish brown-haired bob. Her breasts are obscured by her grey, loose-fitting tunic, flowing down to reach the middle of her thigh. Her legs are clad in snug, form-fitting leather breeches, and a comfortable pair of leather shoes shield her soles from the potentially harmful environment around her.");
			init2Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_NORMAL,40,true);
			init3BreastRows("D");
			init4Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,40);
			init5Body(65,HIP_RATING_AMPLE,BUTT_RATING_AVERAGE+1);
			init6Skin("white");
			init7Hair("white",3);

			this.temperment = 1;

			//Clothing/Armor
			this.armorName = "comfortable clothes";
			this.weaponName = "fists";
			this.weaponVerb = "punches";

			//Primary stats
			this.str = 45;
			this.tou = 30;
			this.spe = 5;
			this.inte = 110;
			this.lib = 100;
			this.sens = 0;
			this.cor = 33;

			//Combat Stats
			this.bonusHP = 30;
			this.HP = eMaxHP();
			this.lustVuln = 1;
			this.lust = 10;

			//Level Stats
			this.level = 4;
			this.XP = totalXP();
			this.gems = 0;


		}
		
	}

}