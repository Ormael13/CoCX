package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Anemone extends Monster 
	{


		override public function eAttack():void
		{
			outputText("Giggling playfully, the anemone launches several tentacles at you.  Most are aimed for your crotch, but a few attempt to caress your chest and face.\n", false);
			super.eAttack();
		}

		override public function eOneAttack():int
		{
			if (attackSucceeded()){
				game.applyVenom(rand(4 + player.sens / 20) + 1);
			}
			return 1;
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatAnemone();
		}

		override public function outputAttack(damage:int):void
		{
			outputText("You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.", false);
		}

		public function Anemone(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("the ", "anemone", "anemone", "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.");
			init02Male(new Cock(7,1,CockTypesEnum.ANEMONE));
			init02Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE, 5);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY,10);
			init05Body("5'5",BUTT_RATING_NOTICEABLE,HIP_RATING_CURVY);
			init06Skin("purple");
			init07Hair("purplish-black",20,HAIR_ANEMONE);
			init08Face();
			init09PrimaryStats(40,20,40,50,55,35,50);
			init10Weapon("tendrils","tentacle",5);
			init11Armor("clammy skin");
			init12Combat(120,30,.9,TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(4,rand(5) + 1);
		}
		
	}

}