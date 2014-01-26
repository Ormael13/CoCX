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
	
		
		// Entry point from HighMountain explores
		public function encounter():void
		{
			if (flags[kFLAGS.IZUMI_MET] == 0)
			{
				flags[kFLAGS.IZUMI_MET] = 1;
				
				outputText(<![CDATA[
As you wander the wasted landscape searching for anything of interest, you come across a large rock blocking what appears to be the entrance to a cave.  Wondering about how to best get around it, you suddenly become aware of a strange sound on the edge of your hearing.

Flattening yourself against the stone in case of danger, you strain your ears and scan the horizon, searching for the source of the noise.  The volume gradually increases, and eventually you realise what it is that you’re hearing; someone nearby is loudly humming, a lively tune echoing off the rocks and cliffs.  As best you can tell, it seems to be coming from the other side of the enormous stone blocking your path.
 
Your curiosity piqued, you search around the obstruction for a way inside, and finally manage to find a slim gap between the bottom of the rock and the cliff face.  Kneeling down, you peer inside and can make out the distinct glowing embers of a campfire.  You’re pretty sure you can make it inside, but it might be difficult to get away if danger threatens.  On the other hand, wild animals don’t light campfires, and a lust-crazed demon probably wouldn’t bother to hide itself so effectively....]]>, true, true);

				menu();
				addButton(0, "Enter", enterFirstTime);
			}
			else
			{
				outputText(<![CDATA[
As you wander the wasted landscape searching for anything of interest, you find yourself face to face with a familiar large boulder; the same one hiding the entrance to Izumi’s cave.  Once again, you become aware of a strange sound on the edge of your hearing.  Carefully positioning yourself at the gap between the boulder and the cave entrance, you turn your ear to the source of the noise and manage to pick out what it is that you’re hearing; somebody is loudly humming, the same lively tune you heard during your previous visit.

Considering how your last visit to the cave ended, you hesitate for a moment and wonder if you should push forward to enter Izumi’s home... or if turning back to camp would be a wiser decision.]]>, true, true);
				menu();
				addButton(0, "Enter", enterAfterMet);
				addButton(1, "Leave", nopeLeavePlz);
			}
		}
		
		public function enterAfterMet():void
		{
			trace("placeholder");
		}
		
		// Already met, dun wanna get oniraepd again plz
		protected function nopeLeavePlz():void
		{
			outputText(<![CDATA[You decide discretion is the better part of valour and choose not to barge into the strange womans cave again, opting to slip away before she notices you hanging around outside her home.]]>, true, true);
			doNext(13);
		}
		
		// Introduce the fuckhuge oni
		protected function enterFirstTime():void
		{
			// TRIAL BY FIRE FOR THE PARSER, LETS GO
			// PC is > 9’ Tall
			outputText(<![CDATA[
			
[screen startup | 
[if (player.tallness > 108)
	[if (player.str > 75)
Putting your shoulder to the stone, you push with all your might, trying to roll it out of the way.  It resists for a moment, then gives, slowly but surely rattling and scraping across the uneven ground.  | Putting your shoulder to the stone, you push with all your might, trying to roll it out of the way.  It resists, but you are determined, your [feet] scrabbling against loose rocks and gravel, trying to find the purchase you need to move the boulder.]
			
The humming stops almost instantly, and moments later a hand suddenly rests itself on the rock in front of you.  Looking up from your exertions, you find yourself face to face with a woman.  It takes a moment, but then you realise, you really are actually face to face with her - she’s as tall as you are! [if (player.str <= 75) She gives the boulder a shove - with just one hand - and it starts to give, scraping across the uneven ground.]
			
The woman stares at you in suspicion for a moment, giving you the opportunity to study her in return.  She wears a silken kimono, embroidered with stars, dragons and flowers, which you can’t help but notice is of a truly scandalous cut – your eye is inevitably drawn to her enormous breasts, bulging dangerously against the fabric as though straining to escape.  If she were human-sized and remained in proportion, they would probably be around a DD, but at her size, you honestly have no idea.  Not only is she just as tall as you, she’s pretty built physically as well, at least from what you can see of her thighs and arms thanks to her figure-hugging outfit.
			
When you finally manage to drag your eyes back to her face, her expression is quite different. Instead of suspicion, she treats you to a sly smile.
			
“<i>Well now,</i>” she drawls in a syrupy, seductive tone, twirling an errant lock of her hair thoughtfully in her fingers. “<i>You’re a </i>big<i> one, aren’t you? And here you are, [if (pc.str > 75) forcing | trying to force] your way through little Izumi’s door uninvited.  I’d tell you off, but I’ve got to admit, I don’t get many visitors of your... </i>stature.<i>  [if (player.hornType != HORNS_COW_MINOTAUR) Or at least, ones without a pair of bulls horns [if (player.hasStatusEffect("rut") == -1 && player.hasStatusEffect("heat") == -1 && player.hasStatusEffect("dysfunction") == -1) - and the temperament to match - | , ] | [if (player.hasStatusEffect("rut") == -1 && player.hasStatusEffect("heat") == -1 && player.hasStatusEffect("dysfunction") == -1) Or at least, ones without the temperament to match the... physique,] if you follow?</i>” ]
			
She turns and heads back into the cave, quickly disappearing into the gloom,  the strange woman motioning you to follower her inside with a wave.  You creep slowly into the cave, your sight gradually adapting to the darkness.
			
|
			
You squeeze through the gap, entering the cave.  Almost immediately, a palpable wave of heat rushes over you, sweat already starting to bead on your brow; it’s <i>stuffy</i> in here!
			
]
			
Now that you’ve made it inside, you can see that the cave is dimly lit by two burning braziers on either side of what appears to be a large tent of some sort.  In front of the tent, the fire smolders gently. It’s difficult to make out details, as the lighting is pretty poor, wreathing everything in strange, dancing shadows. To make matters worse, the entire place is permeated by a thick veil of smoke that makes your eyes sting [if (toughness < 75) and of course, that obnoxiously endurance-sapping heat].
			 

[if (pc.tallness <= 108)
You can still hear the humming, but at first, there doesn’t seem to be anyone around.  You creep closer to the tent, until suddenly, a huge shadow at the front of the tent shifts.  You freeze, straining your eyes through the darkness, as you suddenly realise that’s not a shadow at all - It’s an enormous figure!  You must have gasped, as without warning the humming stops.
			
			“Hm?” the shadow grunts, then speaks.  “Oh?  Now how did you find your way in here, I wonder?”  The voice is deep, rich and undeniably female, but has a gravelly edge to it like a cross between magma and molten chocolate.  You hear the hiss of indrawn breath and a small light flares up briefly in the darkness, then the shadow speaks again.  “Well, whatever. It’s been awhile since I had company, [if (pc.race == minotaur) plus it looks like you're thinking with the head on top of your neck, rather than the head between your legs, unlike the the stupid brutes who usually wander around these parts.]|[if (pc.race == DOGE) plus it looks like you'd actually be able to resist chasing down a stick, if I threw one outta' the cave.|[if (pc.race == goblin) plus you don't seem to be as insufferable as the rest of those little green whores who usually trollop around these parts, hunting their next lay.|[if (pc.race == demon) plus you're not forever going on about corruption this, enslavement that, demonic taint the other, unlike the insufferable clods who usually wander around these parts.|[if (pc.race == harpy) plus you're not screeching incessantly, like the feathery sluts who usually flap their way around these parts.  They're lucky they </i>can<i> fly, 'cause I'd give them something to really squawk about if I could get my hands on them. |[if (pc.race == basilisk) plus, you don't have the same creepy eyes that the scaley idiots from around these parts keep trying to use on me.| plus you don’t look like the troglodytes who usually wander around these parts.]]  Sit down, sit down!”
			
			Cautiously, you edge towards the lip of the fire, and the shadow leans forward, finally becoming visible.  [if (pc.tallness < 108) For a moment, you’re stunned into silence; the figure looks completely human, aside from two important factors.  The first, her size; she looks as though someone had tried to build a human but got the scale wrong.  By the looks of her, if she was standing upright she would tower at least around eight or nine feet in height, and she looks broad enough to carry a horse on her back. | With the opportunity to finally study the strange woman in detail, you’re stunned into silence.  She looks completely human, aside from two important factors.  The first, her size; she looks as though someone had tried to build a human but got the scale wrong.  A fact you’re made aware of every time you venture from camp; it’s not every day you meet somebody just as tall as yourself. ] The second factor, of course, would be the enormous curved horn of red, rock-like bone that juts proudly from her forehead.  Still, they’re no less inhuman than some of the other creatures you’ve encountered since arriving....
			
			“Hmm?”  She looks blankly at you. The sudden realisation that you’ve been staring at her horn for an uncomfortably long time hits you.  “What?  Is there something on my face?”  Blushing, you open your mouth to answer, but as you breathe in, a rush of coarse smoke down your throat [if (pc.toughness < 60) causes you to cough and splutter. | momentarily steals your voice, having been ill-prepared for the sudden burn. ] The strange woman blinks at you in confusion for a moment, then her face cracks into a grin.  “Oh, right, I forgot people like you tend to be pretty fragile.  Hold on [if (pc.toughness < 60) , kid .  Let | , let ] me get some air in here for you...” She launches herself to her feet with surprising speed and breezes past you.
			
			Still [if (pc.toughness < 60) struggling with | distracted by ] the smoke, you turn to see her, only barely through the gloom, at the boulder blocking entry to the cave.  [if (pc.strength <= 75) To your amazement, the boulder begins to move, and as more light - along with a much-needed rush of fresh air - floods into the smoky cavern, you see she’s actually rolling it aside with her <i>bare hands</i>.  Even given her great size, this woman’s strength must be immense! | The boulder begins to move, and as more light - along with a welcome rush of fresh air - floods into the smoky cavern, you see she’s rolling it aside with her bare hands with graceful, if unnerving, ease. ]
			
			Finally, the boulder is pushed far enough that about half of the cave mouth is now open to the air. It’s still dark, but at least now you are able to see well enough to make out actual details as the woman strides casually back to you to retake her seat.  She smiles again, her features broad and honest, framed by an enormous chaotic mass of shaggy golden hair, looking for all the world like the mane of some great lion.
			
			[if (tallness) <= 108) She wears a silken kimono, embroidered with stars, dragons and flowers, which you can’t help but notice is of a truly scandalous cut – your eye is inevitably drawn to her enormous breasts, bulging dangerously against the fabric as though straining to escape.  If she were human-sized and remained in proportion, they would probably be around a DD, but at her size, you honestly have no idea. ]
			
			She sits, right knee raised so she can rest her arm on it, her left foot tucked behind the right.  As she does so, her kimono slides aside, [if (corruption < 33) exposing an uncomfortable amount of creamy-white thigh flesh. | if (corruption >= 33 && corruption <= 66) exposing a tantalising view of creamy-white thigh flesh.| if (corruption > 66) exposing a delicious view of her thigh, the creamy-white flesh screaming out for your caresses.]  If she notices, then she doesn’t seem to care. 
			
			“Better, right?”  She asks, and you nod.  “Sorry, I didn’t realise the smoke was getting to you at first.  It’s been awhile since I’ve seen anything but a minotaur or a demon, at least ones that seem more interested in polite conversation than reaming everything in sight.”  She grimaces, briefly.  “So, what’s your story, [IzumiShort]?”  Whoever she is, she seems friendly enough [if (tallness <= 96) - if a little... imposing - | , ]  so you give her your name, and hesitant to discuss your true quest in depth, detail some of your past encounters in this strange world.  Nodding encouragingly, she raises a long, elaborately carved pipe to her lips, puffing away as you tell your story….
			
			“Oh, so you’re the heroic type, yeah?  So, I guess it’s my turn now, huh?” She sighs and closes her eyes, reclining and crossing her legs.  You can’t help but notice the way her kimono slithers around her legs, mere inches from becoming truly indecent, nor the way her breasts threaten to burst free of their confinement as she stretches.
			
			“Ah, but where to begin?  My clan calls me ‘Izumi, <b>The Font Of All Strength’</b>.”  She snorts in amusement at your reaction to her name.  “I know, it’s a little pompous, right?  Just use Izumi, I always do.  Either way, I’m a traveller from another world. [if (race == “human”) I’ve met humans before a few times.  Back home, my people like to play games with them to see how they’ll react; show up, scare the locals, steal a sheep and run off giggling to yourself, that kind of thing.  Sometimes one of them is actually brave enough to come after us.  Sometimes we even slap ‘em on the back, give ‘em the sheep and then drink them under the table.”  
			
			She takes a long, powerful drag on her pipe, her lips locked tight around the mouthpiece.  “It was fun for a while, but bothering goatherds for the next thousand years wasn’t my scene, frankly, so I left.  Bailed.  Disappeared.]  I didn’t come here to fight demons or any of that nonsense, though.  I’m just looking for something <b>fun</b> to do, you know?  Something to keep my interest for a while.”  She opens her eyes again, two enormous amber irises staring thoughtfully down at you.  For some reason, you find something very uncomfortable about her gaze... [if (strength <= 75 || tallness < 96)You can’t help but feel like a sheep yourself - one who’s just noticed the wolf is staring it down.]
			
			“My mistake coming here, though.  There’s no conversationalists, no challenges, nothing fun. The only other conversations I’ve had since coming here have all gone more or less the same way, you know?  ‘Harharhar, I shall turn you into my slave!  How dare you pick me up, I shall destroy you!  Why are we heading towards that cliff!’  and so on.”  You laugh at the idea despite yourself.  
			
			Izumi seems singularly unperturbed by the sex-mad nature of this world, an attitude you find oddly refreshing.  There’s something about her; she seems to exude an aura of steady, unconcerned confidence from every movement, dripping from each word she speaks.  It’s a difficult thought to articulate, but the enormous woman’s lazy smile and relaxed attitude seem... infectious. 
			
			You talk animatedly with Izumi some more over the next hour or so, inquiring about the horn on her forehead, what life is like where she comes from, how she came to be here and a dozen other topics.  She explains that all of her race, the Oni, have horns that reflect their power and strength.  For her part, she asks a myriad questions about you and your home world.  When you ask about the pipe she’s smoking, she surprises you by wordlessly handing it to you.
			
			:[Smoke][NoSmoke]
[button doSmoke | Smoke]
[button noSmoke | NoSmoke]
]
			
[screen smoke |
			Whatever it is she has in there, the smoke is thick and cloying and even the smallest puff makes [if(toughness <= 60) you cough and splutter | [if(toughness < 75) you flinch, holding back a cough | your eyes water]] - much to your mutual amusement.  You talk and joke for a while longer, the smoke making you feel incredibly relaxed, as though all the tension were simply melting from your body.  [if (toughness <= 80) After a while, you find it hard to even raise your arms to reach for the pipe again.]
			
			dynStats(“libido”, 0.95, “speed”, 0.90, “toughness”, 1.05, “sensitivity”, 1.1, “lust”, 20)
			
[button smokeJoins | Next]
]

[screen noSmoke |
			You do your best to politely refuse the pipe, explaining your unwillingness to eat, drink, chew, chug or otherwise consume various items you’ve come across during your travels, having witnessed some of the effects.
			
			dynStats(“lust”, 10, “speed”, 0.95, “sensitivity”, 1.05, “libido”, 0.975, “toughness”, 1.025);
			
[button smokeJoins | Next]
]

[screen smokeJoins |
Finally, the two of you seem to run out of things to speak about and the conversation dies down. Izumi puffs on her pipe and lets out a long column of smoke, still gazing at you speculatively. “Hmm.  You’ve been pretty interesting.  I didn’t expect to meet anyone who might be <b>fun</b> out here.”  She mutters.  “If you <b>are</b> going to keep going with this whole heroic deeds thing, try not to die, okay?  You’re the only halfway entertaining person I’ve met on this rock, and I’d hate to imagine you winding up as some imp’s body pillow, or whatever....”
			
			You hear Izumi let out a quiet giggle.  Looking up, you see she’s shifted closer to you, edging right up to the fire.  She makes a show of appraising you physically, her golden-amber eyes sparkling in the dancing firelight as her gaze roams over your body, from head to [foot].  [if (strength <= 75 || toughness <= 75 || tallness <= 96)You swallow, hard, suddenly feeling oddly nervous.]  She’s even larger up close, and you can clearly see the solid, capable looking muscle that makes up her frame…
			
			
			[if (pc.tallness <= 108)
			“You know, you’re pretty cute.  Did I already say that?  Well even if I did, it’s true.  I like brave people.  I like people who challenge themselves.  You’re pretty brave, surviving in a place like this all alone, you know?”  Without warning, she leans forwards over the dying fire, the ruddy light from the coals illuminates her face from below, giving her a decidedly sinister air.
			
			“I think it’s about time you repaid me for my hospitality.”  She says, her eyes glittering dangerously in the firelight.  “After all, you came into my camp uninvited... that’s pretty rude, you know?  I think I might take offence to that.”  As she speaks, she slinks closer to you on all fours like some kind of predatory cat, about to make the final killing leap upon it’s helpless prey... Her personality has changed completely from the gentle giant you were speaking with a second ago.  You suddenly wonder if perhaps the smoke is somehow affecting her.
			
			“I think you’d better make it up to me, yeah?”  She continues, slurring her words slightly as she reaches out with one hammer-like hand, then seizes hold of your [armor].  “Otherwise I might get nasty.  And you don’t want me to get <i>nasty</i> with ya’, do ya’?”
			
			|
			
			“You’re pretty impressive, you know? You’ve even gotten me a little homesick, coming in here looking like that.  How cruel. How cruel...” She presses a finger to her lips, thoughtfully.  Then she smiles, taking you by the hand and drawing you into the cave. “I know!” She says in a sing-song voice. “Since you came stomping around here so rudely, it’s only right that I get to discipline you, right? So, in return for me letting you leave... I get to do whatever I want to you in the meantime.”
			
			]
			
			You could let her continue with whatever it is that she’s planning, but her truly gargantuan stature is more than a little intimidating.  On the other hand, you could try to fight her or make a break for it, but you don’t know how well either of those plans would work out; if there’s anything Izumi appears to be, it’s physically fit... although, as your eyes begin to adjust and Izumi’s scandalous neckline swims back into focus, the third option does seem somewhat tantalizing as well...
			
			:[Fight] [Surrender] [Flee]
[button placeholder | Fight]
[button placeholder | Surrender]
[button placeholder | Flee]
]
]]>, true, false);
		}
	}
}