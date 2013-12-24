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


	public class InfestedHellhound extends Monster
	{
		

		public function InfestedHellhound(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("InfestedHellhound Constructor!");
			init01Names("the ", "infested hellhound", "infestedhellhound", "It looks like a large four-legged demon with two heads placed side-by-side. Its eyes and mouth are filled with flames, and covering each of its paws are large and menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads are looking at you hungrily as the hellhound circles around you.  A pair of black, slightly pointed cocks hang exposed, dripping with cum and worms.  You get the feeling reasoning with this beast will be impossible.");
			init02Male([new Cock(9,2),new Cock(9,2)],2,5,8);
			init03BreastRows([0],[0],[0]);
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);
			init05Body(47,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1);
			init06Skin("black",SKIN_TYPE_FUR);
			init07Hair("red",3);
			init08Face();
			init09PrimaryStats(65,60,50,1,95,20,100);
			init10Weapon("claws","claw",5);
			init11Armor("thick fur");
			init12Combat(0,50,0.87,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(5,10+rand(10));
			initX_Specials(5066,5067,5107);
			initX_Tail(TAIL_TYPE_DOG);
		}

	}

}