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


	public class Akbal extends Monster
	{

		override public function eAttack():void
		{
			game.akabalAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.victoryChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				game.doNext(game.endLustLoss);
			} else {
				game.loseToAckballllllz();
			}
		}

		public function Akbal(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("Akbal Constructor!");
			init01Names("", "Akbal", "akbal", "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.");
			init02Male([new Cock(15,2.5,CockTypesEnum.DOG)],2,4,6,400);
			init03BreastRows([0],[0],[0],[0]);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body("4'",HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
			init06Skin("spotted",SKIN_TYPE_FUR);
			init07Hair("black",5);
			init08Face();
			init09PrimaryStats(55,53,50,75,50,50,100);
			init10Weapon("claws","claw-slash",5);
			init11Armor("shimmering pelt",5);
			init12Combat(20,30,0.8,TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(6,15);
			initX_Specials(5125,5126,5127);
			initX_Tail(TAIL_TYPE_DOG);
		}

	}

}