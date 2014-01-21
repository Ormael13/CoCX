package classes.Scenes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Imp extends Monster
	{


		//Special Attack 1
		protected function impFire():void
		{
			outputText("The imp mutters something to himself, before you have time to react the demonic creature's hand is filled with a bright red fire that he hurls at you.  The flames lick at your body leaving a painful burn or you torso, as well as an arousing heat in your groin.");
			//[-HP // +Lust(minor)]
			var damage:int = 40 + rand(10);
			player.takeDamage(damage);
			game.dynStats("lus", 20 + player.cor / 10);
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hasStatusAffect("Kitsune Fight") >= 0) {
				game.forest.kitsuneScene.winKitsuneImpFight();
			} else {
				game.impScene.impVictory();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hasStatusAffect("Kitsune Fight") >= 0) {
				game.forest.kitsuneScene.loseKitsuneImpFight();
			} else if (pcCameWorms) {
				outputText("\n\nThe imp grins at your already corrupted state...", false);
				player.lust = 100;
				doNext(game.impScene.impRapesYou);
			} else {
				game.eventParser(game.impScene.impRapesYou);
			}
		}

		public function Imp(noInit:Boolean=false)
		{
			if (noInit) return;
			trace("Imp Constructor!");
			init01Names("the ", "imp", "imp", "An imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.");
			init02Male([new Cock(rand(2) + 11, 2.5, CockTypesEnum.DEMON)], 2, 1);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED, ANAL_WETNESS_NORMAL);
			init05Body(rand(24) + 25, HIP_RATING_BOYISH, BUTT_RATING_TIGHT);
			init06Skin("red");
			init07Hair("black", 5);
			init09PrimaryStats(20, 10, 25, 12, 45, 45, 100);
			init08Face();
			init10Weapon("claws", "claw-slash");
			init11Armor("leathery skin");
			init12Combat(0, 40, 1, 1);
			init13Level(1, rand(5) + 5);
			init14WeightedDrop().
					add(consumables.SUCMILK,3).
					add(consumables.INCUBID,3).
					add(consumables.IMPFOOD,4);
			initX_Specials(5019,impFire);
			initX_Wings(WING_TYPE_IMP);

		}

	}

}