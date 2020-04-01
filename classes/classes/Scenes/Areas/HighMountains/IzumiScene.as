package classes.Scenes.Areas.HighMountains 
{
import classes.*;
import classes.BodyParts.Horns;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.UniqueSexScenes;

/**
	 * Izumi, the fuckhuge Oni. TOUCH THE FLUFFY HORN.
	 * 
	 * @author FeatureCreep
	 * @editor Gedan
	 * @programmer Gedan
	 */
	public class IzumiScene extends BaseContent
	{
		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		public function IzumiScene() 
		{
		}
		
		/**
		 * Support Functions
		 */

		// Return a height-based nickname for the player
		public function heightDesc(doName:Boolean = true):String
		{
			if (rand(4) != 0) return "kid";
			else
			{
				if (player.tallness < 60) return "pint-size";
				if (player.tallness < 72) return "short-stuff";
				if (player.tallness < 84) return "shorty";
				if (player.tallness < 96) return "kid";
				else
				{
					if (doName) return player.short;
					else return "kid";
				}
			}
		}
		
		public function HeightDesc():String
		{
			var str:String = this.heightDesc();
			return str.charAt(0).toUpperCase() + str.substr(1);
		}

		// Bundle of logic to determine if a player might "act" like a minotaur, based off of a couple of related statusEffects
		public function actsLikeACow():Boolean
		{
			if (player.inHeat) return true;
			if (player.inRut) return true;
			if (player.hasStatusEffect(StatusEffects.Dysfunction)) return true;
			return false;
		}
		
		/**
		 * Introduction/Entry Scenes
		 */
		// Entry point from HighMountain explores
		// Tested
		public function encounter():void
		{
			clearOutput();
			
			if (flags[kFLAGS.IZUMI_MET] == 0)
			{
				outputText("As you wander the wasted landscape searching for anything of interest, you come across a large rock blocking what appears to be the entrance to a cave.  Wondering about how to best get around it, you suddenly become aware of a strange sound on the edge of your hearing.\n\n");
				outputText("Flattening yourself against the stone in case of danger, you strain your ears and scan the horizon, searching for the source of the noise.  The volume gradually increases, and eventually you realize what it is that you’re hearing; someone nearby is loudly humming, a lively tune echoing off the rocks and cliffs.  As best you can tell, it seems to be coming from the other side of the enormous stone blocking your path.\n\n");
				outputText("Your curiosity piqued, you search around the obstruction for a way inside, and finally manage to find a slim gap between the bottom of the rock and the cliff face.  Kneeling down, you peer inside and can make out the distinct glowing embers of a campfire.  You’re pretty sure you can make it inside, but it might be difficult to get away if danger threatens.  On the other hand, wild animals don’t light campfires, and a lust-crazed demon probably wouldn’t bother to hide itself so effectively....\n\n");
				menu();
				addButton(0, "Enter", enterFirstTime);
				addButton(1, "Leave", abortabortleavethefukkencave);
			}
			else
			{
				outputText("As you wander the wasted landscape searching for anything of interest, you find yourself face to face with a familiar large boulder; the same one hiding the entrance to Izumi’s cave.  Once again, you become aware of a strange sound on the edge of your hearing.  Carefully positioning yourself at the gap between the boulder and the cave entrance, you turn your ear to the source of the noise and manage to pick out what it is that you’re hearing; somebody is loudly humming, the same lively tune you heard during your previous visit.\n\n");
				outputText("Considering how your last visit to the cave ended, you hesitate for a moment and wonder if you should push forward to enter Izumi’s home... or if turning back to camp would be a wiser decision.\n\n");
				if (player.findPerk(PerkLib.SoulSense) >= 0 && flags[kFLAGS.SOUL_SENSE_IZUMI] < 2) flags[kFLAGS.SOUL_SENSE_IZUMI]++;
				if (flags[kFLAGS.SOUL_SENSE_IZUMI] == 2) {
					flags[kFLAGS.SOUL_SENSE_IZUMI]++;
					outputText("\n\n<b>You have meet her enough times to be able to find her in the future when using soul sense. (Removes Izumi from high mountains explore encounters pool!)</b>\n\n");
				}
				menu();
				addButton(0, "Enter", enterAfterMet);
				addButton(1, "Leave", nopeLeavePlz);
			}
		}
		
		// Repeat encounters with Izumi after having met in the past
		public function enterAfterMet():void
		{
			clearOutput();

			if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 0) flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 2;
			
			if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 1)
			{
				outputText("Remembering the outcome of your last visit, you peer cautiously around the mouth of the cave.  Izumi, as before, is seated by the fire, happily puffing away at whatever bizarre narcotic she keeps in her pipe.  She sees you almost immediately, raising a hand cheerfully and beckoning for you to enter.\n\n");

				outputText("“<i>Hey, it’s you! How’s it going, "+ this.heightDesc() + "? Killed any demon kings yet?</i>” Izumi ribs. “<i>Let me guess.. You’re here to take revenge on the big bad Oni, grr argh, right? Or...</i>”  She pauses for a second to shift around into a more comfortable position that - completely inadvertently, you’re sure - ends up with her showing off much more of her thighs and impressive bust.  “<i>Could it be you just came back to ask for another turn, hmm?</i>”\n\n");
			}
			else if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 2)
			{
				outputText("Remembering your last visit, you peer cautiously around the mouth of the cave.  Izumi, as before, is seated by the fire, happily puffing away at whatever bizarre narcotic she keeps in her pipe.  She sees you almost immediately, raising a hand cheerfully and beckoning for you to enter.\n\n");

				outputText("“<i>Oh hey, you came back!</i>”  She announces.  “<i>That’s good, ‘cause for a while there I thought you were a wuss.  Crazy idea, right?  So, did you decide to try your luck, or are you just gonna give up and let me have some fun?</i>”\n\n");
			}
			else if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 3)
			{
				outputText("Ranging through mountains and valleys, you find yourself back at Izumi’s camp.  Remembering the outcome of your last visit, you peer cautiously around the mouth of the cave.  Izumi, as before, is seated by the fire, puffing away at whatever bizarre narcotic she keeps in her pipe.  She catches sight of you almost immediately, frowns slightly, then raises a hand in a hesitant greeting.  There’s an awkward silence for a moment, during which Izumi avoids your gaze.\n\n");

					outputText("“<i>So, uh...</i>” she begins.  Then she scowls, blushing slightly.  “<i>So, you came back to apologize, right?  You damn well better have!  In fact, I’m not forgiving you until I’ve made you feel as humiliated as I did, so just give in already, okay?!</i>”\n\n");
			}
			else
			{
				throw new Error("Izumi encounter flag wasn't set during a previous encounter.");
			}

			menu();
			addButton(0, "Fight", fightTheFuckhugeOni);
			addButton(1, "Surrender", fuckhugeOniGetsWhatSheWants);
			addButton(2, "Flee", fuckinChegIt);
		}
		
		// Leave the cave, no meeting
		protected function abortabortleavethefukkencave():void
		{
			clearOutput();

			outputText("Spelunking in random caves around these parts is probably not the best idea; especially considering the kinds of creatures that you keep tripping over whenever you <i>do</i> decide to poke your nose somewhere it doesn't belong.\n\n");
			
			outputText("You head back to camp, having found nothing else of interest.");
			doNext(camp.returnToCampUseOneHour);
		}

		// Already met, dun wanna get oniraepd again plz
		protected function nopeLeavePlz():void
		{
			clearOutput();

			outputText("You decide discretion is the better part of valour and choose not to barge into the strange woman's cave again, opting to slip away before she notices you hanging around outside her home.");
			doNext(camp.returnToCampUseOneHour);
		}

		// Introduce the fuckhuge oni
		// Long: Untested
		// Short: Tested
		protected function enterFirstTime():void
		{
			clearOutput();
			flags[kFLAGS.IZUMI_MET] = 1;

			// TRIAL BY FIRE FOR THE PARSER, LETS GO

			// Fire won, parser is being thrown out of the window. I'll let you have at the original docs Fake-Name so you can figure out wtf.
			// Trying to code this + figure out the parser + make sure I've not fucked up the logic + how difficult it is to debug issues
			// in the parsed strings == noplz :(

			// PC is > 9’ Tall
			if (player.tallness >= 108)
			{
				// High strength variant
				if (player.str >= 75)
				{
					outputText("Putting your shoulder to the stone, you push with all your might, trying to roll it out of the way.  It resists for a moment, then gives, slowly but surely rattling and scraping across the uneven ground.\n\n");
				}
				// Low strength variant
				else
				{
					outputText("Putting your shoulder to the stone, you push with all your might, trying to roll it out of the way.  It resists, but you are determined, your [feet] scrabbling against loose rocks and gravel, trying to find the purchase you need to move the boulder.\n\n");
				}

				// Shared
				outputText("The humming stops almost instantly, and moments later a hand suddenly rests itself on the rock in front of you.  Looking up from your exertions, you find yourself face to face with a woman.  It takes a moment, but then you realize, you really are actually face to face with her - she’s as tall as you are!");

				// Catch logic shit that we just broke
				if (player.str < 75)
				{
					outputText("  She gives the boulder a shove - with just one hand - and it starts to give, scraping across the uneven ground.\n\n");
				}
				else
				{
					outputText("\n\n");
				}

				outputText("The woman stares at you in suspicion for a moment, giving you the opportunity to study her in return.  She wears a silken kimono, embroidered with stars, dragons and flowers, which you can’t help but notice is of a truly scandalous cut – your eye is inevitably drawn to her enormous breasts, bulging dangerously against the fabric as though straining to escape.  If she were human-sized and remained in proportion, they would probably be around a DD, but at her size, you honestly have no idea.  Not only is she just as tall as you, she’s pretty built physically as well, at least from what you can see of her thighs and arms thanks to her figure-hugging outfit.\n\n");

				outputText("When you finally manage to drag your eyes back to her face, her expression is quite different. Instead of suspicion, she treats you to a sly smile.\n\n");

				outputText("“<i>Well now,</i>” she drawls in a syrupy, seductive tone, twirling an errant lock of her hair thoughtfully in her fingers.  “<i>You’re a </i>big<i> one, aren’t you?  And here you are,");
				if (player.str >= 75) outputText(" forcing");
				else outputText(" trying to force");
				outputText(" your way through little Izumi’s door uninvited.  I’d tell you off, but I’ve got to admit, I don’t get many visitors of your... </i>stature.<i>");
				
				if (player.horns.type != Horns.COW_MINOTAUR)
				{
					outputText("  Or at least, ones without a pair of bulls horns");
					if (this.actsLikeACow() == true)
					{
						outputText(" - and the temperament to match - ");
					}
					else
					{
						outputText(", ");
					}
				}
				else
				{
					if (this.actsLikeACow() == true)
					{
						outputText("  Or at least, ones without the temperament to match the... physique, ");
					}
				}
				outputText("if you follow?</i>”\n\n");

				outputText("She turns and heads back into the cave, quickly disappearing into the gloom, the strange woman motioning you to follower her inside with a wave.  You creep slowly into the darkness after her, your sight gradually adapting to the darkness.\n\n");
			}
			// "short" variant
			else
			{
				outputText("You squeeze through the gap, entering the cave.  Almost immediately, a palpable wave of heat rushes over you, sweat already starting to bead on your brow; it’s <i>stuffy</i> in here!\n\n");
			}

			outputText("Now that you’ve made it inside, you can see that the cave is dimly lit by two burning braziers on either side of what appears to be a large tent of some sort.  In front of the tent, the fire smolders gently.  It’s difficult to make out details, as the lighting is pretty poor, wreathing everything in strange, animated shadows.  To make matters worse, the entire place is permeated by a thick veil of smoke that makes your eyes sting");
			if (player.tou <= 75) outputText(" and of course, that obnoxiously endurance-sapping heat");
			outputText(".\n\n");

			if (player.tallness < 108)
			{
				outputText("You can still hear the humming, but at first, there doesn’t seem to be anyone around.  You creep closer to the tent, until suddenly, a huge shadow at the front of the tent shifts.  You freeze, straining your eyes through the darkness, as you suddenly realize that’s not a shadow at all - it’s an enormous figure!  You must have gasped, as without warning the humming stops.\n\n");
				outputText("“<i>Hm?</i>” the shadow grunts, then speaks.  “<i>Oh?  Now how did you find your way in here, I wonder?</i>”  The voice is deep, rich and undeniably female, but has a gravelly edge to it like a cross between magma and molten chocolate.  You hear the hiss of indrawn breath and a small light flares up briefly in the darkness, then the shadow speaks again.  “<i>Well, whatever. It’s been a while since I had company, ");
				if (player.minotaurScore() > 3) outputText("plus it looks like you're thinking with the head on top of your neck, rather than the head between your legs, unlike the stupid brutes who usually wander around these parts.  ");
				else if (player.dogScore() > 3) outputText("plus it looks like you'd actually be able to resist chasing down a stick, if I threw one outta' the cave.  ");
				else if (player.goblinScore() > 3) outputText("plus you don't seem to be as insufferable as the rest of those little green whores who trollop around these parts, hunting their next lay.  ");
				else if (player.demonScore() > 3) outputText("plus you're not forever going on about corruption this, enslavement that, demonic taint the other, unlike the insufferable clods who usually wander around these parts.  ");
				else if (player.harpyScore() > 3) outputText("plus you're not screeching incessantly, like the feathery sluts who usually flap their way around these parts.  They're lucky they </i>can<i> fly, 'cause I'd give them something to really squawk about if I could get my hands on them.  ");
				else if (player.lizardScore() > 3) outputText("plus, you don't have the same creepy eyes that the scaley idiots from around these parts keep trying to use on me.  ");
				else outputText("plus you don’t look like the troglodytes who usually wander around these parts.  ");
				outputText("Sit down, sit down!</i>”\n\n");
			}
			outputText("Cautiously, you edge towards the lip of the fire, and");
			if (player.tallness >= 108)
			{
				outputText(" a");
			}
			else 
			{
				outputText(" the");
			}
			outputText(" shadow leans forward, finally becoming visible.");
			if (player.tallness < 108)
			{
				outputText("  For a moment, you’re stunned into silence; the figure looks completely human, aside from two important factors.  The first, her size; she looks as though someone had tried to build a human but got the scale wrong.  By the looks of her, if she was standing upright she would tower at least around eight or nine feet in height, and she looks broad enough to carry a horse on her back.");
			}
			else
			{
				outputText("  With the opportunity to finally study the strange woman in detail, you’re stunned into silence.  She looks completely human, aside from two important factors.  The first, her size; she looks as though someone had tried to build a human but got the scale wrong.  A fact you’re made aware of every time you venture from camp; it’s not every day you meet somebody just as tall as yourself.");
			}
			
			outputText("  The second factor, of course, would be the enormous curved horns of red, rock-like bone that juts proudly from her forehead.  Still, they’re no less inhuman than some of the other creatures you’ve encountered since arriving....\n\n");
			outputText("“<i>Hmm?</i>”  She looks blankly at you.  The sudden realisation that you’ve been staring at her horns for an uncomfortably long time hits you.  “<i>What?  Is there something on my face?</i>”  Blushing, you open your mouth to answer, but as you breathe in, a rush of coarse smoke down your throat");
			if (player.tou < 60) outputText(" causes you to cough and splutter.\n\n");
			else outputText(" momentarily steals your voice, having been ill-prepared for the sudden burn.\n\n");
			outputText("The strange woman blinks at you in confusion for a moment, then her face cracks into a grin.  “<i>Oh, right, I forgot people like you tend to be pretty fragile.  Hold on");
			if (player.tou < 60) outputText(", kid. Let");
			else outputText(", let");
			outputText(" me get some air in here for you...</i>”  She launches herself to her feet with surprising speed and breezes past you.\n\n");
			menu();
			addButton(0, "Next", enterFirstTimePartII);
		}
	
		protected function enterFirstTimePartII():void
		{
			clearOutput();
			
			outputText("Still");
			if (player.tou < 60) outputText(" struggling with");
			else outputText(" distracted by");
			outputText(" the smoke, you turn to see her, only barely through the gloom, at the boulder blocking entry to the cave.");
			if (player.str <= 75) outputText("  To your amazement, the boulder begins to move, and as more light - along with a much-needed rush of fresh air - floods into the smoky cavern, you see she’s actually rolling it aside with her <i> bare hands </i>.  Even given her great size, this woman’s strength must be immense!\n\n");
			else outputText("  The boulder begins to move, and as more light - along with a welcome rush of fresh air - floods into the smoky cavern, you see she’s rolling it aside with nothing more than her bare hands with graceful, if unnerving, ease.\n\n");
			outputText("Finally, the boulder is pushed far enough that about half of the cave mouth is now open to the air. It’s still dark, but at least now you are able to see well enough to make out actual details as the woman strides casually back to you to retake her seat.  She smiles again, her features broad and honest, framed by an enormous chaotic mass of shaggy golden hair, looking for all the world like the mane of some great lion.\n\n");
			// Catch describing her in detail to short players
			if (player.tallness < 108) outputText("She wears a silken kimono, embroidered with stars, dragons and flowers, which you can’t help but notice is of a truly scandalous cut – your eye is inevitably drawn to her enormous breasts, bulging dangerously against the fabric as though straining to escape.  If she were human-sized and remained in proportion, they would probably be around a DD, but at her size, you honestly have no idea.\n\n");
			outputText("She sits, right knee raised so she can rest her arm on it, her left foot tucked behind the right.  As she does so, her kimono slides aside,");
			if (player.cor <= 33) outputText(" exposing an uncomfortable amount of creamy-white thigh flesh.");
			else if (player.cor > 33 && player.cor < 66) outputText(" exposing a tantalising view of creamy-white thigh flesh.");
			else outputText(" exposing a delicious view of her thigh, the creamy-white flesh almost screaming out for your caresses.");
			outputText("  If she notices, then she doesn’t seem to care.\n\n");
			outputText("“<i>Better, right?</i>” she asks, and you nod.  “<i>Sorry, I didn’t realize the smoke was getting to you at first.  It’s been a while since I’ve seen anything but a minotaur or a demon, at least ones that seem more interested in polite conversation than reaming everything in sight.</i>”  She grimaces, briefly.  “<i>So, what’s your story, " + this.heightDesc(false) +"?</i>”  Whoever she is, she seems friendly enough");
			if (player.tallness <= 96) outputText(" - if a little... imposing -");
			else outputText(",");
			outputText(" so you give her your name, and, hesitant to discuss your true quest in any depth, detail some of your past encounters in this strange world.  Nodding encouragingly, she raises a long, elaborately carved pipe to her lips, puffing away as you tell your story....\n\n");
			outputText("“<i>Oh, so you’re the heroic type, yeah?  So, I guess it’s my turn now, huh?</i>” She sighs and closes her eyes, reclining and crossing her legs.  You can’t help but notice the way her kimono slithers around her legs, mere inches from becoming truly indecent, nor the way her breasts threaten to burst free of their confinement as she stretches.\n\n");
			outputText("“<i>Ah, but where to begin?  My clan calls me ‘Izumi, <b>The Font Of All Strength’</b>.</i>”  She snorts in amusement at your reaction to her name.  “<i>I know, it’s a little pompous, right?  Just use Izumi, I always do.  Either way, I’m a traveller from another world.");
			if (player.humanScore() > 3)
			{
				outputText("  I’ve met humans before a few times.  Back home, my people like to play games with them to see how they’ll react; show up, scare the locals, steal a sheep and run off giggling to yourself, that kind of thing.  Sometimes one of them is actually brave enough to come after us.  Sometimes we even slap ‘em on the back, give ‘em the sheep and then drink them under the table.</i>” \n\n");
				outputText("She takes a long, powerful drag on her pipe, her lips locked tight around the mouthpiece.  “<i>It was fun for a while, but bothering goatherds for the next thousand years wasn’t my scene, frankly, so I left.  Bailed.  Disappeared.");
			}
			outputText("  I didn’t come here to fight demons or any of that nonsense, though.  I’m just looking for something <b>fun</b> to do, you know?  Something to keep my interest for a while.</i>”  She opens her eyes again, two enormous amber irises staring thoughtfully down at you.  For some reason, you find something very uncomfortable about her gaze....");
			if (player.str <= 75 || player.tallness < 96) outputText(" You can’t help but feel like a sheep yourself - one who’s just noticed the wolf is staring it down.\n\n");
			outputText("“<i>My mistake coming here, though.  There’s no conversationalists, no challenges, nothing fun. The only other conversations I’ve had since coming here have all gone more or less the same way, you know?  ‘Harharhar, I shall turn you into my slave!  How dare you pick me up, I shall destroy you!  Why are we heading towards that cliff!’  and so on.</i>”\n\n");
			outputText("Izumi seems singularly unperturbed by the sex-mad nature of this world, an attitude you find oddly refreshing.  There’s something about her; she seems to exude an aura of steady, unconcerned confidence from every movement, dripping from each word she speaks.  It’s a difficult thought to articulate, but the enormous woman’s lazy smile and relaxed attitude seem... infectious.\n\n");
			outputText("You talk animatedly with Izumi some more over the next hour or so, inquiring about the horns on her forehead, what life is like where she comes from, how she came to be here and a dozen other topics.  She explains that all of her race, the Oni, have horns that reflect their power and strength.  For her part, she asks a myriad questions about your home.  When you ask about the pipe she’s smoking, she surprises you by wordlessly handing it to you.\n\n");
			menu();
			addButton(0, "Smoke", smokeThePipe);
			addButton(1, "NoSmoke", dontSmokeThePipe);
		}

		// Set some shit up for the Pipesmoke scene during the introduction
		private const SMOKE_SPEED_REDUCE:Number = 1.1;
		private const SMOKE_SENS_BOOST:Number = 1.1;
		private const SMOKE_LIBIDO_BOOST:Number = 1.1;
		private const SMOKE_DURATION:int = 24;

		// Applies the smokeeffect to a player, based on if they used the pipe directly or not
		protected function smokeEffect(smokedPipe:Boolean):void
		{
			var deltaSpd:int = player.spe - (player.spe * SMOKE_SPEED_REDUCE);
			var deltaSns:int = (player.sens * SMOKE_SENS_BOOST) - player.sens;
			var deltaLib:int = (player.lib * SMOKE_LIBIDO_BOOST) - player.lib;
			var lustMod:int = 7;

			// Double effect for directly smokin da pipe
			if (smokedPipe)
			{
				deltaSpd *= 2;
				deltaSns *= 2;
				deltaLib *= 2;
				lustMod *= 2;
			}

			player.createStatusEffect(StatusEffects.IzumisPipeSmoke, SMOKE_DURATION, deltaSpd, deltaSns, deltaLib);
			
			// Can't use dynStats for this, because stats() has a chained modifier to incoming sens changes that could turn this value into 8x what we expected it to be
			player.spe += deltaSpd;
			player.sens += deltaSns;
			player.lib += deltaLib;
			var maxes:Object = player.getAllMaxStats();
			if (player.spe <= 0) player.spe = 1;
			if (player.sens >= maxes.sens) player.sens = maxes.sens;
			if (player.lib >= maxes.lib) player.lib = maxes.lib;
			
			showStatDown('spe');
			showStatUp('sens');
			showStatUp('lib');
			
			dynStats("lus", lustMod);
		}

		// Update the duration of the pipe smoke effect
		public function updateSmokeDuration(hours:int):void
		{
			var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.IzumisPipeSmoke);

			if (sac)
			{
				sac.value1 -= hours;

				if (sac.value1 <= 0)
				{
					this.smokeEffectWearsOff();
				}
			}
		}

		// Method to contain removal mechanics + scene text to spit out
		protected function smokeEffectWearsOff():void
		{
			var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.IzumisPipeSmoke);

			if (sac)
			{
				player.spe += Math.abs(sac.value2);
				player.sens -= sac.value3;
				player.lib -= sac.value4;
				
				if (player.sens > 100) player.sens = 100;
				var max:int = player.getMaxStats("spe");
				if (player.spe > max) player.spe = max;
				if (player.lib <= 0) player.lib = 1;
				
				showStatUp('spe');
				showStatDown('sens');
				showStatDown('lib');
				
				outputText("\n<b>You groan softly as your thoughts begin to clear somewhat.  It looks like the effects of Izumi's pipe smoke have worn off.</b>\n");
				
				player.removeStatusEffect(StatusEffects.IzumisPipeSmoke);
			}
		}

		// Actual introduction scene content for pipesmokin
		protected function smokeThePipe():void
		{
			clearOutput();

			outputText("Whatever it is she has in there, the smoke is thick and cloying and even the smallest puff makes");
			if (player.tou <= 60) outputText(" you cough and splutter");
			else if (player.tou < 75) outputText(" you flinch, holding back a cough");
			else outputText(" your eyes water");
			outputText(" - much to your mutual amusement.  You talk and joke for a while longer, the smoke making you feel incredibly relaxed, as though all the tension were simply melting from your body.");
			if (player.tou <= 80) outputText("  After a while, you find it hard to even raise your arms to reach for the pipe again.\n\n");
			else outputText("\n\n");
			
			this.smokeEffect(true);

			this.smokeJoins();
		}

		// Turn down the pipe -- still recieve SOME effect from the smoke in the cave
		protected function dontSmokeThePipe():void
		{
			clearOutput();

			outputText("You do your best to politely refuse the pipe, explaining your unwillingness to eat, drink, chew, chug or otherwise consume various items you’ve come across during your travels, having witnessed some of the effects first-hand.\n\n");
			this.smokeEffect(false);

			this.smokeJoins();
		}

		// Continue after the pipe smoke split
		protected function smokeJoins():void
		{
			outputText("Finally, the two of you seem to run out of things to speak about and the conversation dies down.  Izumi puffs on her pipe and lets out a long column of smoke, still gazing at you speculatively.  “<i>Hmm.  You’ve been pretty interesting, I didn’t expect to meet anyone who might be </i>fun<i> out here.</i>”  She mutters.  “<i>If you </i>are<i> going to keep going with this whole heroic deeds thing, try not to die, okay?  You’re the only halfway entertaining person I’ve met on this rock, and I’d hate to imagine you winding up as some imp’s body pillow, or whatever....</i>”\n\n");

			outputText("You hear Izumi let out a quiet giggle.  Looking up, you see she’s shifted closer to you, edging right up to the fire.  She makes a show of appraising you physically, her golden-amber eyes sparkling in the dancing firelight as her gaze roams over your body, from head to [foot].");
			if (player.str <= 75 || player.tou <= 75 || player.tallness <= 96) outputText("  You swallow, hard, suddenly feeling oddly nervous.");
			outputText("  She’s even larger up close, and you can clearly see the solid, capable looking muscle that makes up her frame....\n\n");

			if (player.tallness < 108)
			{
				outputText("“<i>You know, you’re pretty cute.  Did I already say that?  Well even if I did, it’s true.  I like brave people.  I like people who challenge themselves.  You’re pretty brave, surviving in a place like this all alone, you know?</i>”  Without warning, she leans forwards over the dying fire, the ruddy light from the coals illuminates her face from below, giving her a decidedly sinister air.\n\n");

				outputText("“<i>I think it’s about time you repaid me for my hospitality.</i>”  She says, her eyes glittering dangerously in the firelight.  “<i>After all, you came into my camp uninvited... that’s pretty rude, you know?  I think I might take offence to that.</i>”  As she speaks, she slinks closer to you on all fours like some kind of predatory cat, about to make the final killing leap upon its helpless prey... Her personality has changed completely from the gentle giant you were speaking with a second ago.  You suddenly wonder if perhaps the smoke is somehow affecting her.\n\n");

				outputText("“<i>I think you’d better make it up to me, yeah?</i>”  She continues, slurring her words slightly as she reaches out with one hammer-like hand, then seizes hold of your [armor].  “<i>Otherwise I might get nasty.  And you don’t want me to get <i>nasty</i> with ya’, do ya’?</i>”\n\n");
			}
			else
			{
				outputText("“<i>You’re pretty impressive, you know?  You’ve even gotten me a little homesick, coming in here looking like that.  How cruel. How cruel....</i>”  She presses a finger to her lips, thoughtfully.  Then she smiles, taking you by the hand and drawing you into the cave. “<i>I know!</i>” She says in a sing-song voice.  “<i>Since you came stomping around here so rudely, it’s only right that I get to discipline you, right?  So, in return for me letting you leave... I get to do whatever I want to you in the meantime.</i>”\n\n");
			}

			outputText("You could let her continue with whatever it is that she’s planning, but her truly gargantuan stature is more than a little intimidating.  On the other hand, you could try to fight her or make a break for it, but you don’t know how well either of those plans would work out; if there’s anything Izumi appears to be, it’s physically fit... although, as your eyes begin to adjust and Izumi’s scandalous neckline swims back into focus, the third option does seem somewhat tantalizing as well...\n\n");

			menu();
			addButton(0, "Fight", fightTheFuckhugeOni);
			addButton(1, "Surrender", fuckhugeOniGetsWhatSheWants);
			addButton(2, "Flee", fuckinChegIt);
		}

		// Player opts to leave rather than do anything
		// TODO: Bulk this up some, its way short.
		protected function fuckinChegIt():void
		{
			hideUpDown();
			
			flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 2;
			
			clearOutput();

			outputText("Spotting an opening, you decide to beat a hasty retreat, as far away from the immense woman as possible.\n\n");

			doNext(camp.returnToCampUseOneHour);
		}
		/**
		 * FIGHT SHIT
		 */
		protected function fightTheFuckhugeOni():void
		{
			hideUpDown();
			
			clearOutput();

			// First time
			if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 0)
			{
				outputText("You don’t know what Izumi is thinking, but there’s no way you’re just going to lie back and let some strange woman walk all over you, metaphorically <b>or</b> literally - and you tell her exactly that.  To your surprise, rather than lunging forwards to attack or flying off the handle, she actually beams at you.\n\n");

				outputText("“<i>Oh, you think you can take me?  That’s cute, "+ this.heightDesc() +".  That’s real cute,</i>” Izumi says, breaking off the conversation.  She picks herself up from the floor, abruptly breaking off the conversation to wander around the cave, flexing her muscles and rotating her joints as though preparing to exercise - all the while, her grin growing increasingly confident, more... ravenous.\n\n");

				if (player.tone <= 75) outputText("“<i>Alright!  I’ll tell you what I’ll do... I’ll give myself a handicap.</i>”  Izumi turns to face you, cracks her neck, then extends a hand, folding the other arm behind her back.  “<i>I’ll only use one arm.  I wouldn’t want to put you in your place </i>too<i> quickly.  Where would be the fun in that?</i>”  She leers.\n\n");

				outputText("“<i>If you can beat me, I’ll let you go.  If not, well... to the victor go the spoils.  Know what I mean?</i>”  She says, her smirk somehow growing perceptibly wider.\n\n");

				if (player.tone <= 75) outputText("The idea that she thinks she can beat you with one hand behind her back is insulting to say the least, but on the other hand, her overconfidence could be her downfall.\n\n");

				outputText("You nod, rising to your [feet] and dropping into a fighting stance. Izumi grins.  “<i>Let me just say this to start... I am </i>quite<i> strong.</i>”\n\n");
			}
			// PC won last fight
			else if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 3)
			{
				outputText("“<i>So, you’re not gonna apologize?!</i>” Izumi scowls at you, blushing slightly. “<i>You’re a real jerk, you know that?  Fine then, I’ll just have to spank some manners into you!  Don’t cry!</i>”\n\n");

				outputText("She drops into a fighting stance once again, but this time, instead of bending one arm behind her back, she hesitantly holds it up in front of her horns.  Her blush deepens as you stare at her.  “<i>Y-You cheat! I’m not falling for that kind of thing again!</i>” she explains hotly.\n\n");
			}
			// PC lost last fight
			else if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 1)
			{
				outputText("There’s no way you’re just going to lie back and let Izumi walk all over you again; at least, not without resistance.\n\n");

				outputText("“<i>Alright! I’ll tell you what I’ll do... I’ll give myself a handicap.</i>”  Izumi turns to face you, cracks her neck, then extends a hand, folding the other arm behind her back.  “<i>I’ll only use one arm.  I wouldn’t want to put you in your place </i>too<i> quickly.  Where would be the fun in that?</i>”  She leers, “<i>If you can beat me, I’ll let you go.  If not, well... to the victor go the spoils.  Know what I mean?</i>”\n\n");

				outputText("You nod, rising to your feet and dropping into a fighting stance.\n\n");
			}
			// PC ran away
			else if (flags[kFLAGS.IZUMI_LAST_ENCOUNTER] == 2)
			{
				outputText("Sooner or later, you’re going to have to face up to the large Oni.  No time like the present, right?\n\n");

				outputText("Izumi can clearly tell that you have no intentions of running away on her... again.  To your surpise, rather than lunging forwards to attack or flying off the handle, she beams at you.  “<i>Alright! I’ll tell you what I’ll do... I’ll give myself a handicap.</i>”  Izumi turns to face you, cracks her neck, then extends a hand, folding the other arm behind her back.  “<i>I’ll only use one arm.  I wouldn’t want to put you in your place </i>too<i> quickly.  Where would be the fun in that?”  She leers, “<i>If you can beat me, I’ll let you go.  If not, well... to the victor go the spoils.  Know what I mean?</i>”\n\n");
			}
			else
			{
				throw new Error("You done fucked something up in Izumi's fight intro text!");
			}

			startCombat(new Izumi());
		}

		/**
		 * SURRENDER SCENES
		 */
		protected function fuckhugeOniGetsWhatSheWants():void
		{
			hideUpDown();
			
			clearOutput();

			// Male/Herms
			if (player.hasCock())
			{
				outputText("You swallow your pride and shake your head, signalling Izumi that you don’t intend to resist.  Her face splits into a truly lascivious grin and she licks her lips, hungrily.\n\n");

				outputText("“<i>Yeah, that’s what I thought.</i>”  She smirks.  “<i>You just do exactly what I say, when I say, and nothing bad will happen to you.  Well... Nothing <i>too</i> bad, anyway.</i>”\n\n");

				outputText("Suddenly, she lunges forwards, one enormous hand planting itself onto your");
				if (player.isTaur()) outputText(" flank and forcing you sideways onto the ground.");
				else outputText(" chest and forcing you backwards onto the ground.");
				outputText("  You grunt from the impact and try to sit up, but Izumi easily restrains you with a single well-muscled arm.  “<i>Well now, let’s see what we’re workin’ with here, shall we?</i>” she announces casually, as she pulls aside your [armor] to reveal your cock.\n\n");

				if (player.biggestCockLength() <= 6) surrenderSmallCock();
				else if (player.biggestCockLength() <= 14) surrenderMediumCock();
				else surrenderLargeCock();
			}
			// Female
			else if (player.hasVagina())
			{
				surrenderOhGodTheFemaleSurrenderContentIsFuckingHugeSendHelp();
			}
			// Genderless
			else
			{
				noDickNoVagNoService();
			}

			flags[kFLAGS.IZUMI_TIMES_SUBMITTED]++;
			flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 1;
			flags[kFLAGS.IZUMI_SEEN_PC_GENDER] = player.gender;
		}

		// Male/Herm scene for cocks <= 4"
		protected function surrenderSmallCock():void
		{
			outputText("“<i>Ohhh!</i>”  She positively purrs as her eyes fall upon your naked [cock biggest] for the first time.  “<i>What’s this?</i>”  She leans forwards to stare at your genitals with undisguised interest.  “<i>Well, now... I figured you [race]s would be pretty");
			if (player.isTaur()) outputText(" big");
			else outputText(" small");
			outputText(", but this isn’t what I was expecting at all.  Hmm... I </i>was<i> planning on giving you a handjob, but, uh... I guess this’ll have to do, huh?</i>”  She gives you an almost apologetic smile as she holds up her hand, thumb and forefinger curled into a ring as though to show you what she has planned, before reaching back down to your groin. Her fingers slide over your stiffening flesh and you realize in a flood of soul - crushing embarrassment that she’s right.  You’re so small, she actually can’t fit more than two fingers around your cock at a time.\n\n");

			outputText("You try to look away, blushing crimson, but the weight on your");
			if (player.isTaur()) outputText(" flank");
			else outputText(" chest");
			outputText(" suddenly disappears as Izumi grips your chin with her free hand, forcing you to lock gazes with her.  “<i>Hey, don’t look away!</i>”  She chides.  “<i>Seeing your face during all this is the best part... aw, hey, are you embarrassed?  You’re blushing!  That’s so </i > cute !” She trills.  “<i> Here, look.  I know what’ll make ya feel better....</i>”  Before you can respond, the domineering Oni woman");
			if (player.isTaur()) outputText(" perches her muscular ass on your flank, your body making for a suitable seat.");
			else outputText(" drops to the floor, laying next to you on her side.");
			outputText("  She releases your chin, but her hand snakes around behind your head to your other cheek, pulling you in towards her.  You can’t help but grunt in surprise as the side of your head is forcibly pushed up against one massive, pillowy-soft breast");

			if (player.biggestTitSize() >= 1 && player.biggestTitSize() < 3) outputText(", your [chest] dwarfed by the larger womans own pair.");
			else if (player.biggestTitSize() >= 3 && player.biggestTitSize() < 5) outputText(", your [chest] moulding themselves against the underside of the Oni’s larger pair.");
			else if (player.biggestTitSize() >= 5 && player.biggestTitSize() <= 8) outputText(", your [chest] compressing against the Oni’s larger pair, forming a delicious valley of flesh between your bodies.");
			else outputText(", your [chest] dwarfing the larger womans own pair.");

			outputText("  “<i>There.</i>”  She announces happily, softly stroking your cheek as though to reassure you.  “<i>All better now, right?  Good.</i>”  She doesn’t even wait for a response before turning her attention back to your [cock biggest]....\n\n");

			outputText("Izumi holds you there easily, pinned against her chest as she slowly coaxes your stiffening erection to life, and you finally realize that you’re completely trapped.  If there ever was a chance for you to slip free and escape from this situation you must have missed it, because now you’re locked in the embrace of those strong, iron-muscled arms, all you can do is feel intimidated.  As Izumi casually molests you, you can’t help but realize how much more powerful than you she seems - how much stronger and more confident in everything she does.  At this moment, you feel as though if she desired, she could do anything she wanted to you");
			if (player.str <= 75) outputText(" and you would be powerless to resist...");
			else outputText(" and you would struggle to deny her will...");
			outputText(" a feeling that is only compounded by the burning sense of shame you feel as she jacks you off with a measly two fingers.\n\n");

			outputText("With the realisation that you’re completely under her control, something inside you simply switches off and your resistance vanishes entirely.  You decide to just let Izumi do as she wills with you; after all, she’s so much stronger than you, how could you oppose her?  Nuzzling your face into Izumi’s breast, you squirm and wriggle under her touch as your [cock biggest] reaches it’s full - if it could even be called such - hardness.  Hopefully, if you just go with whatever she wants to hear, this won’t be so bad.\n\n");

			outputText("“<i>So, you’re ashamed of this, are you?</i>”  Izumi suddenly asks.  You don’t respond, so she stares down at you.  “<i>Answer.</i>”  She commands, her tone imperious.  You can’t bring yourself to speak, so you simply nod, burying your face in her silk-covered bust.  “<i>Good.  You answer when I ask you something, "+ this.heightDesc() + "</i>”  She nods approvingly and resumes her slow, gentle strokes.  The casual, unhurried pace of her handjob is beginning to drive you insane; it’s certainly pleasurable, but it’s also agonizingly slow, and you long for her to just speed up even the tiniest bit...\n\n");

			outputText("“<i>Well, I can certainly see why you </i>would<i> be ashamed of it.  It’s pretty tiny, you know?  In fact, I think this is probably the smallest I’ve </i>ever<i> seen.</i>”  She announces, and you wince. Part of you wishes she would just shut up, but somewhere deep inside you, another part of you feels almost... curious?  Part of you, some dark, treacherous part, wants her to continue.  Part of you wants to know more");
			if (player.hasVagina()) outputText(", sticky moisture dribbling across your thigh, your [vagina] clenching in lust - fueled harmony with your cock");
			outputText("... “<i>Hey, don’t get upset.  After all, </i>” She pauses for a moment, her hand lingering in place.  “<i>Some women </i>like<i> ‘em small...</i>”\n\n");

			outputText("“<i>So, let me guess.  In a place like this, it’s gotta be weird having something this small, right?  I mean, it’s a pretty unique trait, given the circumstances.</i>”  She continues.  “<i>Hey, tell me something.  Do the harpies leave you alone?  Are you so small that they think you’re ");
			if (player.gender == 3) outputText(" just a regular");
			else outputText(" a");
			outputText(" girl?</i>”  Suddenly, her hand bottoms out around your [cock biggest]");

			if (player.balls > 0) outputText(" and her free fingers reach out to gently stroke against your [balls].");
			else if (player.hasVagina()) outputText(" and her free fingers reach out to gently stroke against your [vag].");
			else outputText(".");

			outputText("  At the same time, she leans in close to your ear.  “<i>Do the </i>Minotaurs?”  She hisses suggestively, eyes flashing.\n\n");

			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1)
			{
				outputText("The moment the word ‘Minotaur’ enters your lust-addled brain, your body shifts over to automatic. Your [cock biggest] twitches painfully, loins longing for the release that can only come from being filled full of gallons of hot Minotaur cream, and you let out a distinctly feminine sounding moan as depraved fantasies of being roughly taken by the bull-men rush through your head.\n\n");

				outputText("Izumi leers shamelessly at your reddening face, then whispers, softly into your ear.  “<i>Dirty [boy]....</i>”  You realize that she knows exactly what you’ve been doing - or rather, what’s been repeatedly doing <i>you</i> - and that shameful revelation combined with the burning arousal you feel from the very thought of minotaur cum is more than enough to force you over the edge into a sudden orgasm.  Far from being upset, Izumi seems positively overjoyed at your premature ejaculation.\n\n");

				outputText("“<i>Ahaha, well now, look at that!</i>”  She cries, beaming.  “<i>I guess I called it right, hmm?  Geez, did the minotaurs do something to you, or were you always this perverted?</i>”  Izumi snickers.  You can’t even muster up the energy to respond, you’re so drained from your sudden orgasm.\n\n");
			}
			else
			{
				if (!player.isTaur()) outputText("As you squirm in her arms, she releases your head from her grip, instead pushing you up into a seated position.");

				outputText("“<i>Hold on, I want to watch this.</i>”  She says, shifting position until her head is placed on one side of your hip, staring at your [cock biggest]");
				if (!player.isTaur()) outputText(" as one arm reaches around to continue the handjob from the other side");
				outputText(".  She stares intently at your cock, an expectant smirk plastered over her face, her free hand working");
				if (player.isTaur()) outputText(" over your flank");
				else outputText(" you over with increased vigour");
				outputText(".  Before you know it the combination of her skilled fingers and the bizarre, embarrassing sensation of being so carefully observed are pushing you over the edge.  Rather than leaving off as you cum, Izumi’s handjob actually speeds up, her eyes widening in excitement as your orgasm floods through you.  The sensation is much more powerful than you usually experience, perhaps due to Izumi’s extensive teasing, and you can only sit and shudder, staring down at yourself in shock as your [cock biggest]");

				if (player.cumQ() <= 100) outputText(" dribbles a hot, sticky mess onto the cold cavern floor.");
				else if (player.cumQ() > 100 && player.cumQ() <= 250) outputText(" spurts and splutters a hot, sticky mess onto the cold cavern floor.");
				else if (player.cumQ() > 250)
				{
					outputText(" shoots out rope after rope of hot, sticky cum across the cold cavern floor");
					if (player.cumQ() > 500) 
					{
						outputText(", a small puddle of creamy-white forming between you and the cavern wall");
						if (player.cumQ() > 1000) outputText(", slowly expanding into a small lake....\n\n");
					}
					else
					{
						outputText(".\n\n");
					}
				}

				outputText("“<i>Hah!  Oh yeah, thar she blows!</i>”  Izumi crows, staring fixatedly at your spasming dick like a woman possessed.  “<i>Now ain’t that a pretty sight... Yeesh, and you just keep cumming and cumming.  Did being teased feel that good, "+ this.heightDesc() +"?</i>”  She grins. You can’t seem to find the energy to respond, panting for breath as you stare in confusion at your already-deflated cock, your balls aching from the strain of such a forceful ejaculation.\n\n");
			}

			outputText("“<i>Well, that was fun.</i>”  Izumi says, sitting up and dusting off her palms, dismissively.  “<i>I’m assuming you’re not up to a rematch just yet from the way you’re shaking.</i>”  She picks up her pipe and takes a drag, shooting you a knowing grin.  “<i>Feel free to drop by again, though.  You know, in case you wanted to tell me off... or maybe if you just want me to bully you some more.</i>” \n\n");

			player.sexReward("Default","Dick",true,false);

			menu();
			doNext(camp.returnToCampUseOneHour);
		}

		// Male/Herm scene for cocks <= 10"
		protected function surrenderMediumCock():void
		{
			outputText("“<i>Huh.  Not bad, " + this.heightDesc() +"; I gotta say, I thought you people’d be");
			if (player.isTaur()) outputText(" bigger");
			else outputText(" smaller");
			outputText(" down here... or are you just a little ‘gifted’?</i>”  She says, giving you a lopsided grin.  You attempt to stammer out a reply, but she ignores you, instead focusing her attention completely on your [cock biggest].  Still restraining you with one hand, her other hand glides across your cock, easily bringing it to hardness.  You can’t help but gasp as you feel her talented fingers playing across your flesh; from the way she seems to naturally gravitate to all of your most sensitive spots in turn, you can’t help but think she must have done this kind of thing before.\n\n");

			outputText("In mere moments, you’re fully erect, as hard as you’ve ever been");
			if (player.hasVagina())
			{
				outputText(", your [vagina]");
				if (player.wetness() == 0) outputText(" moistening");
				else if (player.wetness() == 1) outputText(" dribbling runnels of sticky fem-juice");
				else if (player.wetness() == 2) outputText(" constantly oozing feminine arousal");
				else outputText(" a soppy mess, gushing a veritable lake of fem-slime");
				outputText(" in lust-fueled harmony with your cock.");
			}
			else outputText(".");
			outputText("  Izumi looks down at you and flashes you an indulgent smile.");

			outputText("“<i>So, I guess we can start now.</i>”  Says the Oni as she drops into position,");
			if (player.isTaur()) outputText(" perching her muscular ass on your flank, your lower body offering a comfortable seat for Izumi.");
			else outputText(" laying on her side next to you.");
			outputText("  She releases your");
			if (player.isTaur()) outputText(" flank");
			else outputText(" chest");
			outputText(" and instead leans on her elbow, leaving you uncomfortably free and completely unsure of what to do with yourself as she wraps her hand around your [cock biggest] and slowly begins to stroke you.  Her palms are warm and pleasingly soft, something you didn’t expect from the well-muscled Oni woman.\n\n");

			outputText("Her pace is glacially slow, but as her hand rolls gently up and down your length, she somehow manages to find each and every secret spot, every sensitive place, causing you to flinch and quiver under her grasp.  You grit your teeth and squirm in discomfort as Izumi teases your cock in an entirely new way.  Already, you can feel your body rebelling at the bizarre, paradoxical sensations.  Unable to comprehend what is happening, every fiber in your body screams a single thought in unison; <b>faster</b>.\n\n");

			outputText("Without warning, your hips spasm and buck");
			if (player.isTaur()) outputText(" upwards");
			outputText(" almost of their own accord.  Izumi’s fingers tighten a little, just enough to keep her grip, but her gentle motions stop completely.  She simply holds on, grinning slyly at you as you desperately hump into the air.  Izumi’s amber eyes glitter in the gloom as she leans in closer to you, whispering into your ear.\n\n");

			outputText("“<i>Lay back and settle down, or I ruin your fun.</i>” she purrs.\n\n");

			menu();
			addButton(0, "Obey", surrenderMediumCockObey);
			addButton(1, "Refuse", surrenderMediumCockRefuse);
		}

		// Male/Herm play along scene split
		protected function surrenderMediumCockObey():void
		{
			outputText("Taking a deep breath, you grit your teeth and force yourself to calm down.");
			if(player.isTaur()) outputText("  Y");
			else outputText("  Lowering your shaking hips, y");
			outputText("ou manage to relax and simply wait passively for Izumi to resume her handjob.\n\n");

			outputText("“<i>That’s better.</i>”  Izumi says approvingly.  “<i>Now, since you played nice...</i>” She trails off dangerously, but before you can try to figure out what she has planned, she hits you with it - her handjob resumes, but much, much faster than before.  Despite her increased speed, she still manages to hit every single spot she was hitting before, causing a whirlwind of pleasure to rush through you.\n\n");

			outputText("Almost immediately, you feel your orgasm starting to rise within you.  You try to stammer out a warning, but Izumi’s pace continues unabated.\n\n");

			outputText("“<i>It’s fine.  Just cum as much as you like.</i>”  She announces casually.  A few seconds later, your orgasm hits, exploding forcefully out of your [cockhead biggest].  Even once she sees the burning juice begin to erupt from your cock, Izumi doesn’t slow down - on the contrary, she actually accelerates her pace!  As she extends your orgasm over and over again, all you can do is writhe around, drumming your feet against the floor and groaning in ecstasy as the massive Oni woman vigorously milks you, draining your aching");
			if (player.balls > 0) outputText(" balls");
			outputText("cock");
			outputText(" to the very last drop.\n\n");

			outputText("Finally, she relents, and your extended orgasm mercifully subsides.  Izumi stares indulgently down at your shivering form for a moment, before muttering a quiet “<i>Heh,</i>” and wandering back over to her tent.  You can only manage to rest there, laid prone in a");
			if (player.hasVagina()) outputText(" mixed puddle of your own fem-slime and");
			else outputText(" puddle of your own");
			outputText(" cum, staring at the cavern roof and panting madly for a good few minutes afterwards.  Once you regain the use of your legs, you retrieve your clothes and wander back to camp in a daze.\n\n");

			player.sexReward("Default","Dick",true,false);

			menu();
			doNext(camp.returnToCampUseOneHour);
		}

		// Male/Herm be a jerk about it split
		protected function surrenderMediumCockRefuse():void
		{
			outputText("Sick of Izumi and the strange, uncomfortable feelings the Oni keeps forcing you to experience, you defy her command.  Instead, you thrust more vigorously into the air, turning this way and that, trying to force some form of stimulation from the hand mercilessly gripping your member.\n\n");

			outputText("“<i>Fine.</i>”  Izumi says, apparently unconcerned.  “<i>Go ahead and try.  It won’t do you any good.</i>”\n\n");
			 
			outputText("Ignoring her, you continue thrusting, twisting and turning, but always Izumi follows you effortlessly, thwarting every twist and turn you make in a desperate attempt to fuck her hand.  Finally, after an eternity of painful stalemate, you give in, collapsing to the ground, momentarily exhausted.\n\n");
			 
			outputText("“<i>All done?</i>”  She asks.  You glare at her, and her grin widens.  “<i>So, you wanna cum, huh?  Well then, let’s do that.</i>”  She announces, happily.  Suddenly, she begins stroking you again - this time at a speed far beyond her previous unhurried pace.  Her hand flies up and down your shaft, stimulating you just as much as before, but at easily three times the speed!  It is, without a doubt, the most amazing handjob you’ve ever experienced.\n\n");

			outputText("The insane feeling is just too much, and you feel your orgasm boiling up within you.  Just as you feel yourself rising to crest the orgamsic wave and hit sweet release... Izumi lets go.\n\n");
			 
			outputText("You cry out in anger and pain as you find your impending orgasm so cruelly denied, your [cock biggest] twitching and throbbing painfully");
			if (player.hasVagina()) outputText(", [vagina] spasming in sympathy");
			outputText(", desperate for release.  Somehow, she could sense you were on the verge of orgasm, and she chose to deny you that pleasure, you just <b>know</b> it.  You shoot Izumi a vicious, hateful glare, only to see her laying there quite calmly, her expression blank.\n\n");
			 
			outputText("“<i>Hm?</i>”  She grunts, looking surprised.  “<i>Oh, do you want some help?  Sure; here, let me handle this for you.</i>”  She says, her tone even.  She reaches out and, very deliberately, softly flicks your [cockhead] with a single finger.\n\n");
			 
			outputText("The sensation is almost nothing, but as close as you are, it’s just enough.  You groan in a mix of pleasure and heartbroken anguish as the tiny amount of contact forces you over the edge, your load forcing its way up through your cock with agonizing slowness until finally");
			if (player.cumQ() <= 250) outputText(" spurting free, spattering down randomly over you as Izumi watches, happily observing the effects of your ruined orgasm.");
			else if (player.cumQ() <= 500) outputText(" sputtering freely from your [cock], glob after glob of thick jizz showering down randomly over you as Izumi watches, mildly amused with the results of your ruined orgasm.");
			else if (player.cumQ() <= 1000) outputText(" a torrent of fertile spunk rushes forth from your [cock], glob after glob of thick jizz showering down randomly over you, covering you from head to toe.  Izumi simply watches, amused with the results of your ruined orgasm.");
			else outputText("a torrent of fertile spunk rushes forth from your [cock], rope after rope of the thick cum launching into the air and splattering down over you.  Your orgasm continues unabated as you slowly paint yourself in a creamy white layer, Izumi giggling quietly, evidently quite proud of herself.");
			outputText("  Finally, you finish cumming, and as you lay panting in the results of her handiwork, Izumi gently pats you on the head.\n\n");

			outputText("“<i>So, you learned something today, right?  Next time, just do what I say, and the results are much more... fun.</i>” She smiles, then turns away.  Retrieving your clothes, you drag yourself back to camp, feeling decidedly shaky.\n\n");

			player.sexReward("Default","Dick",true,false);

			menu();
			doNext(camp.returnToCampUseOneHour);
		}

		// Urtadicks itt
		protected function surrenderLargeCock():void
		{
			outputText("Izumi grunts in surprise as your [cock biggest] flops free of its confinement.  “<i>Damn.  This is pretty impressive, you know?</i>”  She frowns, running an exploratory hand across the length of your flesh.  “<i>Let me guess, you got a bit too frisky with one of the natives?  Maybe didn’t think to boil the water before you drank it?  Look, no offence, but there is no way this thing is legit, "+ this.heightDesc() +".</i>”\n\n");
 
			outputText("Izumi continues to frown as she inspects you, turning your stiffening cock this way and that in her hands, apparently indifferent to the way her touch has begun to coax you towards full hardness.  She murmurs to herself under her breath, tapping a finger to her lips whilst absentmindedly wringing your cock with her other hand.  Eventually, she appears to reach a decision.  “<i>Alright!</i>”  She announces, loudly.  “<i>Let’s try it like this, shall we?!</i>”\n\n");
			 
			outputText("Izumi releases you from the floor, allowing you to sit");
			if (player.isTaur()) outputText(" back on your haunches, front end raised");
			outputText(" up as she makes her way around to sit cross-legged between your legs.  Once settled into position, she smirks suggestively at you around the throbbing meat now standing at insistent attention between the two of you.  “<i>Get ready,</i>” She warns, “<i>because this is going to be a hell of a ride... and you wouldn’t want to disappoint me now, would you?</i>”\n\n");

			outputText("“<i>Six!</i>”  She shouts, suddenly, making you flinch in surprise as her right hand snaps out and latches onto your cock, just below the sensitive [cockHead biggest].  Izumi grins, slowly rotating her wrist and wringing her hand around in place, but she doesn’t start up any kind of up-and-down motion - yet.\n\n");
			 
			outputText("“<i>Five!</i>”  She yells, and her left hand joins the first in gripping your cock, this time about halfway down your shaft.  Again, her wrist rotates gently as she massages the area, but her hand doesn’t actually go anywhere.  Her grin widens into a truly ominous smile as she leans forwards conspiratorially.\n\n");
			 
			outputText("“<i>Four.</i>”  She whispers, and without warning her legs unfold, both feet flying out from beneath her and latching onto the [sheath] of your [cock biggest]!  Izumi leers at you with undisguised amusement as she watches your reaction to the sensation of her bare soles rolling over the [sheath] of your shaft");
			if (player.balls > 0 && !player.hasVagina()) outputText(", occasionally sliding down to massage your [balls] before returning to your cock.");
			else if (player.balls == 0 && player.hasVagina()) outputText(", occasionally sliding down to tease at the lips of your [vagina].");
			else if (player.balls > 0 && player.hasVagina()) outputText(", occasionally sliding down, alternating between a gentle massage of your [balls] and teasing caresses of your [vagina].");
			outputText("\n\n");

			outputText("The strange sensation causes you to quiver, your towering erection twitching ominously.  “<i>Hey, don’t give up just yet!</i>” Izumi quips. “<i>We’re just about to get to the fun part...</i>”  Already beginning to sweat as the mind-addling smoke fogs your brain with lust, you briefly wonder what exactly ‘the fun part’ entails....\n\n");
			 
			outputText("“<i>Three.</i>”  She announces casually, and then begins to move.  You groan in equal parts pleasure and surprise; Izumi’s feet are surprisingly dextrous, and you can’t help but be amazed at how warm and soft her soles feel as they glide across your skin.  Incredibly, there seems to be almost no difference in sensation between her feet and her hands; if you close your eyes, it almost feels as though you’re being stroked along your entire length by four hands at once....\n\n");
			 
			outputText("“<i>It’s good, right?</i>”  Izumi’s voice penetrates your thoughts, and you open your eyes to see her gazing up at you, amber irises glittering in the half-light of the fire.  “<i>You know, there’s one more level to this... but looking at the state you’re in, there’s no way you could endure it for long.  In terms of pleasure, it outclasses what I’ve been doing up to now completely. Do you want to see it?</i>”  You don’t even have to think about it.  You nod your head, unsure if you can manage the difficult task of speaking, and Izumi giggles.  “<i>Alright, "+ this.heightDesc() +", but don’t say I didn’t warn you.  Here we go...</i>”\n\n");
			 
			outputText("“<i>Two.</i>”  She teases, her technique changing completely.  Rather than just running her hands and feet gently over your flesh, she grips on tightly, her hands clenching around your [cock biggest] like vices.  Her movements change completely, instead of the simple, slow up-and-down motion she had been using, she begins to alternate the motions of her left and right angles of attack - while her left hand rolls up your shaft, the right slides down to meet it.  Even her feet seem to somehow press in tighter against your flesh, mirroring her hands; the strange technique creating a unique wave-like rolling sensation that feels quite unlike anything you’ve experienced on Mareth before. You wonder briefly if there might be a little bit of magic involved here before your thoughts are obliterated by an avalanche of pleasure - Izumi has begun to speed up.\n\n");
			 
			outputText("You can only grunt and shiver under the onslaught as Izumi works you over with this bizarre new approach.  There’s no gentleness here, you realize; no playful teasing or long, drawn out pauses.  This move is designed for one thing, and one thing only - to force you to cum.");
			if (player.balls > 0) outputText("  You groan, your aching balls coming to the same conclusion as you have, twitching under a passing stroke from one of Izumi’s soles and tensing up in readiness.");
			outputText("  You understand now why Izumi warned you about this technique; you are no longer being teased, gently coaxed towards the edge and then pulled back at the last minute.  As of now, you are being milked.\n\n");
			 
			outputText("“<i>One.</i>”  She commands, her tone demanding.  After only a few moments, you throw back your head and let out a long, ecstatic moan as you cum, your orgasm fountaining up through you and exploding free of your [cockhead biggest].  As the first jet of semen surges free of your cock and thrusts up into the air, Izumi gasps.  A split second later, she releases you and launches herself backwards in a powerful roll that catapults her across the cave. Your first load splatters explosively down where she had been sitting moments ago, but you’re too busy firing off a second to care.\n\n");

			if (player.cumQ() > 500) outputText("You remain sat there for a crippling eternity, unable to do anything but moan as you inexplicably continue to cum, your aching erection firing out shot after shot of hot, dripping goo as Izumi watches you from the safety of the shadows, grinning happily like the cat that got the cream.  ");

			outputText("Eventually, your orgasm subsides, and you collapse");
			if (player.isTaur()) outputText(" sideways");
			else outputText(" backwards");
			outputText(" onto the ground, staring up at the roof of the cave in a daze.  After a few seconds, Izumi’s face appears in your field of vision, albeit upside down.\n\n");

			outputText("“<i>Haha... Sorry about that, but I didn’t want you to ruin my clothes, you know?</i>”  She half-apologizes, giggling.  “<i>Hmm... maybe that move was a little much to try on a [race].  I just thought that since you were a little more... <i>robust</i> than most others of your kind that I’ve met, you’d be able to take it.  I did try to warn you, although... It seems like you enjoyed yourself anyway, hmm?</i>”  She beams.  You can barely find the energy to blink, let alone to muster a response.\n\n");
			 
			outputText("Izumi returns to her tent and lights up her pipe, unceremoniously abandoning you there on the cave floor, apparently done with you for now.  Still, it’s some time before you are able to drag yourself to your feet and stumble home to your camp, wondering how long it’ll be before you can see straight again...\n\n");

			player.sexReward("Default","Dick",true,false);

			menu();
			doNext(camp.returnToCampUseOneHour);
		}

		protected function surrenderOhGodTheFemaleSurrenderContentIsFuckingHugeSendHelp():void
		{
			outputText("You resign yourself to letting Izumi do as she wills with you, and hesitantly reach to start undressing.");

			// First time addition to the start of the scene
			if (flags[kFLAGS.IZUMI_TIMES_SUBMITTED] == 0)
			{
				outputText("  Before you can remove your clothes, however, Izumi grabs a hold of your wrist.\n\n");

				outputText("“<i>Not so fast, I’ve never really had a chance to play with a girl before.  I wanna take my time on this one...</i>” She says.  Smiling suggestively, she reaches out and slowly divests you of your [armorname].");
				if (player.cor <= 33) outputText("  You can’t help but feel a crippling sense of embarrassment as the strange woman undresses you, and you look away, embarrassed, while Izumi’s hands explore your body.");
				else if (player.cor >= 66) outputText("  As Izumi slowly reveals your naked body to the world, you begin to feel an oh-so-familiar heat building up inside of you.  You look down at Izumi with pride as she inspects your body, running a skillful hand over your chest with a thoughtful look on her face.");
				outputText("\n\n");

				// Big knockers!
				if (player.biggestTitSize() >= 15)
				{
					outputText("Izumi’s eyes widen in surprise as she pulls aside your clothing to reveal your impressive bust, your [chest] finally free.\n\n");

					outputText("“<i>Wha- Wait, these are real?!</i>”  she exclaims, loudly.");

					// Low corruption
					if (player.cor < 50)
					{
						outputText("Sheepishly, you nod as Izumi manhandles your massive mammaries as though looking for evidence of their falseness.  She bites her bottom lip, glaring intently at you as she roughly runs her hands over your breasts.  Although the Oni woman’s palms are surprisingly soft, her treatment of your breasts is not - she practically mauls you, squeezing, groping, even pinching the soft flesh.\n\n");

						outputText("“<i>Unbelievable...</i>” She mutters to herself, bitterly.  She looks up at you, confusion still plain upon your face, then scowls.  “<i>You don’t even know why I’m annoyed, do you?  Does having a chest THIS huge,</i>” she reaches out and pinches one of your [nipples] between her thumb and forefinger, causing you to yelp in surprise and pain.  “<i>Just seem normal to you?!</i>”  She grumbles in frustration before giving the nipple a sharp tug, causing you to cry out once again.  “<i>Forget it.</i>”\n\n");
					}
					// High(er) corruption
					else
					{
						outputText("You smile and nod proudly as Izumi examines your breasts, experiencing a giddy little thrill at the feeling of her soft palms rolling across your endowments.  She bites her bottom lip, glaring intently at you, and you return her gaze with amused indifference.  Although the Oni woman’s palms are surprisingly soft, her treatment of your breasts is not - she practically mauls you, squeezing, groping, even pinching the soft flesh. The rough treatment is deliciously arousing, and you can’t help but let out a few soft moans at being manhandled so forcefully - much to Izumi’s obvious annoyance.\n\n");

						outputText("“<i>Let me guess, you intentionally made them grow this big?</i>”  She scowls.  She reaches out and pinches one of your nipples between her thumb and forefinger, causing you to let out another excited little groan.\n\n");

						outputText("You respond with a shrug, teasingly, not entirely wanting Izumi’s abuse to stop.  Izumi’s frown deepens and she tweaks your nipple, twisting it painfully to the side, eliciting another gasp from you.\n\n");

						
					}

					outputText("“<i>How shameless.</i>”  She grumbles, returning her gaze to your bust.  “<i>How utterly shameless....</i>”\n\n");
				}
			}
			else
			{
				outputText("Before you can finish removing your clothes, Izumi grabs a hold of your wrist.  She takes over, placing herself firmly in charge of your state of dress.\n\n");
			}

			// PC is an exhibitionist!
			if (flags[kFLAGS.PC_FETISH] >= 1)
			{
				outputText("While Izumi takes her time freeing you of your [armor], you experience a little familiar thrill as Ceraph’s cursed piercings start to work their magic.  Every inch of your skin from head to foot tingles with excitement as you relish the prospect of finding yourself on display once again, naked and defenceless for the whole world to stare, or scowl, or leer - it makes your nipples harden just thinking about it.\n\n");

				outputText("Looking up at you with a superior smirk, Izumi continues to run her hands over your body, clearly more interested in stealthily groping you to check out the goods than actually undressing you. The tortuous anticipation just makes everything feel that much better though - soon, you’re going to find yourself completely naked in front of this strange woman. Not just yet, but <i>soon</i>, oh so soon....  It’s hard to believe how erotic the idea now seems to you.  Like a child the night before a birthday, you’re equal parts excited and desperate - and before long you’re practically screaming internally for Izumi to hurry up, rip off the rest of your clothes and just strip you <i>bare</i> already.  By the time she gets round to removing the bottom half of your clothing, you’re positively soaking wet.\n\n");

				outputText("Izumi grunts in surprise as she surveys your dripping folds");
				if (player.hasCock()) outputText(", your [cock] slowly thickening under her scrutiny");
				outputText(".  You shift in place,");
				if (player.isNaga()) outputText(" wriggling atop your [legs]");
				else outputText(" subtly parting your [legs] and even ");
				if (player.isTaur()) outputText(" rolling your butt upward");
				else outputText(" tilting your hips forwards");
				outputText(" a little, to ensure that Izumi gets a really <b>good</b> look at you down there.  The shameless act sends a flush of embarrassed warmth through you, making you tremble in pleasure.  You’re unable to keep yourself from smiling a little - you can barely manage to stop yourself from moaning aloud.  You place your hands above your breasts, hoping that Izumi will stop to look at them... which she does, looking up a moment later to say something, then pausing as her eyes linger at the sight of your [chest].\n\n");

				if (!player.isNaga()) outputText("You rub your thighs together in delight");
				else outputText("You wriggle and writhe in delight");
				outputText(" as Izumi stares at your proudly displayed chest, enjoying the sensation of being watched and idly wishing you had something to fill the aching void");
				if (player.isNaga()) outputText(" deep within your [vagina].  You slither around in place, your [leg] shifting and weaving around, moving and undulating... b");
				else outputText(" between your [legs] as well.  As you move your weight repeatedly from one [foot] to the other, you shiver in enjoyment.  B");
				outputText("eing stared at feels so good.... You blink, suddenly called back to reality by Izumi’s voice.\n\n");

				outputText("“<i>Look, "+ this.heightDesc() +", I know I’m kind of an intimidating specimen, but you don’t really need to be scared.</i>” She smirks.  “<i>You keep shivering in fear like that and I’m liable to take offence, yeah?</i>”  You blink again in confusion before realization finally dawns.  Izumi has absolutely no idea how much this is turning you on.  The idea of your secret arousal going completely unnoticed is surprisingly erotic, and that thought turns out to be just enough to push you over the edge.  You wince and bite your lip to stifle your moans, quivering in the throes of a miniature orgasm, even though you’ve really yet to be even touched... and on a whim, you decide to keep eye contact with Izumi for the entire thing.\n\n");

				outputText("Staring into those steady amber eyes as you quietly cum adds an entire new level of deliciously wrong-feeling pleasure to the affair, something you resolve to enjoy for as long as possible. Finally, your orgasm subsides, and you visibly relax.\n\n");

				outputText("“<i>There.  See?  I ain’t so bad.</i>”  Izumi smiles again, still apparently oblivious to your fun at her expense.  “<i>Now, we get to move on to the good part.  You ready? </i>” She asks.  You smile and nod, still basking in the post-coital warmth of your inner glow.\n\n");
			}

			// Scentime!

			// Non-Taurs
			if (!player.isTaur())
			{
				outputText("Without warning, Izumi violently lunges forward, grabbing at you.  You are only able to let out a surprised yelp before she grips onto your arms, pulling you towards her and spinning you around.");
				if (!player.isNaga()) outputText("  Before you know it, she has you down on your knees, the cold stone of the floor digging into your [skinfurscales] a little as she circles behind you, smirking cruelly.");
				else outputText("  She takes hold of your shoulders and forces you lower to the ground, forced to slither more and more of your tail out from under yourself, until Izumi towers over you.  She circles behind you, a cruel smirk the only hint of her intentions.");
				outputText("\n\n");

				outputText("Izumi reaches around from behind you and you half turn to look at her, but she grips you by the chin and firmly turns your head away from her.  Your gaze flits nervously around the cave at random as you feel Izumi’s other hand glide slowly across your [skinfurscales], running along your stomach and down towards your");
				if(player.isNaga()) outputText(" [leg]");
				else outputText(" thighs");
				outputText(".\n\n");

				outputText("“<i>Well now, let’s see...</i>” She murmurs into your ear, softly.  “<i>What can I possibly do with you, hmm?</i>”  She jerks you painfully back upright, locking your arm behind you as she frogmarches you towards the entrance to her cave.  “<i>You’re really pretty, you know that?</i>”  She purrs.  “<i>It’d be a shame to hide such a pretty thing away in a dark place like this, wouldn’t it?</i>”\n\n");

				outputText("Struggling helplessly against the enormous Oni’s iron-hard muscles, you stagger over to the mouth of the cave.  A gust of cold mountain air blows over you, chilling your skin and causing you to shiver as your nipples harden.  Izumi halts, stopping your wobbling advance dead. You gaze out at the scenery for a moment, the vast mountain range spread out below you, and for a moment you’re filled with an irrational fear that she intends to simply hurl you off the cliffside and leave you to fend for yourself without your gear.  Then, suddenly, Izumi kicks your legs out from under you.\n\n");

				outputText("You cry out in surprise and terror, then let out a grunt as you find yourself being yanked backwards into Izumi’s lap.  Her legs entwine with yours, yanking them apart painfully, exposing your [vagina] to the cold mountain winds.  At the same time, she grips both your wrists with one hand, pulling them behind your back, forcing you to arch backward, and thrusting your [fullchest] out for inspection.  You gasp in surprise as you feel her other hand reach around to grope at your breasts, squeezing and massaging them experimentally.  Despite yourself, you can’t help but let out a yelp as she squeezes a [nipple] between thumb and forefinger.\n\n");

				outputText("As you squirm in Izumi’s grip, it begins to dawn on you that you’re not getting away from this.  Your resistance begins to lessen until eventually you begin to relax, finally admitting to yourself that this really doesn’t feel half bad...\n\n");
			}
			// Taur variant
			else
			{
				outputText("Without warning, Izumi violently lunges forward, a hop in her step easily launching her high enough to land on top of your [race]-like body.  You’re only able to let out a surprised yelp before she grabs your arms, pulling them behind your back as a makeshift set of reins, a single powerful hand clasped around your wrists to keep them restrained.  The effect of being so utterly under the control of the Oni only amplified by the sensation of her muscular thighs clamped tightly around your flanks.\n\n");

				outputText("Izumi reaches around from behind you and you half turn to look at her, but she grips you by the chin with her free hand and firmly turns your head away from her.  Your gaze flits nervously around the cave at random as you feel Izumi’s feet run across your [skinfurscales], her toes squirming against your underbelly.\n\n");

				outputText("“<i>Well now, let’s see...”<i>  She murmurs, softly.  “<i>What can I possibly do with you, hmm?</i>”  She jerks your arms painfully forward, elbows locked straight thanks to her iron-hard grip around your wrists.  The motion prompts you to stumble a half step forward, edging you closer to the entrance of her cave.  “<i>You’re really pretty, you know that?</i>”  She purrs.  “<i>It’d be a shame to hide such a pretty thing away in a dark place like this, wouldn’t it?</i>”\n\n");

				outputText("Struggling helplessly against the enormous Oni’s manacle-like grip around your wrists, you gradually stagger over to the mouth of the cave under her direction, another jolt delivered to your arms whenever Izumi deems your progress too slow.  A gust of cold mountain air blows over you, chilling your [skinfurscales] and causing you to shiver as your nipples harden.  Izumi tugs backward on your ‘reins’ to stop your wobbling advance dead.  You gaze out at the scenery, the vast mountain range spread out below you, and for a moment you’re filled with an irrational fear that she intends to simply drive you off the cliffside and leave you to fend for yourself without your gear.  Then, without warning, Izumi kicks your legs out from under you, forcing you to collapse to the floor with a surprised shriek.\n\n");

				outputText("Izumi shifts herself around to casually lay along the length of your lower body, using  her grip on your wrists to jerk you backward once more, forcing you to arch your back and thrust your [fullchest] out for easier inspection.  You gasp in surprise as you feel her free hand reach around to grope at your breasts, squeezing and massaging them experimentally.  Despite yourself you can’t help but let out a yelp as she squeezes a [nipple] between thumb and forefinger.\n\n");

				outputText("As you squirm under Izumi’s body, it begins to dawn on you that you’re not getting away from this.  Your resistance begins to lessen until eventually you begin to relax, finally admitting to yourself that this really doesn’t feel half bad....\n\n");
			}

			outputText("“<i>Well, well. Look at that,</i>” She whispers into your ear conspiratorially. “<i>It seems you’re already drawing an audience.</i>”  It takes a moment, but her words finally filter through your lust-fogged consciousness, jerking back to reality.  Your eyes snap open in surprise, just in time to see a flicker of movement among the rocks nearby.  Then another, and another.  Imps, goblins, even one or two harpies slowly start to congregate around you, affording you brief glimpses at them as they take up vantage points in preparation for what is about to come.  Several of them are already clearly aroused, and your eyes widen at the sight of an imp’s wagging erection as he scampers between a pair of nearby boulders.  It slowly dawns on you that in a place as remote and empty as this, the sight of someone like you being toyed with - maybe even raped if the situation weren’t voluntary - is probably quite the rare spectacle.  And here Izumi is, displaying you like some kind of rare prize for every perverted beast on the mountain to gawk at.\n\n");

			// More exhibitionist shit (!)
			if (flags[kFLAGS.PC_FETISH] >= 1)
			{
				menu();
				addButton(0, "ShowMeOff", surrenderFemaleExhibitionVariant);
				addButton(1, "HideMe", surrenderFemaleNonExhibitionVariant);
			}
			else
			{
				menu();
				addButton(0, "Next", surrenderFemaleNonExhibitionVariant);
			}
		}

		// Female surrender, "regular" path
		protected function surrenderFemaleNonExhibitionVariant():void
		{
			clearOutput();

			outputText("You squirm desperately, the feeling of a dozen pairs of eyes leering at you making you feel decidedly uncomfortable.  Izumi apparently notices your distress, however, as a few seconds later you hear a thunderous crack as she reaches out to a nearby outcropping of jagged rock, snapping it off with one massive hand.\n\n");

			outputText("“<i>Get lost, ya scummy vultures!</i>” She yells,");
			if (player.isTaur()) outputText(" sitting upright on your back and");
			outputText(" hurling the rock forcefully at the circle of watchers. It shatters harmlessly on a boulder, but the crowd gets the message, disappearing in a flurry of angry squawks and howls. “<i>Sorry,</i>” Izumi adds apologetically as you twist your neck around to stare at her in confusion. “<i>Like I said, this neighbourhood’s full of trash like that, you know? I didn’t realize they’d upset you.</i>” She smiles - a friendly, honest smile, bereft of guile or malice.\n\n");

			outputText("Despite your uncomfortable situation, you can’t help but feel kind of... reassured.  The smile soon becomes something more than friendly though, and suddenly Izumi’s head darts forwards and she forces her tongue into your surprised");
			if (player.hasMuzzle()) outputText(" maw");
			else outputText(" mouth");
			outputText(", stunning you as she launches into a powerful french kiss.  Her tongue wraps effortlessly around your own, leaving you breathless and unable to help but wonder how dextrous it could be.  Izumi assaults your mouth, forcefully, leaving no doubt as to who is in control of the situation - it’s all you can do to keep up with the insistent, probing kiss.  Finally, she breaks off, leaving you gasping for breath after your extended tongue-grappling session.  For her part, Izumi seems to be none the worse for wear, wiping her mouth with a satisfied expression.\n\n");

			outputText("“<i>Now, where were we?</i>” Izumi murmurs.  You look down as she gently rolls a hand around to cup one of your breasts. “<i>Oh yeah,</i>” She adds, playfully. “I<i> remember...</i>” Izumi gropes at your chest experimentally, stroking, fondling, squeezing, molesting your bust as she gauges it for firmness.\n\n");

			// Itty-bitty-titties
			if (player.biggestTitSize() <= 2)
			{
				outputText("“<i>Haha... You’re pretty cute, you know?</i>” Izumi whispers into your ear, idly twiddling one of your nipples between thumb and forefinger as though this were a perfectly natural conversation. “<i>Funny, I was going to play with your breasts a little, get you nice and warmed up... but I can’t seem to find ‘em.  That’s not right, is it?  Girls have boobs, big, pillowy things to show off in front of the fellas... but you don’t.  Completely flat, aren’t ya? Almost like you were a boy.  That’s gotta be embarrassing, right?</i>”  You look down at your chest, blushing furiously.  You’d never really thought about it before, but now that Izumi mentions it....  Plus, with Izumi leaning in and gripping you from behind, those strong, muscled arms caging you in as her enormous breasts press inescapably against your spine, you have to admit you do feel kind of inadequate... as well as strangely aroused.\n\n");

				outputText("“<i>Well, it’s pretty sad, but don’t be too upset,</i>” Izumi continues, reaching around with her other hand to play with the other nipple.  She pointedly avoids so much as stroking against the unimpressive mounds that make up your sub-average titflesh, solely concerned with molesting your now diamond-hard nipples, heightening both your sense of arousal and your rising shame at your small size.  “<i>I’m sure someone, somewhere, will still want to take you.  Of course, they’ll probably be the kinky type.  Who else would want someone as flat as you?  There isn’t even enough here to rub up against.  But hey, some guys are into that.  You might have to pretend to be a schoolgirl for ‘em, but they’re into it...</i>”  Without warning, Izumi shifts up her game, pinching your [nipples] painfully and pulling on them slightly, forcing you to let out a moan of confusion; half pleasure, half pain.\n\n");

				outputText("“<i>Or is that what </i>you’re<i> into?</i>”  She hisses, suddenly intense.  “<i>Admit it, there’s no way anyone could really have breasts this small.  You did this on purpose, right?  Wanted to make yourself as flat and unappealing as possible, so only the </i>real<i> deviants would want you.  Is that it, is that what makes you tick?  You want to find some sick perv who can only get off by fucking someone as flat as you?! Someone with a body that looks more like it belongs to a little girl?!</i>”  She squeezes down on your long-suffering nipples, causing you to cry out again, then relents just a little.  “<i>Well?  Answer me.  Do you want to be the little girl?</i>”\n\n");

				outputText("You stammer some form of response, feeling hot, and trapped, and confused, and wanting to get out but also desperate to stay and find out what happens <i>next</i>.  Why <i>did</i> you do this to yourself, anyway?  <i>Did</i> you even do it, or was it done to you... or is this just how you’ve always been?  You’re so confused, the smoke drifting from the cave combining with the heat and the oppressive bear hug from Izumi to leave you feeling muggy and unfocused.  It must be having some kind of aphrodisiac effect on you, or something. Suddenly, Izumi chuckles, gentle and soft, mere inches from your ear.\n\n");

				outputText("“<i>It’s fine.  Relax, kitten; I don’t care what kind of crazy kinks you think you need to get yourself off,</i>” She murmurs, reassuringly. Then you feel her hand take gentle hold of your wrist. “<i>But I </i>do<i> want to see it happen...</i>” She adds");
				if (!player.isTaur()) outputText(", guiding your hand down to your own nethers, which you’re shocked - in a foggy, distant kind of way - to discover are sopping wet");
				outputText(".\n\n");

				outputText("“<i>You’re not leaving ‘til I see your O-face,</i>” She purrs, her tongue slipping out to give your neck and cheek a long, lascivious lick, making you shudder as the hot, wet sensation glides over your [skinfurscales]. “<i>So unless you want to accidentally train yourself into having a fetish for all this pretend-schoolgirl stuff, I’d get busy... or don’t,</i>” She pushes her face into your neck, leaving a line of kisses up to your ear as the smoke-scent of her hair fills your nose. “<i>Your call. Personally, I think you’d look pretty cute in a uniform.</i>”\n\n");

				outputText("You groan in equal parts arousal and terror at the idea, then silently acquiesce to Izumi’s demands, slowly beginning to masturbate, still cradled in her arms as she watches with interest from over your shoulder.  Occasionally, Izumi will offer advice on technique or ask if you really do it ‘like that’, leaving you half wishing she’d shut up and half wishing she’d show you how it’s done.\n\n");

				outputText("Given your already addled and aroused state, it isn’t long before you feel your orgasm building. Izumi seems to feel it too, as she grips your masturbating wrist forcefully, holding it in position, while her other hand turns your head to face her.  “<i>Keep doing it, exactly like that. Fast and hard. Don’t dare look away.</i>” She commands, and you’re far too far gone to disobey.  \n\n");

				outputText("Finally, your wave crests, and you let out a strangled scream of pleasure as you cum, bucking and jerking in Izumi’s arms.  Through your entire orgasm, she holds your head in place and regards you carefully with a quiet, satisfied leer. Finally you collapse, panting, against the oni woman’s bulk, shivering and exhausted. \n\n");

				outputText("“<i>Good girl,</i>” Izumi says, kindly, giving you a gentle kiss on the forehead as you rest your fatigued body against her bust. She reaches down between your legs and gives your still-throbbing pussy a couple of wet, slapping pats, as though congratulating it on a job well done... The impacts unfortunately causing you to yelp and tense up again as another mini-orgasm rolls through you. “<i>Hah!  Sorry.  Didn’t think you would still be that sensitive. But, you did good, "+ this.heightDesc() +".</i>” She releases you, finally, and you slide to the floor, struggling to stand as Izumi hands you your clothes.\n\n");

				outputText("“<i>Come back any time, sweet-stuff,</i>” She says, blowing you a kiss as she wanders back to her pipe. “<i>Always got time for cute little morsels like you.</i>” You nod, absently, as you stagger from the cave and make your way back to camp.\n\n");

				outputText("A schoolgirl outfit would be a pretty kinky thing to own, you have to admit...\n\n");
			}
			// C-Cup+
			else
			{
				outputText("“<i>Hrm.. Not bad, I guess. Not bad at all,</i>”  Izumi grunts, somewhat appreciatively, as she manhandles your rack with skilled, articulate fingers. “<i>Yeah, I’d say you’re just about the right size here.</i>”  Her hands glide over your ample bust, examining it in detail, the soft sensation of her palms gliding over your bare skin, coaxing your nipples to hardness, gently squeezing or massaging the flesh, all of it feeling decidedly good.\n\n");

				outputText("Satisfied with her inspection, one giant hand slides");
				if (player.isNaga()) outputText(" over your [hip].");
				else if( player.isDrider()) outputText(" between your spindly legs, slapping them lightly to force you to spread them wider.");
				else outputText(" between your thighs, slapping them lightly to force you to open them wider.");
				outputText("  The pressure of her breasts pushing into your back increases as she draws you into a one armed hug, resting her chin on your shoulder and nuzzling her face into your neck.  “<i>Let’s play!</i>”  She announces in a cheery, sing-song voice.  Then her tongue snakes out, feeling inhumanly long as it slides across your flesh from the base of your neck to your cheek.  “<i>Well, I say ‘let’s’... don’t worry, kitten. I’m just gonna mess your head up for a little while, that’s all.  I’ll try not to make you swear off men for good, though...</i>”  She chuckles breathily into your ear as her questing hand snakes");
				if (player.isNaga()) outputText(" along");
				else outputText(" between");
				outputText(" your [legs] to trail ever-so-softly over your nethers, a feather-light touch clearly designed to leave you wanting more.\n\n");

				outputText("Perhaps the worst - or possibly the best - part is that it’s working.  The soft, whispery sensation of Izumi’s fingers dancing <i>just</i> close enough for you to feel them but never actually close enough to make full contact is beginning to work its frustrating magic on you, leaving you feeling increasingly hot and needy.  Your discomfort is clearly obvious to Izumi, judging by the obscene leer on her face.\n\n");

				outputText("“<i>Aw, whassamatter?</i>”  She purrs, “<i>You want me to quit playing around? Haha, geez, you’re such a dyke!</i>”  Izumi laughs again, pressing her cheek affectionately against your neck as she peers down at your dampening crotch.  “<i>Alright, alright,</i>”  She smirks, giving one of your breasts a quick, chastising squeeze.  “<i>I’m gonna start with the real thing now, okay?</i>”  You feel one oversized finger suddenly slide between your lips as Izumi prepares to slip it inside you.  You nod your head, eagerly, feeling glad of the chance for some real stimulation as opposed to the mean-spirited teasing of earlier.\n\n");

				outputText("Izumi’s finger is naturally much larger than your own, so thick that it feels almost like an actual cock, rather than just a probing digit... but the way it flexes and bends within you, slowly worming its way in deeper to gently probe at your most sensitive spots, is distinctly different.");

				if (player.looseness() <= VaginaClass.LOOSENESS_NORMAL) outputText("  She takes it slowly, pushing into you with agonizing care so as not to cause you any distress.  Inch by inch, centimeter by centimeter, she slides her finger into your pussy, finally bottoming out down to the knuckle.  You let out a little gasp of surprise and alarm as she gives her finger a sudden quick, tickling twitch, as though tickling a pet under its chin, then grins savagely at your reaction.\n\n");
				else if (player.looseness() >= VaginaClass.LOOSENESS_GAPING) outputText("  Izumi’s finger slips between your cavernous walls with ease, quickly bottoming out inside you.  She lets out an amused grunt of surprise at the ease with which she’s able to fit her finger inside you.\n\n");

				outputText("“<i>I guess someone’s been busy, huh? And here was me thinking you were a nice girl.</i>”  Izumi teases.  “<i>Well, I guess we can skip the foreplay then....</i>”\n\n");

				outputText("One hand now actively engaged in exploring your nethers, Izumi begins to grope your [chest] in earnest, nibbling on your neck as she grips a nipple between thumb and forefinger and squeezes, almost painfully tweaking and pulling at the sensitive flesh.  She pulls gently but insistently at your [nipple] in a rhythmic motion.  “Haha, say... you ever been milked, "+ this.heightDesc() +"?”  She murmurs, ominously. \n\n");

				if (player.lactationQ() > 0) outputText("You let out a moan of pleasure as a sudden jet of milk spurts from your heavy breasts, splattering across the rocky ground.  Izumi doesn’t let up though, instead working your nipple even harder, almost feverishly pinching and squeezing away, forcing more and more of the warm liquid to be coaxed free of your bust.\n\n");

				if ((player.hasStatusEffect(StatusEffects.BreastsMilked)) && (player.lactationQ() > 750))
				{
					outputText("You instinctively relax and lean back into the cushioned softness of Izumi’s breasts as the familiar sensation of being milked washes over you.  Your breasts respond readily to the repeated stimulation, great jets of milk answering the insistent urging of Izumi’s fingers.  Her other hand detaches itself from your groin temporarily to begin cupping and squeezing at your bust as well, much to your enjoyment.  You lay there in her arms, gazing down at your [chest] as you are being milked, and you can’t help but think to yourself");

					if (player.cor < 40) outputText(" ‘How did this happen?‘  How did you get into this bizarre state, this weird situation?  It seems so strange, and yet, you can’t seem to summon up the energy to object or resist at all.  Perhaps, you wonder briefly, it has something to do with that damned smoke.  Izumi <i>was</i> smoking something, after all, and if it’s strong enough to affect a person as huge as her....\n\n");
					else if (player.cor >= 40 && player.cor <= 90) outputText(" how surprisingly pleasant this is.  Izumi’s treatment of your nipples is getting a little rough, but you can’t deny that it does feel good to be milked so intimately, your breasts being emptied, spurt by spurt.  You smile, dully, and resolve to just enjoy the sensation while you can.  After all, it isn’t like enjoying yourself once in a while is going to lead to anything bad.\n\n");
					else outputText(" how good it feels to be milked again.  How <i>hot</i> it feels, having someone work over your body like this, manipulating your swollen teats until they give up their cargo of your precious milk.  Izumi’s hands are rough and methodical, squeezing out an dribbling arc from one breast, then the other; left, right, left, right, left, right, an endless, mechanical rhythm, by this point completely bereft of sensuality.\n\n");
				}

				outputText("But that just adds to your arousal.  There’s something about the situation that you just can’t help but find strangely thrilling.  You’re actually quite enjoying the sensation of being milked; it feels somehow... Right. You feel docile.  Placid.  Satisfied with your place in the world, as though you really were just some dumb animal, being harvested for her milk - like a cow.\n\n");

				outputText("The thought sticks in your brain, and you find it quite an enjoyable little fantasy; the idea of being reduced to something so basic, so animalistic, is kind of a turn-on.  Even the movement of Izumi’s hands, first one teat, then the other, seems reminiscent of the act of milking a cow.  No, not teat, you correct yourself with a giggle - <i>udder.</i> Cows have <i>udders,</i> don’t they?\n\n");

				outputText("Enraptured by the concept, you submerge yourself in fantasy as Izumi drains your fat, eager udders.  Your eyes roll back into your head as you daydream of rough hands, methodical inspections of your swollen breast-udders, and finally the chilling thrill of being guided towards the cold embrace of those steely, sucking tubes for another day’s ‘work’.  You’re not entirely sure through your lust-addled haze, but you think you might even have heard yourself murmur out a little ‘moo’ once or twice...\n\n");

				outputText("Finally, you realize - with a slight note of disappointment - that Izumi has finished, her hand snaking back down");
				if (player.isNaga()) outputText(" to");
				else outputText(" between");
				outputText(" your [legs] as she returns her attention to your groin.\n\n");

				outputText("Despite her earlier protestations of inexperience when it comes to women, Izumi certainly seems to know what she’s doing.  It isn’t long before you’re squirming in her grip, panting helplessly as you instinctively roll your hips in response to Izumi’s skillful fingers, all the while flicking her thumb across your by now hypersensitive [clit].  Her tongue slides lasciviously across your neck, feeling impossibly long and causing you to gasp and shiver as you wonder just what other uses she might find for it before too long...\n\n");

				outputText("You open your mouth to gasp for air, Izumi’s head darts forwards and she locks her lips to yours, pulling you into a sudden french kiss.  Her tongue wraps around your own, bizarrely flexible as it invades your mouth, forcing you to surrender to her embrace.  She runs her hands over your body and you can only moan feebly into her mouth as your orgasm begins to rise within you, suffusing your entire being as you flex and strain inside Izumi’s iron grip.  You squirm and buck your hips desperately and Izumi pins you down, riding out your orgasm as she strums away at your desperate nethers, your juices splattering wetly across the cave floor.\n\n");

				outputText("Izumi releases you, a trail of saliva hanging between your exhausted mouths for a moment before she gives you an indulgent pat on the behind and rises to her feet, licking suggestively at her fingers.  You shakily pull your clothes towards you and redress, while Izumi settles back down to take a long drag from her pipe, eyeing you with clear amusement as you attempt to cover yourself.  You decide to make your escape before the big woman decides to rope you into another, more strenuous round of sexual wrestling...\n\n");
			}

			player.sexReward("Default","Default",true,false);

			menu();
			doNext(camp.returnToCampUseOneHour);
		}

		// Female surrender, ask player if which variant they want
		protected function surrenderFemaleExhibitionVariant():void
		{
			clearOutput();

			outputText("For some reason, you find that idea to be quite possibly the hottest thought you’ve ever had.  You’re surrounded by a ring of barely-unseen onlookers, all waiting to see you get fucked, many of them already masturbating just at the sight of your naked form.  Without a moment’s hesitation");
			if (player.isBiped()) outputText(", you spread your legs a little wider,");
			outputText(" you");
			outputText(" arch your back a little further, muscles straining as you struggle to present a better view to your audience.  You moan with greater enthusiasm, hoping to draw in a larger crowd.  You feel Izumi’s breasts shake, pressed up against your back, as she chuckles to herself.\n\n");

			outputText("“<i>Get off on being watched, huh?  That’s kinda slutty, you know?  Well, I don’t mind playing you in front of a crowd,</i>” She purrs into your ear.  “<i>But if you’re <b>that</b> kind of kinky, maybe you wanna try a little... Audience participation?</i>”\n\n");

			menu();
			addButton(0, "Yes", surrenderFemaleLookitYouTheCenterOfAttentionYouSlut);
			addButton(1, "No", surrenderFemaleNonExhibitionVariant); // Take the non-exhibitionist path
		}

		// Female surrender, Exhibitionist variant scene body
		protected function surrenderFemaleLookitYouTheCenterOfAttentionYouSlut():void
		{
			outputText("You nod your head vigorously at the idea of getting some of your beloved audience actually involved.  Izumi chuckles again.\n\n");

			outputText("“<i>Alright. Let’s get this party started, then.</i>”  Izumi releases you and stands.  You start to follow, thankful of the opportunity to stretch out your strained muscles, but Izumi places a hand firmly on your head and pushes you back down.  “<i>Oh no,</i>” she says, smiling at you. “<i>No, you just sit right back down. You’re going to be staying on your knees for a while, "+ this.heightDesc() +".</i>”  Her words send a chill of excitement rushing through you, so you obediently adopt a kneeling position, waiting patiently.  Izumi’s smirk only grows wider as she pats you on the head.  Then she turns towards the assembled crowd of lurking masturbators.\n\n");

			outputText("“<i>Hey out there!  Turns out my friend here is just too big a slut to resist the smell of some juicy cock, and you got her all riled up.  So, with that in mind,</i>” She announces, loudly.  “<i>She’s up for public use.  Who’s first?</i>”\n\n");

			outputText("There’s a moment of deathly silence that seems to stretch for minutes.  Then, suddenly, an imp comes hurtling out of cover, already reaching for his loincloth, casting a wary glance at Izumi.  She gives him a winning smile, like a shopkeeper welcoming a client.  You realize that would make you the merchandise in this situation, and for some reason it just turns you on even more.\n\n");

			outputText("“<i>Lucky number one!</i>”  Izumi extends a hand towards you in an expansive gesture.  “<i>She’s all yours.  Pick any hole, she’s too cockhungry to care.</i>”  The imp eyes you up for a moment, then steps onto your");
			if (player.isBiped()) outputText(" thighs");
			else outputText(" [legs]");
			outputText(", pulling aside his loincloth to reveal his raging erection.  It bobs up and down, the bulbous head mere inches from your face.  “<i>Well?</i>”  Izumi asks.  “<i>What are you waiting for?  Get started, slut!</i>”\n\n");

			outputText("Hesitantly, you lean forwards and envelop the imp’s waiting cock into your mouth.  You struggle not to think about the taste as you submissively service the imp, but then you notice from the corner of your eye that the ring of observers have crept a little closer, leaving the safety of their rocky hiding spots to get a better view...  a better view of you.  A better view of you, naked");
			if(player.isBiped()) outputText(" and on your knees");
			outputText(", sucking on an imp’s cock like it was candy.  Suddenly, it doesn’t seem nearly so bad.\n\n");

			outputText("“<i>You wanted to give them a show, right?</i>”  Izumi whispers to you, still grinning.  You nod your head as best you can around the stiff phallus invading your mouth.  “<i>Well then, in that case...  do it right, you stupid slut!</i>”  She roars suddenly, grabbing you by the back of the neck and forcing your face down onto the imp’s cock.  You gag and squeak in surprise as you find your nose suddenly pressed up against his stomach, his thick meat invading your throat, cutting off your air.\n\n");

			outputText("“<i>This crowd came here to see a whore getting fucked, not to see some amateur try her best.  If you aren’t gonna try, I’ll do it for you.</i>”  Izumi’s expression is almost feral with lust as she forces you into a brutal");
			if (player.hasMuzzle()) outputText(" muzzle");
			else outputText(" face");
			outputText("-fuck, tears of exertion streaming down your face.  “<i>Tongue his balls, then you get to come up for air,</i>” she commands, and you comply.  A few seconds later, you’re rewarded with the distinct hot, gloopy sensation of the imp blowing his load into your throat - and, much to your lust-addled surprise, a quick shoulder-squeeze from Izumi.  “<i>Sorry if I’m being a little rough, "+ this.heightDesc() +". Just playing the part, you know?</i>”  She whispers, reassuringly.\n\n");

			outputText("The imp pulls himself free of your mouth, staggering away to the safety of the rocks.  More importantly however, you realize that the ring of spectators has begun to close in, apparently satisfied that they’re no longer confined to just spectating.\n\n");

			outputText("“<i>Hope you’re ready for round two.</i>” Izumi mutters.  You can’t help but nod, smiling hungrily as you eye the approaching crowd.\n\n");

			outputText("An hour later, after having licked, sucked, deepthroated and fucked your way through an endless parade of harpies, goblins and imps, the crowd finally disperses.  Of course by that point, you’re barely aware of it, having lost track of pretty much everything aside from the ‘client’ currently employing your services some time ago in a haze of wanton sluttery.  Izumi swims blearily into focus, shaking her head in amusement.\n\n");

			outputText("“<i>Well, that was certainly quite the performance,</i>” she says, archly. “<i>I kinda wish I’d just kept you to myself now.</i>”  She tuts, then shakes her head again.  “<i>Geez, you’re in no condition to be walking around alone.  I’d feel pretty bad if I let you wander off like this and let something happen to you, so I guess...</i>”  She reaches down and grips you by the wrist, pulling you to your feet and wrapping an arm around your waist to support you. “I’ll<i> have to take you home.</i>”\n\n");

			outputText("You’re in no position to resist as Izumi casually marches off into the cave, dragging you along.  The best you can do is stumble along next to her, even a journey as short as heading back into the gloomy cave difficult after such an extensive public performance.  She bundles you inside of her tent tenderly, and you quickly surrender to exhaustion...\n\n");

			outputText("You jerk upright with a start, warm bedding falling away from your body, the last few hours slowly beginning to filter through the sleepy haze clouding your thoughts.  Izumi seems to have worn herself out too, splayed out across the floor beside you.  You look around, gathering your bearings before deciding a sneaky exit from the Oni’s home is your best course of action...\n\n");

			player.sexReward("Default","Default",true,false);

			menu();
			doNext(camp.returnToCampUseOneHour);
		}

		/**
		 * LOSS SCENES
		 */
		public function fuckedUpByAFuckhugeOni(titLoss:Boolean = false):void
		{
			flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 1;
			flags[kFLAGS.IZUMI_SEEN_PC_GENDER] = player.gender;
			
			clearOutput();

			if (player.HP <= 0)
			{
				outputText("You fall to the ground, reeling from Izumi’s iron-hard muscles - and other parts besides.  Grinning widely, Izumi visibly relaxes, satisfied that you’re in no fit state to continue fighting.\n\n");
			}
			else if (player.lust >= player.maxLust())
			{
				outputText("You fall to the ground, too horny to resist further against the Oni’s iron-hard muscles - and other parts beside.  Grinning widely, Izumi visibly relaxes, satisfied that you’re in no fit state to continue fighting.\n\n");
			}
			
			outputText("“<i>So, it’s my win!</i>”  She announces, gleefully.  “<i>And you know what that means, right? It’s </i>playtime....”  The enormous woman looms over you, and you suddenly find yourself feeling distinctly nervous...  without warning, Izumi drops to her hands and knees and leans forwards, her leering face inches from your own.  With her arms on either side of you and her face filling your vision, you can’t help but feel a little enclosed. “<i>Let’s have sex!</i>”  She cries, then looks down towards your crotch, raising a hand threateningly.\n\n");

			outputText("Reflexively, you");
			if (player.isNaga()) outputText(" slither");
			else if (player.isDrider()) outputText(" scuttle");
			else outputText(" scurry");
			outputText(" backwards, self-preservation instincts kicking in, intent on escaping the deranged Oni.  To your surprise, rather than snatching or leaping at you, she just blinks and looks at you in confusion.\n\n");

			outputText("“<i>Huh?  What’s the matter?</i>”  She asks, looking genuinely nonplussed.  She reaches out towards you and you shuffle away again, putting a little more distance between the two of you.");
			if(player.lust >= player.maxLust()) outputText("  Despite how much the fight with the enormous Oni has turned you on, you’re still hesitant to capitulate to her will entirely.");
			outputText("  Izumi actually looks a little hurt.  “<i>You... you really don’t want to do it?</i>”  You can only stare at the oversized giantess in utter confusion as she stammers awkwardly.  “<i>D-Did I do something wrong? I was only playing around, so... we can do it now, right?  What’s wrong?!</i>”  Against all your expectations, Izumi actually backs down, settling back into a seated position on her knees, her expression visibly deflating.\n\n");

			outputText("“<i>Oh, I get it.  It’s me, right?  You don’t find a girl like me attractive.</i>”  Her face falls as she stares at the floor, looking positively morose.  “<i>It’s okay, I don’t blame you.  This whole situation probably seems pretty weird, right?  One minute I’m smacking you around, the next I’m trying to jump you... I forget sometimes that not everyone acts the way Oni do when it comes to stuff like this.</i>”  She sniffs, rubbing one massive palm into her eye and scowling.\n\n");

			outputText("“<i>Ah, stupid.  Don’t mind me, really. You can leave if you want, it’s okay; I won’t chase you or anythin’.  I just got over excited since I don’t get to talk to people very often, but I can’t expect you to want to bang someone who just tried to clean the floor with ya.</i>”  Izumi raises her head and gives you a wavering smile.  “<i>Really.  It’s fine! Oni get a little <b>heated</b> after a good fight, you know?  So, I did a dumb thing and figured you were feelin’ the same.  I shoulda known that ‘no’ doesn’t mean ‘only if you beat me’ to a human, right?!  Ahaha, ah... I’m an idiot.</i>”  She droops her head again.\n\n");

			outputText("You hesitate.  It seems like she’s being honest about letting you go, which is unexpected to say the least.  If you wanted to, you’re pretty sure you could just get up and");
			if(player.isNaga()) outputText(" slither");
			else outputText(" walk");
			outputText(" out of the cave without any trouble.  On the other hand...");
			if (player.lust >= 75) outputText(" the idea of sex with Izumi <i>is</i> quite a tantalizing prospect.  F");
			else outputText(" f");
			outputText("rom your position, you can clearly make out how tightly her kimono clings to her substantial assets, how only a thin scrap of material dangling between those powerful thighs - not even reaching low enough to touch the floor - obscures your vision and prevents you from seeing <i>everything</i>.");
			if (player.lust >= 75) outputText("  Despite yourself, you have to wonder exactly what it would feel like to slide between those giant sweat-slicked thighs, bury your face into Izumi’s mountainous bust, and just let your libido run wild.");
			outputText("\n\n");

			menu();

			if (player.hasCock())
			{
				addButton(0, "Anal", cowedIntoPuttingItInIntoHerGiantOniButt);
				addButton(1, "Vaginal", fuckhugeOniWantsYourBabiesOrSomeShit);
			}

			if (player.hasVagina() && !player.hasCock())
			{
				addButton(2, "69", littleChampLittleChampFuckhugeOniIsCominTaEatcha);
			}

			if (!player.hasCock() && !player.hasVagina())
			{
				addButton(0, "Next", noDickNoVagNoService);
			}

			if (player.hasVagina() || player.hasCock())
			{
				addButton(14, "Leave", lossSceneLeave);
			}
			if (flags[kFLAGS.SFW_MODE] > 0) {
				outputText("<b>SFW mode is enabled.</b>");
				menu();
				doNext(lossSceneLeave);
			}
			
		}

		// Nah, fuck this crazy bitch
		protected function lossSceneLeave():void
		{
			clearOutput();

			outputText("You rise and make your excuses, and to her credit Izumi takes your refusal in stride; already seeming to have cheered up a little after her earlier outburst.  As you exit the cave, she raises a hand in farewell.\n\n");

			outputText("“<i>Feel free to come back if you want me to clean your clock again, yeah?</i>”  She calls after you with a grin.  You shake your head ruefully as you make your way down the mountain and back to your camp.  Overall, that could have gone better, but it could have gone a lot worse, too.\n\n");

			menu();
			cleanupAfterCombat();
		}

		// Call this shit at the top of any "Stay" scene for shared initial content
		protected function lossSceneStay():void
		{
			clearOutput();

			outputText("Your mind made up, you lean forwards, reach out your hands and firmly grasp one of Izumi’s sizeable breasts.\n\n");

			outputText("“<i>Oh!</i>”  Izumi yelps, surprised, her head snapping up as you grope at her soft flesh.  “<i>Oh.  </i>Oh...<i></i>”  She repeats as comprehension slowly dawns.  “<i>So, wait, you decided you actually </i>do<i> want to...</i>”  She trails off as you nod, and a sly smile begins to spread across her face.  “<i>I guess there’s a little Oni in you after all, huh?</i>”  She says, leaning in closer to you to draw you into a hug - which you use as an opportunity to enjoy the better access to her breasts.\n\n");

			if (player.hasCock()) outputText("“<i>Or maybe,</i>”  She whispers seductively into your ear, “<i>You wanna bury that little Oni of yours in </i>me<i>.  Hmmmm?</i>”  You shudder as you feel her hand snake into your underwear and run sinuously across your crotch, readying you for the ordeal ahead...\n\n");
		}

		// Special loss scene if the player loses whilst being titsmothered by izumi
		public function deathBySnuSnuIMeanGiantOniTits():void
		{
			flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 1;
			
			if (player.isTaur() || player.isDrider() || !player.hasCock())
			{
				this.fuckedUpByAFuckhugeOni(true);
				return;
			}

			clearOutput();

			outputText("Try as you might, you find that you just can’t break free of Izumi’s grasp.  Not only that, but the constant rubbing, flexing sensation stimulating [eachCock], combined with the heat of Izumi’s body and the scent of whatever heady drug she was smoking hanging around her like a perfume, you give one final shudder and give in, going limp against the massive woman’s rack.\n\n");

			outputText("Slowly, you start to pull back your hips, gently dragging your [cocks] back across Izumi’s stomach.  You realize foggily that underneath her kimono, she must be fairly well-toned, as the muscles in her abdomen provide a pleasingly firm and bumpy surface for you to rub yourself across.  Anxious to satisfy the needy throbbing in your cock, you slowly start to thrust, rolling your hips backwards and forwards as you grind yourself into Izumi’s abs.\n\n");

			outputText("The sensation is oddly unique, hard yet yielding, and you find yourself quickly entranced by the pleasure, falling into a steady rhythm, burying your face into Izumi’s bust and wrapping your arms around her for support.  Still fully clothed, you begin to grind yourself against Izumi, mindlessly searching for release.\n\n");

			outputText("“<i>Hey, what are you...</i>”  Izumi’s confused murmur drags you back to reality.  Groggily, you raise your head to find her looking down at you with a concerned expression.  One look at your panting, reddened face however, and her face quickly splits into a familiar smirk.  “<i>Oh.  Oh, I see.</i>”  She murmurs. The arm inexpertly pulling you towards her slackens, giving you a little more room to breathe. Meanwhile, her other hand appears from behind her back as she drums her fingers on her cheek, smiling indulgently down at you as though confronted with an errant child.  “<i>You’re kind of a strange one, you know that?  Well, if that’s what you want, I suppose it can’t be helped....  Go ahead kid, I won’t stop you.</i>”  The arm that was previously attempting to choke you slips down to grip your waist, supporting you and hugging you closer to her, causing you to shiver as your erection is pressed ever harder into her flesh.\n\n");

			outputText("Gratefully, you nod, too aroused to care about Izumi’s dismissive attitude.  Right now, all you care about is how close this weird new form of stimulation is to helping you get off, and she’s just given you the green light to explore that feeling.  Returning your attention to Izumi’s breasts, you take advantage of the increased support from the arm around your waist to slip your arms inside the upper portion of Izumi’s kimono, running your hands across the expansive breasts within.  Izumi rumbles appreciatively as your hands stumble over her nipples, stroking the hardening flesh, tweaking and gently twisting them until they are hard enough to stand out against the silken fabric of her clothing. Finally, you can’t stand it anymore.  With a powerful gesture, you push both sides of Izumi’s kimono aside at once, exposing her breasts completely and causing them to bounce and jiggle with the force of the motion.\n\n");

			outputText("“<i>Ah!</i>”  Izumi yelps. “<i>Greedy!</i>”  She chides, grinning down at you as you simultaneously grope both of her breasts.  You couldn’t care less though, you’re so enflamed by lust at this point that all you can think about is enjoying yourself as much as possible; bringing one of Izumi’s nipples to your mouth, you latch onto her breast and suck powerfully, eliciting a hiss of pleasure from Izumi.  Judging by how Izumi’s breasts begin to heave and shiver under you as her breathing quickens, she seems to be enjoying this almost as much as you are.  Sure enough, after only a few moments, Izumi’s hand snakes down to stroke through your hair, gently but insistently holding you over her breast to continue your oral assault.\n\n");

			if (player.tallness <= 60)
			{
				outputText("At the same time, the arm gripping your waist slides downwards too, hooking under your [butt] almost like some kind of seat, freeing you to keep grinding your needy cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" into her midsection while you suck at her teat.");
				if (player.biggestCockLength() <= 5)
				{
					outputText("  “<i>Hmph.</i>” Izumi grunts, smirking as she cups your balls.  “<i>Just like a baby... in more ways than one, am I right?</i>”  She continues, extending her middle finger to stroke the entirety of the underside of");
					if(player.cockTotal() > 1) outputText(" one of your");
					else outputText(" your");
					outputText(" trembling, undersized prick");
					if(player.cockTotal() > 1) outputText("s");
					outputText(", from tip to base, as your hips roll into your backstroke.  You shiver in embarrassment, causing Izumi to snort with amusement.\n\n");
				}
			}

			outputText("The thought of Izumi getting turned on too just makes your lust burn even hotter and you renew your efforts, grinding and humping into Izumi’s stomach, running your tongue over the soft skin of her breasts as she strokes your hair indulgently.  The climbing heat of your bodies conspires to melt your thoughts away, your poor dick");
			if(player.cockTotal() > 1) outputText("s");
			outputText(" trapped in the hottest point of all - directly between you.  Assaulted on all sides by the rising heat and the increasingly slippery sensation of rubbing against Izumi’s sweat-soaked body, your cock feels as though it has been transformed into a supernova of arousal, burning with desire and incredibly sensitive.\n\n");

			outputText("The two of you remain there in this strange half-standing, half-fucking position for what feels like the best part of an hour as you grind and groan, suckle and slurp.  If just rubbing away at her from the outside feels this good, how much better must it feel to actually feel [oneCock] inside her, part of you wonders... and then another quieter, darker part of you wonders if it wouldn’t be so much hotter if you never found out.\n\n");

			outputText("Finally, you start to feel an ominous pressure building up in your groin, your breathing growing laboured and desperate.  Izumi clearly notices your animalistic intent, as she looks down at you and speaks, massaging the back of your neck vigorously as you suck forcefully at her breast.\n\n");

			outputText("“<i>Hey, you’re getting close, right?</i>”  She asks. You nod vigorously, but she continues anyway. “<i>You’re gonna do it, right?  You’re gonna cum, just from this, just from rubbing up against me.</i>” You nod even more desperately, feeling your orgasm already starting to rise up inside you.  Izumi actually pants, looking almost as aroused as you feel.  “<i>That’s okay... that’s good.  Go ahead and cum, okay?  I want to see if you can really blow your load just from a little frottage...</i>” Frottage.  You make a mental note to remember that word.  If that’s the name for this, it might be worth knowing, you think.  Then, at long last, your orgasm hits.\n\n");

			outputText("You positively explode, throwing open your mouth and howling in ecstasy as your long-awaited orgasm bursts out of you.  You feel a jet of hot, warm goo pulse free from");
			if (player.cockTotal() > 1) outputText(" each of");
			outputText(" your iron-hard cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText("... only to splatter instantly against the insides of your [armor].  Your eyes go wide as you realize in a rush of embarrassment that you forgot to even so much as slip your cock");
			if(player.cockTotal() > 1) outputText("s");
			outputText(" free before humping yourself to a climax against Izumi’s stomach.  The realisation does nothing to hinder your orgasm, however - and may even have heightened it - as surge after surge of baby batter explodes free from your erection");
			if(player.cockTotal() > 1) outputText("s");
			outputText(", coating the insides of your underwear with thick, sticky goo.\n\n");

			outputText("Your underwear thoroughly decorated, your cock");
			if (player.cockTotal() > 1) outputText("s relent");
			else outputText(" relents");
			outputText(", deflating and ceasing");
			if (player.cockTotal() > 1) outputText(" their");
			else outputText(" it’s");
			outputText(" relentless demands.  Puffing and panting, you manage to raise your head enough to look up at Izumi, still wearing that everpresent smirk.\n\n");

			outputText("“<i>Aw, what’s the matter?</i>”  She says, reaching down and gripping at your aching bulge.  You groan at the sensation of your own slime being used as lubricant to wring a couple more drops from your aching body.  “<i>Couldn’t even wait to get your clothes off?</i>” She laughs, but there’s no malice there.  Izumi lowers you gently back down until you’re standing on the floor once again, on somewhat unsteady legs.  \n\n");

			outputText("“<i>Well, I gotta admit, that wasn’t exactly how I was expecting the fight to end,</i>” she says, scratching the back of her neck in a manner that seems almost coquettish. “<i>But it was pretty fun all the same. Next time you’re in the neighborhood, let me know if you’re up for a rematch, or... whatever.  Okay?</i>” She asks, retaking her seat by the fire and retrieving her pipe.  You nod, absently, still kind of dazed after the abortive end to the fight, and wander off to find somewhere to wash the increasingly unpleasant feeling contents of your underclothing away.\n\n");

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}

		// Loss scene for buttstuffins
		protected function cowedIntoPuttingItInIntoHerGiantOniButt():void
		{
			lossSceneStay();

			outputText("“<i>Hey,</i>”  Izumi whispers, fingers rolling tantalizingly over [eachCock].  “<i>Let’s try something dirty...</i>”\n\n");

			outputText("She pushes you gently onto your back, pulling your clothes aside and freeing your erection");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" to the air.  Her grin widens as she stands, removing her clothing - such as it is - and hurling it across the cave.  She stands there for a moment, hands on her hips, eyeing up your");
			if (player.cockTotal() > 1) outputText(" [multicock]");
			else outputText(" [cock biggest]");
			outputText(" with a hungry smile.  In turn, you take the opportunity to survey Izumi’s naked body in detail.  The light from the smouldering campfire licks hungrily across her skin, illuminating her skin in warm, flickering gold as you size her up. Her muscles are well toned but not obtrusively so, her frame still distinctly feminine.  She stands there completely unabashed, displaying every inch of herself to you, and you feel your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" twitch in response to the sight.");
			if (player.cockTotal() > 1) outputText("  They");
			else outputText("  It");
			outputText(" must have been visible to Izumi, too, since she laughs and speaks up a moment later.\n\n");

			outputText("“<i>Alright, I see you’re ready.  Let’s get this thing started, shall we?</i>”  She chuckles, squatting down tantalizingly over your [cock biggest].  To your surprise, however, she spins around in place, turning her back to you while maintaining her position.  It isn’t until her hand reaches back to grab at your erection and begins guiding it towards her plowable rear that you realize what she’s doing.  She catches your eye and pauses, her face colouring slightly.\n\n");

			outputText("“<i>What?</i>” she asks, sounding a little embarrassed.  “<i>Girls are allowed to like stuff like this too, you know..</i>”  You can’t help but smile at her insecurity as you reach forwards and grip her hips, pulling her backwards onto your erection.  She gasps and her eyes widen slightly in surprise as your [cockhead biggest] slips inside her, but then her distinctive grin returns.  “<i>Oh, so it’s like that, is it? Well, let’s see how ya like this!</i>”\n\n");

			outputText("Without another word, Izumi drops her hips, forcing the entirety of your length into her asshole right down to the base.  She grunts appreciatively as your cock sinks deeply into her rear, grinding her hips into yours experimentally, twisting and turning, scraping your cock across as much of her insides as possible.\n\n");

			outputText("“<i>Haha, yeah...</i>” She murmurs, seemingly more to herself than anything else. She shifts her hips a little, trying to find a comfortable position to accommodate your length inside her. “<i>That’s the stuff, alright... okay!</i>” Izumi glances back at you, her faced flushed with a mixture of embarrassment and arousal, but still grinning almost ferally.  “<i>Well? What are you waiting for?! I’m not gonna do all the work myself here, you know?</i>”\n\n");

			outputText("Your only response is to forcefully roll your hips upward, raising Izumi several inches from her seated position as you spear into her behind.  “<i>Woah!</i>” You can’t help but feel a hint of satisfaction at Izumi’s sudden yelp of surprise.  “<i>H-Hey, easy, easy!</i>” She chides, reproachfully. “<i>Just ‘cause I’m bigger than you doesn’t mean I’m not still a girl, you know... be a little gentler, yeah?</i>” You relax, slumping back down onto the ground, much to Izumi’s relief.  When you start to move again you take your time, setting up a much steadier, more measured pace.  Izumi squats over your hips, rocking back in time with your thrusts, trying to ensure you have the best angle for the deepest possible penetration.\n\n");

			outputText("Her growing arousal is clearly beginning to get to her, as evidenced by her distant, lust-fogged stare - and the increasing force behind the backwards thrusting of her hips. Before long, she’s slamming her hips back into you with such vigour that you’re gripping her waist less for leverage and more simply to hold on.\n\n");

			outputText("Izumi’s breathy grunting fills the cavern as she enthusiastically slams her hips down into you, her hammer-blow bouncing leaving you wondering if you’ll make it out of this encounter without some severe bruising.  It’s worth it though; Izumi’s asshole clenches and massages your length at a random place from [sheath] to tip on every thrust, leaving you guessing as to when the next spasm of pleasure will shoot through you. Every now and then your Oni partner slams her hips down into your own, then holds herself there for a moment, hissing through clenched teeth as she enjoys the sensation of being filled by your [cock biggest].\n\n");

			outputText("The heat from your enthusiastic lovemaking continues to rise, and before long, Izumi is openly panting from exertion, her tongue lolling out of her mouth in arousal. Her face is flushed, and a few errant beads of sweat are beginning to trail down her back by the time she speaks again.\n\n");

			outputText("“<i>Haha, hah..</i>” She half-pants, half laughs. “<i>It’s been a while since I’ve had the chance to do </i>this<i> kind of workout. I’m surprised you can keep up, you know?</i>”  You merely grunt in response; as much as you hate to admit it, Izumi is not exactly light, and you’re beginning to worry about the possibility of permanent damage....  Granted, her ass does have some natural ‘padding’, but the sheer force behind her bouncing is taking it’s toll.\n\n");

			outputText("“<i>Ohh, enjoying yourself too much to respond, huh?</i>”  Izumi grins lazily, completely misconstruing your silence. Her arousal is written clear across her face, and her transparently lewd expression causes your already strained erection to ache urgently.  With herculean effort, you slam your waist upwards with renewed vigour, hammering home with punishing force as you feel your orgasm begin to rise up within you.  Your fingers clench tighter, digging into the yielding softness of Izumi’s hips, while she grunts and pants in equal parts surprise and arousal at your sudden enthusiasm.\n\n");

			outputText("With a primal roar, you bury yourself to the hilt in the Oni girl’s backside as your orgasm explodes out of you.  Izumi lets out a triumphant laugh, arching her back in pleasure at the sensation of your cum flooding her insides");
			if (player.cockTotal() > 1)
			{
				outputText(", the cock");
				if (player.cockTotal() > 2) outputText("s");
				outputText(" not buried to the root in Izumi’s butt erupting in concert, splattering the joining between you with musky jizz.");
			}
			else
			{
				outputText(".");
			}

			outputText("  You jackhammer against her, extending your orgasm for as long as you can, but eventually your ejaculation ends, leaving you sprawled on the cavern floor panting for breath.  Izumi refuses to let you off that easily, however, keeping your softening cock lodged deep within her ass for as long as possible, squatting over you with a satisfied smirk on her face.\n\n");

			// TODO: probably add some cumq variants here

			outputText("“<i>Hah. So, looks like you had fun after all, huh?</i>” she says when she finally deigns to release you, your softening erection slipping slickly free of her as she stands and stretches, the muscles undulating attractively across her body.  “<i>It’s been a long time since I had someone else to do that kind of thing with, so I’m glad to know I’m still up to scratch, you know? Ahaha!</i>”\n\n");

			outputText("Izumi stands there with her hands on her hips, apparently unconcerned about being naked as she rolls her neck to relieve some of the stiffness built up there.  Despite having only just cum, the sight of the leonine woman standing so unabashedly naked before you, stretching out her body without a care in the world is undeniably arousing.  Even as the thought hits you, though, the dull ache in your hips reminds you that you had probably better not push your luck.\n\n");

			outputText("“<i>Hmm? Aw, you’re leaving already?</i>” Izumi notices you pulling yourself unsteadily to your feet and turns. “<i>I figured we could go again... ah, crap, I guess I got a little overenthusiastic, didn’t I?  You’re okay, right?</i>” Izumi actually blushes, pressing a hand to her cheek in embarrassment at her behaviour. It’s actually kind of cute, in a weird way.\n\n");

			outputText("Either way, after assuring Izumi that you’ll survive, you stagger out of the cave and begin to make your decidedly wobbly way back to camp.  Hopefully, your bruises won’t keep you awake....\n\n");

			player.sexReward("Default","Dick",true,false);
			cleanupAfterCombat();
		}

		// Super Ordinary Regular Missionary Sexy Time, honest
		protected function fuckhugeOniWantsYourBabiesOrSomeShit():void
		{
			lossSceneStay();

			outputText("Izumi leans over you as she pulls [eachCock] free of your clothing.  You let out a soft grunt as she straddles you, her hand almost absent-mindedly gliding over your [cock biggest] as she positions herself.  Her eyes glimmer in the dim light as she lowers herself down onto you, staring intently as your straining hardon slips between her lips, her pussy already slickening in anticipation. With a quick glance up at your face, she rests her free hand on your chest and pulls you inside.\n\n");

			outputText("The two of you let out a mutual hiss of pleasure as you [cockhead] slides into her, Izumi slowly lowering her hips, sinking down your length until you bottom out.  Izumi leans forwards, beaming even, as a flush starts to spread across her face.  Her muscles clench and undulate around you as she moves, massaging your cock; although whether it’s intentional or just a side-effect you have no idea - for all you know, this could just be what all Oni girls feel like.\n\n");

			outputText("“<i>Hey, um...</i>”  Izumi pipes up as she hunches over you, looking strangely awkward. She raises a hand to her chest, pulling aside the woefully inadequate covering to expose one massive breast.  “<i>If you want, you can... you know.  Play with ‘em..?</i>”  She mumbles while looking away, her flush visibly deepening.  This time it’s your turn to smirk; she’s so transparent at times that it can actually be kind of endearing.  Taking pity on her, you reach up and caress her breast, eliciting a shiver from Izumi.  Her eyes sparkle impishly in the dim light and she starts to rock back and forth, slowly, grinding her hips into your own in an agonizingly slow metronome.\n\n");

			outputText("Not satisfied with letting her have it all her own way, however, you push your hips upwards to match her motions, pushing even deeper inside of her with every stroke.  Izumi’s grin only widens and she runs her hand over your chest - a massage you are more than happy to respond to in kind.  Soon the two of you have reached equilibrium; a steady, easy pace that leaves you free to turn your attention to exploring Izumi’s mountainous regions.  Her breasts swing gently with the motion of her riding you, the impressive pair bouncing almost hypnotizingly every time she changes direction.\n\n");

			outputText("In contrast to her earlier showing during the fight, Izumi’s skin is surprisingly soft against your own.  Warm and yielding, it’s hard to believe that it belongs to the same person who was earlier flinging sledgehammer blows at you like it was nothing.  Compared to that, the Izumi currently smiling gently down at you seems like a completely different person.  Even the tousled mess of hair seems less the leonine mane it was during combat and more...  gentle, somehow.  The dim light filling the cave catches her hair in strange ways, suffusing it with a soft golden glow.\n\n");

			outputText("On top of all that, there’s her smile; no longer the leering, suggestive grin or the cocky, confident smirk, Izumi’s smile now is warm and genuine.  She’s happy.  Bereft of guile, the true scale of Izumi’s loneliness suddenly shines through; wandering the stars, without a home or a family to return to.  The thought makes you feel momentarily sad - the portal at your camp is a constant reminder of all the people you have praying and hoping for you, but Izumi has no such luxury.\n\n");

			outputText("You smile to yourself, dispelling the gloomy notion.  Izumi may be a little lonely, but you can think of one way to take her mind off it - at least for a while.  Leaning forwards suddenly, you pull Izumi’s other breast free of her kimono and bring her nipple to your mouth.  You run your teeth gently over the sensitive flesh and Izumi groans in response, running her hand through your hair encouragingly.\n\n");

			outputText("You thrust up into her enthusiastically, her soft walls tensing and flexing around you in response.  You cling to her, tightly, and she returns the affection in equal measure.  The heat from her body suffuses you, heightening your arousal and leaving both of you panting and sweating.  Your whole body trembles with the effort of holding back your orgasm as you pound into Izumi’s nethers, the burning heat from her crotch driving you wild with desire.  All too soon though, you find yourself pushed to the brink, and as your orgasm crashes over you, you suddenly reach up and pull Izumi down into a powerful french kiss.  Izumi’s eyes go wide and she reflexively tries to jerk back, but the shock of your dual assault seems to have robbed her of her strength, and she shudderingly relaxes.  You hold her there for the duration of your orgasm, exploring her unresisting mouth as you empty your");
			if (player.balls > 0) outputText(" balls");
			else outputText(" load");
			outputText(" into her twitching pussy.\n\n");

			// TODO: Add cumq variants

			outputText("When you finally release her, the two of you can only gasp for breath as you sag back onto the ground.  Izumi avoids your gaze, blushing furiously as she absently wipes her mouth with the back of her hand.\n\n");

			outputText("“<i>Well...</i>”  She mumbles.  “<i>I guess we both got a little carried away, huh?</i>”  She smiles again, a little awkwardly.  For a moment, you think about saying something, but before you can, Izumi releases you from her embrace and almost instantly she’s back to her regular carefree self.  “<i>Geez, don’t you know it’s impolite to kiss a girl without asking? Although I guess you figured consent was implied, huh?</i>”  She grins.  “<i>Don’t worry about it.  Just try and remember next time, huh?</i>”\n\n");

			outputText("You nod, pulling yourself to your feet and after exchanging a hasty goodbye with Izumi, you stumble towards the exit.  You’re not quite sure about ‘next time’, but you have to admit that really could have gone worse....\n\n");

			player.sexReward("Default","Dick",true,false);
			cleanupAfterCombat();
		}

		// No bits, no scenes. Izumi had no scenes written for genderless players. In some cases, other scenes would do a p. reasonable job with some reformatting.
		// This is one of the ones where I think something new has to be written. Get it coded, get it working, then considering doing it.
		// TODO: Actual genderless scene potentials
		// Eatin the oni; might as well put your mouf to work rite?
		protected function noDickNoVagNoService():void
		{
			lossSceneStay();
			flags[kFLAGS.IZUMI_SEEN_PC_GENDER] = player.gender;

			outputText("Izumi’s fingers stroke questingly over your groin for a moment, then she frowns, confused.\n\n");

			outputText("“<i>Huh. You, uh... you actually </i>don’t<i> have a dick.</i>” She says, sounding a little taken aback. “<i>You know, I gotta say, I think you’re the first person I’ve met on this rock without a wang?  Seriously.  I just kind of assumed you had one.  Kinda lost track of my gameplan here, ‘cause I was really expecting something to grab onto down here.</i>”  She taps her lip with her free hand while you stare at her, bemused.  Then an ominous, toothy grin spreads slowly across her face.  “<i>Okay, new plan.</i>”  She announces, then her hand staps out to snatch hold of your ankle in an iron grip.  “<i>I guess I’ll just have to eat ya.</i>”\n\n");

			outputText("Before you can protest, you find yourself being spun effortlessly upside down by the oversized Oni, suspended by your");
			if(player.isNaga()) outputText(" tail");
			else outputText(" ankle");
			outputText(") in an extremely uncomfortable position.  Izumi’s grin becomes positively feral as she tears your clothing free");
			if(!player.isNaga()) outputText("before grabbing onto your other ankle, forcibly spreading your legs apart and leaving you creating a very undignified Y-shape");
			outputText(".\n\n");

			outputText("“<i>Well, "+ this.heightDesc() +", you really are weird... no dick </i>or<i> pussy.  I, err...</i>”  She says, the confusion caused your evident lack of equipment spreading across her face.  “<i>I gotta say, I’m fresh out of ideas over here.</i>”\n\n");

			outputText("She gently lowers you toward the floor, and releases her grip on your ankles.  “I-I guess you can go, yeah?” She says, motioning toward the entrance to her cave.  Paying you no mind, she heads off toward her tent, clearly no longer interested in you.\n\n");

			cleanupAfterCombat();
		}

		// Big bad oni gonna eatcha
		protected function littleChampLittleChampFuckhugeOniIsCominTaEatcha():void
		{
			lossSceneStay();

			if (flags[kFLAGS.IZUMI_SEEN_PC_GENDER] != 2 && !player.hasCock())
			{
				outputText("Izumi’s fingers stroke questingly over your slit for a moment, then she frowns, confused.\n\n");

				outputText("“<i>Huh. You, uh.. You actually </i>don’t<i> have a dick.</i>”  She says, sounding a little taken aback.  “<i>You know, I gotta say, I think you’re the first person I’ve met on this rock without a wang? Seriously. I just kind of assumed you had one. Kinda lost track of my gameplan here, ‘cause I was really expecting something to grab onto down here.</i>”  She taps her lip with her free hand while you stare at her, bemused.  Then an ominous, toothy grin spreads slowly across her face.  “<i>Okay, new plan.</i>” She announces, then her hand snaps out to snatch hold of your");
				if (player.isNaga()) outputText(" tail");
				else outputText(" ankle");
				outputText(" with an iron grip.  “<i>I guess I’ll just have to eat ya.</i>”\n\n");
			}
			
			flags[kFLAGS.IZUMI_SEEN_PC_GENDER] = player.gender;

			// TODO: Theres some logical holes with where/what Izumi can know about the players actual gender (A Standard Problem I guess)

			outputText("Before you can protest, you find yourself being spun effortlessly upside down by the oversized Oni, suspended by your");
			if(player.isNaga()) outputText(" tail");
			else outputText(" ankle");
			outputText(" in an extremely uncomfortable position.  Izumi’s grin becomes positively feral as she tears your clothing free before");
			if(!player.isNaga()) outputText(" grabbing onto your other ankle, forcibly spreading your legs apart and leaving you creating a very undignified Y-shape");
			outputText(".\n\n");

			outputText("“<i>Oh, calm down.</i>”  Izumi seems quite unphased by your protests, having her sights clearly set on something else entirely.  “<i>I just wanna try something.  Besides, it’ll be fun!  Promise!</i>” She beams down at you, then rears back, opens her mouth and lunges her face forwards into your crotch!  You yelp in surprise as Izumi’s tongue suddenly slams into your [vagina] as though it held a grudge against it, flickering back and forth, up and down, darting this way and that as she slathers your nethers with her saliva.\n\n");

			outputText("It doesn’t take much of this treatment before you’re twisting and writhing in equal parts panic and pleasure, flailing and bucking desperately as you try to find some relief from Izumi’s relentless, overpowering assault.  The ever-so-slightly rough surface of her tongue snakes over your [clit] and you cry out reflexively, jerking back and then swinging forwards again to collide with the immovable wall of Izumi’s midsection.  You throw your hands around it and hold on for dear life, glad at least of the opportunity to anchor yourself.\n\n");

			outputText("Clinging to Izumi’s muscled torso, you’re unable to do anything but shudder and grit your teeth against the moans as her tongue snakes over your pussy.  Then, out of nowhere, you feel her tongue finally <i>enter</i> you; it feels impossibly long as it snakes sinuously into your innards, and you find yourself wondering with a note of panic just how long Izumi’s tongue might be.  She isn’t human, after all - for all you know, she could have a foot of tongue waiting to plunge into your aching depths.  Your smoke-addled imagination combines with the increasing rush of blood to your head to populate your brain with a myriad terrifying, bizarre and decidedly perverse possibilities.  Izumi’s tongue never lets up for a second, pumping into you, slathering over you, scraping over the sensitive skin of your clit like so much sandpaper....  It’s all far too much for you, and as your eyes begin to roll back into your head you simply surrender to the pleasure.\n\n");

			outputText("Satisfied that you’ve stopped struggling, Izumi continues to devour your cunt, much to your equal parts distress and delight.  Robbed of your reason by the pounding blood in your ears, your [tongue] darts out to give Izumi’s muscled midriff an experimental lick.  The Oni woman grunts above you and shivers in surprise, but makes no attempt to stop you - so you continue.  Running your tongue across her abs, you close your eyes and find yourself mirroring the motions of Izumi’s tongue with your own.\n\n");

			outputText("If Izumi finds your behaviour odd, she doesn’t show it; her pace doesn’t let up for a second, and before long you find yourself hurtling towards an explosive orgasm.  You tremble in Izumi’s grip as you feel it building, and when it hits, it hits hard: You actually lose your grip, tumbling free of Izumi, wailing in tortured ecstasy as the Oni’s talented tongue brings you over the top.  Even while you jackknife in her grip, Izumi doesn’t give you any leeway, continuing her heartless assault in order to drag out your orgasm for as long as humanly possible.  By the time it finally ends, you’re hoarse from screaming - you’re almost certain that Izumi actually managed to make you orgasm over again while still in the middle of your spasming madness.\n\n");

			outputText("Detaching her mouth from your crotch with a wet gasp, Izumi chuckles to herself as she lowers you gently to the floor.\n\n");

			outputText("“<i>That’s what it means to be eaten alive by an Oni!</i>”  She pants, grinning.  While you’re glad - in a kind of dim, distant way - that the endeavour apparently took some sort of toll on her as well, you’re honestly more concerned with the pounding headache and the pins and needles prickling your arms to muster up any kind of response.  “<i>Oh geez, did I go too far? Hey, you’re okay, aren’t ya?</i>”  Izumi stoops next to you, her face radiating concern.  You manage a feeble nod, and she smiles apologetically.  “<i>Sorry, I guess I can get kinda rough when it comes to girls... I dunno why, but hey, you’re okay, so it’s all good, right?!</i>”  She beams.\n\n");

			outputText("Izumi is gracious or wracked by her guilty conscious enough to let you rest up quietly in her cave without further molestation until the pounding in your head fades away.  As you carefully pick your way back down the mountain, you muster up a half-hearted wave of goodbye back to the cheerfully waving giantess.  While you’re not sure if you’d exactly describe what you just experienced as fun... at the very least, you’re glad she didn’t <i>actually</i> try to eat you.  Deep down though, part of you can’t help wondering if she really would...\n\n");

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}

		/**
		 * VICTORY SCENES
		 */

		 // touch the horns. TOUCH IT
		 // Entry to VICTORRRYYYY scenes
		public function touchThatFluffyHorn():void
		{
			flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 3;
			flags[kFLAGS.IZUMI_TIMES_GRABBED_THE_HORN]++;
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] >= 1) flags[kFLAGS.IZUMI_DEFEATS_COUNTER]++;
				else flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 1 && flags[kFLAGS.IZUMI_LVL_UP] < 1) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 1;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 2 && flags[kFLAGS.IZUMI_LVL_UP] == 1) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 2;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 3 && flags[kFLAGS.IZUMI_LVL_UP] == 2) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 3;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 4 && flags[kFLAGS.IZUMI_LVL_UP] == 3) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 4;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 5 && flags[kFLAGS.IZUMI_LVL_UP] == 4) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 5;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 6 && flags[kFLAGS.IZUMI_LVL_UP] == 5) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 6;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 7 && flags[kFLAGS.IZUMI_LVL_UP] == 6) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 7;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 8 && flags[kFLAGS.IZUMI_LVL_UP] == 7) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 8;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 9 && flags[kFLAGS.IZUMI_LVL_UP] == 8) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 9;
				}
				if (flags[kFLAGS.IZUMI_DEFEATS_COUNTER] == 10 && flags[kFLAGS.IZUMI_LVL_UP] == 9) {
					flags[kFLAGS.IZUMI_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.IZUMI_LVL_UP] = 10;
				}
			}
			if (!player.hasStatusEffect(StatusEffects.ChiChiWeddingS)) player.createStatusEffect(StatusEffects.ChiChiWeddingS,0,0,0,0);
			clearOutput();
			outputText("Izumi slips backwards onto one knee and holds up a hand for pause,");
			if((player.HP/player.maxHP()) <= 0.1) outputText(" the brief reprieve giving both of you a moment to recover.\n\n");
			else if(monster.lust >= monster.maxLust()) outputText(" the Oni’s cheeks tinged a rosy peach in contrast to her alabaster skin.\n\n");
			else outputText(" momentarily staggered by your furious onslaught.\n\n");
 
			outputText("“<i>Alright, alright! Hold it a second!</i>” she yells, scowling as she pulls herself back to her feet.  Warily, you remain in your combat stance just out of reach, waiting to see if she’ll try anything.  Instead of launching some kind of surprise attack, however, she just dusts herself off, glaring at you thoughtfully.  The two of you exchange stares for a long, tense moment, before finally Izumi lets out a quiet grunt.\n\n");
			 
			outputText("“<i>Hmph. Okay, okay; I admit it.  You’re pretty good, kid. So, if ya want, we’ll call this one a draw. Go on, get outta here, before I change my mind.</i>”  It seems like she talks a big game, but the second things stop going her way, she wants to back out.  Izumi catches sight of your surprised expression and chuckles.  “<i>What, you actually think you can take </i>me?<i> Full force, without some cheap gimmick?  I’m not normally in the business of granting death wishes, so I’ll give ya one last chance to walk out nice and peaceful before I decide I gotta teach you a lesson.</i>”  She folds her arms and smirks at you expectantly, clearly expecting you to take the hint and run.\n\n");
			 
			outputText("But you don’t.  After her performance in the last fight, you’re pretty sure you can take her – and besides, her smug attitude is beginning to get on your nerves.  You stand your ground, glaring daggers at the busty giantess.  Izumi’s smirk widens slowly into a full-force leer as she realizes you’re not just going to cut and run.\n\n");
			 
			outputText("“<i>You’re really gonna try your luck, aren’t ya?</i>”  Izumi asks. When you nod in response, she throws back her head and lets out a booming, uproarious laugh.  “<i>I love it! I </i>love<i> this attitude!  Fighting you is more exciting than anything else I’ve encountered on this godawful rock!  Alright, here – I’ll give you a gift! A glimpse of my full strength, no gimmicks, no holding back. And remember, you asked for this, so I don’t want to see you crying when you lose!</i>” \n\n");

			// Original version of the scene for seeleey modes
			if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == true)
			{
				outputText("Without warning, Izumi suddenly brings one leg up, swings it wide and smashes it back down onto the ground.  A second later, she does the same with her other leg, assuming some kind of strange, half-crouching stance.  You ready yourself for an attack, but instead Izumi takes a deep breath, clenches her fists, and then....\n\n");
				 
				outputText("“<i><b>Tooooooooohhhhhhhhhhh!</b></i>” She roars, her voice only a low rumble at first but quickly growing to a thunderous crescendo.  You can only watch, astounded at the bizarre spectacle, as Izumi’s roar starts to cause tiny tremors to run through the cave, knocking over several small objects strewn around her camp.  Izumi continues to bellow the strange war-cry, cords of muscle visible against her neck from the strain of... whatever it is she’s doing.\n\n");
				 
				outputText("And then you feel it.  Weakly at first, but growing in strength with every passing moment; waves of energy start rolling off of Izumi, each stronger than the last, making your hair stand on end.  Somehow, the oni’s roar is causing her to positively <i>radiate</i> power – and that power is growing stronger every second.  You begin to worry that you might actually be in real danger here.  Izumi was pretty strong when she claimed to be just playing around and using only a single hand to fight you, but there’s nothing playful about her appearance now.  In fact, in her strange, crouched stance, muscles straining against some invisible force, snarling and roaring at the empty air as she stares into nothing, you can’t help but feel she looks like nothing more than a crazed monster...  a demon, straight out of a story made to scare wayward children.  You have to do something, you realize.  You have to interrupt her, before she finishes whatever it is she’s doing!\n\n");

				outputText("You dart forwards, hoping to catch Izumi off-guard while she’s still distracted, but as soon as you get close those crazed, staring eyes lock onto yours – and before you can react, her arm lunges out in an uppercutting grab, her fist latching around your throat and wrenching you from the floor.  You lash out, swinging at Izumi’s face, but you can’t concentrate while being held off the floor by your neck!  In desperation, you make a grab for the one thing you can think of to try steadying yourself to brace for a strike – the bright red curve of Izumi’s horns.  As soon as your fingers wrap around it, however, Izumi’s brutal, victorious expression changes.\n\n");
				 
				outputText("Specifically, it gets a whole lot redder.\n\n");
				 
				outputText("Izumi blinks, once, twice, as the hair-raising aura dissipates almost immediately.\n\n");
				 
				outputText("“Um,” she says, surprisingly quietly given her formerly berserk appearance.  “C-Could you please let go of that?” she asks, slowly sinking to her knees.  Your feet touch solid ground again, Izumi’s hand still wrapped limply around your neck, apparently forgotten.\n\n");
				 
				outputText("“<i>Really.  Um.  Please let go.</i>”  She says, swallowing hard and staring at nothing.  Given her sudden change of attitude, you can’t help but wonder if your grip on the horns is somehow responsible.  After all, maybe you’ve seized on the source of all her magical strength, or something?  You have no idea, so you decide to simply ask.  “<i>No.  Um.  No... It’s just, um.  T-That isn’t something you should touch.  So, y-you’ll let go now, right?</i>”  Izumi stammers.  You stare at her, fascinated by her complete change of personality; gone is the confident, domineering Oni you originally met.  Instead, Izumi, kneels nervously before you, staring intently into space and trying her level best not to move.  Interesting....\n\n");
				 
				outputText("Experimentally, you roll your thumb over the rocky surface of the horns.  Instantly, Izumi <i>visibly</i> flinches, her eyes widening in surprise and shock.  “<i>Hey,</i>” she says, simply, her voice wavering.  “<i>Hey,</i>” she repeats. “<i>Come on now.  Enough is enough, right?</i>”\n\n");
			}
			// Super awesome Gedan edit mode!
			else
			{
				outputText("Without warning, Izumi suddenly brings one leg up, swings it wide and smashes it back down onto the ground. A second later, she does the same with her other leg, assuming some kind of strange, half-crouching stance.  You ready yourself for an attack, but instead Izumi takes a deep breath, clenches her fists, and then....\n\n");
				 
				outputText("“<i><b>Tooooooooohhhhhhhhhhh!</b></i>” She roars, her voice only a low rumble at first but quickly growing to a thunderous crescendo.  You can only watch, astounded at the bizarre spectacle, as Izumi’s roar starts to reverberate within the cave.  Izumi continues to bellow the strange warcry, cords of muscle visible against her neck from the strain of her warcry.\n\n");

				outputText("Izumi was pretty strong when she claimed to be just playing around and using only a single hand to fight you, but there’s nothing playful about her appearance now.  In fact, in her strange, crouched stance, muscles straining against some invisible force, snarling and roaring at the empty air as she stares into nothing, you can’t help but feel she looks like nothing more than a crazed monster...  a demon, straight out of a story made to scare wayward children. You have to do something, you realize.  You have to interrupt her, before she finishes whatever it is she’s doing!\n\n");

				// Tease victory
				if (monster.lust >= monster.maxLust())
				{
					// Gonna refactor the tease attack code to seperate out the display elements from the action elements, so I we can grab a player-appropriate text blurb
					outputText("[teaseText]");
					outputText("Izumi pays your attempts to distract her no mind, focused entirely on her strange ritual. You slink forwards, hoping that something a little more... hands on might do the trick. But ");
				}
				else
				{
					outputText("You dart forwards, hoping to catch Izumi off-guard while she’s distracted, but ");
				}
				
				outputText("as soon as you get close, those crazed, staring eyes lock onto yours - ");

				if (player.spe >= 90)
				{
					outputText("her arm lunges out in an uppercutting grab, but your reflexes are faster, managing to dodge out of the way at the last moment.  Sensing an opportunity with the Oni suddenly off-balance, you make for a grab of your own - reaching out for the bright red curve of Izumi’s horns.\n\n");
				}
				else if (player.str >= 90)
				{
					outputText("and before you can react, her arm lunges out in an uppercutting grab, her fist latching around your throat and wrenching you from the floor.  You lash out, swinging for Izumi’s arm, managing to pound against the iron-hard limb with enough force to dislodge the choking collar of fingers from your neck.  Sensing an opportunity with the Oni momentarily recovering, you make for a grab of your own - reaching out for the bright red curve of Izumi’s horns.\n\n");
				}
				else if (player.inte >= 75)
				{
					outputText("her arm lunges out in an uppercutting grab, her fist latching around your throat and wrenching you from the floor.  Izumi is far too strong to best directly; leverage, you realize, is what you need to free yourself.  You reach out for the bright red curve of Izumi’s horns. \n\n");

				}
				else if (player.tou >= 90)
				{
					outputText("her arm lunges out in an uppercutting grab, her fist latching around your throat and lifting you from the floor.  Her grip is crushingly tight, but you can endure it... for now, at least.  Looking to respond in kind, you reach out for the bright red curve of Izumi’s horns.\n\n");
				}
				else if (player.lib >= 40 && (player.biggestTitSize() >= 2 || player.biggestCockLength() >= 5))
				{
					outputText("her arm lunges out in an uppercutting grab, her fist latching around your throat and wrenching you from the floor.  You struggle, helplessly, against her arm for a moment before an idea strikes; \n\n");

					if (player.biggestTitSize() > 2) outputText("maybe giving her face a little personal time nestled between your [chest] will finally distract the Oni enough.  You reach out for the bright red curve of Izumi’s horns, ");
					else outputText("thinking quickly, you slip open your [armor] with one hand, bearing your [cock] to the world, your other hand reaching for the bright red curve of Izumi’s horns, ");

					outputText("trying to force her gaze toward your ‘assets.’\n\n");
				}
				else
				{
					outputText("You lash out, swinging at Izumi’s face, but you can’t concentrate while being held off the floor by your neck!  In desperation, you make a grab for the one thing you can think of to try steadying yourself to brace for a strike - the bright red curve of Izumi’s horns.\n\n");
				}

				outputText("As soon as your fingers wrap around it, however, Izumi’s brutal, victorious expression changes.  Specifically, it gets a whole lot redder.\n\n");

				outputText("Izumi blinks once, twice, as the hair-raising visage she was maintaining drops almost immediately.\n\n");

				outputText("“<i>Um,</i>”  She says, surprisingly quietly given her formerly berserk appearance.");
				if (player.spe < 90 || player.str < 90)
				{
					outputText("“<i>C-Could you please let go of that?</i>” She asks, slowly sinking to her knees.  Your feet touch solid ground again, Izumi’s hand still wrapped limply around your neck, apparently forgotten.\n\n");
					outputText("“<i>Really. Um. Please let go.</i>”");
				}
				else outputText("“<i>C-Could you please let go of that?</i>”");

				outputText(" she says, swallowing hard and staring at nothing.  Given her sudden change of attitude, you can’t help but wonder if your grip on the horns is somehow responsible.  “<i>T-That isn’t something you should touch.  So, y-you’ll let go now, right?</i>”  Izumi stammers.  You stare at her, fascinated by her complete change of personality; gone is the confident, domineering Oni you originally met.  Instead, Izumi, kneels nervously before you, staring intently into space and trying her level best not to move.\n\n");

				outputText("Experimentally, you roll your thumb over the rocky surface of the horns.  Instantly, Izumi <i>visibly</i> flinches, her eyes widening in surprise and shock.  “<i>Hey,</i>” She says, simply, her voice wavering. “<i>Hey,</i>” She repeats. “<i>Come on now. Enough is enough, right?</i>”\n\n");
			}

			outputText("You could play nice and let the Oni go free... she is asking nicely, after all.  On the other hand, after the way she tried to ravage you earlier, you figure Izumi’s arrogant attitude could use being taken down a notch or two.  The only question is, what exactly are you going to do?\n\n");

			menu();
			addButton(0, "Let Go", letGoAndLeaveYouSillyFuck);

			flags[kFLAGS.IZUMI_SEEN_PC_GENDER] = player.gender;
			
			if (player.hasVagina())
			{
				addButton(1, "TribHorn", tribThatRockyHornGirl);
			}
			if (player.hasCock())
			{
				addButton(2, "LetsFuck", letGoAndFuck);
				addButton(3, "RevengeAnal", gonnaGetMeSomeRevengeButtsexin);
				addButton(4, "RevengeOral", sayThatsAPrettyFaceBeAShameIfSomebodyJizzedAllOverIt);
				if (player.tentacleCocks() >= 8 || player.stamenCocks() >= 8) addButton(5, "Tentacruel", tentacruelRevengeFux);
			}
			if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
		}

		// Pfft, nofux
		protected function letGoAndLeaveYouSillyFuck():void
		{
			clearOutput();

			outputText("Against the wishes of your libido, you decide to let Izumi off the hook.  You release her horns, soliciting a relieved gasp from Izumi, then take a step back.  The Oni woman straightens hastily and shoots you a grateful look before scurrying back into her tent, emerging a few moments later with an oversized fistful of gems.\n\n");

			outputText("“<i>Here,</i>” she says, hurriedly.  “<i>I don’t need ‘em, and the minotaurs around this place drop ‘em like candy once you slap ‘em around a little, so they’re all yours.  And, uh...</i>” She blushes, looking distinctly awkward, before adding, “<i>Thanks for being such a good sport and stopping when I asked.  And stuff.  I-It’s just, that’s kind of a sensitive area, and it’s pretty rude to touch a girl there, you know?  So... you know.</i>”  She trails off, lamely.  You shake your head, feeling a little bemused as you accept the glittering payoff.\n\n");

			outputText("You stow the gems safely away, reassuring Izumi that you have absolutely no intent of suddenly leaping on her and grabbing her horns again, then turn to make your way out of the cave.  Just as you pass the rock, however, you hear Izumi calling out from behind you.  You turn to see her hovering in the cave mouth looking uncharacteristically nervous.\n\n");

			outputText("“<i>Um, hey, you can come back any time, by the way. I mean, we can still be friends and stuff. It’s just, uh, some stuff is off limits for a girl, you know?  After all, I’m not the kind of girl who’ll just let someone grab wherever they want out of nowhere, even if they do have pretty soft hands.  I mean, I’ve got standards!  Uh...</i>” She bites her lip, then frowns, suddenly, as though coming to a realization.  “<i>Look, I’m just gonna go back inside. Let’s just... forget this ever happened. Okay? See you around, kid.</i>”\n\n");

			outputText("She swirls around and disappears into the gloom of the cave in a flurry of scented smoke.  For your part, you’re left with a long trek home and a complete lack of any idea what the hell just happened.  But on the upside, you <i>do</i> also have a nice stack of shiny gems to make up for the confusion.\n\n");

			cleanupAfterCombat();
		}

		// Kinda friendly fux
		protected function letGoAndFuck():void
		{
			clearOutput();

			outputText("You decide to let Izumi off the hook - up to a point.  You release her horns, soliciting a relieved gasp from Izumi, then take a step back.  The Oni woman straightens hastily and shoots you a grateful look before turning back to her tent.\n\n");

			outputText("“<i>I’ve got some gems back here somewhere...</i>” she says, but you interrupt, grabbing her sleeve and pulling her back towards you.  Deciding to take the direct route, you surprise Izumi by ambushing her with a sudden hug, burying your [face] in her expansive bust.  “<i>Huh?! I- What are you- Oh. </i>Oh!<i></i>”  She says as comprehension dawns.  “<i>You want to, uh...?</i>” she trails off, staring at you as you look up at her from your comfortable position sandwiched between her breasts - got it in one.\n\n");

			outputText("“<i>Huh,</i>”  Izumi murmurs, rubbing her chin thoughtfully.  “<i>So you get the best of me, get me in a compromising position, then just let me go ‘cause I ask... But you still wanna fuck?</i>”  You nod emphatically, causing Izumi to chuckle.  “<i>You’re pretty unusual, kid, you know that? It’s not often I run into the chivalrous type. I gotta admit, it’s a refreshing change from the ‘a penis in every hole’ crowd. Hmm...</i>”  She eyes you thoughtfully for a moment, then gives a defeated shrug, smiling broadly.  “<i>Well, ya beat me, so it looks like ya get to do whatever ya want. I’m completely at your mercy, so if you were gonna do something lewd, I guess I’d have no choice but to go along with it.</i>”  The burly woman grins");
			if (player.tallness < 80) outputText(" down");
			else if (player.tallness > 108) outputText(" up");
			outputText(" at you, planting her hands on her hips.  “<i>So, what are ya gonna do to me now you’ve won, hotshot?</i>”\n\n");

			outputText("Izumi rolls her eyes indulgently as your hand slips under the silken folds of her kimono to grope and grasp at her breast.  You roughly pull the soft fabric aside, exposing one half of Izumi’s considerable bust to the air.  You run your hands over the glorious expanse of titflesh, luxuriating in the sensation of warmth flowing up into your palms as Izumi smirks appreciatively");
			if (player.tallness < 80) outputText(" from above");
			else if (player.tallness > 108) outputText(" from below");
			outputText(".\n\n");

			outputText("Your roving hands locate one already hardening nipple and bring it up to your mouth. Izumi lets out a hiss as you latch onto her breast, sucking and licking away at the stiffening flesh with abandon.\n\n");

			outputText("“<i>Hey,</i>” she groans quietly.  “<i>I’ve got two, you know?</i>”  She pulls her kimono aside, a blush beginning to spread across the broad plain of her features as she awkwardly presents her other breast to you. You can’t help but smirk a little as you change position slightly to suckle and grope at the new arrival instead, much to Izumi’s clear enjoyment.\n\n");

			outputText("Suddenly painfully aware of the rising sensation in your crotch, you detach yourself from Izumi’s boobs in order to undo the rest of her kimono, pulling it aside to hang there limply as you inspect Izumi’s body.  You lean back into her, planting a kiss on her stomach - clearly not what Izumi expected as, somewhat cutely, she actually flinches at the sensation - before gliding a hand down between her legs.  To your surprise, she’s actually already wet; although you do find yourself wondering if it’s from your expert manipulation or the fight beforehand....\n\n");

			outputText("“<i>Hey, hold it a sec,</i>”  Izumi pipes up suddenly.  “<i>Let’s try it like this, since I don’t really wanna do it standing up...</i>”  She detaches from you, backing away in order to take a seat with her back resting against one of the cave walls.  Satisfied that her new position is comfortable, she turns to you, locking you with a gaze that can only be described as ‘come hither’.  Spreading her legs shamelessly wide, she displays herself to you alluringly, beckoning with one finger.\n\n");

			outputText("“<i>Well?  Come on already,</i>” she says, smirking lasciviously.  “<i>You wanted to do me, right? Well then, you’d better hurry up and get started before I get embarrassed...</i>”\n\n");

			outputText("You advance on Izumi, noting the hungry light in her eyes as you remove your [armor].  Her half-discarded kimono acts as a sort of blanket, softening the ground as you crawl in between the enormous woman’s thighs, positioning yourself to thrust into your new conquest.  “<i>Yeah, let’s do it, "+ this.heightDesc() +"... I’m ready, so show me what you’ve got.</i>”  She murmurs, half to herself, and you’re only too happy to oblige.\n\n");

			outputText("In one smooth movement, you thrust your [cock biggest] into Izumi’s waiting pussy.  She grunts appreciatively as you hilt yourself inside her, but the sensation on your end is perhaps far more impressive; whether consciously or unconsciously, the muscles inside Izumi begin to gently stroke and massage you, pushing back in soft protest against the intrusion of your cock.\n\n");

			outputText("“<i>Ahahh, hey now... not bad, kid.  Not bad at all.</i>”  Izumi leans back, allowing you to lay across her stomach while she relaxes, resting her back against the cave wall and smiling at you encouragingly.  You take the time to adjust to the new sensations enveloping your cock, steeling yourself to give Izumi the fucking of a lifetime.  Satisfied that you’re ready, you begin to move, thrusting your hips - slowly at first - into Izumi.  She wets her lips a little, one arm snaking over your back to draw you into a gentle hug,");

			if (player.biggestTitSize() >= 1 && player.biggestTitSize() < 3) outputText(" smothering your [chest] with her own, much larger, pair.\n\n");
			else if (player.biggestTitSize() >= 3 && player.biggestTitSize() < 5) outputText(" your [chest] moulding themselves against the Oni’s larger pair.\n\n");
			else if (player.biggestTitSize() >= 5 && player.biggestTitSize() <= 8) outputText(" your [chest] compressing against the Oni’s larger pair, forming a delicious valley of flesh.\n\n");
			else if (player.biggestTitSize() > 8) outputText(" your [chest] dominating the Oni’s own in the battle for space between the two of you.\n\n");
			else outputText(" pressing you into her chest.\n\n");

			outputText("“<i>You don’t need to be so restrained.  It’s not like you’re gonna hurt me if you pick up the pace a little.</i>”  She looks away, her blush visibly deepening.  “<i>N-Not that this isn’t nice by itself, you understand, I just... you know, if ya want to, you can go faster, I don’t mind...</i>”\n\n");

			outputText("It’s obvious that she wants you to be a little more vigorous, but you decide to hold off for a moment.  You keep up a slow, easy rhythm, luxuriating in the way that Izumi’s pussy seems to try and latch onto your [cock biggest] as you draw back, as though unwilling to let you go, before sliding back inside of her welcoming folds.  Izumi groans, her fingernails rolling across your back as she clenches her fist in frustration.\n\n");

			outputText("“<i>H-Hey, you deaf?! I said you can go faster, you know?</i>” she scowls, clearly embarrassed.  “<i>So... you gonna do it, or what?!</i>”  She gives you a plaintive look, half crushing embarrassment, half pleading desperation. You answer her by burying your face between her breasts, nuzzling against the warm flesh as your hips begin to move faster and faster.  From the way her breath suddenly catches in her throat, you can tell your thrusts are having the desired effect.\n\n");

			outputText("Izumi runs her hand through her hair, moaning in arousal as you exert yourself, thrusting into her with enough force to send small tremors juddering through her frame.  Each time you bottom out inside her, your [hips] colliding with a lewd and clearly audible slap, she lets out a cute little yelp; a momentary, almost inaudible acknowledgement of the pleasure you’re giving her.\n\n");

			outputText("The two of you remain like that for some time, Izumi becoming progressively more hot under the collar as your lovemaking continues.  The brash, bullish woman you met earlier seems to have completely melted away, replaced by this new version of Izumi; all blushes and breathy moans.  She looks at you, awkwardly, as though wrestling with some internal dilemma, her face flushed and hot.\n\n");

			outputText("“<i>Um.  This is really nice.  I just... can you maybe do a thing for me?  It’s nothing hard!</i>” she murmurs, so quietly you can barely hear her.  “<i>D-Do you think you could maybe... you know. Touch it?</i>”  She looks away again, shyly.  You aren’t quite sure what she means at first, so you just stare at her blankly for a moment.  \n\n");

			outputText("She looks back, clocking your expression, then bites her lip.  “<i>M-My horns. Since we’re already, you know... gettin’ intimate anyway, it’s okay, so...</i>”  She trails off, clearly embarrassed beyond belief.  Feeling a little bemused, but willing to oblige, you steady yourself on one hand and reach up to gently grip Izumi’s horns with the other.\n\n");

			outputText("The effect is instantaneous; Izumi screws her eyes shut, cramming a knuckle into her mouth.  You’re momentarily worried she might be in pain, but then she gives you a short, sharp nod of the head.  Izumi’s grip tightens around you, drawing you into an even closer hug, the contours of her body rubbing against your skin, heat rising as your bodies rub slickly against one another.  Her free hand rests demurely at the base of her neck, twitching occasionally as your probing fingers run across a sensitive ridge or bump on her horns.\n\n");

			outputText("The moment your hand touches her horns, Izumi’s pussy clamps down around your cock, slowly relaxing into an awkward rhythm of irregular twitches, periodically clenching around your length as you stimulate her horns.  Surprisingly quickly, she’s reduced to visibly panting with arousal, her bust heaving");
			if (player.biggestTitSize() > 0) outputText(" against your own");
			outputText(" as she gasps for air.\n\n");

			outputText("“<i>Ah, shit,</i>” she gasps suddenly, “<i>I think, I don’t think I’m gonna be able to hold it any longer, s-sorry... ah! Nghahh, oh shit, here it comes!</i>”  Izumi’s eyes go wide as she suddenly jerks forwards slightly, arching her back away from the wall, her fingernails scraping across your back and the walls of her pussy clamping down around you like a vice.  She wraps her free hand around the back of your head, pulling you into her so hard that it’s almost painful.  You feel your own orgasm rising in turn and bury yourself up to the hilt, forcing yourself as deeply into Izumi as you can possibly manage.  She wails in orgasmic gratitude, her legs wrapping themselves around your waist and locking together, forcing you to remain where you are, buried deep within her as her muscles go insane, juddering and squeezing, stimulating every inch of your cock, forcing your orgasm out of you as though she bore it a grudge.\n\n");

			outputText("You let out a loud, bestial grunt of satisfaction as you feel your cum surging through your length, exploding out of you in powerful jets and splashing across the walls of Izumi’s waiting hole.  Izumi shudders beneath you with every spurt, jerking her hips upwards and staring blankly into space, letting out short, almost disbelieving little gasps as your heat spreads slowly within her.\n\n");

			outputText("As your orgasms subside, you feel her go limp below you, slumping back against the wall.  Feeling decidedly spent yourself, you’re content to just lay where you are for a while, head comfortably cushioned by her breasts, enjoying the decidedly pleasant sensation of slowly softening while still inside your Oni partner.\n\n");

			outputText("“<i>Haha, hahh,</i>” Izumi mutters, sounding almost regretful, “<i>Ah, geez. I really came, huh... and from you playing with my horns, too...</i>” she laments.  She covers her eyes with one hand and grins ruefully, her face still reddened from her recent orgasm.  “<i>That’s so embarrassing...</i>”\n\n");

			outputText("On a whim, you decide to try and cheer the big woman up a little.  Propping yourself up on one shaky arm, you lean forwards and plant a kiss directly on her mouth.  Izumi’s fingers split open in front of you to reveal a pair of amber eyes that can only be described as ‘surprised’, or possibly even ‘shocked’.  You break off the kiss, and she stares at you in complete disbelief, her expression unreadable.  After a long moment, she speaks.\n\n");

			outputText("“<i>U-Um. Thanks, but p-please don’t do things like that again,</i>” she stammers. “<i>Not that I hate you for it, or anything!  It was nice, it’s just, I-I don’t, uh... I don’t really know what to, uh, you know...</i>”  She sees your expression and sighs, apologetically.  “<i>Sorry, I just never know how to react to stuff like this. Don’t worry about it, okay?</i>”  She smiles, stroking your hair lovingly.\n\n");

			outputText("You decide not to make an issue of it, since Izumi is clearly embarrassed.  The two of you redress, and as you make to leave, Izumi whistles for your attention.  You turn, and she throws you a small leather bag, which you open to discover a handful of gems inside.\n\n");

			outputText("“<i>It’s just a little thank you gift. You know, for uh...</i>”  She winks, provocatively.  “<i>Services rendered?</i>”  Smiling, you make your way back to camp, feeling decidedly good about yourself.\n\n");

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}

		// Fuck dat giant oni butt
		protected function gonnaGetMeSomeRevengeButtsexin():void
		{
			clearOutput();

			outputText("You know <i>exactly</i> how you want to get your revenge on the uppity giantess.  Firstly, you order her to disrobe; she looks like she’s considering a refusal, but a quick squeeze to the horns ensures she acquiesces, blushing furiously.\n\n");

			outputText("“<i>Okay, fine,</i>” She says hotly, slipping out of her clothing. “<i>You’re just gonna take a quick look and then you’ll let go, right?  And by the way, you’re pretty perverted for making a girl strip in front of you, you know?!</i>”  She has no idea...\n\n");

			outputText("A moment later, Izumi is kneeling naked in front of you, looking decidedly flustered for someone who earlier tried to rape you.  She awkwardly hovers, red faced, as though unsure as to whether she’s allowed to cover herself - something you’re only too happy to leave her in the dark over.  It seems she can dish it out but can’t take it, biting her lip in impotent anger, refusing to meet your gaze as you look her over.\n\n");

			outputText("Physically, you have to admit, she’s not bad.  Her body was more or less on display as it was, given the scandalously provocative cut of her kimono, but now that she’s completely disrobed, you can’t help but take a moment to appreciate the sights.  Her breasts are full, rounded and firm, her stomach boasts a set of well-defined and clearly visible abs, her arms and thighs equally well built without crossing the line into disturbing bulkiness.  Perhaps predictably, she’s also completely lacking in any kind of underwear, her pussy crowned by the faintest downy wisp of gold.\n\n");

			outputText("Feeling emboldened by Izumi’s remarkably passive behaviour thus far, you slap her thighs until she grudgingly spreads her legs a little wider, then reach out to cop a feel.  Izumi’s head snaps around to glare at you, eyes narrowing as you press your hand exploratively into her crotch, but she makes no real attempt to stop you.  She’s hardly soaking wet, but you can’t help but notice a distinct warmth there.\n\n");

			outputText("“<i>Fine, you got me, I’m humiliated, okay? The big bad Oni can’t even stop you from fingering her, ha-ha-ha. Happy?</i>”  She scowls, before adding, “<i>So just go ahead and jerk your little cock off to the thought of fingering me, or whatever it is you’re gonna do, then let me </i>go<i> already.</i>”  You just smirk at her defiant attitude before pulling her forcibly towards a nearby wall by the horns.  She yowls in either pain or arousal, you honestly can’t tell which, while you enact the next stage of your plan.\n\n");

			outputText("You order her to raise her arms, still kneeling, and place her palms flat against the wall, stretching as widely as she can manage.  She stares daggers at you but acquiesces, clearly wondering exactly what it is you have planned next.  After that, you order her to spread her legs, slapping her thighs again for added emphasis.  It takes a lot less effort this time.\n\n");

			outputText("Finally, you lean in close to her ear, running your fingers up and down her horns, causing her to whimper and moan as she struggles to remain in her assigned position, and then you make her the offer: If she swears to do everything you want, you’ll let go of the horns - just this once.  But if she disobeys or makes any kind of move against you? You’ll torture that horns for hours, until she’s nothing but a snivelling, mind-broken wreck, wallowing in the cooling proof of her own shameless orgasms.\n\n");

			outputText("She goes very quiet for a moment, then practically spits out a “<i>Fine.</i>”  Grinning, you slowly, tentatively release your grip on her horns.  True to her word, she doesn’t budge, glaring at the wall so hard you’d think she was trying to bore a hole through it.  You give her a congratulatory pat on the butt for obeying so reliably as you return to your position behind her, Izumi turning her head to stare furiously as you unfasten your clothing...\n\n");

			// Small cocks
			if (player.biggestCockLength() <= 4)
			{
				outputText("There’s a moment of silence as you unveil yourself to the captive Oni, your [cock biggest] on full display.  She stares at your crotch blankly, then her eyes flick up to meet your own.\n\n");

				outputText("“<i>Are you serious?</i>”  She says, flatly.  “<i>You are, aren’t you?  You’re actually going to try and rape me with... </i>that.<i>  Seriously kid, I hate to break it to you, but most women prefer dicks they can actually, you know, feel. Or </i>see.”  You scowl at her in response and step up to her backside; she can talk trash all she wants for now, but she’s going to be the one begging for another taste of your dick by the end of the time you’re through with her.\n\n");

				outputText("However, once you’re in position, Izumi’s plentiful ass spread out before you, you can’t help but feel a little intimidated.  Was she always this big?  Well, at least you were already planning to use the tighter hole anyway.  You grip your meat in one hand and line up to enter her asshole, then plunge home, slipping easily into the warm, welcoming hole.  The penetration is so easy, in fact, that you’re able to slide all the way inside in a single stroke, your [hips] bumping against the soft cushion of Izumi’s buttcheeks.\n\n");

				outputText("“<i>Hm?</i>”  Izumi grunts, looking back over her shoulder.  “<i>Oh, so it’s actually in then?  Wonderful... be sure to tell me when you’re done.  I don’t think I’ll be able to tell.</i>”  She says, rolling her eyes and turning away.  You flush hotly, your wounded pride burning at the Oni girl’s dismissive attitude.  The worst part is, her words cut all the deeper because you have the sneaking suspicion she might be right.  She’s hardly loose, but you’re still able to move easily inside her, even though you’re buried to the hilt in her ass.\n\n");

				outputText("Angrily, you begin to thrust into her at high speed, pounding repeatedly into her buns with as much force as you can muster.  Unfortunately, owing to your less-than-stellar endowments, your strokes end up just being a succession of little gyrations, more a roll of the hips than a cycle of withdrawal and penetration.  The cave is completely silent apart from the quiet crackling of the fire and the soft, rapid clop-clop-clopping noise of your waist slapping into Izumi’s rear.\n\n");

				outputText("For some reason, that noise just adds to your growing sense of anger and inadequacy, as you realize that Izumi is still completely silent; the only sound is you humping against her, every slap reminding you that she is completely non-responsive.  And yet, you seem unable to stop - you feel like a rabbit, frantically thrusting away at some much larger animal.  The mental image is extremely upsetting.\n\n");

				outputText("Izumi sighs, sounding bored.  She’s being raped, dammit!  The least she could do is react!  Anger swells up within you, and then suddenly, an idea.  Reaching around the wide expanse of her hips, your hand snakes down to the cleft between those rippling thighs, searching for the larger woman’s clitoris, stroking, probing....\n\n");

				outputText("“<i>Don’t.</i>”  Izumi’s voice is flat and hard.  “<i>Don’t even bother, kid. The idea of you trying to make me cum from this is frankly embarrassing for both of us. Just face it; you’re not going to be seeing an Oni O-face any time soon, peewee.</i>”  You flush with embarrassment and shame again, withdrawing your hand and narrowing your eyes at the back of Izumi’s head.  The uppity bitch ignores you, staring pointedly at the wall, clearly wanting this to be over as quickly as possible. Her clear distaste for this gives you another idea....\n\n");

				outputText("<i>Smack!</i>  Izumi’s head jerks around, her expression thunderous, as the open palm slap hammers home onto her rump.\n\n");

				outputText("“<i>What the </i>hell<i> do you think you’re doing, kid?!</i>”  She bellows.  You grin happily at her, glad you’ve finally gotten her attention.\n\n");

				outputText("“<i>Tell me how big it is.</i>”  You command.\n\n");

				outputText("“<i>Wha-</i>”  Izumi opens her mouth to object, but is cut off by another blistering slap to the rump.  She winces in pain, then roars in outrage.  “<i>Why, you little piece of-</i>”  Another slap hammers home, cutting her off again.  “<i>Fine! Fine, I’ll- Fine.</i>”  She repeats, apparently more to calm herself down than to reassure you.  There’s a long, awkward pause as she glares off into the gloom of the cave.  You raise your hand again, threateningly, and she grimaces before finally responding.\n\n");

				outputText("“<i>It’s big,</i>” she spits.\n\n");

				outputText("“<i>How big?</i>” you ask, feeling pleased with yourself.\n\n");

				outputText("“<i>Fuck, I don’t-</i>”  You raise an eyebrow, your hand still raised threateningly above her reddening rump.  She glares at it for a moment.  “<i>Fine. I get it, already. It’s.. Really big, okay?  Huge.  Massive.</i>”  She growls.\n\n");

				outputText("“<i>Keep going.</i>”  You say, lowering your hand to caress her cheeks as you begin to thrust once again.\n\n");

				outputText("“<i>Yeah, keep going, I get it you little pervert...</i>”  Izumi grumbles under her breath, then speaks up, listing off your supposed amazing attributes in the same tone one might discuss the weather. “<i>You’re hung like a monster.  Okay?  I’ve never seen a dick as big and beautiful as yours.  It’s...</i>”  She grits her teeth.  “<i>It’s amazing. I’ve never felt this much pleasure from a single cock before. Uhn. Ahn.</i>”\n\n");

				outputText("The fake groans were a nice little touch, you think, pumping happily away at Izumi’s ring while she verbally fellates your imaginary megacock.  It seems that your new plan is working much better than the old one; if Izumi is going to shoot down your every attempt to make this pleasurable for her, you may as well get your jollies by humiliating her instead.  Occasionally you pull back a little too far and accidentally slip out, meaning she has to wait for a few seconds for you to awkwardly replace your cock, but that just seems to add to her discomfort and embarrassment - much to your amusement.\n\n");

				outputText("“<i>Ahhn.  Nooo.  If you keep this up, I’ll become your slave.</i>”  She sighs, her voice monotone.");
				if (player.cor >= 50) outputText("  You hate to admit it, but in a messed up way, her apathy is beginning to turn you on a bit by itself.  You knew you weren’t the most well-endowed adventurer in the first place, and to someone physically huge like Izumi the problem must be magnified.  For some reason, you find that idea hot as hell....\n\n");

				outputText("You lean forwards, layering yourself over the broad expanse of Izumi’s back as you reach forwards to grope and massage the vast globes of her tits.  Izumi growls and grumbles in annoyance, but makes no attempt to stop you.  Your questing fingers manage to locate her nipples, which harden swiftly under your tender caress.  You pinch and pull at them, teasing the sensitive nubs, indifferent to Izumi’s grunting protests.\n\n");

				outputText("From your new position draped lazily over her back, you’re free to pound your hips against the soft cushion of Izumi’s backside as though you really were a rabbit in heat, hunched over her and humping relentlessly away with a constant barrage of sharp, swift, and above all <i>short</i> strokes.  This time, though, you’re too lost in the heat of the moment to care, as a familiar tingling readiness spreads through you, the heat from Izumi’s body and the bizarrely arousing situation making up for the lack of stimulation from your clearly inadequate cock.\n\n");

				outputText("“Oh, getting close, huh?”  She snarls.  “You gonna blow already?  Not much for stamina either, are ya?  Ugh, just hurry up...”  You answer her with only a long, drawn out moan as your orgasm hits, burying yourself - for whatever that’s worth - balls deep in her ass as your first load boils free of your diminutive, spasming cocklet.");

				if (player.cumQ() >= 200)
				{
					outputText("In contrast to your disappointing erection, your orgasm is actually quite large; rope after steaming rope of hot, gooey cum jetting out from your undersized equipment, your clenching balls working overtime as though in futile defiance of your small size. If it were actually visible, the spectacle of your pathetically tiny cock disgorging such huge amounts of jizz would probably look positively absurd, firing out a load that seems quite impossible to have fit inside it in the first place.");
				}
				outputText("\n\n");

				outputText("“<i>Wait, that’s...?!</i>”  Izumi tenses, then half turns to look over her shoulder at you, an angry expression of absolute disbelief written across her face.  “<i>You’re </i>still inside?!<i> I thought you pulled out to do it on my back!</i>”  Izumi’s words barely even register as you grind your hips into her plowable buttocks, chasing the tail of your orgasm.\n\n");

				outputText("Finally, you stagger backwards, your diminutive penis already shrunk back to its unassuming flaccid state as you pull out of Izumi.  Her asshole shows no sign whatsoever of the punishing treatment it has just received, closing up effortlessly as though it had never opened.  Izumi stares at you for a moment, her expression torn between anger, confusion and disbelief.  She stands, turning towards you, opening her mouth and raising a warning finger, then stops.\n\n");

				outputText("“<i>No. You know what? No,</i>” She says, flatly.  “<i>This never happened.  This never happened, and we’re never going to mention it again.</i>”  She turns and marches stiffly over towards her tent, pausing on the threshold to whirl around and shoot one final passing rejoinder at you.  “<i>And for the love of whatever the hell it is you worship, if you’re going to try... That sort of thing again, find a way to grow something bigger than a peanut.  I mean, come on! At least that way I can have some fun too, yeesh!</i>”  She holds up a hand towards you, all fingers clenched into a fist aside from her half-extended pinkie.  She shoots a meaningful glare at it, then at you, then disappears inside her tent with a sulky “<i>Hmph!</i>”\n\n");

				outputText("Shrugging to yourself, you snatch up a purse full of gems from next to the Oni’s campfire - payment for the insult - then wander off back to camp.\n\n");
			}
			// Regular dicks
			else if (player.biggestCockLength() > 4 && player.biggestCockLength() <= 12)
			{
				outputText("“<i>Tch, I should have known...</i>”  Izumi grumbles.  “<i>Well, whatever.  Just just hurry up and blow your load before- H-Hey wait, what are you doing back there?!</i>”  She raises her voice in alarm as your intent becomes clear, lining your [cock biggest] up not with her obediently displayed pussy, but with her asshole.\n\n");

				outputText("“<i>Hey!  W-Who said you could use that hole?!</i>” she yells.  You just flash her a charming smile, then return to the much more interesting business of getting ready to fuck her ass raw.  She glares at you for a moment, then turns back to the wall with a snort.  “<i>Whatever.  I won’t lose,</i>”  she growls.\n\n");

				outputText("Ignoring her, you begin to force your aching erection into the tight hole below you.  It’s a surprisingly snug fit, given how huge Izumi is, something you’re only too happy to enjoy as you sink your turgid dick into her bowels.  Whether it’s because of her species or simply something to do with the muscles covering her frame you’re not sure, but as you slide inside of her, every inch of your cock seems to be being gripped by the Oni girl’s bountiful ass, massaged on all sides by coaxing, undulating muscle.  It’s simply too much to bear; with one powerful thrust, you bury yourself up to the [sheath], actually forcing Izumi to grunt in surprise and discomfort.\n\n");

				outputText("“<i>Oh, just going all the way");
				if(player.balls > 0) outputText(" balls");
				else outputText(" hilt");
				outputText("-deep right away, huh?  Fine, that’s fine, I can take this,</i>”  She mumbles through gritted teeth.  You chuckle at her futile whining as you pull almost all the way out, leaving just your [cockhead biggest] lodged within her, enjoying the pleasant tingling sensation as her ass mindlessly twitches and clenches around your sensitive flesh, then thrust in again, all the way down to the [sheath].  Izumi’s entire body clenches as you bottom out again, and to your mild amusement, this time there’s no backtalk.\n\n");

				outputText("You set up a steady rhythm, slowly drawing yourself out, holding it, giving her time to appreciate and anticipate what’s about to come, then burying yourself into her, pushing your hips forwards as hard as you can into the pillowy-soft cushioning of her buttocks.  Izumi seems to have lost her taste for rebellion already, her head turned to the wall, her breathing heavy as she struggles to endure the repeated anal violation.  \n\n");

				outputText("On a whim, you reach out with one hand to trace a line down Izumi’s spine, marvelling at the vast expanse of toned backflesh stretched out in front of you.  Your fingers’ feathery touch clearly has some kind of effect on the poor girl too, as she visibly shudders as you reach the small of her back.  Still hilted within her as deeply as you can go, you grope at her substantial butt with one hand, while the other dances little circles across her spine.  Finally, she snaps.\n\n");

				outputText("“<i>Will you cut that out?!  Stop trying to get all romantic or whatever, you....  Just stop it!  Okay?!  I thought you were meant to be </i>raping<i> me!?</i>”\n\n");

				outputText("Well, if she insists... reaching up, you grab a handful of her golden mane, wrap it around your fists and start to pound forwards with your hips, ramming yourself repeatedly home against Izumi’s plowable cheeks while jerking backwards on your newfound ‘reins’ for support.\n\n");

				outputText("Izumi coughs and splutters in surprise as your sudden onslaught hits her right as you also start yanking away at her hair, forcing her head upwards like some kind of perverse pony.  Her asshole tightens up around you too, clenching almost hellishly tight around your cock as you begin to make use of your new fucktoy’s dirty hole in earnest.\n\n");

				outputText("You can see beads of sweat beginning to form on Izumi’s bare flesh, hear her increasingly ragged breathing.  You brutally punish her anus, thumping home into her ring with repeated, almost painful impacts.  As intense and exhausting as your rutting is for you, it must be twice as bad for Izumi; her splayed fingers have long since clenched into fists, her knuckles white with the strain, clearly unwilling to give you the satisfaction of crying out.\n\n");

				outputText("But you get your satisfaction regardless, as you bury yourself as deeply as you possibly can into Izumi, impaling her ass with your cock as you finally start to blow your load, flooding her passageway with your steaming cum.  Izumi shudders, groaning at the feeling of your seed painting her innards a sticky, goopy white.\n\n");

				if (player.cumQ() < 1500)
				{
					outputText("You relax as your orgasms subsides, content that you’ve now thoroughly shown Izumi who’s the boss.  You slip free of her abused ass, a small trickle of cum dripping out after you, and you’re surprised to notice that Izumi seems to be a hell of a lot wetter than she was when you first started.  You raise an eyebrow at her as she stares backwards over her shoulder.\n\n");

					outputText("“<i>What?  It’s a natural thing, asshole,</i>” she snarls.  “<i>It’s not like I liked it. What kind of person would get off from that?  I’m not one of those freaks!</i>”  You shake your head at her in amusement, then motion for her to turn around and face the wall again.  She pales slightly, clearly worried you’re about to try for a second round, but quietly does as she’s told.\n\n");

					outputText("You don’t quite have the energy for that just now though, so instead, you pick up your clothes and make for the exit.  As you walk past Izumi’s discarded clothing, you spy a small pouch full of gems that you hadn’t noticed before.  You snatch that too, making a speedy escape before the Oni girl realizes she could probably make it to her feet before you got her horns by this point....\n\n");
				}
				else
				{
					outputText("But your spunk just keeps coming.  After a few seconds, Izumi seems to catch on, realising that for some reason your orgasm has not only not ended, it seems to be getting <i>stronger.</i>  Your jizz continues to blast free of your cock, still locked as deeply within her as you can manage, held there by a death-grip as you pump spurt after scalding spurt directly into Izumi’s bowels, ensuring that not a single drop of your precious seed escapes her slutty hole.\n\n");

					outputText("“<i>H-Hey, what... what’s going on!?</i>”  Izumi quavers as she looks back at you, visibly distressed.  “<i>Wh-What are you doing?  How come it won’t stop?!  I-Ngh!</i>”  She grabs at her stomach suddenly, and as she shifts in position you can actually see the flesh begin to bulge a little as you literally flood Izumi’s system with your semen.  “<i>T-Take it out!</i>”  She stammers.  “<i>It’s too much, make it stop!  Please!</i>”\n\n");

					outputText("But you refuse, holding yourself hilted inside her, still wrapped up in the throes of your extended orgasm to care a jot for Izumi’s panic.  She’s forced to simply wait, clutching her aching stomach and whimpering in confusion, until you decide that the sex is over.\n\n");

					outputText("When you finally do pull out, a positive avalanche of cum explodes after your cock, drenching the floor beneath you.  Izumi lets out a high-pitched keening squeak, dropping her face to the floor and raising her hips even higher into the air like some kind of animal as long spurts of your jizz erupt out of her anus like some sort of spooge enema.  Her eyes roll back into her head as she clenches her teeth against the feeling, clearly overwhelmed by what must be a decidedly unexpected and quite probably unique sensation.\n\n");

					outputText("You leave her there, half conscious in a pool of your still-steaming cum, knowing that there’s much more where that came from still bubbling away inside her.  As you walk past Izumi’s discarded clothing, you spy a small pouch full of gems that you hadn’t noticed before.  Snatching it up, you make your way back to camp, your spirits - and your balls - decidedly lighter.\n\n");
				}
				
			}
			// Urtadicks plz
			else
			{
				outputText("Her expression soon changes as you unveil your [cock biggest], however.  One look at your thickening meat is all it takes to evaporate the last of her bad attitude, replacing it with fear.\n\n");

				outputText("“<i>N-No way!</i>” she stammers.  “<i>That’s not real, right?!</i>”  You just grin, raising your hefty rod and slapping it down between her soft, pliable cheeks, taking the opportunity to run your hands over the contours of her ass.  You squeeze and grope her backside, enjoying the warm feeling of her bare skin rubbing against your rising erection as you rock your hips backwards and forwards in preparation.\n\n");

				outputText("“<i>Hey, c’mon now, seriously?  You want to do me with </i>that<i> thing?!</i>”  There’s undisguised panic in Izumi’s voice at this point.  You nod, enjoying a sense of complete role reversal.  Izumi stares at your bloated shaft nervously for a moment, then turns back to the wall with an involuntary little whimper.\n\n");

				outputText("You take this as a sign that it’s time to begin the main event, lining yourself up with Izumi’s asshole, much to her clear distress.  Slowly, you begin to push your [cockhead biggest] in, forcing aside the Oni girl’s sensitive ring to make way for your girthy invader.  Izumi whines as you force more and more of yourself into her, visibly tensing, until finally your entire cockhead slips inside.\n\n");

				outputText("“<i>O-Okay, now just... just wait a second,</i>”  Izumi pants, then yelps in surprise as you immediately begin to push in even deeper.  “<i>Hey, wait, wait I said!  I-It’s big, okay?!  I n-need time to get u-used to thiiiee!</i>”  Her protest trails off into a strangled squeak as another inch of your titanic member forces itself into her backside, followed by another, and another, and another.  Soon, you’ve actually gotten your entire length buried inside Izumi’s plump ass, panting with exertion and luxuriating in the sensation as you’re surrounded on all sides by the burning heat and vice-like tightness, the big woman’s anus gripping at you so hard that it’s actually quite a struggle when you finally begin to draw back and pull out again.\n\n");

				outputText("If the process is physically draining for you however, you can only imagine how it must feel for Izumi.  She leans against the rock wall in front of her, arms shaking with exertion, gasping for breath and shivering as you slowly withdraw your mighty pillar from her ass.  Your [cockhead biggest] reaches her ring once again, but you don’t pull out all the way, instead preparing yourself to thrust back inside her in earnest.  The besieged Oni looks back at your over her shoulder with a pleading expression, clearly defeated.\n\n");

				outputText("“<i>Come on, please!  I-I give, okay?</i>”  She almost looks like she’s on the verge of tears, although whether from the admission that she’s been beaten or from the anal invasion, you’re not quite sure.  Seeing that you don’t seem to be about to relent, she goes one step further; “<i>But I’m scared! What if it hurts?! Please be gentle, I’m only small!</i>” she wails.\n\n");

				outputText("<i>Small?</i>  You have to wonder exactly where she got that idea, but given that she looks legitimately upset, you decide to cut her a break.  Besides, you’re not sure you could even manage to get up to the speed you’d like, given how obnoxiously tight Izumi is turning out to be.  Instead, you start up a more leisurely pace, slowly pushing your hips forwards again and enjoying the sensation of being gently enveloped by Izumi’s tight, welcoming hole once again.  She shudders again, but this time it seems to be more out of relief than anything else.\n\n");

				outputText("“<i>Thanks...</i>” she sniffs gratefully as she turns back to the wall, apparently content to let you do as you will now that she’s not worried about you suddenly increasing your speed.  Given free reign, you’re able to shift your position somewhat to achieve a better angle as you slowly push down into her, enjoying a slightly deeper penetration as a result.  It’s not much, but as Izumi’s quivering ass-muscles massage your titanic girth on all sides, you’re more than happy to take it.\n\n");

				outputText("You keep up your measured pace for a few more minutes, luxuriating in the sensation of being so tightly engulfed by the cushiony softness of Izumi’s ass.  You grope and squeeze her plump backside as you slowly pump in and out of her, the pliant flesh rolling beneath your fingers as you explore Izumi’s curves.\n\n");

				outputText("Much to your surprise, after a while of this gentle, almost affectionate treatment, Izumi actually begins to rock her hips back against you.  The motion is ever so slight, but it’s definitely there. Not only that, but her pained grunting normalizes into a soft, breathy gasping.  Her hand slowly snakes down from its position pressed against the wall to run through her hair, clutching at great handfuls of the golden mane as her muscles reflexively clench and unclench.\n\n");

				outputText("“<i>It’s okay to... go a little faster,</i>”  Izumi mutters over her shoulder, her face beet red and with beads of sweat beginning to form on her brow. “<i>If you want, I mean.</i>”  That’s all the encouragement you need to try and pick up the pace.  Leaning forwards over Izumi’s rump, you redouble your efforts as you force yourself home with even greater vigour.  Just as you suspected however, the sheer tightness of the fit ensures that you’re not able to reach the kind of breakneck speed you’d prefer.  Still, there’s something to be said for this kind of thing as well; the feeling of having to really <i>force</i> yourself home every time, combined with the rippling effect caused by Izumi’s quivering muscles straining to accommodate your bulk, is an incredibly pleasurable experience.\n\n");

				outputText("Hilting yourself within her, you lean forwards and reach around under her armpits to grope at the pendulous breasts hanging beneath her.  Grinding your hips into hers as the two of you remain locked together in lewd congress, you run your hands over the Oni’s impressive bust, revelling in the feel of the soft flesh under your fingers.  Izumi bites her lip, clearly trying - and failing - not to enjoy the feeling of being so thoroughly stuffed with cock.  Her hand snakes down to slide over your own, gently drawing your questing hand up to her erect nipple.  Smirking to yourself, you reward her obedience by tweaking and squeezing the sensitive nub, causing Izumi to hiss in pleasure.\n\n");

				outputText("Drawing back your hips ever so slightly, you suddenly slam back into Izumi’s plowable butt.  You hump into her repeatedly, your backstroke only extending a few inches but each slapping impact causing Izumi to let out a tiny yelp regardless.  With these new, shorter strokes, you’re able to hit a much faster rhythm than you had before; the cave swiftly filling with the clop-clop-clop sound of your body slapping against Izumi like some kind of beast in rut.\n\n");

				outputText("“<i>Hey!  Hang on!  I mean, wait, n-no, you can’t- Nnngh!</i>”  Izumi gabbles helplessly as your rapid-fire thrusts combine with your assault on her breasts to overwhelm her defences.  She throws back her head and lets out a strangled squeak, her eyes roll back into her head, and suddenly you feel as though her entire body has just clamped down on your dick at once.\n\n");

				outputText("Locked in the throes of a powerful assgasm, the muscles in Izumi’s butt go crazy.  You can only grunt in surprise as they tighten around you like a snare, almost to the point of pain, ensuring you couldn’t possibly pull out even if you wanted to.  The undulating, rolling waves of muscle grip and massage across your entire length, spasming madly around you in an onslaught of sudden, violent sensation.\n\n");

				outputText("It feels as though you’ve been sealed inside some hellishly pleasurable trap and are now being milked for all you’re worth, and such a sudden change of pace after your previously slow and laborious fuck is just too much to bear.  After only a few moments, you let out a bestial roar as you cum too, flooding Izumi’s quaking frame with your seed.  The sudden rush of hot cum splashing against her innards only adds to her orgasm, extending the mad undulation of her ass - which in turn extends your own, achingly pleasurable release.\n\n");

				outputText("Finally, you can cum no more, and Izumi slumps down with fatigue as her orgasm subsides too.  You withdraw, with agonizing slowness, from Izumi’s slick and exhausted hole; it attempts to close up behind you, but it looks like it might take a while before she’s fully back to normal.\n\n");

				outputText("“<i>I’m just... going to stay here for a while,</i>”  Izumi mumbles drowsily, leaning against the wall. “<i>I, uh, don’t really feel like movin’ about too much right now.</i>”  She adds, looking absolutely exhausted.  Satisfied that she’s been thoroughly shown who’s the boss, you re-dress, feeling pretty tired yourself - and that’s when you notice the pouch sitting amongst Izumi’s discarded possessions.  Picking it up, you discover it to be full of gems; a fitting reward for your gentlemanly behaviour, you think.  \n\n");

				outputText("You turn to say something to Izumi, but to your surprise you discover she’s actually fallen asleep.  Shaking your head in amusement at the Oni girl’s inferior stamina, you make your way out of the cave and back to camp, counting the gems as you go. \n\n");
			}

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}

		// Huehue, Tentacruel!
		protected function tentacruelRevengeFux():void
		{
			clearOutput();

			outputText("You release your grip on Izumi’s horns, but only to reach down to remove your [armor].  As you open your clothing and unveil yourself, your [multicockdescriptlight] arch themselves like some kind of deadly snakes preparing to strike.  Izumi slips backwards in surprise, falling onto her rump.\n\n");

			outputText("“<i>H-Hey,</i>” She stammers, staring at your writhing crotch in a mixture of revulsion and fascination.  “<i>W-Why didn’t you leave some dicks for the rest of the class?!  Uh..</i>” If that was an attempt to distract you, it was sadly pointless.  Izumi yelps in what seems like actual fright as your tentacles surge forwards, snatching at her arms and legs, plunging down her neckline and <i>pulling</i>, causing her kimono to slip open and freeing her bountiful bust. \n\n");

			outputText("“<i>You’re weird!  You’re really weird!</i>” She yells, a note of panic entering her voice as she strains against your rampaging organs.  For a moment, you’re a bit worried she might actually break free of the tentacles wrapping her up - which would be, at the very least, <i>extremely painful</i> - but then you deploy your coup de grace maneuver. One of your prehensile tentacle-dicks slithers up Izumi’s grimacing face, rears back, then wraps itself completely around her horns in one seamless motion.\n\n");

			outputText("Izumi stiffens instantly, her eyes going wide and staring into nothing as she lets out a quiet, strangled squeak.  You can’t help but leer a little at the sight of the enormous woman, muscles quivering, completely at the mercy of your tender, tentacled ministrations.  You resolve to take your time a little and enjoy the sensation, as apparently so long as you keep your grip on Izumi’s horns, you have what can only be described as a captive audience.  And <i>speaking of</i> that horns....\n\n");

			outputText("Izumi’s eyes roll back into their sockets and she grits her teeth, grunting as your prehensile member flexes, tightening and loosening rhythmically around her horns.  It’s amazing, you think, how quickly Izumi’s attitude changed once you grabbed it.  The confident, domineering woman is completely gone, and instead she shivers nervously in your grip like a virgin on her wedding night.  Apparently, it’s an incredibly sensitive organ, a suspicion that is confirmed when you slowly begin to roll the tentacle wrapped around the horns up and down its length, causing Izumi to immediately let out a startled “Ah!” and flinch again at the sensation, straining against her bonds.\n\n");

			outputText("With a quick lurch, you pull Izumi’s legs up and apart, exposing her crotch and the vast expanse of her thighs to boot.  She wears no underwear, but frankly you’d probably be more surprised if she did.  She pants and grunts before you, the sweat from her body gleaming in the firelight with her unfastened kimono hanging dangerously from her breasts.  You lean in between her thighs as though to inspect her, causing her to suddenly flush crimson.  Or perhaps that was the sensation of another of your tentacled appendages slipping under the silky folds of her kimono to repeatedly flick at her nipple, already hardened by your treatment of her horns?  You may never know.\n\n");

			outputText("“<i>H-Hey!</i>”  Izumi suddenly pipes up, her voice filled with forced joviality.  She winces as you look up, the motion causing the tentacle wrapped around her horns to squirm and twist. “<i>I-I’ve got a great idea!  How about we call this one a draw?</i>”  You stare at her in disbelief, so she continues.  “<i>You did p-pretty damn good, so- Ah!  Uh, so how’s about you and me forget all about this and we just go make out in my tent?  H-How’s that sound?  I’ll even let you be on top!  How about it?!</i>”  There’s a distinct note of desperation in her voice by this point....\n\n");

			outputText("You have to admit though, the idea of fucking Izumi does have a certain appeal right now...  so you decide to do it.  Izumi’s eyes widen in realization as you flex your remaining appendages threateningly in preparation for the festivities, and she opens her mouth to object - something you put a stop to almost immediately.  She briefly goes slightly cross-eyed as you ram one of your plethora of cocks into her mouth, scowling in outrage at the oral invader.  For a moment you think she’s going to bite, but a swift squeeze from the tentacle still holding fast to her horns soon quells any thoughts of rebellion.\n\n");

			outputText("With the danger averted, you’re free to enjoy yourself and waste no time in enthusiastically beginning to fuck Izumi’s throat.  She gags and splutters around your invading member, the rumbling of her muffled, mumbling protests adding a fun extra degree of sensation to the facefuck.\n\n");

			outputText("You’re not satisfied just with that though, particularly when the main event is displayed so tantalizingly before you.  Raising yet another tentacle, you plunge forwards and force yourself into Izumi’s pussy, penetrating her fully.  Despite her increased size, she’s surprisingly tight, but you’re still able to comfortably push in deeper than you’d probably be able to with a smaller partner.  Izumi grunts and sways in the impromptu sling you’ve set up, rocking backwards and forwards as you pump into her from two different angles.  It’s an interesting experience to say the least, double-dicking an amazonian monster-woman while simultaneously ensuring she can’t fight back by molesting her magical horns.  For good measure, you give the horns another quick squeeze and roll the coiled tentacle wrapping it around a little, eliciting a high pitched squeal from Izumi, her entire body going momentarily tense.\n\n");

			outputText("When she relaxes, her face is completely flushed, her eyes looking distinctly fogged with arousal.  She isn’t struggling or resisting anymore; in fact, you realize, she’s even begun to roll her hips in time with your thrusts, helping you to penetrate her deeper, harder, stronger.  She seems to be functioning almost on automatic, stretching her neck forwards to accept more of your length as you thrust into her mouth, then twisting her head to the side as you pull out, stimulating more of your member than your previous thrusting.  Even her moaning seems quieter, more submissive, as though she’s accepted her role in the proceedings - or at least blocked out everything but the sensations she’s feeling enough to enjoy them.");
			if (player.tentacleCocks() >= 10 || player.stamenCocks() >= 10) outputText("  You decide to test the theory, snaking another prehensile appendage into each of her open, outstretched palms.  Sure enough, after a few fumbling attempts, Izumi manages to grasp the concept of a handjob and awkwardly starts to jerk them off.");

			outputText("\n\nRegardless, you’re still not finished.  After all, there’s still one hole left unaccounted for, and after all the trouble she’s given you, it hardly seems fair that she should just get to check out and enjoy the ride.  Izumi’s eyes widen as she feels your final tentacock slide between her buttcheeks, rubbing against the slick flesh, tracing an ominous ring around her hole before prodding demandingly at the entrance to her ass.\n\n");

			outputText("Then, without warning, you plunge in, hard.  Izumi screws one eye shut, wincing in shock, her whole body tensing again as she arches her back in a futile defence against the sudden anal intrusion.  Your flexible tentacle just follows her, however, ensuring there’s nowhere she can twist or turn to that will let her escape.  Before long you’re pumping away at her at full force again, your tentacles undulating madly as they repeatedly slip and slam into every single one of Izumi’s holes.  \n\n");

			outputText("You pound the burly muscle-girl relentlessly for some time, even dragging what feels suspiciously like an orgasm out of her enormous frame as she tightens around you and flexes in the cradle of your phallic appendages... but, all too soon, you feel your own orgasm approaching.  Determined to make the experience as memorable for Izumi as you possibly can, you quicken your pace, jackhammering into her furiously.  She squeals and squirms beneath you, the firelight gleaming off of her slick body and driving you to even greater heights.  With a final roar, you finally reach the crest of your orgasm and thrust yourself forwards one last time as you start to cum.\n\n");

			outputText("Izumi arches her back powerfully as you bury yourself deep inside each of her holes and begin to flood her with your thick, scalding spooge.  After filling her innards from as many angles as seem to be available, you pull out for a few more spurts, ensuring that you thoroughly coat Izumi’s face, her still-twitching ab muscles and the vast landscape of her bust.  For good measure, you finally release her horns, eliciting a decidedly girly whimper, and let your final tentacle release itself all over the rocky protrusion.  Izumi can only shiver and pant as you defile her horns on a whim, evidently completely exhausted at this point.\n\n");

			outputText("By the time your orgasm finally subsides, Izumi has been reduced to a cummy, sticky mess, laying on her back panting for breath, her entire body liberally coated with your seed.  Your tentacles snake out again, and her eyes widen slightly in fear, but she doesn’t need to worry; you’re just wiping yourself off on her hair, after all.  As she realizes that, she relaxes, apparently falling asleep.  With a smug smile, you redress and decide to take a poke around her camp for a while. \n\n");

			outputText("Amidst some miscellaneous junk that you cannot for the life of you figure out, you find a small pile of gems.  You help yourself to them as payment for the good time you just showed the uppity Oni, stow them safely away and wander back to camp, whistling happily to yourself.\n\n");

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}

		// Facefuck
		protected function sayThatsAPrettyFaceBeAShameIfSomebodyJizzedAllOverIt():void
		{
			clearOutput();

			outputText("An evil idea begins to form inside your head.  You give Izumi’s horns a quick yank, causing her to yelp out loud, flinching massively.\n\n");

			outputText("You direct her to kneel down with a growl.  Izumi opens her mouth to argue, then thinks better of it.  “<i>Okay! Okay, look, I’m cooperating.  Ha ha, you sure showed me, boy is my face re-Oh.</i>” She stops, eyes widening a little as you use your free hand to pull out [oneCock], stroking it towards hardness mere inches from her face.  She stares, mesmerized, as your hand rolls up and down your stiffening erection right in front of her.  \n\n");

			outputText("You smile, and on a whim, you decide to start stroking Izumi’s horns in the same way, matching stroke for stroke.  She flinches again and her hands reach up to grip weakly at your wrist.  “<i>Hands down!</i>” you bark, and they fall away instantly to rest on her knees, her hands clenching and unclenching repeatedly as she grits her teeth against the feeling of you rubbing at her horns.\n\n");

			outputText("Finally, you’re fully erect, Izumi’s occasionally-wincing gaze locked on the [cockhead biggest] of your [cock biggest], bobbing in the air in front of her.  Your smile widens into a leer as you put phase two of your ingenious plan into action.\n\n");

			outputText("“<i>Kiss it,</i>” you order. Izumi’s eyes flicker briefly to look up at your face, but by this point she knows better than to attempt disobedience.  Leaning hesitantly forwards, Izumi purses her lips as she moves in for the kiss.");

			var cockIndex:int = player.biggestCockIndex();

			if (player.cocks[cockIndex].cockType == CockTypesEnum.HORSE) outputText("  Visibly unsure of where to put herself, Izumi finally settles for brushing her lips against the exact center of the flared mass that makes up the head of your stallion-prick.");
			else if (player.cocks[cockIndex].cockType == CockTypesEnum.DOG) outputText("  Her eyes darting nervously from side to side, Izumi leans forwards and takes the very tip of your dogcock into her mouth, pressing her lips against the main bulk of what passes for your head.");
			else outputText("  You feel the soft, warm sensation of Izumi’s lips brushing against the sensitive head of your cock for a moment, then the process repeats itself as Izumi actually darts in again, unbidden, for a second smooch.");
			outputText("\n\n");

			outputText("Satisfied, you decide it’s time to move onto phase three.  Yanking hard on Izumi’s horns, you thrust your [hips] forwards at the same time, forcing your cock into her mouth.  She lets out a garbled yell of surprise as you slam into her throat, although you’re not sure if she’s more upset about the treatment of her mouth or her horns.  Regardless, it’s all the same to you; nothing more than a pleasant vibration....\n\n");

			outputText("“<i>Suck it!</i>” you command, as Izumi stares up at you with a pleading expression, tears beginning to form in the corners of her eyes due to lack of oxygen - or possibly just the rough treatment of her hyper-sensitive horns.  She lets out another whimper as you squeeze it, showing her what happens when she’s too slow, then she finally begins to work you over in earnest.\n\n");

			outputText("Her mouth latches onto you like a vacuum, sucking on your [cockHead biggest] so strongly it makes your knees weak, her tongue performing bizarre oral gymnastics around your cock.  You can only grunt in surprised appreciation; whatever else you might think about her, Izumi is <i>good</i> at this.  Or maybe she’s just desperate, trying to force you to cum as quickly as possible so that you’ll release her precious horns?  That seems distinctly possible, so you decide to take steps to counter it.\n\n");

			outputText("Yanking forwards on Izumi’s horns again, you pull her bodily down your length until you’re buried to the [sheath], swallowed up completely into Izumi’s tingling-hot mouth, her nose pressed up against your stomach.  She lets out another strangled, slightly frustrated cry, staring up at you in confusion.\n\n");

			outputText("You order her to stop, and you can see the confusion bloom in her eyes.\n\n");

			outputText("Izumi’s oral assault on your cock falters, awaiting your next move.  You simply stand there for a while, enjoying the feeling of having the brash Oni woman completely at your mercy...  and of course, forcing her to think about her situation as well.  How helpless she is, the thick meat filling her throat, her nose pressed deep in against you, every breath filling her lungs with your thick scent.  Idly, you begin to roll her head this way and that, using the poor Oni’s horns as a sort of joystick as you tilt her unresisting head to look at one side, then the other.\n\n");

			outputText("Satisfied that she’s had enough time to soak in the idea of being subservient and powerless, you get back to the business at hand; getting yourself off with the convenient aid of Izumi’s face.  You push her back, still gripping her horns as her lips slip free of your erection, leaving little trails of saliva dangling between your cock and her abused throat.\n\n");

			outputText("“<i>Wha-</i>” she stammers hazily, but you jerk her horns powerfully upwards, causing her face to freeze up in an agonized grimace as you force her down onto her back.  Repositioning yourself, you forcibly insert your cock once again into the warm, welcoming confines of Izumi’s throat.  Unfortunately, you still can’t really get into it from this angle, but then an idea hits you.  Still buried in Izumi’s mouth, you suddenly spin around to rest one leg on either side of her face - and causing Izumi to let out an incensed squeak as your [cock biggest] swirls around inside her mouth.  You lean back, grabbing her horns with a fresh hand before releasing the by now quite awkward grip you had before.\n\n");

			outputText("From this angle, you have a much better line of approach to Izumi’s throat, giving you a far deeper maximum thrust - something you happily take advantage of almost immediately in order to fuck Izumi’s mouth in earnest.");
			if (player.balls > 0) outputText("  As an amusing added bonus to your new angle, Izumi’s face actually provides a comfortable little platform for you to rest your [balls] on. You can’t help but smile when she lets out an aggravated little growl as your balls come to rest on her face for the first time, the warm air rushing in and out of her nose as she tries - and fails - not to breathe <i>too</i> deeply, providing a surprisingly pleasant sensation.\n\n");

			outputText("With your new position now secured, you get back to the task at hand with renewed vigour.  You slam into Izumi’s throat with gusto, causing her to cough and gag around your length, squirming in discomfort as you ride her face in your new, bizarre inverse-reverse-cowgirl position.  At the same time, you relentlessly tease her horns, running your hand across it, tweaking the tip, searching for the most sensitive spots - something that has a clear and noticeable effect on the poor Oni girl.\n\n");

			outputText("At first it’s pretty minor; a twitch here, a muffled yelp there, but before too long Izumi is visibly shaking, tears of exertion staining her face as her eyes roll back in her head and she, somewhat bizarrely, begins to randomly jerk and thrust her hips impotently toward a phantom lover.  Despite being incredibly strange, the sight is also somehow incredibly arousing.\n\n");

			outputText("Leaning back slightly to take a look at Izumi’s face, you’re surprised to see just how effective your treatment of her horns has turned out to be; her face is flushed bright red, her eyes screwed tight shut as the combination of horns-play and her difficulty breathing around your cock clouds her mind, leaving her hopelessly bouncing her hips, instinctively searching for the release of a penetration that will never come.\n\n");

			outputText("The sight of the bullish Oni girl reduced to mindlessly humping the air with your cock still buried deep inside her hot, clinging throat is just too much for you, though.  You feel the familiar sense of your orgasm rising and decide to make the most of it, returning your attention to Izumi’s throat and hammering into her with powerful strokes.  You manage to hit with one, two, three juddering impacts before your orgasm finally arrives, with gusto, and you bury yourself in the surprised Oni’s face, spraying your cum down her throat.");
			if (player.cumQ() > 500) outputText("  Her surprise only deepens when you simply keep cumming, your prolonged orgasm flooding her mouth faster than she can swallow, forcing her cheeks to bulge out and tiny rivulets of cum to occasionally slip free of the tight seal her lips have formed around your cock.\n\n");

			if (player.cumQ() > 100)
			{
				outputText("Her hips shoot up and <i>stay</i> up this time, her lips and tongue working on overdrive to milk your shuddering cock for as much of its thick, creamy goo as she possibly can.  At first you’re more than content to just stay hilted inside her mouth and enjoy the incredible sensations, but then another idea penetrates your lust-fogged brain.  Pulling free of Izumi’s mouth, despite her best efforts to the contrary, judging by how she latches onto you and starts suckling desperately like her life depended on it, you spin around, jerking your cock a few times to coax one final powerful explosion from your aching erection.\n\n");

				outputText("It goes exactly how you’d hoped it would, and you paint Izumi’s leonine features with your seed, laying thick ropes of jism across her face; lips, eyes, even her nose and horns.  The last couple of jets go a little wild, ending up landing in the tangled mess of her hair, spread out beneath her on the cave floor. You collapse, panting, into a seated position on Izumi’s breasts.  After a few seconds, and with some effort, Izumi manages to raise her head and you snap back to reality as you feel your cock once again enveloped in the heat of her mouth, drawn back inside for her to suck the last few drops of cum from your deflating member.\n\n");
			}

			outputText("Finally, it becomes apparent that you’re now completely done...  as is Izumi.  The two of you remain where you are, panting, for a few moments.  You’re the first to regain your feet, while Izumi burbles to herself, unable to even muster up the energy to even wipe her face.\n\n");

			outputText("“<i>Oh man, and I was so...</i>” she mutters, her hands clenching and unclenching just above her waist. Then she drags herself to her feet and stumbles away towards her tent, rubbing her forearm absently.  “<i>I uh, I gotta, gotta go do a thing for a sec...</i>” she mumbles, disappearing inside the tent.  For your part, you’re left completely alone, exhausted, inside the big woman’s cave.  You decide that now might be a good time to take your leave.\n\n");

			outputText("On the way out, you notice a small leather bag just laying out in the open.  Inspecting it, you discover it to be filled with a small fortune in gems!  You decide to take it with you - after all, it’s not like Izumi seems to need the money, plus she <i>did</i> try to rape you, so it’s technically a trophy.  Feeling decidedly more light hearted about your situation, you leave the cave and make your way back to camp, happily inspecting the gems as you go.\n\n");

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}

		// Nice horns, be a shame if somebody got it all sticky, huh?
		protected function tribThatRockyHornGirl():void
		{
			clearOutput();

			outputText("After listening to her request and offer of a bribe in exchange for letting her go unmolested, you respond by giving Izumi a sweet, innocent smile.\n\n");

			outputText("“<i>Ah, shit.</i>” She mutters, just before you push her to the ground, forcing her onto her back and swinging your leg over to straddle her chest.  She lets out a little ‘Oof!’ as you land.  You make a mental note to punish her for that, too; just what is she trying to imply, here?\n\n");

			outputText("“<i>H-Hey, listen!</i>” She stammers, wincing slightly as you run your hand exploratively over the rocky appendage protruding from her forehead. “<i>Y-You’re not really gonna do this, are you?! I mean, you’re a girl too, right? You’re not gonnauuwuugh come onnn...</i>” She trails off, twitching and shivering as you hit a particularly sensitive spot.  You can’t help but grin in anticipation as you slip out of your [armor], eyeing the horns lustily.  Izumi follows your gaze, initially failing to comprehend your intent, but then her face goes white and she grabs you by the wrist, desperately.\n\n");

			outputText("“<i>Wait!  Wait wait wait, you’re not thinking-?!</i>” She yammers.  “<i>You can’t!  You super can’t! Seriously, t-that’s dangerous!  You might hurt yourself, what are you thinking?!  And... a-and if you did that, I’d die!  I’ll really die!</i>”  To your intense surprise, she claps her hands together in front of her face and screws her eyes tight shut in fear, bowing her head in pleading submission.  “<i>Have mercy!</i>”\n\n");

			outputText("You can’t help but smirk in amusement at her misplaced terror as you realize what she thinks you’re planning to do.  Although the idea of totally overloading the big woman’s horns to see how she’d react is very tempting, you’re pretty sure forcing it inside yourself would be an incredibly bad idea; at the very least, if Izumi were to lose control of herself and start thrashing around... it is <i>close</i> to what you had in mind though.  \n\n");

			outputText("Extricating yourself from Izumi’s clutches, you scoot forwards, ignoring the whimpering girl below you.  You press your [vag] against her horns, causing her to shiver and let out a panicked whine, tensing up as she anticipates the onslaught to come.  Rather than try to pull the horns fully <i>into</i> you, however, you begin to roll your hips, grinding your dampening nethers against the uneven surface.\n\n");

			outputText("Izumi’s horns is covered in a myriad small bumps, faults and angles, causing you to let out an appreciative hiss or a surprised gasp whenever an unexpected ridge or lump rubs against your most sensitive parts.  Despite its bony, rocky appearance, Izumi’s horns is actually warm to the touch - a pleasant discovery, given that you were expecting it to be as cold and hard as the stone it resembles.  Judging by the sounds coming from beneath you, it would appear that Izumi has already been reduced to a quivering wreck, unable to do anything but stammer out a long series of croaking, staccato “A-a-aa-a-a” noises.  In a strange way, her helplessness is actually kind of cute.\n\n");

			outputText("You have other concerns on your mind just now though, as you’re really beginning to enjoy your new toy.  You roll your [hips] with ever-increasing force, mashing your [vagina] into the slickening protrusion as you use Izumi’s horns to grind yourself closer and closer to your encroaching orgasm.  You grip the horns even tighter, eliciting a high-pitched whine from Izumi as you press it into your crotch as hard as you can manage, rubbing yourself onto it with even greater ferocity, your juices beginning to flow in earnest, trickling down onto Izumi’s face as you ride her face, relentlessly tribbing yourself towards climax.\n\n");

			outputText("Dimly, you feel Izumi shift under you, followed by a quiet, breathy grunt.  Izumi’s breathing also changes, becoming less the panicky, stressed out hyperventilating you’ve grown accustomed to, and more an awkward, rhythmic panting.  Casting a glance over your shoulder, it would appear that Izumi still has her eyes clamped shut.  Somewhat more interestingly, however, one musclebound arm has managed to raise itself from her side to slip between her legs, disappearing under the skimpy folds of her kimono.  Her other hand grips the first weakly at the wrist, alternately clenching as you hit a particularly sensitive spot or awkwardly rubbing her forearm as she stealthily masturbates - it seems your self-indulgent play has turned her on almost as much as you.\n\n");

			outputText("You let out an amused laugh.  You have to admit, it’s pretty funny that the big bad muscle-girl couldn’t manage to control herself even while she’s technically being raped.\n\n");

			outputText("“<i>Having fun?</i>”  You ask, smiling to yourself.  Izumi’s eyes snap open, her face turning an even deeper shade of crimson than before as her eyes flicker down to her crotch.  Poor girl, you think; she might not even have fully realized what she was doing.  Well, she does now...\n\n");

			outputText("“<i>I-It’s... it’s not... s-shut up!</i>” She stammers, adding “<i>It’s not my f-fault if you keep t-touching me in weird places and I get... distracted!  </i>You’re<i> the perverted one here, not me!</i>”\n\n");

			if (player.cor > 80) outputText("“<i>Whatever.  Just try not to cum too hard while I’m making you my bitch, you little slut.</i>” You shoot back, returning");
			else outputText("Ignoring her protests entirely, you return");
			outputText(" your attention to her horns.  Still though, there’s something missing; as fun as it is molesting and toying with the oversized lout currently protesting her innocence while buried up to the knuckle in her own cunt, you’re not quite feeling it enough to get off yourself.  Clearly, that has to change.\n\n");

			outputText("Experimentally, you shift position, leaning back to expose more of your crotch to the wonderful warm, bumpy sensations running through it, supporting your weight with one arm wrapped around the long-suffering Oni’s horns.  That’s <i>much</i> better you think, as you rock bodily back and forth, running yourself across the entire rugged length of the curved protrusion, biting your lip as an errant crag scrapes deliciously across your [clit]. The act sends a searing shiver down your spine, along with a growing, scandalous desire to revisit the sensation.  \n\n");

			outputText("With increasing urgency, you frig yourself in earnest on Izumi’s horns, her muted sounds of protest rising in pitch and desperation along with the power of your strokes.  You sense her hips rising behind you as she begins to lose her inhibitions once again in the face of your unflinching assault, slapping away shamelessly at her pussy - which, by the sounds of it, must be absolutely dripping wet by now - two enormous fingers ramming themselves repeatedly home with brutal force.\n\n");

			outputText("The thought of the once proud Oni now being reduced to such desperate and wanton masturbation by the idea of being made into your toy makes you want to laugh again, but more than that, it’s somehow incredibly arousing.  You’re not sure which you’d prefer more; to find out that she has a hidden submissive streak and that she’s totally into this kind of thing... or that she <i>isn’t.</i>\n\n");

			outputText("Regardless, any further experimentation will have to wait, as before you know it your orgasm is upon you.  Clutching at Izumi’s horns, you ram yourself home one final time, almost as though punishing your wanton pussy by slamming it against the hard surface.  Beneath you, Izumi bucks and jerks, letting out a high and surprisingly girlish wail as you orgasm around her horns, your juices splattering down to cover her face, her horns, your increasingly numb-feeling hand....\n\n");

			outputText("With a final thump, Izumi’s hips drop back down to the ground, her arms flopping uselessly to her side.  After a moment or two of mutual, panting recover, you unsteadily step off of her and scratch at your head, as the aftermath of your orgasm begins to subside.  For her part, Izumi lays flat on her back, unmoving, her eyes glassy and unfocused, breathing as though she had just run a marathon.  Between her legs, you can dimly make out an unmistakable damp streak, glistening across the cave floor in the darkness.  You smirk at the sight, deciding to add one final little insult to the proceedings.\n\n");

			outputText("“<i>You came, didn’t you?</i>” You ask, sweetly.  Izumi trembles a little, her eyes rolling over to you.  She seems to be having trouble focusing.\n\n");

			outputText("“<i>..’es,</i>”  She croaks, almost inaudibly.  She sounds as though she’s on the verge of tears, presumably from embarrassment - you’re pretty certain you haven’t actually done anything that could hurt her.  You shake your head, chuckling to yourself as you redress and rummage through Izumi’s belongings for a trophy.\n\n");

			outputText("“<i>I’m taking this,</i>” You announce cheerfully, hefting a small bag of gems in one hand.  “<i>‘Kay.</i>” Izumi’s approval doesn’t matter to you either way, but your smile widens at her submissive, exhausted tone.\n\n");

			outputText("By the time you get back to camp, you’re almost feeling good enough to whistle.");

			player.sexReward("Default","Default",true,false);
			cleanupAfterCombat();
		}
	}
}
