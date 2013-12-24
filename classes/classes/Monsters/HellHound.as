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


	public class HellHound extends Monster
	{
		

		public function HellHound(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("HellHound Constructor!");
			init01Names("the ", "hellhound", "hellhound", "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.");
			init02Male([new Cock(8,2),new Cock(8,2,CockTypesEnum.DOG)],2,4,5);
			init03BreastRows([0],[0],[0]);
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);
			init05Body(47,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1);
			init06Skin("black",SKIN_TYPE_FUR);
			init07Hair("red",3);
			init08Face();
			init09PrimaryStats(55,60,40,1,95,20,100);
			init10Weapon("claws","claw",10);
			init11Armor("thick fur");
			init12Combat(0,25,1,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(5,10+rand(10));
			initX_Tail(TAIL_TYPE_DOG);
			initX_Specials(5066,5067);
		}

	}

}