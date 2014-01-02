package classes.Monsters
{
	import classes.CoC;
	import classes.Appearance;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class MinotaurLord extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.fidoAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.clearOutput();
			outputText("The minotaur lord is defeated!  ");
			outputText("  You could use him for a quick fuck to sate your lusts before continuing on.  Do you?");
			game.menu();
			game.addButton(0,"Fuck",game.winRapeAMinoLordAsUrta);
			game.addButton(4,"Leave",game.beatMinoLordOnToSuccubi);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) game.urtaLosesToMinotaurRoughVersion();
			else game.urtaSubmitsToMinotaurBadEnd();
		}

		public function MinotaurLord()
		{
			init01Names("the ", "minotaur lord", "minotaurlord", "Across from you is the biggest minotaur you've ever seen.  Fully eleven feet tall, this shaggy monstrosity has muscles so thick that they stand even through his thick, obscuring fur.  A leather collar with a tag indicates his status as 'pet' though it seems completely out of place on the herculean minotaur.  His legs and arms are like thick tree trunks, imposing and implacable, flexing fiercely with every movement.  This can only be a minotaur lord, a minotaur of strength and virility far beyond his lesser brothers. In his hands, a massive chain swings, connected to his collar, but used as an impromptu weapon for now.  A simple loincloth girds his groin, though it does little to hide the massive, erect length that tents it.  It winds up looking more like a simple, cloth condom than any sort of clothing, and it drips long strings of musky pre-slime in ribbons onto the ground.  Below, heavy testes, each easily the size of a basketball, swing in a taut, sloshing sack.  You can almost smell the liquid bounty he has for you, and the musk he's giving off makes it seem like a good idea...");
			var ballSize:Number = 2 + rand(13);
			init02Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2, ballSize,1.5,ballSize * 10);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,50);
			init05Body(rand(37) + 84,HIP_RATING_AVERAGE, BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);
			init06Skin("red",SKIN_TYPE_FUR,"shaggy fur");
			init07Hair(Appearance.randomChoice("black","brown"),3);
			init08Face(FACE_COW_MINOTAUR);
			init09PrimaryStats(125,90,30,30,70,25,85);
			init10Weapon("chain","chain-whip",50);
			init11Armor("thick fur");
			init12Combat(700,50,0.33,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(15,rand(5) + 5);
			initX_Tail(TAIL_TYPE_COW);
			initX_Specials(5029);

		}
		
	}

}