/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.NPCs
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armors.LustyMaidensArmor;

	public class CeraphScene extends NPCAwareContent
	{
		public function CeraphScene()
		{
		}

//VARS
//  ZETSUKO_MET:int = 406;

//Pierced Slave Encounter Chain – PC encounters an omnibus who attempts to
//trick/force the player into wearing cursed piercings.

//Ceraph the Omnibus – Manipulative, renegade demon seeking to build a harem of magically controlled bondage slaves.  Has a heavily warded and concealed lair under the mountains.  Loves humiliating males with femdom and forcing girls to fellate her.
//10 inch cock
//Juicy pussy with very wet squirts during orgasm.
//Bodily fluids raise libido & sensitivity when ingested.

//Three Levels of piercing control
//First level – One out of every 10 rounds in combat, the player's armor will briefly disappear, arousing the PC by a LOT and the enemy by lesser degree before it reappears.
//Second Level – Player character will gain high lust every time they are bound or constricted.
//Third Level – PC finds themselves incapable of attacking physically.

//How it goes down
//First Meeting – PC is unpierced, Ceraph appears as cute goblin offering a free ear-piercing that increases (cum volume/fertility).  
//If PC volunteers, PC gets pierced and Ceraph reveals herself, letting the PC know she's been duped into wearing cursed ear-rings that give will force an exhibitionism fetish upon him/her.
//If PC declines, Ceraph attacks.  If Ceraph wins, the player character is pierced.  If Ceraph loses, go to standard Ceraph loss rapes.
//If PC manages to fight her off the first time, all repeats start with the PC immediately thrown into combat with her!

//PC is @ Level one 1 piercing.
//The player character finds an impressive/scandalous looking suit of armor dropped off a normal enemy.  If the player equips it, the armor pierces their nipples and folds into itself until the player is wearing naught but a nipple-chain.
//PC can hear Ceraph's sultry voice cackling as it happens, letting them know they have a fetish for being bound thanks to the cursed piercings.

//PC is @ level 2 piercing
//Ceraph saunters up, asking the player how good it feels to expose oneself, or be tied down and restrained.  PC can tell her it's pretty damned good and ask for more or resist.
//Resist brings on a fight, losing causing piercing.
//Ceraph pierces clit, dick, or bellybutton in that order.  
//Ceraph taunts and teases player, who discovers he/she is incapable of physically attacking.

//PC is @ level 3 piercing
//Ceraph asks player to join her harem permanently.  At this point the player can volunteer for it (and only be allowed out one day a week for adventuring) or resist and fight.
//If the player joins the harem they receive a vibrating tongue-stud and gains 'lick' attack.
//If the PC loses, Ceraph has very bondagey degrading sex with the PC, but does not push the issue.

		/*MISC NOTES
		 Type 
		 0 - unpierced
		 1 - stud
		 2- ring
		 3- ladder
		 4 - hoop
		 5 - chain

		 //L1 Ear Piercings
		 player.earsPShort = "green gem-stone ear-studs";
		 player.earsPLhort = "Green gem-stone ear-studs";

		 //L2 NIP PIERCINS
		 "seamless black nipple-studs"
		 "Seamless black nipple-studs"

		 //L3 Cock
		 player.cocks[0].pShort = "diamond cock-stud";
		 player.cocks[0].pLong = "Diamond cock-stud";

		 //L3 Clit
		 player.vaginas[0].clitPierced = 1;
		 player.vaginas[0].clitPShort = "diamond clit-stud";
		 player.vaginas[0].clitPLong = "Diamond clit-stud";
		 //L3 Eyebrow
		 player.eyebrowPierced = 1;
		 player.eyebrowPShort = "diamond eyebrow-stud";
		 player.eyebrowPLong = "Diamond eyebrow-stud";
		 */


//[Beat Ceraph And Rape Her]
//Ceraph's fluids boost PC libido and sensitivity massively either way.
		internal function maleFuckCeraphsPussy():void
		{
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00291]++;
			spriteSelect(7);
			clearOutput();
			//UBER-Fullbodypenetration
			if (!player.isTaur() && player.biggestCockArea() > 500 && (player.statusEffectv1(StatusEffects.Exgartuan) == 1 || monk >= 5)) {
				hugeCorruptionForceFuckCeraph();
				return;
			}
			if (player.cockArea(0) <= monster.vaginalCapacity()) {
				//[Male] Fuck 'Dat Pussah
				//[lust]
				if (monster.lust >= monster.eMaxLust()) {
					outputText("Ignoring her squeals of pleasure, you force Ceraph onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Mindful of her demonic wiles, you pull her hands together and use a few tattered strips of cloth to bind them over her head.  Moaning with helpless desire, the demon grinds her crotch against your " + player.leg() + ", spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.\n\n", false);
				}
				//[hp]
				else {
					outputText("Ignoring her grunts of pain, you force Ceraph onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Wary of the demon's abilities, you tie up her hands with a few tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.\n\n", false);
				}
				outputText("Ceraph licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me, champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"\n\n", false);

				if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.", false);
				else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.", false);
				else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.", false);
				outputText("  It's too late for her to have any hope of swaying you anyway.  You strip off your " + player.armorName + " ", false);
				if (flags[kFLAGS.PC_FETISH] >= 1) {
					outputText("getting an exhibitionist thrill ", false);
				}
				outputText("and begin stroking ", false);
				if (player.totalCocks() > 1) outputText("each of ", false);
				outputText("your stiff " + player.multiCockDescriptLight() + ", preparing to penetrate her.\n\n", false);

				outputText("Ceraph squirms in the dirt as you bring your " + player.cockDescript(0) + " closer and closer to her female hole, her cock twitching with need like some kind of perverse, mutant clit.  Her hips twitch at you, as if eager to devour your maleness.  You don't keep her waiting, ", false);

				if (player.cockArea(0) < 40) {
					outputText("and with a forceful thrust, you sheath yourself inside the demon's unholy pussy", false);
				}
				else outputText("and with a mighty effort, you force your over-sized cock inside her.  For a moment all you can do is stare in awe as it distorts her body – the fact that such a thing is possible puzzles you", false);
				outputText(".  Her interior is inhumanly hot and covered with thousands of slippery protrusions, each rubbing against your dick's flesh.  The orgy of sensation is incredible, and you immediately begin fucking your bound, demonic captive as the need to orgasm rises within you.\n\n", false);

				outputText("The defeated omnibus mewls in mock protest, \"<i>Oh, don't cum in my demonic twat, dear champion!  If you do, you'll never want any other pussy ever again!</i>\"\n\n", false);

				outputText("You grunt, pounding her harder and faster than before, knowing you couldn't pull out of her vise-like pleasure-hole if you wanted to.  It feels too good to hold out or resist, and you drop down, adjusting your angle as you rape the beautiful omnibus.  You're grunting like an animal, humping her as fast as your body will let you, but she lies under you with a serene and enticing expression, as if she's greatly enjoying the situation and awaiting your orgasm.  You pinch her nipple roughly, irritated by her superior air, but it only makes her wriggling pussy get even wetter.  It clamps down on you, wringing your " + player.cockDescript(0) + " dry as it erupts in a powerful orgasm.\n\n", false);

				outputText("Ceraph squeals happily, her sultry visage fracturing into an uninhibited expression of pleasure as she cries, \"<i>Fill me with your seed, champion!  Dominate the demon with your mighty spear!</i>\"\n\n", false);

				outputText("Her purple-hued pussy spasms around you, its oddly textured interior rippling and sucking in time with your ejaculations, drinking down your cum.  Ceraph squirms happily while her body absorbs your jizz with her impossibly pleasurable hole.", false);
				if (player.cumQ() >= 500 && player.cumQ() < 1000) outputText("  Her belly begins to rise with the volume of cum she's absorbed, and you finish your orgasm with a mildly pregnant demon underneath you.", false);
				else if (player.cumQ() >= 1000) outputText("  Her belly rises quickly from the volume of cum you're pumping into her, swelling up until she looks ready to give birth, but her taut purple body seems to handle the strain quite well, save for her belly-button turning into an outtie with an abrupt 'pop'.", false);
				outputText("  The omnibus' nubby shaft twitches happily and squirts out tiny dribbles of demon-semen, too left out by the sex to achieve a truly enjoyable orgasm, but more than willing to leak cum.\n\n", false);

				outputText("Ceraph exhales with exhaustion and rubs her hands over her belly, cooing, \"<i>So, you really did give up all your semen to me.  I guess I'll have to name the first imp I birth from this after you, won't I?</i>\"\n\n", false);

				if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n", false);
				else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n", false);
				else outputText("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit him on my cock first chance I get, dear.</i>\"\n\n", false);
				outputText("As you leave, you don't bother to spare a glance at the confused omnibus.  She isn't worth your time.", false);
			}
			else {
				//[MALE TOO DAMN BIGGA WIGGA]
				//[lust] 
				if (monster.lust >= monster.eMaxLust()) outputText("Ignoring her squeals of pleasure, you force Ceraph onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Wary of the demon's wiles, you pull her hands together and use some scraps of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your " + player.leg() + ", spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.\n\n", false);
				//[hp] 
				else outputText("Ignoring her grunts of pain, you force Ceraph onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat. Wary of the demon's abilities, you tie up her hands with a few pieces of tattered cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.\n\n", false);

				outputText("Ceraph licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please, don't rape me Champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"\n\n", false);

				if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.", false);
				else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.", false);
				else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.", false);
				outputText("  It's too late for her to have any hope of swaying you anyway.  You strip off your " + player.armorName + " ", false);
				if (flags[kFLAGS.PC_FETISH] >= 1) {
					outputText("getting an exhibitionist thrill ", false);
				}
				outputText("and begin stroking ", false);
				if (player.cockTotal() > 1) outputText("each of ", false);
				outputText("your stiff " + player.multiCockDescriptLight() + ", preparing to penetrate her.\n\n", false);

				outputText("The " + player.cockHead() + " of your " + player.cockDescript(0) + " squishes flat against her twat, too big for her prodigious demon-cunt to swallow.  Spurred by frustrated desires, you lift her legs and wrap her girlcum-slicked thighs about your ", false);
				if (player.cockTotal() > 1) outputText("primary ", false);
				outputText(player.cockDescript(0) + ". Ceraph's smooth skin and soft thigh-flesh form a comfortably tight masturbation tube.  Starting slowly, you begin rocking back and forth, sawing your prodigious cock-flesh over her body.  The demoness swivels her hips underneath your " + player.cockDescript(0) + ", her slippery gash and near-crushed member feverishly rubbing into you.  Though you didn't get to truly violate her, her thighs and unblemished skin are more than good enough to bring you to the brink of orgasm.\n\n", false);
				outputText("The defeated omnibus wraps her arms around your " + player.cockDescript(0) + " and whines lustily, \"<i>No, please!  You'll cover me in seed and despoil my face!  Please don't glaze me in that awful stuff!</i>\"\n\n", false);
				outputText("You grunt, hold the captive by her ankles, and use her like a disposable sex-toy.  The slap of your " + player.hipDescript() + " slapping into her thighs echoes loudly, nearly drowning out the wet squishing of your " + player.cockDescript(0) + " with each violent brush against her cuntlips.  ", false);

				if (player.cocks[0].cockLength < 18) outputText("Your " + player.cockHead() + " crests between her breasts with every stroke, bumping against her chin.  It grows larger as the pleasure of the act intensifies to orgasmic levels.\n\n", false);
				else if (player.cocks[0].cockLength < 24) outputText("Your " + player.cockHead() + " slides over her cheek with every stroke, leaving a trail of pre-cum on her face.  The smudges of glistening pre grow larger and larger as the pleasure of the act nears orgasmic levels.\n\n", false);
				else outputText("Your " + player.cockDescript(0) + " slides over her face with every stroke, smearing the demon's hair with your thick pre-seed before you pull back and dribble it on her face.  The pleasure of the act is incredible, and you feel yourself getting harder as the sensation nears orgasmic levels.\n\n", false);

				outputText("Ceraph squeals and blubbers incoherently for a moment as she cums, eventually managing to scream out, \"<i>Yes, splatter me with seed!  Punish this lowly demon with your powerful spunk.  Dominaaaaate meeee~</i>\"\n\n", false);

				outputText("Underneath your own mammoth erection, you can feel Ceraph's smaller cock twisting and squirming, unloading its own hot fluids onto her sweat-slicked belly.  She wriggles and twitches under you, her thigh muscles clenching and releasing in time with her spurts as they push you beyond your limit.  You watch your " + player.cockDescript(0) + " as it strains and squirts, dumping your thick load into the demon's ", false);
				if (player.cocks[0].cockLength < 18) outputText("tits", false);
				else if (player.cocks[0].cockLength < 24) outputText("face", false);
				else outputText("long hair", false);
				outputText(".  The orgasming demonette continues to squirt underneath you, drenching and smearing herself with even more cum and her entire mid-section looks glazed in thick whitish goo.", false);
				if (player.cumQ() >= 1000) outputText("  Your prodigious fertility quickly forms a puddle around her, leaving the deceptive seductress practically submerged in cum.", false);
				outputText("\n\n", false);

				outputText("You sigh, feeling immense relief, and remove your softening bulk from atop her form.  Ceraph exhales in exhaustion and smears the mixture of cum over her belly, cooing, \"<i>So you really did give me a huge load.  I'll be sure to scoop a few batches of it into my womb so we can have lots of imps together.</i>\"\n\n", false);

				if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n", false);
				else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n", false);
				else outputText("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit them on my cock first chance I get, dear.</i>\"\n\n", false);

				outputText("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.", false);
			}
			player.orgasm();
			dynStats("lib", 3, "sen", 3, "cor", 1);
			if (getGame().inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}

//[Female] Ride 'Dat Cawk
		internal function rideCeraphsCockLikeaBAWSSexclamation11eleven():void
		{
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00291]++;
			player.slimeFeed();
			spriteSelect(7);
			clearOutput();
			//lust
			if (monster.lust >= monster.eMaxLust()) outputText("Ignoring her squeals of pleasure, you force Ceraph onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants. Wary of the demon's wiles, you pull her hands together and use some tattered strips of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your " + player.leg() + ", spreading her thighs apart into a near split and giving you a world-class view of her pulsating black demon-cock.\n\n", false);
			//[hp] 
			else outputText("Ignoring her grunts of pain, you force Ceraph onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Mindful of the demon's abilities, you tie up her hands with some tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her pulsating black demon-cock.\n\n", false);

			outputText("Ceraph licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me!  I took a vow of chastity!</i>\"\n\n", false);

			if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to get off on a sex-demon's tool.", false);
			else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.", false);
			else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.", false);

			outputText("\n\nIt's too late for her to have any hope of swaying you anyway.  You strip off your " + player.armorName + " ", false);

			if (flags[kFLAGS.PC_FETISH] >= 1) outputText("getting an exhibitionist thrill ", false);
			outputText("and begin touching your " + player.vaginaDescript(0) + ", getting yourself ready for what is to come.\n\n", false);

			outputText("You sink down, feeling yourself part around the hot demon-tool, its ring of crown-nubs stroking your walls as you slide down, and the bumpy texture of its shaft makes your " + player.legs() + " feel weak.  You drop the rest of the way down in one smooth, wet slide, ");
			if (player.vaginalCapacity() < 12) outputText("unable to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.\n\n", false);
			else outputText("able to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.\n\n", false);

			outputText("Ceraph cries in mock protest, \"<i>No, don't make me cum inside you!  Please Champion, I swore not to spill my seed, lest I father a bastard child!</i>\"\n\n", false);

			outputText("The sensations of her vibrating nodules ensure you don't have the will or the strength to pull off of her, and what little power your " + player.legs() + " have is used to keep bouncing and grinding on top of her, filling the air with wet squelches and slippery squishes.  You fall forwards, barely catching yourself before you slam into the sultry demoness.  Your ", false);
			if (player.biggestTitSize() < 1) outputText("chest ", false);
			else outputText("tits ", false);
			outputText("squish against hers, squeezing a gout of milk from her nipples.  Both pairs of ", false);
			if (player.biggestTitSize() < 1) outputText("nipples", false);
			else outputText("jiggling mounds", false);
			outputText(" feel wonderful as they're pressed between you, sliding back and forth in time with your body's urgent grinding.\n\n", false);

			outputText("The omnibus' facade of feigned innocence drops under the force of the hot, wet fuck.  Her mouth opens into an 'o' of pleasure, and you feel her rod thicken as it begins pumping the proof of her ecstasy inside you.  The nodules that cover Ceraph's demonic erection wildly vibrate as she orgasms, throwing you over the edge and into the midst of a body-shaking orgasm.  Demon-seed floods your womb, squeezed inside it by your body's orgasmic contractions.  You shudder with the demon as you both begin calming down.\n\n", false);

			outputText("She groans, \"<i>Ooooh... Champion why did you make me despoil your womb?  ", false);
			if (player.pregnancyIncubation == 0) outputText("You're only feeding the swarms of imps that are despoiling this land.", false);
			else outputText("I'm sure whatever baby you have in there won't enjoy being so soaked in corruption.", false);
			outputText("</i>\"\n\n", false);

			if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n", false);
			else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n", false);
			else outputText("You bend over and rub your belly while whispering in her ear, \"<i>Like mother, like child.</i>\"\n\n", false);
			outputText("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.\n\n", false);
			player.cuntChange(monster.cockArea(0), true);
			player.orgasm();
			dynStats("lib", 3, "sen", 3,"cor", 1);
			player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 32, 61); //Ceraph causes faster pregnancies
			if (getGame().inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}

//[OH SHIT SON YOU LOST GET EARS PIERCED]
		private function loseToCeraphAndGetPiercingsInEarsOrSomethingSomehow():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph advances on your ", false);
			if (player.HP < 1) outputText("prone ", false);
			else outputText("lust-consumed ", false);
			outputText("form, whispering calmly as she pulls a pair of gleaming, green piercings from a pouch, \"<i>Oh, don't worry baby, you're going to love this so much.  These piercings are special, and they'll help you learn to enjoy the things I'm going to teach you.</i>\"\n\n", false);

			if (player.earsPierced > 0) outputText("With a dismissive gesture, Ceraph murmurs words of dark magic and the piercings in your ears drop to the ground, leaving behind smooth, unbroken flesh.  ", false);
			//(BUSINESS AS USUAL GENTLEMEN)
			outputText("The demon places a hand on your forehead and rubs your temples.  Strength drains from your body with every touch, until you're left helpless and paralyzed.  She snaps an earring into your left ear, and dizziness washes over you.  A moment later she's piercing the other side, and the now-familiar vertigo that accompanies it seems to come and go quicker than before.  You hope she doesn't take your " + player.armorName + " while you're paralyzed, leaving you to roam the realm totally exposed.  Confusion and waves of new desire battle in your mind as you try to come to grips with the odd thought.\n\n", false);

			outputText("Ceraph watches your ", false);
			if (player.cockTotal() > 0) outputText("cock bounce in time with your fluttering heartbeats", false);
			else if (player.hasVagina()) outputText("vagina get wetter and wetter", false);
			else outputText("parted lips and confused expression", false);
			outputText(" as the new thoughts and desires settle themselves inside you.  She gives you a gentle pat and explains, \"<i>It's ok baby, you're an exhibitionist now.  The moment I put those cursed earrings in your cute little ears, they slid their magic deep inside you, teaching you how to be a good " + player.mf("boy", "girl") + " and get turned on by exposing yourself.</i>\"\n\n", false);

			outputText("Judging by how hot the idea is getting you, Ceraph is right – <b>whether you like it or not, you're an exhibitionist now.</b>", false);
			player.earsPierced = 1;
			player.earsPShort = "green gem-stone ear-studs";
			player.earsPLong = "Green gem-stone ear-studs";
			flags[kFLAGS.PC_FETISH] = 1;
			dynStats("lus", 25, "cor", 5);
			combat.cleanupAfterCombat();
		}

//[OH SHIT SON MOAR SHIT GETTING PIERCEDEDEDED] – NIPPLEZ GO
		private function loseToCeraphAnGetPierced2():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph giggles as she closes in on you once again.  Unable to fight back, you lie there as she once again massages your temples, using her magic to paralyze your body.  She's all too happy to build up the suspense as she pulls out a pair of shining black studs, \"<i>Oh, did you want to know what these are going to teach you?  Well, how about I slide them into your ", false);
			if (player.hasFuckableNipples()) outputText("slut", false);
			else if (player.nippleLength < 1) outputText("cute", false);
			else outputText("tight", false);
			outputText("-nipples and you tell me all about your fetishes and which one makes you the hottest.  OK?</i>\"\n\n", false);

			//If already pierced
			if (player.nipplesPierced > 0) outputText("With a dismissive gesture, Ceraph murmurs words of dark magic, and the piercings in your nipples drop to the ground, leaving behind smooth, unbroken flesh.  ", false);
			//Business as usual!
			outputText("The demon doesn't give you a chance to reply, instead she focuses on aligning the business ends of the piercings with your sensitive nipple-flesh.  Your right " + player.nippleDescript(0) + " is pierced in one smooth motion, nearly making you scream in pain.  As she fastens it on, you feel goosebumps spread over your body in a wave.  The second piercing doesn't seem to hurt as bad, but the sensation of spreading goosebumps is far more noticeable.  Your eyes dart wildly, afraid at what new kind of fetish Ceraph has forced upon you.\n\n", false);

			outputText("She smiles down at you and teases, \"<i>Still haven't figured it out?  I'll give you a hint:  Isn't being paralyzed nearly the same as being tied down?</i>\"\n\n", false);

			outputText("Your body goes beet-red as it suddenly tries to struggle against her invisible restraints.  It really is!  You nearly cry as the restraint turns you on more and more.  Ceraph's cursed piercings have given you a fetish for being restrained.  You nearly faint when you think of the tentacle monsters, and you know you have no hope of resisting if they ever bind you up.  <b>Somehow you'll have to get used to being a bondage fetishist...</b>", false);
			dynStats("lus", 25, "cor", 5);
			player.nipplesPierced = 1;
			player.nipplesPShort = "seamless black nipple-studs";
			player.nipplesPLong = "Seamless black nipple-studs";
			flags[kFLAGS.PC_FETISH] = 2;
			combat.cleanupAfterCombat();
		}

//[OH SHIT!  WHY DOES FEN KEEP WIRTING THAT 3RD TIME – CROTCH GO]
		private function getPiercedByCeraphLoss3():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("The demoness pulls out a diamond-studded piercing and closes in on you, her cock hard, her pussy moist, and her hips swaying seductively as she advances.  Ceraph gives you a serious look and warns you, \"<i>You know how close you are to being my pet, don't you?  You just need this piercing and a little time to get used to it.  Then if you're good, I'll strip you naked, tie you down, and let you lick me out.  We can even let the imps watch!</i>\"\n\n", false);

			outputText("The idea turns you on immensely, and you pant and gasp as ", false);
			if (player.totalCocks() > 0) {
				outputText("pre-cum oozes from ", false);
				if (player.totalCocks() > 1) outputText("each of ", false);
				outputText("your " + player.multiCockDescriptLight() + ".", false);
			}
			else if (player.hasVagina()) outputText("feminine moisture drools from between your lips and your " + player.clitDescript() + " turns into a hard button.", false);
			else outputText("your body aches for release.", false);
			outputText("  With an amused grin, Ceraph yanks down your gear and ", false);
			//[dicks]
			if (player.totalCocks() > 0) {
				outputText("grabs your " + player.cockDescript(0), false);
				if (player.cocks[0].pierced > 0) outputText(", the old piercing clattering to the ground as it slides out of your flesh, ", false);
				outputText(" and snaps the diamond stud through your sensitive flesh, making your vision haze red in pain.\n\n", false);
				player.cocks[0].pierced = 1;
				player.cocks[0].pShortDesc = "diamond cock-stud";
				player.cocks[0].pLongDesc = "Diamond cock-stud";
			}
			//[cunts]
			else if (player.hasVagina()) {
				outputText("spreads your lips", false);
				if (player.vaginas[0].clitPierced > 0) outputText(", the old piercing clattering to the ground as it slides out of your flesh, ", false);
				outputText(", getting ahold of the flesh around the base of your " + player.clitDescript() + ".  With practiced ease, she snaps the piercing closed, attaching the diamond stud to you while the pain fuzzes your vision red.\n\n", false);
				player.vaginas[0].clitPierced = 1;
				player.vaginas[0].clitPShort = "diamond clit-stud";
				player.vaginas[0].clitPLong = "Diamond clit-stud";
			}
			//[else]
			else {
				outputText("snaps the diamond stud into your eye-brow, piercing it", false);
				if (player.eyebrowPierced > 0) outputText(" and discarding your old jewelry like a piece of garbage", false);
				outputText(".  It hurts more than it ought to, fuzzing your vision red.\n\n", false);
				player.eyebrowPierced = 1;
				player.eyebrowPShort = "diamond eyebrow-stud";
				player.eyebrowPLong = "Diamond eyebrow-stud";
			}
			//Set fetish level
			flags[kFLAGS.PC_FETISH] = 3;
			outputText("As she finishes, you realize she didn't even try to restrain you!  Feeling a second wind, you twist out of her grasp before she can take advantage of your new piercing and lash out with a vicious punch.  Ceraph doesn't even try to move.  The demon watches calmly as your fist gets closer and closer, then stops, the punch turning into a gentle caress.  Horrified, you try to smack her with a " + player.leg() + ", but all you manage to do is stroke it along her inner thigh.\n\n", false);

			outputText("\"<i>So, I take it you like it?  You'll never be able to raise a hand in anger again.  I guess if you want to win fights you'll have to tease your foes into submission with that luscious body.  I suppose that might be hard to do when you're getting off on exposing yourself and cumming from the thought of being tied down,</i>\" she laughs.\n\n", false);

			outputText("You tremble in impotent fury at the violation as the demoness flounces away.  You'd pursue her, but between her ideas and exposing your crotch to the entire area, you need to cum more than anything.  You scurry back to camp, too horny to think straight and your new piercing aching just enough to keep you from forgetting about it.", false);
			dynStats("lus", 25, "cor", 5);
			combat.cleanupAfterCombat();
		}

//[FINAL ENCOUNTER LEVEL]
		private function finalEncounterLevelCeraphPiercingButtholeNipples():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph wiggles out from between the bushes, holding a bondage harness and openly eyeing your body.  She suggestively says, \"<i>Well, aren't you just a cute little slave-to-be.  Are you ready to put yourself in your slave harness and join my harem?  I've got a few more piercings I think would look great on you.  Maybe I could give you an oral fixation and a foot fetish.  Wouldn't that be nice?  Or maybe I can just keep you tied up and parade you around Mareth.  You know I'll make sure you love every minute baby, just come put this on.</i>\"\n\n", false);

			outputText("It shames you to admit it, but you desperately want to be naked and restrained, paraded around to tease and amuse Ceraph's enemies.  You know the desires were forced on you by her cursed piercings, but it doesn't make it any easier to deny the feelings they've brought out in you.  The sexy demon-dom would be happy to feed you foreign desires and stoke them into a burning blaze that would burn away your doubts and worries.  Do you give in and become her bondage slave?\n\n", false);
			simpleChoices("Yes", agreeToBecomeCeraphsFuckpetBondageToyBitchSlut, "No", finalCeraphEncounterChoiceNo, "Fight", finalCeraphEncounterStartFight, "", null, "", null);
		}

//[no]
		private function finalCeraphEncounterChoiceNo():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You tell Ceraph no, emphatically, over and over.  She gives you a smirk and says, \"<i>Whatever.  It's only a matter of time.  You'll join me soon, pet.</i>\"\n\n", false);

			outputText("With that declaration she departs, leaving you confused and horny.", false);
			doNext(camp.returnToCampUseOneHour);
		}

//[fight]
		private function finalCeraphEncounterStartFight():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You tell Ceraph no, and let her know ", false);
			if (player.cor <= 50) outputText("you'll stop her devilish scheme", false);
			else outputText("you'll be HER " + player.mf("master", "mistress"), false);
			outputText(".  She snarls and drops the harness, preparing to defend herself.  It looks like you've got a fight!", false);
			startCombat(new Ceraph());
		}

//[Yes] TO BAD END
//[Agree to become Ceraph's Fuckpet Bondage Toy bitch slut]
		private function agreeToBecomeCeraphsFuckpetBondageToyBitchSlut():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("At this point, you know she's right.  The desires Ceraph has awakened inside you will never go away.  In spite of the hassle they've caused, you've come to love being so uncontrollably aroused by such humiliating treatment.", false);
			if (player.hasVagina()) outputText("  Your " + player.vaginaDescript(0) + " tingles as you wonder how many piercings and fetishes she could fit into your labia.", false);
			else if (player.cockTotal() > 0) outputText("  Your " + player.cockDescript(0) + " grows rock hard as you wonder if she'll give you a Jacob's ladder full of new fetishes and thoughts.", false);
			else outputText("  Your body hums with arousal as you wonder if she'll give you a cock and cunt, pierce them both, and fill you with new fetishes and sexy submissive thoughts.", false);

			outputText("\n\nWith your mind made up, you give Ceraph a solemn nod.  The demon smiles knowingly and saunters up to you.  She grabs you by the head and looks you dead in the eye, as if searching for something.  Moments drag by until she releases you all at once, taking her whip and binding it crudely around your neck.  She pulls on it, forcing you down to the dirt, and commands, \"<i>Pets crawl.  And they don't wear clothes.</i>\"\n\n", false);

			outputText("She spends a few moments undressing you, then gives your " + player.buttDescript() + " a few smacks to suitably redden it.  Horrified at the treatment but more turned on than ever, you endure the humiliation, crawling after your mistress as she leads you to a new, sexy life on an impromptu leash.  You lose track of time, just focusing on putting one hand in front of the other.  Multiple times you catch glimpses of demons and monsters from the fringe of your vision, but none of them seem keen on approaching your mistress or her new slave, you.  Every time you feel their eyes on your naked " + player.skinDesc + ", you're rocked with sexual pleasure.\n\n", false);

			outputText("Absorbed in your own thoughts, you barely notice the light dim or the solid thunk of a door closing behind you.  Happy moans bring you out of your dazed state.  You've arrived at Ceraph's lair.  The demon is barely paying attention to you, holding on to your leash as she walks around greeting her other pets.  She ruffles the hair of a tiny boy wearing naught but doggie-ears and an inventive looking butt-plug that gives him the appearance of having a tail.  Ceraph tickles the crotch of a girl with more than a few demonic features.  She's tied to the wall, with two vibrators strapped hilt-deep in her abused nipple-cunts.  Her original sex is drooling but totally unfilled as she squirms in her straps while Ceraph touches her.\n\n", false);

			outputText("There are many more slaves just like those two throughout Ceraph's home.  Some are little more than furniture, some she treats like artwork, and others she uses for her sexual enjoyment.  She announces, \"<i>Pets, meet your new " + player.mf("brother", "sister") + ".  I think I'll just call " + player.mf("him", "her") + " 'pet'.  " + player.mf("He", "She") + " needs to learn her place and we're going to be teaching and piercing " + player.mf("him", "her") + " all week.</i>\"\n\n", false);

			outputText("The whip is uncurled from around your neck, and you look up, unsure of what to do.  Ceraph coos, \"<i>Good pet.  Just stay like that and pout for me.</i>\"\n\n", false);

			outputText("Not seeing the harm and seeking to endear yourself to your mistress, you thrust your lower lip out.  Your obediance is rewarded by a sharp snap of dazzling pain.  Licking experimentally, you feel the smooth band that loops over the center of your lip. ", false);
			//if pierced there
			if (player.lipPierced > 0) outputText("The previous piercing has vanished!  ", false);
			outputText("Mistress is so kind to give you such a pretty piercing!  The ease you find yourself calling her mistress shocks you, but that's what she is, isn't she?  She's your mistress and owner, and you are her pet.  You catch her looking at you expectantly and you realize she's waiting for something.\n\n", false);

			outputText("You lick your new lip-ring nervously and say, \"<i>Thank you mistress, pet is so happy to be pierced again!</i>\"\n\n", false);

			outputText("What the hell?  Did you just call yourself pet?  You struggle internally, thinking, \"<i>When did pet start thinking of " + player.mf("him", "her") + "self as pet?</i>\"  A tingle of new arousal shivers through you – Mistress Ceraph has made it impossible for you to think or call yourself anything other than pet!  What else is she going to do to you?\n\n", false);

			outputText("\"<i>Oh it's so cute watching my pets and toys truly learn their new names.  Now come here pet, a good pet wears a collar so everyone knows who " + player.mf("he", "she") + " belongs to,</i>\" says Mistress as she pulls a thick black collar off a hook on the wall.  Compliant, you allow her to fasten it around your neck, waggling your ", false);
			if (player.tailType == TAIL_TYPE_NONE) outputText("backside", false);
			else outputText("tail", false);
			outputText(" back and forth to show Mistress how happy you are.  Obedience slowly crowds your mind, rolling over your other thoughts and concerns inexorably.  Your worries, cares, and troubles slide away, replaced with an all-consuming need to please.", false);
			doNext(agreeToBeABitchPt2);
		}

//(EPILOGUE)
		private function agreeToBeABitchPt2():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Months pass in pure bliss.  Since adoption into Mistress Ceraph's harem, pet gained over a dozen piercings and nearly twice as many fetishes.  Pet learned to love spanking, and developed the ability to cum just from having " + player.mf("his", "her") + " nipples pinched or being paddled.  Ceraph enjoyed that for a while, but she did eventually tire, and pet was given a fetish for orgasm denial", false);
			if (player.cockTotal() > 0) outputText(" along with a magical cock-ring", false);
			outputText(".  Two weeks of drug and bondage induced edging nearly broke pet's mind, but Mistress was nice and let " + player.mf("him", "her") + " cum over and over after getting a new piercing and worshiping her feet for a few hours.\n\n", false);

			outputText("The champion that left Ingnam so long ago is totally unrecognizable, body and soul.  The spirit that once burned bright with the desire to save the innocents of the village has been warped and twisted beyond repair.  The once-champion known only as 'pet', not even worthy of a proper name, spends all " + player.mf("his", "her") + " time lusting after Mistress Ceraph, taking part in her depraved orgies and willingly submitting to any kinks or debaucheries that are presented to " + player.mf("him", "her") + ".  Pet's life of individuality and choice is over, all that remains is pleasure and pain.", false);

			getGame().gameOver();
		}

//[Initial Meeting Text]
		private function ceraphFirstTime():void
		{
			clearOutput();
			spriteSelect(88);
			outputText("A cute goblin steps out of the bushes, holding a pair of green earrings up to the light.  She politely asks, \"<i>Hey cutey!  I've got some spare earrings I made the other day.  I was wondering if you want them?  As you can see, my ears are already full, and my daughters are a bunch of ungrateful cunts.</i>\"\n\n", false);

			outputText("The goblin's ears are covered in a dazzling array of piercings of all varieties.  She isn't dressed nearly as slutty as most of the goblins you've seen.\n\n", false);
			outputText("Do you let her put the earrings in your ears?", false);
			flags[kFLAGS.PC_MET_CERAPH] = 1;
			doYesNo(ceraphFirstTimeVolunteer, ceraphFirstTimeDecline);
		}

//[No]
		private function ceraphFirstTimeDecline():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You decline, informing the petite girl you have no interest in her earrings.  She shrugs and laughs, her form distorting as it grows taller, twisting as her skin lightens, her breasts bulge, and a pair of cute horns breaks out of the skin of her forehead.  She pockets the earrings and stretches, revealing a glistening demon-snatch capped with a modest cock growing from where her clit should be.\n\n", false);

			outputText("The demon introduces herself, \"<i>Well if you want to do this the hard way, that's fine by me.  The ones that fight the hardest break down into the most submissive slaves.  Just remember that this is the beginning of your life as Ceraph the Omnibus' slave-" + player.mf("boy", "girl") + ".</i>\"\n\n", false);

			outputText("Ceraph adopts a suggestive pose and tweaks her nipple, clearly more intent on turning you on than physically harming you.", false);
			//FIGHTO
			startCombat(new Ceraph());
		}

//[Yes]
		private function ceraphFirstTimeVolunteer():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("The goblin motions for you to bend over, and you do.  She holds the earrings up on your ears, getting them aligned just right.  ", false);
			if (player.earsPierced > 0) outputText("Miraculously, your old earrings just fall out.  ", false);
			outputText("The earrings snap into place with a painful and definitive *click*, and dizziness hits you so hard that you nearly fall.  The goblin catches you, steadying you as you blink a few times and adjust to the sensation.\n\n", false);

			outputText("When you feel steady again, you look up and see that the tiny goblin has transformed into a nude, hermaphroditic demon!  She grins knowingly and caresses your body.  You step back and she says, \"<i>Awww, don't look so shocked dear.  You just took your first step into becoming one of my pets!  I'm Ceraph, and we're going to be getting VERY familiar with each other.</i>\"\n\n", false);
			outputText("Her forwardness brings a blush to your face and kindles a bonfire in your loins.  Somehow the thought of being nude in front of her is far more arousing than it ought to be.  You keep trying to banish the thought, but all you can think of is your nudity and how much hornier it's making you.\n\n", false);

			outputText("Ceraph breaks your reverie with a chuckle, \"<i>Oh baby, I see you're starting to figure it out.  Let me break it down for you.  <b>Those earrings have given you a fetish for exhibitionism.</b>  Being exposed and humiliated makes you hornier than a dog in heat, and even if you found a way to remove them, it's too late – they've forever linked nudity and humiliation with desire and lust in your easy little mind.  Get used to it and I'll be back to introduce you to another fun little fetish.</i>\"\n\n", false);

			outputText("The slutty demon walks away with a sexy sway, and you're too confused and turned on by your predicament to pursue her.  It looks like you'll have to do with a little extra arousal whenever you're exposed in public.\n\n", false);
			player.earsPierced = 1;
			player.earsPShort = "green gem-stone ear-studs";
			player.earsPLong = "Green gem-stone ear-studs";
			flags[kFLAGS.PC_FETISH] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

//[PC 'BEAT OFF' Ceraph the first time...]
		private function ceraphFirstTimeRepeat():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph saunters out of the bushes and gives you a disapproving look, \"<i>I tried this the easy way.  Now we're doing it the hard way.</i>\"\n\n", false);

			outputText("She uncurls a whip that lights aflame and says, \"<i>Time for your spanking!</i>\"\n\n", false);
			startCombat(new Ceraph());
		}

//[PC haz 1 piercing, trapped armor]
		/*	scandalously seductive armor – dropped off a random demonic enemy.
		 A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.
		 [After wearing]
		 While you take a break, you feel a sudden shift in your scandalous new armor.  To your horror, it begins folding into itself, revealing more and more of your " + player.skin + " and the comfortable underclothes you had on underneath it.  The transforming armor gradually covers less and less of you until it's little more than a pair of huge nipple-coverings and a silver chain.  A loud KA-CHUNK startles you, and then you're screaming as you feel something stabbing through your nipples.  Goosebumps cover your flesh as you twist in unexpected agony.  
		 After you've had a chance to recover, you inspect your abused nipples and discover that your armor has totally disappeared.  The only thing left behind is a pair of seamless black nipple-studs, embedded into your vulnerable flesh.  There doesn't appear to be any way to remove them either.  Thankfully, your comfortable underclothes have been unaffected by the sudden disappearance of your armor.  The thought of having to run around naked stays stubbornly locked in your mind, and you mentally curse the demon for what she's done to you.
		 As if summoned by your thoughts, you can hear her voice on the wind, taunting you again, \"<i>Enjoy your new bondage fetish pet!  One more piercing and you'll be ready.  Don't have too much fun being tied down and fucked ok?</i>\"
		 */
//[PC @ 2 piercings, Ceraph offers 3rd]
		private function level3CeraphOffer():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph once again appears to you, licking her lips and repeatedly swatting a riding crop against her thigh.  She asks, \"<i>Have you come to love the exposure, the helplessness, of being nude and restrained?  Does your body ache for me to turn you into a bound love-pet yet?  We could keep going down this road my pet-to-be, just one more piercing and then you'll be ready.</i>\"\n\n", false);
			outputText("Do you let her pierce you?", false);
			//[Yes] [No]
			doYesNo(yesOHGODYESPIERCELEVEL3, level3CeraphOfferNo);
		}

//[No]
		private function level3CeraphOfferNo():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You let Ceraph know that you refuse to let her violate your body and mind in such a way.  She shrugs nonchalantly and tugs on the crop, stretching it into a whip that bursts into flames.\n\n", false);
			outputText("\"<i>Mortals always want to do things the hard way,</i>\" she sighs.\n\n", false);
			outputText("<b>You've got a fight on your hands!</b>", false);
			startCombat(new Ceraph());
		}

//[YES OH YES]
		private function yesOHGODYESPIERCELEVEL3():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You nod, biting your lip anxiously and undoing your armor to give her better access to your body.  The demoness pulls out a diamond-studded piercing and closes in on you, her cock hard, her pussy moist, and her hips swaying seductively as she advances.  Ceraph gives you a serious look and warns you, \"<i>You know how close you are to being my pet, don't you?  You just need this piercing and a little time to get used to it.  Then if you're good I'll strip you naked, tie you down, and let you lick me out.  We can even let the imps watch!</i>\"\n\n", false);
			outputText("The idea turns you on immensely, and you pant and gasp as ", false);
			if (player.totalCocks() > 0) {
				outputText("pre-cum oozes from ", false);
				if (player.totalCocks() > 1) outputText("each of ", false);
				outputText("your " + player.multiCockDescriptLight() + ".", false);
			}
			else if (player.hasVagina()) {
				outputText("feminine moisture drools from between your lips and your " + player.clitDescript() + " turns into a hard button.", false);
			}
			else outputText("your body aches for release.", false);

			outputText("\n\nWith an amused grin, Ceraph yanks down your gear and ", false);
			//[dicks]
			if (player.cockTotal() > 0) {
				outputText("grabs your " + player.cockDescript(0), false);
				if (player.cocks[0].pierced > 0)
					outputText(", the old piercing clattering to the ground as it slides out of your flesh,", false);
				outputText(" and snaps the diamond stud through your sensitive flesh, making your vision haze red in pain.", false);
				player.cocks[0].pierced = 1;
				player.cocks[0].pShortDesc = "seamless, diamond cock-stud";
				player.cocks[0].pLongDesc = "Seamless, diamond cock-stud";
			}
			//[cunts]
			else if (player.hasVagina()) {
				outputText("spreads your lips", false);
				if (player.vaginas[0].clitPierced > 0) outputText(", the old piercing clattering to the ground as it slides out of your flesh,", false);
				outputText(" and gets ahold of the flesh around the base of your " + player.clitDescript() + ".  With practiced ease, she snaps the piercing closed, attaching the diamond stud to you while the pain fuzzes your vision red.", false);
				player.vaginas[0].clitPierced = 1;
				player.vaginas[0].clitPShort = "seamless, diamond clit-stud";
				player.vaginas[0].clitPLong = "seamless, diamond clit-stud";
			}
			else {
				outputText("gives you a mildly annoyed look before she snaps the diamond stud into your eye-brow, piercing it.  ", false);
				if (player.eyebrowPierced > 0) {
					outputText("She discards your old jewelry like a piece of garbage.  ", false);
				}
				outputText("It hurts more than it ought to, fuzzing your vision red.", false);
				player.eyebrowPierced = 1;
				player.eyebrowPShort = "seamless, diamond eyebrow-stud";
				player.eyebrowPLong = "seamless, diamond eyebrow-stud";
			}
			outputText("  As she finishes, you feel grateful that she's so willing to lavish you with such sexy jewelry and teach you how to enjoy these wonderful new experiences.  You give her a wet kiss, wondering what she's done to you, but in the end you don't really care.  Somehow you know it's going to make you feel even more like a horny, hot, and obedient sex-pot for your demonic mistress.\n\n", false);
			outputText("\"<i>So, I take it you like it?  You'll never be able to raise a hand in anger again.  I guess if you want to win fights you'll have to tease your foes into submission with that luscious body.  I suppose that might be hard to do when you're getting off on exposing yourself and cumming from the thought of being tied down,</i>\" she laughs.\n\n", false);
			outputText("You tremble with barely restrained lust as the demoness flounces away.  You'd pursue her, but between her ideas and exposing your crotch to the entire area, you need to cum more than anything in the world.  You scurry back to camp, too horny to think straight and your new piercing aching just enough to keep you from forgetting about it.", false);
			flags[kFLAGS.PC_FETISH] = 3;
			doNext(camp.returnToCampUseOneHour);
		}



		public function encounterCeraph():void
		{
			//Just in case set up next button for 1 hr + camp
			doNext(camp.returnToCampUseOneHour);
			//If havent met her
			if (flags[kFLAGS.PC_MET_CERAPH] == 0) {
				spriteSelect(7);
				ceraphFirstTime();
				return;
			}
			//If still not fetished by her
			if (flags[kFLAGS.PC_FETISH] == 0) {
				spriteSelect(7);
				ceraphFirstTimeRepeat();
				return;
			}
			//If fetished level 1
			if (flags[kFLAGS.PC_FETISH] == 1) {
				outputText("Though you spend an hour exploring, you don't find anything of note.", true);
				return;
			}
			//fetished level 2
			if (flags[kFLAGS.PC_FETISH] == 2) {
				spriteSelect(7);
				level3CeraphOffer();
				return;
			}
			//fetished level 3
			if (flags[kFLAGS.PC_FETISH] == 3) {
				spriteSelect(7);
				finalEncounterLevelCeraphPiercingButtholeNipples();
			}
		}

		public function winRapeChoices():void
		{
			//FOLLOWER CHANCE:
			var leave:Function = combat.cleanupAfterCombat;
			if (!getGame().inCombat) {
				//Load ceraph and set up win conditions
				startCombat(new Ceraph());
				leave = ceraphFollowerScene.ceraphFollowerAppearance;
				//Exit combat
				getGame().inCombat = false;
				monster.lust = 100;
				monster.HP = 2;
				if (player.lust < 34) player.lust = 34;
			}
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00291] >= 4) {
				ceraphFollowerScene.submissiveCeraphOffer();
				return;
			}
			//Normal stuff here
			spriteSelect(7);
			clearOutput();
			if (monster.HP < 1) outputText("Ceraph collapses in a beaten, bloody heap.", false);
			else outputText("Ceraph masturbates futilely, too driven by desire to fight.", false);
			if (player.lust >= 33 && player.gender > 0) {
				outputText("  Do you have your way with her? (And if so, which of your body parts do you do it with?)", false);

				var dicking:Function =null;
				var buttsmexing:Function =null;
				//Dickings ahoyu!
				if (player.hasCock()) {
					dicking = maleFuckCeraphsPussy;
					if (player.cockThatFits(monster.analCapacity()) != -1) buttsmexing = buttRapeCeraph;
					else outputText("  <b>There's no way you could fit inside her ass - you're too big.</b>", false);
				}
				var cunting:Function =null;
				if (player.hasVagina()) cunting = rideCeraphsCockLikeaBAWSSexclamation11eleven;
				var bikiniTits:Function = null;
				if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") bikiniTits = createCallBackFunction2((player.armor as LustyMaidensArmor).lustyMaidenPaizuri,player,monster);

				simpleChoices("Fuck Her", dicking, "Ride Her", cunting, "FuckHerAss", buttsmexing, "B.Titfuck", bikiniTits, "Leave", leave);
				/*
				 if (player.gender == 1) doYesNo(maleFuckCeraphsPussy, combat.cleanupAfterCombat);
				 if (player.gender == 2) doYesNo(rideCeraphsCockLikeaBAWSSexclamation11eleven, combat.cleanupAfterCombat);
				 if (player.gender == 3) simpleChoices("Fuck Her",maleFuckCeraphsPussy,"Ride Her",rideCeraphsCockLikeaBAWSSexclamation11eleven,"",0,"",0,"Leave", combat.cleanupAfterCombat);
				 */
			}
			else {
				if (getGame().inCombat)
					combat.cleanupAfterCombat();
				else doNext(ceraphFollowerScene.ceraphFollowerAppearance);
			}
		}

		public function loseFUCKME():void
		{
			//Reset rape count if lost
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00291] = 0;
			spriteSelect(7);
			if (flags[kFLAGS.PC_FETISH] == 0) loseToCeraphAndGetPiercingsInEarsOrSomethingSomehow();
			else if (flags[kFLAGS.PC_FETISH] == 1) loseToCeraphAnGetPierced2();
			else if (flags[kFLAGS.PC_FETISH] == 2) getPiercedByCeraphLoss3();
			else {
				ceraphRapesYouBADDAWGYODIGGITY();
			}
		}

		public function ceraphRapesYouBADDAWGYODIGGITY():void
		{
			player.slimeFeed();
			spriteSelect(7);
			clearOutput();
			if ((!getGame().inCombat) && flags[kFLAGS.PC_FETISH] < 3) outputText("The demoness touches your forehead, and suddenly your mind is awash with fetishes!  Judging by the playful look she has, it's temporary, and you play along.  ", false);
			outputText("Ceraph throws her head back and laughs as you ", false);
			if (player.HP < 1) outputText("slump down, defeated", false);
			else outputText("give up and start masturbating", false);
			outputText(", \"<i>Really?  Is that it?  After being under my magic for so long, you try to make a stand and fail, like this?!  Pathetic.</i>\"\n\n", false);

			outputText("The demonic hermaphrodite steps one foot onto your chest", false);
			if (player.biggestTitSize() > 1) outputText(", right between your " + player.allBreastsDescript(), false);
			outputText(".  Her foot is arched like a high-heel, with a bone-like protrusion forming the heel and digging painfully into your chest.  She looks down at you, watching with a bemused expression while her right hand traces idle circles over her puffy feminine sex.  You can't help but enjoy the situation, pinned under the sexy demon and restrained by her heel.  Ceraph smirks and taunts, \"<i>So what am I to do you with you?  I want you to submit to my harem, not become a bound and unwilling slave.</i>\"\n\n", false);

			outputText("She reaches down to pinch one of your erect nipples, \"<i>Though I'm sure you'd enjoy the restraint and humiliation...  I suppose I'll just have to punish you for your transgression and hope you've learned your lesson.  Now I'm not letting you go until you get me off or suffocate, so I hope you have a talented tongue!</i>\"\n\n", false);

			outputText("For a brief, confused moment you wonder what she means, but then your hands and " + player.legs() + " are swiftly hog-tied together with her whip.  Ceraph is so quick at her task that she finishes before your dumbstruck mind gets a handle on the situation.  You're utterly helpless to resist this demon's whims, and the best you can do to resist her would be to roll on your side.  It would be a hopelessly futile gesture, and you resolve to deal with whatever is to come without showing any fear or remorse.\n\n", false);

			outputText("The sky is blocked out by Ceraph's curvy shadow as she steps over your head, dripping sweet-smelling demonic fluids onto your face.  An inch at a time, she lowers herself down, her sex dripping anxiously and her thick demon-shaft pulsating hotly.  The fluid-slicked lips get closer and closer to your own, dripping more and more moisture from the excited demonette's passage onto your neck.  Plunging down with violent force, she slams her hungry twat against your " + player.face() + ", smearing you from chin to nose with demon-juice.\n\n", false);

			outputText("Her nodule-covered demon-cock flops across your nose and forehead, already dripping with thick pre-cum that slowly rolls up towards your " + player.hairDescript() + ".  Ceraph's well manicured hand wraps around, stroking it and totally blocking your view while her pussy continues to block your airflow.  Knowing that you've no choice but to get her off, you struggle with arousal of your own from the crude restraint. You open wide and plunge your tongue inside her, tasting her sweet yet tangy fluids and feeling the oddly-textured interior of her passage.\n\n", false);

			outputText("Ceraph moans out, \"<i>Ooooh good fuck-toy, eat out your mistress' box!  How does it feel to suffocate on submission and fragrant demon-cunt?</i>\"\n\n", false);

			outputText("Rocking her hips, she grinds herself into you, enhancing her stimulation as you begin to run out of breath.  With a mix of frantic sexual need and desire for oxygen, you lash your tongue around inside her, tilting your head slightly to rub your nose against her clit.  Your efforts pay off, and the demon's taunts die off into moans and gasps that you would think were cute, were you not being smothered in dripping demon-box.\n\n", false);

			outputText("You start to black out as you feel her release a wave of seed onto your " + player.hairDescript() + ".  Though you're too far gone to realize it, your eyes are slowly rolling back as your vision goes black.  Copious demonic fluids fill your mouth while Ceraph gets off on riding your face.  You're nearly gone when she finally pulls herself off of you, jacking her cock off and splattering a few ropes of thick male cum onto your chest and neck.  Coughing and sputtering out her sexual fluids, you fight back to consciousness, humiliated and aroused beyond measure.\n\n", false);

			if (player.totalCocks() > 0) {
				if (player.totalCocks() > 1) outputText("Each of y", false);
				else outputText("Y", false);
				outputText("our " + player.multiCockDescript() + " is twitching and dripping pre-cum, on the edge of orgasm.  ", false);
			}
			if (player.hasVagina()) {
				outputText("Your " + player.vaginaDescript(0) + " twitches, aching with the desire to be touched or filled, and your hips twitch lewdly, desperate for sensation.  ", false);
			}

			outputText("The perverse sexuality fills you with need, but Ceraph only smirks and puts her foot against your cheek, shoving your face into the sex-fluid-filled mud.  She mutters, \"<i>It looks like you managed to save a few brain-cells this time slut.  Because you've been so disobedient you don't get to cum with me.  You can lay here and ache for sex for a few hours I think.</i>\"\n\n", false);

			outputText("Her whip uncurls itself from around you, but by some sorcerous trick, you're unable to separate your limbs and free yourself.  Ceraph snickers and gives your rump a crack with her whip before sauntering off, leaving you to lie there, growing more and more sexually frustrated.  Eventually you doze off into a sort of half-sleep, dreaming of being dominated as the demon's fluids dry on your face.", false);
			dynStats("lus", 200);
			if (getGame().inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}

//(REQ's – HUGE WANG, Exgartuan or Jojo corruption, and !centaur)
		private function hugeCorruptionForceFuckCeraph():void
		{
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00291] += 2;
			clearOutput();
			spriteSelect(7);
			var x:Number = player.biggestCockIndex();

			outputText("You laugh at Ceraph's ", false);
			if (monster.HP < 1) outputText("beaten, prone", false);
			else outputText("prone, masturbating", false);
			outputText(" form, \"<i>You fucking demons are all the same.  That smug superiority complex makes you forget that being a demon doesn't come with an invincibility clause.</i>\"\n\n", false);

			outputText("The hermaphrodite dominatrix frigs her dripping slit, getting off on the dominance in your words, but she still manages to snarl defiantly, \"<i>F-uuuck off.  Just... rape me or whatever and get it over with.</i>\"\n\n", false);

			outputText("She's quite the sore loser!  You drop your " + player.armorName + " on the ground and stroke your ", false);
			if (player.cockTotal() > 1) outputText("largest ", false);
			outputText(player.cockDescript(x) + ", feeling the blood pump into it.  The thick, penile flesh inflates to the ludicrous size it adopts every time you get hard.  Ceraph's eyes widen into dinner plate-sized saucers of shock as she beholds the behemoth that sprouts from your loins.  She actually tries to scrabble away in the dirt, but she fails miserably.  ", false);
			if (monster.HP < 1) outputText("Her hands are too busy starting to pump away at her nodule-covered demon-dick to help her crawl away.", false);
			else outputText("Both her hands are too busy at her groin to help her escape.", false);
			outputText("\n\n", false);

			outputText("You drop the swollen mass of dick-flesh on top her, pinning her under the weight of your lust.  Ceraph gasps in shock and pain, but her hard nipples are pressing tightly into your " + player.cockDescript(x) + "'s underside.  The slut is loving it – could she secretly be a submissive?  It doesn't matter one way or the other; this demon is going to pay.  You shimmy back, dragging the elephantine fuck-stick over the defeated demon's body until the bloated tip is resting on her purplish demon-snatch.  She screams, \"<i>OH FUCK NO!  That would kill me!  Please, don't!</i>\"\n\n", false);

			outputText("Please?  She said the magic words.  ", false);
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) outputText("You pat your " + player.cockDescript(x) + " and say, \"<i>A little help please, Exgartuan?</i>\"  ", false);
			else outputText("You blink your eyes closed and focus your corruptive powers in your crotch.  ", false);
			outputText("Pleasure blooms in your midsection, spreading through your over-sized prick until it begins to dribble from the tip in the form of black ooze.  The viscous, dark substance splashes into Ceraph's demonic cunt, wicking into her drippy hole in an instant.  She moans, probably getting off on the influx of perverse magic.  The effect is immediate and gravity is able to pull your tip into her unassisted.  The demon's corrupted cunt starts to stretch around you, and you haven't even started to push!\n\n", false);

			outputText("The flawless skin of her thighs slips through your fingers before you get a grip on her legs, just below the knees.  Ceraph is alternatively moaning and begging, \"<i>Wha-what are you doing to meeee?  Stop... please... don't... push it in!  Oh by the Queen, it's good... it shouldn't feel goooooood...</i>\"\n\n", false);

			outputText("She doesn't seem to mind receiving it at all.  You push forwards into the clenching tightness of a demon's pussy and groan with delight at the feeling of her tight walls clamping down on you.  The once-dominatrix's belly visibly distorts, mirroring the shape of your member as her cunt expands to handle you.  Her curvy hips visibly shift, spreading apart as Ceraph's body bends to your will.  Your " + player.cockHead(x) + " hits a token block of resistance, but a quick spurt of black, transformative cum dilates her cervix to allows you to pass through. The demonic love canal continues to widen in order to accept the gift of your " + player.cockDescript(x) + " and you have an easy time pushing the distortion past her belly button to just below her large, firm breasts.\n\n", false);

			outputText("Even with your dark magic twisting her body, it doesn't look like Ceraph's body can take any more.  Her mind sure as hell can't; her eyes are rolled most of the way back and she's panting pornographic nonsense, \"<i>Fuck.. ahh... pussy-cock... oooh... so... big... more... cum-sleeve...</i>\"  You're a bit disappointed that you've broken her already, but it quickly fades when you feel her body sucking more of you inside her.  It might be her inherent magic falling under your influence, or maybe her fractured personality has decided to assist you in fully penetrating her.  Whatever the case, a cylindrical bulge forms between her tits, mirroring every vein of your " + player.cockDescript(x) + " through her skin.\n\n", false);

			outputText("Ceraph's throat balloons out to handle your girth, just in time for her to suck you further inside.  You aren't even pushing forwards at this point; her entire body feels like the inside of a succubus' cunt, entirely focused on pleasing male organs.  Her babbles cut off into pleased gurgles, and then die down entirely.  You aren't sure how she's breathing, but her jaw unhinges and stretches obscenely.  You can actually see your tainted pre-cum spilling out from between her lips to run down her face, and then your cunt-slicked tip is tasting the air.", false);
			if (player.cocks[x].cockLength < 68) outputText("  It's impossible!  You aren't long enough for that.  Her body must have shrunk itself to a more appropriate length...", false);
			outputText("\n\n", false);

			outputText("As you're squeezed and massaged by ", false);
			if (player.cocks[x].cockLength < 68) outputText(num2Text(int(player.cocks[x].cockLength / 12)), false);
			else outputText("six", false);
			outputText(" feet of love-tunnel, you struggle not to blow your load.  ", false);
			if (player.cocks[x].cockLength > 84) outputText("You've still got a lot more dick to get wet, and you start pushing the rest through her, using her like a plus-sized, organic onahole.  ", false);
			else {
				outputText("You sigh happily, rubbing your ", false);
				if (!player.hasSheath()) outputText("groin", false);
				else outputText("sheath", false);
				outputText(" against her slippery, split slit, before you pull back and start fucking her like a plus-sized, organic onahole.  ", false);
			}
			outputText("The once-formidable demon sighs happily each time you pull back out of her throat, and the obscene 'schlick' her cunt makes as you penetrate it is auditory heaven.  You slap her tits and watch them jiggle, but the absurd eroticism of it all overwhelms even your perverse standards.  Ceraph slides down, bottoming out on you while her full-body cunt convulses with orgasm.  ", false);
			if (player.cumQ() < 100) outputText("You squirt your load into the dirt, but some rolls back along the underside of your urethra, catches on Ceraph's upper lip, and drips up her cheek into her tangled hair.", false);
			else if (player.cumQ() < 1000) outputText("You squirt your copious cum everywhere, splattering the dirt and dripping white goo onto Ceraph's face, forehead, and hair.  By the time you finish she's got a nice glaze going on.", false);
			else outputText("You expel huge waves of seed in what can only be described as eruptions.  They splatter into the dirt, forming thick puddles that are joined together with each successful splash of goo.  In between blasts, a steady stream leaks from the tip, travels down the underside, and catches on Ceraph's lip.  The spunk-flow is pulled over her face and into her hair by gravity.  She's glazed white and dripping into a puddle by the time you finish.", false);
			outputText("\n\n", false);

			outputText("You push the used fuck-toy off your " + player.cockDescript(0), false);
			if (player.cockTotal() == 2) outputText(" and marvel at the cum your other cock dumped into the puddle", false);
			else if (player.cockTotal() > 2) outputText(" and marvel at the cum your other cocks dumped into the puddle", false);
			outputText(".  Ceraph's pussy gapes at least " + num2Text(int(player.cocks[x].cockThickness + 1)) + " inches wide, pushing her hips so far apart as to make it difficult to walk.  She shudders, drooling spit, pussy-juice, and sperm as her mouth, neck, and chest tighten up.  Her lower body doesn't change one iota; your magics are still overpowering her natural abilities below the waist.  The abused dom twitches a few more times before her eyes reappear and she pulls her tongue back into her mouth.\n\n", false);

			outputText("Ceraph gasps, \"<i>Ohhhhkay.  That felt goooooooood.</i>\"  She gathers some of your sperm from her space and swallows it with a smile before she offers, \"<i>You've shown me a good time, mortal.", false);
			if (!getGame().inCombat) {
				outputText("</i>\"", false);
				player.orgasm();
				dynStats("lib", 3, "sen", 3, "cor", 1);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			outputText("  That's rarer than you know, so I'm feeling a little generous.  ", false);
			if (flags[kFLAGS.PC_FETISH] > 0) outputText("I'll remove some of my magic from you if you want, and I'll even let you keep the piercing.  Would you like that?", false);
			else outputText("I'd be willing to give you a few extra gems to keep you motivated to do something like this again.  I LIKE surprises. How about it?", false);
			outputText("</i>\"\n\n", false);
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) {
				outputText("Exgartuan mumbles, \"<i>Yeah I love me too.  Now while you two bitches kiss and make up, I'm gonna take a nap.</i>\"\n\n", false);
				//Put Exgartuan to bed.  Awww he's so cute!
				player.addStatusValue(StatusEffects.Exgartuan, 2, 5);
			}
			outputText("(Do you accept Ceraph's Offer?)", false);
			//Y/N – remove 1 fetish level or +10 gems
			doYesNo(ceraphsNiceOffer, combat.cleanupAfterCombat);
			player.orgasm();
			dynStats("lib", 3, "sen", 3, "cor", 1);
		}

		private function ceraphsNiceOffer():void
		{
			clearOutput();
			spriteSelect(7);
			if (flags[kFLAGS.PC_FETISH] > 0) {
				outputText("Ceraph touches your forehead, and it feels like her claws are raking through your brain, plowing through the surface of your thoughts.  She pulls away, leaving you feeling a little dazed.  You blink and mentally go over your fetishes - ", false);
				if (flags[kFLAGS.PC_FETISH] == 1) outputText("your exhibitionism is gone!", false);
				else if (flags[kFLAGS.PC_FETISH] == 2) outputText("your bondage fetish is gone!", false);
				else outputText("your pacifism is gone!", false);
				flags[kFLAGS.PC_FETISH]--;
			}
			else {
				outputText("Ceraph shakes some of the jism out of her hair and reaches under the tangled mass.  Her hand comes out with a small pouch of gems, and she tosses them to you.  You open it up and are surprised to find 10 gems inside.", false);
				player.gems += 10;
			}
			outputText("\n\nThe abused demon-dom laughs, \"<i>What?  Did you expect me to trick you?  No, I liked today.  It's so hard to find someone who can go toe to toe with me AND find incredible ways to abuse my body.</i>\"\n\nShe lays back and relaxes, falling asleep after the intense fuck.", false);
			combat.cleanupAfterCombat();
		}

		/*
		 MOAR CERAPH.
		 Ceraph the Omnibus is totally nude and reveling in it.  Her large yet perky breasts jiggle heavily against her chest as she moves.  The flawless purple skin of her twin mounds glistens with a thin sheen of sweat, inviting you to touch them and rub your fingers along their slippery surface.  Her eyes are solid black, but convey a mix of amusement and desire in spite of their alien appearance.  The demon's crotch is a combination of both genders – a drooling cunt topped with a thick, demonic shaft sprouting from where a clit should be.

		 1. Remove fetish if PC trades her bimbo liquer.
		 2. Will remove your fetishes if she can take your genitals!

		 (Chance of encountering 'Friendly' Ceraph even when PC is awaiting trapped armor.
		 */

		public function friendlyNeighborhoodSpiderManCeraph():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("While exploring, a sudden compulsion to strip naked runs through your body, ", false);
			if (player.cor > 66) outputText("and without a second thought you disrobe, tossing your " + player.armorName + " to the side.  It thumps heavily in the dry mountain dust.", false);
			else if (player.cor > 33) outputText("and you squirm and writhe within your " + player.armorName + ", the material itching on your skin.  Ultimately, you manage to resist.", false);
			else outputText("and you stifle a laugh at the ridiculous thought, ignoring your fingers while they scratch at the itch under your gear.", false);
			outputText("  Your ", false);
			if ([SKIN_TYPE_PLAIN, SKIN_TYPE_FUR].indexOf(player.skinType) >= 0) outputText("skin burns", false);
			else if (player.skinType == SKIN_TYPE_SCALES) outputText("scales burn", false);
			else outputText(player.skinDesc + " burns", false);
			outputText(" hot, raging from fetish-enhanced lust and daydreams, but you shake your head in time to see a pair of inky black orbs rising from behind a nearby boulder.\n\n", false);

			outputText("You wrench your gaze from the treacherous, alien eyes and glance lower, but it doesn't help.  There's nothing but flawless, sweat-moistened demon-skin, jutting purple breasts, and a crotch that combines the finest attributes of both genders.  It's the demon, Ceraph!\n\n", false);

			outputText("\"<i>Oh my, does someone like what they see?  ", false);
			if (player.cor > 66) outputText("I can see just how hot I'm making you, I'm so glad you gave in and got undressed for me", false);
			else outputText("You can't take your eyes off me.  It's a shame you didn't get undressed.  Didn't anyone tell you this mountain has a dress code?  Or should I say, an undress code", false);
			outputText(",</i>\" she says.\n\n", false);

			outputText("You ready your " + player.weaponName + ", but Ceraph just throws her head back and laughs in your face.  \"<i>", false);
			if (player.cor > 66) outputText("Are you going to try to fight me in the buff?  If you're going to do that then you can go ahead and get dressed, I wouldn't want to accidentally leave a scar in the wrong place.", false);
			else outputText("Are you going to try to fight me?  If you're going to do that, I suppose we can.  You do seem to need some practice at indulging your fetishes.", false);
			outputText("</i>\"\n\n", false);

			outputText("The demoness lifts one heeled foot high onto a boulder and winks at you, letting her whip rub up and down her hard, nodule-studded shaft.  Her tail rises languidly between her perfect, lissomelegs, rubbing the glistening wet delta of her sex enticingly.  The demon coos, \"<i>Oh, I do love putting on a show for my future pets.  Tell me, did you really come up here to fight?  I'd rather lie back in the sunlight, rubbing my fingers over my glistening skin and showing everyone just how wondrous sex with me would be.  You can even go if you want, or maybe you'd have something worth trading with me?</i>\"", false);
			dynStats("lus", (5 + player.cor / 10 + player.lib / 20), "cor", 0)
			//[Fight] [Trade] [Run]
			simpleChoices("Fight", startAFightWithCeraph, "Trade", tradeCeraphSomething, "", null, "", null, "Run", runFromCeraphsNiceDeal);
		}

//[Fight] → Cue normal Ceraph fight
		private function startAFightWithCeraph():void
		{
			startCombat(new Ceraph());
			spriteSelect(7);
			playerMenu();
		}

//[Run] → 
		private function runFromCeraphsNiceDeal():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You ", false);
			if (player.cor > 66) outputText("grab your equipment and ", false);
			outputText("beat a hasty retreat from the trickster of fetishes.  Her masturbatory moans chase you down the mountainside back towards your camp, spiking the already-burning furnace of your lust.", false);
			//(+10 lust + 10lust/piercing)
			dynStats("lus", (10 + flags[kFLAGS.PC_FETISH] * 10));
			doNext(camp.returnToCampUseOneHour);
		}

//[Trade] 
		private function tradeCeraphSomething():void
		{
			clearOutput();
			spriteSelect(7);
			var liqueur:Function =null;
			var endowment:Function =null;
			var armor:Function =null;
			outputText("Ceraph looks you up and down like an appraiser examining an antique, never stopping her languid masturbation.  You stand there, hands on your hips, waiting for her to finish while you try not to stare too long at her beading pre-cum or dripping twat-juice.\n\n", false);
			//(BIMBO LIQUER) 
			if (player.hasItem(consumables.BIMBOLQ)) {
				outputText("She finishes and smiles widely.  \"<i>Is that bimbo liqueur?  That stuff is so hard to find, even for a demon like me.  I tell you what, I'll release you from ", false);
				if (flags[kFLAGS.PC_FETISH] > 1) outputText("all the fetishes", false);
				else outputText("the fetish", false);
				outputText(" I've placed upon you if you'll trade me that stuff.  There's a naughty boy in my harem whose quick wit I've begun to tire of.", false);
				if (player.gender > 0 || player.biggestTitSize() > 2) outputText("  Or if you'd rather keep it, I could take one of your endowments for my own use and remove a single fetish.  It's always fun giving one of my old pets a new part to play with.", false);
				outputText("  Maybe you just need some better equipment though?  I have this sexy armor I'd love to loan you, pet.</i>\"\n\n", false);
				liqueur = tradeCeraphBimboLiqueur;
				if (player.gender > 0 || player.biggestTitSize() > 2) endowment = tradeCeraphCrotchityBits;
			}
			//(No Bimbo Liquer) 
			else if (player.gender > 0 || player.biggestTitSize() > 2) {
				outputText("She finishes and perks up, leering lewdly at you.  \"<i>I tell you what.  Let me take one of your endowments to use on my pets and I'll get rid of ", false);
				if (flags[kFLAGS.PC_FETISH] == 1) outputText("your fetish for you.</i>\"\n\n", false);
				else outputText("one of your fetishes for you.</i>\"\n\n", false);
				endowment = tradeCeraphCrotchityBits;
			}
			//(NO TRADE)
			else {
				outputText("She finishes and frowns.  \"<i>I don't think you've got a single thing worth trading.", false);
				if (flags[kFLAGS.PC_FETISH] < 2) {
					armor = getCeraphsArmor;
					outputText("Don't fret your " + player.mf("pretty little head", "charming little head") + ", Mistress Ceraph is nothing if not generous to her pets.  I can give you some beautiful armor to entice your foes with, wouldn't that be lovely?", false);
				}
				outputText("</i>\"\n\n", false);
			}
			//Leave uses the run text!
			simpleChoices("Liqueur", liqueur, "Endowment", endowment, "Armor", armor, "", null, "Leave", runFromCeraphsNiceDeal);
		}


//[Take Armor]
		private function getCeraphsArmor():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph smiles knowingly at your response.  \"<i>You'll find this to be quite sexy.  Just be careful putting it on.  If you don't fit it right it'll pinch,</i>\" the demoness instructs while tossing you a set of armor.\n\n", false);
			//(Get trapped armor and go home)
			inventory.takeItem(armors.SEDUCTA, camp.returnToCampUseOneHour);
		}

//[Trade Bimbo Liquer]
		private function tradeCeraphBimboLiqueur():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("Ceraph grins as wide as the Cheshire Cat, groaning with happiness as she pulls her dripping tail from her snatch.  The pungent scent of her lusty, tainted puss hangs in the air while her tail extends towards you, looping around the liquer's top and pulling it from your pouch.  Ceraph plucks the bottle from her lust-drenched tail with great care and undoes the top.  She gives the liquer a tiny sniff, but it rocks her back on her heels all the same.  The demon starts giggling as she corks it, smiling with a slightly dopy look.  \"<i>Wheeeeeewww... heheheheee.. that stuff has got some kick!</i>\"\n\n", false);

			outputText("You mention the deal and she glares back at you in irritation.  Her beautiful features curl with anger, a hand coming out of nowhere to slap you squarely on the side of the temple.  \"<i>Don't interrupt me, pet.</i>\"  Ears ringing, you stagger back, clutching at your head in surprise.  By the time you glare back at her, she's walking away.  You briefly consider giving her payback, but you realize your head feels clearer, more normal.  The artificial fetishes are gone!  While you catalogue lewd acts in your head and marvel at how little they affect you, Ceraph makes good on her escape.", false);
			player.consumeItem(consumables.BIMBOLQ);
			player.takeDamage(4);
			flags[kFLAGS.PC_FETISH] = 0;
			dynStats("lus", -20);
			doNext(camp.returnToCampUseOneHour);
		}

//[Trade Genitals]
		private function tradeCeraphCrotchityBits():void
		{
			clearOutput();
			spriteSelect(7);
			//(EXGARTUAN PISSED) 
			if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) {
				outputText("A disembodied voice roars out, \"<i>FUCK NO!  You are NOT giving me to that crazy bitch!</i>\"  Exgartuan doesn't seem to want to run the risk of being taken by Ceraph, and he completely assumes control of your " + player.legs() + " to make you flee with all due haste.  He taunts, \"<i>Rip off your own little dick, why doncha!  You'd look better with just a pussy anyhow ya dried out old sow!</i>\"\n\n", false);
				outputText("Ceraph seems perturbed but doesn't bother to pursue you.", false);
				dynStats("lus", -20);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//Create array for choosing bits!
			var choices:Array = [];
			var choice:Number = 0;
			var temp2:Number = 0;
			//1 = wang, 2 = cunt, 3 = tits.
			//Add dicks
			temp = player.totalCocks();
			while (temp > 0) {
				temp--;
				choices[choices.length] = 1;
			}
			//Add pussy twice for kicks!
			if (player.hasVagina()) {
				choices[choices.length] = 2;
				if (rand(2) == 0) choices[choices.length] = 2;
			}
			//Add tits
			temp = player.breastRows.length;
			while (temp > 0) {
				temp--;
				//She only wants tits if they're decent!
				if (player.breastRows[temp].breastRating > 2) choices[choices.length] = 3;
			}
			//Think about it...
			outputText("Ceraph grins lecherously and pulls her tail from her drooling snatch.  \"<i>Really?  Well this should be fun.  Let me just figure out what I want...</i>\"  Her gaze is quite piercing.\n\n", false);
			//Pick a winner!
			choice = choices[rand(choices.length)];

			if (choice == 0) outputText("FUCK AN ERROR HAPPENED GET FENOXO ON THE HORN!", false);
			//(DICKS)
			else if (choice == 1) {
				temp2 = rand(player.cockTotal());
				outputText("She pipes up, \"<i>", false);
				if (player.cocks[temp2].cockType == CockTypesEnum.HORSE) outputText("Oooh, is that a horse-cock?  Those are quite nice.  I love the feel of a flare inside me, or even better, plunging one deep into a slut's poor, abused asshole.", false);
				else if (player.cocks[temp2].cockType == CockTypesEnum.DOG) outputText("Oooh, is that a dog-cock?  Those are quite nice.  It's oh-so-fun to enhance the knots on those and then watch them puff up enough to distend some poor slave's gut.", false);
				else if (player.cocks[temp2].cockType == CockTypesEnum.DEMON) outputText("Oooh, is that a demon-cock?  As you can see I'm QUITE familiar with those, but it might be fun to replace one of my girl's tongues with it.", false);
				else if (player.cocks[temp2].cockType == CockTypesEnum.CAT) outputText("Oooh, is that a kitty-dick?  The spines on those feel so good while they rub down all your walls or catch your prostate.  Meow.", false);
				else if (player.cocks[temp2].cockType == CockTypesEnum.LIZARD) outputText("Wow, you've got a snake-dick?  I haven't seen one of those in a while.  I love the bulbous, knot-like texture.  Maybe I'll graft it onto a chair and make one of my boys sit on it for a few days.", false);
				else if (player.cocks[temp2].cockType == CockTypesEnum.TENTACLE) outputText("Oooh, a tentacle cock?  How lucky to find one of those on you!  I've been meaning to add another poor tentacle-slave.", false);
				else if (player.cocks[temp2].cockType == CockTypesEnum.ANEMONE) outputText("Oooh, an anemone-cock?  Simply marvelous!  I might have to crank up the strength of the venom and use it myself!", false);
				else outputText("Oooh, a normal, uncorrupted cock.  How utterly droll!  You'd think these would be more common, but it's quite a treat to come across one.", false);
				if (player.cockTotal() > 1) {
					outputText("  Of course that's not the only prick you're packing, hrmmm?  Maybe I should take ", false);
					if (player.cockTotal() == 2) outputText("the other one", false);
					else outputText("one of the others", false);
				}
				outputText(".", false);
				outputText("</i>\"\n\n", false);
			}
			//(Cunts) 
			else if (choice == 2) {
				outputText("The demon's gaze drops down between your " + player.legs() + ", and she remarks, \"<i>", false);
				if (player.wetness() >= 5) outputText("My my, what a juicy box you have there.  Tell me, doesn't it bother you to be soaking in your own lubricants all the time?  Perhaps I'll put it on one of my slaves and mount her on the wall.  Then I can simply slip in and lube up before giving one of my other pets a proper lesson.", false);
				else if (player.wetness() >= 3) outputText("My my, what a nice wet pussy you have there.  I really feel that you have a perfect blend of moisture and practicality down there.  I might have to snatch that snatch and give it to one of my drier pets.", false);
				else if (player.vaginalCapacity() >= 150) outputText("My my, what a terrifically gaped hole you have there.  Do minotaurs even feel anything while they rail you?  Perhaps I could use that when I'm playing with Shenandoah.  She's had a few too many incubi drafts and can be a little difficult to handle.", false);
				else outputText("My my, such a pretty pussy.  I bet it would be fun to replace one of my noisier pet's mouth with.  She never did learn not to bite.", false);
				outputText("</i>\"\n\n", false);
			}
			//(Tits) 
			else {
				outputText("Ceraph's hands reach up to cup the swell of your " + player.biggestBreastSizeDescript() + " as she asks, \"<i>", false);
				if (player.biggestTitSize() > 14) outputText("Oh wow... just wow.  How do you walk?  With melons like this you could tit-fuck three or four people at once!  Absolutely exquisite.", false);
				else if (player.biggestTitSize() > 6) outputText("Tell me dear, are they real?  I mean, were they always this size, or did you have to get a little bit of work done?", false);
				else outputText("Well, these are a bit small.  Have you ever considered trying some Gro Plus?  I hear it's all the rage with Lethice's lackeys nowadays.", false);
				outputText("</i>\"\n\n", false);
			}
			outputText("A long, silent moment passes before Ceraph makes up her mind.  She points at your ", false);
			if (choice == 1) {
				outputText("manhood", false);
				if (player.cockTotal() > 1) outputText("s", false);
				outputText(" ", false);
			}
			else if (choice == 2) outputText("vagina ", false);
			else outputText("breasts ", false);
			outputText("and declares, \"<i>I think I'll have ", false);
			if (choice <= 2) outputText("one ", false);
			else outputText("two ", false);
			outputText("of those.  Now just hold still.</i>\"\n\n", false);

			outputText("Do you let her take it?", false);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] = choice;
			doYesNo(giveUpYourBallsOrWhateverForLessFetishes, bailBeforeCeraphYoinksYourNads);
		}

//[No]
		private function bailBeforeCeraphYoinksYourNads():void
		{
			clearOutput();
			spriteSelect(7);
			outputText("You let her know that you've changed your mind and take off before Ceraph can try to take your beloved body parts.  You hear her laugh and tease as you run, yelling, \"<i>What, can't handle the thought of an Omnibus touching your fun bits?  Poor baby!</i>\"\n\n", false);
			doNext(camp.returnToCampUseOneHour);
		}

//[Yes]
		private function giveUpYourBallsOrWhateverForLessFetishes():void
		{
			clearOutput();
			spriteSelect(7);
			var x:Number = 0;
			outputText("You hold still, dreading this moment but knowing all-too well that you'd have to give something up to get her touch out of your mind.  ", false);
			//(Cock)
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] == 1) {
				//Pick a dick at random!
				x = rand(player.cockTotal());
				outputText("Ceraph's fingers feel unexpectedly hot as they brush your " + player.cockDescript(x) + ", as if she had just come out of a heated tub.  You don't have long to ponder that little detail as they pinch into a tight ring", false);
				if (player.cocks[x].cockThickness >= 4) outputText(", compressing your massive girth into the rigid shaft", false);
				outputText(", slowly closing.  It should hurt but it doesn't, it just feels warmer and warmer, and then with a sudden 'PYOING!', Ceraph is holding your " + player.cockDescript(x), false);
				if (player.balls > 0 && player.cockTotal() == 1) {
					outputText(" and balls", false);
					//Gotcher balls!
					player.balls = 0;
					player.ballSize = 1;
				}
				if (player.cockTotal() == 1) player.removeStatusEffect(StatusEffects.Infested);
				outputText(" in her hand!  At the base there's smooth flesh and an arcane mark, somehow keeping the disembodied dick alive to pulse and squirm in her grasp.  The place on your groin is left completely smooth and featureless, as if it had never been there at all.\n\n", false);

				outputText("Ceraph runs a finger up and down the length, setting off fireworks in your brain – you can still feel it!  The demoness laughs and says, \"<i>Don't worry, you won't feel the sensations constantly once I bond it elsewhere, though you may get a hint of feeling when unconscious.  For now, enjoy the pleasure!  Oh, I packed that tasty fetish into the cock for later.  Ta-ta, my pet!  Now go find me some more delicious dicks!</i>\"\n\n", false);

				outputText("She pirouettes away, practically dancing through the mountains while she strokes and teases the cock you just lost.  Thankfully she was true to her word – your mind feels significantly clearer, at least when a burning hot demon-tongue isn't enveloping Ceraph's new toy.", false);
				//PYOING!
				player.removeCock(x, 1);
				//(-fetish, +cock-toy status +1)
				flags[kFLAGS.PC_FETISH]--;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218]++;
				dynStats("lib", -2, "sen", -2, "cor", 5);
			}
			//(Pussy)
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] == 2) {
				outputText("Ceraph's fingernails stab at your " + player.skinDesc + " painfully, dragging them in a circular motion around your vulva.  The pain of the action fades to a gentle, throbbing heat while her fingers go deeper, corkscrewing through your flesh.  A second later she pulls back, a featureless pillar of flesh wrapped in skin and sitting in her hand, topped with your " + player.vaginaDescript() + ".  The other end is capped with a strange, arcane mark, seemingly tattooed into the skin.  You glance down, expecting to find your groin ruined, but the spot your vagina once occupied is replaced with bare, unmarked skin.\n\n", false);

				outputText("The demon slips a finger into her hand-held pussy, and you inexplicably moan, still feeling every sensation with perfect clarity.  She plays with it for a few more seconds, the gentle 'schlick-schlick-schlick' of her fingers carrying through the mountain air before she seems to tire of teasing you.\n\n", false);

				outputText("\"<i>Oh don't mind the feelings, they'll fade once I get farther away and get this stuffed into another pet.  I don't know if you'll ever be completely isolated from it, but who cares?  You'll probably only feel it in your dreams anyway.  Oh, I almost forgot!  I packed up a fetish into my new pocket pussy.  I'm a lady of my word, wouldn't you say?  Now, I have to go.  Pet, make sure to get another one of these in case I need more, okay?</i>\" instructs Ceraph with an air of incalculable authority.\n\n", false);

				outputText("You work your jaw in consternation, trying to dredge up a response or stop her, but before you can do anything, she pushes your old " + player.vaginaDescript(0) + " down on her throbbing demon-shaft.  It knocks the strength out of your " + player.legs() + ", and you lie there moaning while Ceraph prances off, masturbating herself with your disembodied pussy.  Eventually you cum to the feeling of demon-cum spurting inside you, but it's a strange, empty orgasm.", false);
				player.removeVagina(0, 1);
				//(-100 lust, -1 fetish, +1 vagina toy status)
				player.orgasm();
				dynStats("cor", 5);
				flags[kFLAGS.PC_FETISH]--;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219]++;
			}
			//(Tits) 
			else {
				//Take da biggest titz!
				x = player.biggestTitRow();
				//Store nipplecuntz or milks
				if (player.breastRows[x].fuckable) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] = 4;
				else if (player.lactationQ() >= 100) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] = 5;
				else flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] = 3;
				outputText("Ceraph bounces your " + player.breastDescript(x) + " in her hands, playing with them for just a few seconds before she digs her nails in and pulls.  Your tits stretch for a moment, pulled tight while Ceraph giggles cruelly.  Heat blooms inside your chest, vivid tingles radiating from Ceraph's fingertips deep inside you.  At last it peaks and with a deep 'POMF', your tit-flesh separates from your body.  You look closely at the departing bosom – where it once joined with your body, it's covered in healthy pink skin and intricate, arcane tattoos.  Meanwhile, ", false);
				//More than 1 set of tits and not on bottom row?
				if (x < player.breastRows.length - 1 && player.breastRows.length > 1) {
					//If only 1 row below
					if (x >= player.breastRows.length - 2) outputText("your torso has shifted and your " + player.breastDescript(x + 1) + " have moved up to fill the void.", false);
					//Multiple below
					else outputText("your torso has shifted and your other breasts have moved up to fill the void.", false);
					player.removeBreastRow(x, 1);
				}
				//Top row is only row
				else if (x == 0) {
					outputText("your now-flat chest slowly gains two tiny, quarter-inch nipples.", false);
					player.breastRows[0].breastRating = 0;
					player.nippleLength = .25;
					player.breastRows[0].breasts = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].fuckable = false;
					player.breastRows[0].lactationMultiplier = 0;
				}
				//everybody else
				else {
					outputText("your torso leaves the now-empty spot as a flat, featureless void.", false);
					player.removeBreastRow(x, 1);
				}
				//Oh shit something went wrong.
				if (player.breastRows.length == 0) outputText("<b>ERROR!  ERROR!  Please contact Fenoxo and reload your game if you don't want your save messed up.</b>", false);
				outputText("\n\n", false);

				outputText("You gasp when Ceraph ", false);
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] == 3) outputText("rolls the nipples in her hands", false);
				else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00217] == 4) outputText("pushes her fingertips inside the leaky nipple-cunts", false);
				else outputText("squeezes out a squirt of milk", false);
				outputText(", going a little weak in the knees.  Ceraph laughs and lowers the bouncy orbs down between her legs, and you can feel every little bump and nodule of her corrupted cock as she tit-fucks herself on your disembodied breasts.\n\n", false);

				outputText("\"<i>Oh oh, does someone like having a nice hard cock buried in her tits?  Maybe I should've left these on you so that I could get the full benefit before I left.  Maybe next time.  Don't mind the fact that you can still feel them – that'll fade with distance and time.  I have heard that you can still feel them in your dreams though, so maybe if you close your eyes hard enough you'll get to feel my dick fucking your tits on one of my pets,</i>\" taunts the demoness while she continues to tit-fuck herself on your former bosom.  \"<i>Don't worry about the fetish, I packed it up with these puppies.  It's not like it was that hard to get it on you in the first place.</i>\"\n\n", false);

				outputText("Ceraph turns and prances off through the rocks, tweaking your nipples HARD every time you start to make a move to follow her.  It's no use.  She vanishes before long, leaving you to deal with the slowly dwindling sensation of her cock in your tits.\n\n", false);
				//(-1 fetish, +1 tit toy status)
				dynStats("lus", 20, "cor", 5);
				flags[kFLAGS.PC_FETISH]--;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220]++;
			}
			//Fix any gender mixmatches
			player.genderCheck();
			doNext(camp.returnToCampUseOneHour);
		}

//NIGHTTIME
//Nighttime Cock Surprise! - If Ceraph has ever taken a PC's wang.
//*Wax dripping? -3 sensitivity
//*Buttfuck?  -100 lust
//*Feather torture +3 sensitivity

//Nighttime Cunt Surprise!
//*Used as a fleshlight.
//*Clit pump
//*Orgy floor Drain
		public function ceraphBodyPartDreams():void
		{
			spriteSelect(7);
			//Create array for choosing bits!
			var choices:Array = [];
			var choice:Number = 0;
			var subChoice:Number = 0;
			//dicks
			temp = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218];
			while (temp > 0) {
				temp--;
				choices[choices.length] = 1;
			}
			//pussies
			temp = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219];
			while (temp > 0) {
				temp--;
				choices[choices.length] = 2;
			}
			temp = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220];
			while (temp > 0) {
				temp--;
				choices[choices.length] = 3;
			}
			//Pick one!
			choice = choices[rand(choices.length)];
			outputText("\n<b>Something odd happens while you sleep...</b>\n", false);
			//PUSSAH
			if (choice == 2) {
				subChoice = rand(4);
				//PUSSY ORGY FLOOR DRAIN
				if (subChoice == 0) {
					outputText("You can feel an odd sensation in your nethers during your dreams, and as the warm, slick feeling grows you recognize it for what it is – cum dripping into your pussy.  ", false);
					if (!player.hasVagina()) outputText("You don't have a vagina any more, do you?", false);
					else outputText("No, that doesn't feel right – it isn't your vagina.", false);
					outputText("  It must be the sex that Ceraph stole from you!  You feel tight... enclosed somehow, but the ever present trickle of bodily fluids into your imprisoned nethers slowly brings about your own arousal.\n\n", false);

					outputText("Choruses of voices moan with building, peaking pleasure, and the ebb and flow of sexual slime into your parted pussy increases.  You moan in your sleep, feeling wet, obscenely wet, as you're used as a cum-drain for some massive orgy.  The cum from dozens of Ceraph's pets drools into you, filling you with warm, masculine slime and slippery pussy-fluid.  Helpless and imprisoned, you can do nothing but pant with desire until your womb is utterly packed with spooge and your gaping twat is brimming with spunk.\n\n", false);

					outputText("You're a useless cum-dump, there only to slurp up the leavings from Ceraph's more treasured pets, but it makes you oh-so horny.  You pant in your sleep, hopelessly aroused but denied release by the fading dream.", false);
					//(+4 sens, +200 lust)
					dynStats("sen", 4, "lus", 200);
				}
				//PUSSY CLITPUMP
				else if (subChoice == 1) {
					outputText("An insistent suction pulls on your lower lips, engorging them.  You squirm, rolling your hips back and forth to escape the pull, even as your clit begins to grow from its hood.  ", false);
					if (!player.hasVagina()) outputText("Wait... you don't have a clit any more... Ceraph took that away.  ", false);
					else outputText("Wait... that's not your " + player.clitDescript() + "... it's the one Ceraph took from you.  ", false);
					outputText("The thought of your demonic tormentor sharpens the sensations, letting you feel a smooth, circular chamber around the top of your old vagina.  You blink open long, mascara-laden eyes and are treated to the sight of Ceraph (your mistress?) pumping away at the device she has on your clit, increasing the suction.\n\n", false);

					outputText("Her pet mewls happily through her lips while you snore out a muted echo of pleasure, and though your thoughts feel oddly discordant, the cunt-pumping pleasure in your crotch brings you more and more in line with the blissful fuck-toy's way of thinking.  Ceraph squeezes on a black bulb that's connected to the device.  It wheezes out puffs of air, vacuuming harder and harder on your swelling clit in time with your mistress' rhythmic hand contractions.  She asks, \"<i>Is your clitty big enough?  We'll be doing this every couple of nights until your little love-button is big and hard enough to fuck my sweet pussy.  After that we can pump it some more.  I wonder if we can get it big enough to make the boys in the harem jealous?  Wouldn't that be nice?</i>\"\n\n", false);

					outputText("You (and her pet?) nod vigorously, hips pumping while your womanhood is engorged with an overabundance of blood.  Ceraph laughs at you, but you can see how hard her swollen member has gotten at the sight of your puffed-up womanhood.  Always an obedient pet, you reach down with your feet to stroke your mistress' shaft, pleasuring her the same way her toy is pleasuring you.  The demoness laughs, \"<i>Aren't you the eager bitch.  Very well, we need to leave your clit pumped like this for a while for the drugs to take effect anyhow.  Pleasure me with your feet and perhaps I will let you bear me a litter of imps with that new pussy.</i>\"\n\n", false);

					outputText("Emboldened by Mistress' praise, you arch your toes around Ceraph's lusty spear, stroking up and down while her soft nodules slide across your soles.  She leaks hot pre all over your feet, slobbering them with the heat of her lust, and you shamelessly smear the demonic leavings along her shaft.  Inside the pump, your slobbery cunt-lips rub against each other delightfully, jiggling with every slide of cum-covered foot over demon-dick.  Aided by the sensations in your loins, you pick up the pace, giving Ceraph a gloriously intense footjob.\n\n", false);

					outputText("The demon-dom grabs your ankles and foot-fucks you hard, leaving you to swim in pleasure like your cunt swims in pooled juices.  Your vulva are huge and rounded from the drugs and constant suction, filling the clear pump and pressing against the chamber walls.  The clit that pokes between them looks monstrous, huge and veiny.  It resembles a massive, distended dog-cock more than anything human, but every time your hips shake and bounce it against the sides of the tube it fills, you nearly cum.\n\n", false);

					outputText("Sudden warmth plasters your feet and ankles, drenching them with the inhumanly warm jizm of Ceraph's pleasure.  She sighs, relaxing her grip on your ankles while you pump away, dutifully milking every ounce of demonic juice onto your willing soles.  \"<i>Gooood pet... yes, good girl,</i>\" coos the still blissful dominatrix before she suddenly yanks the pump from your groin without warning.  Your poor pussy jiggles with pain and pleasure, orgasming hard enough to squirt all over your cock-sized clitty.  Thankfully, the swelling of your genitals immediately fades, leaving them larger but less freakish.  Ceraph presses her still-hard cock against your lips, but the mental link starts to fade as she does so, leaving you to return to your normal dreams...", false);
					//(-3 sens, -100 lust)
					player.orgasm();
					dynStats("sen", -3);
				}
				//PUSSY FLESHLIGHT
				else if (subChoice == 2) {
					outputText("A sudden prodding at your vagina's entrance nearly rouses you from your sleep.  ", false);
					if (!player.hasVagina()) outputText("Wait... you don't have a pussy anymore.  ", false);
					else outputText("Wait... your pussy doesn't feel like that!  ", false);
					outputText("You must be picking up on feelings from the cunt Ceraph took away from you!  Warm demonic cum bubbles at your entrance, slicking the engorging vulva with demonic taint.  You swoon from the heat of it, and the demoness wastes no time, quickly inserting her entire length.\n\n", false);

					outputText("The nubby nodules that line her shape press on your walls, stroking the innermost folds of your long-lost nethers.  Somehow you get a visual of the scene – Ceraph, lying back in bed, your pussy-flesh clutched in her hand like a perverse sex-toy.  She starts pumping it on herself, using a part of your body like a simple masturbation tool.  The room is empty, and she wastes no time in vocalizing her pleasure, \"<i>Ohhh fuck you've got a nice pussy " + player.short + ".  By Lethice's lewd tits, I hope you can feel how good your cooch is at devouring a demon's dick.  Next time we meet you should... Ah.. ahhh... ohhhh umm... submit to... ahhh AHHH!</i>\"\n\n", false);

					outputText("Throughout Ceraph's speech she continually increased her pace, jackhammering your pussy up and down on her bulging dick.  The nodules start to enlarge, puffing up around her base and then rippling, wave-like towards the slowly thickening head.  A squirt of hot cum shoots into your depths, sliming them with the demoness' corrupt cream, but it feels so good... so very good.  Your pussy clamps down on the invader, imprinting the swollen nodules against its soft inner walls, and you cum as hard as if you were riding her yourself.\n\n", false);

					outputText("The vision and feelings slowly fade, letting you out of their grip and leaving faint after-images of Ceraph cleaning you with her tongue.", false);
					//(-100 lust, +2 sens, +1 cor)
					player.orgasm();
					dynStats("sen", 2, "cor", 1);
				}
				else {
					//Vagina Wall-Cubby
					outputText("MMMmmm, something is filling you just - ahhhh... right.  You shift position in your blankets, but it doesn't seem to move the insistent hardness lodged up your twat.  Gods, it feels so good to be so full.  It's like having three or four hard dicks inside you all at once, keeping you stretched and open, the cunt-honey dripping toward the floor.  The only time they move is when a wave of contractions pulses through your female flesh, squeezing about the invaders.  Languidly, you work your muscles faster, wanting to feel greater pleasures.  You secretly wish that whatever it is would fuck you.");
					outputText("\n\nWithout any warning, the multitude of rigid intruders moves, one of their number sliding out.  Your poor, stretched-out vaginal flesh slowly tightens up around the remainder, but it isn't as tight or enjoyable as it was a moment ago.  Under your covers, your [hips] rock back and forth encouragingly, but it doesn't help at all.  Another rod vanishes from your vaginal embrace, setting off fire bursts of pleasure followed by aching hollowness.  You're so empty that your lips don't even close around the rest of the thick shifts.  They just gape, luridly opening wider as if to beg for more.");
					outputText("\n\nAgain, a fat shaft is withdrawn.  There's only one left, and you can feel it leaning down, almost sliding out thanks to gravity and your own sexual excitement.  Your poor cunt is so wide-open that can you shiver from the cold air circulating in its cavernous depths, and as the invader is taken, an anguished moan escapes your lips.  You're utterly, completely, soul-crushingly EMPTY.  You whine and whimper in your sleep, but relief will not come.");
					outputText("\n\n\"<i>Oh [name], your pussy makes such a good cubbyhole for my toys.  Still, it gets so wet.  I could do with some relief,</i>\" an unseen, feminine voice muses, \"<i>I'm so glad I was playing with some gro+ earlier...</i>\"");
					outputText("\n\nGods, she's fucking huge!  You can feel the gargantuan glans slipping in, stretching your abused entrance even wider.  Hard little nubs stroke your vulva as they slip through, a ring of them positioned just behind the frenulum of the slowly-advancing cock.  As it slides in further, more of the fantastic little nodules make themselves apparent all over the shaft, though they lack the symmetrical organization of the ring near the top.  Having this dick in you... it's like having hundreds of tiny fingertips probing at your interior on top of the dick slowly-stuffing your hot wet cunt.");
					outputText("\n\nWhatever it is, that magic cock fits you nicely, and once it starts to piston in and out, fucking you hard, fast, and carelessly, you begin to moan.  It doesn't even matter that it's fucking you without a care for your feelings - the perfect little dick-bumps hit every sensitive spot in your interior.  You're tossing and turning in bed, panting and gasping, a nocturnal orgasm just a moment away.  The mysterious tool jackhammers at your hole, fucking faster and faster, the nubs growing larger as the cock closes in on its crescendo.");
					outputText("\n\nA quim-stained crotch smacks into your lips, and explosions of warmth begin detonating deep inside your depths, the blooms of liquid heat bringing you to a cunt-clenching climax of epic proportions.  Your muscles lock and your [butt] rises from your resting place, cheeks clenched in tight pleasure.  A scream of bliss tears through the night as you cum.  Jizz froths from your entrance as you're overfilled, spilling out to roll to the ground.  It feels so good, so goddamn good.  Your wails slowly trail off to whimpers, aftershocks of enjoyment causing your body to twitch wildly beneath the blankets until the cream-spurting cock is finally removed from your jizz-glazed cavern.");
					outputText("\n\n\"<i>I suppose I should thank [name] for giving me such an excellent fuck-toy,</i>\" the mysterious-yet-familiar voice comments.  Wait... Ceraph!");
					outputText("\n\nYou jolt awake, sweating buckets and shivering.  Somewhere, the demoness just blew a load in your old pussy.  The thought would keep you awake, if that orgasm hadn't been so goddamn satisfying.");
					player.orgasm();
					dynStats("sen", 2, "cor", 1);
				}
			}
			else if (choice == 3) {
				subChoice = rand(3);
				//Naga made of breasts...
				if (subChoice == 0) {
					outputText("You feel your tits dragging across the smooth cave floor... a dozen pairs arranged by size, starting with a meager pair of A-cups at the tip of your tail, up to DD cups not far below your waist.  The well-arranged boobs swell up your thighs, hitting F-cups by your hips.  Three more rows of mammoth mammaries hang from your torso, straining your poor back with their obscene weight.  You want to clutch at them, but you have no arms, and every movement is an agony of pleasure, dragging nipples, tit-pussies, and teats beneath you.  Juices run unhindered from your cloaca, your poor, neglected pussy unable to deal with the erotic sensations.");
					outputText("\n\nIn a panic, you wriggle your tit-tail, propelling yourself around the confines of your small chamber.  The door is locked, as always, but you press your tight, hard nipples against it anyhow.  Mistress has kept you pent up for so long, trapped away in this little box.  You regret everything!  You'll never doubt her again!  She was so right... nipples can feel so wonderfully, exquisitely pleasureable, but you can't take it any longer.  Every movement, every sinuous slide, they feel so good.  You can cum just from pacing about, but you know you'll just wind up a twisted, curling mass of squirming nipple-flesh, your tail half-tied in knots as it tries to rub each pair of breasts against another. You know because you've done it countless times already.");
					outputText("\n\nA spiral of pain twists through your pleasure-wounded psyche, and you remember yourself, not the demon-enslaved naga.  Still, conjoined as your minds are, you're able to recognize that one of those many breasts used to be yours.  Ceraph has put it to good use.  The realization jars you to wakefulness, and you're forced to try and go to sleep with the knowledge that somewhere, your breasts are being used to break a naga.  Sleep does not return easily.");
					dynStats("lus", 5 + player.lib / 5);
				}
				//Milk Dispenser
				else if (subChoice == 1) {
					outputText("You dream about your tits.  Not your current [chest], but the ones from before.  Before Ceraph took them.  You can't see anything.  You can't hear anything.  There's something sucking on your nipples - slowly, incessantly tugging.  Trickles of warm wetness express from your milky tits with every pull.  There's a subtle relief mixed with erotic pleasure, and as the sucking action repeats itself, you come to realize that it's mechanical.  Something is milking your tits!  It never stops or slows.  The milking simply continues.");
					outputText("\n\nSuddenly, from out of nowhere, you hear a voice in the silence, \"<i>Well, I can't thank [name] enough for these.  No shortage of milk here!</i>\"  Then, there is brightness.  The appearance of light reveals a strange, disembodied view of a demon standing next to a tank. It's Ceraph!  She holds a cup of coffee, and as she pulls a lever, creamy breast milk flows into the mocha-colored beverage, lightening it significantly. Your tits, hooked up to some kind of odd machinery, tremble and shake as fluids are fed into them by transparent cables.  The speed of the milking increases, gallons gushing from your tender teats in mere seconds.  Faster and faster the liquids flow, a veritable waterfall of lactic cream.");
					outputText("\n\nErotic energy sizzles through your nipples as the milking goes faster and faster, the pleasure unbearable.  Sadly, just when you feel on the cusp of orgasm, the machine shuts down, and the vision fades.  There will be no relief for you tonight.");
					dynStats("lus", 5 + player.lib / 5);
				}
				//Tit Volleyball
				else {
					outputText("You see Ceraph, the conniving omnibus, standing in a hazy pink void, dressed in a tiny purple bikini.  She smiles to herself as she holds out a fleshy orb.  It looks soft, jiggly... and alarmingly familiar.  As you spy a rounded areola, you realize the demon is holding one of your old breasts! She tosses the plump tit ponderously for a moment, before raising it to her mouth and... blowing?");
					outputText("\n\nAs the seductress blows into the nipple, the breast amazingly, impossibly, begins to inflate like a balloon.  She eventually stops and examines her surreal handiwork, your ex-tit now the size of a beachball.  As she bats it into the air and it begins to lazily float back into her hands, you realize it has the same density as a beachball too.");
					outputText("\n\nCeraph whistles shrilly, and a duo of buff incubi step out of the fog; each wears an obsidian choker and a bulging thong, though one of them also dons a stylish pair of ");
					if (silly()) outputText("Pink Flamingo ");
					outputText("sunglasses.  As you gaze at the unnatural scene, the demoness tosses your oversized mammary into the air and smacks it towards one of the incubi, and they quickly organise into a match of beach volleyball.  On cue, the ethereal ground is replaced by shimmering pink sand, with violet waves lapping at the shore.  Off in the distance you hear seagulls, though the sounds are warped slightly.");
					outputText("\n\nAs the demonic trio continue their game, Ceraph playing solo against the incubus tag-team, you notice, no, you <i>feel</i> your nipple react and stiffen, soon becoming erect.  Ceraph too notices and, grinning, plants a hearty smack directly on your sensitive nub.  The sudden rush of passion that her lusty touch induces causes your nipple to twitch and release an arc of milk as it sails through the air.  The stylish incubus returns her throw with one equally powerful, forcing even more cream from your now-aching breast, the white liquid brilliant against the pink-and-purple haze of the dreamworld.");
					outputText("\n\nThe game goes on, toss after toss, stream after pearly-white stream.  You notice that the milk is not merely soaking into the sand, but being drawn into a neat criss-cross mesh between the two groups.  As the mesh continues to grow with breastmilk, two enormous throbbing ");
					if (silly()) outputText("horsecocks ");
					else outputText("demonic cocks ");
					outputText("rise from the sand, forming makeshift poles for the twisted volleyball net.");
					outputText("\n\nDespite the incubi's advantage in numbers, Ceraph is trouncing them easily, forcing them to leap and dive to counter her shots.  The one with sunglasses, now panting from exertion, angrily snatches your incoming tit and bites into your areola, sucking greedily.  The pleasure is immense, his sex-skilled tongue teasing your leaking nipple with expert motions, and the teat rewards him with a thick jet of refreshing milk.  As he gulps down the creamy goodness, you notice that your breast isn't deflating at all, but the incubus is definitely inflating; his biceps bulge, his pecs jut out imposingly, and his frame grows to that of the beefiest of beefcakes, a mountain of man-muscle.  As he removes your quivering tit from his lips, his body ripped and rippling with strength, he stoically wipes away his milk moustache.  The other incubus looks slightly crestfallen.");
					outputText("\n\nThe hulking demon casually tosses your breast high into the air, before propelling himself after it and delivering an almighty spike, sending the hapless orb soaring straight towards Ceraph's stunned face.  The impact is incredible, sending the unsuspecting omnibus careening back as an immense jet of milk erupts from your teat, soaking her sprawling, bikini-clad form.");
					outputText("\n\nAs Ceraph groans, the incubi high-five each other, and your prone breast slowly dribbles milk into the sand, the dream fades, and you wake up.  You stare blankly for a moment, trying to piece together what just happened");
					if (silly()) outputText(" and what possible ramifications it has for your mental health");
					outputText(", until you dismiss it as corruption and toss over, entering a peaceful, dreamless sleep.");
					dynStats("lus", 5 + player.lib / 5);
				}
			}
			//COCKUUUU
			else {
				subChoice = rand(10);
				//WAX DRIPPU
				if (subChoice <= 2) {
					outputText("The feeling of dripping, scalding-hot pain nearly jolts you from your sleep.  It starts with just a few drops, splattering over the surface of a cock you gave to a demon, yet still have the misfortune of feeling.  Ceraph must be punishing that penis' owner for some imagined slight!  Drip, drip, drip... the torture drags on until the oldest drops have hardened, cocooning most of your forgotten phallus in a hard wax shell.  Just when you think the demon has finished, her long, pointed nails drag down the slightly-burned skin to peel away the wax.  It's nearly painful enough to make you cry, but somehow it's arousing you at the same time.\n\n", false);

					outputText("The process is repeated twice more, each more painful and arousing than the last.  Just as you're nearly driven to wakefulness, a cool salve is applied to the oh-so-sensitive member, smothering the pain with blissful cool.  Ceraph's nails tease their way through the new substance, setting you on edge.  While you're ready for an explosive climax, it never comes.  That's the last thing your phantom cock feels that night, and you drift into a peaceful, if horny, slumber.", false);
					//-3 sensitivity +200 lust.
					dynStats("sen", -3, "lus", 200);
				}
				//FUCK A BUTT
				else if (subChoice < 5) {
					outputText("At first, the sensation of a warm hand fondling your limp prick is a mere pleasant buzz in the back of your dreams, but as your inflating manhood hardens, it comes to the forefront, dominating your dream-vision.  You can see Ceraph, feel her stroking your tightly-bound dick until it's leaking pre all over her hand and pulsing within the confines of her whip's tight leather.  A voice moans, \"<i>Mistress... this is torture... you promised I could come inside yooouuuu...</i>\"\n\n", false);

					outputText("At that, Ceraph tights the whip's hold on your phantom genitalia.  In the back of your mind, you know all too well that this is no dream – you're picking up on echoes of feelings from the penis you sacrificed.  She seems quite pleased with herself too, fondling the super-hard shaft until it's bulging around the whip's leather embrace, engorged to the absolute maximum.  You (her pet?) grunt and cry, weakly trying to thrust your hips for more friction, but bound as you are on the bondage table, you can't get any leverage.\n\n", false);

					outputText("The demoness laughs, slapping your face with her tail and saying, \"<i>If my special boy wants his reward, he'll lie still for mistress until she's ready to let him cum.</i>\"  You reply, \"<i>Yes mistress,</i>\" in a voice that isn't your own, but the constant hardness of your member keeps you in the moment.  Enthralled by the swaying dominatrix's body, you lie completely still and pray your gorgeous dominatrix shows you the promised reward.\n\n", false);

					outputText("Ceraph slaps your face again, instructing, \"<i>Lie still pet.  If you so much as move a muscle, I'll spank your balls until they're red and then squeeze the cum from them by hand.  Do you understand?</i>\"  You give voice to your assent with a piteous but affirmative whimper.  The dominatrix watches you, searching for some sign of resistance, but she finds none – you're completely and totally subservient to your gorgeous, hermaphrodite fuck-queen.  She nods and climbs up onto the table, swaying her hips from side to side in a sensuous show.\n\n", false);

					outputText("You sigh happily, watching your perfectly proportioned mistress put on a show for you while your eyes never leave her lithe, sculpted form.  Ceraph drops down on her hands and knees, her pussy mere inches over your bloated cock.  The heat of her infernal womanhood bathes the pulsing penis with moist, lust-soaked air, and while you didn't think it possible, you feel yourself getting harder... painfully hard.  Your dominatrix bounces and grinds, letting her vulva kiss the tip of your cock from time to time while her hypnotically jiggling ass does its best to entrance you.\n\n", false);

					outputText("That puffy, moist entrance bounces lower, but before you slip inside the demoness arches her back and pushes her winking asshole against your cock-tip, devouring it with a messy-sounding slurp.  The crushing tightness is agony and ecstasy on your over-filled prick, but it doesn't stop you from moaning like a bitch, \"<i>Misssstress... n-not there... It's too tight!  You promised I could cum insiiiiide...</i>\"\n\n", false);

					outputText("The flattened spade of a demonic tail slaps into your cheek.  \"<i>I said you could cum inside.  I never said which hole you would get to use.  Now I want you to moan like a whore, and if you do it well enough you'll earn the pleasure of licking me out.</i>\"  Obedient even in this, you moan like a wanton whore, crying out for Ceraph to rape your cock with her corrupted asshole - to turn you into her obedient anal-addicted toy.  She obliges and bounces atop you, nearly crushing your member in her dark tunnel, but that heavenly, agonizing tightness won't accept anything but the unconditional surrender of your seed into its depths.\n\n", false);

					outputText("You fight to stay still, resisting your body's urgings in order to be allowed the pleasure of cleaning your cum from mistress with your tongue, and though you have to bite your lip while you moan, you succeed.  In one torrential burst, your cock feels like it explodes, untangling the whip from around itself with the sheer force of its orgasmic engorging.  A blast of semen pumps into your mistress, making her coo with delight.\n\n", false);

					outputText("\"<i>Good pet.  Yes, you're my good, special boy aren't you?  Moan for me, pet.  Moan for your mistress like the willing whore that you are.  That's better... mmm... I'll tell you what.  Since you're doing such a good job of stuffing all your spunk inside me, I'll let you pack it full again after you clean it.  And if you're still my good little whore, I'll let you lick that out too!</i>\"\n\n", false);

					outputText("Oh gods, she's so perfect.  You submit completely, emptying every ounce of your loins into her perfect purple-skinned ass.  Totally spent, your cock gives a few waning twitches and starts to soften.  Ceraph smiles and lifts off, spunk dripping from her gaping asshole as she slides it up your chest.  The dream-sequence fades before you can see any more, fading away along with the wilting strength of your former penis.\n\n", false);

					outputText("With the sensation and scenario fading, your confused dreams shift before resuming a more normal flow.  You've no doubt you'll feel sated in the morning, but the lingering echoes of Ceraph's pet in your mind wishes you'd go submit to her.", false);
					//(-100 lust, +1 corruption)
					player.orgasm();
					dynStats("cor", 1);
				}
				//FEATHER TORTURE
				else if (subChoice < 7) {
					outputText("Throughout the night you're constantly aroused by the feelings of feathers sliding up and down your turgid member, teasing the swollen hardness with soft, even strokes.  Without ever increasing the pace, you're kept in a hell of constant sensation.  It goes on and on, your swollen balls getting sore and achy.  You open your eyes, seeing yourself in a dungeon – Ceraph's dungeon – with a feathery harpy girl a few inches away.  She's slowly squatting up and down, sliding her soft tail-feathers over your groin to tease you.\n\n", false);

					outputText("Her mouth is filled by Ceraph's dick, jizm pooling from the corners of her mouth while her lipstick gilds the demon's cock in gold.  The demonic dominatrix is panting, blushing hard from all the harpy-drugs in her but showing no signs of slowing down.  \"<i>Keep sucking you thick-thighed turkey.  You're going to swallow my cum until your lip-stick wears off or your belly's too full for you to move.  We'll see which happens first!  And don't you dare stop teasing that dick behind you either!  Nice even strokes.  Once we break " + player.mf("his", "her") + " fragile little mind I've got a new personality I want to give " + player.mf("him", "her") + ".</i>\"\n\n", false);

					outputText("The scene fades, but that maddening, feathery purgatory on your phantom cock never goes away.  You're kept hard, on the verge of orgasm, all... night... long...", false);
					//(+100 lust, +30 hours since last orgasm)
					dynStats("sen", 3, "lus=", 100);
					player.hoursSinceCum += 30;
				}
				//Cock Sandwich
				else {
					outputText("Your dick feels gooooooood.  Damn good.  Like two tight, sweaty bodies are grinding into it from either side, hot drippy gashes smearing across the tip. Opening your eyes, the strangest sight greets you - two oiled up succubi, their arms bound around each other, stuck chest to chest.  The demonic duo is busy trying to make the best of a bad situation, moaning into each other's mouths and working each of their squirming bodies relentlessly against the other's engorged erogenous zones.  All four legs wrap around your waist, bound up on the other side in latex or something else, trapping your cock firmly where it belongs - between the two slick, demonic honeypots.");
					outputText("\n\nGushing girl-goo soaks you to the balls as one of the two reaches her peak, her moisture spraying in wild, pleasurable release.  The stud that pierces her hard clit bumps against your tip as she thrashes, and you find yourself desperately wishing you were not so restrained by their legs.  If only you could properly thrust, these tainted tramps would be soaked with your cum!  Instead, the best you can do is wiggle from side to side a little bit, which only makes the gift Ceraph granted you all the harder.  Curse whoever she got this dick from!  The hellishly pleasurable sensations build relentlessly, and yet you have no release.");
					outputText("\n\nYou glance down to watch, admiring the swell of your fantastic bust.  After all, it is what caused Mistress to pursue you in the first place.  Your pert nipples stand out, hard and proud, thick, gem-studded hoops hanging from them.  The second row Ceraph gave you is pierced in the same way, though you can't see much aside from the gleaming metal of their piercings.  Sighing, you turn your attention back to the purple twins, their twisting bodies rejoicing in the oddly-constrained sex, as if they relished the challenge of achieving release in such a restrictive situation.  Fucking bitches.");
					outputText("\n\nSMACK!  Ceraph's hand swats your pert bottom, a stinging reminder of just who is charge here.  You crane your head to look at your mistress, twisting your torso to give her a good view of your many sideboobs.  Perhaps if you give her some eye-candy she'll deem you worthy of a nice, hard fuck.  It's so rare to be chosen by the mistress for sex, but oh so very wonderful when you are.  You shiver at the memory of the last time, when Ceraph used her magic to make every single one of your piercings gently vibrate against you.");
					outputText("\n\n\"<i>Enjoying yourself, pets?</i>\" the Mistress asks.");
					outputText("\n\nThe demonettes answer, \"<i>Yes goddess, thank you for this nice thick cock to tease!</i>\" with voices full of delight.");
					outputText("\n\nCunts.");
					outputText("\n\nTheir bodies writhe faster against you, and Ceraph whispers in your ear, \"<i>Would you like to cum too?  ...to empty that nice, hard cock I gave you all over that oiled-up female flesh?</i>\"");
					outputText("\n\nYou do the only thing you can.  You nod and whimper, \"<i>Yes, Mistress, yes, please, I've been so good to you.</i>\"");
					outputText("\n\nCeraph coos happily as she pinches your nipple.  \"<i>Good pet.  You may cum... tomorrow.  For now, stay nice and hard.  You've only been edged six days so far; another one won't be too big of a deal, will it?</i>\"");
					outputText("\n\nNo!  Anything but that!  You start to beg, but a gag fills your mouth.  It tastes sweet, like strawberries and cream, and the dribbling meat-stick pinned between the succubi's tight bods begins to drip even more.  What did she put on this gag?  There's no way to ask - Ceraph's heels click a few times as she wanders away, and the two tainted twats below are too busy rubbing your cock and making out to give you answer.  A moan of bliss reverberates through your gag, releasing more yummy, cock-thickening goodness.  Your torturers hear as well, and they slow their gyrations to make sure you don't cum yet.  After all, they get to abuse you for another day...");
					outputText("\n\nYou wake with your heart pounding.  That was hot, but agonizing.  It will be hard to go back to sleep now.");
					dynStats("lus", 5 + player.lib / 5, "cor", .5);
					player.hoursSinceCum += 100;
				}
			}
			doNext(playerMenu);
		}

		internal function buttRapeCeraph():void
		{
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00291]++;
			spriteSelect(7);
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = 0;
			clearOutput();
			outputText("Completely defeated, the haughty demoness lies face down in the dirt, ", false);
			if (monster.HP < 1) outputText("her tail hanging limp between her legs.  She spits a wad of bloody saliva and says, \"<i>What's the matter?  Beat a girl senseless and lose your nerve?  I thought you were going to rape me.</i>\"", false);
			else outputText("her rump up in the air while her tail plunges violently into her cunt over and over again.  She moans up to you, \"<i>What's the matter?  Are you nervous about putting it inside me?  Come on... rape me already!  Punish my gushing-wet cunt with your divine rod!</i>\"", false);
			outputText("\n\nYou reach down and slap her ass hard, ", false);
			if (player.str < 75) outputText("making her whole body jiggle", false);
			else outputText("making her jiggle and slide a few inches in the dirt", false);
			outputText(" and shutting her up while you tear off your " + player.armorName + ".\n\n", false);

			outputText("Now naked, you waste no time in grabbing her by her toned thighs and lifting her up, rubbing her face in the dirt while you get a nice look at her tightly-clenched asshole and ", false);
			if (monster.HP < 1) outputText("wet ", false);
			else outputText("achingly wet ", false);
			outputText("demon-twat.  Her vulva flares out, massively engorging and unfolding like a flower, practically begging you to plunge into the dripping tunnel.\n\n", false);

			outputText("\"<i>Nooooo... don't stick it in my pussy!  You'll get me pregnant!  Or is that what you're after?  Are you gonna keep cumming in my naughty hole until I'm too pregnant to move?  Is that your plan, champion? Are you going to keep all the demons too pregnant to resist you?  Look at how wet you've made my pussy... I'm a high class demon, y-you can't make me pregnant!  Nooooo,</i>\" groans Ceraph while her tail wraps around your " + player.cockDescript(x) + ", clearly trying to entice you, but you've got a surprise in store for her.\n\n", false);

			outputText("You rub your " + player.cockHead(x) + " against the demonic juice-fountain, letting Ceraph slather you with corrupted lubricants while you tease her whorishly-ready fuck-lips.  In seconds you're soaked from tip to hips, and before Ceraph can con you into filling her full of demonic children, you drop her low and ram your " + player.hipDescript() + " forward.  Her pucker, though tight, yields before your onslaught, gradually dilating to accept your " + player.cockHead(x) + " and the first few inches of your " + player.cockDescript(x) + ".", false);
			if (player.cockTotal() == 2) outputText("  The other " + player.cockDescript(x) + " rubs against her butt-cheeks, sliding through them with ease thanks to her copious secretions.", false);
			else if (player.cockTotal() > 2) outputText("  The rest of your male genitals slide between the demoness' pert butt-cheeks in one huge, femcum-slicked bundle.", false);
			outputText("  Ceraph squeaks in distress, taken completely by surprise and for once, completely lacking a witty retort.\n\n", false);

			outputText("The demon grunts like a wounded animal underneath you, her long, demonic tongue hanging out to flop in the dirt while you rock her half-comatose form closer to your crotch.  Inside, your " + player.cockHead(x) + " squeezes past the tightness of her anal ring to the unusual warmth of a demon's innermost depths.  More and more of your " + player.cockDescript(x) + " slips into the wonderfully tight, hot little hole, the penetration growing ever easier as the defeated demon relaxes into her role as a cum-dump unworthy of your children.", false);
			if (monster.HP < 1) outputText("  Cunt-juice splatters over your " + player.legs() + " as Ceraph's now-energetic tail plunges into her sodden box, pumping into it in time with the penetration of her asshole.", false);
			else outputText("  Cunt-juice dribbles over your " + player.legs() + " as Ceraph's tail slowly and purposefully plows her box, mimicking the penetration of her asshole.", false);
			outputText("\n\n", false);

			outputText("Ceraph whimpers and begs, \"<i>Noooo... you're raping my ass... g-get it out of there!  Aren't you supposed to be p-pure?  Untainted?  You're – unf – fucking a demon's butt like some kind of pervy animal!  Please... f-fuck my pussy.  I don't even mind if you don't wash it off... just stick it in my cunt.</i>\"\n\n", false);

			outputText("Like hell!  You pull harder, splitting her asscheeks until they're squished into your body, her cock-gaped asshole ", false);
			if (!player.hasSheath()) outputText("barely touching your groin", false);
			else outputText("rubbing your sheath", false);
			outputText(".  The demon's ass is warm enough to make you feel you could melt like an icicle in an oven, the blissful sensations spurring you to play with her supple ass-cheeks while you enjoy the complete penetration of a demon's backdoor.  You give those cheeks a hard slap and pull back, enjoying the feel of her gloriously tight ring as it slides over the pussy-slicked length of your " + player.cockDescript(x) + ".\n\n", false);

			outputText("Without waiting, you slam it back home, burying it in the swelteringly hot backside.  Ceraph grunts, her tail locked in time with you and clearly bringing her great pleasure.  You take the time to reach down and pull it out – if she's going to cum, she's going to cum to the feel of you packing her bowels full of wasted seed.  She cries in distress, \"<i>Noooooo... fuck you!  Please... at least let me cum from this.  You're fucking me so dominantly... so hard... by Lethice it's making me so soaking wet.  Please!  Let me cum, let me cum... letmecumletmecumletmecum!</i>\"\n\n", false);

			outputText("You don't let go of her tail.  She's going to pay for constantly trying to turn you into some kind of fetish-bound bitch!  You pump her hard, the echoes of your sweating bodies slamming together echoing over the mountainside, likely attracting all manner of demons and beasts.  A voice in the back of your mind warns you to hurry, lest you get caught unawares by another monster, and you speed up your thrusts in response.  Ceraph stops fighting after a few particularly powerful, hip-slamming hits, a string of pre-cum dangling from her half-limp cock.  Each frenzied butt-fuck squeezes out more of the stuff, but before she can cum, you feel your own orgasm hit.\n\n", false);

			outputText("Ropes of jism splatter into the demon's rectum, and while it turns her tight back-door into a drooling wet fuck-hole, it actually lowers the temperature to a saner threshold.  ", false);
			if (player.cumQ() >= 500 && player.cumQ() < 1500) outputText("Her belly bulges slightly from the cummy deposit, marking her even more obviously as a cum-bucket for your cock.  ", false);
			else if (player.cumQ() >= 1500) outputText("Her belly burbles and swells, bulging out to look positively pregnant, though you know she's packed from the other end.  ", false);
			outputText("You pull out, and Ceraph's ", false);
			if (player.cocks[x].cockThickness < 3) outputText("slightly-gaped", false);
			else if (player.cocks[x].cockThickness < 5) outputText("gaped", false);
			else outputText("gaping-wide", false);
			outputText(" asshole leaks spunk everywhere. Disgusted with her", false);
			if (player.cor < 33) outputText(" and a little bit by yourself", false);
			outputText(", you drop her like a discarded rag.  She moans and begins masturbating, half-insensate from the rough treatment.  You ignore her, get dressed, and get out of there before the mountain's beasts show up.  Ceraph is in for a wild night!", false);
			player.orgasm();
			if (getGame().inCombat)
				combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}


	}
}
