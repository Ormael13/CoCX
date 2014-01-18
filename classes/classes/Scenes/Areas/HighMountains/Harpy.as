package classes.Scenes.Areas.HighMountains
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Harpy extends Monster
	{

//*Note, special attack one is an idea based on Ceraph.
//About the attack that raises your Lust to 100 if you 
//don't "wait" when she unleashes it. Alright, I 
//basically used the idea, sorry. But it's a neat idea
//so it should be fitting, right? Or you could just 
//dump it out altogether. It'd cause severe damage, 
//in the 150 region if you don't wise up.*

		protected function harpyUberCharge():void
		{
			//(Harpy special attack 1, part one)
			if (hasStatusAffect("Uber") < 0) {
				createStatusAffect("Uber", 0, 0, 0, 0);
				outputText("Flapping her wings frantically, she flies away from you and gains height, hanging in the light before you.  She lets out a shrill and terrifying cry, narrowing her eyes as she focuses in on you!", false);
			}
			//(Harpy special attack 1, part two if PC does anything but "Wait")
			else {
				if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 0) {
					var damage:Number = 160 + rand(20);
					damage = player.takeDamage(damage);
					outputText("The harpy lets out a terrible cry and drops, reaching an almost impossible speed as she dives down at you.  Her eyes are narrowed like a true bird of prey.  You were too busy with your own attack to avoid it!  Her claws surge down and pierce your " + player.armorName + " like paper, driving hard into the flesh beneath and making you cry out in pain.  The harpy dumps you onto the ground, your wounds bleeding profusely. (" + damage + ")", false);
					removeStatusAffect("Uber");
				}
				else {
					outputText("You stand firm and ready yourself as the crazed harpy hovers above you. Letting out an ear-splitting cry she dives at you with her claws extended, reaching an incredible speed before she levels out.  The harpy is heading right for you!  Thanks to your ready position, you manage to dive aside just as the harpy reaches you.  She clips you slightly, spinning you as you dive for the ground.  You hit the ground hard, but look up in time to see her make a rough, graceless landing.  Her body rolls until it reached a standstill.  The enraged harpy drags herself up and takes flight once more!", false);
					player.takeDamage(10 + rand(10));
					removeStatusAffect("Uber");
					HP -= 20;
				}
			}
			combatRoundOver();
		}

		//(Harpy special attack 2, lust increase)
		protected function harpyTease():void
		{
			outputText("The harpy charges at you carelessly, her body striking you with the full weight of her motherly hips.  The pair of you go crashing backwards onto the ground.  You grapple with her weighty ass, trying your best not to think dirty thoughts, but the way she's maniacally flapping and writhing her curvy body against you makes it impossible! After a brief, groping wrestle on the ground, she pushes you away and takes flight again.", false);
			game.dynStats("lus", (12 + rand(player.sens / 5)));
			combatRoundOver();
		}


		override protected function performCombatAction():void
		{
			var select:Number = 1;
			if (hasStatusAffect("Uber") >= 0) {
				harpyUberCharge();
			}
			if (special1 > 0) select++;
			if (special2 > 0) select++;
			if (special3 > 0) select++;
			var rando:int = int(Math.random() * select);
			if (rando == 0) eAttack();
			if (rando == 1) game.eventParser(special1);
			if (rando == 2) game.eventParser(special2);
			if (rando == 3) game.eventParser(special3);
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.highMountains.harpyScene.harpyVictoryuuuuu();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(game.endLustLoss);
			} else {
				game.highMountains.harpyScene.harpyLossU();
			}
		}

		override protected function outputPlayerDodged(dodge:int):void
		{
			outputText("With another deranged cry the harpy dives at you, swinging her razor-sharp talons through the air with the grace of a ballerina. Your quick reflexes allow you to dodge every vicious slash she makes at you.\n", false);
		}

		override public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.", false);
			} else {
				outputText("The harpy surges forward, bringing her razor-sharp claws down on you, tearing at all the exposed flesh she can reach! (" + damage + ")", false);
			}
		}

		public function Harpy(noInit:Boolean=false)
		{
			if (noInit) return;
			trace("Harpy Constructor!");
			init01Names("the ", "harpy", "harpy", "You are fighting a tall, deranged harpy. She appears very human, about six feet six inches tall but covered in a fine layer of powder-blue down. Her arms are sinewy and muscular, with a long web connecting them to her ample hips, covered in stringy blue feathers to aid her flight. A larger pair of powdery-blue wings also protrudes from her shoulder blades, flapping idly. She appears quite deranged as she circles you, approaching and backing away erratically. Her face is quite beautiful, with fine lilac makeup adorning the features of a handsome woman, and her lips are traced with rich golden lipstick. As she circles you, squawking frantically and trying to intimidate you, your eyes are drawn to her slender torso and small, pert breasts, each the size of a small fruit and covered in a layer of the softest feathers which ripple and move with the gusts from her wings. As astounding as her breasts are, her egg-bearing hips are even more impressive.  They're twice as wide as her torso, with enormous, jiggling buttocks where her huge, meaty thighs are coming up to meet them. Her legs end in three-pronged talons; their shadowy black curves glinting evilly in the light.");
			init02Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_GAPING_WIDE, 40);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_TIGHT, ANAL_WETNESS_DRY, 20);
			init05Body("6'6", HIP_RATING_INHUMANLY_WIDE, BUTT_RATING_EXPANSIVE, LOWER_BODY_TYPE_HARPY);
			init06Skin("pink", SKIN_TYPE_PLAIN, "feathers");
			init07Hair("blue", 16);
			init08Face();
			init09PrimaryStats(60, 40, 90, 40, 70, 30, 80);
			init10Weapon("talons", "slashing talons", 15);
			init11Armor("feathers", 5);
			init12Combat(150, 10, .7, Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(10, 10 + rand(4));
			init14ChainedDrop()
					.add(armors.W_ROBES,1/10)
					.elseDrop(consumables.GLDSEED);
			initX_Wings(WING_TYPE_HARPY);
			initX_Specials(harpyUberCharge, harpyTease);

		}

	}

}