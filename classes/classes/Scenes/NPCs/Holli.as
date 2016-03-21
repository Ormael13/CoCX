package classes.Scenes.NPCs
{
	import classes.*;

	public class Holli extends Monster
	{
		/*Fight -Z
		 Marae's offshoot, [monster] stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.

		 stats:
		 -hella endurance, int, and str
		 -lots o' lust resist
		 -lots o' hp
		 -good armor and regenerates hp/lust every round; but much less so of all three if Jojo is burning her shit
		 -rooted in place, so med-low spd; however, if PC fails a run check he is automatically constricted
		 -not for pussies; this fight should be almost unwinnable without Jojo unless you are wicked lucky or have a super-sploity build
		 -basically requires luck plus any of firebreath level grindan, stun abuse, or blood mage whitefire/arouse abuse
		 */

//Attack:
//[monster] whips out at you with branches and roots!

//attack noun: lash
//Failing to Escape -Z
		public function escapeFailWithHolli():void
		{
			clearOutput();
			outputText("You ");
			if (player.canFly()) outputText("beat your wings and ");
			outputText("try to escape, but " + short + " wraps one of her writhing roots around your [leg], slamming you to the ground and tying you up with several more!  \"<i>And just where do you think you're going, my little meat?</i>\" she hisses.  Her bark splits open, exposing her body, and a green shaft snakes out of her crotch, sprouting thorns and blooming into a rose at the tip.  She holds the drooling blossom over your [face] as she forces your mouth open with her roots! ");
			//hp loss, begin lust constrict next round
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {var damage:int = 15;
			damage = player.takeDamage(damage, true);
			}
			outputText("\n\n");
			player.createStatusEffect(StatusEffects.HolliConstrict, 0, 0, 0, 0);
			combatRoundOver();
		}

//End of Round, if no Jojo Fire -Z
		public function holliBonusHealing():void
		{
			//(monster hp < 100%)
			if (findStatusEffect(StatusEffects.HolliBurning) < 0) {
				if (HPRatio() < 1 && HP > 1) {
					outputText("\n\nWhat wounds you have inflicted on the tree-demon overflow with sap, and begin to close!  You are left to watch helplessly as she recovers, knotting up her damaged bark until it looks as formidable as before.");
					addHP(25);
				}
				//[(monster lust > 0)]
				if (lust > 20 && lust <= 99) {
					outputText("\n\nA single rent forms in the tree's armor-like surface; you can actually see the demon touching her pussy inside, and her eyes roll back as she comes!  It looks like teasing her won't be very effective if you can't distract her from pleasuring herself inside her shell.");
					lust -= 10;
					//repair monster HP and lust by significant amounts
				}
			}
			//End of Round, Round 1 with Jojo Helping - make a little woodpile
			//output anything triggered under no Jojo Fire condition, then output
			if (findStatusEffect(StatusEffects.JojoIsAssisting) >= 0) {
				if (findStatusEffect(StatusEffects.HolliBurning) >= 0) {
					outputText("\n\nJojo continues to ferry firewood to stoke the blaze; flames lick at Holli, and her face contorts in anger.  Sap flows from her burn wounds, but much of it boils away before it can do her any good and her iron-hard bark is peeling in places.");
					//much less HP regain, no lust regain, monster armor lowered
					if (armorDef > 20) armorDef = 20;
					if (tou > 50) tou = 50;
					//Reduced Regen
					addHP(5);
					lust -= 2;
					if (lust < 20) lust = 20;
				}
				else if (findStatusEffect(StatusEffects.JojoPyre) < 0) {
					outputText("\n\nJojo throws another handful of dry leaves and sticks on the growing pile at the demon's roots, then waves and calls to you.  \"<i>[name]!  I've got enough dry wood at her base and I'm going to try to set it on fire!  Hold on just a bit longer; surcease is coming!</i>\"");
					createStatusEffect(StatusEffects.JojoPyre, 0, 0, 0, 0);
				}
				//End of Round, Rounds 2 and 3 with Jojo Helping - light a spark
				else if (statusEffectv1(StatusEffects.JojoPyre) <= 1) {
					//display applicable EOR outputs for fire not lit, then these
					//Round 2:
					if (statusEffectv1(StatusEffects.JojoPyre) == 0) {
						outputText("\n\nJojo scurries toward the woodpile carrying a lit torch, but an eye opens on one of the demon's upper branches and she catches him with a root, sending him tumbling.  For a moment you lose hope, but the plucky monk rolls to the side before she can deliver another lash and from there to his feet.");
						addStatusValue(StatusEffects.JojoPyre, 1, 1);
					}
					//Round 3:
					else {
						outputText("\n\nWary of the constant surveillance from above, Jojo serpentines toward the tree at high speed, dodging roots and branches with a burning stick held in his teeth.  Just as he gets close enough to throw, a root sweeps low and sends him sprawling onto his own torch, catching some of his fur alight!  Without hesitation, he rolls toward the tinder pile and shoves a burning hand into the leaf litter.  As the ring of flammable material catches and the demon screams her frustration, he retreats to the woods, beating his arm with his dirt-smeared robe to put it out.");
						createStatusEffect(StatusEffects.HolliBurning, 0, 0, 0, 0);
					}

				}
			}
			combatRoundOver();
		}

//if player uses whitefire/firebreath successfully, suppress these, go to 'Fire Lit' EOR events, and output additional line after the attack:
		public function lightHolliOnFireMagically():void
		{
			if (findStatusEffect(StatusEffects.JojoIsAssisting) >= 0) {
				if (findStatusEffect(StatusEffects.HolliBurning) < 0) {
					outputText("The magical fire effectively ignites a wide swath of Jojo's tinder, and the demon howls in rage.  Seeing this, Jojo drops the burning torch he carries and turns back toward the forest to fetch more tinder.\n\n");
					createStatusEffect(StatusEffects.HolliBurning, 0, 0, 0, 0);
				}
			}
		}

//Monster Specials -Z
//fuckin' Jumanji flower darts -Z
		private function fuckinJamanjiFlowerDarts():void
		{
			outputText("A blossom opens up on a high branch of the tree, revealing an evil-looking eye surrounded by vicious spines.  With a gesture, " + short + " fires several at you!");

			//Blinded - no hit penalty
			if (findStatusEffect(StatusEffects.Blind) >= 0) outputText("  Though the demon herself is blinded, the fresh eye on the flower seems more than capable of aiming for her!");
			if (player.getEvasionRoll()) {
				outputText("  Nimbly, you step aside and let the darts whistle by.");
			}
			//Hit
			else {
				outputText("  The darts find flesh, and you feel yourself slowing down drastically; all you want to do as the plant woman's poison takes you is fuck and sleep.  \"<i>Just give up,</i>\" Holli coos.  \"<i>Think how good it would be to fall into my arms and ");
				if (player.hasCock()) outputText("come inside me");
				else outputText("have me inside you");
				outputText(", forever...</i>\" ");
				//lust damage, fatigue damage, light HP damage
				player.changeFatigue(10);
				game.dynStats("lus", 25);
				var damage:Number = 20 + rand(10);
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}

//constrict -Z
		private function holliConstrictAttack():void
		{
			outputText("A forest of thick roots bursts from the ground and several lash toward your [legs], trying to ensnare you!");
			//Blinded - hit penalty, but not 100%
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(6) == 0) {
				outputText("  Luckily, the demon's blindness makes it fairly easy to dodge the grasping roots, though there are a few close scrapes.");
			}
			//Miss
			if (player.getEvasionRoll()) {
				outputText("  It's a narrow thing, but you manage to avoid the roots - one of them almost grabs you, but you duck aside and let it find only its neighbor.");
			}
			//Hit
			else {
				outputText("  She latches onto you with a painful smack and several more root tentacles join the first; as she pulls you close, her bark opens and a long, phallic stalk extends from her crotch, wrapped in thorns and flowering with a rose!  It caresses your face, then dangles the blossom above your mouth, dripping her sap.  Several of the roots pry your jaws apart, forcing you to drink the tainted fluids from her pseudo-cock!  \"<i>What do you think of my little sap rose?</i>\" ");
				//plus med HP damage on turn one, plus med-heavy lust damage every turn while constricted
				//sap rose shitposting
				var damage:int = 10 + rand(5);
				damage = player.takeDamage(damage, true);
				game.dynStats("lus", 15);
				player.createStatusEffect(StatusEffects.HolliConstrict, 0, 0, 0, 0);
			}
			combatRoundOver();
		}

		public function struggleOutOfHolli():void
		{
			clearOutput();
			//Boost odds of success. Round 3 guaranteed.
			player.addStatusValue(StatusEffects.HolliConstrict, 1, 9);
			//Struggle Succeed
			//if demon/dragon tongue, automatic success
			if (player.tongueType > TONGUE_HUMAN) {
				outputText("You can't move an arm nor a [leg] to bat the flower away... but she's literally holding your mouth open.  Your long tongue rolls out, gripping and ripping out several of the petals on the end of her stalk!  Holli screams and her roots slacken, allowing you to batter your way out of them.");
				player.removeStatusEffect(StatusEffects.HolliConstrict);
			}
			//else if normal str-based success
			else if (player.str / 10 + rand(20) + 1 + player.statusEffectv1(StatusEffects.HolliConstrict) > 30) {
				outputText("You manage to force the roots open when the distracted Holli begins to stroke her plant-shaft, pulling out of the bindings just as a drop of sap oozes out and falls where you were standing.  You're free!");
				//sap rose pls go
				player.removeStatusEffect(StatusEffects.HolliConstrict);
			}
			//Struggle Fail/Wait
			else {
				outputText("You try to escape the entangling roots, but cannot break their grip!  ");
				waitForHolliConstrict(false);
				return;
			}
			combatRoundOver();
		}

		public function waitForHolliConstrict(newScreen:Boolean = true):void
		{
			if (newScreen) clearOutput();
			outputText("The ominous roseate shaft hovers over you, and its owner strokes the base lewdly, moaning.  \"<i>Oooh, gonna... cum!</i>\" she shrieks.  As a low moan escapes her, the stalk bloats and begins to spill milky-white sap into your mouth!  Held rigid, you're eventually forced to swallow just to breathe; the sap slides into your stomach and warmth radiates to your midsection and groin, making you feel flushed and hot.  Holli sighs in satisfaction, evidently more relaxed after her climax.");
			//lower monster lust by medium-lots and apply med sens-based lust damage
			lust -= 20;
			if (lust < 20) lust = 20;
			game.dynStats("lus", 15 + player.sens / 5);
			combatRoundOver();
		}

//heal -Z
//used if monster HP < some level
		private function healHolli():void
		{
			clearOutput();
			outputText("The bark splits part way and the woman's mouth suddenly explodes with color, her lips folding out into a rather yonic-looking orchid.  Copious white-tinted sap oozes from the bloom, coating her bark and healing the lesions.  Petals rustle as she speaks wetly through it.  \"<i>Your efforts are nothing!  Throw yourself on my mercy; be my slave and do my bidding!</i>\"");
			//heal some fuckin' hp
			addHP(200);
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			if (HP < 50 && rand(2) == 0) healHolli();
			else if (rand(4) == 0 && player.findStatusEffect(StatusEffects.HolliConstrict) < 0) holliConstrictAttack();
			else if (rand(2) == 0) fuckinJamanjiFlowerDarts();
			else eAttack();
			holliBonusHealing();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.holliScene.defeatHolli();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.holliScene.enjoyYourBadEndBIYAAAATCH();
		}


		override public function teased(lustDelta:Number):void
		{
			if (findStatusEffect(StatusEffects.HolliBurning) >= 0) {
				outputText("Holli doesn't even seem to notice, so concerned is she with defeating you before the mounting bonfire causes her any more pain.");
				lustDelta = 0;
			}
			applyTease(lustDelta);
		}

		public function Holli()
		{
			this.a = "";
			this.short = "Holli";
			this.imageName = "holli";
			this.long = "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.";
			// this.plural = false;
			this.createCock(12,2,CockTypesEnum.HUMAN);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(12) + 55;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "black";
			this.hairColor = "sandy-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(150, 80, 80, 85);
			initLibSensCor(75, 40, 80);
			this.weaponName = "branches";
			this.weaponVerb="branchy thwack";
			this.armorName = "bark";
			this.armorDef = 40;
			this.bonusHP = 1000;
			this.lust = 20;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 20;
			this.gems = 0;
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}
