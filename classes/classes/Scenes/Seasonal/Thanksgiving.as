//Turkey Girl Thanksgiving Special
//By: Savin


/*
Requirements:
Introduction:
Shoo her Off
Let her Approach
Baste Her
Stuff Her
SPITROAST HER! GangHel Style*/

/*Requirements:

-PC has a Dick
-PC has (Dick'd)Izma or Ceraph in camp (to get the Spit Roast scene only)
-Scene proc's at 12:00, overriding other scenes

Note on progression:
   The PC has, after each scene (Baste, Stuff, Spitroast) the option to say \"<i>That's Enough</i>\" or continue on to the next scene -- the scenes must be done in order, however.*/
package classes.Scenes.Seasonal {
	
	import classes.*;
	import classes.GlobalFlags.*;

	//const TURKEY_FUCK_YEAR_DONE:int = 566;
	
	public class Thanksgiving extends BaseContent 
	{
		public function Thanksgiving() {}
		
		public function isItThanksgiving():Boolean {
			return ((date.date >= 21 && date.month == 10) && (date.date < 30 && date.month == 10) || flags[kFLAGS.ITS_EVERY_DAY] > 0);
		}
		   
		//Introduction: -McGirt
		public function datTurkeyRumpMeeting():void {
			if (flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] > 0) {
				turkeyGirlTwoTheTurkeningBySavinWhatADickInAButt();
				flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] = date.fullYear;
				return;
			}
			flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] = date.fullYear;
			outputText("\nYou sit down by your fire pit, looking at the meager provisions you've managed to gather up in the days leading up to the Feast for the Thankful, your village's largest annual feast day.  Right now through the portal, your friends and loved ones from Ingnam are sitting down to a mighty banquet, holding hands in prayer before devouring more food than they can possibly stand.  A pang of homesickness sweeps through you as you look at the small meal before you.  With a sigh, you pick up your fork and prepare to dig in.");
			outputText("\n\nSomething stirs at the edge of camp.");
			
			outputText("\n\nYou jump to your feet, readying your [weapon] for battle as you scan the perimeter.  A moment later, and you see a ponderous figure step out of the shadows behind a large rock.  At first glance, it looks like a normal girl dressed in a simple deerskin poncho, her bright red hair falling past her shoulders to rest on a pair of absolutely massive breasts.  Timidly, she steps forward, giving you a good look at her less human attributes: a pair of avian legs stick out beneath the hem of her clothes, and a large plume of feathers stick up from her big bubble-butt, each red feather nearly reaching the back of her head.  And her breasts... each easily the size of a goblin, so massive that it seems she can barely wobble along.");
			
			outputText("\n\n\"<i>G-gobble?</i>\"  she asks quietly, her big blue eyes pleading at you.");
			
			//[Shoo her Off] [Let her Approach]
			simpleChoices("Let Approach", letZeTurkeyApproach, "Shoo Away", shooTurkeyAway, "", null, "", null, "", null);
		}

		//Shoo her Off -McGirt
		public function shooTurkeyAway():void {
			clearOutput();
			outputText("You scowl and wave your arm at the strange turkey-girl, telling her to get lost.");
			
			outputText("\n\n\"<i>G-gobble?</i>\"  she repeats, cocking her head to the side.");
			
			outputText("\n\nRolling your eyes, you yell at the strange girl until she finally gets the idea and; with a few more sorrowful gobbles, she wobbles off again, looking for someone else to bother.");
			
			outputText("\n\nShaking your head, you sit back down and eat.");
			if (player.hunger > 60) player.hunger = 70;
			player.refillHunger(40);
			doNext(playerMenu);
		}

		//Let her Approach
		public function letZeTurkeyApproach():void {
			if (player.gender == 2 || (player.gender == 3 && rand(2) == 0)) {
				femaleLetZeTurkeyGalApproach();
				return;
			}
			clearOutput();
			outputText("Considering her ponderous form, the girl obviously poses no threat.  You wave her over, telling her to come on into camp.  With a huge grin, the turkey-girl wobbles over, her gigantic breasts swaying underneath her moccasins until she plops down beside you.  You try saying hello and introducing yourself, but the girl simply cocks her head to the side and murmurs, \"<i>Gobble?</i>\"");
			
			outputText("\n\nYou raise an eyebrow.  Is that all she can say?");
			
			outputText("\n\n\"<i>Gobble?</i>\"  she asks again, her hand drifting onto your leg.  You feel [eachCock] involuntarily stiffening as her slender, alabaster fingers slide along your thigh.  \"<i>Gobble,</i>\" she repeats, brushing your stiffening prick through your [armor].  Oh, is that what she wants?  Well then....");
			
			//(Baste Her) (That's Enough)
			simpleChoices("Baste Her", basteThatTurkeyBooty, "No Thanks", noThanksTurkeyGal, "", null, "", null, "", null);
		}

		public function noThanksTurkeyGal():void {
			clearOutput();
			outputText("You reluctantly push her away.  You've no need to ram your dick down some new monstrosity's gullet.  The girl forlornly gobbles one last time, then prances off into the fading evening light, globular ass jiggling.");
			doNext(camp.returnToCampUseTwoHours);
		}
		//Baste Her -McGirt, reluctantly
		public function basteThatTurkeyBooty():void {
			clearOutput();
			outputText("You let your cock slip free of your [armor], and immediately the turkey-girl takes it in hand, wrapping her fingers around your thick shaft and giving it a few long, languid strokes.  \"<i>Gobble?</i>\"  she asks, and this time you nod as she leans down toward your cock, her long tongue flicking out to run across the [cockHead], tickling the slit of your urethra as she continues to pump your prick.");
			
			outputText("\n\nHer huge tits pop free as you toss her deerskin poncho aside, the massive orbs falling into your lap around your [cock].  The turkey lowers herself onto your rock-hard rod, wrapping her full red lips around the crown and slurping it up.  You run your fingers through her red hair, guiding her head down along your shaft, pushing more and more of your length past her rosy lips and into the wet vice of her throat.  She gags a moment as your tip brushes past her tonsils, but relaxes in your grip, content to let you slowly stuff the entire length of your cock into her pliant mouth.");
			
			outputText("\n\nWith your [cock] shoved fully into the turkey-girl's mouth, you let her begin to blow you, moving her head up and down your length, her tongue lapping hungrily as the underside of her throat contracts around the shaft, trying to gobble it all up.  You stroke her hair, urging her onwards, enjoying the pleasant tightness of her throat and the ministrations of her tongue.  You let the turkey-girl carry on for a few rapturous minutes, shuddering as her coarse tongue slathers your [cock] with her warm saliva, her lips pressed firmly around the inches of your prick she takes in and out of her mouth, always keeping the thick crown in her mouth, lavishing it with throat-kisses and gentle suckling.");
			
			outputText("\n\nAn idea comes to mind as you begin to feel a knot forming in your [balls].  You grab the turkey-girl's bare, supple shoulders and push her up onto her knees, leaving her kneeling in front of you, a surprised \"<i>Gobble?</i>\"  escaping her lips as your cock pops free.  Time to baste this turkey.");
			
			outputText("\n\nYou stand and grab her titanic tits, hefting them up and pushing them together around your stiff [cock].  You start to buck your [hips] into her soft, yielding titflesh, using her massive mammaries to get yourself off.  Quickly, thick rivulets of pre begin to leak from your crown, smearing onto her breasts as you titfuck the hapless girl.  She lets out a series of alarmed gobbles as you thrust into her chest, but finally gets the idea as your leaking head pokes out from between her mounds and, like a good little cock-gobbler, slurps it back up into her eager mouth.");
			
			outputText("\n\nYou move faster and faster, willing the potent seed surging through your loins out and onto the strange turkey, humping her tits until with a roar of ecstasy you pull out of her mouth and cum. Thick globs of spunk shoot out of you, smearing the turkey-girl's face, the tops of her huge breasts and, from there, leaking down onto her flat stomach and bare thighs.  You continue to thrust between her tits, spurting out the last of your climax onto her neck and chest, utterly covering the turkey-girl with your seed.");
			
			outputText("\n\n\"<i>Gobble!</i>\"  she cries ecstatically, a huge smile playing across her face as she licks up a bit of your cum from her cheek, drinking it up without inhibition.  With a sigh, you let the girl's bosom fall free, leaving your wilting prick in the warm air, content with the powerful face-fucking you've given the eager slut.  You run your hand through her hair again, telling her what a good cock-gobbler she is.");
			
			outputText("\n\n\"<i>G-gobble?</i>\"");
			
			outputText("\n\nThe turkey-girl smiles at you and flops onto her back, spreading her meaty thighs to give you a good look at the trimmed red bush between her legs, and the glistening slit of her vagina.  It looks like she wants some stuffing....");
			player.orgasm();
			dynStats("sen", -1);
			simpleChoices("Stuff Her", stuffDatTurkeyWithSpoo, "", null, "", null, "", null, "That'll Do", thatllDoTurkey);
		}

		//Stuff Her -McGirt, this is awful by the way.
		public function stuffDatTurkeyWithSpoo():void {
			clearOutput();
			outputText("Even though you just came, the sight of such an inviting pussy causes your cock to begin to stiffen again.  You move between the turkey legs, tossing them over your shoulders to give you the best angle on her slick snatch.  You give her an experimental lick, running your tongue across her outer folds.  The girl shivers slightly, a tiny gasp passing her lips as you flick your tongue across her tiny bud.  Spurred on by her cute reactions, you bury yourself between her thighs, lapping at her cunt and clit.  Soon, she's nice and ready, her slit practically leaking her lubricants as you orally assault her, preparing her passage for your stuffing.");
			
			outputText("\n\n\"<i>Gobble?</i>\"  she coos, her fingers slipping down to spread her lips wide as you withdraw, giving you a perfect look at the waiting hole for you to fill.  You grin at her and, straightening yourself out, let your [cock] flop onto her crotch, the shaft resting between the lips of her womanhood.  You slide back, letting the [cockHead] of your prick line up with the turkey-girl's tunnel.");
			
			outputText("\n\nAnchoring your fingers around her thick thighs, you ease yourself into the turkey-girl.  A ragged gasp escapes her lips as your turgid [cock] parts her lower lips, sliding through the spit-lubed channel of her cunt with agonizing slowness.  You revel in the tight, slick muscles of her cunt contracting around you, her pussy squeezing down on your invading member as you push further and further into her, nearly tearing her tight slit apart until your crotch presses against hers.");
			
			outputText("\n\n\"<i>G-gobble?</i>\"  the girl asks plaintively, looking over the massive mounds of her breasts to watch the final inches slide into her.  Oh, those do look like inviting targets....");

			outputText("\n\nYou begin to move your hips, slowly rocking a few inches of your cock out and back into the turkey's vice-like sheathe.  Yet your attention turns to the huge, soft orbs of her tits, so large that all but the top of her head is obscured by titflesh.  You reach up, sinking your fingers into one of the huge mounds, angling the large, pink nipple towards you.  A moment passes, your fingers kneading her sensitive breast as you push your cock into her to the hilt.");

			outputText("\n\n\"<i>Gobble,</i>\" the turkey-girl suggests, pushing her mountainous breast toward you, the little nub of her nipple practically brushing your cheek.  You lick your lips and accept the proffered teat, locking your mouth around her large, pale areola.  You run your tongue around the turkey-girl's teat, swirling around the delicate outer flesh before running across the ridges of her stiff nipple.");
			
			outputText("\n\nTo your surprise, something comes out as you suckle from the turkey-girl!  For a moment, you prepare to feast upon a stream of milk from the strange avian, but... it's much too thick, and whatever she's lactating into your mouth tastes like... wait, no.  No way it's actually...");
			
			outputText("\n\n...Gravy?");
			
			outputText("\n\nYou gag a bit as a thick trickle of gravy spills down your throat, now pouring freely from the girl's heavy-laden teats.  She sighs contentedly as you swallow another mouthful of tit-gravy, starting to form a rhythm of sucking sharply between steadily quickening thrusts into her sodden vagina.");

			outputText("\n\nSoft moans begin to echo through the air as you thrust harder and faster into the turkey-girl, lapping up half a gallon of gravy from one of her huge tits before switching to the other, giving her neglected nip the attention it deserves.  You hammer into her, thrusting with enough force to let loose spurts and trickles of femcum and your own pre as the turkey-girl throws her head back in rapture, overwhelmed by the dual sensations.");
			
			outputText("\n\nWith a laugh, you let go of the turkey's tit and bury your face between her mounds, burying yourself in her expansive flesh as ");
			if (player.cumQ() < 1000) outputText("you let loose another load of seed, this time deep into her cunt.  You grunt and growl animalistically, pumping thick gobs of spunk into her until the turkey's womb is practically painted white with your cum.  Each roar sends shudders through her teats, waves of the fatty flesh forming as you cry out into her chest.  You steady yourself between orgasmic thrusts by grabbing onto her melons, your sudden grasp harsh enough to elicit a stream of titgravy from inside her.");
			else outputText("your [cock] distends and bulges.  A startled gasp catches in her throat as the hapless fowl's fuckhole is stretched wider by the oncoming storm.  No sooner has your shaft unloaded a monstrous surge of virile spunk deep inside her cunt than a familiar pressure signals yet another load is on the way.  As you continue to stuff the bitch with baby batter, her once-taut stomach swells outwards, jiggling and gurgling with each fresh load.  Your grunts and growls intermingle with the overstuffed turkey's moans of mindless lust.  Each roar sends shudders through her teats, waves of the fatty flesh forming as you cry out into her chest. You steady yourself between orgasmic thrusts by grabbing onto her melons, your sudden grasp harsh enough to elicit a stream of titgravy from inside her.");
			
			outputText("\n\nSoon, between your kneading out the thick gravy from her breasts and the spunk leaking out from her loins, mixing with what you splattered across her minutes earlier, the poor turkey is absolutely filthy, covered in the remnants of your rough fucking.  Slowly, languidly, you pull out from inside her, your cock still dribbling little rivulets of cum onto the musky girl's thighs.  The air around you now reeks of sex and a warm meal, her strange breastmilk creating a strong aroma of its own below that of drying spooge.");
			player.orgasm();
			dynStats("sen", -1);
			if (flags[kFLAGS.HEL_FUCKBUDDY] == 1 && flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] == 0) {
				outputText("\n\nAs you lay atop the turkey, you hear a faint, almost pleading, \"<i>Gobble?</i>\"  from her. Furrowing your brow, you pick yourself up to look at the cum-slathered turkey.  As soon as you're off her, she rolls over onto her hands and knees, her big bubble butt sticking up in the air for you, her plume of feathers tickling your cheeks.  She... still wants more?</i>\"");
				simpleChoices("Spit-Roast", spitRoastThatTurkey, "", null, "", null, "", null, "That's Enough", thatllDoTurkey);
			}
			else doNext(thatllDoTurkey);
		}

		//SPITROAST HER! GangHel Style 
		//(Needs friendly/lover Hel)
		public function spitRoastThatTurkey():void {
			clearOutput();
			outputText("As you contemplate what to do with the insatiable turkey-girl, you hear another rustling at the edge of camp.  For a moment both worried and aroused by the thought of a whole flock of these sluts, you glance up in time to see a certain salamander poking her way through your bevy of traps.");
			
			outputText("\n\n\"<i>Here, Cockgobbler!  Here girl!</i>\" she calls, letting out a sharp whistle that echoes through the camp. \"<i>C'mon out, girl, I know you're --- on hey, lover mine!  Don't suppose you... oh, I see you met my little Cockgobbler,</i>\" Hel laughs, sauntering over.");
			
			outputText("\n\n\"<i>Aww, did you find a juicy little cock, girl?  Was that lots of fun?</i>\" she laughs, scratching the little turkey girl under the chin, talking down to her like a pet.  Looking up to you, she adds, \"<i>Guess she found the best cock around, huh?  Been tracking this little cutey for a couple of days, now.  Real sweetheart; not too bright, though.  Couldn't tell the difference between a gnoll slut and a real cock.  Might just not be too picky, though.  Either way. So, I don--- hey!</i>\"");
			
			outputText("\n\nBefore Hel can finish her sentence, the turkey-girl reaches out and nabs the salamander's tail between her teeth, grabbing it like a worm off the ground.  Though she flails around in confusion for a moment, Hel soon lets out an involuntary shudder as the turkey-girl applies her oral talents to Hel's sensitive tail-end.  \"<i>W-well, if you insist...</i>\"");
			
			outputText("\n\n\"<i>Gobble,</i>\" the turkey says, muffled by the thick tail stuffed in her mouth.");
			
			outputText("\n\nAs Hel moves to straddle the turkey's shoulders, planting her own cunt in front of the avian girl's face, you decide to join in on the fun.  You sink your fingers into the cockgobbler's plump buttocks, kneading her plush ass as you had her tits before.  You give her a little push, letting her rest upon her massive gravytits as you spread her cheeks out, getting a good look at her last unviolated hole.  Grinning, you slip a finger into your mouth, slathering it with as much saliva as you can before pressing the tip against the tight ring of her ass.");
			
			outputText("\n\n\"<i>Mrh?</i>\" the girl mumbles, looking over her shoulder for a split second before Hel grabs her by the hair and puts her back to work. With your partner helpless to stop you, you push in, parting her sphincter with the very tip of your finger before sliding the well-lubricated digit in.  She lets out a muffled gasp, squealing around your lover's mouth-filling member as you push your finger in to the last knuckle, swirling it around in little circles inside her ass.");
			
			outputText("\n\nWhen you've given her all the lubrication you can, you slowly withdraw your finger and grab your [cock], pushing it up between her full buttcheeks.  The turkey-girl makes a pitiful squeak of a \"<i>Gobble!?</i>\" as you press the [cockHead] against her lightly-stretched anus, giving it an extra gob of spittle on the tip as you start to push into her. She's incredibly tight, her poor, defenseless sphincter clamping down hard around your intruding cock as you press the first inches into her, gently guiding yourself into her backdoor.");
			
			outputText("\n\nThe turkey squirms and writhes as you start to slowly buttfuck her, shuddering and mewling at the strange sensations.  Yet every time she tries to move, Hel locks the girl's head back between her legs, keeping the little slut occupied with sucking her tail. Free to continue, you grab the turkey's wide, egg-layer hips and start to fuck her properly, picking up the pace to a powerful rut, pounding her butt with only her jiggly ass to ablate the force of the buttfuck.");
			
			outputText("\n\nYou hammer the turkey-girl's ass, fucking her until she cries out around Hel's tail, screaming an ecstatic combination of lusty moans and her only word.  Now she's getting into it! You grab her auburn hair, yanking her head back as you land a thrust hard enough to send wobbles through her whole body, ripples running through her bubble butt and goblin-sized jugs.  Over her plumage, you hear Hel give out a sharp yelp, and for a moment fear you've made the poor turkey bite down on her -- until you see Hel's eyes rolled back in her head, one hand ravaging her tits and the other furiously masturbating.");

			outputText("\n\nWith a roar, you give the turkey a hard slap on the ass and, with her last violent contraction around your prick, cum.  Thrice already in the last hour, but you manage, pouring another hot load of semen into the turkey's abused anus.  She cries out as you slap her butt, but her scream turns into a long, lewd moan as she feels your seed filling her bum, your prick packing it in until trickles of spooge pour out around your shaft.");
			
			outputText("\n\nYou pull out of her with a wet squelch, grinning as a flood of your spunk starts to pour from her abused asshole, mixing in with the titgravy and two other loads you blew on her previously.  Supported by her huge tits, the turkey-girl goes limp, finally contented by the third fucking, her body stained and completely covered in your cum.  Looking around her, you see Hel lying on her back, snoring quietly after her own tail-based orgasm, her own body coated liberally with femcum and globs of your own spunk that rubbed off on her.");
			player.orgasm();
			dynStats("sen", -1);
			doNext(thatllDoTurkey);
		}

		public function thatllDoTurkey():void {
			clearOutput();
			outputText("Running your hand through the turkey-girl's hair, you whisper what a good little cockgobbler she is. However, you soon find that the poor thing's passed out, your rut finally over with.  You give her a gentle push over her back, giving you a nice soft tit-pillow to lay your head down upon as you pick up the lunch you'd been preparing to eat before the eager slut arrived.");
			
			outputText("\n\n\"<i>That'll do, turkey,</i>\" you say, patting her jiggling tit. \"<i>That'll do.</i>\"");
			if (player.findPerk(PerkLib.PilgrimsBounty) < 0) {
				player.createPerk(PerkLib.PilgrimsBounty,0,0,0,0);
				outputText("\n\n(<b>Perk Gained: Pilgrim's Bounty - Lower lust values no longer reduce the size of your orgasm.</b>)");
			}
			doNext(camp.returnToCampUseTwoHours);
		}

		//Let her Approach:
		public function femaleLetZeTurkeyGalApproach():void {
			clearOutput();
			outputText("Considering her ponderous form, the girl obviously poses no threat.  You wave her over, trying to welcome her to the camp.  With a huge grin the turkey-girl wobbles over, her gigantic breasts heaving beneath her poncho until she plops down beside you.  You try saying hello and introducing yourself, but the girl simply cocks her head to the side.");
			
			outputText("\n\n\"<i>Gobble?</i>\"");
			
			outputText("\n\nYou raise an eyebrow.  Is that all she can say?");
			
			outputText("\n\n\"<i>Gobble?</i>\" This time her question is punctuated by her hand drifting onto your leg.  You feel your body warming slightly as her slender, alabaster fingers slide along your thigh.  \"<i>Gobble.</i>\" She repeats, fingertips brushing against the crotch of your [armor] as she squeezes your thigh gently.");
			
			outputText("\n\nIt looks like you've found yourself a dinner guest...");
			//[Appetiser] [Main Course] [Dessert]
			simpleChoices("Appetizer", turkeyAppetizer, "Main Course", femaleAndTurkeyMainCourse, "Dessert", haveTurkeyGirlDesertInYourCunt, "", null, "", null);
		}

		//Appetiser:
		public function turkeyAppetizer():void {
			clearOutput();
			outputText("Biting back a moan as the girl continues to tease you, your own hands reach out to her wrists, reluctantly pulling her hands away and placing them on her own thighs.  She seems disappointed as you shift in your seat, but before she can voice her displeasure you slide up to her, snaking an arm around her back as you start to play with her oversized rack.  She gasps slightly as you heft her plush breasts, kneading and squeezing them as your fingers circle around her hardening nipples.");
			
			outputText("\n\nShe shivers at your attentions, starting to grind her thighs together as you press yourself into her side.  Your fingertips pinch at her nipples, staining the thin clothing covering them with dark, damp patches that slowly spread as you increase the pressure.  She coos as you start to nuzzle her neck, kissing and nipping at her ear as you press yourself harder against her.  She cranes her neck as your tongue traces her earlobe, going limp in your arms as a particularly large dollop of fluid starts to soak completely through her poncho, covering your fingers.");
			
			outputText("\n\nYou groan into the girl's ear as warm fluid drips over your hands, slowly nudging her until she flops backwards atop the log, her legs splaying to lie either side of the wood.  Still sitting upright, you look down at her as you bring a hand to your mouth, eager to taste her milk.  However, as your tongue swirls around your fingers, your eyes go wide; this isn't milk!  The taste is far too savory, although it is probably one of the best things you've tasted since you entered this realm.  Your brow furrows as you slurp another finger clean of the thick, delicious fluid.  If you didn't know better, you'd have to say that it was some kind of gravy! Then again, considering where you are, maybe that's not so implausible.");

			outputText("\n\nA choked moan rips your attention away from your new discovery and you look back at the source of both the sound and the delicious goo covering your hands.  The turkeygirl has sprawled herself out on the log, the bottom of her poncho flipped up to reveal her severe lack of undergarments.  One hand sits atop her exposed pussy, slowly rubbing in languid circles around her clit whilst her free hand plays with a still-leaking breast.");
			
			outputText("\n\nIt's the sight of her big, beautiful rear that snaps you back into action and you quickly position yourself over the girl, placing a knee between her legs as your hands slide up her juicy thighs.  She coos softly as your knee grinds against her cleft, one of your hands pulling hers away, relocating the reluctant limb to her heaving chest.  Your other hand strokes up and down her feathered thigh, rubbing teasingly close to her needy clit, drawing another low groan from the aroused avian.");
			
			outputText("\n\nHer breathing grows ragged as you press your leg harder into her crotch, feeling her engorging lips beginning to spread slightly at the increased pressure.  Beneath the poncho, her enormous tits jiggle and bounce as her hands furiously tease and squeeze them, plucking at her erect nipples whilst your own hand starts to snake its way under her clothing, trying to get better access to more of her delicious gravy.  As your hand traces its way across her taut stomach her hips start to hump slowly against your leg, rolling back and forth as she tries to brush her throbbing clit against your armoured limb, desperate to relieve her growing lust.");
			
			outputText("\n\nFeeling a little sorry for the horny girl, you slide your thumb briefly over her needy button, her back arching as she cries out at the sudden rush of pleasure.  Her breasts strain against the thin poncho as she quivers in excitement, her oversized bust seemingly threatening to burst right out of her modest clothing.  Smirking to yourself, you withdraw your knee from between her legs.  Her hands almost unconsciously start to make the move to her now-neglected netherlips, a low cry of displeasure rumbling out of her mouth, a harsh contrast to her previous, high pitched moan.  However, before her hands can even leave her chest you dart your own in, splaying your fingers across her moist slit.  She bites her lip as your hand slowly starts to circle her aching pussy, her fingers tweaking at her nipples as you spread her own femspunk around her entrance.");

			outputText("\n\nMaking sure to stay away from her erect clit, you continue to tease her entrance.  Her hips once again try to hump against you, but your other hand presses down on her stomach with enough force to hold her back.  Lifting her head to look at you, she whines in displeasure as you keep denying her, her breasts still leaking as she plays with herself.  Your eyes lock with hers and you see the need burning behind them.  Without looking away, you slide two fingers into her warm, wet hole.");
			
			outputText("\n\nShe cries out at the penetration and you feel her tunnel grip your fingers as they try to go deeper inside her.  She stiffens up, moaning and groaning as an orgasm wracks her body, her thighs quaking with pleasure and hands going and breasts bouncing as she gasps in air.  You rest your thumb on her clit as she cums, rapidly rolling over the nub and her hips thrust into your hand, desperate to feel your fingers touch as much of her as they can.  Her nipples jut out through the poncho as she contorts herself, her fingers clamping down on them harshly as the pleasure overwhelms her, causing what could only be called an eruption from each nub.  Gravy spurts out, splattering against her already sodden clothing as you feel the tasty liquid streaking down her body beneath the material.  The warmth spreads across your hand, though it is no match for the heat between your legs as you watch the girl writhing in pleasure.");
			
			outputText("\n\nUnable to stop yourself, you wrench your hand out from beneath her garment and before the girl can tell what's happening, you start to pull it up over her head, finally unleashing those fantastic breasts to the fresh air.  She nearly squawks as you drag her up from her relaxed position to free the material trapped beneath her, but calms down once you manage to get the thing over her head, throwing the soaked cloth out of the way.");
			
			player.orgasm();
			doNext(femaleAndTurkeyMainCourse);
		}


		//Main Course:
		public function femaleAndTurkeyMainCourse():void {
			clearOutput();
			outputText("Fully disrobed, the girl runs her hands down her chest, fingers clamping around her dribbling nipples once again.  With another squeeze, gravy is rolling down her chest once more, slathering her fingers with her own mouthwatering juices.  Unable to hold yourself back, your mouth clamps onto her breast, hands shooting to her soft, plush rear as you pull her bodily into your lap.  Her eyes almost light up in her new position, her hands running through your [hair] as you suck for all you're worth.  Her thick, rich gravy fills your mouth with its delicious mix of flavours.  There's so many different, wonderful tastes mixing together that you could almost believe you were back in Ingnam, gorging yourself on the gigantic spread that the village always strives to put on, regardless of how well the harvest went.");
			
			outputText("\n\nYour tongue plays with her nipple as you drink, flicking it to make the girl moan softly whilst your other hand plays with her unattended breast.  Despite her recent orgasm, she still tries to press her dripping pussy against your stomach as you drain her, her head thrown back in bliss as you nibble gently on the hard nub in your mouth.  Feeling your own [vagina] awash with pleasure too, you are, for a moment, torn between continuing to suckle the girl and pulling your lips away to beg her for some attention.  Luckily, as if she can read your mind, one of the turkeygirl's hands extracts itself from your hair and starts to makes its way down your body, cupping your [chest] as she goes.  You moan into her tit as her fingers slip under your waistband, brushing their way tantalizingly across your entrance as she brings her head to rest on your shoulder.");
			
			outputText("\n\nGravy dribbles down your chin as her fingers seek out your slit, teasing you in much the same way you had done to her, something you suddenly find yourself regretting.  Her lithe digits prod at your needy hole, nearly making you thrust against her hand in an attempt to get some contact.  However, the weight of her on you prevents you from making a move, forcing you to withstand her teasing touches as you continue to gorge yourself.  The steady stream of delicious goo starts to wane slightly, the turkeygirl's massive mammaries apparently struggling to keep up with your copious consumption.  Your fingers tweak her other nipple absentmindedly, forcing another burst of gravy out of her.  Deciding that it just isn't fair to leave her other tit so very unattended, you move your mouth to the hard, leaking nub, gulping and sucking hard as the liquid fills your mouth once more.");
			
			outputText("\n\nYour stomach begins to swell slightly as her gravy keeps filling you up, giving her body better purchase and making it much easier for her to rub her crotch against you.  The girl begins to moan again at the double sensation of her still-trembling lips rubbing against you and your slight less lewd lips locked firmly onto her sensitive nipple.  Her teasing becomes slightly more insistent as she grinds her slit into you, fingers sliding between your lips with an ever-increasing pace.");
			
			outputText("\n\nHowever, she continues to deny your aching clit, darting around your opening and occasionally dragging a fingertip across your swollen entrance.  Her crotch keeps thrusting into you, each stroke a little harder than the last.  Her arousal clearly has an effect on her breasts, streams of fluid drip from your soaked chin and splatter across her mound as you struggle to contain her delicious lactate, the girl groaning wantonly as warm juice drizzles over her sensitive clit.  Her moans get faster and higher with each thrust against you, her fingers becoming more adventurous, spreading and squeezing your labia, but never dipping into you.");
			
			outputText("\n\nOne of her fingers gently grazes your clit and you almost climax on the spot, your mouth nearly breaking its seal on her nipple.  Gravy spills out of the corners of your mouth as you cry out into her chest, shaking slightly as you struggle to contain yourself.  The girl grunts as you pull her hard against you, her pussy pressing into your stomach hard enough for her clitoris to brush over your armor.  Her grunt explodes into a moan as her body tightens up again, hips thrusting wildly against you as she orgasms a second time, coating your stomach with thick femspunk as her quivering quim drenches you.");
			
			outputText("\n\nThe hand still entwined in your hair pushes your face into her soft, smooth boob, the point of her nipple nearly touching the back of your throat as your maw is filled with titflesh.  Your tongue flicks across her nub, making her still-cumming body shudder with the overload of pleasure.  The fingers between your twitch and form a fist as her body is wracked with sensation, her knuckles sliding against your lips as she struggles to maintain control, keeping away from your needy button but leaving you panting all the same.");
			
			outputText("\n\nYour hands pull her tightly against you, stopping her mad thrusts as her vagina continues to spasm against your taut belly, the contractions so powerful that you can feel them even through your [armor].  She cranes her head back and moans indecently into the air as her legs grip you, almost making you feel like you're about to burst with the pressure.");
			
			outputText("\n\nFinally though, her climax begins to die down.  She holds you close for a few moments, gulping down air after her body-shaking finish.  You continue to drain her breast, though you feel your [vagina] starting to leave a damp patch on the inside of your armour, dripping down your thighs to soak into the log beneath you.  The hand on your head begins to move its way out of your hair, trailing down your neck almost lovingly as her breathing starts to return to normal.  Her touch is almost electric against your skin and you suddenly find yourself very aware of how much your body has been reacting whilst your brain was fixated on her mind-numbingly good goo.");
			
			outputText("\n\nFinally, unable to withstand it any longer, you break your lips away from her teat and push the girl to the ground, your hunger for her body finally having overcome your hunger for her gravy.  She looks up at you with a confused expression to begin with, but once she sees your hands darting to the clasps of your armor, a much more sultry look crosses her features.");
			dynStats("lus", 30);
			doNext(haveTurkeyGirlDesertInYourCunt);
		}
			
		//DESERT
		public function haveTurkeyGirlDesertInYourCunt():void {
			clearOutput();
			outputText("Barely able to contain yourself, you nearly tear your [armor] from your burning body, desperate to feel the girl with your bare flesh.  She reclines lazily on the ground, legs spreading wide as a hand moves from her dribbling tits, sliding its way down her toned stomach to her swollen lips.  She continues to tease herself whilst you struggle with your clothes, little moans and grunts of pleasure leaving you weak at the knees as she dreamily circles her reddening snatch with a finger.  Her other hand busies itself with her chest, pinching and squeezing just hard enough to release another spurt of gravy that rolls its way down the curve of her breast, dripping onto her belly in a thick glob.");
			
			outputText("\n\nYou finally free yourself of your damned armor, throwing it haphazardly to the ground as your skin finally feels the cool air flow over it, though it does nothing to sate the burning feeling that still threatens to consume you.  The girl's eyes noticeably widen as she takes in your nude body, her reaction making you blush even though it barely affects on your flushed cheeks.  Deciding to put on a little show for your avian acquaintance you drag your hands up from your hips, moving them across your stomach so that they can cup your [chest], tweaking your nipples between the fingers as they slide past.  You moan as you grip the hard nubs, throwing your head back in an exaggerated fashion as your hands keep on going, slipping up your neck to run sensuously through your [hair].  Finally, you turn you eyes back down to the fuckable fowl, shooting her a smouldering look, biting your lip for added effect as a low groan rumbles in your throat.");
			
			outputText("\n\nHer face is as red as yours, hands motionless as she takes in your display.  You can't help but smile at her response, the fact that she's so into your little show having a considerable effect on your own body.  Shifting your hips, you swagger over to her, letting your hands slip down to your nipples once more as you approach.  Your thighs are soaked with your own juices and each step you take brushes them against each other just hard enough to send a shiver of excitement up your back.  You reach the girl and crouch down in between her spread thighs, making sure to stretch your own legs as far apart as possible, eager to display your quivering slit to her as lewdly as you can manage.");
			
			outputText("\n\nShe's panting at you display, her pussy dripping with moisture as you advance on the girl, swinging your legs over her head and spreading her thighs as wide as you can as you come down above her.  She gets the message pretty quickly, her stiff little tongue shooting out to slip across your snatch, a grunt bursting from your mouth just before you can dig into the girl's own moist little hole.");
			
			outputText("\n\nYou recover, though her frantic assault keeps your body wracked with pleasure as you zero in on her pussy.  Your hands keep pushing her thighs apart as they move closer to her snatch, thumbs gently pulling the flushed lips apart to give you a perfect view of her passage.  She moans into you as a breeze blows against her entrance, humping at the air as she whines for you to dig in.");
			
			outputText("\n\nWell, with an offer like that, who could refuse?  Your head dips, tongue digging into her flesh as you give her one obscenely long lick, taking in as much of her taste as possible in one stroke.  Instead of the expected taste of sweat and cum, you find yourself licking your lips as the sweet taste of fresh pumpkin pie assails you.  A few hours ago, this would probably have given you pause, but after gorging yourself on her gravy you simply find yourself digging back into her slit, eager to sample as much of her as you can.");
			
			outputText("\n\nShe moans under your rapid strokes, though her own tongue hardly relents on you entrance, short jabs finally penetrating you as her fingers try to spread your lips as widely as they can, exposing as much of your [vagina] as possible.  You respond in kind, hands sliding under her thighs to come below her drooling slit, spreading wide whilst your pinky fingers tease her tight ring.  She groans in ecstasy as you dig in, her delightful flavor the perfect complement to the savory soup that even now leaks from her, coating your lower stomach as it rests on her bosom.");
			
			outputText("\n\nHer fingers snake their way around your hips until you can feel them resting just above your clit, poised to strike at any moment.  You realize that even one tap could probably finish you off now and begin to slurp at the turkeygirl's own nub, tongue lapping up as much of her sweet juice as it can manage.  You <b>need</b> to get as much of it as possible before she makes you cum, your mouth clamping down on her vagina, getting right to the source and trying to suck it straight out of her as you swirl your tongue around her button in hopes of making her leak even more.");
			
			outputText("\n\nHowever, the girl must be close and she decides to try and finish you off at the same time.  Her fingers suddenly grasp your clit, pinching it softly whilst her tongue dives deeper than ever before.  You cum almost instantly, you passage quivering around her orgasmic organ, humping against her face as you scream into her mound.  As the sound washes over her entrance, she too starts to cry out, both her holes spasming and you take the opportunity to slip a couple of fingers into her tight rear.");
			
			outputText("\n\nThe intrusion completely pushes her over the edge, leaving the pair of you screaming and humping unashamedly into one another, two tangled, sweat-slicked bodies writhing on the ground and groaning blissfully.  Her pussy covers your face with femspunk, which you waste no time in trying to lick up as you feel your own snatch [if (isSquirter = true) \"drench her face, a muffled 'meep' sounding out from between your legs as the girl weathers a vertiable flood from your twitching tunnel\"][if (isSquirter = false) tremble and coat her tongue with fluid, which she quickly drinks down before returning to your soaked hole].");
			
			outputText("\n\nAs your orgasm starts to fade, you manage to roll your exhausted body off the turkeygirl, your chest heaving as you try to catch your breath.  You lie there for a few moments, your stretched stomach a testament to how delicious the girl was.  Out of the corner of your eye you notice her shifting and, to your surprise, she lifts herself up from the sodden ground beneath her.  Her body is dripping with remnants of your encounter, but she seems to be no worse the wear after no less than three orgasms!");
			
			outputText("\n\nShe looks down at you, her big eyes sparkling as your own start to close, the exertion of such a vigorous round of sex too much for your stuffed body to take.  Kneeling down beside you, her mouth locks onto yours, kissing you deeply as you push back with your mouth, though even the effort of raising your head is almost too much for you.  One of her hands starts to gently stroke your bulging stomach, slowly circling the tight skin and kneading your sensitive flesh with soft, slow caresses.  Your eyes start to flutter and your head falls back to the ground, breaking the kiss.  Unperturbed, she coos softly at your dazed expression, her head nuzzling into the crook of your neck as her soft touch starts to calm your overworked body down.");
			
			outputText("\n\nHer mouth nips at your neck, tongue flicking your earlobe whilst she continues to moan quietly, your eyes glancing down her body to see her other hand buried firmly between her legs.  Your mouth curls into a smile as you relax completely, feeling safe and content under the caresses of the turkeygirl.  Somehow you can guess that she won't be here when you wake up, but your body is far too relaxed to do anything about it.");
			
			outputText("\n\n<b>One hour later...</b>");
			
			outputText("\nYour eyes crack open, mind still foggy as sleep still clings to the corners of your eyes.  Memories of the insatiable turkeygirl flood back as you start to sit up, dreading the inevitable clean-up after so much spilled fluid.  However, you quickly realize that you're already redressed! In fact, it seems like someone not only dressed you, but both your body and your [armor] are completely spotless, not even a trace of the girl remaining on your person.  Looking around you notice that your campfire still burns brightly, as if someone stoked it recently.  Even your stomach has returned to its previous state, leaving no sign of the massive amount of gorgeous gravy you guzzled not an hour ago.");
			
			outputText("\n\nLurching to your feet, you stretch your arms, feeling completely refreshed after the short nap.  If it wasn't for the sweet taste of pumpkin still lingering on your lips, you'd be prepared to call what had just happened one of the weirdest dreams you've had since arriving in Mareth.");
			
			outputText("\n\nThen again, you have to admit that it would also class as one of the most fun...");
			if (player.findPerk(PerkLib.Cornucopia) < 0) {
				outputText("\n\n(<b>Gained Perk: Cornucopia - increases vaginal and anal capacities by 30.</b>)");
				player.createPerk(PerkLib.Cornucopia,0,0,0,0);
			}
			//HP set to full, fatigue to 0?
			player.changeFatigue(-100);
			HPChange(3000,false);
			doNext(camp.returnToCampUseTwoHours);
		}

		//Turkey Girl II: Return of the Cockgobbler (Cockwielders)
		//{Thanksgiving Day event, nat. Cockmeisters only.}
		public function turkeyGirlTwoTheTurkeningBySavinWhatADickInAButt():void {
			clearOutput();
			outputText("As you're wandering through camp, your mind wanders back to the old harvest festival your village would hold about this time of year.  The days have come slowly since your arrival in this corrupted demon realm, but you can't help but think back to your family, to the friends you left behind.  Right about now they're probably sitting around the table, saying a prayer to the gods in thanks for the bountiful harvest.  Maybe they're saying one for you.");
			outputText("\n\nYou start to scrounge together a meal together for yourself.  Not much you can do here, with what little you have, but it feels...  right...  to be making something special for today.");
			outputText("\n\nA pang of homesickness sweeps through you as you look at the small meal before you.   With a sigh, you pick up your fork and prepare to dig in.");
			outputText("\n\nAs you reach for some of your spices, you notice...  something...  poking its head into one of your satchels, rustling around.");
			outputText("\n\nYou jump to your feet, readying your [weapon] for battle as you scan the perimeter.   A moment later, and you see a ponderous figure step out of the shadows behind a large rock.   At first glance, it looks like a normal girl dressed in a simple moccasin poncho, her bright red hair falling past her shoulders to rest on a pair of absolutely massive breasts.   Timidly, she steps forward, giving you a good look at her less human attributes: a pair of avian legs stick out beneath the hem of her clothes, and a large plume of feathers stick up from her big bubble-butt, each red feather nearly reaching the back of her head.   And her breasts...  each is easily the size of a goblin, so massive that it seems she can barely wobble along.");
			outputText("\n\n“<i>G-gobble?</i>”  she asks quietly, her big blue eyes pleading at you.");
			awardAchievement("Gobble Gobble", kACHIEVEMENTS.HOLIDAY_THANKSGIVING_II, true, true, false);
			//[Shoo Off] [Let her Come] [Hello again!]
			menu();
			if (player.hasCock())
			{
				if (player.hasKeyItem("Deluxe Dildo") >= 0 || player.hasItem(consumables.L_DRAFT) || player.hasItem(consumables.F_DRAFT)) {
					outputText("\n\n<b>You could let her come, like last year, or greet her in a whole new way (by clicking 'Hello Again')</b>");
					addButton(2,"Hello Again",helloAgain);
					flags[kFLAGS.MORE_TURKEY] = 0;
				}
				else {
					outputText("\n\n<b>You might be able to have some new, kinky fun with Gobbles this year if you had something lusty on you...</b>.");
					flags[kFLAGS.MORE_TURKEY] = 1;
				}
			}
			addButton(0,"Shoo Off",shooTurkeyAway);
			addButton(1,"Let Her Come",letZeTurkeyApproach);
		}

		public function helloAgain():void {
			clearOutput();
			outputText("\"<i>Oh, hey, you,</i>\" you say as the seasonal little near-harpy waddles up.  You pat your thigh invitingly, letting Gobbles approach.");
			
			outputText("\n\nSeeing that you're not angry with her, she bounds over with a flutter of her seemingly useless wings, plopping into your lap with a happy cry of \"<i>Gobble!</i>\" You rustle her feathers playfully as the turkey-girl nestles in, pressing her massive bust tight to your chest.  Damn, those tits of hers are gargantuan, like they haven't been milked since you gave her a good spit-roasting last year.  You can practically hear the gravy sloshing around in them, just waiting to spill out and drench her again.  You lick your lips at the thought, your hands wandering up to the clasps of your [armor] to pull it free.");
			
			outputText("\n\n\"<i>Gobble?</i>\" Gobbles asks cheerily, big blue eyes staring intently at your crotch.");
			
			outputText("\n\n\"<i>Gobble,</i>\" you answer, pushing her head down toward your [cock].  She giggles giddily as you free your prick, already hard enough to bop her on the nose as she buries her face in your groin.  The turkey takes a deep breath, wallowing in the potent musk of your " + player.multiCockDescriptLight() + ", venturing to lick along the side of your shaft.  You let out a soft moan, stroking her auburn locks as the turkey happily suckles on your prick, taking the head ");
			if (player.cockArea(0) <= 60) outputText("and down to the base");
			else outputText("and swallowing your shaft until her throat is bulging with your massive manhood");
			outputText(".  She bobs up and down your length, hefting up her huge rack when she's at the peak to rub your sensitive underside, trying to titfuck you but just too damn big to get them into the action.  You suppose you'll have to take care of that...");
			menu();
			addButton(0,"Next",gravyBoatDatTurkturk);
			//Gravy boat?
		}

		//Gravy Boat
		public function gravyBoatDatTurkturk():void {
			clearOutput();
			outputText("You cup the turkey's chin, pulling her up off your cock enough to get her looking up at you with her big, questioning eyes.  \"<i>Gobble?</i>\" she ventures nervously, straining against your hand to get back at your shaft.");
			
			outputText("\n\n\"<i>Soon, little bird,</i>\" you tease, reaching back to pat her huge harpy booty, fingers digging into the turkey's supple backside before hefting her up into your lap again and turning her around, letting her back rest against your [chest], tits held over your meager harvest meal.");
			
			outputText("\n\n\"<i>Gobble!?</i>\" she yelps, but a gentle caress of one of her heavy-laden tits is all it takes to get her to relax, practically putty in your hands.  You cup her breasts, giving them just enough of a squeeze to get them dripping, thick dark cream welling up at her pink points, drooling down onto your fingertips.  The smell...  oh, that's nice.  You lean around her slender shoulder, licking up a stray rivulet of gravy, savoring the sweet taste and the hearty smell that so reminds you of home.  The turkey flutters her wings happily, practically quivering in anticipation as you start to milk her, squeezing her big nipples, pulling and pinching them until the gravy starts to flow.  She squeals, back arching as her thick lactation spills down her ample chest, rivulets running through your eager fingers and down your arms, too, pooling beneath the pair of you in a steamy lake of rich gravy.");
			
			outputText("\n\nYou let her enjoy it for a long minute, working her sensitive teats until she's constantly fidgeting and gasping, crying, \"<i>Gobble gobble!</i>\" as her feathers flutter happily.  She's enjoying this so much you'd think she was a little cow-girl, almost! Of course, she's not entirely content to just get milked: cock-gobbler that she is, you soon feel a feathered arm slipping down your bare [chest], tickling and teasing as she's reaching around to your [hips] and waist before finally diving down to your [cock].  It's your turn to moan and groan as she wraps her fingers around your turgid member, stroking you from base to crown with gentle, affectionate motions that soon see a well of pre pooling at your slit, staining her reddish feathers dark with eager seed.");
			
			outputText("\n\n\"<i>Gobble?</i>\" she asks again, silenced when you squeeze her tits harder, aiming them for your meager meal.  She squeals happily as you bathe your lunch in gravy, squirting a thick arc of her sweet cream into your cook pan, still so hot that her lactic load quickly sets to steaming.  \"<i>Gobble!</i>\" she giggles, taking a deep breath of the meal as her gravy gets nice and toasty warm in the embers of your fire.  She shifts her hips ever so slightly, letting her grip of your cock go in order to straddle your [legs], squeezing her thigh thighs around your manhood, letting her silky-soft feathers caress your most sensitive flesh, tickling your [cockHead] as she starts to work her hips, grinding against your cock as you keep her tits constantly flowing.  You can visibly see her huge breasts shrinking as you milk her, cream flowing out of your over-flowing pan and into the fire or the hungry ground to be swallowed up.");
			
			outputText("\n\nThe smell is almost overwhelming, so potent and familiar that you can't help but feel homesick and hungry.  But her cock-rubbing legs keep you from getting too down; she's going at it with wild abandon, happily humping against your cock's length.  Her cunt is drooling fem-slime almost as much as her tits now, slathering your [cock] in her warm slickness, her nether lips reaching out to gently caress your prick, almost inviting you to penetrate her.  You hold her still just a moment, long enough to shift your [hips] and slide right on in.  Gobbles' back arches, voice turning into a giddy cry of pleasure as your [cock] enters her, spearing her on your length as you hold her dripping tits over the hearth, cooking her gravy as you spitroast Gobbles once again.");
			
			outputText("\n\n\"<i>Gobble!</i>\" she declares triumphantly as your prick slides home, pushing into her until her hips are nestled back into your lap");
			if (player.cocks[0].cockThickness >= 5) outputText(", her stomach bulging obscenely with your inhuman girth");
			outputText(".");
			
			outputText("\n\n\"<i>Gobble indeed,</i>\" you laugh, planting your arms back on the dry ground, letting the turkey adjust herself.  Her tits are practically empty by now; not quite, but enough that her once immense rack is down to something you can quantify - maybe G-cups.  A pair of perfectly round, bouncy G-cups that are still dripping with spattered gravy, her big red nips erect and still leaking even without your hands to spur them on.  The turkey shifts around on your pole to face you, leaning back in your lap against your [legs], content for the moment to grind her cunt on the [cock] buried deep inside her.");
			
			outputText("\n\nSlowly, she starts to move, rising up along the girthy length of your [cock] until just the tip is buried inside her before sliding back down, giving a little squawk of \"<i>Gobble!</i>\" when you bottom out in her.  You lie back, letting the turkey bounce on your prick, and close your eyes, reveling in the warm coating of gravy smeared across your body, the contentment of having your cock nice and buried in the slutty turkey.");
			
			outputText("\n\n\"<i>Gobble?</i>\" the turkey asks mid-bounce, staring down at you expectantly.");
			
			outputText("\n\nYou open an eye, looking incredulously at the little bird.  When you don't respond, she gives a harrumph of a squawk and dismounts you, turning around to plant her big, round booty in your face and stuffing her face back in your crotch.  You groan as her still delightfully big tits wrap around your [cock], finally sized down enough to where she can work with them; you grit your teeth and try to hold back as she strokes you off between her wet, soft tits, faster and faster with her own gravy as lubrication.  She gleefully takes the head into her mouth as she goes, swirling her slender tongue around your crown before lapping up the trickling pre leaking from your slip.  The sensation of her dexterous muscle caressing your cock, combined with the ceaseless stroking of her tits enveloping your dick, is just too much: you can't hold it in any longer.");
			
			outputText("\n\nYou grab the turkey's head and slam her down on your [cock], pushing it all past her lips as you shoot your load down her throat.  She squeals and flutters atop you, but your strength and the weight of her tits still mounted atop your cock keep her nice and immobile as you throat-fuck her, [hips] pounding your prick deep down her gullet to send your cum right into her belly.");
			
			outputText("\n\n\"<i>Gobble!</i>\" Gobbles cries, and you're not sure if she's happy or upset anymore: the sheer amount and cum and cock in her mouth muffles her word into a mere pleasured cry.  It takes her a solid minute to finally regain her senses enough to pull your shaft out of her mouth, cum drooling out of her lips as she lets your prick droop down.  \"<i>Gobble!</i>\" she repeats, this time wiggling her hips in your face, pushing her drooling, cock-stretched cunt right onto your nose to give you a nice, big whiff of her entrancing pussy-smell.  You're almost hard again by the time you manage to dislodge her, but she holds fast just off of your face, the lips of her muff practically kissing your own.");
			
			outputText("\n\n\"<i>Gobble!</i>\"");
			
			outputText("\n\nLooks like she wants you to return the favor!");
			player.orgasm();
			dynStats("lib", 1);
			menu();
			addButton(0,"Next",seasonHerDatTurkeyBitch);
		}

		//Season Her
		public function seasonHerDatTurkeyBitch():void {
			clearOutput();
			outputText("You plant your hands on the busty bird's broad, breeder's hips, spreading her cheeks to get a good look at her slit.  Still agape after taking your cock earlier, she's liberally leaking fem-slime onto your face, eagerly awaiting your lusty touch.  You venture your tongue out to taste her, and instantly draw back even as she flutters excitedly - does she...  of course she tastes like turkey.  What else? But it's a damn fine turkey, oh so sweet and juicy; you don't hesitate to dig in, tongue probing deep into the giddy fowel's slit.  She wiggles her tremendous tush happily as you spread her nethers wide, her vibrant brown plumage standing straight up, as erect as your own [cock] as Gobbles' tits bounce and jiggle around it.  Tonguing your tasty turkey, you slip a few fingers up between her luscious thighs, brushing the tender flesh just enough to make her arch her back, dragging her tits right along the length of your shaft to bury the crown in the jiggly bottom of her rack.  You trace your fingers higher, brushing the silky lips of her sodden box and circling up to the prominent little bud of her clit.");
			
			outputText("\n\n\"<i>GOBBLE!</i>\" she cries as your digits brush her sensitive point, arching her back and squirting gravy onto your crotch, lactating from pleasure alone.  You shudder as the warm, creamy gravy slathers onto your " + player.multiCockDescriptLight() + " pinned between her tits, her pleasured motions getting her boobs bouncing like a regular titfucking.  At your touch, her quivering quim lets loose a torrent of excited fem-slime, smearing your face in turkey-tasting juices faster than your hard-working tongue can lap it up.  She's a fine tasting turkey if ever you saw one, her sweet juices practically compelling you to eat her out, pushing your tongue as deep into her juicy slit as you can to harvest her delicious bounty.");
			
			outputText("\n\nBut what's a turkey without a little seasoning, hmm? Sweet as she is, and as eager to gobble your cock as can be, things could still turn up a notch.  Still servicing her box, you reach an arm out to your discarded pack, searching through it until you feel the familiar shape of ");
			if (player.hasKeyItem("Deluxe Dildo") >= 0) outputText("Tamani's dildo");
			else if (player.hasItem(consumables.L_DRAFT)) outputText("a bottle of Lust draft");
			else if (player.hasItem(consumables.F_DRAFT)) outputText("a bottle of Fuck draft");
			else outputText("A FUCKIN ERROR");
			outputText(".  You pull it out and squeeze a copious load of the bubblegum pink aphrodisiac out into your hand.  The second it touches your skin, you feel a palpable warmth spreading out through your nerves, skin burning with sensitivity as the roiling, viscous substance pools in your cupped hand.  You can't help but shudder as the pink veno's effect reaches out through your body, setting your whole person to tingling - and especially your " + player.multiCockDescriptLight() + ", which rises to an almost painful hardness.");
			
			outputText("\n\n\"<i>Gobble!</i>\" Gobbles giddily cries, sucking up the head of your turgid [cock] when its crown peeks out from between her teats, clearly pleased with your oral attentions.  She's got no idea what's coming! You slip one hand out of her cunny, and push another in, fingers sliding easily into her sodden hole.  \"<i>G-gobble!?</i>\" she whines as your lust-coated digits probe her, swirling around her quivering walls, making sure to spread the pink venom it out nice and even, coating every inch of her channel.");
			
			outputText("\n\nInstantly, you can see her pale flesh reddening, burning with desire.  Her fem-slime practically pours out of her over-excited pussy as her breath quickens, chest heaving her tits up and around your " + player.multiCockDescriptLight() + ".  Perfect! You pull your hand back out of her love-tunnel, slapping both her butt cheeks to wipe off the last of the lusty cream on her bare derriere, which flushes as red as her hair.  \"<i>Gobble!</i>\" she screams as you swat her ass, slamming her big hips down on your face, trying to get you to eat her needy box again even as she's panting and twitching, playing with her tits and your cock with shameless abandon.");
			
			outputText("\n\n\"<i>Gobbles, gobble,</i>\" you command, poking a finger into her drooling slit.");
			
			outputText("\n\n\"<i>Gobble!</i>\" she answers, rolling off of you and hiking her legs up, knees sinking into her bust to show off her slit for you, so eager and inviting.  You rise to your [feet], grabbing the lusty fowl behind her hooked knees and pulling her in to line up with your " + player.multiCockDescriptLight() + ".  \"<i>G-gobble!</i>\" she begs, fluttering her plumage against your [legs], staring up at you imploringly as her skin further reddens, so hot with desperate lust you can practically feel the sexual hunger radiating off of her.  Time to finish this turkey off in style!");
			dynStats("lus=", player.maxLust(), "resisted", false);
			menu();
			addButton(0,"Next",turkeyDesertBitches);
		}

		//Dessert
		public function turkeyDesertBitches():void {
			clearOutput();
			outputText("\"<i>G-gobble!?</i>\" Gobbles whines at your moment of hesitation, wiggling her upraised botty at you enticingly, hot flesh jiggling just close enough to brush your " + player.multiCockDescriptLight() + " with her lust-coated cheeks.");
			
			outputText("\n\n\"<i>Fuck!</i>\" you groan as the venom drips off your [cock], a small droplet vanishing into your dilated urethra.  Your heart skips a beat as the lusty cream works its magic, pounding through your sex.  Well, that backfired! You clutch at your [chest]");
			if (player.biggestTitSize() > 1) outputText(", cupping a tit");
			outputText(" as the venom takes control, flushing your skin and forcing out all thoughts but one: fuck that turkey! There's nothing for it, now: you grab Gobbles' hips and plunge in");
			if (player.cockTotal() == 2) outputText(" with both cocks, one ramming into her abused cunny and the other right up her vulnerable little bumhole");
			else if (player.cockTotal() > 2) outputText(" with every cock you've got, half in the pink and half in the stink, spreading her as wide as you are in both barrels");
			outputText(", shocking her so much that she can't hold back, screaming and cumming on the spot! You groan, thrusting forward as her spasming muscles contract around your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(", milking you as hard as she can while her orgasm overtakes her.  Gravy geysers out of her swollen tits as fem-cum splashes out around your deep-buried cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(", drenching your [hips] and [legs] in creamy girl-spunk, tinged pink by the poison you fist-fucked up her cunt.");
			
			outputText("\n\nThe squawking turkey seems to be depthless, easily swallowing up every inch of your " + player.multiCockDescriptLight() + " until ");
			if (player.cockArea(0) >= 50) 
			{
				outputText("her stomach is bulging obscenely with the sheer volume of cockflesh rammed up her cunt");
				if (player.cockTotal() > 1) outputText("and ass");
			}
			else outputText("your hips are slapping into hers, making her butt bounce with the impact");
			outputText(".  She cries her one word to the heavens as you pound into her hole");
			if (player.cockTotal() > 1) outputText("s");
			outputText(", thrusting your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" deep inside.  Her avian legs break free of her hold, wrapping around your [hips] and pulling you in, locking you in her spasming hole");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" as she cums and cums, pleading, \"<i>Gobble!</i>\" at the top of her lungs.  You switch your grip to her bountiful bosom, roughly squeezing her tits as you hump your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" in and out of her slick slit{and quivering behind}, pinching her nipples to give the squealing turkey just a little more pleasure.");
			
			outputText("\n\nGobbles' feathered arms reach up, hooking around your neck and bringing you down, pulling you into a startlingly passionate kiss.  You lose yourself in her warm embrace, hips pistoning on automatic as you caress and kiss the lusty bird, tongue playing across her full red lips as you cup a breast just hard enough to make it lactate, so that your fingers are coated in thick gravy.  You bring them up to her cheek, smearing a bit over her lower lip before she eagerly swallows it up, suckling her own lactic lust from your digit like a little teat; you join in, half-kissing her and half licking up the gravy from your fingers, tongue tying with hers more than once, playing across each other.  Your sexy moans turn to gasps and cries as you continue to pound her puss");
			if (player.cockTotal() > 1) outputText(" and ass");
			outputText(", her legs spurring you on every time you withdraw, muscles clenching when you pause, never letting you rest.  Needy slut! But she's more than willing to do her part, thrusting her hips up to meet you, squeezing and milking your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" every time you pierce her, working your shaft");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" so expertly that you know you won't be able to hold on for long - and neither will she, the way she's panting and gasping along with you!");
			
			outputText("\n\nYou draw nearer to the breaking point, hips unrelentingly slamming your shaft");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" deep into Gobbles' eager depths, urged on by her happy squawks and gleeful cries.  Lust-venom-addled as the two of you are, orgasm approaches like a wave of relief, crashing through your bodies in beautiful unison.  \"<i>Gobbles!</i>\" she cries as her cunt ");
			if (player.cockTotal() > 1) outputText("and ass ");
			outputText("squirm around your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(", wringing the cum from you with powerful spastic contraction.  Her arms pull you down into the valley of her gravy-laden bosom, squeezing your face between her massive mounds as she cums, drawing the spunk right out of you.  With a potent, feral roar, you cum, " + player.multiCockDescriptLight() + " blasting its salty load deep into Gobbles' womb");
			if (player.cockTotal() > 1) outputText(" and bowels");
			outputText("; her back arches, teats wobbling around your head as she takes your cum, squawking and gobbling gaily as more and more of your virile spunk pours into her, mixing with her own fem-cum and the remnants of the lusty draft your fucked into her.");
			
			outputText("\n\n\"<i>Gobble!</i>\" she sighs happily as your cock");
			if (player.cockTotal() > 1) outputText("s deposit the last of their");
			else outputText(" deposits the last of its");
			outputText(" cream into her, fully stuffing your turkey-girl.  Panting, you let your head rest between her tits a moment long, shaft");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" wilting inside her until like a broken dam, her cunt");
			if (player.cockTotal() > 1) outputText(" and ass");
			outputText(" begin");
			if (player.cockTotal() == 1) outputText("s");
			outputText(" to drool spunk, pooling onto the hungry ground with the gallons of spilt gravy and fem-spooge.");
			
			outputText("\n\n\"<i>Gobble,</i>\" you agree, wrapping the giddy turkey up in your arms and planting one last kiss on her big ol' boob.  She stares sedately at you with big, blue eyes, a cute little smile on her lips as you withdraw from her, wiping the last of your spunk on her feathery thigh.  Running your hand through the turkey-girl’s hair, you whisper what a good little cockgobbler she is.  However, you soon find that the poor thing’s passed out, your rut finally over with.  Still, she's left you with a nice soft tit-pillow to lay your head down upon as you pick up the lunch you’d been preparing to eat before the eager slut arrived.");
			
			outputText("\n\n“<i>That’ll do, turkey,</i>” you say, patting her jiggling tit and scraping some of the excess gravy out of your lunch.  “<i>That’ll do.</i>”");
			player.orgasm();
			doNext(camp.returnToCampUseTwoHours);
		}

		//Ham Roast: Getting All Up In A Honey Pot (Female and Genderless only)
		//{Yeah what Savin said up there}
		//Desc: Hamroast will be the thanksgiving special at The Wet Bitch. PC will be prompted when they enter to try one. PC can repeat this scene as many times as they want during the Thanksgiving window.

		public function pigSlutRoastingGreet():void {
			clearOutput();
			outputText("As you enter The Wet Bitch you’re accosted by an incredibly busty waitress. You can’t really discern what exactly she is as your eyes are solely focused on the massive melons jutting out from her chest and jiggling proudly with mile deep cleavage to boot.");
			outputText("\n\n\"<i>Hey there " + player.mf("handsome","cutie") + "! We've got quite a unique special going on right now!</i>\" she exclaims in a cheery voice.");
			
			outputText("\n\nThen she motions to a sparkly gem-filled bucket, with several strands of what looks like cum running in creamy rivulets down the side.");
			
			outputText("\n\nShe moves in closer to talk right into your ear with a seductive voice, \"<i>Just throw a gem in that bucket over there and <i>she's</i> all yours for the night!</i>\"");
			
			outputText("\n\nYou grin. You could really go for a wild night right about now and a cheap whore sounds like just the right thing to ease your... stress.");
			awardAchievement("Thankslutting", kACHIEVEMENTS.HOLIDAY_THANKSGIVING_I, true, true);
			//{Lust = lust + 10}
			dynStats("lus", 5);
			menu();
			if (player.gems >= 1) addButton(0,"Throw gem",getARoastPiggueOinkOinkOinkMotherfucker);
			addButton(1, "Nah", getGame().telAdre.barTelAdre);
			addButton(2, "Never", disablePigSlut);
		}
		//[ In For A Gem... ] [ Not My Style ]

		public function disablePigSlut():void {
			clearOutput();
			outputText("Pig sluts are not really your thing. You tell her that you have no interest in her. She seems to be a bit heartbroken.");
			flags[kFLAGS.PIG_SLUT_DISABLED] = 1;
			doNext(getGame().telAdre.barTelAdre);
		}

		//{Return to The Wet Bitch menu}
		//Ham Roast -> In For A Gem
		public function getARoastPiggueOinkOinkOinkMotherfucker():void {
			clearOutput();
			player.gems -= 1;
			outputText("You quickly approach the gooey bucket and toss a single, shiny gem inside. Another waitress winks at you, almost equally as busty, nodding her head in the direction of the back rooms.");
			
			outputText("\n\nYou wander around for a bit in the hallway, doors on either side of you filled with mysterious grunts and groaning. Apparently, people are really getting filled with the holiday spirit, you muse, and getting FILLED with it as well!");
			
			outputText("\n\nEventually you come upon a door at the end of the hallway, noticing a sticky sheet of parchment nailed to it.");
			
			outputText("\n\nIt reads: \"<i>Get your sausage sticky! Or dip some pork tongue into your honey pot!</i>\" in playful calligraphy handwriting, an arrow closer to the bottom of the sheet pointing to the door knob. You notice in amusement how the knob seems a bit sticky too. Just about everything involving this... spit-roasted speciality is sticky.");
			
			outputText("\n\nYou open the door, the smell of sex wafting out in dizzying amounts: hungry pussy, eager asshole, meaty shafts, and hairy balls all mixing together to create a truly arousing aroma. The room is foggy with lusty fumes, working themselves into your [armor] and finding a home in your [hair].");
			
			outputText("\n\n");
			if (player.hasVagina()) outputText("\n\nYour [vagina] drools pussy juice down your [legs] as y");
			else outputText("Y");
			outputText("our nostrils flare, taking in great amounts of the salacious stench.");
			
			outputText("\n\nThen you see her, a jiggly piggy slut furiously frigging her juicy honey pot as syrupy, golden brown juices fly out, not stopping for even a second. Her pink, soft form jiggling and wobbling with just the right amount of fat. There's a paunch in her stomach that wiggles around, possibly a cream-filled belly from all the fun she's been having today. She's lying on her massive posterior, easily one of the biggest you've ever seen, hips flared out like a tried-and-true brood mother. An enormous pair of jugs adorns her plump body, bouncing and leaking what looks like honey as she enters the peak of her excitement.");

			outputText("\n\nOinking cutely, her curled tail waves around and quivers vigorously, like a happy dog getting a treat. You look up to her slightly pig-like snout, an adorable nose poking out from her muzzle, her eyes closed while her mouth is gaping open. Strands of thick masculinity are plastered all over her body, her ass-length curly brown hair tangled and stained with male-milk.");
			
			outputText("\n\nFemspunk dribbles down from her open maw, making her neck rather sticky as the same fluid runs from her own squishing sex. Fingers moving like a blur, she finally creams herself, gushing another wave of honey out of her hot, roasted sex. She breathes deeply, like she had just finished a vigorous exercise. She pulls her fingers out, frosted with syrupy goodness from her still drizzling, juicy cunt.");
			
			outputText("\n\nThe piggy slut brings them to her mouth, tasting her own pussy juice as she licks each one absentmindedly.");
			
			outputText("\n\nShe finally opens her eyes and lets out a surprised, \"<i>Oink!</i>\" when she sees you observing her with an amused glint in her eyes.");
			
			outputText("\n\nThen the plump whore's eyes suddenly turn more seductive, giving you a come-hither look as she oinks rather sexily, something that you didn't think would be possible until now.");
			
			//[ Next ]
			menu();
			addButton(0,"Next",morePigRoast);
		}

		public function morePigRoast():void {
			clearOutput();
			outputText("You climb on top of the bed with her, letting your [armor] slip off in the process. She oinks playfully, letting you know that she approves of the action. You smile at her, your hand reaching down to explore her dribbling nethers, slipping a finger into her love-tunnel with ease. You let a dumb grin spread across your features as you feel her searing folds, so hot and slippery with sticky, liquid lust.");
			
			outputText("\n\n\"<i>Oink?</i>\" she asks eagerly, ready for more.");
			addButton(0,"Next",tenderizeDatPigSloot);
		}

		//[ Tenderize Her ]
		//Ham Roast -> Tenderize Her (Female and Genderless versions)
		public function tenderizeDatPigSloot():void {
			clearOutput();
			outputText("\"<i>Turn over.</i>\" you say rather plainly, eager to see that jiggling booty of hers.");
			outputText("\n\nShe does as you command, rolling over onto her stomach and letting you see the massive mounds of fleshy orbs she calls her ass. You maneuver your way onto her legs, pinning them down with yours as you lick your lips in anticipation. You bring your hand down in a tentative spank, your hand smacking against one of the enormous butt cheeks, sending it jiggling and wobbling as it ripples away from the point of impact.");
			outputText("\n\n\"<i>Oink!?</i>\" the pork roast exclaims in surprise, her muscles stiffening. You answer her with a slap on the other cheek, harder and more confidently as this one repeats the action of her sister.");
			
			outputText("\n\nThe afflicted areas on her generous rump turn rosy red, which is hard to notice on her otherwise pink skin. You grin; apparently nobody had the decency to give this sausage slut a good rump-roasting. You bring both of your open palms down at the same time, both giant tushy cheeks undulating sexily as you leave fingerprint marks on her juicy booty. You experimentally put pressure on one of her fat orbs of flushing-red posterior, smiling in delight as your fingers practically sink into the round flesh.");
			
			outputText("\n\n\"<i>Oink...</i>\" she moans, lustily as you manhandle her backside. The dirty little slut! She likes it! Well, you're not one to deprive a sexy strumpet of her pleasure.");
			
			outputText("\n\nYou begin to rapid-fire spank her ass, alternating your strikes between her two cheeks. ");
			if (player.tailType > TAIL_TYPE_NONE) outputText("You even bring your tail from behind your back to join in, the unfamiliar texture causing the sausage slut to let out surprised, high-pitched squeaks. ");
			outputText("You notice the pigslut moving backwards, her ass being pushed into the air as she attempts to feel the full power of your spanking, her pussy spraying juices onto the soaked sheets.");
			
			outputText("\n\nYour hands are a blur as they play some unknown rhythm on her bouncing booty, as if they were acting on their own. The piggy slut has her hands clenching down on a nearby pillow, teeth gritted as you have your way with her colossal ass. Tears streak down onto the pillow, staining the fabric wet. The sight of her weeping sex is all you need to know to continue; the desperately oinking whore turns out to be a bit of a masochist...");
			
			outputText("\n\nYou look around the room for a more fitting tool to use on this pain-loving slut, even as you turn the whore's jiggling butt cheeks into a pair of booty bongos.");
			dynStats("lus", 25, "resisted", false);
			//[ Hardcore ] [ Softcore ]
			menu();
			addButton(0,"Softcore",hamRoastTenderizeHerSoftcore);
			addButton(1,"Hardcore",tenderizeHerHardcore);
		}

		//Ham Roast -> Tenderize Her -> Hardcore
		public function tenderizeHerHardcore():void {
			clearOutput();
			outputText("You can't help but maliciously smirk, your eyes resting on a fetish whip and some bondage equipment. You give the piggy one last double-handed spank on her ample ass, leaving her a pitifully moaning and quivering wreck. You quickly snatch up the whip, some rope, and a kinky ballgag.");
			outputText("\n\nYou return to the trembling whore, petting her curly brown hair reassuringly as the tears from her eyes slow down, the heat and pain from her raw rump still fresh. You gingerly place the ballgag onto her snout, making her appear as though she was a ham roast with an apple in her mouth. She looks into your eyes with a mixture of pain, arousal, mercy, and pleading. You softly kiss her on the forehead, stroking her hair, admiring its luscious fullness.");
			
			outputText("\n\nYou grab one of her weakened arms, stretching it out to the respective corner of the bed and restraining it with the rope. You do the same for each of her other limbs, her legs being a bit hard to maneuver due to her massive hips and thighs. Eventually you manage to get her all done up, smiling at your handiwork as you brandish the whip.");
			outputText("\n\n\"<i>Oink...</i>\" she moans weakly, her hips bucking uncontrollably in her secure bondage.");
			
			outputText("\n\nYou crack your whip on a nearby surface, creating an ominously loud striking sound. The piggy slut squeals in surprise, struggling in her bonds more when she hears the telltale cracking of the whip. You cocksuredly strut over to the squeaking whore, expertly striking down the whip on her wobbling boty. A bright red, painful looking mark shows itself on her ass where the whip made contact, the slut tensing as all of her muscles lock up.");
			
			outputText("\n\nSuddenly she lets out a high pitched whine, tears pouring from her eyes. Her drooling honey pot tells a different story though, a veritable river of feminine juices erupting from her sex. You crack the whip down on her again, the masochistic pork roast squealing for mercy as you relentlessly go to town on her booty.");
			
			outputText("\n\n\"<i>Oink! OINK! <b>OINK!</b></i>\" her pathetic squealing only excites you more, the sounds of loud strikes from your whip filling the room.");
			
			outputText("\n\nYou lose yourself in the excitement, your own [vagOrAss] twitching with delight each time your whip comes down on her bubbly buttocks.");
			dynStats("lus", 25, "resisted", false);
			//[ Next ]
			menu();
			addButton(0,"Next",spankEpilogueColonYoureAHorriblePersonForAbusingADumbPigGirl);
			//{Route to: here}
		}

		//Ham Roast -> Tenderize Her -> Softcore
		public function hamRoastTenderizeHerSoftcore():void {
			clearOutput();
			outputText("You can't help but let a salacious smile grace your lips, your eyes resting on a paddle in the corner. You give the piggy one last double-handed spank on her ample ass, leaving her a pitifully moaning and quivering wreck. You quickly snatch the somewhat heavy paddle, feeling its heft and grinning like a madman.");
			
			outputText("\n\nYou return to the trembling whore, petting her curly brown hair reassuringly as the tears from her eyes slow down, the heat and pain from her raw rump still fresh. She looks into your eyes with a mixture of pain, arousal, mercy, and pleading. You softly kiss her on the forehead, stroking her hair, admiring its luscious fullness.");
			
			outputText("\n\nYou move back down to your original position, pinning her down by her legs as you brandish the paddle. You quickly smack it down onto her flushing cheeks, sending them jiggling vigorously from the use of the new equipment.");
			
			outputText("\n\n\"<i>Oink!</i>\" she whines in surprise, her tempting rear receiving the full brunt of all the paddle has to offer as you quickly repeat the action with the other globe-like orb. She buries her snout in the pillow and bites down hard, whimpering and wailing as you go to town on her vulnerable booty, providing a gigantic target for your spanks.");
			
			outputText("\n\nYou can see her pussy practically gushing femspunk like a waterfall at each strike from her paddle. The ruined bed becoming even more sticky from the syrupy-like production of her honeypot.");
			
			outputText("\n\nShe oinks and squeals for mercy but you're not having any of it, simply ignoring her pleading and endlessly, rapidly paddling her heated bottom. All the direction you need is coming from her juicebox, which is commanding all of your attention as her slickened gash constantly leaks her cream.");
			
			outputText("\n\nThe pain-slut bucks her hips at each hard spank, moving her rear end back to meet your whacks on her wobbling, huge butt.");
			
			outputText("\n\n\"<i>Oink! OINK! <b>OINK!</b></i>\" her pathetic squealing only excites you more, the sounds of loud strikes from your paddle filling the room.");
			
			outputText("\n\nYou lose yourself in the excitement, your own [vagOrAss] twitching with delight each time your paddle comes down on her bubbly buttocks.");
			
			dynStats("lus", 25, "resisted", false);
			menu();
			addButton(0,"Next",spankEpilogueColonYoureAHorriblePersonForAbusingADumbPigGirl);
			//[ Next ]
		}

		public function spankEpilogueColonYoureAHorriblePersonForAbusingADumbPigGirl():void {
			clearOutput();
			outputText("Eventually you stop your ceaseless romping of her rear, the piggy whore blubbering into the now thoroughly torn pillow from her biting and tearing. Several strips of flesh from her reddened ass look practically raw from your activities. You lay an experimental finger on the tortured flesh, the blazing heat radiating from it telling you all you need to know.");
			
			outputText("\n\nYou grab a handy bottle of <i>Booty Balm</i> and squirt a generous amount on your palm and on each of her butt cheeks, working it in gently and easing a least some of the pain from her juicy rump.");
			
			outputText("\n\nAfter you're sure you've worked as much of the soothing cream into her ass as it will take, you gently pat it with an almost loving caress.");
			
			outputText("\n\n\"<i>Oink...</i>\" the slut sighs appreciatively, her tears finally coming to a stop as you get ready for the second part of your night together.");
			menu();
			addButton(0,"Next",spankEpilogueForRizzles);
			//[ Next ]
		}

		public function spankEpilogueForRizzles():void {
			clearOutput();
			outputText("You look around the room once again, searching for more toys you could use on the masochistic piggy slut. Your eyes rest on a jumbo-sized, horsecock dildo sticking up like a sore thumb out of the rest of the stuff. Someone even had the audacity to put a hat on it! You grab the monstrous thing, mottled black and pink all over with an artificial sheath near the base. You reason it's over two feet long and incredibly thick, its huge weight making it so that you have to carry it with both hands!");
			
			outputText("\n\nYou roughly flip the pigslut back over onto her back, eyeing her honey roasted pussy as it constantly dribbles more of the thick sex juice.");
			
			outputText("\n\nFirst things first, you gotta get this dildo in the other hole if you want to get all up in her syrup dispenser. You look around for lube, the only thing you spot being the <i>Booty Balm</i> from before. You shrug your shoulders; it will have to do. You apply a thick coating to the massive head of the flopping, artificial rod.");
			
			outputText("\n\nYou dominantly spread her legs apart and motion for her to hook her legs back, which she does without argument.");
			
			outputText("\n\n\"<i>Oink!</i>\" she happily exclaims, seeing the monster horsecock toy in your hands. Obviously she wants it, and by the looks of the magnitude of her whorishness, she's probably had plenty of experience in the anal department.");
			
			outputText("\n\nYou bring it down to poke into her pucker, teasing the pink entrance to her other hole with the flared head of the stallion-shaft. Her asshole gapes open a slight bit, making it clear to you that it's been fairly well used today. You ram it forward with all your strength, parting her meaty tushy with the ample girth of the huge beast.");
			
			outputText("\n\nIt easily sinks in a couple of inches into her ass. A lusty, sex-dripping \"<i>Oink...</i>\" escapes her mouth as you shove the dildo in deeper, effortlessly reaching the one foot mark. You chuckle to yourself; she's probably had a couple minotaurs in her booty today... especially judging by the squishing sounds you hear from her spunk-filled insides.");
			
			outputText("\n\nA visible bulge appears in her plump stomach, her stretched asshole touching the outside of the sheath. It takes a little more strain to get the sheath inside, but her butthole gulps it up greedily all the way until you get to the base of the monstrous horse-pole.");
			
			outputText("\n\nThe piggy slut's love-tunnel gushes another helping of femcum onto the sheets as she pats her belly where the flare is poking bulging out of it, satisfiedly oinking in pleasure as her asshole is filled.");
			
			outputText("\n\nWell, now that that's taking care of, you can move on to that delicious looking pig-pussy. While the whore is distracted with the new toy her butthole can play with, you dive into her depths, lapping experimentally at the golden flower with your tongue. A rich, candied, sugary glaze wipes itself on the length of your tongue, the explosion of flavor causing you to eagerly dive into the honey pot.");
			
			outputText("\n\nYour licking tongue easily parts the piggy slut's folds and dives deeper inside, tasting the syrupy sweetness from the source as the whore moans in pleasure, squealing like a pig in a mud pile.");
			
			outputText("\n\nThe taste reminds you so much of home; the candied sweet potatoes you use to have every year around this time. You need more, inserting your oral muscle as far is it can go into her soaking depths and thrashing it around inside, swirling it to lick up as much of the gooey syrup as you can. Lewd slurping sounds fill the air as the slutty pork roast's groans get more high-pitched, quickly approaching another climax.");
			
			outputText("\n\nYou tongue her pleasure buzzer, prodding it with your wet tongue and enveloping it with your slobbering oral muscle, sending the whore over the edge as she sprays the creamy syrup into your mouth. You guzzle it down eagerly; the pig slut's biggest orgasm yet gushing into your [face], causing your cheeks to puff out as you drink more and more of the delicious fluid, losing track of time.");
			
			//[ Next ]
			menu();
			addButton(0,"Next",getDoneEatingOutPigSlut);
		}

		public function getDoneEatingOutPigSlut():void {
			clearOutput();
			outputText("Finally you remove yourself from the still slightly dribbling juicebox, giving the whore one last spank as she seems to have passed out from the bliss. The bed is entirely a mess, covered with her sticky juices and torn from the spanking.");
			
			outputText("\n\nYou let out a satisfied burp from all the syrup you just ingested. Patting your own stomach, you make your way towards the door, leaving the piggy pussy drenched as the whore snoozes away, snorting cutely every once in a while.");
			
			outputText("\n\nWhoah, that was strange.");
			var changed:Boolean = false;
			if (player.thickness < 100) {
				outputText("  You notice that you seem a bit more... jiggly, a slight paunch in your stomach now as you grow a bit more plump than you once were.");
				if (player.thickness <= 10) player.thickness += 10;
				if (player.thickness <= 20) player.thickness += 10;
				if (player.thickness <= 30) player.thickness += 10;
				if (player.thickness <= 40) player.thickness += 10;
				if (player.thickness < 50) player.thickness += 5;
				changed = true;
			}
			if (player.buttRating < 35) {
				outputText("  You notice your ass filling out, gaining more mass as it visibly grows before your eyes."); 
				if (player.buttRating < 4) player.buttRating += 3;
				if (player.buttRating <= 10) player.buttRating += 2;
				if (player.buttRating <= 15) player.buttRating += 1;
				if (player.buttRating <= 20) player.buttRating += 1;
				if (player.buttRating <= 35) player.buttRating += 1;
				changed = true;
			}
			if (player.hipRating < 35) {
				outputText(" Your hips grow too, widening and giving you more sexy curves.");
				if (player.hipRating < 4) player.hipRating += 3;
				if (player.hipRating < 10) player.hipRating += 2;
				if (player.hipRating < 15) player.hipRating += 1;
				if (player.hipRating < 20) player.hipRating += 1;
				if (player.hipRating < 35) player.hipRating += 1;
				changed = true;
			}
			if (player.biggestTitSize() < 20) {
				outputText(" Your boobs also grow, gaining size as it seems that every part of your body wants to join in on the growth.");
				if (player.biggestTitSize() < 3) player.growTits(3, player.bRows(), false, 1);
				if (player.biggestTitSize() < 6) player.growTits(2, player.bRows(), false, 1);
				if (player.biggestTitSize() < 12) player.growTits(2, player.bRows(), false, 1);
				if (player.biggestTitSize() < 20) player.growTits(2, player.bRows(), false, 1);
				changed = true;
			}
			outputText("\n\nYou sigh");
			if (changed) outputText(", feeling your body expand as you waddle out back towards camp with belly full of sweet syrup");
			outputText(". For only one gem, that was a pretty good time...");
			doNext(camp.returnToCampUseTwoHours);
		}
	}
}