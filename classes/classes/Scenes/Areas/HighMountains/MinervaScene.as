package classes.Scenes.Areas.HighMountains {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;

	public class MinervaScene extends BaseContent implements TimeAwareInterface {

		public var pregnancy:PregnancyStore;
		
		public function MinervaScene() {
			pregnancy = new PregnancyStore(kFLAGS.MINERVA_PREGNANCY_TYPE, kFLAGS.MINERVA_PREGNANCY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 216, 144, 72);
			CoC.timeAwareClassAdd(this);
		}
		
//const MINERVA_LOVE:int = 813;
//const MINERVA_BACKSTORY:int = 814;
//const MINERVA_BACKSTORY_LEARNED:int = 815;
//const TIMES_MINERVA_SEXED:int = 816;
//const TIMES_BUTTFUCKED_MINERVA:int = 817;
//const TIMES_MINERVA_COWGIRLED:int = 818;
//const TIMES_MINERVA_LAPSEXED:int = 819;
//const MINERVA_LEZZES_OUT:int = 820;
//const MET_MINERVA:int = 821;

//-Tainted Minerva vaginal capacity: 90
//-Tainted Minerva anal capacity: 100
	public function minervaVCapacity():Number {
		return 90;
	}
	public function minervaACapacity():Number {
		return 100;
	}
	public function minervaSprite():void {
		if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) spriteSelect(120);
		else if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) spriteSelect(121);
		else spriteSelect(95);
	}

	public function minervaRomanced():Boolean {
		return (flags[kFLAGS.MINERVA_LOVE] == 1);
	}

	public var minervaPurification:MinervaPurification = new MinervaPurification;
	public var minervaCorruption:MinervaCorruption = new MinervaCorruption;


//All readers, please read the actual scenes before judging this work. Notes may be rough but the scenes aren't
//LOCATION
//Location: High Mountains - a small oasis high in the mountains with small grove of fruit-bearing trees and a pond of pure, crystal clear water.  Lanterns around the oasis and around the edge of the pond burn with purifying white fire.  The soothing scent of mint wafts up from numerous peppermint plants that sprout from the moss.
//Due to the pure nature, and its location, demons do not approach the spring oasis to get rid of it. Harpies drive off demons that come into their territory, as well, and the oasis is close to their territory, which offers some protection as well. 
//What you can get from coming here (subject to Fen-balancing)
//item data can be found at the bottom of the doc
//The trees grow purity peaches, yellowy orange with reddish tiger stripes, and the size of a pomegranate.  The fruit can be consumed to give a small speed and intelligence stat boost of 2-3 points, lower fatigue by 10 and lower corruption by 1-2 (if Minerva becomes corrupted, the fruits still give stat boosts and remove fatigue, but now give corruption instead of lowering it).
//Consuming the calming mint lowers libido and lust by 3 and 10 respectively (if Minerva becomes corrupted, the mint instead raises libido and lust).
//The pc can drink from, or relax in, the spring to lower fatigue by 10 as well as lower corruption by 4-5 - The corrupted spring also boosts Lust by at least 10-20 points with each dip as well as raising corruption 5-6 points.

//When corrupted or purified, Minerva can get pregnant and impregnate the pc with baby sirens.
//Minerva herself!
//Minerva appearance (normal) 
//http://i46.tinypic.com/20z1f1x.jpg

		public function timeChange():Boolean
		{
			var needNext:Boolean = false;
			pregnancy.pregnancyAdvance();
			trace("\nMinerva time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
			if (pregnancy.incubation == 0 && pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
				minervaPurification.minervaGivesBirth();
				needNext = true;
			}
			return needNext;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}

		public function tryToImpregnateMinerva():void {
			//Chance of getting Minerva PREGNANT!
			if (flags[kFLAGS.MINERVA_CHILDREN] >= 100) return; //Maxed out!
			var chance:Number = 30;
			chance += Math.sqrt(player.cumQ());
			if (chance > 75) chance = 75;
			chance += player.virilityQ() * 100;
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) chance -= (flags[kFLAGS.MINERVA_CHILDREN] * 2); //Diminishing returns. The more the children, the harder it is to get her pregnant.
			//Chance is between 10 and 75 percent.
			if (chance < 10) chance = 10;
			if (chance > 80) chance = 80;
			if (rand(100) < chance && !pregnancy.isPregnant) {
				trace("Minerva got PREGNANT!");
				pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_MINERVA);
			}
		}
		
private function minervaAppearance():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-appearance"), false);
	outputText("Minerva is a siren. She stands 8'5\" with navy blue skin and a white belly, neck and inner thighs. Orange and white stripes adorn her legs, tail and back.  Her head is topped with fiery red orange hair that frames her face with well kept bangs and also slide down her back in a pair of long braids.  Her eyes are bright electric blue on pure black sclera.  The siren's body is adorned with an expansive array of golden studs and rings, one through an eyebrow, a pair on her lips and even one in her nose.  From her ears hangs large hoop earrings while a trio of studs sits higher up.  Along the fin that tips her tail are a set of five gold rings linked together by a fine silver chain.");
	outputText("\n\nAttention-grabbing large red and orange feathered wings sprout from her back; the same feathers flow down her arms like those of a harpy.  Two DD-cup sized breasts rests on her chest, they would look large on a human, but on Minerva, they appear quite average.  Each breast is topped with a firm gold stud pierced nipple about half an inch thick.");
	outputText("\n\nHer feather-covered arms would be more at home on a harpy, but contrasts well with her well toned body. Her skin is blue and white and, though she is clothed, you can tell from how sheer her tight tube top is, that her nipples are a tender pink.");
	outputText("\n\nMinerva's wide hips make her waist appear thin and waspish; they sway in unison with a striped shark tail, each step accentuating her hips and tight shorts her rear.  A long, pink horizontal scar mars the clean white skin across her stomach and a golden piercing adorns her navel.");
	outputText("\n\nBetween Minerva's lightly toned legs rests all of her sexual organs; a normal vagina, and an unusually thick, sixteen-inch long anemone-like penis.  The glans of that blue and pink shaft is ringed by small aphrodisiac-filled tentacles, while the base is surrounded by long tentacles as thick as fingers.  Nestled against her soft thighs is a scrotum with apple-sized balls.  She has a tight asshole, placed between her shapely buttcheeks, where it belongs.");
	outputText("\n\nMinerva has large demonic feet, each toe double-jointed and tipped with a large, black talon.  Similar to her feet, her tongue also has a demonic quality, being two foot long and fully prehensile.");
	outputText("\n\nA white tube top and a pair of short shorts are all the siren wears for clothing.");
	menu();
	//[Talk] [Sex] [Eat] [Fight] [Leave]
	//addButton(0,"Appearance",minervaAppearance);
	genericMenu();
}

public function encounterMinerva():void {
	if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) {
		if (flags[kFLAGS.MET_MINERVA] > 0) flags[kFLAGS.MET_MINERVA]++; //Increment counter by 1 if previously met Minerva.
		if (flags[kFLAGS.MET_MINERVA] == 0) firstMinervaEncounter();
		else if (flags[kFLAGS.MET_MINERVA] == 3) minervaThirdPlusEncounter();
		else if (flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] > 0 && player.gender > 0 && flags[kFLAGS.MINERVA_LOVE] == 0 && rand(2) == 0) minervaAfterFiveTalksRomancing();
		else {
			if (rand(2) == 0) minervaThirdPlusEncounter();
			else repeatEncounterMinerva();
		}
	}
	else {
		minervaPurification.visitTowerPostPurification();
	}
}

//Basic intros
//1-1 First Encounter.
private function firstMinervaEncounter():void {
	clearOutput();
	outputText("Returning to the mountains, you begin to climb; the usual search for loot and, perhaps, some harpies driving your upward efforts.  Perhaps you'll run into");
	//If Sophie Bimbo=0:
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] == 0 && !kGAMECLASS.sophieFollowerScene.sophieFollower()) outputText(" that matronly harpy, Sophie");
	else outputText(" something interesting");
	outputText(", or get some good plunder from some of the local beasts");
	//if minotaur cum addict:
	if (player.minotaurAddicted()) outputText(".  With any luck, you might even find a hunky minotaur to scratch that burning itch in your mind");
	outputText(".  Trudging on, you make your way up and up the mountain, passing the occasional harpy nest as you climb and traverse along the mountain paths.  Just when it looks like you're going to hit the clouds, you catch sight of a trail that you had never really noticed before.");
	//Choice
	//[Ignore Path] [Take Path]
	menu();
	addButton(0,"Take Path",takeMinervasPath);
	addButton(1,"Ignore Path",ignoreMinervasPath);
}
//[Ignore Path]
private function ignoreMinervasPath():void {
	clearOutput();
	outputText("Deciding to play it safe, you turn away from the new path and continue your search elsewhere.");
	// PC returns to camp.
	doNext(camp.returnToCampUseOneHour);
}
//[Take Path]
private function takeMinervasPath():void {
	clearOutput();
	minervaSprite();
	outputText("Knowing that a new path could lead to great things, you can't help but wonder where this one could lead.");
	outputText("\n\nYour curiosity gets the better of you, and you head down this new path.  Winding along the dangerous mountainside, you come upon what looks like a ruined tower built into the mountain.  It was probably erected as some kind of outpost by some long-forgotten people.  Panting from your long trek, you decide to use the tower as shelter and recover your strength.  Cautiously, you approach the ruins and peek inside.");
	
	outputText("\n\nYour eyes widen in surprise when you see what's inside.  You certainly didn't expect to see anything like this!  The huge ruin seems to have been built to completely enclose and protect some kind of mountain oasis.  What lies inside is not stone tiling or boulders, but rich, natural soil with leafy shrubs, blooming fruit trees, and even soft mosses growing from the fertile ground.");
	
	outputText("\n\nCloser inspection reveals that the clean and fertile soil has been spread in a deep pit dug into the rock.  A lush place like this certainly contrasts with the rather barren mountains surrounding it and must be very special, indeed. You're surprised that the demons missed such a tranquil place.  A pool of crystal clear, clean water acts as the centerpiece of this lovely location, feeding all the plants here and radiating a calming aura, making you feel at peace just by being around it.");
	outputText("\n\nThe longer you look around the hidden oasis, the more you can't help but feel that someone, or something, must live up here.  As if sensing your thoughts, a large shadow darkens the ground around you, prompting you to look up at the broken ceiling.  ");
	if (!player.isTaur() && !player.isDrider()) {
		outputText("The shadow reveals itself to be a huge, winged being, something that becomes painfully obvious as it slams into you and picks you up off the ground.  You can't help but look down as you're flown up through the roof and away from the oasis, your assailant carrying you out over the cliffs.  A fall from this height could surely mean your death.");
		outputText("\n\nAt first, you think your attacker is just another harpy, but now that you can get a better look at it, you notice a bizarre mix of shark and harpy features.  Whatever the creature is, it has quite clear feminine traits: Large breasts, wide hips and a beautiful face mark her as a woman.  However, the unmistakable bulge in her shorts suggests her to be a hermaphrodite.  Your eyes make out several finer details: Navy blue skin, contrasted by white and orange stripes and pulled taut against toned, muscular limbs; and bright, almost flaming, red-orange hair and feathered wings.  Whoever this is, it seems hostile.  You desperately struggle against the clawed grip of this huge shark... harpy... thing.");
		outputText("\n\nYour thrashing loosens the grip of your captor, but instead of simply dropping you to your doom, it flies near the cliffs and drops you on your [ass] to the solid ground.");
	}
	//legs=centaur/drider:
	else {
		outputText("The shadow reveals itself to be a huge, winged being, something that becomes painfully obvious as it slams into you with all its might.  The sudden, powerful impact rams you clean out of the tower and to the edge of the cliff.  Rushing to get back on your [legs], you see your assailant for the first time.");
		outputText("\n\nAt first, you think your attacker is just another harpy, but now that you get a better look at it, you notice a bizarre mix of shark and harpy features.  Whatever the creature is, it quite clearly has feminine traits: Large breasts, wide hips and a beautiful face mark her as a woman.  However, the unmistakable bulge in her shorts suggests her to be a hermaphrodite.  Your eyes make out several finer details: Navy blue skin, contrasted by white and orange stripes, pulled tautly against toned, muscular limbs; and bright, almost flaming, red-orange hair and feathered wings.  Whoever this is, it seems hostile, or, at the very least, like someone trying to protect their home from an unknown intruder.");
	}
	outputText("\n\nBefore you can get up however, you're attacked again.  The shark-harpy creature lifts you off the ground with");
	if (player.tallness <= 96) outputText(" one hand");
	else outputText(" both hands");
	outputText(", bodily swinging you out over the abyss, with only her grip keeping you from plunging back down the mountainside.");
	//Low corruption: 
	if (player.cor < 50) outputText("  \"<i>All right, you!  Who are you and what are you doing here?!  I don't get any visitors besides those horny harpies, so what are you after?  Hm?");
	//High corruption:
	else outputText("  \"<i>All right, you corrupted beast!  Who are you and what are you doing here?  Your presence is not welcome in this sanctuary... answer quickly or I'll drop you to your death!");
	//Demon Score=3>:
	if (player.demonScore() >= 3) outputText("  Filthy demon!  Come to finish your work, have you?!  You won't take me without a fight!  Maybe if you beg for your life I'll give you a chance. Speak!  Convince me to not simply kill you here and now!");
	outputText("</i>\" the creature demands, clearly threatening to drop you if you don't answer to her liking.");
	
	//Goo:
	if (player.isGoo()) {
		outputText("\n\nNuts to this, you think to yourself.  Your goopy form is more than capable of surviving an impact with the ground, you tell the bizarre creature as you swallow her legs into your mass, something that her own form can't do.  You could envelop her body and force her into the unyielding ground if you wanted to.  But you decide against it... for now.  You chide the mysterious creature and tell her that you don't wish to cause her harm");
		//Corruption=75>:
		if (player.cor >= 75) outputText("... \"<i>yet</i>\", you think to yourself.");
		
		outputText("\n\nIf she feels set on conflict, however, you are more than willing to help calm such aggressive intentions.  Realizing the position she's in, the feminine beast sighs and asks what you want.");
	}
	//Wings: 
	else if (player.canFly()) {
		outputText("\n\nYou're sure you could fly to safety if she released you, but you figure there'd be more to gain by answering her.");
	}
	else outputText("");
	outputText("\n\nHastily, you explain that you didn't mean to intrude, that you were just exploring the mountain and stumbled upon her \"nest\" by accident.  The shark-like harpy looks at you with suspicion, oddly wary for someone who lives in such safety.  After all, thanks to the harpies as a deterrent, and being so out of the way, it's highly unlikely anything hostile comes out this way.");
	
	outputText("\n\nShe analyzes you and your words, her bright electric blue eyes scrutinizing every inch of you.  \"<i>I sense no lies in your voice, but make no mistake, I don't trust you yet,</i>\" the strange harpy says, setting you back down on the relative safety of the rocky edge.");
	//High corruption:
	if (player.cor > 66) outputText("  She is wise not to fully trust you.");
	
	outputText("\n\nWith");
	if (player.isGoo()) outputText(" your own");
	else outputText(" a");
	outputText(" relieved sigh, you take in the sight of the strange shark... harpy... harpy-shark... sharpy?  What an odd combination!  Looking the woman up and down, you take in her whole appearance.");

	outputText("\n\nShe is quite tall, roughly eight and a half feet by your estimate, covered in navy blue skin that looks like that of a shark girl, and with fiery red-orange hair that frames her feminine face and hangs down in long braids.  The harpy traits are just as obvious: A large pair of bird-like wings extends from her back, their feathers sharing the same burning hue as her hair.  Those same feathers also run down her arms like warm, feathered sleeves, while a long shark tail drapes down from her lower back, completing her unusual appearance.");
	
	outputText("\n\nThe, as yet unnamed, shark-harpy is wearing a tight white tube top that squeezes her DD-cup breasts tightly enough that a pair of stud-like piercings can be seen poking out from the fabric.  A pair of dark blue short shorts hugs her hips snugly and contains the hefty, seam-straining bulge of her male endowment.");
	
	outputText("\n\nThe unusual creature taps one of her demonic-looking clawed feet, the hard black talons clicking against the stone of the mountain, and looks rather annoyed over how long you've been eyeing her.  \"<i>Enough, already!  You said you're not here to cause trouble!  What do you want?</i>\"  Just as you are about to speak, the odd being sighs before shaking her head.  \"<i>I apologize for my rudeness, I'm just not used to visitors.  The only ones that bother to come here are some of the harpies that just try and get me to fertilize them,</i>\" she explains.  \"<i>Allow me to introduce myself, my name is Minerva.  This place is my home... as for what I am - you're obviously curious - you could call me a 'siren'. Sorry for interrupting you by the way</i>\"");
	
	outputText("\n\nLooking at her curiously, you admit that you had a different name in mind for what she is, you would perhaps have called her a 'sharpy,' since she is part shark and part harpy, though her choice has a pleasant ring to it.  Hearing your name for her actually seems to amuse her.  \"<i>Ah, an apt name for sure, but I like to call myself a siren.  It's something from my homeland, you see.  Where I'm from, it was a name for these mythical half-fish, half-bird girls that would lure men into traps with their songs.  And since I'm... well, this,</i>\" she states while gesturing to herself, \"<i>I thought I would use that name for what I am now.  And not because I like to sing, though I do... It's just... I'm part girl, part bird, part fish and part... never mind... just call me a siren... I guess you can come inside if you want.</i>\"  Minerva turns around and heads toward her tower.");
	flags[kFLAGS.MET_MINERVA] = 1;
	//[Follow] [Leave]
	menu();
	addButton(0,"Follow",followMinerva);
	addButton(1,"Don'tFollow",leaveMinervasFirstEncounter);
}

//[Follow]
private function followMinerva():void {
	clearOutput();
	minervaSprite();
	outputText("Deciding that you want to know more about Minerva, you follow her into the tower.  \"<i>So, now that you're inside, would you like to talk?  Or perhaps to partake in some of the peaches that grow on my trees?</i>\" she asks, looking at you with interest.");
	//[Talk] [Drink] [Eat] [Leave]
	menu();
	genericMenu();
	removeButton(0);
	removeButton(2);
}

//[Leave](for first encounter options)
private function leaveMinervasFirstEncounter():void {
	clearOutput();
	minervaSprite();
	outputText("You decide that you don't want to risk going into Minerva's lair as, for all you know, it could be a trap.  Therefore, you turn around and skedaddle back down the mountain.  As you leave, Minerva turns and watches you for a bit, a sad look on her face before she turns back and heads inside her home, alone.");
	// PC returns to camp.
	doNext(camp.returnToCampUseOneHour);
}

//1-2 Repeat Encounter 1.  Use any time.
public function repeatEncounterMinerva():void {
	clearOutput();
	minervaSprite();
	flags[kFLAGS.MET_MINERVA]++;
	outputText("You make your way up the mountain, looking for the oasis tower that you know has to be around here somewhere in the thick mist.  With a bit of searching, you locate the right path and head for the oasis, finally reaching it.  Panting from your long trek, you enter the tower through its crumbling doorway, wondering if Minerva will be home.");
	if (flags[kFLAGS.MET_MINERVA] == 4)
	{
		outputText("\n\n<b>You have visited her enough times to be able to remember where to go. Unlocked Oasis Tower in Places menu!</b>", false);
	}
	outputText("\n\nUpon entering the humble home, you assess the state of the oasis.  The usual fruit trees and the clean pond are still here. Upon taking a closer look, you spot Minerva in the spring as she floats out from behind the cover of a tree.  The shark-like harpy is relaxing in the pure waters like she normally does.");
	outputText("\n\nAs you approach the pond, she catches sight of you and twists in the water, swimming to the shore and wading out to greet you.  Her smooth sharkskin is glossy and dripping wet from her recent swim, the rolling moisture accentuating her well-defined curves.");
	//No romance: 
	if (!minervaRomanced()) outputText("  \"<i>Ah, [name], you have returned!  What can I do for you?</i>\"");
	else outputText("  \"<i>Mmm... my lover has come to see me!  Oh, how I have missed you, my sweet!  Won't you join me for a bath?  Or... is there anything else I can do for you?</i>\"");
	
	//[Talk] [Sex] [Eat] [Fight] [Leave]
	genericMenu();
}

//1-3 Repeat Encounter 2.  Use if 3rd+ time visiting Minerva.
private function minervaThirdPlusEncounter():void {
	clearOutput();
	minervaSprite();
	outputText("You make your way back up the mountain, passing the usual harpy nests as you go, looking for the oasis tower that you know has to be around here somewhere in the thick mountain mists.  After a tedious amount of time spent searching, you finally locate the path and start your journey toward the oasis.  The promise of a respite from your climb, along with food and company, compels you to continue until you finally reach the oasis tower.  Thankfully, you don't have to search long before you promptly catch sight of the crumbling tower.  Panting from your long trek, you enter the tower through a rusted, creaky door.");
	if (flags[kFLAGS.MET_MINERVA] == 4) outputText("\n\n<b>(You have visited the tower enough times to be able to remember where to go. Unlocked Oasis Tower in Places menu!)</b>"); //Unlock Minerva's tower from Places menu.
	outputText("\n\nSurprisingly, you don't see Minerva anywhere.  The shark-harpy isn't lounging in the water, or doing her usual calming exercises.  After a moment, though, a familiar shadow passes over you, and the siren in question lands nearby, smiling at you, looking blissfully happy to finally have some company.");
	//No romance:
	if (!minervaRomanced()) outputText("  \"<i>Welcome back, [name]!  It's good to see you again.  Have you come to give me some company, or would you like to partake in some of the fruit?  Or are you maybe here to sate your thirst?</i>\"");
	else outputText("  \"<i>Darling!  Coming to visit me all the way out here!  How sweet of you!</i>\"");
	outputText("  Minerva says as she strides toward you, her generous hips swaying back and forth, as if to entice you into her arms.");
	menu();
	//[Talk] [Sex] [Eat] [Fight] [Leave]
	genericMenu();
}

//Romancing scenes encounter with all sub scenes.
//1-1 Cute Encounter. Minerva has taken a special liking to the pc by talking to her 5 times.
private function minervaAfterFiveTalksRomancing():void {
	clearOutput();
	minervaSprite();
	flags[kFLAGS.MET_MINERVA]++;
	outputText("You make your way back up the mountain, passing the usual harpy nests as you go, looking for the oasis tower that you know has to be around here somewhere.  With a bit of searching, you locate the right path and head for the tower.  The promise of a respite from your climb, along with food and company, impels you to continue until you reach the oasis tower.  Thankfully, you don't have to search for long, promptly catching sight of the crumbling tower.  Taking in the sights, you look around, assessing the state of the oasis.  The usual fruit trees remain, and the clean pond is still here, but you don't see Minerva anywhere.");
	
	if (!player.isTaur() && !player.isDrider()) {
		outputText("\n\nYou're about to turn around and head off when you're suddenly grabbed and lifted into the air.");
		outputText("  Looking up, you see the grinning face of Minerva, clearly playing with you.  \"<i>Well, hello there, [name]!  I was wondering when you would come and visit me.  I can be away from the oasis for a little while, so... want to go for a flight, or are you scared of heights?</i>\"  she asks playfully.");
		//[Flight] [Land]
		menu();
		addButton(0,"Flight",goForASkyRideWithMinervaHeartBaring);
		addButton(1,"Land",dontFlyWithWithMeYouCrazyBitch);
	}
	else {
		outputText("\n\nYou grin mischievously as the Siren moves to take your body into her grasp; there's no way she could lift you... right?");
		outputText("\n\nMuch to your surprise, Minerva actually manages to get you a few feet off the ground, and though she has to use both hands and feet to do it, the champ is actually lifting you off the ground.  \"<i>Ooh... I don't think this is going to wooorrrk,</i>\"  she manages to groan, the strain of keeping you in the air taking its toll.  Landing with a soft thud, Minerva wipes the sweat from her brow, her efforts visible on her reddened face as she pants and heaves for air.  \"<i>Okay... I was going to take you flying, but I have another idea since </i>someone<i> is too heavy to be flown,</i>\" she jeers playfully, and with her usual sharky grin.");
		
		outputText("\n\nTaking your hand gently in hers, the siren leads you around the tower, giving you a peaceful walk around her home, showing you around and spending some quality time with you.  As you look around the tower, you notice that it seems to have been fixed up a little, and the place has been cleaned up since you started visiting Minerva.  Perhaps you have had some effect on her?  Looking at the siren in question, you can't help but notice the nervous look she has, as if she wants to say something but is holding it inside.  Eventually, your tour of the tower takes you to its centerpiece, the pure spring that dominates the tower interior.  Leading you to the shore, the siren sits with you by the water.");
		// Lead to Minerva opening her heart.
		menu();
		addButton(0,"Next",minervaOpensHerHeartAndDisplaysHerVentricals);
	}
}

//[Flight]
private function goForASkyRideWithMinervaHeartBaring():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-fly"), false);
	outputText("You grin with excitement and");
	if (player.isGoo()) outputText(" cling");
	else outputText(" hold");
	outputText(" onto the large shark-harpy, telling her that you don't mind flying with her.");
	//No or small wings:
	if (!player.canFly()) outputText("  Minerva seems quite pleased when you accept her offer, her arms hugging you against her and resting your head on her soft chest as she beats her wings harder.  With each pump of Minerva's wings, you ascend higher into the tower, and through the huge opening at the top.  Both of you keep going higher and higher until you finally breach the clouds.  As soon as you get above the clouds, the siren suddenly does a spin midair, positioning the two of you so that her back is turned to the distant ground, and you're lying atop her body with the heavens behind your back.  The two of you seem to float there for a moment before gravity kicks in and you both plummet back down through the clouds.");
	//Large wings: 
	else {
		outputText("  Minerva seems quite pleased that you accepted her offer.  Seeing you have powerful wings of your own, she slowly lets go, allowing your wings to spread out and beat as you hover next to her.  The pair of you fly out of the tower together, streaking through the air as you both zoom around the mountain, and it becomes almost like a playful race between you.");
		outputText("\n\nThe sound of powerful wing beats and the rushing of air mixes with the sound of joyful laughter as you race and play with the flying siren.  Reaching out to you with a hand, Minerva decides to put on a show for you.  Beating her wings harder, she pushes ahead of you, twisting and twirling as she rolls above you, your eyes locking with hers for a fleeting moment and catching the look of joy in them.  Not one to be outdone in a race, you flap your " + player.wingDesc + " wings harder and harder, speeding ahead on the final turn as you both rush toward the tower.");
		outputText("\n\nSeeing you getting ahead brings a grin to Minerva's face.  Gritting her teeth, she pushes herself to catch up with you, her arms reaching out and grabbing you in a playful air tackle.");
	}
	//Lead in for Minerva opening her heart (All body types except Centaur and Drider)
	outputText("\n\nThe two of you dive faster and faster, screaming toward the ground");
	//Goo: 
	if (player.isGoo()) outputText(" while you're barely able to maintain your slimy cohesion");
	outputText(".  You almost think that this is going to be the end of you, only for Minerva to roll you both around in the air and spread her wings, slowing down the rapid descent.  The pair of you rocket in through the crumbling entrance of the tower and crash into the steaming spring, the cleansing waters spraying out from the impact, splashing across the surrounding plants and slowly running back toward the spring.  As you and Minerva come up for air, the tall shark-harpy pulls you back into her arms and holds you close to her chest.  \"<i>This was so much fun!  It means a lot to me, you know, that you actually want to help get this thing out of me and put an end to its vile presence,</i>\"  the redheaded siren says warmly,  hugging you close as you sit together in the water.");
	//Lead to Opening her heart.
	menu();
	addButton(0,"Next",minervaOpensHerHeartAndDisplaysHerVentricals);
}

//Opening her heart
private function minervaOpensHerHeartAndDisplaysHerVentricals():void {
	clearOutput();
	minervaSprite();
	outputText("Holding you gently in her arms as she looks deeply into your eyes, the siren stammers, \"<i>H-hey... I've been meaning to talk to you about something.  I've been thinking about you... and me...  You're the first real person to come here.  I mean, the harpies come around to get me to breed them, but that's all they're really interested in.  But you... you keep coming back, and it's not always sex with you.  You talk to me and spend time with me... you're actually interested.  I've been alone for a long time with no one but a couple of birdbrained harpies talk to.  Until you came around, that is- you changed all that.</i>\"");
	outputText("\n\nYou look at the blue-skinned harpy-shark.  She looks to be blushing, though her cheeks are flared purple instead of red or pink. Minerva even appears flustered, like she doesn't quite know what to say.  It's clear she isn't used to this sort of thing, and it's making her ordinarily sharp features look softer... and it's actually kind of cute.  \"<i>Hey, are you listening?  I'm trying to have a moment with you here! This is... really important to me,</i>\"  she declares with an exaggeratedly irritated pout before softening again.");
	outputText("\n\nYou chuckle at her reaction before apologizing and asking the siren to continue.  Minerva sighs, reaching up and stroking your cheek before leaning in and planting a soft kiss on your lips.  \"<i>What I'm trying to say here is... you managed to win over the heart of a lonely siren. I've fallen for you and your dashing charms... there is no other way to say it than... I love you.  I know it's a bother to come here to see me, but I will have you, if you will have me,</i>\" Minerva admits, looking you straight in the eyes as she waits for your answer.");
	//Choice
	//[Kiss] [Reject]
	menu();
	addButton(0,"Kiss Her",yeahSureMinervaILikeYouAndShit);
	addButton(1,"Reject",rejectMinervasLove);
}

//Kiss
private function yeahSureMinervaILikeYouAndShit():void {
	clearOutput();
	minervaSprite();
	outputText("You already know your answer.  Smiling, you lean in and kiss the siren's glossy black lips, an act which prolongs the blush on her face, though it doesn't take long for Minerva to recover.  She pushes you off of her and tackles you into the pool.  Sitting on top of you, the redhead smirks down at you before grabbing onto your shoulder and forcing you into a welcome kiss, her long, demonic tongue quickly snaking into your mouth to deepen the passionate smooch.");
	outputText("\n\nYou can't help but return her grasp when Minerva starts to kiss you again.  Your hands slowly move over her smooth, wet skin, and touch every part of her you can reach, feeling her curves, her firm, gently toned muscles, down her thin waspish waist that flows out into her generous hips, and her ample, squeezable ass.  As soon as you reach her butt, your hands squeeze her, eliciting a gasp from your new lover and making her break the kiss.  \"<i>Why, you... not satisfied with a kiss, are you?</i>\" your siren asks with a toothy grin.");
	flags[kFLAGS.MINERVA_LOVE] = 1;
	menu();
	//{Male: [NEXT] / Female/Herm: [NEXT]}
	//Sex Menu
	if (player.gender == 1) {
		if (player.cockThatFits(minervaVCapacity()) >= 0) addButton(0,"Next",minervaCowgirlSex);
		else addButton(0,"Next",letMinervaSuckYouOff);
	}
	else addButton(0,"Next",minervaLapSex);
}

//[Reject]
private function rejectMinervasLove():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("impoverlord-loss-female"), false);
	outputText("You stare at Minerva awkwardly as she waits for your response, her electric blue eyes looking at you with hope.  ");
	if (player.cor < 45) outputText("The look in the siren's eyes only makes this harder for you as you look into them; you can't help but feel bad that you really don't feel anything special for her.");
	else outputText("You can tell she really wants this - the siren is almost desperate for your attention.  Unfortunately for the love starved herm, she won't find the love she craves with you.");
	outputText("  You look away from her and pull back a bit before speaking.  You confess to her that, while she is a nice person, you do not feel that sort of bond with her, and you apologize if she was misled by your actions, but that you would like to be friends with her still.");
	
	outputText("\n\nAs you speak, you see the hope she had fade, and her face droops in sadness as you reject her feelings.  \"<i>I-I see... I thought that...</i>\" she stops and looks away, before moving away from you and stepping out of the cleansing waters.  The tall, red-headed shark-harpy keeps her back to you, her tail curled around her legs protectively.  \"<i>I'm sorry, I shouldn't have gotten my hopes up.  Can you... maybe you should go, I want to be alone for a bit... but... I... just make sure to come back, please. I would like to still see you around,</i>\" she requests sullenly as she stands by the pool.  Keeping her back to you she looks over her shoulder, a sad smile on her face, it's clear she's trying to be strong and hold back her feelings.  \"<i>I guess love just isn't in the cards for me.</i>\"");
	
	outputText("\n\nSlowly, you get up, looking away from the curvy siren as you step out of the pool and leaving Minerva's tower.  Hopefully she won't be upset for too long, it would be best to check up on her later.  As you go, you swear you hear her let out a sob, the pain of your rejection clear as the mist that floats around the mountain.");
	// PC returns to camp.
	flags[kFLAGS.MINERVA_LOVE] = -1;
	doNext(camp.returnToCampUseOneHour);
}


//[Land]
private function dontFlyWithWithMeYouCrazyBitch():void {
	clearOutput();
	minervaSprite();
	outputText("You look down at the ground with a little uncertainty; you're already so high up.  Looking back at the grinning siren, you rapidly shake your head.  You very much don't want to be flying, especially not with such a gut clenching fall beneath you.  Minerva's grin lessens somewhat, clearly a bit disappointed that you don't want to go flying with her.  She nods despite her disappointment, and glides back down to the tower ground, setting you down on the soft moss that surrounds the pure hot spring.");
	
	outputText("\n\nMinerva looks at you nervously, as if she wants to say something, but then she just smiles and shakes her head.  \"<i>Well... now that you're safe and sound on the ground, is there anything I can do for you, hun?</i>\"");
	//Randomly present flying option scene in future interactions. 
	//[Talk] [Sex] [Eat] [Fight] [Leave]
	menu();
	genericMenu();
}

public function fightMinerva():void {
	startCombat(new Minerva(),true);
	minervaSprite();
	playerMenu();
}

private function genericMenu(display:Boolean = false):void {
	menu();
	if (display) outputText("\"<i>So what will it be then?</i>\"");
	if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10) {
		minervaPurification.pureMinervaMenu();
		return;
	}
	addButton(0,"Appearance",minervaAppearance);
	addButton(1,"Talk",minervaTalkSelect);
	if (player.lust >= 33) addButton(2,"Sex",minervaSexMenu);
	addButton(3,"Eat",eatSomethingYouCunt);
	addButton(4,"Drink",getADrinkYouBitch);
	addButton(5, "Spar", fightMinerva);
	if (minervaRomanced() && model.time.hours >= 20) addButton(6, "Sleep With", sleepWithMinerva);
	if (player.hasKeyItem("Rathazul's Purity Potion") >= 0) addButton(7, "Purify", minervaPurification.purificationByRathazul)
	if (player.hasKeyItem("Marae's Seed") >= 0) addButton(8, "Plant Seed", minervaPurification.purificationByMarae)
	addButton(14, "Leave", camp.returnToCampUseOneHour);	
}

//1-2 Repeatable Cute, Romantic Encounter. Only if PC accepted Minerva's feelings. Add to normal encounters.
private function repeatableMinervaRomanceScene():void {
	clearOutput();
	minervaSprite();
	outputText("You make your way back up the mountain, passing the usual harpy nests as you go.  Climbing through the clouds, you reach a height that has only become easier thanks to the repeated effort.  You make your way back up the mountain, passing the usual harpy nests as you go, looking for the oasis tower that you know has to be around here somewhere in the thick mountain mists. The promise of a respite from your climb, along with food and company, compels you to continue until you finally reach the oasis tower.  Without pausing to catch your breath you head for the tower, the desire to see your siren lover beating out the nagging fatigue you feel from the tough climb.  Your legs are pumping hard as you hoof it down the path, soon enough happening upon the shape of the ruined tower that encloses Minerva's oasis.");
	
	outputText("\n\nNot wasting any time, you head right for the tower.  Upon entering the humble home, you take in the sights and assess the state of the oasis, looking for your favorite flying shark girl.  Before you can really get a good look, though, you've been grabbed and pulled into what seems to be a dance, your hands taken by Minerva's as she spins you and hugs you tightly.  \"<i>I was wondering when you would return to me, I've missed you so much, [name]!  I'm so glad you could come by,</i>\" Minerva says before leaning in to plant a kiss on your neck.  \"<i>So, hun, what shall we do?  Here to give me some company?  Or maybe you want to have some fun?</i>\"  she asks playfully as she presses her hips against yours, giving away her desires.");
	
	menu();
	//[Talk] [Sex] [Eat] [Fight] [Leave]
	genericMenu();
}


private function minervaTalkSelect(bath:Boolean = true):void {
	var choices:Array = [talkingToMinervaAboutBackstory];
	if (flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] == 0) {
		//Force first time to talk about her early backstory!
		if (flags[kFLAGS.MINERVA_BACKSTORY] == 0) {
			talkingToMinervaAboutBackstory();
			return;
		}
		choices[choices.length] = talkingToMinervaAboutBackstory;
		choices[choices.length] = talkingToMinervaAboutBackstory;
		choices[choices.length] = talkingToMinervaAboutBackstory;
		choices[choices.length] = talkingToMinervaAboutBackstory;
		choices[choices.length] = talkingToMinervaAboutBackstory;
	}
	//Force start if the flag is right.
	trace(flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS]);
	if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] == 1) {
		minervaPurification.startPurification();
		return;
	}
	//3-2 Talk Scene 2 - talks about the spring  
	//-repeatable
	choices[choices.length] = talkAboutTheSpringWithMinerva;
	//- requires that backstory has been told
	//- if already romanced Minerva shamefully confesses she may have fathered a granddaughter with her first daughter -repeatable
	//3-3 Talking Scene 3 - talks about her shark girl daughter
	if (minervaRomanced() && flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] == 1) choices[choices.length] =  talkWithMinervaAboutSharkGirlDaughter;
	
	//3-4 Talk Scene 4 - talks about her corruption
	//- romance yes only or if you trick her into thinking you love her. - Repeatable until Minerva is purified or corrupted
	if (minervaRomanced()) choices[choices.length] = talkToMinervaAboutHerCorruption;
	//3-5 Motherhood
	//-talks about how she wishes to be a real mother, have an actual loving family and not made from being raped- repeatable
	choices[choices.length] = minervaMotherhood;
	//3-6 Bath Time - romance only
	//Needs an option to be disabled.
	if (bath && minervaRomanced()) choices[choices.length] = bathTimeTalkWithMinerva;
	
	choices[rand(choices.length)]();
}

//Talking scenes
//3-1 Talk Scene 1 - talks about back story pt1 to pt3
//-repeatable
//Scenes occur in order, starting with part 1 and reset after part 3 is told. Talking is still somewhat random but backstory scenes will trigger in order. 
private function talkingToMinervaAboutBackstory():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-talk-backstory"), false);
	//PART 1
	if (flags[kFLAGS.MINERVA_BACKSTORY] == 0) {
		flags[kFLAGS.MINERVA_BACKSTORY] = 1;
		outputText("Telling Minerva that you want to sit down and talk seems to surprise her.  She certainly didn't expect you to come all this way, simply desiring mere conversation.  After her initial surprise, she smiles pleasantly.  \"<i>Really?  You want to talk to me?  All right, well, what do you want to know?</i>\" she asks, sitting cross-legged on the soft, pillowy moss across from you.  Joining her, you dive into questions concerning her past; how did she come to be what she is?  How did she come to find this place?");
		outputText("\n\nUpon asking about Minerva's past, she flinches.  \"<i>That kind of stuff... there... aren't a lot of good memories down that road.  There were plenty of painful times... but... holding onto painful memories like that isn't good for you, right?</i>\" the siren gives in with a sigh before coming back up to meet your expectant gaze.");
		outputText("\n\n\"<i>Well, I suppose I could start with how I got here.  I guess I'm like you, someone from the other side of one of those portals.  I was a sacrifice of some kind.  There was an ambush waiting for me on the other side.  Even though it was very close, I managed to slip away, but... not without being scathed,</i>\" she notes, gesturing to the long scar on her stomach.  Thinking of that monstrosity of a scar and how large it is, you can't help but wonder how she survived a wound like that.  \"<i>I know that I should have been killed by the blow, but... let's just say that what hit me... also closed the wound.</i>\"  You can't imagine what would have left a scar as terrible-looking as that, and to believe the blow not only inflicted the damage, but cauterized itself as well.  There's clearly something missing from this story.");
		
		outputText("\n\nWanting to take the topic away from her scar, Minerva continues.  \"<i>Of course, they chased after me, but they ceased once I reached the edge of the forest and the lake.  They seemed to fear the lake, giving up on me,</i>\" she adds with a look of relief.  You know exactly what she is talking about, having gone through a very similar experience, though in retrospect, perhaps not nearly as harrowing.");
		
		outputText("\n\nThe siren seems to be lost in thought, though whether she's deciding what to tell you next or simply remembering the events of the demon ambush, you couldn't say.  After a moment of silence, Minerva continues her story.  \"<i>Knowing the demons stayed away from the lake, I took it upon myself to stay there a few days, living on fish.  Unfortunately, the lake was not safe either.  Those simple-minded anemones and savage shark girls... as you can probably tell, I've had more than a few encounters with them.</i>\"  Minerva looks down at her body, more shark-like than human.  \"<i>I'm supposed to be female, but one of the anemones got to me.  Their tentacles are fairly potent and it kept stinging; I couldn't fight back for long before it started to mate with me... Suffice to say, it impregnated me.  Its offspring attached itself to my body and turned into this thing,</i>\" the siren says, before pointing between her legs.");
		
		outputText("\n\nShe again goes deep into thought.  \"<i>I think that's enough for now.  It's hard recalling all these... less than pleasant memories,</i>\" she declares.  With Minerva clearly reluctant to continue, you decide it's time to go.  Saying goodbye to the siren, you leave the tower and head back to camp, leaving Minerva alone with her thoughts.");
		// PC returns to camp.
	}
	//PART 2
	else if (flags[kFLAGS.MINERVA_BACKSTORY] == 1) {
		flags[kFLAGS.MINERVA_BACKSTORY] = 2;
		outputText("Telling Minerva that you want to sit down and talk seems to surprise her, she certainly didn't expect you to come all this way just looking for a conversation.  Getting over her initial surprise, she smiles pleasantly.  \"<i>Really?  You want to talk to me?  Well, all right, what do you want to know?</i>\" she asks as she sits down cross-legged on the soft, pillowy moss across from you.");
		outputText("\n\nTaking a seat, you ask her if she would continue talking about her past.  The shark-harpy purses her lips and seems lost in thought for a moment, unsure if she wants to keep going.  \"<i>Well... I suppose it would be all right to tell you more, if you really want to know,</i>\" Minerva says, running a hand through her red hair.");
		outputText("\n\nThe redheaded siren begins her story again, picking up where she left off, \"<i>I think I was at the part with that anemone...  hm... that was the start of some bad times in my life... so... after the incident with that anemone and getting my... well, after I became more than just female... I fled from the lake, I didn't want to run into any more of the creatures there, so I tried to survive further inland.</i>\"");
		
		outputText("\n\nShe shudders and once again looks down at herself.  \"<i>It didn't work out too well.  You see, I found this farm and it seemed all right, but I didn't want to take any chances, and I was really, </i>really<i> hungry at the time, so I just stole some of the peppers that grew there. These bulbous ones that smelled so good that I just scarfed them down like a hungry animal,</i>\" Minerva reveals with a sigh, squirming a little in her spot at the memory.  \"<i>Damn things made me grow balls... and, I guess, since I ate more than a couple... they got bigger.  At least I still kept my more feminine parts,</i>\" she notes, blushing at the realization that she was describing her genitalia to you.");
		outputText("\n\n\"<i>A-anyway... the food inland seemed a worse option than staying around the lake... I mean, I didn't want to turn into some giant-balled freak,</i>\" she says, her tone making it clear she's aware of the irony, \"<i>So I headed back to the lake, which may have been a mistake, but at least eating the fish didn't change me.  A few days passed without any incidents, until I swam into some of the shark girls that inhabit the lake...  they seemed to take a liking to my new... 'equipment.'  They were stronger than I was, fast and fierce.  They forced themselves on me, using me for their pleasure and making me impregnate them with my new male genitalia.</i>\"  The siren shivers at the memories of sexual violation by the shark girls.");
		outputText("\n\n\"<i>I guess they really took a liking to me, since they force-fed me these soft things that looked like sharks' teeth.  But they changed me, my skin turned all grey and blue, I grew a tail like them and even a fin on my back.  They turned me into some kind of anemone-dicked shark girl... which just made things worse.</i>\"");
		outputText("\n\n\"<i>There are creatures like that in the lake, these... more aggressive, </i>striped<i> shark girls with cocks and balls.</i>\"  She bites her lip, momentarily showing her own sharky teeth.");
		
		outputText("\n\n\"<i>There was this one that didn't like the fact that I was around and had knocked up those shark girls.  I guess it thought I was trying to wedge in on its harem and really, </i>really<i> didn't like it.  So it... </i>she<i>, decided she was going to add me to her harem.</i>\"");
		outputText("\n\n\"<i>I was exhausted from the other sharks when that angry striped one came along; she was much more threatening.  She grabbed me and made sure I was on the receiving end.  The - I guess tiger shark-was so rough...  The lusty beast wanted to teach me a lesson so she fucked me as hard as she could before dumping this... insane load of cum into me... so much that my stomach bulged out like I was already pregnant.</i>\"");
		
		outputText("\n\nMinerva seems to go quiet for a bit after that, just looking down at the ground.  The unpleasant feelings and memories of having been subjected to such a vile act is obvious in her eyes, and something about her behavior seems to suggest that she had been impregnated by the tiger shark.");
		
		outputText("\n\n\"<i>With her enjoying the orgasm, I struggled and managed to get away.  In the fight, it dropped one of those 'teeth' the other sharks had forced on me, but this one had a strange sheen.  I grabbed the thing and... just swam and swam until I reached the shore, then ran into the forest and just... I just...  I felt like giving up.  The world had tried to kill or rape me since I got here... it was probably the lowest point in my life.  I knew I needed to get stronger.  Stronger like the tigershark and sharkgirls.  I knew that those sharks were stronger than me and eating their fishy tasting things, so I took that glowing tooth and swallowed it.  That's how i got these stripes of mine,</i>\" the siren explains as she curls up in her spot, holding her knees to her chest.  For a moment you think she's isn't going to continue her story, but she starts back up, voice slightly muffled by her knees.");
		
		outputText("\n\n\"<i>It turns out that I had, in fact, gotten pregnant from that tiger shark.  And even though, as I said, I wanted to give up... I'd always wanted a family of my own, and it seemed like this would not just be some monster, but an actual child, so I gave this place another chance and decided to keep going.</i>\"");
		
		outputText("\n\n\"<i>I didn't have to wait very long, either... about twelve days after that tiger shark had its way with me, my stomach had grown like a balloon and I was already giving birth.  I thought I was going crazy when I saw my child, but there she was... I had given birth to a baby shark girl.</i>\"");
		
		outputText("\n\nMinerva actually seems to smile at the memory.  It is odd; you would think that she would have very negative feelings about having a shark girl daughter.");
		
		outputText("\n\n\"<i>When I saw her... the way she squirmed in my arms and looked at me...  All I could feel was a sense of pride and maternal instinct, so I kept her, let her suckle at my breast, and watched as she grew in my arms.  As she drank from me, her body swelled to the size of a young girl, maybe... twelve years old.  It was amazing to watch, and she was so cute.  I was happy to have her in my arms...</i>\" Minerva says with a tear in her eye before wiping it away.  \"<i>Thank you for talking to me like this, but I'd like to be alone for a bit...  I'll see you later though, I look forward to seeing you again.</i>\"");
		outputText("\n\nSeeing that she seems to be a bit better than she was the last time, you nod to her and give the siren a pat on the shoulder before saying goodbye, heading out from the tower and going back to camp, leaving Minerva to her thoughts.");
		// PC returns to camp.
	}
	//PART 3
	else {
		flags[kFLAGS.MINERVA_BACKSTORY] = 0;
		outputText("Telling Minerva that you want to sit down and talk with her seems to surprise her, she certainly didn't expect you to come all this way simply want to chat with her.  Getting over her initial surprise, she smiles pleasantly.  \"<i>Really?  You want to talk?  All right, well, what do you want to know this time?</i>\" she asks as she sits down cross-legged on the soft, pillowy moss across from you.");
		outputText("\n\nSitting down, as well, you ask about her and if she would continue telling you about her past.  The shark-harpy purses her lips and seems to think about it for a moment, unsure if she wants to keep going. \"<i>Well... I suppose it would be all right to tell you more, if you really want to know,</i>\" Minerva says, running a hand through her red hair, remembering where she stopped last.");
		outputText("\n\nThe redheaded siren begins her story again, picking up where she left off, smiling this time, \"<i>I remember we stopped right after I had my daughter.</i>\"  Already, Minerva seems a bit happier, though her smile looks bittersweet.  \"<i>I miss her... my darling daughter, my little girl...</i>\" she says, shaking her head and continuing her story.  \"<i>When I was about to give birth, my new instincts told me to seek out water.  I didn't want to go back to the lake again, so I managed to find a river and ended up giving birth to my daughter there.  With her born and so young, I didn't want to just travel around.  So we stayed at the stream for a while.</i>\"  Minerva stops for a moment, closing her eyes as if she's picturing it in her head, reliving the time spent with her daughter.");
		outputText("\n\nAfter a moment or two of reminiscing, Minerva opens her eyes again and, even though she seems sad again, you also notice a certain happiness.  \"<i>We stayed there at the stream for months.  It was just us, mother and daughter.  The stream even had fish in it - plenty of them, too, so it was easy to feed just the two of us.  It seemed safe for us there, and while she was growing up we needed to be by the water.  She... grew up fast, though.  In a matter of months she was about an adult's size.  Though she was smaller than I was at the time, she was easily the size of the tiger shark who had fathered her.</i>\"");
		outputText("\n\n\"<i>I had no idea that she would grow up so quickly!  After reaching the size of a preteen, I figured that she would just grow normally from that point on, but there she was... only a couple of months old and an adult.  It was amazing, but sad... I hoped she would be young just for a while longer so I could be her mother a bit more...</i>\"  Minerva looks down now, seeming ashamed.  \"<i>I... there was... I don't want to talk about this right now,</i>\" she says as she brings her knees to her chest and holds them tight; clearly this is a very sensitive topic.  You reach over and put a hand on her shoulder as a gesture of comfort.  The sad siren looks up at you for a moment before shuffling closer and leaning against you.");
		outputText("\n\nShe stays silent for a bit, likely thinking about whatever happened to her daughter.  You're not sure what occurred, but it is clearly a painful memory.  With a sigh, Minerva continues her story.  \"<i>Maybe I'll tell you about what happened another time, but I'm skipping it for now...  Let's just say I had to leave and continue on my own.  I was having a hard time by then, as my body was getting more corrupted by the day. I could feel it creeping at the edge of my thoughts.  I must've ran into a dozen of those green sluts and red little cretins as I traveled - not at the same time, of course...  Thankfully, my new shark-like body was stronger than before, so I was able to beat them all down when they tried to attack me.  I don't know why, but I headed for these mountains,</i>\" Minerva says, looking up at the broken ceiling of her tower.");
		outputText("\n\n\"<i>Of course, now I know it's fortunate that I did.  Had I not, I would absolutely have succumbed to this corruption inside me.  It was a growing and ready threat inside me, at that point already changing me physically, turning my feet into these clawed things, and my tongue into... well, this,</i>\" Minerva says, before opening her mouth and extending what looks to be a two-foot long demonic tongue.  Pulling it back inside, she continues.  \"<i>Thankfully, I was getting close to 'help,'</i>\" the siren says, before putting her hand below her chest, just under her rib cage.  \"<i>I kept climbing, kept trudging along.  It didn't take more than a few days for my food to run out.  It had to happen, of course, when I was reaching one of the highest points of the mountain.  I could have tried climbing back down, but I would probably have passed out from hunger by then and fallen off.  Luckily, I didn't have to decide, as a trio of harpies found me clinging to the side of the mountain.  With me having to hang onto the rock face, it was easy for the natural-born flyers to pluck me from the side and fly off.  Though, thanks to my size, they had to work together to carry me off to a nest, and like everything else in this world, it was easy to tell what they wanted from me.  As soon as they dropped me down, they were right on top of me again, pulling my clothes off and kissing me with this weird golden lipstick.</i>\" Minerva lets out a shiver at the thought of the experience.");
		outputText("\n\n\"<i>I have no idea what they put in that stuff, but it hit me fast, and in no time, all I could think of was fucking them.  It was like the shark girls all over again, but this time I was the aggressor.  I'm not sure how long the effects of those drugs lasted... at least a few hours, but by the time my head was clear enough to let me try and make a break for it, the three harpies seemed to have had their... fill of me...</i>\" she says, shaking her head at the unintended pun she just made.  \"<i>Anyway... since they were exhausted, I took the chance to get away.  Thankfully, those harpies had food... bags full of these big, gold-colored seeds.</i>\"");
		
		outputText("\n\n\"<i>I was so hungry I didn't care if they changed me.  So I dug in, eating the walnut-sized things one after another until I couldn't eat anymore.</i>\"  Bringing a wing into view, Minerva gently strokes the feathers.  \"<i>I grew these very soon after, sprouting right from my back as my arms were covered in these... sleeves of feathers.  It hurt to grow them, but it didn't really matter to me... I was full of food and had a way to get around more quickly.  I'd tried a few times to get the hang at first... and almost slammed into the mountain for my troubles!</i>\" she chuckles, remembering how dangerous it was.  \"<i>But eventually I got the hang of it; for the first time since I got here, it felt like I was truly free...</i>\"  Judging from the tone of her voice, you can tell she is getting close to the end of her tale.");
		outputText("\n\n\"<i>I must have flown for hours, the seeds I'd eaten getting burned off fairly quickly, leaving me starving again...  What is up with that, anyway?  Why is normal food so hard to come by around here?</i>\" she asks seriously, as if it has been on her mind for a while.  Shrugging your shoulders since you really have no answer for her, you have to admit that you had actually been wondering that yourself.  \"<i>Well... with exhaustion, hunger, and corruption catching up with me, I finally could go no further and crashed onto a cliff side.  I could feel the corruption's warm, all-consuming grasp closing around me.  It was so tempting to give in and let it happen.  But as fate would have it, I landed on the rocks just outside this tower.  I hadn't seen it while in the air because of the mist.</i>\"  Smiling a little, the siren pats the soft moss that grows from the ground.  You can't help but notice the somewhat bittersweet look on her face.");
		outputText("\n\n\"<i>If I was going to become a monster, I at least wanted to have some shelter, so I went inside the tower.  That's when I found this place.  This... oasis of life... hidden away inside the tower.  I guess it was built as some kind of sanctuary, though it clearly fell into disrepair long before I found it.  This place turned out to be my... salvation...</i>\" she states and looks down again, her bittersweet expression deepening.  \"<i>As soon as I saw the fruit on the trees and the fresh water in the spring, I couldn't help myself.  Feasting with my corruption forgotten, I just gorged on the fruits and water and, with each bite, each drink, I felt the corruption recede.  My mind and thoughts became more clear - clearer than they had been in a long time, too.  This place is blessed!  It didn't get rid of the corruption entirely, but it calmed it, made it less pervasive.  I was happy to be more or less back to normal, but... I knew I could never really leave this tower as, if I did, the corruption would just come back.  This place, while beautiful, is my prison, my... gilded cage,</i>\" she says sadly.  You can only imagine it, being on the brink of turning into a monster, only to be saved at the cost of your freedom.  To be safe, fed, and sane, but unable to leave, lest the corruption returns to consume you.  This fact is clearly the source of the bitterness so clear on her face and in her voice.");
		outputText("\n\nReaching out to her, you put an arm around her shoulder, trying to make her feel better.  It seems to help, as the look on her face visibly changes, a tiny smile resurfacing.  \"<i>Thank you for listening to my story; I know it was long and boring,</i>\" she says with a chuckle.  \"<i>You're the first sane person to visit me.  Sometimes, harpies come and try to get me to fuck them... it might even be those same harpies from before... anyway, I just want to tell you how much I appreciate you coming to visit me like this,</i>\" she explains with a genuine smile.  The siren leans in to give you a small peck on the cheek.");
		//No Romance: 
		if (!minervaRomanced()) outputText("  \"<i>You're a good friend to have, and you know that, [name].</i>\"");
		//Romance:
		else outputText("  \"<i>You're a wonderful lover, you know.  I couldn't be happier that you found me.</i>\"");
		// PC returns to camp.
		flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] = 1;
	}
	doNext(camp.returnToCampUseOneHour);
}


//3-2 Talk Scene 2 - talks about the spring  
//-repeatable
private function talkAboutTheSpringWithMinerva():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-talk-spring"), false);
	outputText("Telling Minerva that you want to sit down and talk brings a pleasant smile to her face. The siren is more than happy to talk with you.  \"<i>Really?  You want to talk with me?  All right, well, what do you want to know?</i>\"  she asks as she sits down, cross-legged on the soft, pillowy moss across from you.  Looking at the spring, you feel an inkling urging its way up from inside you, and riveting questions begin to form in your mind.  Minerva has been here for a while... maybe she knows something about it?");
	outputText("\n\n\"<i>The spring?</i>\"  Minerva questions, before looking over at its pure waters. \"<i>Well... truth be told, I don't really know much about it.  I know it has special properties, though.  Over time, it can reduce the corruption of anything in it, and it makes the soil very fertile, helping plants grow abnormally quickly.  It can even bless a weapon with special properties, like how my own halbard wounds the corrupt,</i>\" she says, sighing.");
	outputText("\n\n\"<i>I'm sorry, I just don't know all that much about it.  The only other thing I really know, is that it's the only thing that keeps me from succumbing to the corruption.  Well, that, and it feels really nice to swim in it!</i>\" she states with a grin, before looking back at you.  \"<i>Hey, you know, would you want to go for a swim with me?  It'll be fun!</i>\"  she exclaims, a hopeful look painted on her face.");
	
	outputText("\n\nThinking about it, you decide you could use a dip.  Getting up from the ground, you strip off your [armor] and jump into the pool.  Seeing how eager you are brings a smile to Minerva's slightly angular face, the tainted herm jumping up and fervently stripping as well, before hopping into the water with an energetic splash.");
	
	outputText("\n\nThough the water isn't all that deep, only about four feet, you splash around and swim with the shark-like harpy.  Minerva playfully splashes water at you with her tail, laughing.  You play and swim, unable to help but look the curvy siren over.  With her womanly body drenched in water, her toned features have grown much more defined.  Seeing you stare gives Minerva a kinky thrill.  With a toothy grin, she spins in the water and strikes a pose for you, the water beading down her naked body.");
	outputText("\n\nGrinning back at her, you reach out to try to grab the teasing siren, only for her to spin away from your grasp and splash through the water to escape you, her delightful rump swaying as she wades through the water.  Not willing to just let such teasing go unanswered, you give chase, sending water in every direction.  Your games last for a while, both of you splashing around and playing until, at long last, you're both tired and revert to simply lying on the soft moss together.  \"<i>This was fun!  I'm so glad you came to visit,</i>\" Minerva tells you, before rolling onto her stomach and resting her head on her hands, watching you.");
	outputText("\n\nThe two of you rest for a while, and can't help but enjoy each other's company.  You idly make small talk before deciding that it's time to take your leave.  Putting your [armor] back on, you gather your things with Minerva watching, mildly upset that you have to leave so soon.  \"<i>Thank you so much for coming to visit!  I had a lot of fun.  Now, don't be a stranger, you hear?  Come back and visit again soon!</i>\"  she says, before sitting up and tossing you one last smile.");
	outputText("\n\nReturning her shining smile, you promise to come back and visit soon, then head out and start the hike back toward your camp.");
	// PC returns to camp.
	dynStats("lus", 10+player.lib/10);
	doNext(camp.returnToCampUseOneHour);
}

//3-3 Talking Scene 3 - talks about her shark girl daughter
private function talkWithMinervaAboutSharkGirlDaughter():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-talk-sharkgirl"), false);
	//- requires that backstory has been told
	//- if already romanced Minerva shamefully confesses she may have fathered a granddaughter with her first daughter -repeatable
	outputText("Telling Minerva that you want to sit down and talk brings a pleasant smile to her face. The siren more than happy to talk with you.  \"<i>Well, since you came all this way to see me, I guess we could talk</i>\" she says playfully.  \"<i>All right, what do you want to know?</i>\" she asks as she sits down cross-legged on the soft, pillowy moss across from you.");
	outputText("\n\nRemembering your past conversations with Minerva, she briefly mentioned that she had birthed a shark girl; it seemed like a sensitive topic to her, though, and you didn't broach the subject.  Really wanting to know more, you ask about this daughter of hers.");
	
	outputText("\n\nHearing you ask about her daughter brings a bittersweet smile to Minerva's face and she looks away from you.  \"<i>I... that's a very sensitive topic... I'm not sure how far I'll get into it.  She was such a sweet girl, so lively and playful.  I remember the day she was born.  As you know, it wasn't my first time giving birth, but this one was much more serious.  She was much bigger than that anemone thing I birthed... you should have seen her.  Big red eyes, so bright with wonder as I held her in my arms - I had never seen such a cute little girl, even though she was a shark girl,</i>\" Minerva says with a bright smile as she remembers her daughter.  Hearing her describe it like this, you can't help but grin at the tender scene the siren is painting for you.");
	outputText("\n\n\"<i>I'm sure you've noticed things grow up quickly in this world, and she was no exception.  When I fed her for the first time, she grew up right in my arms, not stopping until she was about the size of a preteen or maybe a very young teenager.  She would follow me everywhere, the adorable little sweetheart... always hanging onto my tail so she would never lose her mommy,</i>\" Minerva tells you with a giggle, and you have to admit, it would have been an cute thing to see.");
	
	outputText("\n\n\"<i>The little one would never leave my side, and I had never been a mother before, so I did the best I could... I played with her, kept her well-fed and taught her all that I could about how to feed herself, how to defend herself and to be wary of her surroundings at all times.  Like a sponge, she absorbed it all.  I really wish I could have had more time with her...</i>\" the siren says, sadness bleeding out into her smile.");
	
	//No romance:
	if (!minervaRomanced()) outputText("\n\n\"<i>I think that's enough for now...  I would rather not get into it any further...  It gets... bad after that.  Thank you for listening, though.  Perhaps, some day when we are more familiar, I think I could probably tell you the rest.</i>\"  With her being reluctant to continue, you decide it's time to go.  Saying goodbye to the siren, you leave the tower and head back to camp, leaving Minerva to her thoughts.");
	//Romance: 
	else {
		outputText("\n\n\"<i>I may have told you this already, but there was an incident between us.  She grew up so fast, I didn't expect her become an adult in only a few months.  It... it was such a shock to me; I had no idea she would grow that quickly.  If I had, I would have established proper boundaries...</i>\" she says, looking down and sighing.  \"<i>I guess it could've had something to do with her shark girl nature, as well, the ones I encountered always were sexually aggressive creatures, especially when it came to breeding,</i>\" Minerva notes with a sigh and a sour look on her face, clearly not happy with how things went with her daughter.");
		outputText("\n\n\"<i>It's my own fault for not doing enough, for not being strong enough to resist her and failing to teach her properly before it got to that point.  She came to me one night, claimed she was ready to be an adult.  She needed me to get her pregnant so she could be a mother in turn... and something... I just couldn't resist her.  We had sex... a lot of sex, at that.</i>\"");
		outputText("\n\n\"<i>Once she seduced me, I couldn't hold back.  She sucked me off, rode me, I plowed her so hard in my lustful haze, and I had to have cum inside her at least half a dozen times that night.  With how needy and fertile those shark girls are, I know I got her pregnant.  How shameful is that?!  I knocked up my own daughter and probably have a granddaughter that I fathered!</i>\" the siren declares sorely, her voice lined with regret and shame for her actions.  \"<i>I'm sorry for yelling, love, I just miss her.  I wish we hadn't parted on those terms.  One day though, I'll see her again... maybe get another chance at being a proper mother,</i>\" she says with a final sigh before looking you in the eyes and hugging you.");
		outputText("\n\n\"<i>Thank you for listening to me, hun, I'm so happy to have someone like you in my life,</i>\" Minerva whispers to you with a genuine smile on her black lips.");
		outputText("\n\nThe two of you stay like this for a while, just spending a little time together before you decide you must return to camp and your quest.  Saying your goodbyes, you give Minerva a kiss before heading home.");
	}
	doNext(camp.returnToCampUseOneHour);
}


//3-4 Talk Scene 4 - talks about her corruption
//- romance yes only or if you trick her into thinking you love her. - Repeatable until Minerva is purified or corrupted
private function talkToMinervaAboutHerCorruption():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-talk-corruption"), false);
	outputText("Telling Mineva that you just want to talk brings a smile to her face, the siren eager to speak with you.  Guiding you over to a soft spot of moss by the spring, she sits next to you and looks into the pond, her smile slowly fading as she looks into the clear waters.");
	outputText("\n\nLooking at her, you notice her sad expression and ask what's bothering her; she looked happy just moments before, what could be troubling her now?  The tall redhead looks over at you before sighing and turning around to face you.  She puts a hand to her chest and holds it there.  \"<i>What I'm about to tell you... is very personal to me.  It's the reason I'm here, the reason I can't really leave this place,</i>\" she says as she looks you in the eyes, clearly quite serious about this.");
	outputText("\n\n\"<i>There is something inside me.  I told you how I came to be here, about how the demons attacked me.  Well, it's obvious I didn't escape unharmed.  There was this little demonic creature that attached itself to me.  It  burrowed inside me.  It's in here right now,</i>\" she finishes, tapping her midriff, above her stomach and under her breasts.  \"<i>Sometimes, I can feel it... squirming...  It's the reason for my corruption and why it won't just go away.  This thing just keeps pumping its corrupting influence into my body; it's probably doing all kinds of other stuff I don't know about, too...</i>\"");
	outputText("\n\nYou look at her with wide eyes, your gaze automatically shifting to her chest where her hand is.  Quickly noticing your look, she turns away, a little embarrassed that you're just staring at her chest.  \"<i>Anyway.  It's this thing that binds me here; it's why I need to consume the blessed water and fruit of this grove.  At one point, this corruption made me do things I feel great shame for...");
	//PC told about shark daughter: 
	if (flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] == 1) outputText("  You remember my firstborn, the shark girl I had?  Well... not long after she reached maturity, she... well, she got a bit amorous...  She seduced me and I... I mated with her.  I mated with her over and over that night.  I enjoyed it... it was like I couldn't get enough...  I probably got her pregnant...  So shameful...  I impregnated my own daughter and made her bear my grandchild,");
	outputText("</i>\" she declares sourly as she stares into the pure waters of the spring.");
	outputText("\n\nYou put a hand on her shoulder, inquiring about the nature of the creature, but your siren companion can only shrug in answer.  \"<i>I don't know.  Considering the demons, it's likely it was supposed to corrupt and mutate me into some foul, twisted beast of rape and pleasure...</i>\"  Minerva looks to you, her eyes soft and full of emotion.  \"<i>I want to be free of this curse.  It's my greatest wish, even more than having a true family of my own.  I want to be pure, to be clean.  I want this creature exiled from my body and myself to be purged of this corruption...</i>\"");
	outputText("\n\nCuddling up to you, the siren slips her arms around you, hugging you tightly.  \"<i>Thank you for listening to me, hun, I'm so happy to have someone like you in my life,</i>\" Minerva whispers to you with a genuine smile on her black lips.  \"<i>Sharing one of my hopes and dreams like that, I can't help but feel closer to you.</i>\"");
	outputText("\n\nThe two of you stay like this for a while, just spending some time together, before you decide you must return to camp and your quest.  Saying your goodbyes, you give Minerva a kiss before heading home.");
	flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 1;
	// PC returns to camp
	doNext(camp.returnToCampUseOneHour);
}

//3-5 Motherhood
//-talks about how she wishes to be a real mother, have an actual loving family and not made from being raped- repeatable
private function minervaMotherhood():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-talk-motherhood"), false);
	outputText("Telling Minerva that you want to sit down and talk with her seems to astonish her; she certainly didn't expect you to just want a chat.  After her initial surprise, she smiles pleasantly.  \"<i>Really?  You want to talk with me?  All right, well, what do you want to know?</i>\"  she asks as she sits down cross-legged on the soft moss across from you.");
	
	outputText("\n\nYou rack your brain trying to think of what to talk about.  Unable to really think about anything important to discuss, you lean back and relax, deciding that you could talk for once - instead of just listen - about random things you have seen.  You elaborate on the creatures you have encountered, the things that have tried to sexually assault you, knock you up or try to force you to impregnate them.  Perhaps she can learn something from your own trials and errors in this land.");
	
	outputText("\n\nThough happy to listen to you for a change, Minerva looks a little uncomfortable with hearing about the sex hungry monsters out there in the world. Nonetheless she pays complete attention to you, leans against the tree with her legs stretched out, her shark tail lying between her legs.  As you tell your tale to your siren ");
	if (minervaRomanced()) outputText("lover");
	else outputText("friend");
	outputText(", you can't help but notice how she becomes utterly entranced, how she seems to be clinging hungrily to every word of your story.  With such an attentive audience, it would be a shame not to embellish the truth, just a little.  And so, you begin weaving a story of how you once fought six minotaurs at the same time, each of them twelve feet tall and carrying huge axes.  It was a hard fight, most of your clothes were shredded from the fierce battle, and your body glistened with sweat as you stood over your fallen bestial foes.");
	
	outputText("\n\nWith your foes beaten, you saved a group of scantily clad damsels, a pair of goblins, a harpy, a shark girl, and even a busty cowgirl, each of them eager to thank their hero for saving them from the mean minotaurs that only wanted to rape them.  The silly story of your own bravado draws giggles and snickers from Minerva, completely absorbed with your fabrication, but whether she knows you're lying, you can't tell.  It's clear she is enjoying your story about bringing the thankful ladies back to your camp for a long night of impassioned loving, though.");
	
	//PC vagina:
	if (player.hasVagina()) {
		outputText("\n\nNot wanting to disappoint, you quickly think of another story to tell your ");
		//friend/lover
		if (!minervaRomanced()) outputText("friend");
		else outputText("lover");
		outputText(".  Without further ado, you weave a tale of how you saved a nice herm bee-girl from several of those nasty imps.  The little buggers were trying to rape the nice girl, and you couldn't just stand there and do nothing.  Taking it upon yourself, you beat those smelly imps into a pulp before carrying the grateful herm away.  To find a bee-girl that was a herm is a rare thing, indeed, and this one was just as pretty as her sisters.  She was so grateful for being saved from those little monsters that she gave you a mass of her honey and explained that she only wanted to find someone to have her eggs with.  Being the generous champion you are, you offered to help her out, flirtatiously pulling the curvy girl to you before kissing her.  That night, you spent your time with your grateful damsel, making love and having your womb and rear filled with sticky eggs and bearing the bee-girl's eggy babies for her.");
	}
	//PC cock:
	if (player.hasCock()) {
		outputText("\n\nRolling right into another story, you begin to tell Minerva about the time you fought three hundred goblins, yet another fierce battle, with them tearing your clothes off and trying to rape you for your seed.  They would cry, \"<i>We claim this pole for the horde,</i>\" but you wouldn't let them have it without a fight, raising your spear of impregnation, you thrust deep into their ranks, activating your mighty spear's life-giving magics, and flooding the enemy lines with rich, potent streams of power.  Your attack was successful, the thick goopy mess defeating the goblin horde temporarily; they always came back each time though, with greater numbers.");
	}
	outputText("\n\nWith your tale over, your audience claps excitedly, the lonely siren quite happy to hear such silly stories.  \"<i>Oh, that was wonderful!  You tell such great stories!</i>\" she says happily, her tail swaying between her legs.  \"<i>It was a lot of fun to listen to, even if it got a bit silly,</i>\" she says with a bright smile before looking down, and putting a hand on her toned, flat stomach.  \"<i>Those damsels");
	if (player.gender == 1) outputText(" and those goblins");
	//PC vagina: 
	else if (player.gender == 2) outputText(" and that bee-girl");
	//PC herm:
	if (player.gender == 3) outputText(", goblins and that bee-girl");
	outputText(", if the stories were real, I'm sure you gave them plenty of children.  I wish to one day have kids... to have a great, loving family to call my own.</i>\"");
	
	outputText("\n\nShaking your head, you grin and shuffle over to Minerva.  Sitting down with her, you");
	//Romance: 
	if (minervaRomanced()) outputText(" hug her tightly and kiss her cheek, telling her that she will have children one day, and perhaps you will have to see about helping her with that 'problem.'");
	//No romance:
	else outputText(" place a hand on her shoulder and give her a comforting smile before telling her that she will have that one day - you're sure of it.");
	outputText(" Hearing your words brings a smile to her black glossy lips.  \"<i>Thank you so much; that means a lot to me, really,</i>\" she coos, her hands gingerly stroking yours before pulling away.  \"<i>But... I guess we have been here for a while.  I'm sure you have a great deal of work to do as such a brave champion.</i>\"");
	
	outputText("\n\nLooking around, you see how late it has gotten and swiftly get up, Minerva's right; you have to get back to your great quest!  Looking at the siren one last time, you tell her that you will be sure to come and visit again later.");
	// PC returns to camp.
	doNext(camp.returnToCampUseOneHour);
}

//3-6 Bath Time - romance only
public function bathTimeTalkWithMinerva():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-talk-bathtime"), false);
	outputText("Telling Minerva that you want to sit down and talk with her brings a smile to her lips; she certainly didn't expect you to want to just chat, but is clearly happy to talk.  \"<i>Really?  You want to talk with me?  All right, well, what do you want to know?</i>\"  she asks, before looking off to the side, clearly distracted.  \"<i>You know... if you don't mind, instead of talking, we could take a bath together.  Relax and just spend some time together,</i>\" she says with a hopeful look on her face.");
	//[Yes] [No]
	menu();
	addButton(0,"Yes",bathTimeWithMinerva);
	addButton(1,"No",noBathTime);
}

//[No] // add and take to another talking scene
private function noBathTime():void {
	clearOutput();
	outputText("Looking down, she sighs, a brief moment passes before she returns her attention to you.  \"<i>Well, that's all right, maybe next time.  So you wanted to talk; what would you like to know?</i>\"");
	menu();
	addButton(0,"Next",minervaTalkSelect,false);
}

//[Yes]
private function bathTimeWithMinerva():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-bathtime"), false);
	outputText("Seeing how hopeful she is makes you chuckle; you have to admit, a bath with the curvy siren would be nice.  Nodding and agreeing to bathe together brings a bright, sharky smile to Minerva's face.  Her black, glossy lips split nearly ear to ear, showing how excited she is with your request.  \"<i>R-really?!  That's great!  Oh, I'm so happy,</i>\" she states joyously, suddenly blushing and playing with one of her long, orange-red bangs.  \"<i>I mean... Thank you, I was really hoping to spend some quality time together.</i>\"");
	outputText("\n\nWithout waiting, Minerva grabs your hand and pulls you to the spring, her excitement as clear as the lust on a goblin.  As soon as the two of you reach the edge, Minerva leaps into the spring... unfortunately for you, she didn't let go, instead yanking you into the water with her and soaking you - perhaps the blushing siren got a little <i>too</i> excited?");
	outputText("\n\nLooking back at you, Mineva gasps and lets go of your hand, obviously quite embarrassed by her actions.  \"<i>Oh, [name], I'm so sorry!  I guess I got a little carried away, didn't I?</i>\" she asks as she looks at you, her head turned down and to the side in her self-inflicted humiliation.  Letting out a sigh, you shake your head and smile before slowly removing your [armor] and placing your garments on the mossy side of the spring to dry.  As if mesmerized by you, Minerva watches you undress, her eyes glued to your form and trailing up and down your body, a dopey, lovestruck look on her face.");
	outputText("\n\nTurning around, you catch the peeping herm in her voyeuristic act, making her jump back and turn away from you.  \"<i>I... I'm sorry!  I couldn't help it... you just... you're... you look really good, is all...</i>\" she says with a stammer, you can't see it, but you're sure her face must be on fire by now.");
	
	outputText("\n\nStepping forward, you slide your arms around the tall, curvy herm and pull her against you, telling her not to worry about it, and to just enjoy the bath.  Your touch seems to work its usual magic, calming her nerves and making Minerva relax against you.  \"<i>Thanks, love... I just can't help myself when it's you...  You're rather sexy, if you didn't know,</i>\" she says playfully before turning around and pushing you back a little, giving you a sharky grin as she makes room for herself to strip.  Pulling her tight white tube top off, her short shorts come off right after, the skimpy clothes tossed to the shore and leaving her just as naked as you are.");
	outputText("\n\nWith both of you ready, you take the siren's hand and sit in the water with her.  It's cool and refreshing, though you could do with a hot bath instead.  As if sensing your thoughts, Minerva moves close to you.  \"<i>Watch this, hun, the spring reacts funny when I cast a white fire spell on it.  Makes for a lovely hot bath,</i>\" she says before focusing, casting an incantation into the water.");
	outputText("\n\nWhen no fire appears, you look at her and wonder if she made a mistake, however, your thoughts are interrupted when a deep warmth flows all around you.  The pure spring water grows lukewarm, then a gentle, pleasant warmth, before reaching the temperature of a hot, relaxing bath.");
	outputText("\n\nGrinning at her work, Minerva cuddles up against you in the now steaming water, and you certainly can't say you're not impressed with that little trick of hers.  Letting out a small moan of approval, both of you lay back and rest in the temporarily hot spring, just relaxing peacefully together, a simple affectionate pastime shared between two lovers.  Minerva holds onto you gently, and her bare breasts presses against your arm as one of her hands tenderly stroke your form, drawing a relaxed sigh from you.");
	outputText("\n\nEventually though, the heat fades and it's time for both of you to get out of the spring.  The affectionate siren helps you out of the warm water, even going to get you something to dry off with and helping dry you off.  As soon as you're dry, you find yourself wrapped up in a tight, squeezing hug, the blue and gray siren cuddling you tightly.  \"<i>That was nice, my love... really, it was wonderful,</i>\" she says as she looks at you, eyes locked on yours, clearly very happy to have shared that tender moment with you.");
	outputText("\n\nLeaning in, she gives you a gentle kiss on the lips before finally letting go of you.  \"<i>I wish you didn't have to go, but I understand that you must.  I'll miss you, you know?  Make sure you come back soon, all right?</i>\"  she asks, a sparkle of hope in her eyes.  Smiling back at the happy siren, you nod, reassuring the herm that you will come back as soon as you can, returning her embrace for a moment before turning and heading back for your camp.");
	// PC returns to camp.
	dynStats("lus", 10+player.lib/10);
	player.changeFatigue(-30);
	doNext(camp.returnToCampUseOneHour);
}


//SEX SCENES!!!!!!!!!
//PC Chooses Sex from Minerva's Options:
private function minervaSexMenu(display:Boolean = true):void
{
	if (display)
	{
		clearOutput();
		minervaSprite();
		outputText("You tell Minerva that, this time, you'd like to have sex with her.");
		//Default, first time:
		if (flags[kFLAGS.TIMES_MINERVA_SEXED] == 0)
		{
			outputText("\n\n\Minerva blushes and looks you up and down, looking a little nervous.  \"<i>Well... it's been a long time since I have been with someone, let alone someone who wasn't some domineering beast...  I guess it would be all right, some companionship would be nice...");
			//PC cock, add: 
			if (player.hasCock()) outputText(" just... not in my vagina, all right?  That's... special.");
			outputText("  Did you have anything specific in mind?");
			//PC female, add: "
			if (player.hasVagina()) outputText("  Would you mind how we do it?  You're the one asking, so... would you want me to fuck your ass?  Or... do you want me to try to fit between those sexy hips of yours?");
			outputText("</i>\"");
		}
		//Dick Too Big - PC exceed capacity
		else if (rand(2) == 0 && player.hasCock() && player.cockThatFits(minervaACapacity()) < 0)
			outputText("Looking at the monstrous mass of your mammoth member, Minerva blushes hard and stares at it with wide eyes.  \"<i>Oh... oh my, that... that's </i>big</i>... I'm sorry, I don't think that's going to fit inside me, how about we try something else?  I'm sure we can come up with something!</i>\"  Minerva says with confidence.");
		//{Repeated/No romance: 
		else if (!minervaRomanced())
		{
			outputText("\n\nMinerva blushes and looks you up and down, looking a little nervous to have sex, but seemingly more comfortable with the idea.  \"<i>Well, I suppose... last time was fun and felt really good, so why not?  Was there anything specific you wanted to do?");
			if (player.hasVagina()) outputText("  Since you don't seem to mind... would you like me to fuck your ass or to squeeze into your cute cunny?");
			outputText("</i>\"");
		}
		//Romanced: 
		else
		{
			outputText("\n\nMinerva blushes and smiles at you, looking pleased that you're eager to spend some quality time with her.  \"<i>Sure, love!  I always have fun when we lie together, and I could use some of our quality time.");
			//PC cock, add:
			if (player.hasCock()) outputText("  Since we're together, I'll even let you have my pussy, I bet you like the sound of that!");
			//PC female, add:
			if (player.hasVagina()) outputText("  I'd be happy to pound that cute butt of yours and stuff your hot pussy - which would you rather have, my dear?");
			outputText("</i>\"");
		}
	}
	menu();
	var btnIdx:int = 0;
	if (player.hasCock() && player.cockThatFits(minervaACapacity()) >= 0)
		addButton(btnIdx++, "FuckHerButt", fuckMinervasAsshole);
	if (player.hasCock() && player.cockThatFits(minervaVCapacity()) >= 0 && minervaRomanced())
	{
		addButton(btnIdx++, "FuckCowgirl", minervaCowgirlSex);
		addButton(btnIdx++, "RestrainFuck", fuckMinervaWithHerHandsBehindHerBack);
	}
	addButton(btnIdx++, "TakeHerDick", chooseVagOrAss);
	addButton(btnIdx++, "EatHerOut", goDownOnAHermAndLoveItYouDirtySlutYou);
	if (player.hasCock())
		addButton(btnIdx++, "Get BJ", letMinervaSuckYouOff);
	addButton(14, "Leave", genericMenu, true);
}

//4-1= sex scene 1 male/herm:  Anal
//-pc pushes Minerva down onto her chest ass up and fucks her ass = needs penis
private function fuckMinervasAsshole():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sex-analpitch"), false);
	var x:int = player.cockThatFits(minervaACapacity());
	if (x < 0) x = player.smallestCockIndex();
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText("You give her a smile and place a hand on Minerva's thigh, gently pushing to indicate she should get down on all fours.  The redheaded siren looks at you for a moment before nodding.  Slipping her tight, short shorts down her legs and tossing them aside, she gets down onto her hands and knees, as it is obvious what your intentions are.  Spreading her knees apart, Minerva lowers her chest and pushes her curvy rump up, presenting herself to you.");
	outputText("\n\nYou smirk and step forward, reaching out to appreciatively squeeze her firm, plump ass, then draw back a hand and give a playful slap to the nearest of her spankable cheeks, the sudden spank drawing a sharp squeak of surprise from the shark-like harpy, looking back at you with a blush on her face, a little embarrassed, but appreciative of the sentiment.  Lifting her long, sharky tail out of the way, she sways it from side to side before curling it gently around your back.  Pushing her rear back and bumping her ass against your hips, she's giving you a clear sign that she's ready.");
	
	outputText("\n\nUnfortunately for her, you're not yet ready.  Wanting to tease the herm a little more, you run a hand between her legs, feeling the slipperiness of her arousal, and her cool, wet sex spreading to your fingers.  Your touch sends shivers of pleasure through the waiting siren.  \"<i>Mm... teasing me still?  So mean... are you going to make me beg for it?</i>\" she asks with a heavy blush on her face, her tone clearly playful.  Bringing your hands up, you grab the lovely blue and gray cheeks of her ass.  If you're going to be fucking her butt, you want to get it good and sensitive.  Squeezing and kneading the firm rear, your hands work it like stubborn dough, getting it ready for the next stage.  You let go and you raise one of your hands above her blue rump before coming down on it, spanking her hard and drawing out a loud squeak of pain and kinky arousal.  You keep spanking the herm over and over, painting hand print after hand print across the firm round cheeks, each naughty hit making Minerva more aroused, more ready for you to take her.  \"<i>P-please... I can't take it!  I feel like I'm going to burst!</i>\" she howls, almost pleading for you to finally take her.");
	
	outputText("\n\nWell, no sense in keeping a lady waiting, right?  You slip down the lower parts of your [armor] until your crotch is bare, exposing [eachCock]");
	if (player.hasVagina()) outputText(" and your [vagina]");
	outputText(" to the open air.");
	outputText("\n\nFeeling Minerva's bare ass rubbing against you helps coax your ");
	if (player.cockTotal() > 1) outputText("shafts");
	else outputText("shaft");
	outputText(" to erectness, and you begin to teasingly drag [oneCock] through the crack of her curvy, spankable ass, hesitating to actually penetrate her until you're ready.  Your vexation brings a brighter blush to her cheeks, her tail squirming gently against you as she takes the hint.  Her hips start pushing back and forth, using her soft rounded rump to massage [eachCock], wanting to get you just as needy as she is.");
	
	outputText("\n\nDeciding that you've finally teased her quite enough, you drag your " + player.cockDescript(x) + " down through the crack of her ass one last time, then align your " + player.cockHead(x) + " with her tight, puckered asshole.  You ask her if she's ready for this, if she's ready to have her ass filled by your throbbing cock.  She nods her head, looking back at you with her bright, blushing face, her eyes locking onto yours as she spreads her knees a little further apart.  \"<i>I... yes, I'm ready, don't be too rough, all right?</i>\"");
	
	outputText("\n\nDrawing your [hips] back and sinking your fingers into her squeezable butt, you begin to push forward into her back passage.  It's surprisingly cool, perhaps because of the shark essence in her blood.  Her throbbing anal walls are slick enough to let you slip in easily, but grip tightly around your " + player.cockDescript(x) + ".  The inner muscles tighten around you and let you feel dozens of tiny, smooth bumps lining the passage inside.  Minerva's walls ripple and massage you as you finally bury yourself to the hilt inside her, groaning in pleasure at her tight anal embrace.");

	outputText("\n\nMinerva bites her lip and pushes her hips back as you push in, doing her best to keep her body relaxed until you're all the way inside before clenching her muscles around you rhythmically.  The siren slowly starts shifting her hips around, trying to make it feel better for you as you slowly stretch her unused anal passage.  \"<i>Nnn... it feels good, so good.  I'm... not used to this, so I should be pretty tight for you,</i>\" she playfully says before pushing back and grinding her hips against yours, while squeezing her tight ass muscles around your cock.  Between her legs, Minerva's tentacled dick rises to attention, its thick length throbbing with her arousal.");
	
	outputText("\n\nYou draw yourself back, dragging your " + player.cockDescript(x) + " inch by inch through her grinding, squeezing walls, then thrust yourself firmly back inside her.  You repeat the process again, and then again, picking up speed as you pull and push.  The siren's lyrical moans slowly start to fill the air, her body rocking with your thrusts, pressing and grinding her pierced nipples against the ground as you pound her slick rear.  The longest of her cock tentacles manage to reach back and grabs hold of your " + player.cockDescript(x) + ", feverishly stroking you as you thrust into her.  The naughty little things sting you hard, oozing their aphrodisiac venom into your " + player.cockDescript(x) + " instinctively.  You cry out, shivering as the potent venom immediately streams through your body, setting your blood aboil with lust, and causing you to piston into her ass with ever-increasing speeds.  More and more toxin floods you, combining with the incredible sensations of her anal walls gripping and squeezing you to turn you into a mindlessly rutting beast.");
	
	outputText("\n\nYour suddenly increased pace and new brutal thrusts cause the siren to grit her teeth and clench the soft moss in her fingers.  A long, throaty groan is pulled from her, clearly enjoying the rough treatment you're giving her.  \"<i>Ahh-ahh... I'm sorry, I can't help it.  My tendrils have a mind of their own... it feels so good, oh fuck!</i>\" she moans between gasps, her tail tightening around you to keep hold of you.");
	
	outputText("\n\nYou can't take it any more and, with a cry, unleash your seething, frothy seed into the siren's waiting bowels.  The intense, rough fucking and the feeling of your sweltering seed flooding her bowels sets her off as well, the siren's orgasm bursting around you.  The siren's tight, slick inner walls squeeze around you as her own member blows its load onto the mossy ground.  Minerva's fat phallus throbs and pulses hard, her thick cumvein bulging as it spews its copious load, making a slick, thick puddle beneath her.");
	
	//Moderate cum or less: 
	outputText("\n\nYou keep gushing into her until totally spent, her innards swallowing your load without the slightest effort.  \"<i>Ahhh... please, let it all out, give me every drop you can muster!</i>\" she groans loudly as her tail squeezes around you, not wanting you to leave her body, her tight anal muscles squeezing you so tightly, trying to suck everything she can from your cock.");
	//High cum: 
	if (player.cumQ() >= 1000) outputText("  Your unnatural orgasm keeps pouring into her guts, flooding her interior with sticky cum.  By the time you give out with a gasp of effort, her stomach is visibly bulging, swollen from the amount of cum you have filled her with.  \"<i>Ooohhh... fuck... so much...  It looks like I have a baby in there,</i>\" Minerva says with a long, drawn out groan, unused to the feeling of having her guts filled up by such hot, thick stuff.");
	//Very High cum:
	if (player.cumQ() >= 5000) outputText("  Your freakish orgasm continues seemingly without end, cascades of jizz pouring into her bowels and through them to her stomach, \"<i>Oh gods... oh gods...  S-so much... how are you cumming this much!?</i>\"  You keep cumming though, the sheer quantity resulting in a buildup of pressure that sends yet more of your spunk spurting out from her curvy backside.  Finally, when you have finished, Minerva's belly is so swollen that she looks like she could give birth any moment, the creamy sperm inside her softly sloshing around.  \"<i>Fu... fuck... h-how... s-so much cum...</i>\" Minerva babbles as a trail of white slowly drips from her drooling mouth before she swallows it back, \"<i>I-I think I can taste it.  I've never felt so full in my life...</i>\"");
	
	//Low to moderate cum volume: 
	if (player.cumQ() < 1000) outputText("\n\nPanting from the rough ass fucking she just received, Minerva slumps forward and sighs, her tail pulling you down on top of her smooth, sweaty body.  \"<i>That... that was good, it felt really good...  You know, we could do that again sometime, if you want to,</i>\" she says before slowly moving and pulling her hips away from yours so she can turn to face you, putting her arms around you for some after-sex cuddling, the blue and gray siren nuzzling your neck gently before giving you a peck on the neck.");
	//{High to moderate cum volume: 
	else if (player.cumQ() < 5000) outputText("\n\nGroaning from being filled so much, Minerva puts a hand on her now swollen belly and pushes, clearly feeling the thick stuff sloshing around inside, her belly giving a soft gurgle from being so stuffed.  Sighing, she props herself up before slowly pulling her hips forward to get you out, then turning and pulling you close for some after-sex cuddling, the sweet blue siren nuzzling your neck before giving you a little peck.  Now that you're not plugging her up, your copious load gushes from her stretched rear, oozing down her round ass and pooling under her flared thighs.");
	//Very high cum volume:
	else outputText("\n\nGasping and gurgling softly, Minerva does her best to hold in the veritable pond of jizz you shot into her.  Her hands keep running up and down the huge, swollen belly she has now, clearly amazed that she was able to withstand such a ridiculous stuffing.  Swallowing again, she slowly pulls away from you, clearly needing to let off the pressure.  As soon as your " + player.cockDescript(x) + " is free, like a cork from a overpressured bottle, your belly packing load bursts from her body, soaking your pelvis and her legs in thick, white cream.  Sighing in great relief, Minerva turns toward you and pulls you into a gentle after-sex cuddle, her lips brushing against your neck as she gives you a gentle peck.");
	
	outputText("\n\nYou allow Minerva to hold you against her toned body, recovering your strength from the draining sex.  Eventually, though, your strength returns and you gently pry yourself free of her, telling her that the sex and her company was wonderful, but that you need to return to camp.");
	
	if (!minervaRomanced()) {
		//First time ending:
		if (flags[kFLAGS.TIMES_BUTTFUCKED_MINERVA] == 0) {
			outputText("\n\nMinerva actually seems a little sad that you're leaving.  \"<i>I guess you are a busy person.  But I'm glad we did this; it was a lot of fun.  And... you know... I wouldn't mind if we did this again soon...</i>\" she says with a small, hopeful smile on her face.  You promise her that you'll try to come back again soon.  Though looking nervous, Minerva approaches you and pulls you into a hug, happy that you at least say that you will return to visit.");
		}
		//Repeated ending:
		else {
			outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren.  \"<i>Well, if you have to go... come back soon, though; we can do this again, if you want.  I know I've enjoyed our encounters,</i>\" she explains with a genuine smile on her slightly angular face.  You promise her that you'll try to come back again soon.  Clearly happy with your promise, Minerva pulls you into a hug, giving you a small peck on the neck before sending you on your way.");
		}
	}
	else {
		outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face.  \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.  The gentle herm pulls you into a deep hug before engaging you in a tongue-tangling kiss.  Grinning ear to ear, Minerva finally lets you go, albeit reluctantly, allowing you to leave her tower and return to your camp.");
	}
	//PC returns to main camp menu
	flags[kFLAGS.TIMES_BUTTFUCKED_MINERVA]++;
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//4-2= sex scene 2:  Cowgirl
//normal/pure  - Cowgirl position, Minerva on top needs penis.
private function minervaCowgirlSex():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sex-cowgirl"), false);
	var x:int = player.cockThatFits(minervaVCapacity());
	if (x < 0) x = player.smallestCockIndex();
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText("You look the attractive siren up and down and");
	if (player.tallness <= 60) outputText(", with some trepidation, given the difference in size,");
	outputText(" ask if Minerva would like to give her female parts some pleasure, promising to allow her control of the pace.");
	//First time:
	if (flags[kFLAGS.TIMES_MINERVA_COWGIRLED] == 0) {
		outputText("  Minerva looks unsure, the siren biting her lip and looking a little away from you, \"<i>I don't know.  That's... special...  After the things I have been through, I don't want to just do it with anyone.  You... </i>have<i> been really nice to me though... I guess I can trust you.</i>\"");
	}
	//Repeated:
	else outputText("  Minerva runs a hand through her hair and smiles, \"<i>Well... the last time was quite nice, I think it could be fun.  Sure, let's do it.</i>\"");
	
	outputText("\n\nWith a smile, you gently remove your clothes and put them aside, giving Minerva a chance to see your naked body.  Your " + player.cockDescript(x) + " already starting to stiffen, you lie back down on the ground, patiently waiting for the siren to make the first move.  You don't have to do so for long, as soon, Minerva's tight tube-top and short shorts are pulled off, her firm, pierced DD's bouncing free of their fabric prison.  Clearly excited by the thrill of actually having regular sex, you can see her male endowment quickly growing hard between her legs, the forearm-length appendage ready to go despite the fact it won't be used for the main event.  Looking down at you, Minerva approaches, swaying her hips to and fro.  She kneels down, crawling over you like some predator, one of her hands briefly stroking your " + player.cockDescript(x) + " before sliding up to feel your [chest].  \"<i>I promise not to get too excited,</i>\" she says before grabbing hold of your maleness and stroking it again.  Bringing her own male organ up against yours, her tentacles encircle your " + player.cockDescript(x) + ", stinging it with her potent venom to really get you fired up as she teases you.  \"<i>This stuff is always floating around in me - that's why I get so damn hard so fast...  I hope you like my special venom.</i>\"");
	
	outputText("\n\nYou groan softly, feeling the venom already coursing through you.  Your " + player.cockDescript(x) + " surges erect, the venom-induced lust making you swell larger than usual, ready for her to do with as she pleases, your limbs numb and useless from the lust-inducing toxins coursing through your body.  You are completely helpless and at her mercy...  And part of you seems to like that.");
	
	outputText("\n\nMinerva seems to enjoy seeing you helpless like this, as her dick seems to just get harder and harder while her tentacles caress your member, though they no longer sting; instead, they just tease you with their slick and gentle touch.  \"<i>You like that, don't you?  You're so hard I can feel your need growing more and more.  You want my tight pussy so badly,</i>\" she says with a lecherous grin before rising her body up and pressing against your " + player.cockDescript(x) + " with her surprisingly cool cunt.  Already her lips are soaked, her slick juices running down your dick as she teases you even further.");
	
	outputText("\n\nFinally, she ends your torment and brings your " + player.cockHead(x) + " to her refreshingly wet entrance before pushing down, letting you penetrate her with agonizing slowness, her longer tentacles still stroking and caressing your length as she pulls you into the vicelike grip of her snatch.  Inside, you can feel smaller tendrils starting to caress and squeeze you, clearly another trait she was gifted with from the shark girls.");
	
	outputText("\n\nYou moan in delight, shivering from the sensations and the lingering effects of her toxin, and unconsciously start to thrust your hips up, trying to push yourself deeper inside her wriggling depths.  Minerva, however, will have none of that and promptly pushes you back down, using the advantage of her position and strength");
	if (player.tallness < 96) outputText(", as well as her superior size,");
	outputText(" to keep you pinned under her.  \"<i>Oh, no you don't, this is my time... and you seem to be in no position to stop me from making this last.  Don't worry, though, I'll make you feel so good,</i>\" she says as her groin and vaginal tentacles caress and tease you.  She starts slowly pushing her temperate cunt down, the hundreds of little cilia squirming around your shaft as her tight inner muscles squeeze down on you like a cool, silken vice.  Her inner cilia only help to tease and pleasure your lust-fueled cock even more as the surprisingly dominant siren slowly eases herself down your swollen, venom-bloated dick.");
	
	outputText("\n\nYou moan and shudder, shivering violently as Minerva's poisons boil through your blood and countless tendrils stoke your lust to a fever pitch.  Your brain seethes and roils with pleasure as you are surrounded, engulfed.  You don't think you can hold back from cumming for very long, and gasp a warning to the siren that you will cum inside her if she isn't careful.  Clearly hearing your response, a sinister grin grows on Minerva's face as two of her longest and strongest tentacles wrap around the base of your " + player.cockDescript(x) + " and squeeze tightly, \"<i>Ah-ah-ah... no cumming for you, not until I get mine... I'm the one in charge, here, remember?</i>\"");
	outputText("\n\nYou can't help but beg and plead for her to show mercy on you, you can't bear this much longer!  Unfortunately for you, the only response you get from Minerva is a smirk, and the tentacles tightening around your throbbing maleness as she draws you in deeper.  The venom and the aggressive treatment makes your dick swell even more, stretching her tight squirming walls around you, the sensation drawing a sharp gasp and soft moan from your siren lover.  The siren's balls come to a rest just above your " + player.cockDescript(x) + ", the heavy, swollen orbs a reminder that she is enjoying this just as much as you.");
	
	outputText("\n\nBiting her lip, she pushes down harder, sinking her soothingly cool pussy down until your whole cock is engulfed in her tight, cilia-filled snatch.  \"<i>Mmm, oh yesss... don't you just love how your " + player.cockDescript(x) + " stretches me... and all those little things in there, stroking you like little tongues.  Tell me how much you need to cum.  Tell me and I'll let you blow your pent-up load deep inside me.  I doubt you could get me pregnant, I'm probably too unstable to breed with someone like you.  Or maybe you'd like to take a gamble and try?  Do it, fill my pussy with your cum!</i>\"");
	
	outputText("\n\nYou plead with her, begging her to let you cum.  You NEED to cum, you feel like you're going to burst!  You ache for relief.  \"<i>Please, let me release myself into your womb!</i>\" you cry out to her.  Licking her lips in anticipation, Minerva lets go of your dick, her cum-blocking tentacles relaxing around you and letting the pressure off of your swollen prick.  With a hollow groan of release, you unleash everything you have into her, flooding her waiting womb with your spooge.");
	
	//Low-moderate cum:
	if (player.cumQ() < 500) {
		outputText("\n\nMinerva shivers in delight as your seed bursts into her tight, hungry cunt, the tightness of her walls making sure not a drop is wasted.  The hundreds of cilia squirm around,  drawing your cum up and into her waiting womb, \"<i>Yesss... let it all out, let me feel your warmth in my belly.</i>\"");
	}
	//Moderate-high cum:
	else if (player.cumQ() < 4000) outputText("\n\nYour blissful release surges from you like froth from an over-shaken champagne bottle, gushing into Minerva's cunt with such eagerness that it barely needs her threshing cilia to draw it up into her belly, which becomes visibly bloated after your deposit.  \"<i>Oh!  Oh!  W-wow!  That... that's a lot.  So warm... I feel... so heavy now.  If I could, I bet you would have gotten me pregnant with all that,</i>\" she croons as she strokes her rounded, swollen tummy.");
	//Very high cum: 
	else outputText("\n\nThe idle thought that Minerva may have bitten off more than she can chew by holding back your orgasm races across your brain, but is scattered like dust on the wind by the bliss of release.  Minerva's belly explosively inflates as gush after frothy gush of copious spunk floods her womb, making it balloon out until it is lying on your own belly, heavy and full.  Minerva's eyes widen as her belly swells bigger and bigger, her trim, firm stomach soon appearing like she was carrying a whole litter of baby shark girls inside her.  Her hands gently stroke her huge, drum-tight belly, the massive load gently sloshing around in her womb.  \"<i>G-geez... how can you let out so much...  Oh gods... so much...  You could knock up a whole village with all this stuff.</i>\"");
	
	//Moderate-very high only:
	if (player.cumQ() >= 500) {
		outputText("\n\nNot nearly done, but needing to let off a bit of your load so the fun can continue, Minerva slowly rises from your " + player.cockDescript(x) + ", grinning as her tentacles make sure to sting you again, wanting to keep you hard and aroused so she can play some more.  The perky, cum-filled siren doesn't bother moving off of your body before pressing on her tummy and making a veritable flood of hot, thick cum pour from her tight, sharky cunt and splatter across you; she is going to be very well-lubed for the next stage of fun.  Squatting back down, she slowly licks her lips before sliding back down onto your, once again, venom-bloated dick, her tentacles getting ready to sting you some more for good measure.");
	}
	else {
		outputText("\n\nNot nearly done with you yet, Minerva squeezes down on you tightly with her exquisite cunt, her tentacles may have let go, but they are still squirming around, the playful things preparing a second dose of their potent payload.  \"<i>I'm </i>so<i> not done with you yet, I want this to be memorable.</i>\"");
	
		outputText("\n\nHeaving gasps of breath, you ask her what she has in mind.  \"<i>Mmm... well, I don't want you getting tired, so I'm going to go first...</i>\" she says with a grin as she runs her hands up your [chest].  The siren's tentacles slither over");
		if (player.balls > 0) outputText(" your balls and");
		outputText(" the base of your " + player.cockDescript(x) + ", stinging you again and again like an overzealous jellyfish, pumping more of her aphrodisiac venom into your genitals in mind-numbing quantities.");
		if (player.hasVagina()) outputText("  A few even slither down into your [vagina] to sting you there as well, making sure you are, at least temporarily, turned into a sex-hungry beast.");
	}
	
	outputText("\n\nYou gasp and writhe, casting a desperate, pleading look at your lover to end your torment and let you be released at last.  With that predatory look in her eyes again, Minerva clenches her strong cunt-muscles around you once more, biting her lip and pressing against you as hard as she can.  Holding you down, she starts to raise her curvy hips and ass up and down, her round butt bouncing against you as she grips your dick tightly, her squirming cilia teasing you even as you're ridden by the lusty, dominant herm.");
	
	outputText("\n\nYou cry out and shake with the effort as your body dredges up a second violent eruption of spunk");
	if (player.cumQ() < 500) outputText(", Minerva's belly visibly bloated by the time you are finished");
	outputText(".");
	if (player.cumQ() < 500) {
		outputText("\n\nUndeterred by your orgasm, Minerva continues to bounce up and down, biting her lip as she hugs you tightly.  Curling her legs under you as she slams her hips down in her own orgasm.  She shudders as her climax fills her, her own forearm-length cock swelling and pulsing, a cool stream of siren sperm lancing out, flying well over you and splattering against moss and stone.  Panting and groaning, Minerva holds her swelling stomach, her hands running over the smooth, taut flesh and feeling how your creamy cum swirls inside her.  \"<i>Ooohh... you let out so much... Look at my belly all swollen... looks a bit like I'm pregnant,</i>\" she states with a soft, hopeful tone in her voice.");
	}
	//High:
	if (player.cumQ() >= 500 && player.cumQ() < 4000) {
		outputText("\n\nMinerva's belly almost doubles in size as your massive load adds itself to that which remained from the last orgasm.  Gritting her teeth, she groans as her middle is stretched by your huge sperm-filled load, \"<i>Oh gods, I feel so full.  You can really let it out, can't you?</i>\"");
		outputText("\n\nUndeterred by your orgasm, Minerva continues to bounce up and down, biting her lip as she hugs you tightly.  Curling her legs under you as she slams her hips down in her own orgasm.  She shudders as her climax fills her, her own forearm-length cock swelling and pulsing.  The cool stream of siren sperm lancing out, flying well over you and splattering against moss and stone.  Panting and groaning, Minerva holds her swelling stomach, her hands running over the smooth, taut flesh and feeling how your creamy cum swirls inside her. The thick viral load pooling in her swollen womb and making her bloated belly look positively pregnant. \"<i>Ohhh... Just look at how big you've made me, my belly so round, it's like i have a baby in my tummy... </i>\" she says with a gentle tone, clearly enjoying the fantasy of being pregnant");
		if (minervaRomanced()) outputText(" with your child");
		outputText(".");
	}
	//Very High: 
	if (player.cumQ() >= 4000) {
		outputText("\n\nYou don't know if Minerva could have safely held the entire contents of both this orgasm and the last.  Luckily, this time, she releases most of it to splash back down onto you, but even so, her belly swells rounder and fuller than before, reaching the bloated state of your last orgasm and then some.  Minerva gasps and groans in some discomfort as her belly swells more and more from your torrential flood of jizz, her tummy taut under the sheer amount of cum crammed into her womb.  Finally, to her palpable relief, her swelling stops as a pool of slick spooge forms underneath your bodies, \"<i>Ooohh...  How... how did you cum even more this time?  I gotta lay off the venom...</i>\"");
		outputText("\n\nUndeterred by your orgasm, Minerva continues to bounce up and down, biting her lip as she hugs you tightly.  Curling her legs under you as she slams her hips down in her own orgasm.  She shudders as her climax fills her, her own forearm-length cock swelling and pulsing.  The cool stream of siren sperm lancing out, flying well over you and splattering against moss and stone.  Panting and groaning, Minerva holds her swelling stomach, her hands running over the smooth, taut flesh and feeling how your creamy cum swirls inside her. Despite her eagerness and accommodating body, you just keep cumming inside her.  Your thick creamy seed fills her womb, forcing the poor baby breeder to swell larger under the pressure of your orgasm.  Your lusty lover groans and moans under the impossibly filling sensation of being stuffed so full of cum.  Thick rivulets ooze out from around your tight fleshy connection to pool around your ass and hips.  Despite her large bodies considerable capacity, you are simply too virile for her body to contain it all.  Even as your tremendous climax tapers off, both your's and Minerva's hips are soaked in your creamy baby batter.  The poor cum stuffed herm groans and slides her hands over her hugely swollen belly.  Her bright eyes looking down at her gravid form as she continues to stroke herself.  She seems to be lost in a rush of sudden maternal feelings at the sight of how big she's gotten.");
		if (!minervaRomanced()) outputText("  \"<i>Oohhh...I'm so... so big... It's almost like you've gotten me pregnant.</i>\"");
		else outputText("  \"<i>Oohhh... I'm so... so big... cumming so much, I didn't know you were so desperate to get me pregnant.</i>\"");
	}
	//Low-to-moderate: 
	if (player.cumQ() >= 500) outputText("\n\nSighing with satisfaction, Minerva leans down, her sperm-swollen tummy pressing against you and squishing her dick against your body.  It's easy to tell she very much enjoyed the sexual union you just shared.  Not yet pulling out, her tight cunt rhythmically squeezes you as she lies on top of you, her fingers tenderly stroking you.  The siren simply basks in the afterglow of sex.");
	//High: 
	else if (player.cumQ() < 4000) outputText("\n\nSighing and panting, Minerva rubs her jizz-bloated belly, looking positively pregnant.  She leans down, lying over you and caresses her belly against you.  It's easy to tell she very much enjoyed the sexual union you just shared, despite being so full of your cum.  Not yet pulling out, her tight cunt gently squeezes you while she lies on top of you, her fingers tenderly stroking you as she cuddles your body.  The siren simply basks in the afterglow of sex.");
	//Very high:
	else outputText("\n\nGroaning and shuddering from the intense sperm injection, Minerva looks down at herself, her hands gently squeezing her distended stomach, each squeeze making a bit of your frothy cream gush out from between the tight vaginal connection.  If she wasn't so tight, there would be far less trapped inside her.  It's easy to tell she very much enjoyed the sexual union you just shared.  Not yet pulling out, her tight cunt gently squeezes you as she, with some difficulty, lies down on top of you, her fingers lightly stroking you as she cuddles against you.  The act of trying to cuddle forces more of your virile baby batter out of her body to add to the ever-growing pool of cum on the ground.  The siren sighs, basking in the afterglow of sex.");
	
	outputText("\n\nYou let Minerva hold you against her soft, curvy body, recovering your strength from the draining sex you just had.  Eventually, though, your strength returns and you gently pry yourself free of her, telling her that the sex and her company was wonderful and that, despite still being very aroused from all the venom she stung you with, you need to return to camp.");
	if (!minervaRomanced()) {
		//Default, first time ending:
		if (flags[kFLAGS.TIMES_MINERVA_COWGIRLED] == 0) outputText("\n\nMinerva actually seems a little sad that you're leaving.  \"<i>I guess you are a busy person.  But I'm glad we did this; it was a lot of fun.  And... you know...  I wouldn't mind if we did this again soon,</i>\" she suggests with a small, hopeful smile on her face.  You promise her that you'll try to come back again soon.");
		//Repeated ending: 
		else outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren.  \"<i>Well, if you have to go... come back soon, we can do this again if you want!  I know I've enjoyed our encounters,</i>\" she insists with a genuine smile on her slightly angular face.  You promise her that you'll try to come back again soon, then take your leave.");
	}
	//Romanced ending:
	else outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face.  \"<i>I hope you'll come back soon; I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.");
	flags[kFLAGS.TIMES_MINERVA_COWGIRLED]++;
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//SEX SCENE 2.5 female/herm: LAP SEX
//PC in Minerva's lap getting fucked by Minerva:
private function minervaLapSex():void {
	var x:int = player.cockThatFits(minervaACapacity());
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sex-lapsex"), false);
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features.  Her legs, her curvy hips... your eyes travel past the thick growing bulge in her shorts, up past her scarred, toned belly and to the siren's large, luscious breasts before finally reaching her face.  Grinning to the blue and gray herm, you decide what you want from her.");
	
	outputText("\n\nWithout a second thought, you approach Minerva and slide an arm around her bare back, your other hand reaching for her shorts, slowly giving the tight bulge a squeeze and rubbing it, the tentacled organ starting to swell almost instantly.  \"<i>Ooohh!  Someone knows what they want!</i>\"  She grins and puts an arm around you, pulling you against her, \"<i>How about we get started and have some fun?</i>\"");
	
	outputText("\n\nGently pushing you back, Minerva slides her hands up and down her body erotically, her hands touching her bulging shorts before undoing them and stripping them off, her swollen, anemone-like cock nearly bursting out as soon as it is free from its tight prison.  Now that her more male organ is free of its confines, it rapidly swells to its full, throbbing sixteen inches.  Your eyes can't help but be drawn to the tentacle-endowed flesh, Minerva's tentacles squirming with her obvious excitement.  Moving up, she lifts her tube top, releasing her breasts for your enjoyment.");
	
	outputText("\n\n\"<i>Now, let's get these clothes off you and get started,</i>\" she says playfully, before sliding her hands over your body, her hands carefully stripping you of your [armor] and tossing it aside.  Licking her lips with a grin, Minerva grabs you, pulling you against her cool, naked body, her tentacled phallus pressing against your own body, hard and ready for you; you're surprised that she doesn't just sting you right here and now.  Seeing your momentary confusion, Minerva grins and yanks you down on the ground as she gets into position.  Suddenly, you find yourself in Minerva's lap with her thick tentacled cock crammed between your bodies, tentacles slowly wiggling against you.");
	
	outputText("\n\nYou're about to ask what Minerva is up to when you suddenly feel something squirming against your [vagina], teasing your nethers with gentle slithering touches.  \"<i>Having tentacles down there really comes in handy, don't you think?</i>\" the siren questions with a playful smirk, her dick tentacles squirming their way into your body.  They tease and slowly sting you with her aphrodisiac venom, the potent poison injecting right into your sensitive vaginal walls.  As soon as your lover's toxins seep into your body, your face and body flush, heating up more and more as the tentacles tease and pleasure you, your feminine sex starting to ooze and dampen with your swelling arousal.");
	
	outputText("\n\nMinerva's hands slide down to grope and squeeze your ass tightly, kneading your [butt] with aggressive fingers.  \"<i>You're so damn sexy, you know that?</i>\" she compliments, as her tentacles squirm around inside your body, teasing and stinging you further to help your arousal.  The venom inside you, and the feeling of her tentacles, leave you panting and groaning, all the while, her hands explore your body, touching you teasingly.");
	//PC herm: 
	if (player.gender == 3) outputText("  One of her hands trail down to your hard herm " + player.cockDescript(x) + ", stroking you softly.");
	
	outputText("\n\nMinerva's hands grope and squeeze your [fullChest], tweaking your nipples between her fingers.  \"<i>Well, now that you're nice and ready, how about we start the main event,</i>\" Minerva whispers into your ear before nibbling it gently.");
	
	outputText("\n\nNodding with a dazed, aroused look on your face, you start to disentangle yourself from the siren, her gentle touch lingering on your skin as her tentacles slip from your body, the slick appendages curling around and slithering across Minerva's dick, lubing it up with your juices for the most fun part of your sexual encounter.  Raising yourself, you look down as the tip of her throbbing cock kisses your [vagina].  Taking the opportunity to tease her for a change you reach for Minerva and grab hold of her firm DD-cup breasts, your hands groping and squeezing at the delightful chest and pinching her nipples playfully.");
	
	outputText("\n\nShifting your hips back and forth, you tease her tentacled dick, barely keeping yourself from being penetrated, your wet entrance rubbing across the bloated swollen head of Minerva's fuckstick.  Finally, you decide it's time to get that thick, venom-packed cock into you.  Biting your lip, you start to sink down onto your siren lover's thick, throbbing dick, her hands sliding to your hips and grabbing hold of your ass tightly.  Minerva's fat anemone dick stretches your [vagina] wide around its girth as you slowly sink down more and more onto Minerva's cock, your hips getting further into her lap with every inch you take inside you.  The siren's hands grope your rump tighter, kneading your [butt] as if to express her need for you.");
	
	outputText("\n\nLetting out a groan, your lover can't seem to take it any longer and pulls you down into her lap.");
	//Nonvirgin: 
	if (!player.hasVirginVagina()) outputText("  The thick siren prick plunges into your soaked cunt and fills your sweltering hole with her oddly cool cock, both of you groaning in delightful pleasure.");
	//Virgin:
	else outputText("  The thick siren prick plunges into your soaked cunt, filling your sweltering pussy with her oddly cool cock, in the process tearing right through your hymen, claiming your first fuck for herself as you bite back a pained yelp, though it is quickly displaced by the pleasure from the stimulation and venom.");
	outputText("  Minerva basks in the feeling of being balls deep in you, and you revel in the feeling of being so filled and stretched while little tentacles squirm inside you and gently sting you with aphrodisiac venom.  The build-up of all the arousal enhancing toxins running through your body and the pleasure of the pussy-packing cock squeezed into your twat becomes too much to bear.  Your vision explodes with stars and your cunt clenches as you reach an orgasm.  Your body shudders and quivers with spine-tingling ecstasy, your nerves alight with furious sensation while your back arches and presses your [chest] against your siren lover.");
	player.cuntChange(32,true,true,false);
	
	outputText("\n\nLetting out a gasp at the sudden tightness, Minerva grits her sharky teeth and grips your rear harder, clearly trying to hold back her own orgasm.  You could swear you could feel her sizable balls swell in preparation only to be denied.  \"<i>Nnnh!  That was close... almost blew my load right there!  You feel so good around me... so warm around my cock.  How do those tentacles feel, hm?  The stinging must feel good,</i>\" she says teasingly as she grinds against you, using her grip on you to shift you back and forth slowly and twist her cock inside you.");
	
	outputText("\n\nGrinning to you, she leans in and nibbles your ear gently before licking the outside playfully.  Just as your orgasm is ending, your siren lover decides that it's time to get things moving.  Gripping you tightly, she starts to pull you off her fat length before slamming you back down hard, the forceful action making your [fullChest] bounce and your [vagina] clench in sudden pleasure.  With hard, slow pulls and humps Minerva yanks you up and down, slowly bouncing you in her lap and filling you each time with the squirming, throbbing fullness of her cock.");
	outputText("\n\nIt doesn't take long for the sound of wet flesh squishing together to pervade the air, the slapping of skin coming together with each hard, fast impact when your hips collide with Minerva's.  Both of you gasp and groan with pleasure as your pace increases.  Leaning you down, Minerva takes a more dominant role, pushing you against the ground without missing a beat, her hips now working against yours as she thrusts into you over and over.  Looking up at your siren lover, you can't help but let out a long moan as another dose of her venom is injected into you.  With so much inside you, coursing through your blood and making you more sensitive than ever, each hard thrust of Minerva's hips, each grope and touch of her hands across your body, sends shocks of spine-tingling pleasure through your body.");
	
	outputText("\n\nThe eight-foot tall siren grunts hard as she kicks up the pace, her shark tail smacking the ground as she starts to rut you harder.  What started as slow and gentle has become a fast and hard, passion-filled fuck.  Minerva leans down, capturing your lips in a heated kiss and, despite your lust-addled mind, you can feel the passion and care in the kiss, her delightfully long tongue gently caressing yours even as she pounds you powerfully.");
	
	outputText("\"<i>So good, so good.  Yes, yes, yes, how do you like this?  Getting fucked so good... mmm... getting your pussy pounded so hard...  Nnnngh!  Oh gods... here it comes, hun, I'm gonna fuck you s-so full of cum,</i>\" Minerva says to you as she pulls back from the kiss, the need in her voice quite clear.  Your lover only lasts a few more hard, powerful thrusts before she gasps, her eyes rolling back into her head as she grips you hard, slamming into you and hilting herself, even as her sizable balls clench and swell again, her thick throbbing cock pulsing inside you, signaling her orgasm.  The thick anemone dick seems to bulge with each fat ejaculation, her pent-up balls blowing an immense load inside you, each gush erupting from her tentacle-endowed dick splattering deep inside you, very quickly pooling in your womb and bloating it as more and more fills you.");
	
	outputText("\n\nThe feeling of being stuffed by such a cool, thick, and sticky fluid sends you spiraling over the edge in a mind-blowing orgasm.  Back arching and hands gripping the ground as you let out a piercing cry, your [vagina] clenches tightly and quivers around the invading member");
	//PC herm: 
	if (player.hasCock()) {
		outputText(", your own throbbing phallus");
		if (player.cockTotal() > 1) outputText("es");
		outputText(" cumming alongside,");
		//{Low-moderate cum: 
		if (player.cumQ() < 500) outputText(" gushing your cum all over both of your bellies");
		//High cum volume:
		else if (player.cumQ() < 4000) outputText(" splattering thick splooge all over you and Minerva, caking your torsos in fertile jizz");
		//Very high cum:
		else outputText(" exploding out onto your unsuspecting bodies, thick ropes of starkly white sperm gushing over your bodies, quickly dousing both of you in buckets of cum and pooling on the ground");
	}
	outputText(".");
	
	outputText("\n\nThough infertile to someone like you, Minerva's seed fills you quite full, swelling your belly with what has to be a good liter or two of her thick, musky cream.");
	
	outputText("\n\nPanting from the passionate lovemaking, you both collapse into a sweaty heap on the ground, the wet soothing coolness of Minerva's copious load helping to cool you down.  Gently, your siren smiles and leans down, kissing you again before hugging you tightly.  \"<i>Mmm, that was so good...  I hope I didn't get too rough with you, it's so hard to control myself when I get to have sex with such a sweet and sexy lover,</i>\" she says with an embarrassed smile.");
	
	outputText("\n\nReaching up, you hug your siren, telling her not to worry, and that you loved every second of it.  The two of you lay there for a little while, cuddling and basking in a gentle after-sex, embrace.");
	
	outputText("\n\nYou allow Minerva to hold you against her soft body, recovering your strength from the sex you just had.  Eventually, though, your strength returns and you gently pry yourself free.  Telling her that the sex and her company was wonderful and, despite still being very aroused due to all the venom she stung you with, you need to return to camp.");
	
	if (!minervaRomanced()) {
		//Default, first time:
		if (flags[kFLAGS.TIMES_MINERVA_LAPSEXED] == 0) {
			outputText("\n\nMinerva actually seems a little sad that you're leaving.  \"<i>I guess you are a busy person.  But I'm glad we did this, it was a lot of fun.  And... you know...  I wouldn't mind if we did this again, soon,</i>\" She suggests with a small, hopeful smile on her face.  You promise her that you'll try to come back again soon.");
		}
		//Default, repeated:
		else {
			outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren.  \"<i>Well, if you have to go... come back soon, we can do this again if you want!  I know I've enjoyed our encounters,</i>\" she insists with a genuine smile on her slightly angular face.  You promise her that you'll try to come back again soon.");
		}
	}
	//Romanced:
	else outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face.  \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.");
	player.slimeFeed();
	flags[kFLAGS.TIMES_MINERVA_LAPSEXED]++;
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//4-5= sex scene 4: Hermy oral 
//(tool tip: There is a LITTLE bit of ball kissing on the pc's part)
//any- PC goes down on Minerva for some oral fun.
private function goDownOnAHermAndLoveItYouDirtySlutYou():void {
	clearOutput();
	minervaSprite();
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText(images.showImage("minerva-sex-eatout"), false);
	outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features, starting with her long legs, and her wide, flared hips.  Your eyes travel past the thick bulge in her shorts, going up her scarred toned belly and up to the siren's perky DD-cup breasts before finally reaching her face.  Grinning to the blue and grey herm, you tell her you want to give her some pleasure for a change, your words bringing some surprise to her face.  \"<i>R-really?  You want to focus on me and my pleasure?</i>\" she asks, pleasantly surprised that you want her to be the focus of pleasure this time, a smile full of shark-like teeth soon spreading across her face, \"<i>Well, if you're sure, how could I reject such an offer?</i>\"");
	
	outputText("\n\nLicking your lips in anticipation of the tongue-tingling sexual act you're about to perform on the shark-like herm, you can't help but look forward to tasting the siren's unique flavor.  Guiding your lover, you lead her over to the mossy ground that surrounds the pure spring, and help Minerva into the best possible position.  The lovely siren moves to her hands and knees, pushing her round, firm ass out for you and spreading her legs as she looks back at you with a violet blush clearly staining her cheeks.  \"<i>It's a bit embarrassing with you looking at my ass like that,</i>\" she says as a playful grin slips into her dark glossy lips.  You snicker and reach out, grabbing her tight shorts and pulling them down her hips to reveal her shapely blue and white rump, your hands sliding over the firm round cheeks before giving her a squeeze, your touch drawing a mewl from your lover.");
	
	outputText("\n\nLooking up from her delightful rear, you catch a glimpse of the bright blush on her cheeks.  \"<i>Is my butt that attractive to you?</i>\" she asks before gently shaking her rear and drawing up her shark tail to wrap around your neck, her actions beckoning you to go through with your lustful plans.  To answer her question, you raise a hand and bring it down on her, spanking her ample cheeks and drawing a surprised squeak from her.  Not at all finished with her, you grope her rear and kneel down, spreading her knees a little more to give you room to work.");
	
	outputText("\n\nAs you get down between her legs, Minerva pushes her hips higher to help you, clearly looking forward to being the focus of lust this time.  Taking a moment, you look at what you have to work with, her smooth, puffy pussy, glistening with her clear arousal, her labia turning a delicate pink to match her wetness.  Beneath her feminine sex, you see her male organs, a pair of heavy, sperm-filled balls hanging down, the skin smooth and taut around the highly productive orbs that could pump out many thick loads of cream.  Lower still is her throbbing, tentacled cock, the tendrils surrounding the base gently squirming over the length of her shaft and over the tight sack.  The long, dexterous things look slick, always ready to sting with her potent, arousing venom.");
	
	outputText("\n\n\"<i>H-hey, what are you doing back there?  Having you stare at my junk like that is embarrassing,</i>\" Minerva says.  You can't see it, but you're sure she's blushing heavily now.  Deciding to put an end to her embarrassment, you slide your hands down from her butt and spread her nethers with your thumbs to get at the soft pink flesh of her inner walls.  Leaning in close, you catch the scent of her arousal, and you could swear it smelt a little bit like the peaches that grow from the trees here.  The soft scent draws you in, making you wonder if she tastes as good as she smells.  You slide your tongue out, drawing it slowly across her spread wet cunt, your tongue pulling a shudder from your shark-like lover as you taste her and discover that she does, indeed, taste a bit like the fruit she consumes so often.");
	
	outputText("\n\nWith her tasting so good, you could really get into this.  Your hands take hold of her hips as you dig in, your tongue eagerly lapping up her arousal, each lick sending shocks of sweet delight through her body.  Minerva's tail tightens around you, clearly not wanting you to stop your tantalizing tonguing.  Her gentle moans reach your ears, telling you how much she is enjoying your attention.  Opening your mouth wider, you draw your teeth up, lightly dragging them over her clitoris and eliciting a sharp gasp from your siren lover, all the while licking and teasing her with your tongue.");
	
	outputText("\n\nNot wanting to leave it unattended, your hands drift down, taking hold of her big dick and stroking it, ");
	if (player.tallness < 96) outputText("your fingers not even able to fit around the herm's hefty girth");
	else outputText("your fingers barely wrapping around the meaty member, the fat thing throbbing gently");
	outputText(" as you stroke it slowly.  Your touches are clearly adding to your partner's pleasure, her thick masculinity pulsating under your grip, her tentacles reacting to your presence, the dexterous things curling around your hands and fingers, touching you gently, but not stinging you.");
	
	outputText("\n\nNow ready to give her your full attention, you dive in, your lips pressing against her nethers as your tongue slides in, giving her a perverted tongue filled kiss.  Your teasing tongue slides in deep and pleasures her inner walls, licking and lapping at every sensitive surface it can reach.  As you lick, you can clearly feel the squirming cilia that cover the quivering depths of her cunt, the little squirming things tickling your tongue as you lick.  ");
	//Dragon/Demon tongue
	if (player.tongueType == TONGUE_DEMONIC || player.tongueType == TONGUE_DRACONIC) outputText("Your deliciously long tongue slithers deeper and deeper, reaching sensitive walls and nerves that only the deepest penetrations would reach.  The deep licking makes Minerva shudder and let out a long drawn out moan, \"<i>O-oh!  Your tongue is so... licking me so deep...</i>\"");
	outputText("  The intimate vaginal kiss is working wonders for the siren.  Her sweet, slick juices leak over your tongue, giving you plenty of the peachy flavor that you crave.  As you tongue your lover's pussy and tease her clit, your hands work her thick, pulsating cock, pre-cum slowly coating your hands and making it easy for you to squeeze tighter and stroke her faster.");
	
	outputText("\n\nNot wanting her to cum too soon, you pull your mouth back from her tight, cilia-filled snatch, drawing a disappointed moan from Minerva, clearly missing having your tongue inside her.  Licking your lips, you can still taste her delightful juices.  With your face so close to her genitals and her so close to orgasm, you have a few options to push her over.  Dig back into her creamy cunt, or give her needy, swollen balls some attention.");
	
	//[Balls] [No balls]
	//-if balls clicked, use this paragraph
	menu();
	addButton(0,"Balls",lickMinervasBalls);
	addButton(1,"No Balls",noBallsMinervaAndContinuation);
}

// Balls
private function lickMinervasBalls():void {
	clearOutput();
	minervaSprite();
	outputText("Not even close to being done, you tease her some more.  The tip of your tongue dances along her outer lips before moving down to her smooth, hairless sack to give her male parts some extra attention.  Kissing her swollen, taut scrotum, you slowly lick and tease it as your hands work her rock hard shaft.  Her fat, sperm-filled balls react to your touch, swelling and pulling up as if getting ready to blow.  You can swear you can hear the poor, hefty testicles audibly churning with their thick creamy seed, eager to stuff some poor woman's pussy and impregnate them.  Closing your eyes, you latch on, sucking the tight sack and teasing the sensitive orbs inside.  \"<i>H-hey, careful down there!  Those things are fragile!</i>\"  she squawks in delight as you take your time giving the juicy pair some much-needed attention.");
	noBallsMinervaAndContinuation(false);
}

// No Balls and continuation
private function noBallsMinervaAndContinuation(clear:Boolean = true):void {
	if (clear) clearOutput();
	else outputText("\n\n");
	minervaSprite();
	outputText(images.showImage("minerva-sex-eatout2"), false);
	outputText("Your careful ministrations soon have the poor siren shuddering and squirming, looking about ready to pop from your skilled hands and mouth.");
	if (!clear) outputText("  Retreating from her throbbing balls, you");
	else outputText("  You");
	outputText(" move back up to her now soaking snatch, your tongue eagerly lapping up all the tasty juices from her lips before delving deep into her refreshingly cool cunt, hungrily licking up every slick drop of her succulent sweetness.  The act of worming your tongue back inside her hungry hole again drives Minerva ever closer to the brink of her climax, each slurp and stroke of your tongue and hands pushing the near-climactic herm right to the edge and sending her off into the blissful, pleasure-filled abyss of a mind-blowing double orgasm.");
	
	outputText("\n\nLetting out a musical cry of pure ecstasy, Minerva's tail tightens around you as her body locks up, her tail pulling your face right against her convulsing cunt, soaking your face and drowning your mouth in her sticky, peachy juices.  Her cilia covered inner walls quiver and squeeze around your tongue, her semi-sweet girlcum flowing over your tongue.");
	
	outputText("\n\nBetween her legs and squeezed in your hands, her thick throbbing cock pulses powerfully.  The thick cumvein along the underside bulges with the thick virile ejaculation.  Her heavy sack swells and pulls up against her body, seeming to throb and pulse with each gout of thick, creamy seed launched from her mighty cum cannon, the dense load splattering along the ground wastefully, adding to an ever-growing puddle of fertility.");
	
	outputText("\n\nYour lover's shuddering, lyrical cries of utter delight echo through the tower as she cums mind-blowingly hard, your attention to both her genitals giving her two potent orgasms simultaneously.  After nearly a minute of constant delight, her climax finally comes to an end.");
	
	outputText("\n\nThe intense sexual crescendo leaves her panting and sweaty as she struggles to stay up, her entire body shaking like jelly.  \"<i>Oh... oh, [name], that was amazing.  Gods... I came so hard, from both my dick and cunt...  You're amazing, you know that, hun?  Look at all that seed you made me waste,</i>\" she says, looking back at you with a playful grin.  Minerva loosens the hold her tail has on you, giving you the chance to pull back from her juicy nethers");
	//if demonic tongue:
	if (player.hasLongTongue()) outputText(", your perversely prehensile tongue slowly retracting from her quivering quim, rubbing and teasing as it comes out and nearly sending the overly sensitive herm into another climax");
	outputText(".");
	
	outputText("\n\nWith you now released from her grasp, Minerva lets out a sigh and slumps to her side, narrowly missing the thick pool of white splooge on the ground.  Her chest rising and falling as she pants, a big smile on her face showing how pleased she is, you can't help but feel a sense of pride at seeing how you were able to satisfy your lover.  Even as tired as she is, Minerva keeps a playful grin on her lips, her surprisingly dexterous shark tail being used to yank you down on top of her.");
	
	outputText("\n\nThe siren's arms wrap around you and hugs you against her, with the clear intent on cuddling for a while.  \"<i>That was lovely, I'm </i>so<i> glad to have someone that doesn't mind taking care of my needs.  Now, how about we cuddle for a bit, we can just lay here together, your head resting at my breast as I cuddle my thoughtful lover,</i>\" she whispers to you softly, and with an invitation like that, how can you say no?  Settling into her grasp, you nuzzle her soft cleavage and relax against your siren lover's cool body.");
	
	outputText("\n\nFor a long while, you just lay there, cuddled up with the mostly naked siren, the two of you idly chatting about various things that come to mind.  Eventually, you must leave the gentle embrace and return to your duties as a Champion.  Disentangling yourself from Minerva, you straighten your clothes out and, with a smile, tell her you had a wonderful time.  Grinning up at you, Minerva climbs back onto her feet and pulls you into a deep, tongue-tangling goodbye kiss.  \"<i>It was amazing, we have to do this again.  Perhaps next time, I can do you, hmm?</i>\" she suggests, not wanting to be greedy and get all the pleasure.  Giving you another peck on the cheek, the siren sends you on your way after telling you to come back and visit soon.");
	
	dynStats("lus", 20);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
	
//4-6= sex scene 6: Blow job!
//any - Minerva sucks off male/herm = needs penis
private function letMinervaSuckYouOff():void {
	var x:int = player.cockThatFits(minervaVCapacity());
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sex-blowjob"), false);
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features.  Starting with her long legs, and moving up to her wide, flared hips, your eyes travel past the thick bulge in her shorts, going up her scarred belly to the siren's perky DD-cup breasts before finally reaching her face.");
	
	outputText("\n\nGrinning to the blue and grey herm you decide what you want from her, your eyes soon falling onto her succulent, glossy black lips, and the long demonic tongue that you know is hidden inside.  Grinning and thinking of all the things that tongue could do, you decide you want some nice oral pleasure.");
	
	outputText("\n\nHearing your request brings an unsure look to Minerva's face.  \"<i>You want me to suck you off?  Well, I guess that wouldn't be so bad...  You're sure about this?  I mean, aren't you a bit freaked out by my teeth?  I promise I would never bite, but still...</i>\"  Undeterred by her sharky features, you answer her.  You know she would not harm you like that.  Guiding her over to one of the fallen pieces of stone, you");
	//If naga: 
	if (player.isNaga()) outputText(" lounge against the rock, spreading open your protective slit and letting your " + player.cockDescript(x) + " hang free.");
	else outputText(" sit down, spreading your [legs] and opening up the crotch of your [armor] to the air, letting your " + player.cockDescript(x) + " hang free.");
	
	outputText("\n\nAnxious and ready, Minerva looks down at you before kneeling, placing a hand on your [hips] as she takes hold of your " + player.cockDescript(x) + " and slowly starts to stroke it.  Her eyes looking up at you, she leans in and starts to gently lick your hardening flesh with the tip of her tongue.  Under her careful, deliberate attentions your manhood is quickly brought to full attention.");
	
	//if cock area 21+:
	if (player.cockArea(x) < 21) {}
	else if (player.cockArea(x) < 34) {
		outputText("\n\nMinerva's eyes widen as your dick grows before her eyes.  \"<i>Goodness, you have a pretty good size, don't you?  I'm going to make you feel really good.</i>\"");
	}
	//if cock area 34+:
	else if (player.cockArea(x) < 60) outputText("\n\nMinerva's eyes widen as your dick grows and grows, quickly growing almost as large as her own sizable package.  \"<i>Wow, you're hung, aren't you?  I'll do my best to take everything... wow,</i>\" she says with a blush on her face.");
	//if cock area 60+:
	else outputText("\n\nMinerva's eyes widen and her mouth opens in shock as your dick grows and grows... and grows, quickly dwarfing her own sizable package.  \"<i>G-geez, what a huge dick, it's enormous...</i>\" she says with wonder in her voice.  Gulping, she licks her lips.  \"<i>W-well... I'll do my best to take all of it...</i>\"  A little nervousness is mixed into her voice, but with how tall she is, you're sure she could take it all.");
	
	outputText("\n\nTaking a relaxing breath, Minerva dives right into it, her long tongue slithering out to lick your hard, sensitive flesh, wrapping around the tip and giving the most sensitive part of your dick a good squeeze.  The heat-quenching chill of her wet tongue feels remarkable on your hard prick, the tight squeeze pulling a gasp from your mouth.  Your hands move over her head and into her dark red hair, and you're suddenly relieved that she can't envenom you this way.  Wanting to show you what she's made of, your siren leans in, dragging her cool wet tongue up your " + player.cockDescript(x) + " from base to tip before planting a kiss right on the " + player.cockHead(x) + " of your throbbing, needy dick.");
	
	//If balls:
	if (player.balls > 0) outputText("  Her hand on your hip moves down between your legs, sliding inwards to gently caress and massage your cum-filled [balls] to increase your pleasure even more, her hands trying their best to get your nuts worked up and prepare a good load for her at the end.");
	
	outputText("\n\nHolding the kiss for a moment, your siren lover slides her tongue out, slowly teasing around the tip.  She look up at you briefly, before a playful smirk slips across her face, her tongue extending from her mouth like a snake, the long appendage coiling around your length and constricting around you tightly, sending shudders of pleasure through your body.  The oral embrace feels tight, wet and cool around your comparatively hot dick, the tip of her tongue teasing the underside of your hard flesh");
	//If balls:
	if (player.balls > 0) outputText(" before licking and teasing your [balls]");
	outputText(".");
	
	outputText("\n\nWith your " + player.cockDescript(x) + " firmly captured by her tongue, Minerva leans down, opening her mouth wide and taking you inside its cool, wet confines, even as her tongue squeezes you and slides around your warm, sensitive flesh.  Looking up at you with a playful twinkle in her eyes, she starts to suck and squirm her tongue around on you, the long, prehensile appendage switching between licking over your throbbing cockmeat and squeezing it in a snakelike embrace.");
	
	outputText("\n\nPuckering her glossy black lips, Minerva starts to bob her head, taking in more and more of you with each downwards motion");
	//If cockarea 50+:
	if (player.cockArea(x) >= 50) outputText(", your huge cock deep inside her mouth, and soon far down her throat.  With some difficulty, her slightly angular nose presses down against your crotch, every inch of your " + player.cockDescript(x) + " trapped inside her cool, wet mouth and throat");
	outputText(".");
	
	outputText("\n\nSlurping and licking your package, she continues to bob her head up and down, working your length with everything she can.  Looking down behind her, you can clearly see her shapely rump swaying back and forth, she's clearly not minding the sexual act.");
	
	outputText("\n\nThe furiously teasing tongue-action, coupled with the powerful sucking, leaves you braced against the rock, groaning in sweet pleasure as Minerva works your dick, practically worshiping your manhood, her tongue licking and wrapping around you as she sucks and pulls you deep inside.  With how good her mouth is, you're glad she can't sting you with her aphrodisiac in this situation, or she would surely reduce you to a quivering pile of lust.");
	
	//If vagina:
	if (player.hasVagina()) outputText("\n\nExtending her tongue as far as she can, Minerva slithers it further from her mouth and down to your womanhood, her demonic tongue licking around your puffy lips before snaking its way inside to cause you more pleasure, licking and squirming against your walls and making you gasp and quiver under her attentions.");
	
	outputText("\n\nPanting and groaning, you know you can't hold out for long, and you slide your hands into your lover's hair.  Your sudden gasping and grabbing hold of her head warn her of your impending orgasm");
	if (player.balls > 0) outputText(", while your [balls] lurch and swell, rising up as you reach your climactic explosion");
	outputText(".");
	
	outputText("\n\nGripping Minerva's head tightly, you let out a long deep moan, your " + player.cockDescript(x) + " bloating with each ejaculation.  Eager to please, Minerva does her best to drink down every drop you give her, her hands gripping your [hips] and pressing her nose against your crotch, puckering her full black lips around your [sheath].");
	
	//Low cum: 
	if (player.cumQ() < 500) outputText("\n\nFeeling your orgasm burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, determined to milk as much as she can from you.  Not lasting very long, your climax dies down, leaving you panting as Minerva slowly pulls her tongue off of you and licks her lips, leaning back from your saliva-soaked cock.  \"<i>Mmm, did you like that?  I didn't do too bad, did I?  And, you know, you don't taste too bad, either,</i>\" she says with a shark-like grin before licking your tip.  \"<i>I wouldn't mind doing this again with you.</i>\"");
	//Moderate cum:
	else if (player.cumQ() < 1000) outputText("\n\nFeeling your orgasm burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, your load slightly bigger than she had thought, your warm seed filling her mouth and completely drenching her tongue in the sticky stuff.  Lasting about a minute, your powerful, breathtaking climax dies down as your siren lover swallows one last time, her tongue licking you a bit longer just to make sure, before popping off your saliva-drenched dick.  \"<i>Mmm, that was pretty good, and you let out more than I expected!  I didn't do too bad, did I?  You don't taste too bad either, either, you know</i>\" she says with a shark-like grin before licking your tip.  \"<i>I wouldn't mind doing this again with you.</i>\"");
	//High cum: 
	else if (player.cumQ() < 4000) outputText("\n\nFeeling your orgasm suddenly burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, your load notably bigger than she thought it would be, flooding her mouth and puffing out her cheeks, forcing her to struggle to swallow and gulp down your thick, copious load.  Lasting well over a minute, your stomach-filling ejaculations finally end, and Minerva pops off your cum hose with a deep sigh, some of your pearly cream running down her chin before being licked up by that delightfully long tongue of hers.  \"<i>W-wow... that was quite the load.  I'm impressed, I wasn't expecting to get such a... filling meal like this, but you taste pretty good.  And I don't think I'm too bad at giving head, either, considering how much I made you cum,</i>\" she says with a shark-like grin and a gentle pat on her slightly swollen tummy.  \"<i>I wouldn't mind doing this again with you.</i>\"");
	//holy shit cum volume: 
	else outputText("\n\nFeeling your orgasm suddenly burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, your colossal load far more than she was expecting.  Like a great flood, your sperm gushes into her sucking mouth, quickly overflowing Minerva despite her constant swallowing and attempts to contain it, her stomach rapidly bloating under the intense flow.  Choking and gagging on the thick cream filling her throat, Minerva squeezes her eyes shut, not about to give up and pull away.  She swallows great gulps of your thick, hot cum, but can't catch it all and some begins to gush from her nose and the seal of her lips.\n\nWith your orgasm lasting for what has to be several minutes, you let out a long, satisfied groan as your sperm fountain of a cock is finally released from Minerva's sucking mouth.  The filled up siren groans and leans back, a hand on her bloated, cum-stuffed belly, her chest and face plastered with your thick, white cream.  Coughing a couple of times to free her throat and sinuses from your jizz, she stares up at you with shock and awe.  \"<i>Gods... I had no idea you could cum so much, I've never seen such a potent " + player.mf("male","herm") + " before...</i>\" she chuckles, before coughing some more, \"<i> I don't think I'm going to have to eat dinner tonight, that's for sure...</i>\" she says with a bit of a laugh as she pats her tummy.  \"<i>Despite almost drowning me in your cum, I wouldn't mind doing this again with you, you're surprisingly delicious!</i>\"");
	
	outputText("\n\nDeciding to relax for a while after your sexual exertion, you curl up on the soft moss with Minerva, both of you just basking in the warmth that the spring gives off, and the softness of the moss, content with each other's presence.  Unfortunately, you know you have to go; the call of your duty to this land is too great, and despite the comfort of this place, you must go.  Pulling away from the siren you promise to return and visit her soon.");
	//PC returns to camp.
	player.orgasm();

	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//4-4= sex scene 4:  hand held behind
//any- pc fucks Minerva, holding min's wrists from behind
private function fuckMinervaWithHerHandsBehindHerBack():void {
	var x:int = player.cockThatFits(minervaVCapacity());
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sex-restrain"), false);
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText("Looking the lean, toned herm up and down, your eyes trail over her every curve as you think over your options, figuring out what kind of sexual adventure you'd like to go on with the redheaded siren.  Your eyes undressing what little clothes she has on as you visually molest the sharky herm.  Your intense gaze is drawing a blush from the herm, her eyes looking away shyly.  \"<i>Hey... you know how it makes me feel when you look at me like that... but I am glad you like how I look,</i>\" the bashful herm admits before grinning, thrusting her hip out, posing for you and showing off her body.");
	
	outputText("\n\nWith her posing like this, it's easy to get a good look at the teasing siren.  Wanting to get a closer look, you start to walk around her, your eyes running over every inch of her, inspecting her form.  Finally, your eyes come to a rest on Minerva's full, perky rump and the tight pink pussy that rests between her legs.  Licking your lips, you approach her from behind, your hands grabbing handfuls of her tight, short-clad rump and squeeze, drawing a sharp gasp and small jump from Minerva before she looks back at you with a blush.  \"<i>Getting a bit grabby, are we?  Well, guess someone knows what they want,</i>\" she says with a grin before pushing her butt back at you and grinding it against your hands.");
	
	outputText("\n\nReaching back, the siren slips an arm around you and leans back, smiling to you.  \"<i>So, how about you show me just what you want?</i>\"  she asks, letting out a throaty coo as if to entice you.  With such an invitation, how could you not?  You know just what to do with her.  Leaning closer, you whisper to her, telling her to trust you just before smirking and pushing her forward.  The herm tumbles onto one of the fallen stones that she likes to use as a seat, letting out a squawk of surprise as she falls.  The siren thankfully catches herself on the stone, her body now fully bent over the rocks with that tight, round ass sticking up, just asking for your attentions, begging to be played with.  Looking back at you, Minerva smiles before grinning and wiggling her hips at you.  \"<i>So, you wanted me bent over a barrel for you, huh?  Shame I don't have any, but this will do,</i>\" she says with a giggle before flicking her sharktail at you.");
	
	outputText("\n\nWith her so eagerly shaking her hips like that, what could you do but give the siren just what you both want.  Grabbing hold of her hips, you reach down, quickly undoing her skin-tight shorts and yanking them down.  Tossing the garments aside as you slip a hand between Minerva's toned thighs and feel up her cool, pink pussy.  The tight entrance to her body is damp from her strong libido, your soft, teasing touch on such a sensitive part of her is pulling shivers and small croons from her black glossy lips.  Your fingers stroke and caress the soft pink folds nestled between her legs, slowly becoming wet with Minerva's growing arousal.");
	
	outputText("\n\nNot yet ready to get down and dirty with the sexy siren, you continue your teasing touches, wanting the herm to beg you to take her.  Knowing how sensitive Minerva's round, curvy rear is, you decide to give it your special treatment before spearing your length into her tight depths.  Sliding your hands from the cool wet opening between her legs, you grab hold of the toned cheeks on either side of her tail, kneading the firm, round ass before taking your teasing a step further.  Your hand raises slowly, drawing out the moment and anticipation before bringing it down and spanking the siren like you know she loves.");
	
	outputText("\n\nYour hands hit again and again, each hard spank rippling the luscious blue and grey rump, and drawing groans and gasps from Minerva every time you plant a new handprint on her round, toned butt.  Your kinky siren is loving the teasing spanking, as her tight pink snatch grows wetter and wetter, and her thick, tentacled cock grows harder and harder, sure signs of her greater arousal.  \"<i>H-hey!  Ahh... how... how long are you going to... ooohh... tease me like this?</i>\" she asks between spanks and moans of delight from the rough teasing.");
	
	outputText("\n\nWith her so wet now, it's the perfect time to strike!  Deftly pulling your [armor] from your body, you toss the useless pieces away and expose [eachCock] to the air.  Taking hold of [oneCock], you drag its length across Minerva's thighs and rump just to tease her a little more before giving the horny herm the hard dicking she craves.  Reaching down, you lift and spread her curvy rear before aligning yourself, your " + player.cockHead(x) + " pressing and kissing her netherlips for a moment, drawing a lusty whimper from the siren before tensing your hips and plowing your iron-hard breeding meat into her with body-jerking power.");
	
	outputText("\n\nDespite your brutal thrust, you slide in with ease, Minerva's tight walls so slickened with her arousal.  You squeeze into the deliciously tight herm like butter, easily ramming every inch of your " + player.cockDescript(x) + " into her with only a few hard, deep thrusts.  With your hips pressed against Minerva's accepting body, you grind against her, making sure she can feel every inch moving inside her clinging cunt.");
	//If balls: 
	if (player.balls > 0) outputText("  As you continue to pound the siren, your [balls] swing between your legs, the sperm-filled orbs churning with your fertility, preparing to fill the needy siren with every drop you can muster when you let loose your eventual orgasm.");
	
	outputText("\n\nYou give the quivering form under you a gentle pat on the rump, appreciating its feel one last time before you take her.  Your hips drive you into Minerva's tight, contracting sex over and over, her tail thrashing with the pleasure she feels for a moment before tightly wrapping around you, not wanting you to pull out of her or even stop your pistoning hips.  Your usual teasing and foreplay have done their jobs well, getting the herm so ready for you, so sensitive to your touches that you have her moaning you a serenade, your slippery connection squishing audibly with each heavy thrust.");
	
	outputText("\n\nWith Minerva so ready, you grin with devilish purpose, knowing just what will make this even better.  Letting go of her curvy hips, you reach forward and grab her hands, holding the Siren up from behind as you rut her like a hungry beast.  Your new, dominant, position seems to only make the well-teased woman enjoy it more, letting her trusted friend and lover take control for a moment, secure in the knowledge that you will keep her safe so she can simply let go and enjoy it.  Letting out long moans as she throws her head back, her long red braids thrash around as she gives in, for the moment, allowing the pleasure to consume her.  As if they had a mind of their own, Minerva's tentacles lash out from below, slithering around her sizable balls to wrap around your thrusting shaft, the anemone-born organ stinging you with arousal-swelling venom.");
	
	outputText("\n\nGrunting with the sudden heat flooding your blood, you only seem to thrust harder into the red-haired siren, the anemone venom filling you with a deep lust and sexual hunger, your newfound lust spurring your movements.  The potent toxin not only fills you with lust, but seems to enlarge your " + player.cockDescript(x) + " with aphrodisiac, making your sexual organ swell longer and thicker inside the siren's slippery snatch.  The deep stretching forces a long, throaty moan of pleasure from Minerva as her refreshingly cool cunt is stretched from the sudden thickness.  \"<i>F-fuuuck... w-what happened?!  Hngh!  Fucking me so hard, now... you're like an animaaal!</i>\" the siren practically screams with new ecstasy as you really start to get into the spine-tingling, heart-pounding, nut-busting action with your dangerous new thickness.");
	
	outputText("\n\nWith your body filled with lust, you renew your hip-smacking thrusts, the wet slapping and squishing of your venom-bloated dick stretching her juicy, pink siren-pussy filling the air.  It mixes well with the sounds of your grunts and the lyrical moans of pleasure filling the air.  A symphony of pleasure and primal satisfaction acting as a testament to your union.  Harder and faster you pound into the siren, gripping her wrists tightly from behind to keep your curvy, wanton mate in balance to continue the sexual onslaught of her sopping wet snatch and plant your virile seed deep in her womb in the hope of breeding your siren's needy body.");
	
	outputText("\n\nYour new pace, your brutal, animalistic rutting now so hard and fast, it takes all of Minerva's will to not lose it right then and there!  Her orgasm is fast approaching, if her loud, echoing moans are to be believed.  The siren's walls tighten, squeezing you in anticipation of her coming climax.  Her own cock swells and her balls tighten as they ready themselves to blow her load over the rocks like a pail of spilt milk.");
	
	outputText("\n\nMinerva's need and lust comes to an explosive end as she arches her back, her perky breasts thrusting forward as she lets out a musical cry of delight and cums around you.  The siren's cilia-covered walls clench and squeeze, the hundreds of little feelers lining the inside of her cool, slippery snatch writhing and stroking you through her orgasm, trying to milk you for the cum her body knows you have.  Between her legs, her tentacle-endowed dick pulsates and bulges as she cums, her male genitalia gushing in unison with her tightly constricting cunt.  Her crotch tentacles eagerly go to town on her own dick, stroking and jerking it off as if to milk her own load from her.  The thick siren cum splatters, like the thickest of cream, across the rocks.");
	
	outputText("\n\nWith your body so stimulated, so aroused by the tight, passionate fuck, and the potent anemone venom coursing through you, you can't hold out a minute longer under the siren's orgasmic assault.  Letting out what can only be described as a primal roar of dominance, you ram your hips against Minerva, letting go of her wrists and grabbing her flanks tightly, spearing your throbbing cockmeat into her desperately quivering quim and let loose your hot, frothy load into her belly.");
	
	//Low-moderate cum: 
	if (player.cumQ() < 500) {
		outputText("\n\nMinerva groans in delight as your seed bursts into her tight, hungry cunt, the tightness of her walls making sure not a drop is wasted, while hundreds of cilia squirm and draw your cum up and into her waiting womb.  \"<i>Yesss... let it all out, let me feel your warmth in my belly,</i>\" she demands before her eyes roll back, clearly enjoying the wet heat spreading through her clinging cunt and cum craving womb.");
	}
	//Moderate-high cum:
	else if (player.cumQ() < 1000) {
		outputText("\n\nYour blissful release surges from you like froth from an over-shaken champagne bottle, gushing into Minerva's cunt with such eagerness that it barely needs her thrashing cilia to draw it up into her belly, which becomes visibly bloated after your deposit.  \"<i>O-oh!  Oh gods!  F-fuuuck!  That... that's sooo, so much.  So hot... so full...</i>\" she babbles, letting out a long satisfied sigh before looking down at her sperm-bloated belly.  \"<i>Oh gods... what if... you get me pregnant with all that?</i>\" she croons as she gulps and looks down, a surprisingly happy look on her face.  Perhaps she wants you to knock her up?");
	}
	//Holy shit!:
	else {
		outputText("\n\nYour inhuman load fills the siren's accepting belly with what can only be described as a flood, as gallons of your hot spooge instantly bloat her belly, swelling her womb like a balloon of raw fertility.");
		if (player.balls > 0) outputText("  Minerva groans and lets out mindless gurgles as you unload your overproductive balls into her.");  
		outputText("  To even your amazement, her hungry womb is able to contain much of your sperm before she can take no more, each blast of potent cum now gushing from between your bodies, the floor soon looking like someone dumped a barrel full of raw milk on the ground before you're finally done.");
		outputText("\n\nLooking down at her now gravid, overstuffed form, Minerva slowly gets up, only to sit down on the rock and hold her swollen belly in her arms with surprising gentleness.  \"<i>Uuugh... oh gods... I feel like I'm gonna burst...  Don't think I'll ever get used to this...</i>\" she says with a groan as she looks down at her taut tummy.  \"<i>Ooohh... I look like I'm about to give birth to twins... or triplets...</i>\" she says with a small smile on her face, despite how she seems to complain.");
	}
	outputText("\n\nFinally letting go of the well-fucked herm's sides, you ease her into a comfortable rest against the rock, your lust spent into her still quivering body as she pants and sighs with satisfaction.  \"<i>That was amazing... I don't know how you do it, but you never cease to amaze, do you?</i>\"  she asks with a throaty coo, looking back at you, a deep blush on her face making it clear that she enjoyed everything you did with her.");
	
	outputText("\n\nWith another sigh, she lets go of you with her tail and lays her head on her arms as she leans against the supporting stone.  \"<i>I'm sorry, but you know how to wear a girl out...  Not that that's a bad thing,</i>\" she says with a giggle, her tail giving you a playful caress this time, just to show how pleased she is.  \"<i>I think I'll just rest here for now... on this... mmm... cool stone, where have you been all my life...</i>\" Minerva says with a content smile on her face.");
	
	outputText("\n\nWith an amused grin, you give the sharky herm a pat on the rump before heading out, your hand sliding along that sexy tail of hers as you let the well-fucked woman rest.");
	//PC returns to camp
	dynStats("sen", -1);
	player.orgasm();
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
	
//4-9= sex scene 9: lesing out
//pure/normal - pc gets eaten out
private function pcGetsEatenOutByMinerva():void {
	clearOutput();
	minervaSprite();
	outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features.  Starting with her long legs, and moving up to her wide, flared hips, your eyes travel past the thick bulge in her shorts, going up her scarred belly to the siren's perky DD-cup breasts before finally reaching her face.");
	
	outputText("\n\nGrinning to the blue and grey herm, you decide what you want from her.  Your eyes quickly fall to her succulent, glossy black lips, and the long demonic tongue hidden inside.  Your mind wanders through your kinky fantasies, conjuring up images of all the things that scandalously long tongue could do to you, and settles on wanting a piece of the sweet oral pleasure you know Minerva could give you.");
	
	outputText("\n\nHearing that you want her to put her tongue and mouth to work for some sapphic fun brings a playful grin to Minerva's black lips.  \"<i>Oh really?  You want to see my oral skills, huh?  Well, I'm not too shabby, if I have to say,</i>\" the sharky herm claims with a smirk before sticking her long demonic tongue out, the far-reaching, saliva-damped organ sliding down between her own breasts and giving a wiggle for emphasis.");
	
	outputText("\n\nPulling her tongue back in, she gives you another grin and approaches, slipping a hand around and grabbing hold of your [butt] before leading you to the mossy base of one of her fruit trees so you can get comfortable.");
	
	outputText("\n\nSitting you down with your back against the tree, Minerva kneels her tall body down, looking up at you as she crawls toward you.  Smirking at her attitude, you spread your legs, spreading them wide and opening up the crotch of your [armor] so that Minerva can have her way with your feminine bits");
	if (player.hasCock()) outputText(", and, perhaps, your more male parts while she's down there");
	outputText(".");
	
	outputText("\n\nLicking her lips, the blue and grey herm moves in closer as you free your genitalia and present yourself to her, eager to see what she can do with that mouth of hers.  Grabbing hold of your thighs, Minerva  leans in");
	if (player.balls > 0) outputText(", one of her hands lifting your [balls] up before giving each of the fertile nuts a kiss");
	outputText(" and moving down to your sweet cunt, just waiting for her attentions.");
	
	outputText("\n\nWith a lick of her lips, the siren starts her sexual stimulation.  Leaning in, she plants a kiss on your [vagina], giving your womanly flower a long, slow kiss before sliding her tongue out and licking you, her tongue dragging across your pussy from bottom to top, teasing you as shivers of sweet pleasure run through your body.  As her long tongue teases you, the tip dancing along the outside of your sex, yet never sliding inside.  Her fingers gently caress your vulva, rubbing and stroking you as her perverse oral appendage plays with your entrance.");
	
	//If herm:
	if (player.gender == 3) outputText("\n\nLicking her way up, she drags her tongue up to your hardening maleness, her perversely prehensile tongue coiling around your growing cock and, like a snake, squeezing down around the swelling mass, drawing a gasp of delight from your lips as the long demonic tongue slowly slithers off you, squeezing you even as it uncoils from you and slides back down.");
	//If balls:
	if (player.balls == 0) outputText("\n\nThe siren's tongue proceeds to slither around your spunk-filled nuts, slapping them with her tongue before opening her maw and sucking on one of the fertile orbs, nearly sucking it into her mouth, before moving back to down to your quivering cunt.");
	outputText("\n\nMinerva plants a kiss on your [clit], her black lips seeming to pucker up and suck on the sensitive bundle of nerves as her tongue flicks and plays with you.  The teasing and toying on such a sensitive part of you rip encouraging gasps from you, your back arching, your hands sliding through the redhead's hair, desperate to keep her head right where she is, where she belongs for the moment, between your legs.");
	
	outputText("\n\nGrinning at your reactions to her teasing, the playful siren sucks harder than ever for an intense second before finally letting off from your now, almost painfully, engorged and aroused clit.  Your swollen center of feminine pleasures, so achingly hard with how needy you are, is given one last, spine-tingling lick before Minerva pulls back with a grin.  Your cunt is craving fulfillment as the herm licks each of her fingers and then uses her slicked digits to spread your [vagina] open, your juices soaking her fingers and showing just how much you need this.");
	
	outputText("\n\nLicking her lips in anticipation of the main event, Minerva leans in, closing the distance between you and her teasing, pleasing mouth.  The siren's perversely prehensile tongue slithers out to tease your tender, dripping cunt, the eager oral organ slowly lapping at your opened vaginal folds, slowly dragging along your sensitive fuckhole and eliciting long, throaty groans of ecstasy from you.");
	
	outputText("\n\nWith your pleasure so clear and easy to read, it's easy for Minerva to tell that you're enjoying the skills she has to offer.  Wanting to experience more of your pleasure, and force you to reach greater heights of toe-curling, mind-melting rapture, she digs right in.  Her tongue lashes out and licks every inch of your sopping snatch, eagerly licking up every drop of your succulent feminine fluids.");
	
	outputText("\n\nLike a slippery serpent, Minerva's tongue squirms against you, teasing and stimulating your immaculate entrance while her thumbs hold you open, her fingers rubbing and squeezing your aching clit between them, causing even more cries of joy from your lips.  Under such a barrage of sexual stimulation, it's not long before the skillful siren drives you over the edge, and into your first orgasm.");
	
	outputText("\n\nYour back arches almost painfully as you throw your head back, letting out a scream of ecstasy, eyes rolling back, tongue lolling out to show the taste of heaven you're feeling.  As if they were afraid she would stop, your legs wrap around Minerva's head, making sure she doesn't stop or try to get away.  If anything, you actually only seem to spur her careful ministrations.  As if sensing the perfect moment to strike, her tongue lashes out, striking like a cobra as it spears its perverse squirming length, like a tentacle beast after its prey, into your body.");
	
	outputText("\n\nEven as you're still caught up in your first explosive climax, the sudden, forceful, penetration by her tentacle-like tongue throws you headlong into a whole new level of pleasure, a second orgasm rushing through your body even as your first was winding down.  Your moans go silent and breathless from the raw, mind-blowing ecstasy, your body too consumed by the heavenly oral ministrations to stop screaming and remember to breathe.");
	
	outputText("\n\nYour vision darkens, tunneling as your lungs burn for fresh air, your siren lover never once stopping her oral onslaught, her tongue squirming and wriggling its way deeper and deeper into your spasming, quivering quim, and eagerly tasting every drop of girl-spunk you let flow from your squeezing snatch.  Realizing your predicament, Minerva lets her tongue slip out, allowing you respite from the lengthy orgasm, just in time for you to grab a hearty lungful of air, your vision snapping back into place.");
	
	outputText("\n\nGrinning at her work, the siren's eyes move up and down your sweaty, heavily panting form, a distant lusty look in your eyes as your body continues to twitch from jolts of sweet pleasure.  \"<i>Mmm... don't go passing out now, cutie.  You wanted me to use my mouth on you, so that's just what you're getting.</i>\"");
	
	outputText("\n\nUnfortunately... or perhaps fortunately, Minerva is not yet done with you.  Licking her lips clean from your juices, she leans back in and draws her tongue up your still quivering cunt.  The slow, teasing touch on your freshly orgasmic flesh feels even better than before, your eyes snapping wide open as you gasp from the sensation.  Grinning her sharky grin, Minerva digs in again, her hands reaching around and grabbing hold of your [butt] before opening her mouth wide and clamping down on you, enclosing your feminine sex inside her cool, wet mouth, her tongue lashing out and spearing into you again, delving deeper then ever before, licking walls that had been left untouched by the siren.");
	
	//If dick:
	if (player.hasCock()) outputText("\n\nOne of her hands slides back from your rear and across your flesh to your swollen, untouched cock, her soft hand closing around your member and stroking you as she works to send you plummeting back into that ocean of heavenly delights.");

	outputText("\n\nWith how sensitive you are from your recent orgasms, and the skillful tongue probing your depths like a squirming eel sending jolts of electric pleasure through your quivering depths, it's not long before you're gasping and panting once again, drool slipping down your chin, your hands gripping both the tree and your sharky lover's body.  Deeper and deeper her wriggling tongue slithers, teasing and worming its way inside you until it even reaches your cervix, the tip of Minerva's tongue licking all around the edge of your sacred entrance, teasing it tenderly even as she licks every wall inside you.");
	
	outputText("\n\nUnder the siren's renewed relentless assault, it's not long before she has you cumming again, your body quaking and shaking like a leaf in the wind.  Mouth open wide, your cries of star seeing splendor fill the tower as your pussy explodes into another orgasm.  Slick juices gush out over your lover's tongue, even as she continues to lick up everything you give her.");
	
	outputText("\n\n");
	//If dick:
	if (player.hasVagina()) outputText("Thanks to her handy stimulation, your musky maleness throbs and dilates along your femininity, the thick cockvein feeding your bloating member as your seed rushes out, splattering up and onto Minerva's back, defiling her smooth skin with your fertility.  ");
	outputText("Her mouth is closed over your hot quaking cunt, catching every drop and sucking hard on you as she slowly retracts her perversely prehensile tongue.  Minerva's mind wanders as she muses your unique flavors, her tongue still squirming inside you, making sure to lick up as much of your feminine juices as she can before finally pulling out from your body and letting go of you.");
	
	outputText("\n\nWith a deeply content sigh, the siren looks across your panting, sweaty body, a cheeky grin appearing on her face appears as she crawls up your exhausted figure and plants a deep tongue-tangling kiss on your lips.  Her girl-cum coated tongue curls around yours, making sure you get a good taste of yourself before pulling back.  \"<i>Mmm, delicious... so musky, so rich, a very special taste for sure,</i>\" she says to you with a grin before laying you down on the moss to let you rest and recover for a while.");
	
	outputText("\n\nNearly an hour goes by as you rest from your orgasms at the hands of Minerva's skilled mouth and tongue.  Stirring softly, you feel the siren cuddled up next to you, her bright, electric blue eyes looking at you tenderly as you awaken, perhaps even watching you as you slept.  Slowly sitting up, you stretch and yawn, feeling somewhat rejuvenated from the pleasurable sex and brief nap.  You let out a content sigh and look around for your clothes, only to remember that you never took them off in the first place, though it seems they have been fixed up by the dutiful siren.  Though you had a wonderful time with the scantily clad hermaphrodite, you must return to your duties as a Champion.");
	if (!minervaRomanced()) {
		//First time ending:
		if (flags[kFLAGS.MINERVA_LEZZES_OUT] == 0) outputText("\n\nMinerva actually seems a little sad that you're leaving.  \"<i>Well, I guess you are a busy person.  But I'm glad we did this though, it was a lot of fun.  And, you know... I wouldn't mind if maybe we could do this again, soon,</i>\"  she says with a small, hopeful smile on her face.  You promise her that you'll try to come back again soon.");
		else outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren.  \"<i>Well, if you have to go... come back soon, we can do this again, if you want...  I know I've enjoyed our encounters,</i>\" she says with a genuine smile on her slightly angular face.  You promise her that you'll try to come back again soon.");
	}
	//Romanced ending: 
	else outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face.  \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.  Smiling down at the tender woman, you promise her that you'll try to come back again soon and visit her.");
	outputText("\n\nWith that, you turn and start the long hike back to camp.");
	flags[kFLAGS.MINERVA_LEZZES_OUT]++;
	// PC returns to camp
	dynStats("sen", -2);
	player.orgasm();
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

private function chooseVagOrAss():void {
	if (player.hasVagina()) {
		outputText("\"<i>So, which of your hole would you like me to fuck?</i>\" the siren asks.", true)
		menu();
		addButton(0, "Vagina", minervaLapSex);
		addButton(1, "Ass", getButtFuckedYouSlut);
	}
	else getButtFuckedYouSlut();
}

private function getButtFuckedYouSlut():void {
	var x:int = player.cockThatFits(minervaACapacity());
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sex-analcatch"), false);
	flags[kFLAGS.TIMES_MINERVA_SEXED]++;
	outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features.  Her legs, her curvy hips... your eyes travel past the thick growing bulge in her shorts, up past her scarred, toned belly and to the siren's large, luscious breasts before finally reaching her face.  Grinning to the blue and gray herm, you decide what you want from her.");
	
	outputText("\n\nWithout a second thought, you approach Minerva and slide an arm around her bare back, your other hand reaching for her shorts, slowly giving the tight bulge a squeeze and rubbing it, the tentacled organ starting to swell almost instantly.  \"<i>Ooohh!  Someone knows what they want!</i>\"  She grins and puts an arm around you, pulling you against her, \"<i>How about we get started and have some fun?</i>\"");
	
	outputText("\n\nGently pushing you back, Minerva slides her hands up and down her body erotically, her hands touching her bulging shorts before undoing them and stripping them off, her swollen, anemone-like cock nearly bursting out as soon as it is free from its tight prison.  Now that her more male organ is free of its confines, it rapidly swells to its full, throbbing sixteen inches.  Your eyes can't help but be drawn to the tentacle-endowed flesh, Minerva's tentacles squirming with her obvious excitement.  Moving up, she lifts her tube top, releasing her breasts for your enjoyment.");
	
	outputText("\n\n\"<i>Now, let's get these clothes off you and get started,</i>\" she says playfully, before sliding her hands over your body, her hands carefully stripping you of your [armor] and tossing it aside.  Licking her lips with a grin, Minerva grabs you, pulling you against her cool, naked body, her tentacled phallus pressing against your own body, hard and ready for you; you're surprised that she doesn't just sting you right here and now.  Seeing your momentary confusion, Minerva grins and yanks you down on the ground as she gets into position.  Suddenly, you find yourself in Minerva's lap with her thick tentacled cock crammed between your bodies, tentacles slowly wiggling against you.");
	
	outputText("\n\nYou're about to ask what Minerva is up to when you suddenly feel something squirming against your [asshole], teasing your butt-cheeks with gentle slithering touches.  \"<i>Having tentacles down there really comes in handy, don't you think?</i>\" the siren questions with a playful smirk, her dick tentacles squirming their way into your body.  They tease and slowly sting you with her aphrodisiac venom, the potent poison injecting right into your sensitive backdoor.  As soon as your lover's toxins seep into your body, your face and body flush, heating up more and more as the tentacles tease and pleasure you.");
	
	outputText("\n\nMinerva's hands slide down to grope and squeeze your ass tightly, kneading your [butt] with aggressive fingers.  \"<i>You're so damn sexy, you know that?</i>\" she compliments, as her tentacles squirm around inside your body, teasing and stinging you further to help your arousal.  The venom inside you, and the feeling of her tentacles, leave you panting and groaning, all the while, her hands explore your body, touching you teasingly.");
	//PC herm: 
	if (player.gender == 3) outputText("  One of her hands trail down to your hard herm " + player.cockDescript(x) + " and " + player.vaginaDescript() + ", stroking and fingering you softly.");
	
	outputText("\n\nMinerva's hands grope and squeeze your [fullChest], tweaking your nipples between her fingers.  \"<i>Well, now that you're nice and ready, how about we start the main event,</i>\" Minerva whispers into your ear before nibbling it gently.");
	
	outputText("\n\nNodding with a dazed, aroused look on your face, you start to disentangle yourself from the siren, her gentle touch lingering on your skin as her tentacles slip from your body, the slick appendages curling around and slithering across Minerva's dick, lubing it up with your juices for the most fun part of your sexual encounter.  Raising yourself, you look down as the tip of her throbbing cock kisses your [asshole].  Taking the opportunity to tease her for a change you reach for Minerva and grab hold of her firm DD-cup breasts, your hands groping and squeezing at the delightful chest and pinching her nipples playfully.");
	
	outputText("\n\nShifting your hips back and forth, you tease her tentacled dick, barely keeping yourself from being penetrated, your rear entrance rubbing across the bloated swollen head of Minerva's fuckstick.  Finally, you decide it's time to get that thick, venom-packed cock into you.  Biting your lip, you start to sink down onto your siren lover's thick, throbbing dick, her hands sliding to your hips and grabbing hold of your ass tightly.  Minerva's fat anemone dick stretches your [asshole] wide around its girth as you slowly sink down more and more onto Minerva's cock, your hips getting further into her lap with every inch you take inside you.  The siren's hands grope your rump tighter, kneading your [butt] as if to express her need for you.");
	
	outputText("\n\nLetting out a groan, your lover can't seem to take it any longer and pulls you down into her lap.");
	
	outputText("  The thick siren prick plunges into your backdoor and fills your sweltering hole with her oddly cool cock, both of you groaning in delightful pleasure.");
	player.buttChange(32, true);
	outputText("  Minerva basks in the feeling of being balls deep in you, and you revel in the feeling of being so filled and stretched while little tentacles squirm inside you and gently sting you with aphrodisiac venom.  The build-up of all the arousal enhancing toxins running through your body and the pleasure of the butt-packing cock squeezed into your ass becomes too much to bear.  Your vision explodes with stars and your ass clenches as you reach an orgasm.  Your body shudders and quivers with spine-tingling ecstasy, your nerves alight with furious sensation while your back arches and presses your [chest] against your siren lover.");
	
	outputText("\n\nLetting out a gasp at the sudden tightness, Minerva grits her sharky teeth and grips your rear harder, clearly trying to hold back her own orgasm.  You could swear you could feel her sizable balls swell in preparation only to be denied.  \"<i>Nnnh!  That was close... almost blew my load right there!  You feel so good around me... so warm around my cock.  How do those tentacles feel, hm?  The stinging must feel good,</i>\" she says teasingly as she grinds against you, using her grip on you to shift you back and forth slowly and twist her cock inside you.");
	
	outputText("\n\nGrinning to you, she leans in and nibbles your ear gently before licking the outside playfully.  Just as your orgasm is ending, your siren lover decides that it's time to get things moving.  Gripping you tightly, she starts to pull you off her fat length before slamming you back down hard, the forceful action making your [fullChest] bounce and your [asshole] clench in sudden pleasure.  With hard, slow pulls and humps Minerva yanks you up and down, slowly bouncing you in her lap and filling you each time with the squirming, throbbing fullness of her cock.");
	outputText("\n\nIt doesn't take long for the sound of wet flesh squishing together to pervade the air, the slapping of skin coming together with each hard, fast impact when your hips collide with Minerva's.  Both of you gasp and groan with pleasure as your pace increases.  Leaning you down, Minerva takes a more dominant role, pushing you against the ground without missing a beat, her hips now working against yours as she thrusts into you over and over.  Looking up at your siren lover, you can't help but let out a long moan as another dose of her venom is injected into you.  With so much inside you, coursing through your blood and making you more sensitive than ever, each hard thrust of Minerva's hips, each grope and touch of her hands across your body, sends shocks of spine-tingling pleasure through your body.");
	
	outputText("\n\nThe eight-foot tall siren grunts hard as she kicks up the pace, her shark tail smacking the ground as she starts to rut you harder.  What started as slow and gentle has become a fast and hard, passion-filled fuck.  Minerva leans down, capturing your lips in a heated kiss and, despite your lust-addled mind, you can feel the passion and care in the kiss, her delightfully long tongue gently caressing yours even as she pounds you powerfully.");
	
	outputText("\"<i>So good, so good.  Yes, yes, yes, how do you like this?  Getting fucked so good... mmm... getting your ass pounded so hard...  Nnnngh!  Oh gods... here it comes, hun, I'm gonna fuck you s-so full of cum,</i>\" Minerva says to you as she pulls back from the kiss, the need in her voice quite clear.  Your lover only lasts a few more hard, powerful thrusts before she gasps, her eyes rolling back into her head as she grips you hard, slamming into you and hilting herself, even as her sizable balls clench and swell again, her thick throbbing cock pulsing inside you, signaling her orgasm.  The thick anemone dick seems to bulge with each fat ejaculation, her pent-up balls blowing an immense load inside you, each gush erupting from her tentacle-endowed dick splattering deep inside you, very quickly pooling in your bowels and bloating it as more and more fills you.");
	
	outputText("\n\nThe feeling of being stuffed by such a cool, thick, and sticky fluid sends you spiraling over the edge in a mind-blowing orgasm.  Back arching and hands gripping the ground as you let out a piercing cry, your [asshole] clenches tightly and quivers around the invading member, ");
	
	if (player.hasVagina()) {
		outputText("your own cunt ");
		if (player.averageVaginalWetness() < 4) outputText("leaking femspunk");
		else outputText("shooting femspunk");
	}	
	if (player.hasVagina() && player.hasCock()) outputText(" while ");
	if (player.hasCock()) {
		outputText("your own throbbing phallus");
		if (player.cockTotal() > 1) outputText("es");
		outputText(" cumming,");
		//{Low-moderate cum: 
		if (player.cumQ() < 500) outputText(" gushing your cum all over both of your bellies");
		//High cum volume:
		else if (player.cumQ() < 4000) outputText(" splattering thick splooge all over you and Minerva, caking your torsos in fertile jizz");
		//Very high cum:
		else outputText(" exploding out onto your unsuspecting bodies, thick ropes of starkly white sperm gushing over your bodies, quickly dousing both of you in buckets of cum and pooling on the ground");
	}

	outputText(".");
	
	outputText("\n\nMinerva's seed fills you quite full, swelling your belly with what has to be a good liter or two of her thick, musky cream.");
	
	outputText("\n\nPanting from the passionate lovemaking, you both collapse into a sweaty heap on the ground, the wet soothing coolness of Minerva's copious load helping to cool you down.  Gently, your siren smiles and leans down, kissing you again before hugging you tightly.  \"<i>Mmm, that was so good...  I hope I didn't get too rough with you, it's so hard to control myself when I get to have sex with such a sweet and sexy lover,</i>\" she says with an embarrassed smile.");
	
	outputText("\n\nReaching up, you hug your siren, telling her not to worry, and that you loved every second of it.  The two of you lay there for a little while, cuddling and basking in a gentle after-sex, embrace.");
	
	outputText("\n\nYou allow Minerva to hold you against her soft body, recovering your strength from the sex you just had.  Eventually, though, your strength returns and you gently pry yourself free.  Telling her that the sex and her company was wonderful and, despite still being very aroused due to all the venom she stung you with, you need to return to camp.");
	
	if (!minervaRomanced()) {
		//Default, first time:
		if (flags[kFLAGS.TIMES_MINERVA_LAPSEXED] == 0) {
			outputText("\n\nMinerva actually seems a little sad that you're leaving.  \"<i>I guess you are a busy person.  But I'm glad we did this, it was a lot of fun.  And... you know...  I wouldn't mind if we did this again, soon,</i>\" She suggests with a small, hopeful smile on her face.  You promise her that you'll try to come back again soon.");
		}
		//Default, repeated:
		else {
			outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren.  \"<i>Well, if you have to go... come back soon, we can do this again if you want!  I know I've enjoyed our encounters,</i>\" she insists with a genuine smile on her slightly angular face.  You promise her that you'll try to come back again soon.");
		}
	}
	//Romanced:
	else outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face.  \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.");
	player.slimeFeed();
	flags[kFLAGS.TIMES_MINERVA_LAPSEXED]++;
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat) combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

internal function loseToMinerva():void {
	clearOutput();
	minervaSprite();
	//PC loss by physical
	if (player.HP < 1) {
		outputText("Falling back from the siren's final strike, the blow sends you on your back as you drop your [weapon] in exhaustion.  Thankfully, the soft, pillow-like moss covering the ground softens your fall.  As you lay there, panting and exhausted from the fierce spar you had with the halberd-wielding siren, you hear her approach, laying her weapon on the ground and beginning to tend to your wounds.  \"<i>Are you all right, [name]?  Was I too rough on you?</i>\" she says with a worried tone in her voice.");
		outputText("\n\nThe friendly siren smiles down at you as she cares for you.  \"<i>I thought you did well!  You put up a real fight, but looks like Minerva came out on top this time!</i>\" she chirps happily with a proud look on her face.  After healing your wounds, Minerva helps you up and holds toward you a freshly picked peach.  \"<i>Here, eat this.  It will help you recover your strength.</i>\" she says, sending you on your way.  ");
		// return PC to options- no combat option
		// PC gains 1 Purity peach
		monster.createStatusEffect(StatusEffects.PeachLootLoss,0,0,0,0);
		inventory.takeItem(consumables.PURPEAC, camp.returnToCampUseOneHour);
		combat.cleanupAfterCombat();
	}
	//PC loss by Lust
	else {
		outputText("Falling back from the siren's final move, the lustful need is too much to ignore as you fall to your knees and drop your [weapon], sliding your hands into your [armor] and fondling yourself.  As you sit there, panting and groaning from the fierce spar you had with the halberd-wielding siren, you hear her approach you, laying her weapon on the ground.  \"<i>Are you all right, [name]?  Was I too rough on you?</i>\" she says as she looks your needy body over, realizing your predicament.  \"<i>G-goodness... did... did I do that to you?</i>\"  A blush flooding over her cheeks at seeing her work.");
		outputText("\n\n\"<i>W-well... don't worry, Minerva is going to take care of you, just tell me how you want it, all right?</i>\" she says earnestly, clearly intending to finish what she started and help you with your battle induced lust.");
		//Take PC to sex menu
		minervaSexMenu(false);
		addButton(14,"Leave", combat.cleanupAfterCombat);
	}
}

//Victory text for tainted
internal function beatUpDatSharpie():void {
	clearOutput();
	minervaSprite();
	//Win by damage
	if (monster.HP < 1) {
		outputText("With your final blow against the siren, you send her silver halberd flying from her hands.  The metal weapon skitters across the ground as Minerva herself falls to the soft moss, her sharky skin covered in sweat and bruises as she sits her butt down, letting out a sigh.  \"<i>Wow... you sure are something, aren't you...  I'm glad this was just a friendly spar and not a real fight,</i>\" she says with a content smile on her face as she looks up at you.  You could swear that she is even blushing a little.  \"<i>Such a big strong warrior you are.</i>\"");
		outputText("\n\nAfter a moment, the siren manages to get up before presenting you with a freshly picked peach and a small sack.  \"<i>I get these gems from the harpies, they seem to like shiny things, but I have no use for them... though I could do with some decorations I guess.  And here's a peach, as well, it'll help you regain your strength... not that you need it with how strong you are...</i>\" she says with a coy chuckle.\n\n");
		//PC gains 1 purity peach
		combat.cleanupAfterCombat();
	}
	//Win by lust
	else {
		outputText("Your final move finishes the horny siren, her shorts bulging obscenely and soaked with her arousal.  Falling to her knees, Minerva desperately grabs hold of her shorts, yanking them from her curvy hips, letting out a gasp of relief and a moan of need.  Between the lusty herm's legs stands her painfully hard cock, all sixteen thick inches throbbing with desperate need, her thighs soaked in womanly juices.  Minerva's hands grab hold of her cock, stroking herself as she slips a pair of fingers into her quivering, slippery quim.  \"<i>Oh, [name], p-please... ohhh... look what you've done.  So mean, getting me so horny like this,</i>\" she says before letting out a long moan.");
		outputText("\n\nShe's looking up at you with her debilitating lust clear in her eyes.  \"<i>W-well... think you could help little old me with this...  Just tell me what to do, I need it so badly.</i>\"");
		minervaSexMenu(false);
		addButton(14,"Leave", combat.cleanupAfterCombat);
	}
}

//Item/oasis interactions
//Purity/Corruption Peach
public function eatSomethingYouCunt():void {
	clearOutput();
	minervaSprite();
	outputText("You take a good look at Minerva's \"garden\". Fruit trees surround the spring, each bearing what appears to be a fruit. Strange herbs grow around the spring. You ponder over what you would like to take.");
	menu();
	addButton(0, "PurPeac", getPurePeach);
	addButton(1, "C. Mint", getMint);
	addButton(4, "Back", genericMenu, true);
}
private function getPurePeach():void {
	clearOutput();
	minervaSprite();
	outputText("You walk over to the fruit trees surrounding the spring, examining the strange treats.  You decide that one ripe fruit, one resembling a peach, is the best choice, and pluck it from the tree.  Thanking Minerva for letting you have it, you stow it away safely and head back to camp.\n\n");
	inventory.takeItem(consumables.PURPEAC, camp.returnToCampUseOneHour);
}
private function getMint():void {
	clearOutput();
	minervaSprite();
	outputText("There are many strange herbs growing around the spring, fed by whatever power resides in the water.  Finally, you locate a sprig of something that resembles mint, but silver in color, and decide to pluck it.  Stowing it carefully amongst your belongings, you thank Minerva for sharing the contents of her 'garden' with you and then head back to camp.", true)
	inventory.takeItem(consumables.C__MINT, camp.returnToCampUseOneHour);
}


/* IMPLEMENTED AT LAST!
Calming Mint
Acquiring: There are many strange herbs growing around the spring, fed by whatever power resides in the water.  Finally, you locate a sprig of something that resembles mint, but silver in color, and decide to pluck it.  Stowing it carefully amongst your belongings, you thank Minerva for sharing the contents of her 'garden' with you and then head back to camp.
C. Mint - Inventory
This is a sprig of silver-colored mint.  Its strong scent makes you feel calmer and less lustful.
Sell value 3
Using
C. Mint - Eating the sprig of raw mint is a bit of a stretch, but you manage to gulp it down.  As the strong minty flavor overwhelms your taste buds, your mind feels calmer, and a relaxed sensation spreads through your body.
// -3 Libido, -10 Lust, intelligence +2
*/
//Spring Water
public function getADrinkYouBitch():void {
	clearOutput();
	minervaSprite();
	outputText("You ask Minerva if she's okay with allowing you to drink from her spring.  She replies with a nod, a smile and a casual wave towards the pool.  Making it quite clear that you can drink your fill.", true);
	//[Bottle] [Drink]
	//[Drink]
	menu();
	addButton(0, "Drink", drinkDirectly);
	addButton(1, "Bottle", getBottle);
	addButton(4, "Back", genericMenu, true);
}
private function drinkDirectly():void {
	outputText("Approaching the pristine pond, you kneel on the shore and dip your hands into the water, cupping them together and lifting them out to scoop up a decent drink.  The water is cool and sweet to the taste, and every swallow makes you feel calmer, cleaner, and refreshed.  You drink until your thirst is quenched, feeling purer in both mind and body.  ", true);
	dynStats("lus", -25, "cor", -.5, "resisted", false);
	player.refillHunger(15);
	if (player.cor > 50) dynStats("cor", -1);
	if (player.cor > 75) dynStats("cor", -1);
	doNext(camp.returnToCampUseOneHour);	
}
private function getBottle():void {
	outputText("Pulling out a small waterskin, you dip it into the crystal clear water, filling the container with the cool, clean spring water before placing it in your pack.  ", true)
	inventory.takeItem(consumables.S_WATER, camp.returnToCampUseOneHour);
}

private function sleepWithMinerva():void {
	clearOutput();
	minervaSprite();
	outputText(images.showImage("minerva-sleepwith"), false);
	outputText("You walk over to the siren and give her a hug. You tell her that you want to sleep with her. \"<i>Oh, really? You want to sleep with me?</i>\" she says. You nod.\n\n", false);
	outputText("Minerva guides you to the most comfortable spot.  She takes off her tube top, exposing her breasts completely.\n\n", false);
	if (player.armorName == "goo armor") outputText("You take your time to get the metal platebody off until you're completely naked save for the goo-girl covering you.  ", false)
	else outputText("You take your time to get your " + player.armorName + " off until you're completely naked.  ", false)
	outputText("You lay next to Minerva while you rest your head on her soft breasts.  ", false)
	if (player.armorName == "goo armor") outputText("Valeria, your goo-girl companion, envelopes you and Minerva, helping to keep you and Minerva warm.  ", false)
	outputText("\"<i>Sweet dreams,</i>\" she says as you finally close your eyes.  ", false)
	doNext(sleepWithMinervaProcess);
}
private function sleepWithMinervaII():void {
	clearOutput();
	outputText(images.showImage("minerva-sleepwith2"), false);
	outputText("<b>Ten hours pass...</b>\n\n", false)
	outputText("You wake up, feeling refreshed. You thank Minerva for letting you sleep with her and you hug her, making sure to give her a good kiss. \"<i>Ohhhhh,</i>\" she moans and even blushes! You break the kiss. \"<i>Darling, come back anytime, ok?</i>\" she says. \n\n", false)
	if (player.armorName == "goo armor") outputText("Valeria encases you once more and you get suited up ", false)
	else outputText("You get re-dressed in your " + player.armorName + " ", false)
	outputText("and you leave the tower to return to your camp. \n\n", false)
	awardAchievement("Getaway", kACHIEVEMENTS.GENERAL_GETAWAY);
	sleepWithMinervaHeal();
	doNext(camp.returnToCampUseOneHour);
}
private function sleepWithMinervaProcess():void {
	clearOutput();
	kGAMECLASS.timeQ = 10;
	goNext(timeQ, true);
	sleepWithMinervaII();
}
private function sleepWithMinervaHeal():void {
	kGAMECLASS.timeQ = 10;
	camp.sleepRecovery(true);
	kGAMECLASS.timeQ = 0;	
}

/* IMPLEMENTED AT LAST!
[Bottle] Pulling out a small waterskin, you dip it into the crystal clear water, filling the container with the cool, clean spring water before placing it in your pack
Spring Water - Inventory
A waterskin full of purified water from Minerva's spring.  It's clean and clear, with a faint sweet scent to it.  You're sure it would be a very refreshing drink.
Using
The water is cool and sweet to the taste, and every swallow makes you feel calmer, cleaner, and refreshed.  You drink until your thirst is quenched, feeling purer in both mind and body.
// Corruption - 3 to 4, lower fatigue by 5 or 10, heal health by 20 per level.
*/
}
}
