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
			init01Names("the ", "plain girl", "shouldra", "Her face has nothing overly attractive about it; a splash of freckles flits across her cheeks, her brows are too strong to be considered feminine, and her jaw is a tad bit square. Regardless, the features come together to make an aesthetically pleasing countenance, framed by a stylish brown-haired bob. Her breasts are obscured by her grey, loose-fitting tunic, flowing down to reach the middle of her thigh. Her legs are clad in snug, form-fitting leather breeches, and a comfortable pair of leather shoes shield her soles from the potentially harmful environment around her.");
			init02Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_NORMAL,40,true);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,40);
			init05Body(65,HIP_RATING_AMPLE,BUTT_RATING_AVERAGE+1);
			init06Skin("white");
			init07Hair("white",3);
			init08Face();
			init09PrimaryStats(45,30,5,110,100,0,33);
			init10Weapon("fists","punches");
			init11Armor("comfortable clothes");
			init12Combat(30,10,1,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(4,0);
			initX_Specials();


		}
		
	}

}