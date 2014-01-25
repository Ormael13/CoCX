package classes.Scenes.Areas.HighMountains 
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	
	/**
	 * Izumi, the fuckhuge Oni. TOUCH THE FLUFFY HORN.
	 * Most of the combat damage and stats will need to actually be tuned. I have no idea about what
	 * these values should be for the intended effect.
	 * 
	 * @author FeatureCreep
	 * @editor Gedan
	 * @programmer Gedan
	 */
	public class Izumi extends Monster
	{
		
		public function Izumi() 
		{
			init01Names("", "Izumi", "izumi", "You're fighting the immense Oni, Izumi.  Standing around 9 feet tall and weilding little more than her fists, she is the picture of strength and power.  She is clad in a scandalous blue and white Kimono, the garment drawing your eyes to her humongous breasts, and her perfectly sculpted thighs.  A curious horn juts from her head, the texture of it almost lost amongst the rock lining the inside of the cave.\n\nA distinctly cocky grin is painted across her face, her undivided attention focused upon you.");
			
			init02Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_NORMAL);
			init03BreastRows("FF"); // The doc mentions her breasts would be around D/DD on a "normal human" so err, winging this shit
			init04Ass(ANAL_LOOSENESS_TIGHT, ANAL_WETNESS_DRY);
			init05Body("9'0", HIP_RATING_AVERAGE, BUTT_RATING_TIGHT);
			init06Skin("creamy-white");
			init07Hair("golden", 25);
			init08Face();
			init09PrimaryStats(90, 90, 90, 80, 30, 25, 0);
			init10Weapon("fist", "punch");
			init11Armor("silken kimono");
			init12Combat(600, 0, 1, Monster.TEMPERMENT_LOVE_GRAPPLES, 0);
			init13Level(22, 25 + rand(25), 75);
		}

		// Override won/lost calls
		override public function defeated(hpVictory:Boolean):void
		{
			game.izumiScenes.pcBeatIzumiIntro();
		}
		
		// Monster won, not player, gg for descriptive method names
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			// Need to handle the special grab she does (later...)
			game.izumiScenes.izumiBeatPCIntro();
		}
		
		// Override combat AI
		override protected function performCombatAction():void
		{
			// Handle chokeslam mechanics
			if (player.hasStatusAffect("Chokeslam") >= 0)
			{
				player.statusAffectv2("Chokeslam") -= 1;
				
				if (player.statusAffectv2("Chokeslam") == 0)
				{
					chokeSlamDamage();
				}
			}
			
			// Handle groundpound
			if (player.hasStatusAffect("Groundpound") >= 0)
			{
				player.statusAffectv1("Groundpound") -= 1;
				
				if (player.statusAffectv1("Groundpound") == 0)
				{
					cleanupGroundpound();
				}
			}
			
			var actions:Array = [straightJab, roundhouseKick, chokeSlam]; 
			actions[rand(actions.length)]();
		}
		
		// Remove any lingering effects from the player once combat is over
		public function cleanup():void
		{
			cleanupChokeslam();
			cleanupGroundpound();
		}
		
		// Quick punch at the player
		// Light damage
		public function straightJab():void
		{
			outputText("Quick as a flash, Izumi lashes out with her free hand, aiming for your head.");

			var damage:int = int ((str + 85) - rand(player.tou) - player.armorDef);
			if (combatMiss() && combatEvade() && combatFlexibility() && combatMisdirect())
			{
				outputText("  You deftly dodge under the lightning-quick punch.");
			}
			else if (damage <= 0)
			{
				outputText("  You lash out and manage to deflect the blow before it can connect.");
			}
			else
			{
				outputText("  Her fist connects with your chin with a mighty crack, sending you sailing across the cave.  Izumi smirks at you as you [if (player.isNaga)raise back up onto your [legs]|stand] and dust yourself off.");
				damage = player.takeDamage(damage);
				outputText("(" + damage + ")");
			}
			combatRoundOver();
		}

		// Roundhouse Kick
		// Milkd lust increase
		public function roundhouseKick():void
		{
			outputText("Izumi leaps backwards onto one foot, spinning around and unleashing a thundering roundhouse kick.  Luckily, you manage to duck just in time, avoiding what surely would have been a monstrously powerful blow.  Unfortunately, as Izumi’s leg scythes through the air over your head, you find your gaze naturally following the line of her thigh muscles until you’re staring directly up the fluttering folds of Izumi’s increasingly impractical kimono.\n\n");

			if (player.cor >= 66 || player.lib >= 50 || player.lust > 50)
			{
				outputText("You fall backwards and stagger away, already feeling a flush of warmth colouring your cheeks, trying to drag your mind back to the fight and away from... other things.");

				game.dynStats("lus", 10 + player.lib / 10);
			}
			else
			{
				outputText("You furrow a brow at the Oni's ineffectual attack, not entirely sure if she was intending to hurt you or turn you on.  Her thighs did look rather tantalizing though...");

				game.dynStats("lus", 5 + player.lib / 20);
			}

			combatRoundOver();
		}
		
		// Bind player for 3 turns. If the player doesn't break out in time, they take huge damage.
		// On escape, Izumi takes some damage
		public function chokeSlam():void
		{
			if (combatMiss() && combatEvade() && combatFlexibility() && combatMisdirect())
			{
				outputText("Izumi surges towards you, closing the distance between you within the blink of an eye. You narrowly avoid her crushing grip, twisting away from her grasp at the last moment.  The enormous Oni lets loose a deep, satisfied laugh.");
			}
			else
			{
				outputText("Izumi surges towards you, smashing aside your guard and seizing you by the throat in the blink of an eye.  Lifting you above her head, you can only struggle to breathe as the enormous Oni grins at you like some sort of prize.");
				player.createStatusAffect("Chokeslam", 3, 0, 0, 0);
			}
			combatRoundOver();
		}
		
		// Struggle against izumi's chokeslam
		public function chokeSlamStruggle():void
		{
			clearOutput();
			
			var brokeFree:Boolean;
			
			if (rand(player.str) > this.str / 2)
			{
				brokeFree = true;
			}
			
			if (brokeFree)
			{
				chokeSlamDamage();
				combatRoundOver();
			}
			else
			{
				outputText("Izumi's grip around your throat continues to strangle the breath from your lungs as she holds you aloft.  Your fingers tighten in turn around the Oni's wrist, fighting against her[if (player.str < 90)immense|impressive] strength, in an attempt to free yourself from her crushing embrace, without success.");
				player.takeDamage(15 + rand(15));
				doAI();
			}
		}
		
		// OH HEY ITS A THING
		public function chokeSlamWait():void
		{
			clearOutput();
			
			outputText("Your feet dangle uselessly in the air as Izumi holds you aloft.  Why bother resisting?  She's just so <i>strong</i>, her fingers wrapped so completely around your neck...");
			player.takeDamage(15 + rand(15));
			
			if (flags[kFLAGS.PC_FETISH] >= 2)
			{
				outputText(" and to be honest, her grip isn't an entirely unplesent experience, either.  If only Izumi would stop playing around and just <i>take you</i> already.");
				game.dynStats("lus", 5);
			}
			doAI();
		}
		
		// Player fails to escape from the chokeslam, and after 3 rounds gets nailed to the fuckin floor
		public function chokeSlamDamage():void
		{
			clearOutput();
			
			outputText("With a grunt of effort, Izumi hauls you through the air, her iron-like grip around your throat providing the perfect anchor to propel you towards the ground.  Before you have a chance to react, the Oni drives you into the unforgiving stone lining the floor of the cave.\n\n");

			outputText("The hit is extreme enough to leave you dazed for a moment, splayed out across the floor.  When you rouse yourself back to full consciousness a few seconds later, the cave is still echoing with the sound of the impact, a testament to the strength of the Oni - and your resilience.");
			
			var damage:int = int ((str + 200) - rand(player.tou) - player.armorDef);
			player.takeDamage(damage);
			
			outputText("(" + damage + ")");
			
			combatRoundOver();
		}
		
		// Player escapes from the chokeslam attack
		public function chokeSlamEscape():void
		{
			clearOutput();
			
			outputText("Scrabbling desperately against her wrist, you narrow your eyes at the Oni woman’s superior expression, [if (player.isBiped)raise a [leg] and kick her roundly|[if (player.isNaga)raise your tail and slap her solidly|and slap her square]] in the face.  Izumi drops you, staggering back in surprise.  “Ow!”  She actually yelps, covering her face with her hands.\n\n");

			outputText("You drop to the ground and roll away, expecting some form of retribution.  Izumi glares at you from behind her hand for a moment, then snickers.  Slowly, she drops back into her fighting stance and gestures for your bout to continue.");
			
			this.HP -= 25 + rand(player.str);
			
			combatRoundOver();
		}
		
		// Remove the effect post-combat
		public function cleanupChokeslam():void
		{
			if (player.hasStatusAffect("Chokeslam") >= 0)
			{
				player.removeStatusAffect("Chokeslam");
			}
		}
		
		// Groundslam, does damage and slows the player if they don't dodge the hit
		public function groundPound():void
		{
			outputText("Izumi raises one mighty foot and slams it to the ground with a victorious yell.  The ground itself actually shakes below your feet, threatening to knock you off balance.\n\n");
			
			if (combatMiss() && combatEvade() && combatFlexibility() && combatMisdirect()) // TODO: ensure this is correct
			{
				outputText("Leaping to the side, you manage to steady yourself against the wall, keeping your footing.");
			}
			else
			{
				outputText("The rumbling actually knocks you off your feet, sprawling on the ground and banging your head.  As the shaking subsides, you pull yourself upright, but you feel a little unsteady on your [feet] after the disorienting impact.");
				
				var spdReducedBy:int = int(player.spe * 0.1);
				player.createStatusAffect("Groundpound", 3, spdReducedBy, 0, 0);
				game.dynStats("spe-", spdReducedBy);
			}
		}
		
		// Remove the effect post-combat, fixup stats
		public function cleanupGroundpound():void
		{
			if (player.hasStatusAffect("Groundpound") >= 0)
			{
				game.dynStats("spe+", player.statusAffectv2("Groundpound"));
				player.removeStatusAffect("Groundpound");
			}
		}
		
		// Binding attack, mild lust increase per turn until the player breaks out. Not TOO hard to break out, though.
		public function chokeOut():void
		{
			// Attack will ALWAYS hit, but be relatively easy to break out of
			outputText("With a sudden burst of speed, the Oni woman bullrushes you, slapping aside your hasty defence.  You brace yourself for a powerful impact, but rather than strike you she instead thrusts her arm straight past your head.  Bemused, you turn your head to follow her fist, just in time to see her crook her elbow and yank you back towards her - hard.  Pulled right off your [feet] by the sudden strike, you slam [if (player.hasMuzzle)muzzle-|face-] first into Izumi - specifically, into her chest.  Shocked by suddenly having your face rammed into the pillowy soft expanse of Izumi’s bust, you rear back only to be slammed straight back into the mountainous expanse by Izumi’s arm.");
			
			player.createStatusAffect("Chokeout", 0, 0, 0, 0);
			game.dynStats("lus", player.lib / 20 + 5 + rand(5));
		}
		
		public function chokeOutStruggle():void
		{
			clearOutput();
			
			var brokeFree:Boolean;
			
			if (rand(player.str) > this.str / 2)
			{
				brokeFree = true;
			}
			
			if (brokeFree)
			{
				chokeSlamDamage();
				combatRoundOver();
			}
			else
			{
				if (rand(2) == 0)
				{
					outputText("“Hah!  Say goodnight, ‘cause I’m going to choke the fight right out of you!”  She cries exuberantly, forcibly mashing your face into her bosom.  It would appear that she is trying to throttle you, but only having one hand is making the task difficult.  You can breathe just fine, but having your face forced into the constantly jostling mass of tit-flesh before you is distracting to say the least.  You scrabble desperately against Izumi’s grip, trying not to think about where you’re placing your hands, or how soft and pliant the flesh beneath you is, or any number of other upsetting little details - but to no avail.  Izumi’s grip is incredibly strong.  You hang there for a moment, trying to get your breath back for another attempt as Izumi jostles and presses against you from all sides.");
				}
				else
				{
					outputText("[if (player.hasCock) Assaulted by the sensation of being pressed against such warm flesh, you can already feel [eachCock] starting to stiffen against your will.  Your hardening erection[if (player.totalCocks > 1)s] just makes things even more unbearable, as the harder [if (player.totalCocks > 1)they get|it gets], the more insistently your [if (pc.totalCocks > 1) erections throb | erection throbs], pressed up against Izumi’s stomach muscles.  Her muscles ripple and undulate as she struggles to keep you in her grip, abs flexing, bumping, encircling your insistent erection[if (pc.totalCocks > 1) s], stimulating you even further.  You realise in a flash of panic that if you don’t get out of this soon, you may actually... | Izumi’s bust encloses you on all sides, leaving you feeling like you’re trapped in some kind of breast sarcophagus.  The heat radiating from the soft flesh combines with the scent of whatever strange drug Izumi had been smoking, now hanging around her like some heady perfume.]]");
				}


| 



				player.takeDamage(15 + rand(15));
				doAI();
			}
		}
	}

}