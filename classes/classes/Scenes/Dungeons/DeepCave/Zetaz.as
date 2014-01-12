package classes.Scenes.Dungeons.DeepCave
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Zetaz extends Monster 
	{


		override public function doAI():void
		{
			game.zetazAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatZetaz();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem put off enough to care...");
				doNext(game.endLustLoss);
			} else {
				game.loseToZetaz();
			}
		}

		public function Zetaz()
		{
			init01Names("","Zetaz","zetaz","Zetaz has gone from a pipsqueak to the biggest imp you've seen!  Though he has the familiar red skin, curving pointed horns, and wings you would expect to find on an imp, his feet now end in hooves, and his body is covered with thick layers of muscle.  If the dramatic change in appearance is any indication, he's had to toughen up nearly as much as yourself over the past "+(game.model.time.days < 60? "weeks":"months")+".  Zetaz still wears the trademark imp loincloth, though it bulges and shifts with his movements in a way that suggest a considerable flaccid size and large, full sack.  His shoulders are wrapped with studded leather and his wrists are covered with metallic bracers.  The imp has clearly invested in at least a little additional protection.  It does not look like he carries a weapon.");
			init02Male(new Cock(rand(2) + 11,2.5,CockTypesEnum.DEMON),2,1,3,20);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY);
			init05Body("4'1",HIP_RATING_BOYISH,BUTT_RATING_TIGHT,LOWER_BODY_TYPE_KANGAROO);
			init06Skin("red");
			init07Hair("black",5);
			init08Face();
			init09PrimaryStats(65,60,45,52,55,35,100);
			init10Weapon("claws","claw-slash");
			init11Armor("leathery skin");
			init12Combat(350,40,.35,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(12,rand(55) + 150,100);
			init14FixedDrop(consumables.BIMBOLQ);
			initX_Specials(special1,special2,special3);
			initX_Wings(WING_TYPE_IMP,"small");
		}
		
	}

}