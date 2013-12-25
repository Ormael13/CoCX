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


	public class TentacleBeast extends Monster
	{


		override protected function performCombatAction():void
		{
			//tentacle beasts have special AI
			if (rand(2) == 0 || hasStatusAffect("TentacleCoolDown") >= 0) mainClassPtr.eventParser(special1);
			else mainClassPtr.eventParser(special2);
		}

		public function TentacleBeast(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("TentacleBeast Constructor!");
			init01Names("the ", "tentacle beast", "tentaclebeast", "You see the massive, shambling form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs.");
			init02Male([new Cock(40,1.5),new Cock(60,1.5),new Cock(50,1.5),new Cock(20,1.5)],0,0,3);
			init02Genderless();
			init03BreastRows();
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(9) + 70,HIP_RATING_BOYISH,BUTT_RATING_BUTTLESS);
			init06Skin("green",SKIN_TYPE_PLAIN,"bark");
			init07Hair("green",1);
			init08Face();
			init09PrimaryStats(58,25,45,45,90,20,100);
			init10Weapon("whip-tendril","thorny tendril",1);
			init11Armor("rubbery skin",1);
			init12Combat(350,10,0.8,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(6,rand(15)+5);
			initX_Specials(5072,5073,5072);


			initX_Tail(TAIL_TYPE_DEMONIC);
		}

	}

}