package classes.Scenes.Monsters
{
	import classes.CoC;
	import classes.Creature;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.Scenes.Areas.Forest.Tamani;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Goblin extends Monster
	{
		protected function goblinDrugAttack():void {
			var temp2:Number = rand(2);
			if(short == "Tamani") temp2 = rand(5);
			if(short == "Tamani's daughters") temp2 = rand(5);
			var color:String = "";
			if(temp2 == 0) color = "red";
			if(temp2 == 1) color = "green";
			if(temp2 == 2) color = "blue";
			if(temp2 == 3) color = "white";
			if(temp2 == 4) color = "black";
			//Throw offensive potions at the player
			if(color != "blue") {
				if(short == "Tamani's daughters") outputText("Tamani uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.", false);
				else outputText(capitalA + short + " uncorks a glass bottle full of " + color + " fluid and swings her arm, flinging a wave of fluid at you.", false);
			}
			//Drink blue pots
			else {
				if(short == "Tamani's daughters") {
					outputText("Tamani pulls out a blue vial and uncaps it, then douses the mob with the contents.", false);
					if(HPRatio() < 1) {
						outputText("  Though less effective than ingesting it, the potion looks to have helped the goblins recover from their wounds!\n", false);
						addHP(80);
					}
					else outputText("  There doesn't seem to be any effect.\n", false);			
					outputText("\n", false);
				}
				else {
					outputText(capitalA + short + " pulls out a blue vial and uncaps it, swiftly downing its contents.", false);
					if(HPRatio() < 1) {
						outputText("  She looks to have recovered from some of her wounds!\n", false);
						addHP(eMaxHP() /4);
						if(short == "Tamani") addHP(eMaxHP()/4);
					}
					else outputText("  There doesn't seem to be any effect.\n", false);
					combatRoundOver();
				}
				return;
			}
			//Dodge chance!
			if((player.hasPerk("Evasion") >= 0 && rand(10) <= 3) || (rand(100) < player.spe/5)) {
				outputText("\nYou narrowly avoid the gush of alchemic fluids!\n", false);
			}
			else {
				//Get hit!
				if (color == "red") {
					//Temporary heat
					outputText("\nThe red fluids hit you and instantly soak into your skin, disappearing.  Your skin flushes and you feel warm.  Oh no...\n", false);
					if (player.hasStatusAffect("Temporary Heat") < 0) player.createStatusAffect("Temporary Heat", 0, 0, 0, 0);
				}
				else if (color == "green") {
					//Green poison
					outputText("\nThe greenish fluids splash over you, making you feel slimy and gross.  Nausea plagues you immediately - you have been poisoned!\n", false);
					if (player.hasStatusAffect("Poison") < 0) player.createStatusAffect("Poison", 0, 0, 0, 0);
				}
				else if (color == "white") {
					//sticky flee prevention
					outputText("\nYou try to avoid it, but it splatters the ground around you with very sticky white fluid, making it difficult to run.  You'll have a hard time escaping now!\n", false);
					if (player.hasStatusAffect("NoFlee") < 0) player.createStatusAffect("NoFlee", 0, 0, 0, 0);
				}
				else if (color == "black") {
					//Increase fatigue
					outputText("\nThe black fluid splashes all over you and wicks into your skin near-instantly.  It makes you feel tired and drowsy.\n", false);
					game.fatigue(10 + rand(25));
				}
			}
			if (!plural) combatRoundOver();
			else outputText("\n", false);
		}
		protected function goblinTeaseAttack():void {
			var det:Number = rand(3);
			if(det == 0) outputText(capitalA + short + " runs her hands along her leather-clad body and blows you a kiss. \"<i>Why not walk on the wild side?</i>\" she asks.", false);
			if(det == 1) outputText(capitalA + short + " grabs her heel and lifts it to her head in an amazing display of flexibility.  She caresses her snatch and gives you a come hither look.", false);
			if(det == 2) outputText(capitalA + short + " bends over, putting on a show and jiggling her heart-shaped ass at you.  She looks over her shoulder and sucks on her finger, batting her eyelashes.", false);
			game.dynStats("lus", rand(player.lib/10)+8);
			outputText("  The display distracts you long enough to prevent you from taking advantage of her awkward pose, leaving you more than a little flushed.\n\n", false);
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.goblinScene.gobboRapeIntro();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.gender == 0) {
				outputText("You collapse in front of the goblin, too wounded to fight.  She giggles and takes out a tube of lipstick smearing it whorishly on your face.  You pass into unconsciousness immediately.  It must have been drugged.", false);
				game.cleanupAfterCombat();
			} else if (pcCameWorms) {
				outputText("\n\nThe goblin's eyes go wide and she turns to leave, no longer interested in you.", false);
				game.dynStats("lus=", 0);
				doNext(game.cleanupAfterCombat);
			} else {
				game.goblinScene.goblinRapesPlayer();
			}
		}

		public function Goblin(noInit:Boolean=false)
		{
			init01Names("the ", "goblin", "goblin", "The goblin before you is a typical example of her species, with dark green skin, pointed ears, and purple hair that would look more at home on a punk-rocker.  She's only about three feet tall, but makes up for it with her curvy body, sporting hips and breasts that would entice any of the men in your village were she full-size.  There isn't a single scrap of clothing on her, just lewd leather straps and a few clinking pouches.  She does sport quite a lot of piercings – the most noticeable being large studs hanging from her purple nipples.  Her eyes are fiery red, and practically glow with lust.  This one isn't going to be satisfied until she has her way with you.  It shouldn't be too hard to subdue such a little creature, right?");
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL, 40);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,30);
			init05Body(35 + rand(4),HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("dark green");
			init07Hair("purple",4);
			init08Face();
			init09PrimaryStats(12,13,35,42,45,45,60);
			init10Weapon("fists","tiny punch");
			init11Armor("leather straps");
			init12Combat(0,50,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(1,rand(5) + 5);
			init14WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE,1);
			initX_Specials(goblinDrugAttack,goblinTeaseAttack);
		}

	}

}