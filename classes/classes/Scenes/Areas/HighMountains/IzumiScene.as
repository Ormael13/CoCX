package classes.Scenes.Areas.HighMountains 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
	
	/**
	 * Izumi, the fuckhuge Oni. TOUCH THE FLUFFY HORN.
	 * 
	 * @author FeatureCreep
	 * @editor Gedan
	 * @programmer Gedan
	 */
	public class IzumiScene extends BaseContent
	{
		public function IzumiScene() 
		{
		}
		
		/**
		 * Support Functions
		 */

		// Return a height-based nickname for the player
		public function heightDesc():String
		{
			if (rand(4) == 0) return "kid";
			else
			{
				if (player.tallness < 60) return "pint-size";
				if (player.tallness < 72) return "short-stuff";
				if (player.tallness < 84) return "shorty";
				if (player.tallness < 96) return "kid";
				else return player.short;
			}
		}

		// Bundle of logic to determine if a player might "act" like a minotaur, based off of a couple of related statusAffects
		public function actsLikeACow():Boolean
		{
			if (kGAMECLASS.player.hasStatusAffect("heat")) return true;
			if (kGAMECLASS.player.hasStatusAffect("rut")) return true;
			if (kGAMECLASS.player.hasStatusAffect("dysfunction")) return true;
			return false;
		}

		// Placeholder shit so I can compile
		public function pcBeatIzumiIntro():void
		{
			trace("placeholder");
		}
		
		public function izumiTitsmotherIntro():void
		{
			trace("placeholder");
		}
		
		public function izumiBeatPCIntro():void
		{
			trace("placeholder");
		}
	
		
		/**
		 * Introduction/Entry Scenes
		 */

		// Entry point from HighMountain explores
		public function encounter():void
		{
			if (flags[kFLAGS.IZUMI_MET] == 0)
			{
				outputText("As you wander the wasted landscape searching for anything of interest, you come across a large rock blocking what appears to be the entrance to a cave.  Wondering about how to best get around it, you suddenly become aware of a strange sound on the edge of your hearing.\n\n");

				outputText("Flattening yourself against the stone in case of danger, you strain your ears and scan the horizon, searching for the source of the noise.  The volume gradually increases, and eventually you realise what it is that you’re hearing; someone nearby is loudly humming, a lively tune echoing off the rocks and cliffs.  As best you can tell, it seems to be coming from the other side of the enormous stone blocking your path.\n\n");
 
				outputText("Your curiosity piqued, you search around the obstruction for a way inside, and finally manage to find a slim gap between the bottom of the rock and the cliff face.  Kneeling down, you peer inside and can make out the distinct glowing embers of a campfire.  You’re pretty sure you can make it inside, but it might be difficult to get away if danger threatens.  On the other hand, wild animals don’t light campfires, and a lust-crazed demon probably wouldn’t bother to hide itself so effectively....\n\n");

				menu();
				addButton(0, "Enter", enterFirstTime);
				addButton(1, "Leave", abortabortleavethefukkencave);
			}
			else
			{
				outputText("As you wander the wasted landscape searching for anything of interest, you find yourself face to face with a familiar large boulder; the same one hiding the entrance to Izumi’s cave.  Once again, you become aware of a strange sound on the edge of your hearing.  Carefully positioning yourself at the gap between the boulder and the cave entrance, you turn your ear to the source of the noise and manage to pick out what it is that you’re hearing; somebody is loudly humming, the same lively tune you heard during your previous visit.\n\n");

				outputText("Considering how your last visit to the cave ended, you hesitate for a moment and wonder if you should push forward to enter Izumi’s home... or if turning back to camp would be a wiser decision.\n\n");

				menu();
				addButton(0, "Enter", enterAfterMet);
				addButton(1, "Leave", nopeLeavePlz);
			}
		}
		
		// Repeat encounters with Izumi after having met in the past
		public function enterAfterMet():void
		{
			clearOutput();

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

					outputText("“<i>So, uh...</i>”  She begins.  Then she scowls, blushing slightly.  “<i>So, you came back to apologize, right?  You damn well better have!  In fact, I’m not forgiving you until I’ve made you feel as humiliated as I did, so just give in already, okay?!</i>”\n\n");
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

			outputText("Spelunking in random caves around these parts is probably not the best idea; especially considering the kinds of creatures that you keep tripping over whenever you <i>do</i> decide to poke your nose somewhere it doesn't belong.");
			doNext(13);
		}

		// Already met, dun wanna get oniraepd again plz
		protected function nopeLeavePlz():void
		{
			clearOutput();

			outputText("You decide discretion is the better part of valour and choose not to barge into the strange womans cave again, opting to slip away before she notices you hanging around outside her home.");
			doNext(13);
		}

		// Introduce the fuckhuge oni
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
				outputText("The humming stops almost instantly, and moments later a hand suddenly rests itself on the rock in front of you.  Looking up from your exertions, you find yourself face to face with a woman.  It takes a moment, but then you realise, you really are actually face to face with her - she’s as tall as you are!");

				// Catch logic shit that we just broke
				if (player.str < 75)
				{
					outputText("  She gives the boulder a shove - with just one hand - and it starts to give, scraping across the uneven ground.\n\n");
				}

				outputText("The woman stares at you in suspicion for a moment, giving you the opportunity to study her in return.  She wears a silken kimono, embroidered with stars, dragons and flowers, which you can’t help but notice is of a truly scandalous cut – your eye is inevitably drawn to her enormous breasts, bulging dangerously against the fabric as though straining to escape.  If she were human-sized and remained in proportion, they would probably be around a DD, but at her size, you honestly have no idea.  Not only is she just as tall as you, she’s pretty built physically as well, at least from what you can see of her thighs and arms thanks to her figure-hugging outfit.\n\n");

				outputText("When you finally manage to drag your eyes back to her face, her expression is quite different. Instead of suspicion, she treats you to a sly smile.\n\n");

				outputText("“<i>Well now,</i>” she drawls in a syrupy, seductive tone, twirling an errant lock of her hair thoughtfully in her fingers.  “<i>You’re a </i>big<i> one, aren’t you?  And here you are, [if (player.str >= 75)forcing|trying to force] your way through little Izumi’s door uninvited.  I’d tell you off, but I’ve got to admit, I don’t get many visitors of your... </i>stature.<i>");
				if (player.hornType != HORNS_COW_MINOTAUR)
				{
					outputText("  Or at least, ones without a pair of bulls horns ");
					if (this.actsLikeACow == true)
					{
						outputText("- and the temperament to match - ");
					}
					else
					{
						outputText(", ");
					}
				}
				else
				{
					if (this.actsLikeACow == true)
					{
						outputText("Or at least, ones without the temperament to match the... physique, ")
					}
				}
				outputText("if you follow?</i>”\n\n");

				outputText("She turns and heads back into the cave, quickly disappearing into the gloom,  the strange woman motioning you to follower her inside with a wave.  You creep slowly into the cave, your sight gradually adapting to the darkness.\n\n");
			}
			// "short" variant
			else
			{
				outputText("You squeeze through the gap, entering the cave.  Almost immediately, a palpable wave of heat rushes over you, sweat already starting to bead on your brow; it’s <i>stuffy</i> in here!\n\n");
			}

			outputText("Now that you’ve made it inside, you can see that the cave is dimly lit by two burning braziers on either side of what appears to be a large tent of some sort.  In front of the tent, the fire smolders gently.  It’s difficult to make out details, as the lighting is pretty poor, wreathing everything in strange, dancing shadows.  To make matters worse, the entire place is permeated by a thick veil of smoke that makes your eyes sting [if (toughness <= 75)and of course, that obnoxiously endurance-sapping heat].\n\n");

			if (player.tallness < 108)
			{
				outputText("You can still hear the humming, but at first, there doesn’t seem to be anyone around.  You creep closer to the tent, until suddenly, a huge shadow at the front of the tent shifts.  You freeze, straining your eyes through the darkness, as you suddenly realise that’s not a shadow at all - It’s an enormous figure!  You must have gasped, as without warning the humming stops.\n\n");

				outputText("“<i>Hm?</i>” the shadow grunts, then speaks.  “<i>Oh?  Now how did you find your way in here, I wonder?</i>”  The voice is deep, rich and undeniably female, but has a gravelly edge to it like a cross between magma and molten chocolate.  You hear the hiss of indrawn breath and a small light flares up briefly in the darkness, then the shadow speaks again.  “<i>Well, whatever. It’s been awhile since I had company, ");

				if (player.minoScore() > 3) outputText("plus it looks like you're thinking with the head on top of your neck, rather than the head between your legs, unlike the the stupid brutes who usually wander around these parts.  ");
				else if (player.dogScore() > 3) outputText("plus it looks like you'd actually be able to resist chasing down a stick, if I threw one outta' the cave.  ");
				else if (player.goblinScore() > 3) putputText("plus you don't seem to be as insufferable as the rest of those little green whores who trollop around these parts, hunting their next lay.  ");
				else if (player.demonScore() > 3) outputText("plus you're not forever going on about corruption this, enslavement that, demonic taint the other, unlike the insufferable clods who usually wander around these parts.  ");
				else if (player.harpyScore() > 3) outputText("plus you're not screeching incessantly, like the feathery sluts who usually flap their way around these parts.  They're lucky they </i>can<i> fly, 'cause I'd give them something to really squawk about if I could get my hands on them.  ");
				else if (player.lizardScore() > 3) outputText("plus, you don't have the same creepy eyes that the scaley idiots from around these parts keep trying to use on me.  ");
				else outputText("plus you don’t look like the troglodytes who usually wander around these parts.  ");
				outputText("Sit down, sit down!</i>”\n\n");
			}

			outputText("Cautiously, you edge towards the lip of the fire, and [if (player.tallness >= 108)a|the] shadow leans forward, finally becoming visible.  [if (pc.tallness < 108)For a moment, you’re stunned into silence; the figure looks completely human, aside from two important factors.  The first, her size; she looks as though someone had tried to build a human but got the scale wrong.  By the looks of her, if she was standing upright she would tower at least around eight or nine feet in height, and she looks broad enough to carry a horse on her back.|With the opportunity to finally study the strange woman in detail, you’re stunned into silence.  She looks completely human, aside from two important factors.  The first, her size; she looks as though someone had tried to build a human but got the scale wrong.  A fact you’re made aware of every time you venture from camp; it’s not every day you meet somebody just as tall as yourself.]  The second factor, of course, would be the enormous curved horn of red, rock-like bone that juts proudly from her forehead.  Still, they’re no less inhuman than some of the other creatures you’ve encountered since arriving....\n\n");

			outputText("“<i>Hmm?</i>”  She looks blankly at you.  The sudden realisation that you’ve been staring at her horn for an uncomfortably long time hits you.  “<i>What?  Is there something on my face?</i>”  Blushing, you open your mouth to answer, but as you breathe in, a rush of coarse smoke down your throat [if (player.tou < 60) causes you to cough and splutter.|momentarily steals your voice, having been ill-prepared for the sudden burn.]  The strange woman blinks at you in confusion for a moment, then her face cracks into a grin.  “<i>Oh, right, I forgot people like you tend to be pretty fragile.  Hold on [if (player.tou < 60) , kid .  Let | , let ] me get some air in here for you...</i>” She launches herself to her feet with surprising speed and breezes past you.\n\n");

			outputText("Still [if (player.tou < 60)struggling with|distracted by] the smoke, you turn to see her, only barely through the gloom, at the boulder blocking entry to the cave.  [if (player.str <= 75) To your amazement, the boulder begins to move, and as more light - along with a much-needed rush of fresh air - floods into the smoky cavern, you see she’s actually rolling it aside with her <i>bare hands</i>.  Even given her great size, this woman’s strength must be immense!|The boulder begins to move, and as more light - along with a welcome rush of fresh air - floods into the smoky cavern, you see she’s rolling it aside with nothing more than her bare hands with graceful, if unnerving, ease.]\n\n");
			
			outputText("Finally, the boulder is pushed far enough that about half of the cave mouth is now open to the air. It’s still dark, but at least now you are able to see well enough to make out actual details as the woman strides casually back to you to retake her seat.  She smiles again, her features broad and honest, framed by an enormous chaotic mass of shaggy golden hair, looking for all the world like the mane of some great lion.\n\n");
			
			// Catch describing her in detail to short players
			outputText("[if (player.tallness) < 108) She wears a silken kimono, embroidered with stars, dragons and flowers, which you can’t help but notice is of a truly scandalous cut – your eye is inevitably drawn to her enormous breasts, bulging dangerously against the fabric as though straining to escape.  If she were human-sized and remained in proportion, they would probably be around a DD, but at her size, you honestly have no idea.]\n\n");
			
			outputText("She sits, right knee raised so she can rest her arm on it, her left foot tucked behind the right.  As she does so, her kimono slides aside, [if (player.cor <= 33) exposing an uncomfortable amount of creamy-white thigh flesh. | if (player.cor > 33 && player.cor < 66) exposing a tantalising view of creamy-white thigh flesh.|[if (player.cor >= 66) exposing a delicious view of her thigh, the creamy-white flesh almost screaming out for your caresses.]  If she notices, then she doesn’t seem to care.\n\n");
			
			outputText("“<i>Better, right?</i>”  She asks, and you nod.  “<i>Sorry, I didn’t realise the smoke was getting to you at first.  It’s been awhile since I’ve seen anything but a minotaur or a demon, at least ones that seem more interested in polite conversation than reaming everything in sight.</i>”  She grimaces, briefly.  “<i>So, what’s your story, "+ this.heightDesc() +"?</i>”  Whoever she is, she seems friendly enough [if (player.tallness <= 96)- if a little... imposing -|,] so you give her your name, and hesitant to discuss your true quest in depth, detail some of your past encounters in this strange world.  Nodding encouragingly, she raises a long, elaborately carved pipe to her lips, puffing away as you tell your story....\n\n");
			
			outputText("“<i>Oh, so you’re the heroic type, yeah?  So, I guess it’s my turn now, huh?</i>” She sighs and closes her eyes, reclining and crossing her legs.  You can’t help but notice the way her kimono slithers around her legs, mere inches from becoming truly indecent, nor the way her breasts threaten to burst free of their confinement as she stretches.\n\n");
			
			outputText("“<i>Ah, but where to begin?  My clan calls me ‘Izumi, <b>The Font Of All Strength’</b>.</i>”  She snorts in amusement at your reaction to her name.  “<i>I know, it’s a little pompous, right?  Just use Izumi, I always do.  Either way, I’m a traveller from another world.");

			if (player.humanScore() > 3)
			{
				outputText("  I’ve met humans before a few times.  Back home, my people like to play games with them to see how they’ll react; show up, scare the locals, steal a sheep and run off giggling to yourself, that kind of thing.  Sometimes one of them is actually brave enough to come after us.  Sometimes we even slap ‘em on the back, give ‘em the sheep and then drink them under the table.</i>” \n\n");
			
				outputText("She takes a long, powerful drag on her pipe, her lips locked tight around the mouthpiece.  “<i>It was fun for a while, but bothering goatherds for the next thousand years wasn’t my scene, frankly, so I left.  Bailed.  Disappeared.");
			}

			outputText("  I didn’t come here to fight demons or any of that nonsense, though.  I’m just looking for something <b>fun</b> to do, you know?  Something to keep my interest for a while.</i>”  She opens her eyes again, two enormous amber irises staring thoughtfully down at you.  For some reason, you find something very uncomfortable about her gaze... [if (player.str <= 75 || player.tallness < 96)You can’t help but feel like a sheep yourself - one who’s just noticed the wolf is staring it down.]\n\n");
			
			outputText("“<i>My mistake coming here, though.  There’s no conversationalists, no challenges, nothing fun. The only other conversations I’ve had since coming here have all gone more or less the same way, you know?  ‘Harharhar, I shall turn you into my slave!  How dare you pick me up, I shall destroy you!  Why are we heading towards that cliff!’  and so on.</i>”  You laugh at the idea despite yourself.\n\n");
			
			outputText("Izumi seems singularly unperturbed by the sex-mad nature of this world, an attitude you find oddly refreshing.  There’s something about her; she seems to exude an aura of steady, unconcerned confidence from every movement, dripping from each word she speaks.  It’s a difficult thought to articulate, but the enormous woman’s lazy smile and relaxed attitude seem... infectious.\n\n");
			
			outputText("You talk animatedly with Izumi some more over the next hour or so, inquiring about the horn on her forehead, what life is like where she comes from, how she came to be here and a dozen other topics.  She explains that all of her race, the Oni, have horns that reflect their power and strength.  For her part, she asks a myriad questions about you and your home world.  When you ask about the pipe she’s smoking, she surprises you by wordlessly handing it to you.\n\n");

			menu():
			addButton(0, "Smoke", smokeThePipe);
			addButton(1, "NoSmoke", dontSmokeThePipe);
		}

		// Set some shit up for the Pipesmoke scene during the introduction
		private const SMOKE_SPEED_REDUCE:int = 5;
		private const SMOKE_SENS_BOOST:int = 5;
		private const SMOKE_DURATION:int = 24;

		// Applies the smokeeffect to a player, based on if they used the pipe directly or not
		protected function smokeEffect(smokedPipe:boolean):void
		{
			var deltaSpd:int = (SMOKE_SPEED_REDUCE + player.spd) - 100;
			var deltaSns:int = (SMOKE_SENS_BOOST + player.sens) - 100;
			var lustMod:int = 7;

			// Double effect for directly smokin da pipe
			if (smokedPipe)
			{
				deltaSpd *= 2;
				deltaSns *= 2;
				lustMod *= 2;
			}

			player.createStatusAffect("Izumis Pipe Smoke", SMOKE_DURATION, deltaSpd, deltaSns, 0);
			dynStats("spd-", deltaSpd, "sen", deltaSns, "lus", lustMod);
		}

		// Per-hour update decimation of the timer, removal etc
		public function smokeEffectUpdate():void
		{
			var affectIndex:int = player.hasStatusAffect("Izumis Pipe Smoke");

			if (affectIndex >= 0)
			{
				player.statusAffects[affectIndex].value1 -= 1;

				if (player.statusAffects[affectIndex].value1 == 0)
				{
					this.smokeEffectWearsOff();
				}
			}
		}

		// Method to contain removal mechanics + scene text to spit out
		protected function smokeEffectWearsOff():void
		{
			var affectIndex:int = player.hasStatusAffect("Izumis Pipe Smoke");

			if (affectIndex >= 0)
			{
				dynStats("sen", player.statusAffects[affectIndex].value2, "spd", player.statusAffects[affectIndex].value3);
				// TODO mangle some scene text or something similar to the timed Uma effects
			}
		}

		// Actual introduction scene content for pipesmokin
		protected function smokeThePipe():void
		{
			clearOutput();

			outputText("Whatever it is she has in there, the smoke is thick and cloying and even the smallest puff makes [if(player.tou <= 60)you cough and splutter|[if(player.tou < 75) you flinch, holding back a cough|your eyes water]] - much to your mutual amusement.  You talk and joke for a while longer, the smoke making you feel incredibly relaxed, as though all the tension were simply melting from your body.  [if (player.tou <= 80) After a while, you find it hard to even raise your arms to reach for the pipe again.]\n\n");
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

			outputText("You hear Izumi let out a quiet giggle.  Looking up, you see she’s shifted closer to you, edging right up to the fire.  She makes a show of appraising you physically, her golden-amber eyes sparkling in the dancing firelight as her gaze roams over your body, from head to [foot].  [if (player.str <= 75 || player.tou <= 75 || player.tallness <= 96)You swallow, hard, suddenly feeling oddly nervous.]  She’s even larger up close, and you can clearly see the solid, capable looking muscle that makes up her frame....\n\n");

			if (player.tallness < 108)
			{
				outputText("“<i>You know, you’re pretty cute.  Did I already say that?  Well even if I did, it’s true.  I like brave people.  I like people who challenge themselves.  You’re pretty brave, surviving in a place like this all alone, you know?</i>”  Without warning, she leans forwards over the dying fire, the ruddy light from the coals illuminates her face from below, giving her a decidedly sinister air.\n\n");

				outputText("“<i>I think it’s about time you repaid me for my hospitality.</i>”  She says, her eyes glittering dangerously in the firelight.  “<i>After all, you came into my camp uninvited... that’s pretty rude, you know?  I think I might take offence to that.</i>”  As she speaks, she slinks closer to you on all fours like some kind of predatory cat, about to make the final killing leap upon it’s helpless prey... Her personality has changed completely from the gentle giant you were speaking with a second ago.  You suddenly wonder if perhaps the smoke is somehow affecting her.\n\n");

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

		/**
		 * SURRENDER SCENES
		 */
		protected function surrenderSelector():void
		{
			flags[kFLAGS.IZUMI_TIMES_SUBMITTED]++;
			flags[kFLAGS.IZUMI_LAST_ENCOUNTER] = 1;
			flags[kFLAGS.IZUMI_SEEN_PC_GENDER] = player.gender;
			clearOutput();

			// Male/Herms
			if (player.hasCock())
			{
				outputText("You swallow your pride and shake your head, signalling Izumi that you don’t intend to resist.  Her face splits into a truly lascivious grin and she licks her lips, hungrily.\n\n");

				outputText("“<i>Yeah, that’s what I thought.</i>”  She smirks.  “<i>You just do exactly what I say, when I say, and nothing bad will happen to you.  Well... Nothing <i>too</i> bad, anyway.</i>”\n\n");

				outputText("Suddenly, she lunges forwards, one enormous hand planting itself onto your [if (player.isATaur == true)flank and forcing you sideways onto the ground.|chest and forcing you backwards onto the ground.]  You grunt from the impact and try to sit up, but Izumi easily restrains you with a single well-muscled arm.  “<i>Well now, let’s see what we’re workin’ with here, shall we?</i>”  She announces casually, as she pulls aside your [armor] to reveal your cock.\n\n");

				if (player.biggestCockLength() <= 4) surrenderSmallCock();
				else if (player.biggestCockLength() <= 10) surrenderMediumCock();
				else surrenderLargeCock();
			}
			// Female
			else if (player.hasVagina())
			{
				surrenderOhGodTheFemaleSurrenderContentIsFuckingHuge();
			}
			// Genderless
			else
			{
				someGenderlessExitSceneBecauseNoneWereWritten();
			}
		}

		// Male/Herm scene for cocks <= 4"
		protected function surrenderSmallCock():void
		{
			outputText("“<i>Ohhh!</i>”  She positively purrs as her eyes fall upon your naked [cock biggest] for the first time.  “<i>What’s this?</i>”  She leans forwards to stare at your genitals with undisguised interest.  “<i>Well, now... I figured you [race]s would be pretty [if (player.isATaur == true)big|small], but this isn’t what I was expecting at all.  Hmm... I </i>was<i> planning on giving you a handjob, but, uh... I guess this’ll have to do, huh?</i>”  She gives you an almost apologetic smile as she holds up her hand, thumb and forefinger curled into a ring as though to show you what she has planned, before reaching back down to your groin. Her fingers slide over your stiffening flesh and you realise in a flood of soul-crushing embarrassment that she’s right.  You’re so small, she actually can’t fit more than two fingers around your cock at a time.\n\n");

			outputText("You try to look away, blushing crimson, but the weight on your [if(player.isATaur)flank|chest] suddenly disappears as Izumi grips your chin with her free hand, forcing you to lock gazes with her.  “<i>Hey, don’t look away!</i>”  She chides.  “<i>Seeing your face during all this is the best part... aw, hey, are you embarrassed?  You’re blushing!  That’s so </i>cute!” She trills.  “<i>Here, look.  I know what’ll make ya feel better....</i>”  Before you can respond, the domineering Oni woman [if (player.isATaur)perches her muscular ass on your flank, your body making for a suitable seat.|drops to the floor, laying next to you on her side.]  She releases your chin, but her hand snakes around behind your head to your other cheek, pulling you in towards her.  You can’t help but grunt in surprise as the side of your head is forcibly pushed up against one massive, pillowy-soft breast"); 

			if (player.biggestTitSize() >= 1 && player.biggestTitSize() < 3) outputText(" , your [chest] dwarfed by the larger womans own pair.");
			else if (player.biggestTitSize() >= 3 && player.biggestTitSize() < 5) outputText(" , your [chest] moulding themselves against the underside of the Oni’s larger pair.");
			else if (player.biggestTitSize() >= 5 && player.biggestTitSize() <= 8) outputText(" , your [chest] compressing against the Oni’s larger pair, forming a delicious valley of flesh between your bodies.");
			else outputText(" , your [chest] dwarfing the larger womans own pair.");

			outputText("  “<i>There.</i>”  She announces happily, softly stroking your cheek as though to reassure you.  “<i>All better now, right?  Good.</i>”  She doesn’t even wait for a response before turning her attention back to your [cock biggest]....\n\n");

			outputText("Izumi holds you there easily, pinned against her chest as she slowly coaxes your stiffening erection to life, and you finally realise that you’re completely trapped.  If there ever was a chance for you to slip free and escape from this situation you must have missed it, because now you’re locked in the embrace of those strong, iron-muscled arms, all you can do is feel intimidated.  As Izumi casually molests you, you can’t help but realise how much more powerful than you she seems - how much stronger and more confident in everything she does.  At this moment, you feel as though if she desired, she could do anything she wanted to you [if(player.str <= 75) and you would be powerless to resist...|and you would struggle to deny her will...] a feeling that is only compounded by the burning sense of shame you feel as she jacks you off with a measly two fingers.\n\n");

			outputText("With the realisation that you’re completely under her control, something inside you simply switches off and your resistance vanishes entirely.  You decide to just let Izumi do as she wills with you; after all, she’s so much stronger than you, how could you oppose her?  Nuzzling your face into Izumi’s breast, you squirm and wriggle under her touch as your [cock biggest] reaches it’s full - if it could even be called such - hardness.  Hopefully, if you just go with whatever she wants to hear, this won’t be so bad.\n\n");

			outputText("“<i>So, you’re ashamed of this, are you?</i>”  Izumi suddenly asks.  You don’t respond, so she stares down at you.  “<i>Answer.</i>”  She commands, her tone imperious.  You can’t bring yourself to speak, so you simply nod, burying your face in her silk-covered bust.  “<i>Good.  You answer when I ask you something, "+ this.heightDesc() + "</i>”  She nods approvingly and resumes her slow, gentle strokes.  The casual, unhurried pace of her handjob is beginning to drive you insane; it’s certainly pleasurable, but it’s also agonizingly slow, and you long for her to just speed up even the tiniest bit...\n\n");

			outputText("“<i>Well, I can certainly see why you </i>would<i> be ashamed of it.  It’s pretty tiny, you know?  In fact, I think this is probably the smallest I’ve </i>ever<i> seen.</i>”  She announces, and you wince. Part of you wishes she would just shut up, but somewhere deep inside you, another part of you feels almost... curious?  Part of you, some dark, treacherous part, wants her to continue.  Part of you wants to know more [if (player.hasVagina) , sticky moisture dribbling across your thigh, your [vagina] clenching in lust-fueled harmony with your cock]... “<i>Hey, don’t get upset.  After all,</i>” She pauses for a moment, her hand lingering in place.  “<i>Some women </i>like<i> ‘em small...</i>”\n\n");

			outputText("“<i>So, let me guess.  In a place like this, it’s gotta be weird having something this small, right?  I mean, it’s a pretty unique trait, given the circumstances.</i>”  She continues.  “<i>Hey, tell me something.  Do the harpies leave you alone?  Are you so small that they think you’re [if (player.gender == 3)just a regular|a] girl?</i>” Suddenly, her hand bottoms out around your [cock biggest]");

			if (player.balls > 0) outputText(" and her free fingers reach out to gently stroke against your [balls].");
			else if (player.hasVagina()) outputText(" and her free fingers reach out to gently stroke against your [vag].");
			else outputText(".");

			outputText("  At the same time, she leans in close to your ear.  “<i>Do the </i>Minotaurs?”  She hisses suggestively, eyes flashing.\n\n");

			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1)
			{
				outputText("The moment the word ‘Minotaur’ enters your lust-addled brain, your body shifts over to automatic. Your [cock biggest] twitches painfully, loins longing for the release that can only come from being filled full of gallons of hot Minotaur cream, and you let out a distinctly feminine sounding moan as depraved fantasies of being roughly taken by the bull-men rush through your head.\n\n");

				outputText("Izumi leers shamelessly at your reddening face, then whispers, softly into your ear.  “<i>Dirty [boy]....</i>”  You realise that she knows exactly what you’ve been doing - or rather, what’s been repeatedly doing <i>you</i> - and that shameful revelation combined with the burning arousal you feel from the very thought of minotaur cum is more than enough to force you over the edge into a sudden orgasm.  Far from being upset, Izumi seems positively overjoyed at your premature ejaculation.\n\n");

				outputText("“<i>Ahaha, well now, look at that!</i>”  She cries, beaming.  “<i>I guess I called it right, hmm?  Geez, did the minotaurs do something to you, or were you always this perverted?</i>”  Izumi snickers.  You can’t even muster up the energy to respond, you’re so drained from your sudden orgasm.\n\n");
			}
			else
			{
				if (!player.isTaur()) outputText("As you squirm in her arms, she releases your head from her grip, instead pushing you up into a seated position.");

				outputText("“<i>Hold on, I want to watch this.</i>”  She says, shifting position until her head is placed on one side of your hip, staring at your [cock biggest][if(player.isATaur == false) as one arm reaches around to continue the handjob from the other side ].  She stares intently at your cock, an expectant smirk plastered over her face, her free hand working [if (player.isATaur == true)over your flank|you over with increased vigour].  Before you know it the combination of her skilled fingers and the bizarre, embarrassing sensation of being so carefully observed are pushing you over the edge.  Rather than leaving off as you cum, Izumi’s handjob actually speeds up, her eyes widening in excitement as your orgasm floods through you.  The sensation is much more powerful than you usually experience, perhaps due to Izumi’s extensive teasing, and you can only sit and shudder, staring down at yourself in shock as your [cock biggest]");

				if (player.cumQ() <= 100) outputText(" dribbles a hot, sticky mess onto the cold cavern floor.");
				else if (player.cumQ() > 100 && player.cumQ() <= 250) outputText(" spurts and splutters a hot, sticky mess onto the cold cavern floor.");
				else if (player.cumQ() > 250)
				{
					outputText(" shoots out rope after rope of hot, sticky cum across the cold cavern floor");
					if (player.cumQ() > 500) outputText(" , a small puddle of creamy-white forming between you and the cavern wall");
					{
						if (player.cumQ() > 1000) outputText(" , slowly expanding into a small lake....\n\n");
					}
					else
					{
						outputText(".\n\n");
					}
				}

				outputText("“<i>Hah!  Oh yeah, thar she blows!</i>”  Izumi crows, staring fixatedly at your spasming dick like a woman possessed.  “<i>Now ain’t that a pretty sight... Yeesh, and you just keep cumming and cumming.  Did being teased feel that good, "+ this.heightDesc() +"?</i>”  She grins. You can’t seem to find the energy to respond, panting for breath as you stare in confusion at your already-deflated cock, your balls aching from the strain of such a forceful ejaculation.\n\n");
			}

			outputText("“<i>Well, that was fun.</i>”  Izumi says, sitting up and dusting off her palms, dismissively.  “<i>I’m assuming you’re not up to a rematch just yet from the way you’re shaking.</i>”  She picks up her pipe and takes a drag, shooting you a knowing grin.  “<i>Feel free to drop by again, though.  You know, in case you wanted to tell me off... or maybe if you just want me to bully you some more.</i>” \n\n");

			dynStats("lus=", 0);

			menu();
			doNext(13);
		}

		// Male/Herm scene for cocks <= 10"
		protected function surrenderMediumCock():void
		{
			outputText("“<i>Huh.  Not bad, "+ this.heightDesc() +"; I gotta say, I thought you people’d be [if (player.isATaur == true)bigger|smaller] down here... or are you just a little ‘gifted’?</i>”  She says, giving you a lopsided grin.  You attempt to stammer out a reply, but she ignores you, instead focusing her attention completely on your [cock biggest].  Still restraining you with one hand, her other hand glides across your cock, easily bringing it to hardness.  You can’t help but gasp as you feel her talented fingers playing across your flesh; from the way she seems to naturally gravitate to all of your most sensitive spots in turn, you can’t help but think she must have done this kind of thing before.\n\n");

			outputText("In mere moments, you’re fully erect, as hard as you’ve ever been");
			if (player.hasVagina())
			{
				outputText(" , your [vagina]");
				if (player.wetness == 0) outputText(" moistening");
				else if (player.wetness == 1) outputText(" dribbling runnels of sticky fem-juice");
				else if (player.wetness == 2) outputText(" constantly oozing feminine arousal");
				else outputText(" a soppy mess, gushing a veritable lake of fem-slime");
				outputText(" in lust-fueled harmony with your cock.");  
			}
			else outputText(".");
			outputText("  Izumi looks down at you and flashes you an indulgent smile.");

			outputText("“<i>So, I guess we can start now.</i>”  Says the Oni as she drops into position, [if(player.isATaur == true) perching her muscular ass on your flank, your lower body offering a comfortable seat for Izumi.|laying on her side next to you.]  She releases your [if(player.isATaur == true)flank|chest] and instead leans on her elbow, leaving you uncomfortably free and completely unsure of what to do with yourself as she wraps her hand around your [cock biggest] and slowly begins to stroke you.  Her palms are warm and pleasingly soft, something you didn’t expect from the well-muscled Oni woman.\n\n");

			outputText("Her pace is glacially slow, but as her hand rolls gently up and down your length, she somehow manages to find each and every secret spot, every sensitive place, causing you to flinch and quiver under her grasp.  You grit your teeth and squirm in discomfort as Izumi teases your cock in an entirely new way.  Already, you can feel your body rebelling at the bizarre, paradoxical sensations.  Unable to comprehend what is happening, every fibre in your body screams a single thought in unison; <b>faster</b>.\n\n");

			outputText("Without warning, your hips spasm and buck [if(player.isATaur == false)upwards] almost of their own accord.  Izumi’s fingers tighten a little, just enough to keep her grip, but her gentle motions stop completely.  She simply holds on, grinning slyly at you as you desperately hump into the air.  Izumi’s amber eyes glitter in the gloom as she leans in closer to you, whispering into your ear.\n\n");

			outputText("“<i>Lay back and settle down, or I ruin your fun.</i>” she purrs.\n\n");

			menu();
			addButton(0, "Obey", surrenderMediumCockObey);
			addButton(1, "Refuse", surrenderMediumCockRefuse);
		}

		// Male/Herm play along scene split
		protected function surrenderMediumCockObey():void
		{
Taking a deep breath, you grit your teeth and force yourself to calm down.  [if (pc.isTaur) Y | Lowering your shaking hips, y]ou manage to relax and simply wait passively for Izumi to resume her handjob.
 
“That’s better.”  Izumi says approvingly.  “Now, since you played nice...” She trails off dangerously, but before you can try to figure out what she has planned, she hits you with it - her handjob resumes, but much, much faster than before.  Despite her increased speed, she still manages to hit every single spot she was hitting before, causing a whirlwind of pleasure to rush through you.

Almost immediately, you feel your orgasm starting to rise within you.  You try to stammer out a warning, but Izumi’s pace continues unabated.

“It’s fine.  Just cum as much as you like.”  She announces casually.  A few seconds later, your orgasm hits, exploding forcefully out of your [cockhead biggest].  Even once she sees the burning juice begin to erupt from your cock, Izumi doesn’t slow down - on the contrary, she actually accelerates her pace!  As she extends your orgasm over and over again, all you can do is writhe around, drumming your feet against the floor and groaning in ecstasy as the massive Oni woman vigorously milks you, draining your aching [if (pc.balls > 0) balls | cock ] to the very last drop.
 
Finally, she relents, and your extended orgasm mercifully subsides.  Izumi stares indulgently down at your shivering form for a moment, before muttering a quiet “Heh,” and wandering back over to her tent.  You can only manage to rest there, laid prone in a [if (player.hasVagina) mixed puddle of your own fem-slime and | puddle of your own ] cum, staring at the cavern roof and panting madly for a good few minutes afterwards.  Once you regain the use of your legs, you retrieve your clothes and wander back to camp in a daze.

dynStats(“lust”, -100);

:[Next]

		}

		protected function surrenderMediumCockRefuse():void
		{
			Sick of Izumi and the strange, uncomfortable feelings the Oni keeps forcing you to experience, you defy her command.   Instead, you thrust more vigorously into the air, turning this way and that, trying to force some form of stimulation from the hand mercilessly gripping your member.

“Fine.”  Izumi says, apparently unconcerned.  “Go ahead and try.  It won’t do you any good.”
 
Ignoring her, you continue thrusting, twisting and turning, but always Izumi follows you effortlessly, thwarting every twist and turn you make in a desperate attempt to fuck her hand.  Finally, after an eternity of painful stalemate, you give in, collapsing to the ground, momentarily exhausted.
 
“All done?”  She asks.  You glare at her, and her grin widens.  “So, you wanna cum, huh?  Well then, let’s do that.”  She announces, happily.  Suddenly, she begins stroking you again - this time at a speed far beyond her previous unhurried pace.  Her hand flies up and down your shaft, stimulating you just as much as before, but at easily three times the speed!  It is, without a doubt, the most amazing handjob you’ve ever experienced.

The insane feeling is just too much, and you feel your orgasm boiling up within you.  Just as you feel yourself rising to crest the orgamsic wave and hit sweet release... Izumi lets go.
 
You cry out in anger and pain as you find your impending orgasm so cruelly denied, your [cock biggest] twitching and throbbing painfully [if (pc.hasVagina) , [vagina] spasming in sympathy], desperate for release.  Somehow, she knew you were on the verge of orgasm, and she chose to deny you that pleasure, you just <b>know</b> it.  You shoot Izumi a vicious, hateful glare, only to see her laying there quite calmly, her expression blank.
 
“Hm?”  She grunts, looking surprised.  “Oh, do you want some help?  Sure; here, let me handle this for you.”  She says, her tone even.  She reaches out and, very deliberately, softly flicks your [cockhead] with a single finger.
 
The sensation is almost nothing, but as close as you are, it’s just enough.  You groan in a mix of pleasure and heartbroken anguish as the tiny amount of contact forces you over the edge, your load forcing its way up through your cock with agonizing slowness until finally [if (player.cumQ <= 250) spurting free, spattering down randomly over you as Izumi watches, happily observing the effects of your ruined orgasm.
| [if (player.cumQ <= 500) sputtering freely from your [cock], glob after glob of thick jizz showering down randomly over you as Izumi watches, mildly amused with the results of your ruined orgasm.
| [if (player.cumQ <= 1000) a torrent of fertile spunk rushes forth from your [cock], glob after glob of thick jizz showering down randomly over you, covering you from head to toe as Izumi watches, amused with the results of your ruined orgasm.
| a torrent of fertile spunk rushes forth from your [cock], rope after rope of the thick cum launching into the air and splattering down over you.  Your orgasm continues unabated as you slowly paint yourself in a creamy white layer, Izumi giggling quietly, evidently proud of herself. ]]] Finally, you finish cumming, and as you lay panting in the results of her handiwork, Izumi gently pats you on the head.

“So, you learned something today, right?  Next time, just do what I say, and the results are much more... fun.” She smiles, then turns away.  Retrieving your clothes, you drag yourself back to camp, feeling decidedly shaky.

dynStats(“lust”, -100);

[Next]
		}

		protected function surrenderLargeCock():void
		{
			Izumi grunts in surprise as your [cock biggest] flops free of its confinement.  “Damn.  This is pretty impressive, you know?”  She frowns, running an exploratory hand across the length of your flesh.  “Let me guess, you got a bit too frisky with one of the natives?  Maybe didn’t think to boil the water before you drank it?  Look, no offence, but there is no way this thing is legit, [IzumiShort].”
 
Izumi continues to frown as she inspects you, turning your stiffening cock this way and that in her hands, apparently indifferent to the way her touch has begun to coax you towards full hardness.  She murmurs to herself under her breath, tapping a finger to her lips whilst absentmindedly wringing your cock with her other hand.  Eventually, she appears to reach a decision.  “Alright!”  She announces, loudly.  “Let’s try it like this, shall we?!”
 
Izumi releases you from the floor, allowing you to sit [if (pc.isTaur) back on your haunches, front end raised ] up as she makes her way around to sit cross-legged between your legs.  Once settled into position, she smirks suggestively at you around the throbbing meat now standing at insistent attention between the two of you.  “Get ready,” She warns, “because this is going to be a hell of a ride... and you wouldn’t want to disappoint me now, would you?”

“Six!”  She shouts, suddenly, making you flinch in surprise as her right hand snaps out and latches onto your cock, just below the sensitive [cockhead].  Izumi grins, slowly rotating her wrist and wringing her hand around in place, but she doesn’t start up any kind of up-and-down motion - yet.
 
“Five!”  She yells, and her left hand joins the first in gripping your cock, this time about halfway down your shaft.  Again, her wrist rotates gently as she massages the area, but her hand doesn’t actually go anywhere.  Her grin widens into a truly ominous smile as she leans forwards conspiratorially.
 
“Four.”  She whispers, and without warning her legs unfold, both feet flying out from beneath her and latching onto the [sheath] of your [cock biggest]! Izumi leers at you with undisguised amusement as she watches your reaction to the sensation of her bare soles rolling over the [sheath] of your shaft 
[if (pc.balls > 0) , occasionally sliding down to massage your [balls] before returning to your cock.
| if (pc.hasVagina) , occasionally sliding down to tease at the lips of your [vagina].
| if (pc.hasVagina && pc.balls > 0) , occasionally sliding down, alternating between a gentle massage of your [balls] and teasing caresses of your [vagina].]].  

The strange sensation causes you to quiver, your towering erection twitching ominously.  “Hey, don’t give up just yet!”  Izumi quips . “We’re just about to get to the fun part...” Already beginning to sweat as the mind-addling smoke fogs your brain with lust, you briefly wonder what exactly ‘the fun part’ entails....
 
“Three.”  She announces, and then begins to move.  You groan in equal parts pleasure and surprise; Izumi’s feet are surprisingly dextrous, and you can’t help but be amazed at how warm and soft her soles feel as they glide across your skin.  Incredibly, there seems to be almost no difference in sensation between her feet and her hands; if you close your eyes, it almost feels as though you’re being stroked along your entire length by four hands at once....
 
“It’s good, right?”  Izumi’s voice penetrates your thoughts, and you open your eyes to see her gazing up at you, amber irises glittering golden in the half-light.  “You know, there’s one more level to this... but looking at the state you’re in, there’s no way you could endure it for long.  In terms of pleasure, it outclasses what I’ve been doing up to now completely. Do you want to see it?”  You don’t even have to think about it.  You nod your head, unsure if you can manage the difficult task of speaking, and Izumi giggles.  “Alright, [IzumiRace], but don’t say I didn’t warn you.  Here we go...”
 
“Two.”  She teases, her technique changing completely.  Rather than just running her hands and feet gently over your flesh, she grips on tightly, her hands clenching around your [cock biggest] like vices.  Her movements change completely, instead of the simple, slow up-and-down motion she had been using, she begins to alternate the motions of her left and right angles of attack - while her left hand rolls up your shaft, the right slides down to meet it.  Even her feet seem to somehow press in tighter against your flesh, mirroring her hands;  the strange technique creating a unique wave-like rolling sensation that feels quite unlike anything you’ve experienced on Mareth before. You wonder briefly if there might be a little bit of magic involved here before your thoughts are obliterated by an avalanche of pleasure - Izumi has begun to speed up.
 
You can only grunt and shiver under the onslaught as Izumi works you over with this bizarre new approach.  There’s no gentleness here, you realise; no playful teasing or long, drawn out pauses.  This move is designed for one thing, and one thing only - to force you to cum.  [if (pc.balls > 0)You groan, your aching balls coming to the same conclusion as you have, twitching under a passing stroke from one of Izumi’s soles and tensing up in readiness.]  You understand now why Izumi warned you about this technique; you are no longer being teased, gently coaxed towards the edge and then pulled back at the last minute.  As of now, you are being milked.
 
“One.”  She commands, her tone demanding.  After only a few moments, you throw back your head and let out a long, ecstatic moan as you cum, your orgasm fountaining up through you and exploding free of your [cockhead biggest] like a creamy fireworks display.  As the first jet of semen surges free of your cock and thrusts up into the air, Izumi gasps.  A split second later, she releases you and launches herself backwards in a powerful roll that catapults her across the cave. Your first load splatters explosively down where she had been sitting moments ago, but you’re too busy firing off a second to care.

[if (pc.cumQ > 500) 
You remain sat there for a crippling eternity, unable to do anything but moan as you inexplicably continue to cum, your aching erection firing out shot after shot of hot, dripping goo as Izumi watches you from the safety of the shadows, grinning happily like the cat that got the cream.] Eventually, your orgasm subsides, and you collapse [if (pc.isTaur) sideways | backwards ] onto the ground, staring up at the roof of the cave in a daze.  After a few seconds, Izumi’s face appears in your field of vision, albeit upside down.

“Haha... Sorry about that, but I didn’t want you to ruin my clothes, you know?”  She half-apologizes, giggling.  “Hmm... maybe that move was a little much to try on a [IzumiRace].  I just thought that since you were a little more... <i>Robust</i> than most others of your kind that I’ve met, you’d be able to take it.  I did try to warn you, although... It seems like you enjoyed yourself anyway, hmm?”  She beams.  You can barely find the energy to blink, let alone respond.  
 
Izumi returns to her tent and lights up her pipe, unceremoniously abandoning you there on the cave floor, apparently done with you for now.  Still, it’s some time before you are able to drag yourself to your feet and stumble home to your camp, wondering how long it’ll be before you can see straight again...

dynStats(“lust”, -100);

[Next]

		}

		protected function surrenderOhGodTheFemaleSurrenderContentIsFuckingHuge():void
		{
			You resign yourself to letting Izumi do as she wills with you and hesitantly reach to start undressing.  

[First Time Submit]
[if (flags[kFLAGS.IZUMI_TIMES_SUBMITTED] == 0) Before you can remove your clothes, however, Izumi grabs a hold of your wrist.

“Not so fast.  I’ve never really had a chance to play with a girl before.  I wanna take my time on this one...” She says.  Smiling suggestively, she reaches out and slowly divests you of your [armorname].  [if (pc.corruption <= 33) You can’t help but feel a crippling sense of embarrassment as the strange woman undresses you, and you look away, embarrassed, while Izumi’s hands explore your body.] [if (pc.corruption >= 66) As Izumi slowly reveals your naked body to the world, you begin to feel an oh-so-familiar heat building up inside of you.  You look down at Izumi with pride as she inspects your body, running a skillful hand over your chest with a thoughtful look on her face.]

[if (pc.biggestTitSize >= 15)  Izumi’s eyes widen in surprise as she pulls aside your clothing to reveal your impressive bust, your [chest] finally free.

“Wha- Wait, these are real?!”  she exclaims, loudly. [if (pc.corruption < 50)Sheepishly, you nod as Izumi manhandles your massive mammaries as though looking for evidence of their falseness.  She bites her bottom lip, glaring intently at you as she roughly runs her hands over your breasts.  Although the Oni woman’s palms are surprisingly soft, her treatment of your breasts is not - she practically mauls you, squeezing, groping, even pinching the soft flesh.

“Unbelievable...” She mutters to herself, bitterly.  She looks up at you, confusion still plain upon your face, then scowls.  “You don’t even know why I’m annoyed, do you?  Does having a chest THIS huge,” she reaches out and pinches one of your [nipples] between her thumb and forefinger, causing you to yelp in surprise and pain.  “Just seem normal to you?!”  She grumbles in frustration before giving the nipple a sharp tug, causing you to cry out once again.  “Forget it.”]

[if (pc.corruption >= 50) You smile and nod proudly as Izumi examines your breasts, experiencing a giddy little thrill at the feeling of her soft palms rolling across your endowments.  She bites her bottom lip, glaring intently at you, and you return her gaze with amused indifference.  Although the Oni woman’s palms are surprisingly soft, her treatment of your breasts is not - she practically mauls you, squeezing, groping, even pinching the soft flesh . The rough treatment is deliciously arousing, and you can’t help but let out a few soft moans at being manhandled so forcefully - much to Izumi’s obvious annoyance.

“Let me guess, you intentionally made them grow this big?”  She scowls.  She reaches out and pinches one of your nipples between her thumb and forefinger, causing you to let out another excited little groan.

You respond with a shrug, teasingly, not entirely wanting Izumi’s abuse to stop.  Izumi’s frown deepens and she tweaks your nipple, twisting it painfully to the side, eliciting another gasp from you.]

“How shameless.”  She grumbles, returning her gaze to your bust.  “How utterly shameless....”]]

// Exhibitionist addition to scene start
[if (flags[kFLAGS.PC_FETISH] >= 1)
While Izumi takes her time freeing you of your [armorname], you experience a little familiar thrill as Ceraph’s cursed piercings start to work their magic.  Every inch of your skin from head to foot tingles with excitement as you relish the prospect of finding yourself on display once again, naked and defenceless for the whole world to stare, or scowl, or leer - it makes your nipples harden just thinking about it.

Looking up at you with a superior smirk, Izumi continues to run her hands over your body, clearly more interested in stealthily groping you to check out the goods than actually undressing you. The tortuous anticipation just makes everything feel that much better though - soon, you’re going to find yourself completely naked in front of this strange woman. Not just yet, but <i>soon</i>, oh so soon….  It’s hard to believe how erotic the idea now seems to you.  Like a child the night before a birthday, you’re equal parts excited and desperate - and before long you’re practically screaming internally for Izumi to hurry up, rip off the rest of your clothes and just strip you <i>bare</i> already.  By the time she gets round to removing the bottom half of your clothing, you’re positively soaking wet.

Izumi grunts in surprise as she surveys your dripping folds [if (pc.hasCock) , your [cock] slowly thickening under her scrutiny].  You shift in place, [if (pc.isNaga) wriggling atop your [legs] | subtly parting your [legs]] and even [if (pc.isTaur) rolling your butt upward | tilting your hips forwards ]a little, to ensure that Izumi gets a really <b>good</b> look at you down there.  The shameless act sends a flush of embarrassed warmth through you, making you tremble in pleasure.  You’re unable to keep yourself from smiling a little - you can barely manage to stop yourself from moaning aloud.  You place your hands above your breasts, hoping that Izumi will stop to look at them... Which she does, looking up a moment later to say something, then pausing as her eyes linger at the sight of your [chest].

[if (!pc.isNaga)You rub your thighs together in delight | You wriggle and writhe in delight ] as Izumi stares at your proudly displayed chest, enjoying the sensation of being watched and idly wishing you had something to fill the aching void [if (pc.isNaga) deep within your [vagina].  You slither around in place, your [leg] shifting and weaving around itself, moving and undulating... | between your [legs] as well.  As you move your weight repeatedly from one [foot] to the other, you shiver in enjoyment.]   Being stared at feels so good.... You blink, suddenly called back to reality by Izumi’s voice.

“Look, [IzumiShort], I know I’m kind of an intimidating specimen, but you don’t really need to be scared.” She smirks.  “You keep shivering in fear like that and I’m liable to take offence, yeah?”  You blink again in confusion before realization finally dawns.  Izumi has absolutely no idea how much this is turning you on.  The idea of your secret arousal going completely unnoticed is surprisingly erotic, and that thought turns out to be just enough to push you over the edge.  You wince and bite your lip to stifle your moans, quivering in the throes of a miniature orgasm, even though you’ve really yet to be even touched... And on a whim, you decide to keep eye contact with Izumi for the entire thing.

Staring into those steady amber eyes as you quietly cum adds an entire new level of deliciously wrong-feeling pleasure to the affair, something you resolve to enjoy for as long as possible. Finally, your orgasm subsides, and you visibly relax.

“There.  See?  I ain’t so bad.”  Izumi smiles again, still apparently oblivious to your fun at her expense.  “Now, we get to move on to the good part.  You ready? ” She asks.  You smile and nod, still basking in the post-coital warmth of your inner glow.

] // End addition to scene start

[if (!pc.isTaur)

Without warning, Izumi violently lunges forward, grabbing at you.  You are only able to let out a surprised yelp before she grips onto your arms, pulling you towards her and spinning you around.  [if (!pc.isNaga) Before you know it, she has you down on your knees, the cold stone of the floor digging into your skin a little as she circles behind you, smirking cruelly. | She takes hold of your shoulders and forces you lower to the ground, forced to slither more and more of your tail out from under yourself, until Izumi towers over you.  She circles behind you, a cruel smirk the only hint of her intentions.]

Izumi reaches around from behind you and you half turn to look at her, but she grips you by the chin and firmly turns your head away from her.  Your gaze flits nervously around the cave at random as you feel Izumi’s other hand glide slowly across your [skinfurscales], running along your stomach and down towards your [if (pc.isNaga) [leg] | thighs ].

“Well now, let’s see...” She murmurs into your ear, softly.  “What can I possibly do with you, hmm?”  She jerks you painfully back upright, locking your arm behind you as she frogmarches you towards the entrance to her cave.  “You’re really pretty, you know that?” She purrs.  “It’d be a shame to hide such a pretty thing away in a dark place like this, wouldn’t it?”

Struggling helplessly against the enormous Oni’s iron-hard muscles, you stagger over to the mouth of the cave.  A gust of cold mountain air blows over you, chilling your skin and causing you to shiver as your nipples harden.  Izumi halts, stopping your wobbling advance dead. You gaze out at the scenery for a moment, the vast mountain range spread out below you, and for a moment you’re filled with an irrational fear that she intends to simply hurl you off the cliffside and leave you to fend for yourself without your gear.  Then, suddenly, Izumi kicks your legs out from under you.

You cry out in surprise and terror, then let out a grunt as you find yourself being yanked backwards into Izumi’s lap.  Her legs entwine with yours, yanking them apart painfully, exposing your [vagina] to the cold mountain winds.  At the same time, she grips both your wrists with one hand, pulling them behind your back, forcing you to arch backward, and thrusting your [fullchest] out for inspection.  You gasp in surprise as you feel her other hand reach around to grope at your breasts, squeezing and massaging them experimentally.  Despite yourself, you can’t help but let out a yelp as she squeezes a [nipple] between thumb and forefinger.  

As you squirm in Izumi’s grip, it begins to dawn on you that you’re not getting away from this.  Your resistance begins to lessen until eventually you begin to relax, finally admitting to yourself that this really doesn’t feel half bad...

| // Izumi rides the pony!

Without warning, Izumi violently lunges forward, a hop in her step easily launching her high enough to land on top of your [race]-like body.  You’re only able to let out a surprised yelp before she grabs your arms, pulling them behind your back as a makeshift set of reins, a single powerful hand clasped around your wrists to keep them restrained.  The effect of being so utterly under the control of the Oni only amplified by the sensation of her muscular thighs clamped tightly around your flanks.

Izumi reaches around from behind you and you half turn to look at her, but she grips you by the chin with her free hand and firmly turns your head away from her.  Your gaze flits nervously around the cave at random as you feel Izumi’s feet run across your [skinfurscales], her toes squirming against your underbelly.

“Well now, let’s see… “  She murmurs, softly.  “What can I possibly do with you, hmm?”  She jerks your arms painfully forward, elbows locked straight thanks to her iron-hard grip around your wrists.  The motion prompts you to stumble a half step forward, edging you closer to the entrance of her cave.  “You’re really pretty, you know that?” She purrs.  “It’d be a shame to hide such a pretty thing away in a dark place like this, wouldn’t it?”

Struggling helplessly against the enormous Oni’s manacle-like grip around your wrists, you gradually stagger over to the mouth of the cave under her direction, another jolt delivered to your arms whenever Izumi deems your progress too slow.  A gust of cold mountain air blows over you, chilling your [skinfurscales] and causing you to shiver as your nipples harden.  Izumi tugs backward on your ‘reins’ to stop your wobbling advance dead.  You gaze out at the scenery, the vast mountain range spread out below you, and for a moment you’re filled with an irrational fear that she intends to simply drive you off the cliffside and leave you to fend for yourself without your gear.  Then, suddenly, Izumi kicks your legs out from under you, collapsing to the floor with a surprised shriek.

Izumi shifts herself around to casually lay along the length of your lower body, using  her grip on your wrists to jerk you backward once more, forcing you to arch your back and thrust your [fullchest] out for easier inspection.  You gasp in surprise as you feel her free hand reach around to grope at your breasts, squeezing and massaging them experimentally.  Despite yourself you can’t help but let out a yelp as she squeezes a [nipple] between thumb and forefinger.

As you squirm under Izumi’s body, it begins to dawn on you that you’re not getting away from this.  Your resistance begins to lessen until eventually you begin to relax, finally admitting to yourself that this really doesn’t feel half bad....

]


“Well, well. Look at that,” She whispers into your ear conspiratorially. “It seems you’re already drawing an audience.”  It takes a moment, but her words finally filter through your lust-fogged consciousness, jerking back to reality .  Your eyes snap open in surprise, just in time to see a flicker of movement among the rocks nearby.  Then another, and another.  Imps, goblins, even one or two harpies slowly start to congregate around you, affording you brief glimpses at them as they take up vantage points in preparation for what is about to come.  Several of them are already clearly aroused, and your eyes widen at the sight of an imp’s wagging erection as he scampers between a pair of nearby boulders.  It slowly dawns on you that in a place as remote and empty as this, the sight of someone like you being toyed with - maybe even raped if the situation weren’t voluntary - is probably quite the rare spectacle.  And here Izumi is, displaying you like some kind of rare prize for every perverted beast on the mountain to gawk at.

[if (flags[kFLAGS.PC_FETISH] == 1) [ExhibitionVariant] | [NonExhibitionVariant]]
[NonExhibitionVariant]
You squirm desperately, the feeling of a dozen pairs of eyes leering at you making you feel decidedly uncomfortable.  Izumi apparently notices your distress, however, as a few seconds later you hear a thunderous crack as she reaches out to a nearby outcropping of jagged rock, snapping it off with one massive hand.

“Get lost, ya scummy vultures!” She yells, [if (pc.isTaur) sitting upright on your back and] hurling the rock forcefully at the circle of watchers. It shatters harmlessly on a boulder, but the crowd gets the message, disappearing in a flurry of angry squawks and howls. “Sorry,” Izumi adds apologetically as you twist your neck around to stare at her in confusion. “Like I said, this neighbourhood’s full of trash like that, you know? I didn’t realise they’d upset you.” She smiles - a friendly, honest smile, bereft of guile or malice.

Despite your uncomfortable situation, you can’t help but feel kind of... reassured.  The smile soon becomes something more than friendly though, and suddenly Izumi’s head darts forwards and she forces her tongue into your surprised [if (pc.hasMuzzle) maw | mouth ], stunning you as she launches into a powerful french kiss.  Her tongue wraps effortlessly around your own, leaving you breathless and unable to help but wonder how dextrous it could be.  Izumi assaults your mouth, forcefully, leaving no doubt as to who is in control of the situation - it’s all you can do to keep up with the insistent, probing kiss.  Finally, she breaks off, leaving you gasping for breath after your extended tongue-grappling session.  For her part, Izumi seems to be none the worse for wear, wiping her mouth with a satisfied expression.

“Now, where were we?” Izumi murmurs.  You look down as she gently rolls a hand around to cup one of your breasts. “Oh yeah,” She adds, playfully. “</i>I</i> remember...” Izumi gropes at your chest experimentally, stroking, fondling, squeezing, molesting your bust as she gauges it for firmness.

[if (player.biggestTitSize <= 2)
“Haha... You’re pretty cute, you know?” Izumi whispers into your ear, idly twiddling one of your nipples between thumb and forefinger as though this were a perfectly natural conversation. “Funny, I was going to play with your breasts a little, get you nice and warmed up... but I can’t seem to find ‘em.  That’s not right, is it?  Girls have boobs, big, pillowy things to show off in front of the fellas... but you don’t.  Completely flat, aren’t ya? Almost like you were a boy.  That’s gotta be embarrassing, right?”  You look down at your chest, blushing furiously.  You’d never really thought about it before, but now that Izumi mentions it....   Plus, with Izumi leaning in and gripping you from behind, those strong, muscled arms caging you in as her enormous breasts press inescapably against your spine, you have to admit you do feel kind of inadequate... as well as strangely aroused.

“Well, it’s pretty sad, but don’t be too upset,” Izumi continues, reaching around with her other hand to play with the other nipple.  She pointedly avoids so much as stroking against the unimpressive mounds that make up your sub-average titflesh, solely concerned with molesting your now diamond-hard nipples, heightening both your sense of arousal and your rising shame at your small size.  “I’m sure someone, somewhere, will still want to take you.  Of course, they’ll probably be the kinky type.  Who else would want someone as flat as you?  There isn’t even enough here to rub up against.  But hey, some guys are into that.  You might have to pretend to be a schoolgirl for ‘em, but they’re into it...”  Without warning, Izumi shifts up her game, pinching your [nipples] painfully and pulling on them slightly, forcing you to let out a moan of confusion; half pleasure, half pain.

“Or is that what </i>you’re<i> into?”  She hisses, suddenly intense.  “Admit it, there’s no way anyone could really have breasts this small.  You did this on purpose, right?  Wanted to make yourself as flat and unappealing as possible, so only the </i>real<i> deviants would want you.  Is that it, is that what makes you tick?  You want to find some sick perv who can only get off by fucking someone as flat as you?! Someone with a body that looks more like it belongs to a little girl?!”  She squeezes down on your long-suffering nipples, causing you to cry out again, then relents just a little.  “Well? Answer me.  Do you want to be the little girl?”

You stammer some form of response, feeling hot, and trapped, and confused, and wanting to get out but also desperate to stay and find out what happens <i>next.</i>  Why <i>did</i> you do this to yourself, anyway?  <i>Did</i> you even do it, or was it done to you... Or is this just how you’ve always been?  You’re so confused, the smoke drifting from the cave combining with the heat and the oppressive bear hug from Izumi to leave you feeling muggy and unfocused.  It must be having some kind of aphrodisiac effect on you, or something. Suddenly, Izumi chuckles, gentle and soft, mere inches from your ear.

“It’s fine.  Relax, kitten; I don’t care what kind of crazy kinks you think you need to get yourself off,” She murmurs, reassuringly. Then you feel her hand take gentle hold of your wrist. “But I </i>do<i> want to see it happen...” She adds [if (!pc.isTaur), guiding your hand down to your own nethers, which you’re shocked - in a foggy, distant kind of way - to discover are sopping wet.|.]

“You’re not leaving ‘til I see your O-face,” She purrs, her tongue slipping out to give your neck and cheek a long, lascivious lick, making you shudder as the hot, wet sensation glides over your [skinfurscales]. “So unless you want to accidentally train yourself into having a fetish for all this pretend-schoolgirl stuff, I’d get busy... Or don’t,” She pushes her face into your neck, leaving a line of kisses up to your ear as the smoke-scent of her hair fills your nose. “Your call. Personally, I think you’d look pretty cute in a uniform.”

You groan in equal parts arousal and terror at the idea, then silently acquiesce to Izumi’s demands, slowly beginning to masturbate, still cradled in her arms as she watches with interest from over your shoulder.  Occasionally, Izumi will offer advice on technique or ask if you really do it ‘like that’, leaving you half wishing she’d shut up and half wishing she’d show you how it’s done.

Given your already addled and aroused state, it isn’t long before you feel your orgasm building. Izumi seems to feel it too, as she grips your masturbating wrist forcefully, holding it in position, while her other hand turns your head to face her. “Keep doing it, exactly like that. Fast and hard. Don’t dare look away.” She commands, and you’re far too far gone to disobey.  

Finally, your wave crests, and you let out a strangled scream of pleasure as you cum, bucking and jerking in Izumi’s arms.  Through your entire orgasm, she holds your head in place and regards you carefully with a quiet, satisfied leer. Finally you collapse, panting, against the oni woman’s bulk, shivering and exhausted. 

“Good girl,” Izumi says, kindly, giving you a gentle kiss on the forehead as you rest your fatigued body against her bust. She reaches down between your legs and gives your still-throbbing pussy a couple of wet, slapping pats, as though congratulating it on a job well done... The impacts unfortunately causing you to yelp and tense up again as another mini-orgasm rolls through you. “Hah! Sorry. Didn’t think you would still be that sensitive. But, you did good, [IzumiShort].” She releases you, finally, and you slide to the floor, struggling to stand as Izumi hands you your clothes.

“Come back any time, sweet stuff,” She says, blowing you a kiss as she wanders back to her pipe. “Always got time for cute little morsels like you.” You nod, absently, as you stagger from the cave and make your way back to camp.

A schoolgirl outfit would be a pretty kinky thing to own, you have to admit... [END]

[If the PC has C-Cup+ boobs:]
“Hrm.. Not bad, I guess. Not bad at all,”  Izumi grunts, somewhat appreciatively, as she manhandles your rack with skilled, articulate fingers. “Yeah, I’d say you’re just about the right size here.”  Her hands glide over your ample bust, examining it in detail, the soft sensation of her palms gliding over your bare skin, coaxing your nipples to hardness, gently squeezing or massaging the flesh, all of it feeling decidedly good.

Satisfied with her inspection, one giant hand slides [if (pc.isNaga) over your [hip] |[if (pc.isDrider) between your spindly legs, slapping them lightly to force you to spread them wider.| between your thighs, slapping them lightly to force you to open them wider]].  The pressure of her breasts pushing into your back increases as she draws you into a one armed hug, resting her chin on your shoulder and nuzzling her face into your neck.  “Let’s play!”  She announces in a cheery, sing-song voice.  Then her tongue snakes out, feeling inhumanly long as it slides across your flesh from the base of your neck to your cheek.  “Well, I say ‘let’s’... don’t worry, kitten. I’m just gonna mess your head up for a little while, that’s all. I’ll try not to make you swear off men for good, though...”  She chuckles breathily into your ear as her questing hand snakes [if (pc.isNaga) along | between] your [legs] to trail ever-so-softly over your nethers, a feather-light touch clearly designed to leave you wanting more.

Perhaps the worst - or possibly the best - part is that it’s working.  The soft, whispery sensation of Izumi’s fingers dancing <i>just</i> close enough for you to feel them but never actually close enough to make full contact is beginning to work its frustrating magic on you, leaving you feeling increasingly hot and needy.  Your discomfort is clearly obvious to Izumi, judging by the obscene leer on her face.

“Aw, whassamatter?”  She purrs, “You want me to quit playing around? Haha, geez, you’re such a dyke!”  Izumi laughs again, pressing her cheek affectionately against your neck as she peers down at your dampening crotch.  “Alright, alright,”  She smirks, giving one of your breasts a quick, chastising squeeze.  “I’m gonna start with the real thing now, okay?”  You feel one oversized finger suddenly slide between your lips as Izumi prepares to slip it inside you.  You nod your head, eagerly, feeling glad of the chance for some real stimulation as opposed to the mean-spirited teasing of earlier.

Izumi’s finger is naturally much larger than your own, so thick that it feels almost like an actual cock, rather than just a probing digit... But the way it flexes and bends within you, slowly worming its way in deeper to gently probe at your most sensitive spots, is distinctly different.  

[if (pc.looseness <= VAGINA_LOOSENESS_NORMAL)She takes it slowly, pushing into you with agonizing care so as not to cause you any distress.  Inch by inch, centimeter by centimeter, she slides her finger into your pussy, finally bottoming out down to the knuckle.  You let out a little gasp of surprise and alarm as she gives her finger a sudden quick, tickling twitch, as though tickling a pet under its chin, then grins savagely at your reaction.]

[if (pc.looseness >= VAGINA_LOOSENESS_GAPING)
Izumi’s finger slips between your cavernous walls with ease, quickly bottoming out inside you.  She lets out an amused grunt of surprise at the ease with which she’s able to fit her finger inside you.

“I guess someone’s been busy, huh? And here was me thinking you were a nice girl.”  Izumi teases.  “Well, I guess we can skip the foreplay then...”]

One hand now actively engaged in exploring your nethers, Izumi begins to grope your [chest] in earnest, nibbling on your neck as she grips a nipple between thumb and forefinger and squeezes, almost painfully tweaking and pulling at the sensitive flesh.  She pulls gently but insistently at your [nipple] in a rhythmic motion.  “Haha, say... You ever been milked, [IzumiShort]?”  She murmurs, ominously. 

[if (pc.lactationQ() > 0) You let out a moan of pleasure as a sudden jet of milk spurts from your heavy breasts, splattering across the rocky ground.  Izumi doesn’t let up though, instead working your nipple even harder, almost feverishly pinching and squeezing away, forcing more and more of the warm liquid to be coaxed free of your bust.  

[if ((pc.hasStatusAffect("Breasts Milked") > 0) && (pc.lactationQ() > 750)) You instinctively relax and lean back into the cushioned softness of Izumi’s breasts as the familiar sensation of being milked washes over you.  Your breasts respond readily to the repeated stimulation, great jets of milk answering the insistent urging of Izumi’s fingers.  Her other hand detaches itself from your groin temporarily to begin cupping and squeezing at your bust as well, much to your enjoyment.  You lay there in her arms, gazing down at your [chest] as you are being milked, and you can’t help but think to yourself [if (pc.corruption < 40) ‘How did this happen?‘  How did you get into this bizarre state, this weird situation?  It seems so strange, and yet, you can’t seem to summon up the energy to object or resist at all.  Perhaps, you wonder briefly, it has something to do with that damned smoke.  Izumi <i>was</i> smoking something, after all, and if it’s strong enough to affect a person as huge as her... | [if (pc.corruption >= 40 && pc.corruption <= 90) how surprisingly pleasant this is.  Izumi’s treatment of your nipples is getting a little rough, but you can’t deny that it does feel good to be milked so intimately, your breasts being emptied, spurt by spurt.  You smile, dully, and resolve to just enjoy the sensation while you can.  After all, it isn’t like enjoying yourself once in a while is going to lead to anything bad. | how good it feels to be milked again.  How <i>hot</i> it feels, having someone work over your body like this, manipulating your swollen teats until they give up their cargo of your precious milk.  Izumi’s hands are rough and methodical, squeezing out an dribbling arc from one breast, then the other; left, right, left, right, left, right, an endless, mechanical rhythm, by this point completely bereft of sensuality. ]

But that just adds to your arousal.  There’s something about the situation that you just can’t help but find strangely thrilling.  You’re actually quite enjoying the sensation of being milked; it feels somehow... Right. You feel docile.  Placid.  Satisfied with your place in the world, as though you really were just some dumb animal, being harvested for her milk - like a cow.

The thought sticks in your brain, and you find it quite an enjoyable little fantasy; the idea of being reduced to something so basic, so animalistic, is kind of a turn-on.  Even the movement of Izumi’s hands, first one teat, then the other, seems reminiscent of the act of milking a cow.  No, not teat, you correct yourself with a giggle. - <i>udder.</i> Cows have <i>udders,</i> don’t they?

Enraptured by the concept, you submerge yourself in fantasy as Izumi drains your fat, eager udders.  Your eyes roll back into your head as you daydream of rough hands, methodical inspections of your swollen breast-udders, and finally the chilling thrill of being guided towards the cold embrace of those steely, sucking tubes for another day’s ‘work’.  You’re not entirely sure through your lust-addled haze, but you think you might even have heard yourself murmur out a little ‘moo’ once or twice...

Finally, you realise - with a slight note of disappointment - that Izumi has finished, her hand snaking back down [if (pc.isNaga) to | between ] your [legs] as she returns her attention to your groin.] // End Lactation Content

Despite her earlier protestations of inexperience when it comes to women, Izumi certainly seems to know what she’s doing.   It isn’t long before you’re squirming in her grip, panting helplessly as you instinctively roll your hips in response to Izumi’s skillful fingers, all the while flicking her thumb across your by now hypersensitive [clit].  Her tongue slides lasciviously across your neck, feeling impossibly long and causing you to gasp and shiver as you wonder just what other uses she might find for it before too long...

You open you mouth to gasp for air, Izumi’s head darts forwards and she locks her lips to yours, pulling you into a sudden french kiss.  Her tongue wraps around your own, bizarrely flexible as it invades your mouth, forcing you to surrender to her embrace.  She runs her hands over your body and you can only moan feebly into her mouth as your orgasm begins to rise within you, suffusing your entire being as you flex and strain inside Izumi’s iron grip.  You squirm and buck your hips desperately and Izumi pins you down, riding out your orgasm as she strums away at your desperate nethers, your juices splattering wetly across the cave floor.

Izumi releases you, a trail of saliva hanging between your exhausted mouths for a moment before she gives you an indulgent pat on the behind and rises to her feet, licking suggestively at her fingers. You shakily pull your clothes towards you and redress, while Izumi settles back down to take a long drag from her pipe, eyeing you with clear amusement as you attempt to cover yourself.  You decide to make your escape before the big woman decides to rope you into another, more strenuous round of sexual wrestling...

[ExhibitionVariant] (TODO)
For some reason, you find that idea to be quite possibly the hottest thought you’ve ever had.  You’re surrounded by a ring of barely-unseen onlookers, all waiting to see you get fucked, many of them already masturbating just at the sight of your naked form.  Without a moment’s hesitation [if (pc.isBiped) , you spread your legs a little wider, | you ] arch your back a little further, muscles straining as you struggle to present a better view to your audience.  You moan with greater enthusiasm, hoping to draw in a larger crowd.  You feel Izumi’s breasts shake, pressed up against your back, as she chuckles to herself.

“Get off on being watched, huh?  That’s kinda slutty, you know?  Well, I don’t mind playing you in front of a crowd,” She purrs into your ear.  “But if you’re <b>that</b> kind of kinky, maybe you wanna try a little... Audience participation?”

:[YES][NO]

[NO]
:[NonExhibitionVariant]

[YES] (TODO)
You nod your head vigorously at the idea of getting some of your beloved audience actually involved.  Izumi chuckles again.

“Alright. Let’s get this party started, then.”  Izumi releases you and stands.  You start to follow, thankful of the opportunity to stretch out your strained muscles, but Izumi places a hand firmly on your head and pushes you back down.  “Oh no,” she says, smiling at you. “No, you just sit right back down. You’re going to be staying on your knees for a while, [IzumiShort].”  Her words send a chill of excitement rushing through you, so you obediently adopt a kneeling position, waiting patiently.  Izumi’s smirk only grows wider as she pats you on the head.  Then she turns towards the assembled crowd of lurking masturbators.

“Hey out there!  Turns out my friend here is just too big a slut to resist the smell of some juicy cock, and you got her all riled up.  So, with that in mind,” She announces, loudly.  “She’s up for public use.  Who’s first?”

There’s a moment of deathly silence that seems to stretch for minutes.  Then, suddenly, an imp comes hurtling out of cover, already reaching for his loincloth, casting a wary glance at Izumi.  She gives him a winning smile, like a shopkeeper welcoming a client.   You realise that would make you the merchandise in this situation, and for some reason it just turns you on even more.

“Lucky number one!”  Izumi extends a hand towards you in an expansive gesture.  “She’s all yours.  Pick any hole, she’s too cockhungry to care.”  The imp eyes you up for a moment, then steps onto your [if (pc.isBiped) thighs | [legs]], pulling aside his loincloth to reveal his raging erection.  It bobs up and down, the bulbous head mere inches from your face.  “Well?”  Izumi asks.  “What are you waiting for?  Get started, slut!”

Hesitantly, you lean forwards and envelop the imp’s waiting cock into your mouth.  You struggle not to think about the taste as you submissively service the imp, but then you notice from the corner of your eye that the ring of observers have crept a little closer, leaving the safety of their rocky hiding spots to get a better view...  a better view of you.  A better view of you, naked [if (pc.isBiped)and on your knees], sucking on an imp’s cock like it was candy.  Suddenly, it doesn’t seem nearly so bad.

“You wanted to give them a show, right?”  Izumi whispers to you, still grinning.  You nod your head as best you can around the stiff phallus invading your mouth.  “Well then, in that case...  Do it right, you stupid slut!”  She roars suddenly, grabbing you by the back of the neck and forcing your face down onto the imp’s cock.  You gag and squeak in surprise as you find your nose suddenly pressed up against his stomach, his thick meat invading your throat, cutting off your air.

“This crowd came here to see a whore getting fucked, not to see some amateur try her best.  If you aren’t gonna try, I’ll do it for you.”  Izumi’s expression is almost feral with lust as she forces you into a brutal [if (pc.hasMuzzle) muzzle | face]-fuck, tears of exertion streaming down your face.  “Tongue his balls, then you get to come up for air,” she commands, and you comply.   A few seconds later, you’re rewarded with the distinct hot, gloopy sensation of the imp blowing his load into your throat - and, much to your lust-addled surprise, a quick shoulder-squeeze from Izumi.  “Sorry if I’m being a little rough, [IzumiShort]. Just playing the part, you know?”  She whispers, reassuringly.

The imp pulls himself free of your mouth, staggering away to the safety of the rocks.   More importantly however, you realise that the ring of spectators has begun to close in, apparently satisfied that they’re no longer confined to just spectating.

“Hope you’re ready for round two.” Izumi mutters.  You can’t help but nod, smiling hungrily as you eye the approaching crowd.

An hour later, after having licked, sucked, deepthroated and fucked your way through an endless parade of harpies, goblins and imps, the crowd finally disperses.  Of course by that point, you’re barely aware of it, having lost track of pretty much everything aside from the ‘client’ currently employing your services some time ago in a haze of wanton sluttery.  Izumi swims blearily into focus, shaking her head in amusement.

“Well, that was certainly quite the performance,” she says, archly. “I kinda wish I’d just kept you to myself now.”  She tuts, then shakes her head again.  “Geez, you’re in no condition to be walking around alone.  I’d feel pretty bad if I let you wander off like this and let something happen to you, so I guess...”  She reaches down and grips you by the wrist, pulling you to your feet and wrapping an arm around your waist to support you. “<b>I’ll</b> have to take you home.”

You’re in no position to resist as Izumi casually marches off into the cave, dragging you along.  The best you can do is stumble along next to her, even a journey as short as heading back into the gloomy cave difficult after such an extensive public performance.  She bundles you inside of her tent tenderly, and you quickly surrender to exhaustion...

You jerk upright with a start, warm bedding falling away from your body, the last few hours slowly beginning to filter through the sleepy haze clouding your thoughts.  Izumi seems to have worn herself out too, splayed out across the floor beside you.  You look around, gathering your bearings before deciding a sneaky exit from the Oni's home is your best course of action...

		}
	}
}