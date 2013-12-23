package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.Cock;
	import classes.Appearance;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Minotaur extends Monster
	{
		

		public function Minotaur(mainClassPtr:*,furColor:String)
		{
			super(mainClassPtr);
			trace("Minotaur Constructor!");
			trace(mainClassPtr.flags);
			//Most times they dont have an axe
			var hasAxe:Boolean = rand(3)==0;
			init01Names("the ","minotaur","minotaur","An angry-looking minotaur looms over you.  Covered in shaggy " + furColor + " fur, the beast is an imposing sight.  Wearing little but an obviously distended loincloth, he is clearly already plotting his method of punishment.  Like most minotaurs he has hooves, a cow-like tail and face, prominent horns, and impressive musculature. ");
			if (hasAxe) this.long += "<b>This minotaur seems to have found a deadly looking axe somewhere!</b>";
			init02Male(new Cock(rand(13) + 24,2 + rand(3),CockTypesEnum.HORSE),2,2+rand(13),1.5,mainClassPtr.player.ballSize * 10);
			if(this.ballSize > 4)
				 this.long += "  Barely visible below the tattered shreds of loincloth are " + Appearance.ballsDescription(true, true, this) + ", swollen with the minotaur's long pent-up need.";
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,30);
			init05Body(rand(37) + 84,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE,LOWER_BODY_TYPE_HOOFED);
			init06Skin(furColor,SKIN_TYPE_FUR,"shaggy fur");
			init07Hair(Appearance.randomChoice("black","brown"),3);
			init09PrimaryStats(hasAxe?75:50,60,30,20,40+ this.ballSize * 2,15+ this.ballSize * 2,35);
			init08Face(FACE_COW_MINOTAUR);
			init10Weapon(hasAxe?"axe":"fist",hasAxe?"cleave":"punch");
			init11Armor("thick fur");
			init12Combat(0,this.ballSize * 3,hasAxe?0.84:0.87,TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(hasAxe?6:5,rand(5) + 5);
			initX_Specials(5029);
			initX_Tail(TAIL_TYPE_SHARK);
			//Extra ball description!
			this.lust                                  = 20 + rand(this.ballSize*2);
		}

	}

}