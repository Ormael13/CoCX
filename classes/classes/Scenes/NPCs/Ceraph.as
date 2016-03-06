package classes.Scenes.NPCs
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;

	public class Ceraph extends Monster
	{

//[IN COMBAT SPECIALS]
//[SPECIAL 1] – Ubercharge!
		private function ceraphSpecial1():void
		{
			game.spriteSelect(7);
			if (findStatusEffect(StatusEffects.Uber) < 0) {
				if (rand(2) == 0) {
					outputText("Ceraph winks and says, \"<i>Have you ever cum without being touched? You will.</i>\"\n\n", false);
				}
				else {
					outputText("Ceraph titters, \"<i>Let me show you the true power of an Omnibus.</i>\"\n\n", false);
				}
				outputText("Despite her sultry tease, you can tell she's starting to build up to something big...", false);
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
			else {
				//(Next Round)
				if (statusEffectv1(StatusEffects.Uber) == 0) {
					addStatusValue(StatusEffects.Uber, 1, 1);
					if (rand(2) == 0) outputText("The demonic hermaphrodite begins forging demonic symbols in the air before her, each glowing brilliant pink before they blur away in a haze.", false);
					else outputText("The demonette makes obscene motions with her hands, as if masturbating an imaginary cock or vagina while her hands are wreathed in pink flames.", false);
					outputText("  <b>She's about to unleash something huge!</b>", false);
					if (player.inte > 50) outputText("  You should probably wait so you'll have a chance to avoid whatever's coming.", false);
				}
				//FIRE!
				else {
					removeStatusEffect(StatusEffects.Uber);
					//(Avoid!)
					if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
						outputText("She throws her hands out, palms facing you, and a rush of pink flame washes towards you.  Thanks to your decision to wait, it's easy to avoid the onrushing flames and her attack.\n\n", false);
						outputText("Ceraph sighs and asks, \"<i>Why would you move?  It would make you feel soooo good!</i>\"", false);
					}
					//(AUTO-LOSE)
					else {
						outputText("She throws her hands out, palms facing you, and a rush of pink flame washes towards you.  Too busy with your own attack to effectively dodge, you're hit full on by the pink fire.  Incredibly, it doesn't burn.  The fire actually seems to flow inside you, disappearing into your skin.  You stumble, confused for a second, but then it hits you.  Every inch of your body is buzzing with pleasure, practically squirming and convulsing with sexual delight.  You collapse, twitching and heaving, feeling the constant sensation of sexual release running from your head to your " + player.feet() + ".  Too horny and pleasured to resist, you lie down and tremble, occasionally rubbing yourself to enhance the bliss.", false);
						game.dynStats("lus", 999);
					}
				}
			}
			combatRoundOver();
		}
//[SPECIAL] – Whip Binding
		private function ceraphSpecial2():void
		{
			if (player.findStatusEffect(StatusEffects.Bound) < 0) {
				outputText("Ceraph snaps her whip at you, lightning fast.  Unable to avoid the blinding speed of her attack, you find yourself wrapped from head to toe in the strong leather of her whip.  Remarkably, the fire dies out everywhere the whip touches you, leaving you bound but unharmed.", false);
				//If player has l2 piercing
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("  Gods this turns you on!", false);
					game.dynStats("lus", 5);
				}
				player.createStatusEffect(StatusEffects.Bound, 2 + rand(5), 0, 0, 0);
			}
			//[SPECIAL WHILE PC RESTRAINED]
			else {
				if (rand(2) == 0) {
					outputText("Ceraph cuddles up against you, embracing you tenderly.  Her more-than-ample bosom crushes against your flank, and her demonic prick grinds and rubs against your " + player.skinDesc + ", smearing it with her juices.  Her hands slide over your bound form, sneaking underneath your " + player.armorName + " to caress you more intimately while you're at her mercy.", false);
					game.dynStats("lus", 9 + player.sens / 10);
				}
				//[SPECIAL 2 WHILE PC RESTRAINED]
				else {
					outputText("Ceraph blows hot kisses in your ear and slides and rubs against you as she slips over to embrace your front.  She holds up a finger, licks it, and wiggles it back and forth.  It begins to glow pink, dimly at first and then with increasing luminosity.  Once it's reached a brilliant intensity, the sparkling digit is roughly inserted into your mouth.  You can feel the dark magic soaking into your body just like water soaks into a sponge.  ", false);
					if (player.lust < 33) outputText("It makes you feel warm and flushed.", false);
					else if (player.lust < 60) outputText("It gets inside you and turns you on, stoking the flames of your desire.", false);
					else if (player.lust < 80) outputText("It makes you very horny, and you begin to wonder if it's worth resisting.", false);
					else outputText("It makes you ache and tremble with need, practically begging for another touch.", false);
					game.dynStats("lus", 5 + player.cor / 10 + player.lib / 20);
				}
			}
			combatRoundOver();
		}

		//(Struggle)
		public function ceraphBindingStruggle():void
		{
			clearOutput();
			outputText("You wriggle in the tight binding, trying your best to escape.  ", false);
			if (player.statusEffectv1(StatusEffects.Bound) - 1 <= 0) {
				outputText("With a mighty twist and stretch, the whip gives and uncurls from you all at once.  You've regained your freedom", false);
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText(", though you miss the tight leathery embrace", false);
				}
				outputText("!", false);
				player.removeStatusEffect(StatusEffects.Bound);
				combatRoundOver();
				return;
			}
			else {
				outputText("Despite your frantic struggling, all you manage to do is chafe against her impressively taut leather whip.", false);
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("  You get nice and hot from being so effectively restrained, maybe you should just accept it?", false);
				}
				player.addStatusValue(StatusEffects.Bound, 1, -1);
				//Strong characters break free faster
				if (player.str > 65 && rand(player.str) > 45) {
					outputText("  Though you didn't break free, it seems like your mighty struggles loosened the whip slightly...", false);
					player.addStatusValue(StatusEffects.Bound, 1, -1);
				}
			}
			outputText("\n\n", false);
			doAI();
		}

//(Wait)
		public function ceraphBoundWait():void
		{
			clearOutput();
			outputText("Why bother resisting?  The feeling of the leather wrapped tightly around you, digging into your " + player.skinDesc + ", is intoxicating.", false);
			if (flags[kFLAGS.PC_FETISH] >= 2) {
				outputText("  You squirm inside the bindings as you get more and more turned on, hoping that Ceraph will strip away your armor and force you to parade around as her bound, naked pet.", false);
				game.dynStats("lus", 5);
			}
			game.dynStats("lus", player.lib / 20 + 5 + rand(5));
			outputText("\n\n", false);
			doAI();
		}


//[Double-Attack]
		private function ceraphSpecial3():void
		{
			//[Mini-cum] – takes place of double-attack if very horny
			if (lust >= 75) {
				outputText("Ceraph spreads her legs and buries three fingers in her sopping twat, her thumb vigorously rubbing against the base of her bumpy prick.  Her other hand wraps around the meaty pole and begins jerking it rapidly.  In one practiced movement she stops jerking long enough to wrap the whip around her nodule-studded demon-cock, using it like a cockring.  The organ swells thanks to the forced blood-flow, and after a few more seconds of intense masturbation, the demoness cums hard.  Her cunny squirts all over her hand, dripping clear feminine drool down her thighs.  Ceraph's masculine endowment pulses and twitches, blasting out two big squirts of jizm before it slows to a trickle.\n", false);
				outputText("Letting out a throaty sigh, the demon unties her self-induced binding and gives you a wink.  Did you really just stand there and watch the whole thing?  Amazingly Ceraph actually seems stronger after such a crude display...", false);
				//(+10 str/toughness, 1 level, and 10 xp reward.)
				XP += 10;
				level += 1;
				str += 10;
				tou += 10;
				HP += 20;
				lust = 33;
				game.dynStats("lus", 3);
				outputText("\n", false);
				combatRoundOver();
				return;
			}
			var damage:Number = 0;
			outputText("The demoness weaves her whip in the air until you can practically hear it slithering like a snake, cutting the air as it weaves back and forth, still magically alight with flames.  In a blink she lashes out twice in quick succession!\n", false);
			//First hit!
			doNext(game.playerMenu);
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(10) != 9) {
				outputText(capitalA + short + " completely misses you with a blind attack!", false);
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!", false);
				if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!", false);
				if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".", false);
			}
			//Determine if evaded
			else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.", false);
			}
			else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
				outputText("With Raphael's teachings and the easy movement afforded by your bodysuit, you easily anticipate and sidestep " + a + short + "'s attack.", false);
			}
			//Determine damage - str modified by enemy toughness!
			else {
				damage = int((str + weaponAttack) - Math.random() * (player.tou + player.armorDef));
				if (damage > 0) {
					damage = player.takeDamage(damage);
				}
				if (damage <= 0) {
					damage = 0;
					//Due to toughness or amor...
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText("Your " + player.armorName + " absorb and deflect every " + weaponVerb + " from " + a + short + ".", false);
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
				}
				if (damage > 0 && damage < 6) {
					outputText("You are struck a glancing blow by " + a + short + "! ", false);
				}
				if (damage > 5 && damage < 11) {
					outputText(capitalA + short + " wounds you! ", false);
				}
				if (damage > 10 && damage < 21) {
					outputText(capitalA + short + " staggers you with the force of " + pronoun3 + " " + weaponVerb + "! ", false);
				}
				if (damage > 20) {
					outputText(capitalA + short + " <b>mutilates</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ", false);
				}
				if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>", false)
				else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>", false)
			}
			game.statScreenRefresh();
			outputText("\n", false);
			//SECOND ATTACK HERE------
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(10) != 9) {
				outputText(capitalA + short + " completely misses you with a blind attack!", false);
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!", false);
				if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!", false);
				if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".", false);
			}
			//Determine if evaded
			else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.", false);
			}
			else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 15 && player.armorName == "red, high-society bodysuit") {
				outputText("With Raphael's teachings and the easy movement afforded by your bodysuit, you easily anticipate and sidestep " + a + short + "'s attack.", false);
			}
			else {
				//Determine damage - str modified by enemy toughness!
				damage = int((str + weaponAttack) - Math.random() * (player.tou + player.armorDef));
				if (damage > 0) {
					damage = player.takeDamage(damage);
				}
				if (damage <= 0) {
					damage = 0;
					//Due to toughness or amor...
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText("Your " + player.armorName + " absorb and deflect every " + weaponVerb + " from " + a + short + ".", false);
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
				}
				if (damage > 0 && damage < 6) {
					outputText("You are struck a glancing blow by " + a + short + "! ", false);
				}
				if (damage > 5 && damage < 11) {
					outputText(capitalA + short + " wounds you! ", false);
				}
				if (damage > 10 && damage < 21) {
					outputText(capitalA + short + " staggers you with the force of " + pronoun3 + " " + weaponVerb + "! ", false);
				}
				if (damage > 20) {
					outputText(capitalA + short + " <b>mutilates</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ", false);
				}
				if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>", false)
				else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>", false)
			}
			game.statScreenRefresh();
			outputText("\n", false);
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (player.findStatusEffect(StatusEffects.Bound) >= 0) {
				ceraphSpecial2();
				return;
			}
			if (findStatusEffect(StatusEffects.Uber) >= 0) {
				ceraphSpecial1();
				return;
			}
			switch (choice) {
				case 0:
					eAttack();
					break;
				case 1:
					ceraphSpecial1();
					break;
				case 2:
					ceraphSpecial2();
					break;
				case 3:
					ceraphSpecial3();
					break;
			}
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.ceraphScene.winRapeChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(game.combat.endLustLoss);
			} else {
				game.ceraphScene.loseFUCKME();
			}
		}

		public function Ceraph()
		{
			trace("Ceraph Constructor!");
			this.a = "";
			this.short = "Ceraph";
			this.imageName = "ceraph";
			this.long = "Ceraph the Omnibus is totally nude and reveling in it.  Her large yet perky breasts jiggle heavily against her chest as she moves.  The flawless purple skin of her twin mounds glistens with a thin sheen of sweat, inviting you to touch and rub your fingers along their slippery surface.  Her eyes are solid black, but convey a mix of amusement and desire, in spite of their alien appearance.  The demon's crotch is a combination of both genders – a drooling cunt topped with a thick demonic shaft, sprouting from where a clit should be.";
			// this.plural = false;
			this.createCock(10,2,CockTypesEnum.DEMON);
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,15,0,0,0);
			this.tallness = 5*12+6;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
			this.skinTone = "purple";
			this.hairColor = "black";
			this.hairLength = 20;
			initStrTouSpeInte(65, 40, 80, 80);
			initLibSensCor(75, 15, 100);
			this.weaponName = "flaming whip";
			this.weaponVerb="flame-whip";
			this.weaponAttack = 15;
			this.armorName = "demon-skin";
			this.bonusHP = 200;
			this.lust = 30;
			this.lustVuln = 0.75;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 9;
			this.gems = rand(5) + 38;
			this.drop = NO_DROP;
			this.special1 = ceraphSpecial1;
			this.special2 = ceraphSpecial2;
			this.special3 = ceraphSpecial3;
			checkMonster();
		}

	}

}