package classes.Scenes.Areas.Mountain
{
	import classes.CoC;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.Cock;
	import classes.Appearance;
	import classes.internals.Utils;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Minotaur extends Monster
	{
		public var hasAxe:Boolean;


		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusAffect("PhyllaFight") >= 0) {
				removeStatusAffect("PhyllaFight");
				outputText("You defeat a minotaur!  ", true);
				game.desert.antsScene.phyllaBeatAMino();
			} else {
				game.mountain.minotaurScene.minoVictoryRapeChoices();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusAffect("PhyllaFight") >= 0) {
				removeStatusAffect("PhyllaFight");
				game.desert.antsScene.phyllaPCLostToMino();
			} else if (pcCameWorms){
				outputText("\n\nThe minotaur picks you up and forcibly tosses you from his cave, grunting in displeasure.", false);
				game.cleanupAfterCombat();
			} else
				game.eventParser(game.mountain.minotaurScene.getRapedByMinotaur);
		}

		override public function get long():String
		{
			return "An angry-looking minotaur looms over you.  Covered in shaggy " + hairColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. "+
					(ballSize > 4?("  Barely visible below the tattered shreds of loincloth are " + Appearance.ballsDescription(true, true, this) + ", swollen with the minotaur's long pent-up need."):"")+
					(hasAxe?"<b>This minotaur seems to have found a deadly looking axe somewhere!</b>":"");
		}

		public function Minotaur(axe:Boolean=false)
		{
			//Most times they dont have an axe
			hasAxe = axe || rand(3)==0;
			var furColor:String = randomChoice("black","brown");

			trace("Minotaur Constructor!");
			trace(game.flags);
			init01Names("the ","minotaur","minotaur","");
			var ballSize:Number = 2 + rand(13);
			init02Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2, ballSize,1.5,ballSize * 10);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,30);
			init05Body(rand(37) + 84,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE,LOWER_BODY_TYPE_HOOFED);
			init06Skin(furColor,SKIN_TYPE_FUR,"shaggy fur");
			init07Hair(furColor,3);
			init09PrimaryStats(hasAxe?75:50,60,30,20,40+ this.ballSize * 2,15+ this.ballSize * 2,35);
			init08Face(FACE_COW_MINOTAUR);
			init10Weapon(hasAxe?"axe":"fist",hasAxe?"cleave":"punch");
			init11Armor("thick fur");
			init12Combat(20 + rand(this.ballSize*2),this.ballSize * 3,hasAxe?0.84:0.87,TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(hasAxe?6:5,rand(5) + 5);
			if (hasAxe) {
				init14FixedDrop(consumables.MINOBLO);
			} else {
				init14ChainedDrop()
						.add(consumables.MINOCUM, 1 / 5)
						.add(consumables.MINOBLO, 1 / 2)
						.elseDrop(null);
			}
			initX_Specials(game.mountain.minotaurScene.minoPheromones);
			initX_Tail(TAIL_TYPE_COW);
		}

	}

}