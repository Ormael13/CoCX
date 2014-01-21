package classes.Scenes.NPCs
{
	import classes.Scenes.Places.Boat.*;
	import classes.CoC;
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
			applyVenom(rand(4 + player.sens / 20) + 1);
			return 1;
		}

		//Apply the effects of AnemoneVenom()
		public function applyVenom(str:Number = 1):void
		{
			//First application
			if (player.hasStatusAffect("Anemone Venom") < 0) player.createStatusAffect("Anemone Venom", 0, 0, 0, 0);
			//Gain some lust
			game.dynStats("lus", (2 * str));

			//Loop through applying 1 point of venom at a time.
			while (str > 0) {
				str--;
				//Str bottommed out, convert to lust
				if (player.str < 2) game.dynStats("lus", 2);
				//Lose a point of str.
				else {
					showStatDown("str");
					// strDown.visible = true;
					// strUp.visible = false;
					player.str--;
					player.addStatusValue("Anemone Venom", 1, 1);
				}
				//Spe bottomed out, convert to lust
				if (player.spe < 2) game.dynStats("lus", 2);
				//Lose a point of spe.
				else {
					showStatDown("spe");
					// speDown.visible = true;
					// speUp.visible = false;
					player.spe--;
					player.addStatusValue("Anemone Venom", 2, 1);
				}
			}
			game.statScreenRefresh();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.anemoneScene.defeatAnemone();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to mind at all...");
				doNext(game.endLustLoss);
			} else {
				game.anemoneScene.loseToAnemone();
			}
		}

		override public function outputAttack(damage:int):void
		{
			outputText("You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.", false);
		}

		public function Anemone()
		{
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
			init14FixedDrop(consumables.DRYTENT);
		}
		
	}

}