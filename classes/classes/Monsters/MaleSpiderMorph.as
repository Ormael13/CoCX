package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MaleSpiderMorph extends Monster 
	{
		
		public function MaleSpiderMorph(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init01Names("the ", "male spider-morph", "malespidermorph", "The male spider-morph is completely nude, save for his thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of his body - his exoskeleton.  His exposed skin is pale as the full moon, save for the dusk of his nipples and a patch of jet-black that spreads out over his groin, glossing the male's foreskinned cock and dangling sack in glistening ebon.  His ass is small but well-rounded, with a weighty spider-abdomen hanging from just above.  The spider-man is currently eyeing you with a strange expression and his fangs bared.");
			init02Male(new Cock(6,2));
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,40);
			init05Body("7'6",HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1);
			init06Skin("dusky");
			init07Hair("red",13);
			init08Face();
			init09PrimaryStats(60,50,99,99,35,35,20);
			init10Weapon("dagger","stab",15);
			init11Armor("exoskeleton",14,"",70);
			init12Combat(200,20,.6,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(13,rand(10) + 10);
			initX_Tail(TAIL_TYPE_COW,0,0);
			initX_Specials();
		}
		
	}

}