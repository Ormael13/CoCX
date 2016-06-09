package classes.Scenes.NPCs
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;

	public class HelFollower extends NPCAwareContent
	{

		public function HelFollower()
		{
		}

//const HELIA_FOLLOWER_DISABLED:int = 696
//const HEL_INTROS_LEVEL:int = 697;
//const MINO_SONS_HAVE_SOPHIE:int = 698;
//const KEEP_HELIA_AND_SOPHIE:int = 699;
//const FOLLOWER_HEL_TALKS:int = 670;
//const HEL_CAN_SWIM:int = 703;
//const HEL_GUARDING:int = 704;

//const HELIA_ANAL_TRAINING_OFFERED:int = 926;
//const HELIA_ANAL_TRAINING:int = 927;

//const HELIA_BIRTHDAY_OFFERED:int = 928;
//const HELIA_BDAY_DRINKS:int = 929;
//const HELIA_BDAY_HAKON_AND_KIRI:int = 930;
//const HELIA_BDAY_PHOENIXES:int = 931;
//const HELIA_BDAY_FOX_TWINS:int = 932;

private function helCapacity():Number {
	return 85;
}
private function helAnalCapacity():Number {
	var anal:int = 85;
	if (flags[kFLAGS.HELIA_ANAL_TRAINING] >= 1) anal += 100;
	if (flags[kFLAGS.HELIA_ANAL_TRAINING] >= 2) anal += 300;
	return anal;
}
internal function heliaCapacity():Number {
	return helCapacity();
}
internal function heliaAnalCapacity():Number {
	return helAnalCapacity();
}
public function helAffection(diff:Number = 0):Number {
	if (flags[kFLAGS.HEL_AFFECTION_FOLLOWER] > 70 && flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 0) flags[kFLAGS.HEL_AFFECTION_FOLLOWER] = 70;
	if (flags[kFLAGS.HEL_AFFECTION_FOLLOWER] < 100 || (flags[kFLAGS.HEL_BONUS_POINTS] == 0 && diff < 0)) {
		flags[kFLAGS.HEL_AFFECTION_FOLLOWER] += diff;
		if (flags[kFLAGS.HEL_AFFECTION_FOLLOWER] >= 100) flags[kFLAGS.HEL_AFFECTION_FOLLOWER] = 100;
		if (flags[kFLAGS.HEL_AFFECTION_FOLLOWER] < 0) flags[kFLAGS.HEL_AFFECTION_FOLLOWER] = 0;
	}
	else if (followerHel()) {
		flags[kFLAGS.HEL_AFFECTION_FOLLOWER] = 100;
		flags[kFLAGS.HEL_BONUS_POINTS] += diff * 3;
		if (diff > 0) if (flags[kFLAGS.HEL_BONUS_POINTS] > 150) flags[kFLAGS.HEL_BONUS_POINTS] = 150;
		else if (diff < 0) if (flags[kFLAGS.HEL_BONUS_POINTS] < 0) flags[kFLAGS.HEL_BONUS_POINTS] = 0;		
	}
	return flags[kFLAGS.HEL_AFFECTION_FOLLOWER];
	trace("HEL AFFECTION" + flags[kFLAGS.HEL_AFFECTION_FOLLOWER]);
}
public function isHeliaBirthday():Boolean {
	return date.month == 7;

}

//The Pale Flame Lingers: Introduction -McGirt
//(The first time the Champion goes to sleep when all the above conditions are met, display the following, occurring after ALL other night effects):
public function heliaFollowerIntro():void {
	outputText(images.showImage("helia-follower-intro"));
	outputText("\nYou awake from your slumber to a gentle shake.  Eyes fluttering open, your gaze falls upon the cloaked, hooded figure that looms over you, a rough, hard hand grasping your shoulder. You're assaulted by the smell of ale and fire, and nearly cough, but the figure places another hand over your mouth, surprisingly gentle.  You try to struggle, but the stranger is surprisingly strong.");
	
	outputText("\n\n\"<i>Shhh, lover mine,</i>\" the figure whispers, pulling back her hood.  Helia smiles down at you as her long red hair spills out, draping over her shoulders and the hilt of the scimitar strapped to her back.  \"<i>Hey, hey, it's just me,</i>\" she says, taking her hand from your mouth and, ever so gently, brushes her fingers across your cheek.");
	outputText("\n\nGroggily, you ask the salamander what she's doing at your camp.");
	
	outputText("\n\n\"<i>I just. uh... need to talk, is all.  Can we go someplace more... private?</i>\"");
	
	outputText("\n\nYou nod and clamber out of bed.  Smiling, Hel puts an arm around your ");
	if (player.tallness > 84) outputText("waist");
	else outputText("shoulders");
	outputText(" and leads you out beyond the fringe of the camp.  She takes you a fair distance from your bedroll, out to the old ruined wall a stone's throw from the perimeter.  By the time Hel hefts herself up onto a rock, she's practically glowing under her cloak; her long fiery tail is burning more brightly than you've ever seen it shine before, its radiant light putting your meager campfire to shame.");
	
	outputText("\n\nYou rest your back against the crumbling wall and watch as Hel fidgets.  She seems different somehow, though you can't quite put your finger on it.  Her eyes shift constantly, warily looking all around her - at anything that isn't you - as she wraps her arms around herself, perhaps for warmth, though you're nearly sweating from the heat of her burning tail.");
	
	outputText("\n\n\"<i>So, [name], I've been thinking,</i>\" Helia murmers, still avoiding your gaze.  \"<i>I just... I guess I just wanted to say thanks.  For helping me ");
	if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) outputText("kill");
	else outputText("bring down");
	outputText(" the Harpy Queen... and getting my sister out of that shithole.  For giving me a chance to meet my dad.  For everything.</i>\"  You start to tell her that you're happy to help, but Hel cuts you off, speaking quickly: <i>\"Kiri, Dad, and I have been trying to make it work, living out on the plains - we really have - but Dad's not in any shape to fight and Kiri's no good at it; the plains are just too dangerous for them and Dad's been having nightmares about mom, and...\"</i> she pauses to take a gasping breath, unaccustomed to talking so quickly.");
	
	outputText("\n\nShe slows down, finally managing to look your way.  \"<i>So we scraped some gems together, and we're going to try and get a place in that old city - Tel'Adre.  And, well, I was wondering...</i>\" she sighs and runs her scaly hands through her hair, searching for the words she wants to say.  \"<i>Look, [name], you're my best friend, bar none.  In the time we've been together, I've had more fun than the rest of my life combined.  Maybe I'm crazy, but...  I think we're good together, you know?  So, if you think the same - and I understand if you just wanna keep things the way it's been, I do... but maybe you'd like to move in with us?  With me...</i>\"");
	
	outputText("\n\nYou stare at the salamander, momentarily taken aback by her offer.  However, you know that, even if you wanted to, your duties as Champion bind you here, to the portal.  You cannot go with her... But perhaps there's another way to keep Hel close, if you want to take things further at all.");
	//(Display Options: [I can't] [Come2Camp] [Just Friends]
	menu();
	addButton(0,"I Can't",iCantLetFireButtsRapeMyCampsButt);
	addButton(1,"Come2Camp",comeToCampHeliaIWantTailInButt);
	addButton(2,"JustFriends",justFriendsWithAnalTailWaifu);
}

//[I Can't] -The Girt
private function iCantLetFireButtsRapeMyCampsButt():void {
	clearOutput();
	outputText("With a heavy heart, you explain to Hel that you can't come live with her.  Your duties as the Champion keep your bound to the portal, and you cannot leave it undefended lest your village be vulnerable to demon attack.  To her credit, Hel nods with understanding, though you can see her eyes shimmering as you speak.  You tell her that you'd like to be with her, but it's simply not possible right now, no matter how much either of you desire it.");
	
	outputText("\n\nWhen you're through, the salamander gives you a small, weak smile.  <i>\"Yeah.  I guess... Well, what was I expecting?  You've got your duties, now I've got my family.  Just wasn't meant to be, I guess.  I understand, lover mine.  I do.\"</i>");
	
	outputText("\n\nTaking an emotional second wind, Hel grins and slugs your shoulder playfully.  <i>\"Hey, even if you can't move in, you can at least come visit, right?  Swing by the Wet Bitch in the afternoons ");
	if (flags[kFLAGS.HEL_FOXY_FOURSOME_WARNED] > 0 || flags[kFLAGS.HEL_EDRYN_OFFER] > 0) outputText("like usual");
	outputText(", and maybe you and I can spend some quality time together.  Alright?\"</i>");
	
	outputText("\n\nYou nod and tell your fiery lover you'll be sure to do just that.");
	flags[kFLAGS.HELIA_FOLLOWER_DISABLED] = 1;
	doNext(playerMenu);
}

//[Come2Camp] -Dirty
private function comeToCampHeliaIWantTailInButt():void {
	clearOutput();
	outputText("With a heavy heart, you explain to Hel that you can't come live with her - that your duties as champion prevent you from leaving the portal unguarded... But, as you speak, an idea pops into your head as to keeping your fiery lover close despite your obligations.  Hel seems to like you - love you, even - and at the least you aren't opposed to having your eager friend within easy reach.  Grinning, you ask Hel if she'd consent to moving into camp with you.  She can put her dad and sister up in Tel'Adre, then... come back and live with you.");
	
	outputText("\n\nHel goes wide-eyed at the suggestion, taken aback by your solution.  <i>\"I-I dunno, [name].  Gods know I wanna be with you, I'd give anything to have you close... But I don't like the idea of Dad and Kiri being all by themselves.  They need me, you know?  And I need them.\"</i>");
	
	outputText("\n\nUnwilling to simply let Hel refuse you, you spend the next several minutes trying to allay her concerns.  She can still visit her father and sister whenever she likes, can still support them with her adventures - it isn't as though you're going to chain her down and hold her prisoner here. Helia shifts uncomfortably as you talk, but slowly begins to nod, even grinning as you try and coax her into coming to live with you.");
	
	outputText("\n\n<i>\"Alright, alright,\"</i> Hel finally says, making a show of huffing and rolling her eyes.  <i>\"I guess, if you just can't live without me...  Well, Dad and Kiri will be fine, as long as I'm still helping, and - and they'd want me to be happy.\"</i>  With a wolfish grin, Hel hooks her arms around your neck, pressing herself close to you, a lusty look in her eyes.  <i>\"And believe me, lover mine.  Nothing on the planet would make me happier than being with you.\"</i>");
	
	outputText("\n\nYou smile at the salamander and give her a long, affectionate kiss.  Hel seems to melt in your arms, going languid as her tongue slips past your lips, entwining with yours.  You and Hel run your hands over each other's bodies, stroking, groping and teasing as you kiss, eventually pushing Hel against the wall.  She gasps, hiking her legs around your waist as you begin to play with the straps of her scale bikini and thong.");
	
	outputText("\n\nFinally, she breaks the kiss long enough to say, <i>\"Oh, I am going to enjoy living with you...\"</i>");
	menu();
	//place holder
	model.time.hours++;
	addButton(0,"Next",afterMoveInBoningAnalFireTail);
}

//Afterwards, play:
//Hel Moving into Camp -McGirt
private function afterMoveInBoningAnalFireTail():void {
	clearOutput();
	outputText("<b>An hour later...</b>");

	outputText("\n\nYou and Hel disentangle from your post-coitus repose, redressing together as you tease and flirt, giving Hel's big breasts a playful squeeze as she swats your [butt] with her warm tail.  After you're both clothed, you draw the salamander into another long kiss, breaking it only to ask what you can do to help her get settled in.");
	
	outputText("\n\nShe gives you a little wink and a grin.  <i>\"You've done plenty, lover mine.  Give me a chance to swing back by my camp, get my shit, and I'll be all moved in within the hour.  Then... you and I are going to have a fuckin' party, you hear me.\"</i>");
	
	outputText("\n\nYou roll your eyes and give her a little swat on the ass toward the plains.  Laughing, Hel blows a kiss over her shoulder before dashing off to collect her belongings.");
	
	outputText("\n\n(<b>Hel has been added to the Lovers menu!</b>)");
	flags[kFLAGS.HEL_FOLLOWER_LEVEL] = 2;
	doNext(playerMenu);
}

//[Just Friends] -Dirt
private function justFriendsWithAnalTailWaifu():void {
	clearOutput();
	outputText("Awkwardly, you spend the next few minutes saying that, while you appreciate the offer and her affections, you're more interested in just being friends with Hel, as you have been for some time.");
	
	outputText("\n\nHel seems to take your answer surprisingly well.  <i>\"Hey, no worries, lover mine.  I understand - I'm alright with things staying the way they are.  That's fine... I was just, you know, offering.  Still, hey, if you wanna swing by and say hi to the folks - or spend some 'quality time' with me - hit me up at the Wet Bitch, alright?\"</i>");
	
	outputText("\n\nYou tell her you'll do that if you get the chance.  Hel smiles, and leans ");
	if (player.tallness > 84) outputText("up");
	else if (player.tallness < 60) outputText("down");
	else outputText("over");
	outputText(" to give you a little peck on the cheek.  <i>\"Well, that's that, then.  I guess.  Well, see you around, [name].\"</i>");
	
	outputText("\n\n<i>\"Sure will.\"</i>");
	
	outputText("\n\nYou wave as Hel retreats back toward her own home.");
	flags[kFLAGS.HELIA_FOLLOWER_DISABLED] = .5;
	doNext(camp.returnToCampUseOneHour);
}

//Hel Comes to Camp -- Intro Scenes (Play in Order)
public function helFollowersIntro():void {
	clearOutput();
	//(If Kiha is at camp & has "met" Hel before)
	if (followerKiha() && flags[kFLAGS.HEL_INTROS_LEVEL] < 1) {
		flags[kFLAGS.HEL_INTROS_LEVEL] = 1;
		outputText("You pace around camp, awaiting the return of your new companion.  After several minutes, you notice Kiha sitting behind you, eyeing you with an eyebrow cocked.  Suddenly self-conscious, you stop and face the dragon-girl.");
		outputText("\n\nKiha smirks slightly. <i>\"What the hell are you doing, doofus?  Expecting someone?\"</i>");
		
		outputText("\n\nWell, yeah, actually.");
		
		outputText("\n\n<i>\"Oh?  Is that right?  Well, come on then, [name], spill it!  Who's c- oh you've gotta be shitting me.\"</i>");
		outputText("\n\nYou look over your shoulder, and see Hel standing a few feet behind you, her meager possessions slung over her shoulder.  The salamander smiles at you, but falters when she sees the dragoness.");
		
		outputText("\n\n<i>\"Well hey there, hot wings,\"</i> Hel says, giving Kiha a little wink as she slips an arm around your waist.");
		outputText("\n\n<i>\"W-what the hell are you doing here!?\"</i>  Kiha demands, jumping to her feet and positively fuming.");
		outputText("\n\n<i>\"I'd ask you the same thing, but...  Well, I think we both know [name] here is into polyamory.  Isn't that right, lover mine?\"</i>");
		outputText("\n\n<i>\"Hey!  You get your whore hands off my [name] right this instant!\"</i>");
		
		outputText("\n\nHel rolls her eyes.  <i>\"Oh, don't you worry, I can share real nice - hey, what the shit's your name, anyway?\"</i>");
		
		outputText("\n\n<i>\"WHY YOU... wait, what?\"</i>  Kiha asks, taken aback by Hel's query.");
		
		outputText("\n\n<i>\"Well shit, hot wings, we're gonna be living together, in case you didn't notice.  Pet names are cute and all, but still... not as good as the real thing.\"</i>  Hel steps forward, extending her hand to Kiha with a broad smile.  <i>\"I'm Helia, by the way.  Hel to my friends... and lovers,\"</i> she adds, giving Kiha a playful swat on the butt.");
		
		outputText("\n\n<i>\"Gah!\"</i> the dragoness yelps, rubbing her now-red butt and flushing slightly.  Hel laughs heartily, until Kiha finally says, <i>\"Friends, huh?  Well, I guess if [name] trusts you, I can...  at least be civil, I guess...  I'm Kiha.\"</i>  She steps up and, reservedly, shakes Hel's hand.");
		
		outputText("\n\nTo your surprise - and Kiha's, by the look on her face - Hel yanks the dragoness into a tight hug, nearly smothering the foot-smaller woman between her big breasts.  After a moment of squirming around, Kiha finally manages to escape Hel's grasp and, now blushing brightly, launches off into the air.");
		
		outputText("\n\n<i>\"Catch you later, hot wings!\"</i>  Hel yells after her, giggling girlishly before asking you to show her around.");
	}
	//If Isabella 
	else if (isabellaFollower() && flags[kFLAGS.HEL_INTROS_LEVEL] < 2) {
		flags[kFLAGS.HEL_INTROS_LEVEL] = 2;
		//is at Camp (She and Hel are cool)
		if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] > 0) {
			outputText("Showing Hel around, you eventually come to the part of your camp inhabited by the towering cowgirl Isabella.  When you arrive, you find Isabella reclining in her armchair, humming a sweet melody as she cleans her tower shield.");
			
			//(If you suppressed Isabella's main character trait:)
			if (!isabellaAccent()) outputText("\n\n<i>\"Ah!</i>\"  Isabella says with a slight smile as you and Hel walk by arm in arm.  <i>\"And what have we here?  My little Hel come to pay a visit?\"</i>");
			else outputText("\n\n<i>\"Ah!</i>\"  Isabella says with a slight smile as you and Hel walk by arm in arm.  <i>\"And vat have we here?  Mein little Helia come to pay a visit?\"</i>");
			
			outputText("\n\n<i>\"Heyya, Izzy!\"</i> Hel yells gleefully, leaping into the cowgirl's lap.  Isabella makes an exaggerated <i>\"OOMPH\"</i> as Hel jumps onto her, though she manages to laugh and wrap her arms around the smaller salamander, letting Hel snuggle into her lap.");
			outputText("\n\nGrinning at the two of them, you mention to Isabella that no, Hel isn't just paying a visit...  She's going to be a permanent addition.");
			if (isabellaAccent()) outputText("\n\n<i>\"Oh, ja?  Iz zis true, Helia?\"</i>");
			else outputText("\n\n<i>\"Oh, really?  Is that true, Helia?\"</i>");
	
			outputText("\n\n<i>\"Mmhm,\"</i> the salamander nods, using the motion to further nestle her head between Isabella's massive mammaries until she practically disappears between them.  Muffled by titflesh, she adds, <i>\"[name] invited me to stick around, so...  Looks like I won't have to walk so far to get my favorite milk!\"</i>");
			if (isabellaAccent()) outputText("\n\n<i>\"Vell, I look forward to having you around, mein Hel,\"</i> the warrior-cow laughs, running her hand through Hel's hair.  You seat yourself on the arm of Isabella's chair and join in, giving both girls a bit of (heavy) petting until you practically have to drag Hel out from the canyon of Isabella's cleavage.  The tour still needs to be finished, and Hel needs to get settled.");
			else outputText("\n\n<i>\"Well, I look forward to having you around, Hel,\"</i> the warrior-cow laughs, running her hand through Hel's hair.  You seat yourself on the arm of Isabella's chair and join in, giving both girls a bit of (heavy) petting until you practically have to drag Hel out from the canyon of Isabella's cleavage.  The tour still needs to be finished, and Hel needs to get settled.");
		}
		//If Isabella is at Camp (And she and Hel are NOT cool)
		else {
			outputText("Showing Hel around, you eventually come to the part of your camp inhabited by the towering cowgirl Isabella.  When you arrive, you find Isabella reclining in her armchair, humming a sweet melody as she cleans her tower shield.");
			outputText("\n\nYou only have a moment to remember Hel's disdain for the cowgirl before...");
			outputText("\n\n<i>\"Oh, what the fuck is SHE doing here!?  OI, BITCH!\"</i>  Hel yells, dropping her shit and grabbing her scimitar.  Isabella has only a moment to react before Hel sinks her blade into the cowgirl's shield, nearly punching through it.");
			if (isabellaAccent()) outputText("\n\n<i>\"Y-You!\"</i>  Isabella stammers.  She recovers from her surprise a moment later, throwing Hel back and slinging her arm through the shield's straps.  <i>\"Vhat are YOU doing here?\"</i>");
			else outputText("\n\n<i>\"Y-You!\"</i>  Isabella stammers.  She recovers from her surprise a moment later, throwing Hel back and slinging her arm through the shield's straps.  <i>\"What are YOU doing here?\"</i>");
			
			outputText("\n\nBefore the two of them can come to further violence, you leap between them and try to hold them apart.  You suffer the brunt of their aggression for a few moments, but manage to hold them off for the moment until they come down off their combat high.");
			//Hel meets Izzy, Con't
			outputText("\n\n<i>\"[name]!?\"</i> They both blurt at once, surprised by your intervention.");
			
			outputText("\n\nNow that you have the two redheads' attention, you insist on knowing what - exactly - is going on here.");
			
			outputText("\n\nGlaring at Isabella, Hel says, <i>\"This...  cow...  stole my bandanna a few months ago and won't give it back.\"</i>");
			
			outputText("\n\nIsabella makes an indignant huff and turns her nose up at the salamander.  <i>\"Do not listen to this little liar, [name].  I found it in ze hands of ze gnolls, und most certainly did not 'steal' it.\"</i>");
			
			outputText("\n\n<i>\"And what the fuck is SHE doing here anyway!?\"</i>  Hel demands.");
			
			outputText("\n\nThe cow-girl's brow furrows.  <i>\"Ja!  I could ask much ze same question.\"</i>");
			
			outputText("\n\nYou spend the next few minutes explaining how you met each of the women in turn, receiving suspicious nods from Hel and Isabella.  Once you've explained yourself to the pair attempting to intimidate you, you ");
			//(corruption = pussy)
			if (player.cor < 50) outputText("fall silent under their considering gazes.");
			//(corruption = high enough to call bitches out when they're hypocrites)
			else outputText("glower balefully at them, as if to challenge either to invite your opinion of their own sexual 'résumé' with an ill-considered comment.");
			
			if (isabellaAccent()) outputText("\n\n<i>\"Zo,\"</i> Isabella finally says, shifting her gaze from you to the salamander.  <i>\"You two are... lovers, ja?  Und here Isabella vas about to thrash you!\"</i>");
			else outputText("\n\n<i>\"So,\"</i> Isabella finally says, shifting her gaze from you to the salamander.  <i>\"You two are... lovers, huh?  And here I was about to thrash you!\"</i>");
			
			outputText("\n\n\"<i>Yeah,</i>\" Hel answers with a little scoff, <i>\"And, I guess if you're [name]'s friend...  you're probably alright.  Although I was winning, you impertinent bitch.\"</i>");
			
			outputText("\n\nA dopey smile spreads across your face as Hel offers Isabella her hand.  Warily, the cow-girl shakes it.  The girls increase the tempo of the handshake competitively until both their pairs of massive tits are jiggling.");
			
			if (isabellaAccent()) outputText("\n\n<i>\"Oh... und here,\"</i> Isabella says, breaking the (milk)shake to pull the blue bow from her tail and hand it over to Hel.  With a happy gasp, Hel grabs it and ties it around her forehead - making herself look like some kind of half-naked commando in the process - though it's quickly hidden under her long red hair.");
			else outputText("\n\n<i>\"Oh... and here,\"</i> Isabella says, breaking the (milk)shake to pull the blue bow from her tail and hand it over to Hel.  With a happy gasp, Hel grabs it and ties it around her forehead - making herself look like some kind of half-naked commando in the process - though it's quickly hidden under her long red hair.");
			
			outputText("\n\n<i>\"Yeah.  You're alright.\"</i>  Hel says, finally sheathing her sword.  <i>\"Thanks for giving me my mom's bandana back.\"</i>");
		
			if (isabellaAccent()) outputText("<i>\"You are... velcome,\"</i> Isabella says before collecting some of the scattered belongings from the ground.  You continue your tour, now that the girls are...  not going to murder each other in the middle of the night, at least.");
			else outputText("<i>\"You're... welcome,\"</i> Isabella says before collecting some of the scattered belongings from the ground.  You continue your tour, now that the girls are...  not going to murder each other in the middle of the night, at least.");
			flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] = 1;
		}
	}
	//If Rath is in Camp
	else if (flags[kFLAGS.HEL_INTROS_LEVEL] < 3 && player.findStatusEffect(StatusEffects.CampRathazul) >= 0) {
		flags[kFLAGS.HEL_INTROS_LEVEL] = 3;
		outputText("You take Hel over to the small section of camp Rathazul has cordoned off for his 'laboratory,' surrounding himself with glass tubes and beakers and other, stranger instruments.  You poke through the array of equipment to find old Rath sitting in front of some experiment or another, furiously scribbling notes.  With a light cough, you alert him to your presence.");
		
		outputText("\n\n<i>\"Hmm?  Oh, good news ever- mother of god, what the devil have you got there?\"</i>  the old rat yelps, scrambling for the spectacles he just dropped.  By the time he's got them adjusted, Hel's pressed her face right up against him, giving the poor man such a start he collapses.");
		
		outputText("\n\n<i>\"Well hello to you too, gramps,\"</i> Hel laughs, offering Rath a hand up.");
		
		outputText("\n\nGrumbling a 'thankyouverymuch,' Rath struggles to his feet and stares at Hel.  <i>\"Ahhh, a salamander! I haven't seen one of your kind in some time.  I thought you all moved off to the volcanic region...\"</i>");
		outputText("\n\n<i>\"Not all,</i>\" Hel says with a wink.  <i>\"THIS salamander, for instance, is moving in...  Oh, right about here, I'd say,\"</i> she says, looking toward what's to be her part of the camp.");
		
		outputText("\n\n\"<i>Goodness gracious, you certainly collect people, don't you, [name]?</i>\"");
		
		outputText("\n\nYou chuckle, but before you can answer, Hel is struck by a sudden bimbo moment as she looms over some of the frothing beakers.  <i>\"Oooh, what's in here!?\"</i>");
		
		outputText("\n\n<i>\"DON'T TOUCH THAT, DAMN YOUR EYES!\"</i> Rath shouts, shooing her away.  <i>\"Stay out of my laboratory!\"</i>");
		
		outputText("\n\nHel recoils, stumbling away from Rath's experiments.  <i>\"Damn, old man. I was just gonna ask if you could maybe help me set up a still or something?\"</i>");
		
		outputText("\n\n<i>\"A-wha?  Oh! I see, well in that case... Hmm, I suppose I could do with a bit of the good stuff, yes... Well, we'll see, young lady.  We'll see.\"</i>");
		
		outputText("\n\nLaughing, you lead Hel along towards her new home.");
	}
	//If Bimbo Sophie is at Camp:
	else if (flags[kFLAGS.HEL_INTROS_LEVEL] < 4 && bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		flags[kFLAGS.HEL_INTROS_LEVEL] = 4;
		outputText("As you help Hel string up her hammock between a few of the rocks inside your perimeter, you hear the tell-tale flapping of useless wings and a clattering of claws on the hard-packed dirt.  You brace for impact as your bimbo harpy prances up to you, planting a big, wet kiss on your cheek");
		//{PC lust goes up if not immunized to luststick}
		outputText(".");
		
		outputText("\n\n<i>\"Yay!  My special little cutie is back!</i>\"  Sophie exclaims, giggling as she wraps her feathered arms around you.  \"<i>Is my " + player.mf("hunk","babe") + " interested in like, some 'fun'?\"</i>");
		
		outputText("\n\nYou're about to give your answer when suddenly Sophie is yanked off you, Hel's muscular arms locked around her neck.  \"<i>You keep your claws off my [name], you feather slut!</i>\"  Hel growls, compressing Sophie's neck until the harpy bimbo squirms and gags, her flush face turning a deep blue.");
		
		outputText("\n\n\"<i>Hey, hey, HEY!  Break it up!</i>\"  You snap, harshly enough to make Hel drop the dumb blonde.");
		
		outputText("\n\n<i>\"What... what the FUCK is this thing doing here, [name]?\"</i>  Hel yells, pointing an accusing finger at Sophie, who's sitting in a hapless pile on the ground, swaying slightly as her big chest heaves.  You try to explain, but Hel's having none of it - she seems <b>pissed</b>. <i>\"Look, [name], I don't know why you have a harpy in your camp, and I don't care.  Just...  just get rid of her, alright?  I can't...  I refuse to be around this thing!\"</i>");
		
		outputText("\n\n<i>\"Wha?\"</i>  Sophie says, obviously overwhelmed by all the attention.  <i>\"Do you guys, like, wanna fuck?  Ooh, we could all do it, like, together!\"</i>");
		
		outputText("\n\nWelp.  You could boot Sophie out of camp like Hel wanted, though she isn't likely to survive out in the wilds with her slutty body and stupid mind.  Or, you could tell Hel to pack up and leave instead; at least she can take care of herself.  ");
		//{If easy int check is passed:}  
		if (player.inte >= 40 || player.inte/5 + rand(20) + 1 > 10) {
			outputText("Or, maybe there's a way to make this work...");
			//(Display Option: [Boot Sophie] [Boot Hel] [Work it Out])
			menu();
			addButton(0,"Boot Sophie",bimboSophieGetsBooted4Firebutt);
			addButton(1,"Boot Hel",bootHelOutForBimboSophie);
			addButton(2,"Work It Out",workItOutWithSophieAndFireTits);
			return;
		}
		menu();
		addButton(0,"Boot Sophie",bimboSophieGetsBooted4Firebutt);
		addButton(1,"Boot Hel",bootHelOutForBimboSophie);
		return;
	}
	else {
		flags[kFLAGS.HEL_INTROS_LEVEL] = 9001;
		playerMenu();
		return;
	}
	menu();
	addButton(0,"Next",helFollowersIntro);
}


//[Boot Sophie]
private function bimboSophieGetsBooted4Firebutt():void {
	clearOutput();
	outputText("You sigh and pick Sophie up, slinging the harpy over your shoulders.  <i>\"Yaaaay~\"</i> she cheers.  </i>\"I'm going for a ride!\"</i>");
	
	outputText("\n\nYou take her a fair ways outside of camp, headed towards the mountains.  Once the peaks are in sight, you dump Sophie on the ground and tell her to scram.");
	
	outputText("\n\n<i>\"Whaaaa?\"</i>  She whines, staring at you with her big, dim eyes.  <i>\"Whadda ya mean, babe?\"</i>");
	
	outputText("\n\nYou spend a few moments explaining to Sophie, using small, slow words, that she needs to fend for herself, now.  She just stares at you, completely blank.  When you finish, she simply blinks, grins, and says, <i>\"So you, uh, wanted to do it in the mountains?</i>\"");
	
	outputText("\n\n<i>\"N-no, Sophie.  You need to leave, now.\"</i>");
	
	//{If PC has a gang of Mino Sons}
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] >= 3) {
		outputText("\n\nAs you're trying to get rid of the dumb blonde you made, you hear the clop of hooves approaching.  You look up in time to see a few familiar faces - your minotaur sons!");
		outputText("\n\n<i>\"Hey there, mom,\"</i> the biggest of them says, <i>\"Whatcha got there?  You bring us a present?\"</i>");
		outputText("\n\nNo, you di- hey, wait a minute...");
		outputText("\n\n<i>\"Yeah, I did,\"</i> you say, picking Sophie up and giving her a little push toward your boys.  <i>\"I thought you horny boys might like a little harpy slut of your very own.\"</i>");
		
		outputText("\n\n<i>\"Oh!  Hell yeah!\"</i>  some of them say, grabbing Sophie, their big dicks hardening shamelessly.");
		
		outputText("\n\n<i>\"Just take good care of her, and she'll give you PLENTY of little 'taurs of your own,\"</i> you say, watching with a little smile as Sophie giggles brainlessly at the boys' gropes and teases - and then groans happily as one of them slides right into her.  You shake your head and head on back to camp, confident that Sophie's found a... well, not a good home, but what the hell.");
		flags[kFLAGS.MINO_SONS_HAVE_SOPHIE] = 1;
	}
	//{If PC don't have no minogang yet}
	else {
		outputText("\n\n<i>\"Well, I guess this is goodbye...\"</i> You say, getting ready to leave.");
		outputText("\n\nAs you start to walk away, you're thrust forward as Sophie leaps onto your back, giggling and hugging you.  You throw her back, a bit too violently, and tell her to stay.  With a turn you start to walk back, but after just a few moments you see Sophie following you, bounding after you with a brainless smile.");
		outputText("\n\n<i>\"No, Sophie!\"</i>  you command.  <i>\"Stay!\"</i>");
		
		outputText("\n\n<i>\"B-babe?\"</i>");
		
		outputText("\n\n<i>\"STAY!\"</i>");
		
		outputText("\n\n<i>\"But...\"</i>");
		
		outputText("\n\n<i>\"STAY!\"</i>");
		
		outputText("\n\nYou put out a hand, commanding the harpy to remain as you retreat, remaining in earshot just in time to hear her break down in tears.");
		
		outputText("\n\nGod DAMMIT, Hel.");
	}
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[Boot Hel]
private function bootHelOutForBimboSophie():void {
	clearOutput();
	outputText("<i>\"Nope, you get out,\"</i> you answer, scowling at the salamander.");
	
	outputText("\n\n<i>\"What.\"</i>  She says, deadpan.");
	
	outputText("\n\n<i>\"You.  Get.  Out.\"</i>");
	
	outputText("\n\n<i>\"What the fuck, [name]?  Y-you're choosing a BIMBO over ME!?\"</i>");
	
	outputText("\n\n<i>\"Yeah.  Now get the fuck out.\"</i>");
	
	outputText("\n\n<i>\"I... well fine!  Fuck you anyway, [name].  Fuck you!\"</i>");
	
	outputText("\n\nHel grabs her shit and leaves.  She scowls over her shoulder as she disappears over the horizon.");
	
	outputText("\n\n<i>\"Bye!\"</i>  Sophie calls after her, waving energetically.");
	//Block future move ins
	flags[kFLAGS.HELIA_FOLLOWER_DISABLED] = 1;
	//Reduces her encounter rate
	doNext(camp.returnToCampUseOneHour);
}

//[Work it Out]
private function workItOutWithSophieAndFireTits():void {
	clearOutput();
	outputText("You cross your arms and tell Hel to deal with it, remarking that you won't just dump Sophie out in the wilderness - she can't take care of herself - but you still want Hel around.");
	outputText("\n\n<i>\"I... But WHY, [name]?  It's a harpy. They're evil!\"</i>");
	outputText("\n\n<i>\"Sophie's not.  And she's too stupid to survive on her own.\"</i>");
	outputText("\n\n<i>\"Hey... you're a cutie!\"</i>  Sophie suddenly says, jumping up and rushing Hel.  She tries to wrap her arms around Hel, causing her to plant a slap across her face.  Sophie recoils a bit, rubbing her - now red -  cheek.  \"<i>Hey... I'm not, like, into rough stuff like that, babe.</i>\"");
	outputText("\n\n<i>\"I...  what?  Gah!\"</i>  She throws her arms into the air.  \"<i>What the fuck's wrong with you, ya' dumb piece of shit?</i>\"");
	
	outputText("\n\nYou explain your bimbofication of the slutty harpy, and remind her that you've been saying she's too stupid to leave camp.");
	
	outputText("\n\nHel sighs, and rolls her eyes.  <i>\"I dunno, [name]. I don't like having her around, but - hey, get off - I guess if you're sure she's harmle- DAMMIT woman get your tits out of my face - I guess I can live with he- okay, okay, gimme a minute to settle in and I'll fuck ya already!  Damn!\"</i>");
	outputText("\n\nWell, maybe they'll get along after all...");
	flags[kFLAGS.KEEP_HELIA_AND_SOPHIE] = 1;
	doNext(camp.returnToCampUseOneHour);
}
	
//If Hel is at Camp and Isabella Arrives, neither are cool
public function angryHelAndIzzyCampHelHereFirst():void {
	clearOutput();
	outputText("Showing Isabella around, you eventually come to the chaotic, cluttered part of camp inhabited by Hel the salamander, who's currently sitting on her hammock sharpening her scimitar.");
	outputText("\n\nYou only have a moment to remember Hel's disdain for the cowgirl before...");
	outputText("\n\n<i>\"Oh, what the fuck is SHE doing here!?  OI, BITCH!\"</i>  Hel yells, dropping her whetstone and grabbing her scimitar.  Isabella has only a moment to react before Hel sinks her blade into the cowgirl's shield, nearly punching through it.");
	
	outputText("\n\n<i>\"Y-you!\"</i> Isabella stammers.  She recovers from her surprise a moment later, throwing Hel back and slinging her arm through the shield's straps.  <i>\"");
	if (isabellaAccent()) outputText("V");
	else outputText("W");
	outputText("hat are YOU doing here?!\"</i>");
	
	outputText("\n\nBefore the two of them can come to further violence, you leap between them and try to hold them apart.  You suffer the brunt of their aggression for a few moments, but manage to hold them off for the moment until they come down off their combat high.");
	//(Continued Below)
	//Hel meets Izzy, Con't(C)
	
	outputText("\n\n<i>\"[name]!?\"</i> They both blurt at once, surprised by your intervention.");
	outputText("\n\nNow that you have the two redheads' attention, you insist on knowing what - exactly - is going on here.");

	outputText("\n\nGlaring at Isabella, Hel says, <i>\"This...  cow...  stole my bandanna a few months ago and won't give it back.\"</i>");
	
	outputText("\n\nIsabella makes an indignant huff and turns her nose up at the salamander.  <i>\"Do not listen to this little liar, [name].  I found it in ze hands of ze gnolls, und most certainly did not 'steal' it.\"</i>");
	
	outputText("\n\n<i>\"And what the fuck is SHE doing here anyway!?\"</i>  Hel demands.");
	
	if (isabellaAccent()) outputText("\n\nThe cow-girl's brow furrows.  <i>\"Ja!  I could ask much ze same question.\"</i>");
	else outputText("\n\nThe cow-girl's brow furrows.  <i>\"Yeah!  I could ask you much the same question.\"</i>");
	
	outputText("\n\nYou spend the next few minutes explaining how you met each of the women in turn, receiving suspicious nods from Hel and Isabella.  Once you've explained yourself to the pair attempting to intimidate you, you ");
	//[(corruption = pussy)
	if (player.cor < 50) outputText("fall silent under their considering gazes.");
	//(corruption = high enough to call bitches out when they're hypocrites)
	else outputText("glower balefully at them, as if to challenge either to invite your opinion of their own sexual 'résumé' with an ill-considered comment.");
	
	if (isabellaAccent()) outputText("\n\n<i>\"Zo,\"</i> Isabella finally says, shifting her gaze from you to the salamander.  <i>\"You two are... lovers, ja?  Und here Isabella vas about to thrash you!\"</i>");
	else outputText("\n\n<i>\"So,\"</i> Isabella finally says, shifting her gaze from you to the salamander.  <i>\"You two are... lovers, huh?  And here I was about to thrash you!\"</i>");
	
	outputText("\n\n\"<i>Yeah,</i>\" Hel answers with a little scoff, <i>\"And, I guess if you're [name]'s friend...  you're probably alright.  Although I was winning, you impertinent bitch.\"</i>");
	
	outputText("\n\nA dopey smile spreads across your face as Hel offers Isabella her hand.  Warily, the cow-girl shakes it.  The girls increase the tempo of the handshake competitively until both their pairs of massive tits are jiggling.");
	
	if (isabellaAccent()) outputText("\n\n<i>\"Oh... und here,\"</i> Isabella says, breaking the (milk)shake to pull the blue bow from her tail and hand it over to Hel.  With a happy gasp, Hel grabs it and ties it around her forehead - making herself look like some kind of half-naked commando in the process - though it's quickly hidden under her long red hair.");
	else outputText("\n\n<i>\"Oh... and here,\"</i> Isabella says, breaking the (milk)shake to pull the blue bow from her tail and hand it over to Hel.  With a happy gasp, Hel grabs it and ties it around her forehead - making herself look like some kind of half-naked commando in the process - though it's quickly hidden under her long red hair.");
	
	outputText("\n\n<i>\"Yeah.  You're alright.\"</i>  Hel says, finally sheathing her sword.  <i>\"Thanks for giving me my mom's bandana back.\"</i>");

	if (isabellaAccent()) outputText("<i>\"You are... velcome,\"</i> Isabella says before collecting some of the scattered belongings from the ground.  You continue your tour, now that the girls are...  not going to murder each other in the middle of the night, at least.");
	else outputText("<i>\"You're... welcome,\"</i> Isabella says before collecting some of the scattered belongings from the ground.  You continue your tour, now that the girls are...  not going to murder each other in the middle of the night, at least.");
	flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}



//Introduction -- Followers -> Helia
public function heliaFollowerMenu(display:Boolean = true):void {
	if (display) 
	{
		clearOutput();
		spriteSelect(68);
	}
	if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 2) {
		if (flags[kFLAGS.HELIA_ANAL_TRAINING_OFFERED] == 0 && display && player.biggestCockArea() > heliaAnalCapacity()) {
			heliaAnalTrainingPrompt();
			return;
		}
		if (display) outputText("You call your salamander lover over, and in a few moments Hel walks your way, hips and tail swaying gaily as she moves.  She wraps an arm around your shoulders, pressing her soft, warm body against yours, and grins.  <i>\"Heyya, lover mine.  You need anything?\"</i>");
		menu();
		//Hel Camp Follower menu
		//Options:
		//Talk
		//[If before 21:00: "Hug" else "Cuddle"]
		//Spar
		//Boxing
		//Rough Sex (Needs normal lust to appear)
		//Gentle Sex (Regardless of lust)
		//Threesomes
		//Take a Bath
		//Appearance
		if (flags[kFLAGS.CODEX_ENTRY_SALAMANDERS] <= 0) { //Force unlock for existing saves who still have Helia as lover.
			flags[kFLAGS.CODEX_ENTRY_SALAMANDERS] = 1;
			outputText("\n\n<b>New codex entry unlocked: Salamanders!</b>")
		}
		addButton(0,"Appearance",helSpawnScene.heliasAppearanceScreen, null, null, null, "Examine Helia's appearance.");
		if (player.lust >= 33) {
			addButton(1,"Sex",heliaRoughSex, null, null, null, "Initiate sex with Helia.");
			addButton(2,"Threesomes",heliaThreesomes, null, null, null, "Invite someone for threesomes activity with Helia!");
		}
		addButton(4,"Talk",heliaOptions, null, null, null, "Discuss with Helia about various topics.");
		if (!kGAMECLASS.helScene.pregnancy.isPregnant) addButton(5,"Spar",sparWithHeliaFirebuttsAreHot, null, null, null, "Do some quick fight sessions!");
		else outputText("\n\n<b>Helia will not spar or box while pregnant.</b>");
		if (!kGAMECLASS.helScene.pregnancy.isPregnant) addButton(6,"Box",boxWithInCampHel, null, null, null, "Box with Helia and train your strength and toughness.");
		if (flags[kFLAGS.HEL_LOVE] == 1 || flags[kFLAGS.HEL_LOVE] == -1) {
			if (player.hasCock() && player.cockThatFits(heliaCapacity()) >= 0 && player.lust >= 33 &&
					!helPregnant() && flags[kFLAGS.HELSPAWN_AGE] == 0) addButton(7,"Have A Kid",helSpawnScene.haveAKid, null, null, null, "Get Helia pregnant and start a family with her.");
		}
		addButton(14,"Back",camp.campLoversMenu)
	}
	else if (flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1) {
		if (flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1) {
			if (display) outputText("(You've reached the culmination of Helia's current storyline.  Stay tuned for more!)");
		}
		else {
			if (display) outputText("You approach Hel as she's pacing around camp.  She's clad in her normal field attire: a simple scale bikini top and leather thong which supports her scimitar's scabbard.  Her cloak is loosely thrown over her shoulders, giving her a slight measure of protection from the mountain's harsh environs.");
			if (display) outputText("\n\n\"<i>Heya, [name]! Ready to hit the road?</i>\"");
			if (flags[kFLAGS.HARDCORE_MODE] > 0) {
				if (display) outputText("\n\n<b>You are in Hardcore Mode. Are you sure you want to embark on the quest? You cannot return until you defeat the opponents and if you get defeated, your save file is permanently deleted.</b>");
			}
			//(Display Options: [Dungeon] [Not Yet])
			simpleChoices("Dungeon", kGAMECLASS.dungeons.heltower.goToHeliaDungeon, "", null, "", null, "", null, "Not Yet", kGAMECLASS.dungeons.heltower.notYet);
		}
	}
}

private function heliaOptions():void {
	if (kGAMECLASS.helScene.pregnancy.event >= 3 && flags[kFLAGS.HELIA_TALK_SEVEN] == 0) {
		helSpawnScene.heliaTalkSeven();
		return;
	}
	if (flags[kFLAGS.HELSPAWN_AGE] == 1 && flags[kFLAGS.HEL_TALK_EIGHT] == 0) {
		helSpawnScene.heliaTalkEight();
		return;
	}
	menu();
	addButton(0,"Discuss",talkToHel, null, null, null, "Talk to her about random topics.");
	if (model.time.hours >= 21) addButton(1,"Cuddle",hugASmokeyTail, null, null, null, "Cuddle with Helia and sleep with her.");
	else {
		if (flags[kFLAGS.SLEEP_WITH] == "Helia") addButton(1, "NoSleepWith", dontSleepWithHelia, null, null, null, "Stop sleeping with Helia, for now.", "No Sleep With");
		addButton(2,"Hug",hugASmokeyTail, null, null, null, "Give that salamander bitch a hug. Bitches love hugs.");
	}
	if (flags[kFLAGS.HELIA_ANAL_TRAINING_OFFERED] > 0 && flags[kFLAGS.HELIA_ANAL_TRAINING] < 2 && player.biggestCockArea() > heliaAnalCapacity() && player.hasItem(consumables.GOB_ALE, 1)) addButton(3, "Anal Train", heliaGapeSceneChoices);
	//addButton(4, "Futafication", talkAboutFuta, null, null, null, "See if she's in the mood to grow a new penis.");
	addButton(5, "Bathe", takeABath, null, null, null, "Swim in stream with Helia.");
	if (flags[kFLAGS.HELSPAWN_AGE] == 1) addButton(7,flags[kFLAGS.HELSPAWN_NAME],helSpawnScene.playWithYourKid, null, null, null, "Spend some time with your salamander child.");
	if (flags[kFLAGS.HEL_GUARDING] == 0) addButton(8,"GuardCamp",helGuardToggle, null, null, null, "Request her to guard the camp every night.", "Guard Camp");
	else addButton(8,"NoGuarding",helGuardToggle, null, null, null, "Request her to stop guarding the camp.", "No Guarding");
	addButton(14,"Back",heliaFollowerMenu);
}

private function dontSleepWithHelia():void {
	clearOutput();
	outputText("You decide not to sleep with Helia at night, for now.");
	flags[kFLAGS.SLEEP_WITH] = "";
	heliaOptions();
}

/*Replaced by a function in heliaPreggers.as: heliasAppearanceScreen
//Hel: Appearance	
private function helFollowerAppearance():void {
	clearOutput();
	outputText("Hel the salamander stands seven feet tall, with pale skin and thick, bright-red scales covering her arms and legs, though she has a normal human torso and face.  A fiery tail swishes gaily behind her, blazing with a bright orange glow that lets off a pleasant heat, though it never seems to burn you.  Hel is wearing her scale bikini and a leather thong, and using her scimitar as a weapon.  She has a human face, with bright red eyes, gentle, feminine features and a smattering of pale scales on her cheeks, like freckles.  Hel has long, bright-red hair bound in a pony-tail that hangs down her back.  She has wide-flared hips and a soft, squishy butt.  Her two reptilian legs are visibly adorned with scales and claws, ending in soft, leathery soles.");
	if (flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] >= 1) outputText("  Hel's blue bandanna is wrapped around her brow, mostly hidden beneath her fiery hair.");
	outputText("\n\nHel has a pair of big, soft E-cup breasts, each with a 0.5 inch nipple at their tip.");
	
	outputText("\n\nShe has a warm, wet, and accommodating pussy between her legs.");
	
	outputText("\n\nHel has a single tight asshole between her buttcheeks, right where it belongs.");
	
	menu();
	addButton(0,"Next",heliaFollowerMenu);
}*/
//Hel: Spar Intro
private function sparWithHeliaFirebuttsAreHot():void {
	clearOutput();
	outputText("Giving Hel a playful punch on the shoulder, you ask the salamander-girl if she'd be up for a little battle practice.");
	outputText("\n\n<i>\"Oh?  Well, it's certainly been awhile since you and I fought out on the plains...  Alright, let's do it, [name]!  But heads up, I might just need to have my way with you after I push your face in the dirt!\"</i>");
	outputText("\n\nYou ready your [weapon] and prepare for battle!");
	startCombat(new Hel());
	monster.createStatusEffect(StatusEffects.Sparring,0,0,0,0);
	//No gems.
	//monster.XP = 1;
	monster.gems = 0;
}

//Hel Whips [name]'s Ass
internal function loseToSparringHeliaLikeAButtRapedChump():void {
	clearOutput();
	//If HP loss) 
	if (player.HP < 1) outputText("You collapse on the ground, overwhelmed by pain and exhaustion caused by the berserker's onslaught.");
	else outputText("Your arousal is too great, and your mind can no longer focus on anything but a desperate need for release.  Lust robs you of your will, and with buckling knees you collapse.");
	
	outputText("\n\nYou look up to see Hel looming over you, slowly removing her bikini, revealing her ample breasts and a glistening cunt.  <i>\"What's the matter, [name]?\"</i> she teases, tossing her leather thong onto your face, \"<i>Pick yourself up!  Fight me more!  Show me what my Champion can do!  COME ON!</i>\"");
	
	outputText("\n\nUnable to comply, you look up at Hel helplessly.  She sighs.  <i>\"Well, there's no shame in losing,\"</i> she says, offering a hand up.  Shakily, you take it - and she pulls you right into a rough kiss.");
	
	outputText("\n\n<i>\"But, to the victor go the spoils,\"</i> she says, pushing her body against yours.  You can feel the dampness between her thighs, soaking into your [armor].  She really gets off on violence, doesn't she?  <i>\"Come on, [name], I'll even let you choose how you get me off...\"</i>");
	
	outputText("\n\nWell, you might as well enjoy yourself...");
	//[Display "Rough" sex options]
	heliaRoughSex(false);
}

//PC Whips Hel's Ass
internal function PCBeatsUpSalamanderSparring():void {
	clearOutput();
	//(If HP loss) 
	if (monster.HP < 1) outputText("Unable to withstand your onslaught, the salamander collapses to a knee, barely supporting her weight on her sword.");
	else outputText("Panting heavily, knees snaking, she collapses, heavily leaning upon her sword.");
	
	outputText("\n\n<i>\"Come on, [name],\"</i> Hel groans, swaying unsteadily.  ");
	if (monster.HP < 1) outputText("<i>\"Kick my ass a little harder, why don't you?\"</i>");
	else outputText("<i>\"Turn me on till I can't think straight, why don't you?\"</i>");
	outputText("  You chuckle and offer her a hand up. The blushing Salamander takes it as you pull her into a tight embrace.  The cool wetness between her thighs a potent reminder of how much your lover seems to get off on violence.  Since she's so turned on, you could easily turn this into some rough loving.");
	
	//[Display "Rough" sex options]
	heliaRoughSex(false);
	//cleanupAfterCombat();
}


//TALK to Hel @ Camp (Play at random after 1st)

private function talkToHel():void {
	clearOutput();
	//Hel Talk 1 (Play at First Time)
	if (flags[kFLAGS.FOLLOWER_HEL_TALKS] == 0) {
		outputText("You run a hand through Hel's hair and ask the recent addition to your camp if she'd like to talk.");
		outputText("\n\n<i>\"Sounds good to me, " + player.mf("bud","babe") + ",\"</i> Hel grins, leading you by the arm to a rock near her hammock.  The two of you sit yourselves down, with Hel locking her fingers through yours in her lap.  <i>\"So what's on your mind, lover mine?\"</i>");
		
		outputText("\n\nFirst, you ask her how she's settling in.  She smiles at the question, <i>\"It's good to be here, [name].  It's nice to know someone's got my back while I sleep, that I have someone who can take care of me if I get sick or hurt...  But most of all, I'm loving being so close to my best friend.\"</i>  She leans over and plants a little kiss on your cheek.");
		
		//(If Rath's at camp):
		if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0) {
			outputText("\n\n<i>\"Oh!  And check out what the old man helped me set up!\"</i>  Hel adds, quickly hopping down and going to a large metal cask sitting under the hammock.");
		}
		else
			outputText("\n\n<i>\"Oh, hey, check out what I made!\"</i>  Hel adds, quickly hopping down and going to a large metal cask sitting under the hammock.");
		
		outputText("\n\nShe grabs a pair of new-looking steins and pours...  something foul-smelling...  from the metal cylinder.  Once each stein has a nice, frothy top, she saunters back to you and swings into your lap, handing you one of the glasses.  Taking an experimental taste, you realize it's...  alcohol!");
		
		outputText("\n\n<i>\"Yep!\"</i>  Hel laughs, knocking back half her cup in one slurp.  Hard liquor runs down her chin, staining the tops of her breasts; a moment later, she lets out a powerful belch that smells of brimstone and burning booze.  <i>\"Fiiiiinally got the still working.  Let there be booze!\"</i>  she declares, clinking her stein against yours before chugging the rest of it.  You chuckle and join her, kicking back a long draught.  ");
		//(If Toughness <50: 
		if (player.tou < 50) outputText("You cough and gag, eyes misting as the pure-grain booze burns your throat worse than hot coals.  Hel laughs riotously, slapping you on the back hard enough to cause booze to snort out through your nose.");
		else  outputText("You knock back the stein easily, your super-human endurance keeping you from choking on the powerful brew.  Impressed, Hel gives you a high-five and throws her head back in a laugh.");
		outputText("\n\n<i>\"So yeah,\"</i> Hel laughs, throwing an arm around your shoulder, <i>\"I'm settling in just fine. Good booze, great camp...  even better company.\"</i>");
		
		outputText("\n\nHel nestles her head on your [chest], wrapping her tail around your waist and curling up in your lap.  Smiling at your salamander, you wrap your arms around her and finish off your stein as Hel cuddles up.");
	}
	//Hel Talk 2
	else if (flags[kFLAGS.FOLLOWER_HEL_TALKS] == 1) {
		outputText("Sitting Hel down, you ask if she's got any stories she'd like to share.  After all, she's been adventuring for years - surely she's got some fun tales to tell.");
		
		outputText("\n\n\"<i>Me? Good stories?  Psssh, naw,</i>\" she laughs, grabbing a glass from her home-made still and filling it up.  \"<i>Well, there's always that one time...  Okay, context: way back when, three, maybe four years ago.  I was still with some of the old tribe - we hadn't quite gotten ourselves wiped out yet, but we were already hurting pretty bad, you follow?  So we're sending out little scouting parties: raiders, really, going to steal what we can't forage ourselves from the gnolls.  Fuck gnolls, by the way.  Just throwin' that out there.  Anyway, so I get slotted for a party: me, Anika, who made me look like a busty giantess - and I'm on the short side for a salamander bitch - though she was amazing with a bow; and this big fucking bruiser, Dane.  Oh, shit, Dane was awesome.  He'd literally rip people in half.  Saw him do it two, three times.  Big scary motherfucker, but the nicest guy otherwise.</i>\"");
		
		outputText("\n\n\"<i>Anyway.  Three of us, supposed to go out and get food.  Hard to fucking do at the best of times, but winter's setting in and all the gnoll tribes, rabbit-folk, and the damn centaurs are all picking everything they can find.  The plains are a fucking barren wasteland by now, and we've barely got enough stored away to last HALF the season.  Three of us go out hunting, but there's fucking nothing out there.  Well shit, right?  The fuck do we do now? Well, Anika, who's on point with her longbow, spots a gnoll camp.  Big fucking thing, tents surrounded by a wooden wall. Permanent type deal, like a little town.  Maybe a hundred assholes in there, we figure. Whoopsie fucking daisy.  But how're we supposed to know, right?  Who'da thunk there's really more like a thousand of the fucks packed in real tight in there.</i>\"");
		
		outputText("\n\n\"<i>But I'm spoiling it. Anika, Dane, and I decide we're gonna wait till dusk and climb the wall.  Break into the larders, grab a whole packload of gnoll food each, get out.  Good stuff, adding a few weeks to our meager supplies.  The three of us bunker down and wait till it gets dark, then scamper over the walls. It's all going perfectly.  So far, so good.</i>\"");
		
		outputText("\n\n\"<i>We make it into the larder - and Dane even gets to rip a gnoll bitch's head off after An shot her partner. Neither gets to make a peep.  So we sneak inside, and lo and behold, it's FULL of food. Enough to feed the tribe for a year, maybe even two.  Shit, we figured we should just double back and convince my mom, resident tribe leader, to assault the place.  Mom mighta been an over-cautious bitch, but it was such a juicy, tempting target.  She'd go for it, right?  Well, we gather up our packloads of food, and get ready to skedaddle, when all of a sudden a gnoll-boy - this puny, sissy little bitch - wanders in looking for a midnight snack.  He sees us, we see him. The little bugger screams before An puts an arrow through his throat.  Well, shit. There goes stealth, we think, as warrior-cunts start pouring out of the tents.</i>\"");
		
		outputText("\n\n\"<i>Holy fucking shit there were a lot of them.  We tried to escape, but...  Well, let's just say it didn't work out too well.  An manages to break through and climb over the walls, but Dane and I are too big and heavy and we get dragged back down before we can make it.  So yeah, captured by gnolls. Total bad end, we end up getting executed, lots of tears were shed.  Good stuff.</i>\"");
		
		outputText("\n\nYou scowl and tell Hel to finish the damn story.");
		
		outputText("\n\n\"<i>What?  That's how it ended -- I'm just a spooky ghost come to haunt sexy adventurers!</i>\"");
		
		//If Shouldra follower: 
		if (shouldraFollower.followerShouldra()) outputText("\n\nSuddenly, Shouldra pops out, seemingly from nowhere, and snaps, \"<i>Hey!  That's my job!</i>\" before vanishing.");
		
		outputText("\n\nYou give her a little punch on the shoulder.");
		
		outputText("\n\n\"<i>Ow, okay, okay.  Fine, if you want the horror story part... So Dane and I get captured. Shitting dick nipples there's lots of gnolls around us, all growling and snapping and jabbing us with spear hafts.  They prod us over to the biggest part of the camp, this tall wooden building, probably the only permanent building there.  We get tossed in the front doors, but the bitches leave us there; just close the door and chain it up from outside.  Total darkness inside, only light we have is the fire of our tails.  But it's an oppressive darkness, and we can only see a few feet around.</i>\"");
		
		outputText("\n\n\"<i>The walls are covered with gnoll boys, packed shoulder to shoulder along all fours.  Silent, still as rocks.  Dane punches one, hard enough to break a rib.  Looked like a sissy boy, but he doesn't even flinch.  He pops a boner, though. I remember THAT clear as day.  But anyway, so Dane and I wander around this great big hall, a mead hall, I guess, until we get to the other side, opposite the door.  There's a throne, huge fucking thing that dwarfs the two of us.  And on it is... the Amazon Queen!</i>\"");
		
		outputText("\n\nWhat.");
		
		outputText("\n\n\"<i>Yeah, no joke. The queen bitch, the alpha gnoll.  Huge cunt, decked in a mail bikini like mine, barely holding in these huge fuzzy tits of hers.  Big, soft, globular things with cleavage like a canyon.  The kind of tits you could lose yourself in, and... ehem ...  So there we are, facing down the gnoll queen and a hundred femboy sluts of hers.  She just leers down at us, leaning on her spear, grinning this wolfish grin.  I thought she was gonna eat us alive.  But she just grins at us for a long, long time, till my legs are shaking - hey, I wasn't such a badass back then, okay?</i>\"");
		
		outputText("\n\n\"<i>So just finally speaks, 'Ohhhh, what have we here?  A pair of precious little salamanders come to pay tribute to the Amazon Queen?  Well, well, how very thoughtful of you... Why, you even brought me dinner,' and a couple of her femboys grab the packs of food we stole -- then push us down on our knees.  We'd been disarmed, but now Dane and I are disrobed. They cut our clothes right off of us, left us naked in front of the queen bitch.  So she just grins some more, real menacing-like, and says, 'Well, I must find some way to show my appreciation...'</i>\"");
		
		outputText("\n\n\"<i>And then suddenly we're surrounded by dozens of naked gnoll-boys...</i>\"");
		
		outputText("\n\nYou think you know where this is going...  Do you want to listen to the rest of Hel's story?");
		menu();
		addButton(0,"Listen",listenToHelTalkAboutGnolls);
		addButton(1,"Shut Up",shutUpHelTalks);
		return;
	}
	//Hel Talk 3(C)
	else if (flags[kFLAGS.FOLLOWER_HEL_TALKS] == 2) {
		outputText("Just as you're starting to speak, Hel suddenly throws her arms around your shoulders and pulls you into her lap.  You yelp in surprise as your salamander lover holds you tight, running a hand through your [hair] as she settles onto the big rock near her hammock.  Giving a surprisingly girlish giggle, Hel nuzzles you, slipping her muscular legs and tail around your waist.");
		outputText("\n\n<i>\"Mine,\"</i> she purrs, nipping and kissing along the nape of your neck.");
	}
	//Hel Talk 4(C)
	else if (flags[kFLAGS.FOLLOWER_HEL_TALKS] == 3) {
		//Hel Talk 4(C)
		outputText("You ask Hel if she has a few minutes to spare.");
		outputText("\n\n<i>\"I dunno, I was about to go find some gnolls to beat up,\"</i> she laughs.  Before you can protest, your salamander chuckles and grabs your hand.  <i>\"Come on, lover, let's take a walk.\"</i>  You shrug and follow Hel, letting your lover lock her fingers through yours as the two of you head out onto the plains.");
		outputText("\n\nThough she keeps her sword out, Hel walks tantalizingly close to you, her wide, swaying hips occasionally brushing against you, or letting her tail wrap around your [legs] between steps.  As the two of you make it out on the plains, your lover begins to whistle, belting out a jaunty, soaring tune as she bats aside clumps of prairie grass with the flat of her scimitar.");
		
		outputText("\n\nAfter a few minutes wandering the plains, Hel stops in her tracks and, putting her arms around your shoulders, huskily whispers, <i>\"So...  What's on your mind, lover mine?\"</i>");
		
		outputText("\n\nYou slip your hands around Hel's waist and let her draw you into a long, tender kiss.  She pulls you tight against her, her large, soft breasts pressing against your [chest].  You cup her cheek, kiss her again, and let out a little gasp as Hel wraps her tail around you, holding you to her as she nestles her brow against yours, her red eyes gazing deeply into yours.");
		
		outputText("\n\n<i>\"Mmm, this is nice,\"</i> she whispers.  You smile and pull her down; you flop onto your back, bringing Hel with you, letting her nestle against your [chest].  <i>\"Ah!  Even better,\"</i> she chuckles, cuddling up around your body.  You run a hand through Hel's long, red hair.  She purrs like a cat, happily moving her scalp for you to get a better angle.");
		
		outputText("\n\n<i>\"Hey, [name],\"</i> Hel says after a long while, shifting to bring her face over yours.  By way of answer, you lean up and give her a little kiss.  She grins.  <i>\"I dunno if I've told you this lately, but...  Well,\"</i> she laughs, stroking your cheek, <i>\"there's no one I'd rather lie in the sun with than you.\"</i>");
		outputText("\n\nYou pull Hel down into another long, tongue-filled kiss.");
	}
	//Hel Talk 5(C)
	else if (flags[kFLAGS.FOLLOWER_HEL_TALKS] == 4) {
		outputText("<i>\"Hey, [name],\"</i> Hel says, slipping out of your grasp with a come-hither wag of her finger, <i>\"wanna have a drink with me?\"</i>");
		outputText("\n\n<i>\"Sure,\"</i> you say, following Hel over to her still.");
		
		outputText("\n\nShe pours out two tankards of ");
		if (helSpawnScene.helPregnant()) outputText("beer ");
		else outputText("fizzy, non-alcoholic beer ");
		outputText("and, swinging onto your lap, clinks her glass against yours.  <i>\"To loving friends and an awesome new home,\"</i> she says, raising her tankard high before knocking it back.  Before you can finish yours, Hel belches loudly and violently shakes her head");
		if (!helSpawnScene.helPregnant()) outputText(", her eyes crossing a little.  Looks like she was dipping in before you got here...");
		else outputText(".");
		
		outputText("\n\nHel laughs ");
		if (!helSpawnScene.helPregnant()) outputText("drunkenly");
		else outputText("happily");
		if (!helSpawnScene.helPregnant())
		{ 
			outputText(", filling her cup up again and, with a wide smile, jumping out of your lap.  <i>\"Hey, lover, check this out!\"</i> she shouts, grabbing her fiery tail in one hand and swirling a mouth-full of alcohol.  You have just enough time to take cover before Hel swings her tail around and spits a stream of pure-grain over it, resulting in a great gout of flame that streaks into the heavens.");
			//if Kiha is in camp: 
			if (kihaFollower.followerKiha()) outputText("  From across camp, you hear a certain dusky dragoness shout <i>\"HEY! That's MY trick, firebutt!\"</i>");
		
			outputText("\n\nHel giggles, and spews another fireball into the sky.  <i>\"Heh.  Hey, this is pretty fun.  C'mere, [name], try it!\"</i>");
		
			outputText("\n\nWith a little encouragement from your salamander lover, you gulp down a bit of booze and, lining your mouth up with her tail, spit out a combustible spray.  You stumble back as the sky alights with fire, ");
			if (kihaFollower.followerKiha()) outputText("further pissing off Kiha, who throws a rock at Hel, and ");
			outputText("shooting up like a beacon over the wasteland.");
		}
		else {
			outputText(" and launches into a series of debauched jokes. You answer her, lewd jest for jest.");
		}
		outputText("\n\n<i>\"Hehehe.  Nice one, lover,\"</i> Hel laughs, pulling you ");
		if (player.tallness < 60) outputText("up ");
		else outputText("down ");
		outputText("into a hug, mashing your face into her warm, soft bosom.  You struggle for air, finally bursting out of her tight cleavage.  Hel chuckles, running her hand through your [hair] as her fiery tail wags gaily behind her.");
		
		outputText("\n\n<i>\"Mmm, you're a cutie, you know that?\"</i>  Hel giggles, planting a kiss on your brow before letting you go.  By the time you get turned around again, Hel's already breathing fire again.");
	}
	//Hel Talk 6 (Needs Isabella and Kiha at camp; at least 1 gem)(C)
	else if (flags[kFLAGS.FOLLOWER_HEL_TALKS] == 5 && player.gems >= 1 && isabellaFollower() && kihaFollower.followerKiha()) {
		outputText(images.showImage("helia-follower-poker"));		
		var gems:int = 0;
		outputText("<i>\"Hey, [name],\"</i> Hel says with a sly grin.  <i>\"Me, Izzy, and spitfire were just playing a little game.  Wanna deal in?\"</i>");
		
		outputText("\n\n<i>\"Maybe.  What're you playing?\"</i>");
		
		outputText("\n\n<i>\"Something from Isabella's world...  Polka, or something.\"</i>");
		
		outputText("\n\n<i>\"Poker?\"</i> You suggest.");
		
		outputText("\n\n<i>\"Yeah, sure, whatever.  Wanna play!?\"</i>");
		
		outputText("\n\nYou shrug and follow Hel over to Kiha's nest.  The dragoness's table has been cleared off and stacked full of glittering gems, paper cards, and half-empty glasses of beer and wine.  Hel clears a spot for you before joining the other two busty redheads around the table and picking up a hand of five ancient-looking cards.");
		
		if (isabellaAccent()) outputText("\n\n<i>\"Ze game ist Poker, mein freunds,\"</i> Isabella says, passing you a set of cards.");
		else outputText("\n\n<i>\"The game is Poker, my friends,\"</i> Isabella says, passing you a set of cards.");
		
		outputText("\n\n<i>\"Polkawha?\"</i> Kiha asks, turning her cards one way and her head the other");
		if (!isabellaAccent()) outputText(", obviously only somewhat interested");
		outputText(".");
		
		if (isabellaAccent()) outputText("\n\n<i>\"Poker, zilly girl!\"</i> Isabella snaps.");
		else outputText("\n\n<i>\"Poker, silly girl!\"</i> Isabella snaps.");

		outputText("\n\n<i>\"SILLY GIRL!?\"</i>");
		
		outputText("\n\n<i>\"Chill your tits, spitfire,\"</i> Hel laughs, kicking back a shot of rum.  Kiha fumes, but manages to <b>not</b> leap across the table and tear into Isabella.");
		
		outputText("\n\nWith the fiery redheads all settled, you take a peek at your cards...");
		
		//{Make an INT check}
		if (rand(20) + 1 + player.inte/5 >= 15) {
			//[Successful]
			outputText("\n\nAbout an hour later, you sit proudly behind a massive pile of gems, collected from all three of your friends - as well as Hel's bikini and Isabella's corset.");
			
			outputText("\n\n<i>\"Fucking shit cunt bitch,\"</i> Hel declares, covering her chest with her scaly arms.");
			
			if (isabellaAccent()) outputText("\n\n<i>\"Und I thought you vere a beginner...\"</i> Isabella moans, her milky mammaries quivering in the cool air.");
			else outputText("\n\n<i>\"And I thought you were a beginner...\"</i> Isabella moans, her milky mammaries quivering in the cool air.");
			outputText("\n\n<i>\"I got no shame, bitches.\"</i>  Kiha, " + (flags[kFLAGS.KIHA_UNDERGARMENTS] > 0 ? "nearly " : "") + "nude before you got to her, laughs drunkenly before face-planting into her empty gem-pouch.");
			gems = 40 + rand(40);
		}
		//[Fail 1]
		else if (rand(3) == 0) {
			outputText("\n\n<i>\"Booyah, bitches,\"</i> Hel yells an hour later, raking in the last of the gems you cared to wager.  Isabella and Kiha glower at the salamander as she scoops her new wealth into a haversack.");
			outputText("\n\n<i>\"Y-you cheated!\"</i> Kiha yells, lurching to her feet.");
			if (isabellaAccent()) outputText("\n\n<i>\"Nein, zilly girl,\"</i> Isabella groans, crossing her arms, <i>\"Ve vere beaten by ze luck of ze draw.\"</i>");
			else outputText("\n\n<i>\"No, silly girl,\"</i> Isabella groans, crossing her arms, <i>\"We were beaten by the luck of the draw.\"</i>");
			
			outputText("\n\n<i>\"Literally,\"</i> you add, flicking your last losing hand away.");
			gems = -5 - rand(10);
		}
		//[Fail 2]
		else if (rand(2) == 0) {
			if (isabellaAccent()) {
				outputText("\n\n<i>\"Ja, ja, come to mama Isabella,\"</i> your feisty cow-girl laughs, throwing down a stunning, crushing hand.  Groaning, you, Hel, and Kiha all relinquish the last of the gems you can spare for the game.");
				outputText("\n\n<i>\"Oh, I zee ein new skirt in ze future!\"</i> Isabella laughs, dumping your gems into her pouch before sauntering off.");
			}
			else {
				outputText("\n\n<i>\"Yeah, yeah, come to mama Isabella,\"</i> your feisty cow-girl laughs, throwing down a stunning, crushing hand.  Groaning, you, Hel, and Kiha all relinquish the last of the gems you can spare for the game.");
				outputText("\n\n<i>\"Oh, I see a new skirt in my future!\"</i> Isabella laughs, dumping your gems into her pouch before sauntering off.");
			}
			outputText("\n\n<i>\"Fuckin' milkmaid,\"</i> Hel scoffs, knocking back another tankard of her home-brew.");
			
			outputText("\n\n<i>\"T-this isn't faaaiiiirrrrrrrr,\"</i> Kiha whines, brandishing her empty gem-purse.  <i>\"She knew the game better than us.  If we...  If I'd had a chance to learn it, why...\"</i>");
			
			outputText("\n\n<i>\"Oh, can it, spitfire,\"</i> Hel moans, dragging herself to her feet.  <i>\"I'm gonna go drink away the shame.\"</i>");
			gems = -5 - rand(10);
		}
		//[Fail 3]
		else {
			outputText("\n\n<i>\"I won?\"</i>  Kiha says, staring incredulously at the cards laid down on the table.  <i>\"Er, of course I won!  You idiots never had a chance!\"</i>");
			outputText("\n\n<i>\"Wax on, wax off, take my gems and piss off,\"</i> Hel grumbles, shoving her pile of currency to the dragoness.");
			
			if (isabellaAccent()) outputText("\n\n<i>\"Nein, you cannot rhyme a vord vith ze zame vord,\"</i> Isabella huffs, crossing her arms as Kiha rakes up all of the gems the three of you cared to lose that night.");
			else outputText("\n\n<i>\"No!  You can't rhyme a word with the same word!\"</i> Isabella huffs, crossing her arms as Kiha rakes up all of the gems the three of you cared to lose that night.");
			
			outputText("\n\nLaughing merrily, Kiha scoops up the last of the gems into her pack and walks off, humming a jaunty tune to herself, her tail wagging happily.");
			
			gems = -5 - rand(10);
			//[Display Message: You {gained/lost} X gems in the game!]
		}
		if (player.gems + gems < 0) gems = player.gems;
		if (gems < 0) outputText("\n\nYou lost " + gems + " gems in the game!");
		else outputText("\n\nYou gained " + gems + " gems in the game!");
		player.gems += gems;
		statScreenRefresh();
	}
	else {
		flags[kFLAGS.FOLLOWER_HEL_TALKS] = 1;
		talkToHel();
		return;
	}

	flags[kFLAGS.FOLLOWER_HEL_TALKS]++;
	doNext(camp.returnToCampUseOneHour);
}
	
//Shut up, slut
private function shutUpHelTalks():void {
	clearOutput();
	outputText("Quickly you interject before Helia can continue with the story; you've heard quite enough.  <i>\"Whaaaat?  We were just getting to the good part...\"</i>  Hel whines, rolling her eyes.  <i>\"Hey, you're the one who asked!\"</i>");
	outputText("\n\nYes... yes you did.  And you're regretting every moment of it.  Crossing her arms, the salamander folds her arms and huffs, <i>\"Oh you big baby!  Can't handle the thought of a thousand cocks eagerly thrusting... Oh, never mind.\"</i>");
	
	//{If PC has cock: 
	if (player.hasCock()) {
		outputText("\n\nAfter a moment, Hel adds, <i>\"Sorry, lover.  I just... get carried away with stories.  Wanted to be a bard, once.  Anyway, uh, sorry.  Didn't wanna make you uncomfortable...\"</i>");
	
		outputText("\n\nSuddenly, Hel flips herself into your lap, straddling your [legs].  <i>\"Don't worry though, lover... Your dick's still the best!\"</i>  She plants a quick kiss on your lips before bounding off to another part of camp.");
	}
	//{If PC is cockelless: 
	else {
		outputText("\n\nAfter a moment, Hel adds, <i>\"Sorry, lover. I just... get carried away with stories.  Wanted to be a bard, once.  Anyway, uh, sorry.  Didn't wanna make you uncomfortable... I'm sorry, lover.  I'll just, uh, wander off, then.\"</I.  Excusing herself, Hel gets up and heads off to attend to something else.  You don't really know how to feel about Hel's little romp with a gnoll village.  Perhaps it's best that you not dwell on it for too long.");
	}
	flags[kFLAGS.FOLLOWER_HEL_TALKS]++;
	doNext(camp.returnToCampUseOneHour);
}
//Listen In
private function listenToHelTalkAboutGnolls():void {
	clearOutput();
	outputText("Uninterrupted, Hel continues: \"<i>They're all short, girly-like (the opposite of the women, naturally), but they're all stroking stiffies around us. Well, you can see where this is going, huh? So before I can do shit about it, I've got two or three gnoll-pricks stuffed up every hole, they're basically using Dane and I as their personal toys.  The femboys don't wait long to cum, but every time one does, there's another slut to take his place.  I'm trying not to enjoy it, but... God damn, you know?  Three cocks up my twat and ass feels too good, all of them together; stretching me wide, one hammering in as two others pull out; they just keep cumming and cumming until I'm leaking gnollcum everywhere, and having myself a good old time as the whole harem just uses me again and again.  And all the while, the Amazon Queen's just reclining on her throne, urging her femboys on, stroking off this enormous clit-cock thing that'd make a minotaur feel inadequate. She just sits there, fapping, while we're used and abused for hours until we look like cum-white ghosts.</i>\"");
	
	outputText("\n\nHel pauses in her story to refill her tankard and knock it back in one go. She blinks hard, then grins devilishly.  \"<i>So after a couple hours of that, the Amazon Queen gets to her feet.  She's not cum yet, I think; been edging herself the entire time.  So she has this enormous, swollen clit that looks fit to rip a bitch apart.  She walks over to me, and her sluts withdraw - all at once, so suddenly I'm leaking spunk like a broken dam.  But she just hefts me up by the scruff of the neck and throws me on her throne; my hips are hanging off the lip, my ass is in the air. I can hear her licking her lips with anticipation.</i>\"");
	
	outputText("\n\n\"<i>She spreads my cheeks and drops this huge throbbing clit in my asscrack. The queen starts stroking off on me, hotdogging me, spreading all that delicious gnollcum around and pushing some - lots - back into my bum. I'm too broken to do anything about it; I just whimper and wiggle my hips, begging her to fuck me hard.</i>\"");
	
	outputText("\n\n\"<i>So she does. She finally slips that massive fucker inside me.  Gods, I was no virgin before, but I'd never had something so... so HUGE... rammed inside me.  She was not gentle. The queen just grabs my hips and hammers me, fucking my ass so hard that gnollcum is squirting out all over.  I scream and cry, but she just laughs quietly.  Whispers in my ear what a dirty slut I am, how I'm enjoying myself (and I am; I'm cumming again and again, make no mistake).  She ruts me and fucks me, stretching me wider than anything I'd ever taken before.  My asshole is gaping by the time she hilts me; I'm bawling like a baby, but she finally hilts me, pressing her giant hips right against my ass.  I can feel her giant, throbbing clit inside me, growing and shrinking to the slow, rhythmic beating of her heart.  She's still now, just gripping me.  She came, I think, just from how tight I was around her clitcock.</i>\"");
	
	outputText("\n\n\"<i>Then she whispers, 'Do you like it, girl? Do you love being torn apart by my scepter, with only gallons of my harem's cum to ease your pain?'</i>\"");
	
	outputText("\n\n\"<i>'Yes,' I sobbed. My mind was shattered. I couldn't think straight; I just wanted pleasure: more and more and more.</i>\"");
	
	outputText("\n\n\"<i>So she asks me, 'Do you want to taste my boys again?  To let them use you again and again, to break you into the perfect little toy for your Queen to use until you shatter?'</i>\"");
	
	outputText("\n\n\"<i>'Yes,' I begged.</i>\"");
	
	outputText("\n\n\"<i>So she throws me back to her sluts.  We go again, them and I; for hours and hours and hours until they're spent, utterly and completely spent.  They'd forgotten all about Dane by then; their queen demanded they fuck me until I was bloated and ruined by hundreds of cocks and gallons of semen.  It's dawn by the time the harem finishes with me.  By then I was nearly plastered to the floor by dried cum, but the Queen...  Laughing, she picks me up by the scruff of the neck and takes me to her throne again.</i>\"");
	
	outputText("\n\n\"<i>The second time was different, though.  I don't...</i>\" Hel scoffs, shaking her head as she downs another tankard from her still.  \"<i>...  I don't really know what happened then.  It was a haze, but...  I guess you could say, if she fucked me the first time, the second time she...  made love to me.  She never said a word, just drew me into her lap, all gentle-like, and puts me on her clit-dick again.  This time she slides into me, nice and smooth, holding me against her huge tits as she rolled her hips into my cum-drenched twat.  I was broken, limp in her arms, but she was so very, very, gentle.  My belly was positively bulging from her harem's cum; each of her thrusts squirted cup-fulls out of my holes until she's as drenched as I am, probably ripe to get knocked up on second-hand cum.</i>\"");
	
	outputText("\n\n\"<i>Maybe that's what she wanted, I dunno.  She just held me close and let me cum one last time.  I screamed and screamed, stretched so wide I could burst by her massive clit.  She slipped a fist up my ass and rammed her shaft in to the hilt.</i>\"  Hel pauses to laugh ruefully, adding, \"<i>I guess they'd forgotten about Anika, because all of a sudden there's a shout outside, and then there's salamanders bursting in.  I don't remember much, just that somehow I got dragged home.</i>\"");
	
	outputText("\n\nHel pulls herself to her feet and gives you a drunken grin.  \"<i>And that, lover mine, is the story of how I learned to love fucking in groups!</i>\"");
	
	outputText("\n\nYou stare at Hel for a long moment.  Looking down, you notice her thighs are slick with girl-juice - she's gotten turned on telling you about her getting gangraped!");
	
	outputText("\n\n\"<i>What?</i>\" Hel says, indignant.  \"<i>I don't judge your fetishes.</i>\"");

	outputText("\n\nStill, you'd think getting gangraped for an entire evening would make her terrified of the idea; not turned on by it.");
	
	outputText("\n\n\"<i>Hey, it felt amazing, alright? Sure, it was fucked up - I even have nightmares about it, sometimes, but...  I dunno.  One cock or cunt at a time just seems...  Boring, somehow.</i>\"");
	
	outputText("\n\nYou're about to protest, but Hel draws herself into your lap and plants a wet kiss on your cheek.  \"<i>Of course, there are always exceptions...</i>\"");
	
	//Sex options here maybe?
	flags[kFLAGS.FOLLOWER_HEL_TALKS]++;
	heliaRoughSex(false);
	addButton(14,"Leave",camp.returnToCampUseOneHour);
//	doNext(13);
}


//Hug(C)
private function hugASmokeyTail():void {
	clearOutput();
	//Cuddle with Hel (Replaces Hug @ 21:00+)
	if (model.time.hours >= 21) {
		outputText("As the sun sets over the camp, you see Helia standing over her hammock, stretching and yawning, ready to turn in for the night.  You approach her, sliding your arms around her supple waist and burying your face in her soft crimson locks, holding your lover close.  Hel giggles girlishly as you give her a long hug, nuzzling into the nape of her neck.");
		outputText("\n\nWith a bit of effort, Hel turns around in your embrace and starts to fiddle with your [armor], slowly pulling it off, leaving your bare flesh pressed against her own.  You breathe in the woodsmoke scent of her hair; rub your " + player.skinFurScales() + " along her smooth flesh; gasp lightly as her long tail wraps lovingly around your [legs], drawing you even closer, letting your face rest against her yielding chest.");
		outputText("\n\nKissing and nipping along your arm and neck, Hel gently pulls you into the hammock, leaving you resting atop the salamander, your limbs and tail");
		if (player.tailType > TAIL_TYPE_NONE) outputText("s");
		outputText(" intertwined.  <i>\"Oh, this is nice,\"</i> Hel laughs, running her long, scaled fingers through your hair.  <i>\"So, you wanna stay with me tonight, lover mine?  I'd appreciate the company....\"</i>");

		outputText("\n\nBefore you can give an answer, Hel presses her lips to yours, her breath coming hot against your face as her hands run across your back and [butt].");
		
		outputText("\n\nHel smiles prettily as you give your assent.  <i>\"On a night like this, there's no one I'd rather be with, [name]...\"</i>\n\n");
		flags[kFLAGS.SLEEP_WITH] = "Helia";
		menu();
		addButton(0,"Next",camp.doSleep);
		return;
	}
	//[If PC is >8ft tall]
	else if (player.tallness >= 96) {
		outputText("You sweep Hel up in your arms, lifting her off the ground in your embrace.  Hel giggles girlishly, her powerful legs flailing a few inches above the ground.  You squeeze your little lover to your chest, grinning as she wraps her powerful legs and arms around your waist and neck.  She nuzzles her head against your [chest], tracing one of her claws around your chest through your [armor].  You give Hel a little kiss on the top of the head before drawing her up closer to your face and pressing your lips to hers.");
		outputText("\n\n<i>\"Oh, [name],\"</i> Hel sighs happily, going languid in your loving embrace.  <i>\"My big, strong [name].\"</i>");
	}
	//[If PC is 6-8ft Tall]
	else if (player.tallness >= 72) {
		outputText("You sweep your salamander lover up in your arms, holding the fiery redhead close against you.  Hel lets out a happy gasp, quickly locking her strong arms around your neck and wrapping her warm tail around your waist, binding you to her.  She nuzzles into your neck, kissing and nipping gently at your tender flesh as she hooks one of her legs around you.  Smiling, you cup Hel's cheeks and give her a kiss, letting her long, slender tongue wrap around your own.");
		outputText("\n\n<i>\"Oh, [name],\"</i> Hel sighs happily, holding you tight.  <i>\"My wonderful, " + player.mf("handsome","beautiful") + " [name].\"</i>");
	}
	//[If PC is <6ft Tall]
	else {
		outputText("You put your arms out to your salamander lover and, with a big dopey grin, Hel sweeps you off your feet, spinning you around before holding you tight against her, your [feet] dangling off the ground.  Hel wraps you in a tight, long hug, her tail and strong arms pressing you against her soft, delightfully warm body.");
		outputText("\n\nAfter a few moments, Hel puts a hand on your back and leans you back, like a gentleman in a storybook, cupping your cheek before pressing her lips to yours.  She holds you in a long, affectionate kiss, her slender tongue wrapping playfully around your own.");
		outputText("\n\n<i>\"Oh, [name],\"</i> Hel sighs happily, holding you back against her bosom.  <i>\"My cute little [name].\"</i>");
	}
	doNext(camp.returnToCampUseOneHour);
}

//Talk about futafication, requires 75+ Helia Bonus Points. 
private function talkAboutFuta():void {
	clearOutput();

}

//What a horrible night to have a canyon vagina
//Hel Has a Nightmare (Play 10% of the time you Cuddle Hel)
public function sleepyNightMareHel():void {
	outputText("\nYou awake, finding yourself covered in a sheen of sweat.  Groggily, you peel your eyes open as the dangerously warm body beside you squirms in your grip, moaning quietly as her tail thrashes around your [legs].");
	
	outputText("\n\n<i>\"M-mooom,\"</i> Hel breathes, just loud enough to hear, her entire body twitching, recoiling from some imagined horror.");
	
	outputText("\n\nGently, you stroke her cheek, giving her sleeping mind what comfort you can.  After a few moments, Hel relaxes in your arms.  She rolls over, nuzzling her cheek into your [chest] and, murmuring your name, begins to snore peacefully.\n");
}


//Rough Sex
//Into Text
private function heliaRoughSex(output:Boolean = true):void {
	if (output) {
		clearOutput();
		outputText("<i>\"Mmm, need to blow off some steam, lover?\"</i>  Hel grins, reaching around to undo the straps of her scale bikini.  <i>\"Well, I'm all for that!\"</i>");
	}
	var buttons:int = 0;
	//(Display Options: 
	//PC has a dick: [Vaginal] [Anal] [Get Blown] [DP (Multi)] [Tail Wank]
	//PC has Vag: [Get Licked]
	//All: [Tail Peg]
	//Morph-based: [Possession] [Mount Her] [Hanging 69] [Coil Her Up] [Tentafuck])
	menu();
	if (player.hasCock() && player.lust >= 33) {
		//85 vag capacity by base
		if (player.cockThatFits(heliaCapacity()) >= 0 && buttons < 14)
		{	
			addButton(buttons,"FuckVag",helScene.beatUpHelAndStealHerWalletFromHerVagina, null, null, null, "Penetrate her vaginally.");
			buttons++;
		}
		//85 ass capacity
		if (player.cockThatFits(heliaAnalCapacity()) >= 0 && buttons < 14)
		{
			addButton(buttons,"Anal",helScene.fuckHelsAss, null, null, null, "Penetrate her anally.");
			buttons++;
		}
		if (buttons < 14) {
			addButton(buttons,"Get Blown",helScene.helBlowsYou, null, null, null, "Have her suck you off..");
			buttons++;
		}
		if (player.cockThatFits(heliaCapacity()) >= 0 && player.cockThatFits2(heliaCapacity()) >= 0 && buttons < 14) 
		{
			addButton(buttons,"DoublePen",helScene.dpHel, null, null, null, "Fill both of her holes with your cocks.");
			buttons++;
		}
		if (buttons < 14) {
			addButton(buttons,"Tail Wank",helScene.helTailWanksYourDickBecauseSheLovesYouDesuDesuHoraHora, null, null, null, "Have her jerk you off using her tail.");
			buttons++;
		}
	}
	if (player.hasVagina() && player.lust >= 33 && buttons < 14) {
		addButton(buttons,"GetLicked",helScene.getLickedByHel, null, null, null, "Have her lick your vagina.");
		buttons++;
	}
	if (player.lust >= 33 && buttons < 14) {
		addButton(buttons,"TailPeg",helScene.helTailPegging, null, null, null, "Have her peg your ass.");
		buttons++;
	}
	//if (player.lust >= 33 && flags[kFLAGS.HELIA_FUTA] > 0) {
	//	addButton(buttons, "Get Fucked", helScene.getFucked, null, null, null, "Have her penetrate you anally with her dick.");
	//	buttons++;
	//}
	//Morph-based: [Possession] [Mount Her] [Hanging 69] [Coil Her Up] [Tentafuck])
	if (player.lust >= 33 && player.isTaur()) 
	{
		if (player.hasCock()) 
		{
			if (player.cockThatFits(heliaCapacity()) >= 0 && buttons < 14) {
				addButton(buttons,"Mount Her",centaurMountsCampHel);
				buttons++;	
			}
		}
		if (player.hasKeyItem("Centaur Pole") >= 0 && player.hasVagina() && buttons < 14) {
			addButton(buttons,"CentaurToy",femtaurPlusCampHel);
			buttons++;	
		}
	}
	if (player.lust >= 33 && player.findPerk(PerkLib.Incorporeality) >= 0 && izmaFollower() && flags[kFLAGS.IZMA_NO_COCK] == 0 && buttons < 14) {
		addButton(buttons,"Possess",heliaCampPossession);
		buttons++;
	}
	if (player.lust >= 33 && player.countCocksOfType(CockTypesEnum.TENTACLE) > 6) {
		addButton(buttons,"Tentacles",heliaFollowerTentafuck);
		buttons++;	
	}
	if (player.lust >= 33 && player.isNaga()) 
	{
		//"Rough" Sex -- Naga Coil (Female w/ Naga Lower Body)
		if (player.hasVagina() && buttons < 14) 
		{
			addButton(buttons,"NagaCoilF",nagaCoilForHelCampWithGirls);
			buttons++;	
		}
		//"Rough" Sex (Well, it's in the menu, if not in spirit) -- Naga Coil (Male w/ Naga Lower Body)
		//Male naga shit
		if (player.hasCock() && buttons < 14) 
		{
			if (player.cockThatFits(heliaCapacity()) >= 0) {
				addButton(buttons,"NagaCoilM",inCampHelNagaLuv);
				buttons++;	
			}
		}
	}
	if (player.lust < 33) outputText("\n\n<b>You aren't turned on enough for sex right now.</b>");
	if (getGame().inCombat)
		addButton(14, "Leave", combat.cleanupAfterCombat);
	else addButton(14, "Back", heliaFollowerMenu);
}

//Note 2 Fen: Copypasta old PC Victory scenes here ^ EXCEPT for Morph-based scenes!
//And here we have the exciting Follower Hel expansion, where literally nothing changes.

//Rough Sex - Possession
private function heliaCampPossession():void {
	clearOutput();
	outputText(images.showImage("helia-follower-sex-possession"));
	outputText("With a coy grin, you let your ghostly attributes go transparent, and ask Hel if she'd mind taking an extra passenger for a little bit.");
	
	outputText("\n\n\"<i>Oh, that's too spooky for me, lover mi - HEY!</i>\" she yelps as you dive into her.  Your lover flails around for a minute before settling down, grudgingly allowing you to take the wheels.  Internally, you hear her say: \"<i>Alright, alright, I trust you. Have fun, [name].</i>\"  Now having assumed direct control of the salamander, you spend a few quick minutes getting adjusted to your slutty new body.  You run your scaled, clawed hands across Hel's smooth, taut body, giving your gropable ass and big, soft tits each a squeeze.  To your delight, even that slight stimulation is enough to cause a little trickle to escape the band of Hel's bikini bottom, staining your thighs with her lubricant.  Slutty body indeed.");
	outputText("\n\n\"<i>Hey, I can hear you!</i>\"");
	
	outputText("\n\nSorry.");
	
	outputText("\n\nWith your beautiful plaything ready to go, you scan around camp for someone or something to play with...");
	menu();
	addButton(0,"Izma",possessIzma);
	
}

//Possession -- Izma (who has a dick still)
private function possessIzma():void {
	clearOutput();
	outputText(images.showImage("helia-follower-sex-possession-izma"));
	outputText("You decide to give Hel's legs a stretch and trot over to the stream near camp.  Walking along the shore, it isn't long before you see a certain dark-red fin cresting the water.  A moment later your beta, Izma, breaches, jumping up out of the water and landing a few feet away.  Still dripping from her swim, you watch as Izma shakes a bit of water off before going to get her grass skirt - for now, though, you can see her hefty fifteen-inch rod and quad swinging in the breeze.");
	
	outputText("\n\nYou cough slightly.");
	
	outputText("\n\n\"<i>Gah!</i>\" the tigershark yelps, spinning around.  \"<i>Oh!  Hi there, Hel.  Didn't, uh, didn't see you there. You need something?</i>\" she asks, shifting awkwardly to cover her bait and tackle.");
	
	outputText("\n\nGrinning, you approach the tigershark, swishing Hel's wide hips and putting a little jiggle into her big breasts.  Confused, Izma takes a step back - until you slip one of Hel's powerful arms around the smaller girl's dainty shoulders.  You lean down, pressing your ample bosom against hers, and a moment later feel a little tap on your thigh as a certain shark-cock pops to attention.");
	
	outputText("\n\n\"<i>Oh, someone's eager for a little attention,</i>\" you let Hel say, grinning wolfishly at your beta. Internally, she adds, \"<i>Oh, this is gonna be good.</i>\"");
	
	outputText("\n\n\"<i>Er, uh, I, um,</i>\" Izma stammers, squirming in your firm grasp, \"<i>I don't think [name] would be okay with thaaaaaa!</i>\" she yelps as you reach down and grasp her erect mast, gripping it tightly in your warm, leathery hand.  Izma gulps heavily as you give her a single, experimental pump.  With a few encouraging words, you tell her to relax: she obviously wants it... and her lovely [name] surely wouldn't mind Izma taking care of her... urges.");
	
	outputText("\n\n\"<i>Well, if you're sure [name] wouldn't mind...</i>\" she says nervously, relaxing somewhat in your grasp.  Smiling wider, you start to stroke her off, pumping her long shaft and drawing the cute little shark into a kiss.  Hesitantly, she allows you to slip your slender reptilian tongue into her mouth, flicking it across the tip of her own tongue and the less-dangerous row of her teeth.  She moans into your mouth, shuddering slightly as you increase the pace of your hand-job.");
	
	
	outputText("\n\n\"<i>Aaahhhhhh,</i>\" Izma groans, squirming.  \"<i>P-please let me put it in... I wanna put it...</i>\"");
	
	outputText("\n\n\"<i>Shhh,</i>\" you command, giving her prick a hard squeeze.  \"<i>Betas don't get to decide how or when they put their cocks in other peoples' holes,</i>\" you tell her, pushing her down on her back.  Obediently, Izma lays down, her fifteen-incher standing straight up like a flagpole.  You bend down, planting a quick little kiss on the crown of her cock, before slipping up her body, straddling her shoulders.");
	
	outputText("\n\n\"<i>Lick,</i>\" you command, planting your hot box right in front of her angular face.");
	
	outputText("\n\n\"<i>W-whaaaa?</i>\"");
	
	outputText("\n\nYou grab Izma by her silvery hair and shove her face into your twat.  She struggles for a moment, before finally submitting and letting her tongue dart out, parting the lips of your cunt and sliding in.  The tigershark gasps, surprised by the intense heat of Hel's fiery insides, but a rough pinch of her teats puts her back on task.");
	
	outputText("\n\nMore gently, you stroke Izma's silvery hair as her long tongue flicks your inner walls, stopping only to tease and suckle on your clitty.  You urge her on, reaching behind you and taking hold of her red dick again, pumping it with smooth, fluid motions, telling your slut to match your speeds.  She does her best, slurping and sucking at your borrowed cunt.");
	
	outputText("\n\n\"<i>Niiiiice,</i>\" Hel groans inside you, relaxing inside you as she enjoys your slut's ministrations.  But it's not quite enough for you....");
	
	outputText("\n\nYou give Izma a playful slap, just enough to get her face out of your crotch, rolling the submissive tigershark onto all fours and brushing her long tail out of the way, to reveal the wet slit of her womanhood.  You grab the shark by her hips as you bring Hel's great big tail to bear, letting its pointed tip brush against Izma's tiny bud. She squeaks with sudden pleasure, nearly melting in your grasp.");
	
	outputText("\n\n\"<i>P-please,</i>\" she groans, begging you to fuck her.");
	
	outputText("\n\n\"<i>What's that?  I can't hear you.</i>\"");
	
	outputText("\n\n\"<i>Please put it in me, Hel!</i>\"");
	
	outputText("\n\n\"<i>Aww, I don't know about that...</i>\"");
	
	outputText("\n\nIzma gasps, horrified at the idea you might not let her get off.  \"<i>Pleeeeeeease!</i>\"");
	
	outputText("\n\nNope.  If she's going to be such a little bitch about it, you'll just have to teach her a lesson.  She's supposed to be YOUR beta, not just submit to anyone who can tease her along.  You'll show her.");
	
	outputText("\n\nYou give the slut a hard spank and throw her back on her back.  Before she can recover, you impale Hel on her cock, ramming all fifteen inches of sharkmeat into your twat until you can feel her head brushing against your cervix.  Izma groans, rolling her head back; she nearly screams when you grab her perky nipples and pinch them, hard, pulling on them until the shark-slut has to lean up.  You grab her shoulders and smash her face into one of your big, soft tits, putting her mouth up to one of your own rock-hard nips.  She gets the idea and starts licking, running her coarse tongue across your sensitive flesh.  With a low groan, you roll your hips on Izma's cock to reward her for her efforts.  You feel inches of thick cockmeat slipping in and out of you as you begin to ride your slut's cock, letting yourself go as her shaft stretches you, her pre lubing up your already-sodden box until you can feel orgasm coming... and Izma's, too.");
	
	outputText("\n\nOh no.");
	
	outputText("\n\nYou stand, drawing her cock out of your hot cunt before slamming her face into your crotch.  You impale yourself on her face, stretching your lips wide and forcing her to lick.  She whimpers, but complies, licking you until Hel's orgasm comes, a wave of burning pleasure slamming through you until your legs suddenly give.");
	
	outputText("\n\nYou collapse, writhing and shuddering as you cum. You're just aware enough to see Izma grinning devilishly as she crawls over you, her thick shaft dragging along your thighs.");
	
	outputText("\n\n\"<i>You're not done yet!</i>\" she declares, not so weak after all.  \"<i>I haven't cum yeeeeeet!</i>\" she cries as you grab her shoulders and toss her back on her back where she belongs, spreading her legs wide and hopping on her cock.  You both cry out as you ram yourself on her up to the hilt, her quad of nads pressing against your taut ass.");
	
	outputText("\n\n\"<i>No,</i>\" you say, grabbing Izma by the hair and forcing her shark-like face into your cleavage.  \"<i>You don't get to cum.  Weak, slutty little whores don't get to cum without their [master].</i>\"");
	
	outputText("\n\nYou start to bounce on her cock, going fast and hard, yanking yourself off her and finishing on her face every time she nears orgasm.  Refusing to let her cum, you continue riding her again and again for nearly an hour, cumming and cumming until Izma's face and Hel's thighs are smeared with thick layers of girl-cum and her pre-seed; by now Izma's cock has swollen thickly with cum that cannot get release.  She tries to jerk herself off, but you grab her hands; she tries to fuck you, but you use Hel's tail as a cockring, wrapping it around the base of her shaft until she groans in agony.");
	
	outputText("\n\nThen you resume, bouncing happily on her pent-up, turgid fuckpole, riding through another dozen orgasms until you feel your heart about to burst in your chest and think Izma might just die from want of release.  Finally, as a massive orgasm rolls through you, nearly throwing you off your beta's prick with its intensity, you notice that Izma's gone completely insensate, her tongue lolling out of her mouth as her body has fallen utterly limp.");
	
	outputText("\n\nPanting, you recover from your final orgasm and stumble up on shaky legs.  \"<i>Well, what do you think about that, slut?</i>\" you ask - or was it Hel?  You aren't sure anymore...");
	
	outputText("\n\n\"<i>I...  When...</i>\" she gasps, eyes still crossed.  \"<i>When I tell my alpha what...</i>\"");
	
	outputText("\n\n\"<i>Oh, there's nothing to tell,</i>\" one of you answers.  You let go of Hel, materializing in front of her.  Hel grins, wrapping her arms around your waist as you loom over Izma.");
	
	outputText("\n\n\"<i>A-Alpha!</i>\" she gasps, aghast.");
	
	outputText("\n\n\"<i>That's what you get for submitting to other people without my permission,</i>\" you say, pushing Hel's tail-cockring off of Izma's cock.  \"<i>Now be a good girl and do something about... that...</i>\"");
	
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
	


//"Rough" Sex (Well, it's in the menu, if not in spirit) -- Naga Coil (Male w/ Naga Lower Body)
//Male naga shit
private function inCampHelNagaLuv():void {
	clearOutput();
	outputText(images.showImage("helia-follower-sex-nagamale"));
	var x:int = player.cockThatFits(heliaCapacity());
	if (x < 0) x = player.smallestCockIndex();
	outputText("You slither over to the salamander and circle around her, your serpentine lower body trailing around her legs as you sweep Helia into a tight embrace.  She grins wolfishly, pressing her lips to yours; you let her tongue enter your mouth, entwining with your tongue, letting her distract herself as you coil more and more of your snake-body around the salamander.  By the time Hel realizes what you're up to, there isn't much she can do about it - you grab her arms and press them to her sides as you bind her up past the waist, wrapping your lover in your lengthy, serpentine form.");
	
	outputText("\n\n\"<i>Awwww,</i>\" she says, leaning over to give you a kiss on the cheek, \"<i>Nagas give the best damn hugs...</i>\"");
	
	outputText("\n\nYou return her smile, enjoying her intense warmth as it suffuses through your reptilian lower body.  Better yet, you can also feel her hot juices leaking out around her leather thong, staining your scales; just the hug's gotten her wet, by the looks of things.  She blushes slightly as you ask her if she knows what a horny little slut she is.  \"<i>Come on, don't be a tease... You know I want it...</i>\"");

	outputText("\n\nWell, alrighty then.  Popping [oneCock] out of your genital slit, you give it a little stroke; though it hardly needs any encouragement to get hard, with the femlube soaking into you and Hel's big tits resting atop your binding body.  You release her from your naga-hug, and Hel grunts as she flops onto her back, her legs spread perfectly for you.  In between her soaked thighs you slither, plopping your " + player.cockDescript(x) + " onto her twat and sliding yourself between her lips in a single, fluid motion.  Hel rolls her head back and moans as you enter her, digging the very tips of her claws into the " + player.skinFurScales() + " of your back.");
	
	outputText("\n\nYou only manage to give her a single thrust before Hel grabs your shoulders and throws you onto your back, hilting you as she suddenly straddles your lower body.  Left to gaze upon your salamander lover's efforts, you watch her grab the very tip of your tail and slips it into her mouth, suckling it like a teat before taking the now-sodden end of your body and, with a grunt, placing it between her buttcheeks.  Your eyes widen a bit as Hel impales herself on your tip, the sensitive nerve-endings firing off as her hot, tight passage contracts around your ever-enlarging invader.");
	
	outputText("\n\nA wicked idea pops into your mind. Hel seems to like your tail, and...  well, nagas do give the best hugs.");
	
	outputText("\n\nYou reach up and grab your lover's shoulders, pulling her face down onto your [chest] before rolling over, constricting her legs in a layer of naga tail, binding her with your tip and cock buried inside her.  Hel gasps, but after a moment begins to help you, guiding your lengthy, serpentine body around and around your entwined bodies until the two of you are utterly bound together, locked in intimate embrace.  You lie back, using your tail as a warm, comfy bed; Hel cuddles up atop you, managing to squirm until her arms are wrapped tightly around you.  With a kiss, you slip your tongue into Hel's mouth as you begin to move your body, rolling your hips into hers and wriggling your tail, doubling Hel's pleasure.  She gasps and moans, starting to fully tongue-fuck you as you ream her holes.");
	
	outputText("\n\nUnable to move much in your serpentine embrace, Hel begins to rapidly contract her vaginal and anal muscles, squeezing and grinding against your " + player.cockDescript(x) + " and tip.  Content to close your eyes and bask in the pleasures of your lover, ready to lose yourself in pleasure.  You relax, leaning back on yourself as you buck your hips into your lover's sweet hot box, flick your tail inside her ass, and play your tongue around her mouth, tasting her warm saliva and the aftertaste of beer.");
	
	outputText("\n\nYou cum easily, only a small grunt escaping your lips as Hel's delicious cunt brings you over, pulling your " + player.cockDescript(x) + " deep into her and tightening your hold around her.  The sudden squeeze is the last hurrah as you empty your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("load");
	outputText(" well into her womb.  Your tail spasms as you cum, running wild inside Hel's rectum until she cums too, yelping into your open mouth as she climaxes a moment after you, girlcum squirting out of her twat until your [hips] are thoroughly soaked.");
	
	outputText("\n\nHaving cum, you stroke Hel's cheek and kiss her again, this time a short, sweet peck on the lips that leaves her smiling lovingly at you.  Hel nuzzles against your [chest], content to snuggle in your reptilian hug; you run your fingers through her thick, rich red hair, and yawn as her comforting body heat flows through you.");
	
	outputText("\n\nBefore you know it, you're drifting off to sleep in your lover's embrace...  The last thing you hear is her quiet whisper: \"<i>Nagas really do give the best hugs...</i>\"");
	
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}	

//"Rough" Sex -- Naga Coil (Female w/ Naga Lower Body)
private function nagaCoilForHelCampWithGirls():void {
	clearOutput();
	outputText(images.showImage("helia-follower-sex-nagafemale"));
	outputText("You slither over to the salamander and circle around her, your serpentine lower body trailing around her legs as you sweep Helia into a tight embrace.  She grins wolfishly, pressing her lips to yours; you let her tongue enter your mouth, entwining with your tongue, letting her distract herself as you coil more and more of your snake-body around the salamander.  By the time Hel realizes what you're up to, there isn't much she can do about it -- you grab her arms and press them to her sides as you bind her up past the waist, wrapping your lover in your lengthy, serpentine self.");
	
	outputText("\n\n\"<i>Awwww,</i>\" she says, leaning over to give you a kiss on the cheek, \"<i>Nagas give the best damn hugs...</i>\"");
	
	outputText("\n\nYou slip inside your coil, pressing your [chest] against Hel and giving her a long, tongue-entwining kiss.  After a few minutes, though, you break the kiss and slither downwards, cupping one of Helia's large, soft breasts in your hands and putting your lips to it.  She lets out a soft gasp as you gently nip at her teat.  \"<i>Gah! R-right there, [name].  Oh, that's nice.  That's niiiice,</i>\" she moans, pulling one of her arms free to stroke your hair and give you a gentle nudge into her yielding flesh.  You eagerly suckle at her sensitive bud, licking and biting from one breast to the other until Hel is positively trembling with sensation.");
	
	outputText("\n\n\"<i>Alright, alright, enough,</i>\" she groans, rubbing your hair.  \"<i>Let's just do it already... I need you, lover.</i>\"");
	
	outputText("\n\nWell, you suppose you could have a little mercy on your salamander... and besides, your tit-feast has left your [vagina] soaked and ready, and brushing up against Hel's wet thighs leaves you trembling with electric pleasure.  A wicked grin spreads across your [face] as you wriggle your tail up through the coil, letting the tip pop between your entwined body, pressing against Hel's loose, slick cunt.  She groans as the tip of your tail flicks across her lower lips, but is still aware enough to bring her own scaly tail to bare, wrapping it around your [hips] before its warm, firm tip pokes your [vagina].");
	
	outputText("\n\nHelia locks eyes with you, and you both grin and nod.  As one, you both slide your tails forward, and both groan as the ever-thickening members slide into your wet cunts.  You squirm and moan as Hel's warm, flexible tail slides into you, first as thin as a gentle finger, but soon thicker than any cock around, stretching you wide as she slithers more and more tail-meat into you until you feel her hot scales on every inch of your inner walls.  An errant waggle of her tail sends shivers through your spine, making you contract your own tail, squeezing your bodies together, your [chest] pressing into Hel's soft bosom.  She laughs and kisses you, grabbing your [butt] and pulling you down on a little more of her tail.");
	
	outputText("\n\nYou feel the slender tip of Hel's tail flick across the entrance to your cervix, and only just stifle a whimper of intense pain and pleasure as, with a sadistic grin, Hel pushes forward parting your entrance and slipping an inch or two inside you.  You bite your lips as Hel starts squirming her tail around, writhing it around your vaginal passage and teasing the tip along the walls of your womb.  Every movement she makes sends bolts of pleasure through you, making the naga-tail buried inside her twist and thrash, battering Hel's own cunt until she's yelling with pleasure, throwing her head back and crying to the heavens as she cums.");
	
	outputText("\n\nHer orgasm sends her tail wild inside you, hammering in and out of you like a thick prick, the tip fucking your cervical entrance like a second twat inside your [vagina].  You can't last long under such an assault, and soon find yourself shuddering and squirming as an orgasm rolls through your long, serpentine body until you're numb with bliss, mind blanking as Hel desperately double-fucks your innermost depths.");
	
	outputText("\n\nBy the time your body has settled down, Hel is cuddled up against you, clinging tightly to you as your tails slowly withdraw from each other's bodies.  Still, you keep her wrapped in your tight naga hug, stroking Hel's cheek and kiss her again, this time a short, sweet peck on the lips that leaves her smiling lovingly at you.  The feisty salamander nuzzles against your [chest], content to snuggle; you run your fingers through her thick, rich red hair, and yawn as her comforting body heat flows through you.");
	
	outputText("\n\nBefore you know it, you're drifting off to sleep in your lover's embrace.... The last thing you hear is her quiet whisper:  \"<i>Nagas really do give the best hugs...</i>\"");
	
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}	


//"Rough" Sex -- Centaur Mounts Hel (PC has Centaur body & a dick)
private function centaurMountsCampHel():void {
	var x:int = player.cockThatFits(heliaCapacity());
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	outputText(images.showImage("helia-follower-sex-mount"));
	outputText("You trot around your lover, your powerful centaur frame brushing lightly against her.  Hel grins, reaching out to pet your flanks and running her claws across your " + player.skinFurScales() + ".  \"<i>You've got a helluva body,</i>\" she smiles, and with an invitation from you, swings up onto your back, wrapping her arms tightly around your waist as you break out into a canter around camp.");
	
	outputText("\n\nShe nudges you toward her part of camp.  When you arrive, Hel leaps off and grabs some ropes from her pack.  You raise an eyebrow, but allow her to tie them around your equine half, creating a makeshift harness underneath you.  Once done, Hel lowers herself to her knees and, pushing aside your [armor], takes hold of your " + player.cockDescript(x) + ".  She gives it an experimental stroke, running her warm, leathery palm and scaled fingers across your length until you let out a little whinny and stamp your hooves.");
	
	outputText("\n\nHel pats your flank with her free hand, but doesn't let up, instead adding her long, slender tongue to the mix.  She flicks it along the " + player.cockHead(x) + " of your " + player.cockDescript(x) + ", sending shivers of pleasure up your rigid shaft.  You ache to do something here, to add to your own pleasure or return it to your partner, ");
	//if no boobs: 
	if (player.biggestTitSize() < 3) outputText(" but your body is too big, and you must content yourself to endure Hel's ministrations");
	else outputText(" but all you can do is take hold of your [chest] and tease and tweak your [nipples], getting what pleasure you can from your sensitive teats");
	outputText(".");
	
	outputText("\n\nAfter a few mind-hazing minutes of salamander hand-job, Hel takes the " + player.cockHead(x) + " of your cock into her mouth, slurping up the tip of your " + player.cockDescript(x) + ".  Your breath catches in your throat as the first inches of your cockmeat are engulfed in the hot, wet embrace of Helia's mouth.  Her lizard-tongue wastes no time in flicking across your " + player.cockHead(x) + ", the forked tip playing across your urethra, drawing forth a thick dollop of pre that soon smears her cheeks with white.  She pumps your cock into her mouth, licking and sucking on your crown as her pistoning hands force thicker globs of sticky precum out of you, eagerly swallowing every drop - but only after savoring it, rolling each drop around in her mouth until her entire gob is a sticky mess, thick webs of seed coating her lips each time she swallows another appetizing taste.");
	
	outputText("\n\nThen as quickly as it began, Hel's blowjob comes to a halt.  The salamander pops your prick out of her maw and, giving it one last kiss on the " + player.cockHead(x) + ", lets it fall aside as she moves.  You lean around yourself awkwardly as your lover ducks beneath your horse-half, clambering into her harness.  Hel disappears from view, completely obscured by your own body; all you can feel of her is her weight pulling down on your back and her powerful scaled legs hooking around your thighs, spreading wide as she grabs your cock again.  You groan pleasurably as the tip brushes her lower lips, the heat of her inhuman pussy radiating out to set your nerves ablaze.");
	
	outputText("\n\nWhen she finally guides you into her cunt's embrace, you nearly cum, the intense foreplay suddenly catching up to you.  You grit your teeth and stomp your hooves, desperately holding back as you adjust to the heat and pressure of her depths, finally coming to rest as she finishes sliding in as much cock as ");
	if (player.cockArea(x) > heliaCapacity()) outputText("she can cram in, the rest of your length twitching between her legs");
	else outputText("you have to offer her");
	outputText(".  Finally, though, you manage to settle down, your breath coming ragged as Hel's vaginal muscles clamp and release, gently massaging your shaft with expert movements, always keeping you on edge until...");
	
	outputText("\n\nTHWACK!");
	
	outputText("\n\nYou start forward as a rough tail-slap lands on your flank.  You reflexively step forward, your equine muscles acting on instinct...  which only serves to rock Hel off and down again on your " + player.cockDescript(x) + ", her impromptu harness moving her like a swing. You arch your back as the movement hammers Hel down on your cock like a free-swinging onahole, but the moment of pleasure lurches out of control when she gives you another hard tail-swat, and another; your insticts carry you forward until you reach a full canter. Shudders and twitches wrack your body as your own motions rock Hel on and off your [cock], slamming her back down on your shaft again and again.");
	
	outputText("\n\nYou grit your teeth and pick up the pace, accelerating to a trot as Hel writhes around on your cock, your movements taking her off your prick in faster intervals, and slamming her back down harder with every step, until she's worked into a furious speed even she couldn't match on her own. Beneath you, she lets out a sharp cry, and you can feel her muscles contracting around your shaft, starting the tell-tale milking as she orgasms on your fast-moving cock. Gleefully, you race forward, as fast as you can, pounding your prick into her until Hel is screaming, her voice carrying out across the wasteland as you circle around camp, fucking her raw with every step.");
	
	outputText("\n\nAs Hel lets out another high-pitched shriek of pleasure, you finally feel yourself hurtling over the edge of bliss. You rear yourself up as you cum, staggering on your hind legs as the first searing spurt of spooge squirts into the screaming salamander.  A huge spurt of cum jets out of your " + player.cockDescript(x) + ", smearing Hel's spasming walls white with your potent seed.  As your prick fires off again and again, you slowly bring yourself to a halt, your prick still twitching inside Hel's cum-soaked box.  When you've brought yourself to a complete stop, you feel a sudden lightness as Hel flops out of her harness, quickly surrounded by a small pool of jizz leaking out of her.");
	
	outputText("\n\n\"<i>Holy shit,</i>\" she gasps, breathing hard, You look down from your loft position on centaur-back as Hel rolls over, idly fingering out thick globs of seed still leaking from her well-abused hole.  \"<i>Thanks for the ride, lover mine.</i>\"");
	
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}	

//"Rough Sex" -- Centauress-PC & Hel (PC must have Centaur Pole)
private function femtaurPlusCampHel():void {
	clearOutput();
	outputText(images.showImage("helia-follower-sex-femtaur"));
	outputText("You trot around your lover, your powerful centaur frame brushing lightly against her. Hel grins, reaching out to pet your flanks and running her claws across your " + player.skinFurScales() + ".  \"<i>You've got a helluva body,</i>\" she smiles, and with an invitation from you, swings up onto your back, wrapping her arms tightly around your waist as you break out into a canter around camp.  She gives you a gentle nudge toward a certain pile of your gear, and it doesn't take but a moment for you to notice she's urging you toward the special toys Whitney gave you for your equine-like body's needs.");
	
	outputText("\n\nYou quickly set up the imp-like centaur pole, its thick horse-shaft easily adjusted to the right height for your [vagina].  You stand for a moment in the presence of the horsecocked imp, its huge hooked nose and wide-brimmed hat casting a maleficent shadow across your back as you line yourself with its plasticy manhood.  As the lips of your femininity brush against the stiff flat head of the false horsecock, Hel slips back along your lean frame, resting her belly and full breasts on your centaur back, her muscular arms wrapping tight around your chest.");
	
	outputText("\n\nA small gasp escapes your lips as you feel a tiny, red-hot point pressing against your [asshole] as the tip of Hel's tail comes to rest atop the plastic horsecock, brushing across your most sensitive parts with tantalizing slowness.  \"<i>Come on, pretty girl. Let's give both your holes a thrill!</i>\" Hel laughs, patting your side encouragingly.  Slowly, you start to back up, shivering as you feel the two intruders press against your twin holes.  You clop back, a shudder wracking your body as the tip of Hel's tail pierces your [asshole] and the pole's cock spreads your womanly lips, entering your [vagina].");
	
	outputText("\n\nYou pause a moment, reveling in the intense fullness, the gaping half-pain of the two thick shafts stretching your holes.  A long moment passes by as your body tries to adjust to the tail and dildo stuffing you; only as your holes stop spasming do you start to move again, backing slowly up toward the pole, letting more and more plastic and scale into you.  It takes nearly a minute for you to finally stuff the entirety of the shaft's length into your cunt, its massive length mirrored by Hel's thick tail now stuffed wholly into your ass, stretching you wide as the appendage twitches and squirms, teasing your inner walls.  As your [butt] presses against the towering Centaur Pole, you start to move, but a quick swat on the flank from your lover stops you.");
	
	outputText("\n\n\"<i>Let me handle this,</i>\" Hel whispers, her voice sultry and full of promise.  You feel her tail wriggle inside you, slowly drawing itself out of your well-stretched anus, until only a few inches remain to spread your cheeks.  A moment later Hel thrusts back in, her hot tail ramming back into your with the force of a battering ram.  You grunt and groan as it settles inside you, finally letting out a relieved sigh when it's only giving you a modest, pleasant stretching, the fake cock inside you strangely still... but you can feel it growing.");
	
	outputText("\n\nYou yelp as the imp-statue's hands suddenly reach out and grasp your [hips].  Your eyes go wide as you feel the thick dildo withdraw from your cunt, the imp's hips pulling back.  You look back, you and Helia both gazing over your shoulders as the magic statue readies itself to join in the fun.  To your surprise though, it withdraws until just the tip remains inside you.  Its rubber cock seems to part, and a second, equally-sized cock appears above it, as if from nowhere.");
	
	outputText("\n\n\"<i>Fuck me,</i>\" Hel groans as the second plastid shaft flops down just between her legs, its flared head pressing against her slit.");
	
	outputText("\n\nYou have time only to let out a desperate curse before the toy rams itself back into you.  You try to leap forward from the massive, mind-numbingly pleasurable impact, but its strong hands hold you fast.  You yelp and scream as the statue begins to fuck you roughly, making forceful thrusts deep into your [vagina] until the dildo is battering your cervix.  Its motions into you carry its second cock forward, too, slamming into Hel until her gut visibly distends under the sudden impact, forcing a scream from her lips - and a brutal thrashing of her tail, her thick shaft going wild inside your anus, wriggling madly about inside you, completely out of her control.");
	
	outputText("\n\nIn minutes you've arched your back and cried out, screaming an orgasmm to the heavens as the twin members inside you hammer wildly into you.  But the statue keeps fucking, and Hel keeps thrashing wildly, and soon you've cum again, driven to mind-blanking pleasure by the intense fucking meted out by the magical apparatus.");
	
	outputText("\n\nNearly an hour passes before you collapse, finally falling off the toy as gallons of fake-spooge leak out of your horsecunt, your fiery lover tumbling off your back to land in a pool of the statue's leavings leaking from her abused cunt.");
	
	outputText("\n\n\"<i>I have got... to get... one of those,</i>\" Hel pants, her eyes still rolled up in her head.");
	
	outputText("\n\nBreathing heavily, you pat her on the cheek and stumble off to get cleaned up.");
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Rough Sex -- Tentafuck
//[Requires at least 5 tentacle cocks]
private function heliaFollowerTentafuck():void {
	clearOutput();
	outputText(images.showImage("helia-follower-sex-tentacles"));
	outputText("With a flourish you pull your [armor] off, exposing your writhing mass of tentacle-cocks for Hel`s enjoyment.  \"<i>Wow, think you got enough of th--urf!</i>\" the salamander starts to say before you shut her up with one of your tentacle pricks, lashing forward and plugging her mouth.  Hel staggers back, flailing around before grabbing the cock you've shoved down her throat and giving it a rough tug.  Just as she nearly succeeds in pulling it out, your other wriggling members wrap around her thick thighs; you pull her in toward you, grabbing her shoulders as your pricks peel off her bikini bottom to reveal the smooth face of Helia's crotch.");
	
	outputText("\n\n\"<i>Awwight, leggo,</i>\" Hel growls around the prick stuffed into her mouth, though her muffled words only give you the opportunity to push further down her throat, until you can see your cockhead bulging her throat like an engorged adam's apple.  Her struggling hands relax a moment under your assault on her face, until they change tactics: instead of pulling you out, her hands start jerking you off, giving your length a handy even as her throat spasms and contracts around the intruding tentacle.  Now that's she's a bit more compliant, your other cocks set to work!  A pair of them curl around Hel's thighs until their tips brush the inferno of her rapidly-moistening cunt, twin tips peeling open her sodden box to bask in the intense heat radiating from her twat.  Your twin tentacles slither into her, slowly spreading her vaginal walls as liberal trickles of femlube pour out around your members.");
	
	outputText("\n\n\"<i>Oh, gods,</i>\" Hel groans around the cock on her mouth, \"<i>Stuff 'em in there!  Gods, YES!</i>\" she cries, clutching at your mouth-gaping cock as the second and third members ram into her cunt, moving faster, fucking her with wild abandon.  As your three salamander-stuffing pricks pound into Hel's two holes, though, your next two cocks slowly move into position.  Your fourth vine-like tool readies to pounce, and with one quick motion pierces Hel's ass, jamming its first inches into her backdoor with enough force to make her scream around the cock in her throat.  You push yourself further in, and further still, until the three cocks pile-driving into Hel's cunt and ass can feel each other through her walls, writhing against each other through the thin barrier of flesh separating her pussy and rear.  Another of your cocks soon joins the fray, wriggling up between Hel's prominent E-cups and thrusting itself upwards, seizing a tit-fucking while the salamander's distracted with your quad-attack.");
	
	outputText("\n\nWith five viney cocks assaulting her all at once, you watch with satisfaction as Hel's eyes roll back in her head, her back arching as all her holes are roughly abused by your inhuman manhoods.  With a grin, you make a sudden pelvic thrust and in so doing fully lift Helia off the ground, suspending her in mid-air a foot off the ground, supported by your powerful erections.  \"<i>Gaaaahhh!  Put me down!</i>\"  But you only laugh at her helpless cries, instead sending your muscles into over-drive.  Your many tentacles thrash around inside her, moving faster and faster until with an ear-piercing cry, Hel cums, throwing her head back and screaming her pleasure to the heavens.  Her wildly-spasm muscles, contracting ass and flailing tongue combine around your viney pricks, bringing you closer and closer to your climax until you too roar with pleasure and the first thick bursts of semen pour forth from your cocks, smearing Hel's chest, mouth, ass, and cunt with the slimey smears of seed.  Your tentacles pulse as great blobs of spunk surge through them, pumping your cum into Hel until your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("wriggling tentacles");
	outputText(" feel painfully empty and white slush pours from all her holes, painting the ground white beneath her dangling feet.");
	
	outputText("\n\nWith a contented sigh, you yank your wilting pricks out of your fiery lover, letting her flop to the ground in a puddle of sticky spunk.  She groans loudly, rolling over and blinking hard.  \"<i>You're just a miniature tentacle monster, you know that?  And I love it!  You gotta do that again some time... just like a walking gang bang.</i>\"");
	
	outputText("\n\nYou roll your eyes and go to get cleaned up.");
	player.orgasm();
	dynStats("sen", -1);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Boxing
private function boxWithInCampHel():void {
	clearOutput();
	outputText(images.showImage("helia-follower-boxing"));
	outputText("You ask Hel if she'd like to get in some combat practice -- but brush her hand away from her scimitar's hilt when she reaches for it.  \"<i>Unarmed combat practice,</i>\" you clarify, balling your fists. Hel grins, and tosses her sword to the side -- and her scant clothes as well.  Wholly exposed, Hel drops into a fighting stance, legs spread wide and fists raised defensively.");
	outputText("\n\n\"<i>Come on, lover mine,</i>\" she says, a playful grin spreading across her lips, \"<i>Let's dance!</i>\"");
	
	//{Make an INT or STR check, whichever is higher:
	outputText("\n\nYou toss your [armor] aside and assume your own battle stance, your powerful muscles tightening beneath your " + player.skinFurScales() + ", ready to spring into action.  You move slowly, cautiously; you and Hel begin to circle each other like predators observing their prey, each watching the other for any momentary lapse, any split-second vulnerabilities.  Suddenly, Hel lashes out, a quick one-two jab at you, narrowly blocked in your guard.  You grind your feet into the ground, deflecting her inhumanly-strong blows as best you can.  She launches a third strike, but you duck aside, spinning into her guard and delivering a hard jab to her gut.  The salamander recoils, swinging her fiery tail at you as she gets some distance, staggering back from the hit.  You exchange another quick flurry of blows, punches connecting, blocked, or dodged in rapid succession.  The fight drags on, neither of you able to land a telling blow, your strikes deflected or dodged, your prowess in battle nearly matched.");
	player.changeFatigue(5+rand(20));
	//If INT check succeeds: 
	if (player.inte/20 + 1 + rand(20) >= 13) {
		outputText("\n\nUntil you see an opening: only for a second, Hel leaves her side exposed between attacks.  You take a step back, inviting her to attack; the salamander lunges just as planned, throwing a mighty punch your way, which you nimbly dodge, putting you just inside her guard.  With all your force, you slam your elbow into her side, throwing your fiery foe to the ground with an audible \"<i>OOF!</i>\"  She's barely landed on her big ol' ass before you jump on her, tackling Hel while she's down and pinning her.  The salamander flails, trying to throw you off, but you hold fast and count down:");
		outputText("\n\n\"<i>One... Two... Three!</i>\" you yell, laughing as you seize victory.");
		
		outputText("\n\n\"<i>Alright, alright,</i>\" Hel groans, settling down beneath you.  \"<i>You win... this time!</i>\"  Her smirk widens even more as your eyes jump wide; the familiar, naughty feel of clawed hand grabbing at your [butt].  Hel licks her lips with a slow, sultry motion and asks, \"<i>Now then, lover mine, to the victor go the spoils...</i>\"");
		//[Display Rough Sex menu]
		dynStats("str", 1,"tou", 1);
		heliaRoughSex(false);
		addButton(14,"Leave",camp.returnToCampUseOneHour);
	}
	//If STR check succeeds:
	else if (player.str/20 + 1 + rand(20) >= 13) {
		outputText("\n\nYou tire of the battle, though, and decide to end it swiftly.  You put your well-trained muscles to good use, lashing out with a single, powerful blow that stuns the salamander, knocking her back.  You follow through with a trio of hard punches to the ribs, pounding Hel until she gasps for breath and stumbles, collapsing in a heap.  You're on her in an instant, pinning her down with your [legs], putting your whole weight down on her so that no matter how hard she struggles, she cannot push you off.");
		
		outputText("\n\n\"<i>Alright, alright,</i>\" Hel groans, settling down beneath you.  \"<i>You win... this time!</i>\"");
		outputText("\n\nYour eyes jump wide as you feel a familiar clawed hand grab a handful of your [butt].  Hel licks her lips with a slow, sultry motion and asks, \"<i>Now then, lover mine, to the victor go the spoils...</i>\"");
		//Display Rough Sex menu
		dynStats("str", 2);
		heliaRoughSex(false);
		addButton(14,"Leave",camp.returnToCampUseOneHour);
	}
	//If PC fails the Check:  
	else {
		outputText("\n\nAs you desperately fend off the salamander's flurry of blows, though, you feel yourself wearing down.  Her punches start getting through your guard, scaled knuckles hammering into your flanks and gut, too many and too hard to withstand.  Eventually, battered and bruised, a particularly hard blow throwing you to the ground.  You land with a groan, and a moment later feel Hel's soft, leathery sole pressing down on your [chest].");
		outputText("\n\n\"<i>Ha! Not today, [name]! You're good, lover, but you're gonna need to practice a lot more to beat me!  Now then.... what shall the victor do with her spoils?</i>\"");
		//[Proceed to Lose to Hel sex scenes]
		dynStats("tou", 2);
		if (player.lust >= 33 && player.hasCock() && rand(2) == 0) {
			if (player.cockThatFits(helCapacity()) >= 0) {
				muddyLizardFeet();
				return;
			}
		}
		heliaRoughSex(false);
		addButton(14,"Leave",camp.returnToCampUseOneHour);
	}
}

//THE LONG AWAITED APPEARANCE OF MUDDY LIZARD FEET (Or, Hel is a Seriously Dirty, Filthy Girl; and We Love Her for it)
//{Play if the Player loses to Hel in Boxing, has a Dick, and current lust 33+ INSTEAD of normal Lose to Hel scene & rape, as above}

private function muddyLizardFeet():void {
	clearOutput();
	outputText(images.showImage("helia-follower-muddylizardfeet"));
	outputText("Suddenly, Hel lunges forward, grabbing you by the waist and tossing you both to the ground. With an \"<i>OOPH!</i>\" both of you go tumbling, rolling hard as Hel's toss carries you down a steep slope.  With a splash, you find yourself rolling in the river near camp, the water only a few inches deep, just enough to fill your ears as your salamander lover pins you down, grinning wolfishly at you.");
	
	outputText("\n\n\"<i>You're mine, [name]!</i>\" she laughs, struggling to stand, one soft sole planted firmly on your chest, pressing you down into the muddy soil beside the stream.  You groan as the salamander looms over you, hands planted firmly on her wide hips.  \"<i>Now... what should I do with my weak little prize, hmm? Should I... oh, why. hello there,</i>\" Hel chuckles as your [cock biggest] stiffens unconsciously, so used to the touch of Helia's body signaling imminent pleasure that her holding you down in the mud sparks a rather confused boner.");
	
	outputText("\n\nHel grins down at you and shifts her weight onto the foot that had been on your chest, her other coming up between your [legs], the smooth flats of her claws caressing the underside of your turgid cock, quickly bringing it to full stiffness.  She coos merrily as her claws stroke the stiff shaft of your manhood, leaving thick, slimy trails of salamander-warmed mud trickling down your prick.  Seeing your reaction - or at least, that of your rock-hard [cock biggest], Hel presses down ever so slightly, moving her heel to the base of your cock and flattening it against your belly.  A little gasp escapes your mouth as your lover applies the tiniest amount of pressure, leaning in to tighly press your rod against you.");
	
	outputText("\n\n\"<i>Aww, he likes it,</i>\" Hel laughs, clutching your girth between her clawed, scaled toes.  Slowly, she moves her foot along your length with tantalizing slowness, her soft, warm soles made slick by the thick mud now slathered on your dick.  Her actions are smooth and fluid, her well-lubricated underside gliding easily down to the base of your prick, ");
	if (player.balls > 0) outputText("her heel coming to caress your taut sack");
	else if (player.hasVagina()) outputText("her heel brushing against the nub of your [clit]");
	else outputText("her heel going so low as to brush your taint, making your [asshole] clench in surprise before she moves back up your length");
	outputText(".  You groan lustily as her toes and soft sole jerk you off, gently urging the tight knot of pleasure in your gut to fruition.  Cupping one of her hefty tits, Hel licks her lips as the first thick smears of pre leak from your cock's [cockHead biggest], smearing onto her long-clawed toes.");
	
	outputText("\n\nJust as you're about to bust your nut onto Hel's foot, though, the sultry salamander ceases her sensual movements.  With a wry grin, she grabs your shoulders and pulls you up into a sitting position before swinging around behind you, wrapping her powerful thighs around your waist.  Wrapping her arms tightly around your [chest], fingers playfully toying with your [nipples], Hel trails kisses down your neck and shoulders, nibbling at the sensitive skin even as both her feet lock around your still-muddy [cock biggest].  You gasp at the sudden warm embrace of her soft soles, shuddering as her soil-slicked feet start to work up your length, massaging your cock between her arches.");
	
	outputText("\n\n\"<i>Oh, [name],</i>\" she moans, squeezing your chest against herself, shifting to let your head rest against her big, soft breasts.  She leans down to kiss you, her lizard-like tongue slithering into your mouth to play across your own.  You return her kiss, reaching down to caress her leathery-scaled legs, brushing your fingers up along her thighs until her breath catches in her throat.  Just as Hel starts to pick up the pace, bringing you closer and closer to the edge of bliss, you twist around in her grip, shifting to face the salamander.  Hel gasps, but quiets instantly when you take her in your arms and kiss her, pushing her back into the muck with the intensity of your passion.");
	
	outputText("\n\nHel's legs wrap back around your [hips], pulling you down against her, your slick cock grazing the hot slit of her pussy, just enough to part her lips ever so slightly.  Your lover breaks the kiss that binds you just long enough to moan your name, throwing her head back and clutching to you as you finally enter her, your cock spearing into her fiery depths with a slow, unyielding thrust.  You groan and moan, breath coming ragged as your [cock biggest] slides into the salamander's cunt.  You forge ahead, pressing your manhood into your lover until ");
	if (player.biggestCockArea() > heliaCapacity()) outputText("you feel your [cockHead biggest] against the lips of her cervix, as fully into her as you can go");
	else outputText("your groin meets Helia's, your [cock] wholly enveloped within her");
	outputText(".  Before you can think to withdraw, Hel tightens her hold on you, whispering huskily, \"<i>Just leave it... just for a second, [name].  Oh, God,</i>\" she moans, her eyes closing as she savors the feeling of you buried so deep inside her, your slick prick twitching as her walls massage it, milking it of the precum that freely flows from your tip.");
	
	outputText("\n\nYou stroke the salamander's cheek, planting a kiss on her lips as you finally start to move, rocking your hips back just a few inches before gently sliding back in, gliding easily into the welcoming embrace of her sodden slit.  Slowly, you move in and out of her, gently and lovingly, reveling in the sensation of her warm embrace, just as she glories in the thick shaft inside her, letting soft moans escape her lips to the beat of your quickening thrusts.");
	
	outputText("\n\nGrinning, you start to build up to a rougher pace, starting to fuck Hel with greater speed and power.  Your rhythm intensifies, as does the salamaner's grip on you, until you feel her claws digging into your back.  \"<i>Yeah, come on, [name]!  Just like that!  Just... like... that!</i>\"");
	
	outputText("\n\nBefore you can blink, Hel shifts her grip on you and rolls you over, suddenly planting you back in the mud, leaving her on top, straddling your [hips], cock half-buried inside her.  She gives you a wink as she lifts up, letting your [cockHead biggest] taste the cool air.  You shudder with the sudden frigid sensation along your manhood as the salamander turns around, whispering, \"<i>I'm not ready for this to end just yet....</i>\"  She comes back down a second later, reaching back to spread her cheeks so that your [cock biggest] slides readily into her taut, muscular butt, trapped behind her as she gently grinds on you.  You groan, brought down from your near-orgasmic high by the sudden cold; Hel's butt is nothing compared to the sweltering embrace of her inner depths.");
	
	outputText("\n\nWinking at you over her shoulder, Hel grabs your [legs] for support as she starts to move, dragging your still-slick cock between her ass-cheeks.  She wastes no time with slowness, immediately bucking up and down on your fuckpole with all the speed she can muster, rutting like mad on top of you.  She's panting lustily in moments, her long tail swinging around to tease her empty twat, slipping a few inches in at the bottom of each bounce.  Unwilling to simply sit passively after you nearly had the both of you cumming buckets, you lean up and grab the slutty salamander's ass, sinking your fingers into her plush butt so hard she yelps.  You give her a little swat, chuckling as her flesh jiggles - and the impact shakes through her, making her clench around your prick.");
	
	outputText("\n\nBefore you can try that again, though, Hel takes your hands in hers and guides them up to the soft mounds of her mammaries, letting you get something real to sink your fingers into.  You squeeze her tits roughly, teasing her stiff teats with a pinch or twist between each thrust, forcing little gasps and moans from her throat.  Soon, Hel's tongue is lolling out of her mouth, her back arching as she undulates atop you, squeezing hard on your [cock biggest] as you lean up to press your [chest] into her back.");
	
	outputText("\n\n\"<i>Oh, shit,</i>\" she groans, \"<i>Just fuck my tits, gimme a boobgasm, c'mon! [name]!</i>\" she cries, throwing her head back, nearly ready to cum just from your savaging her breasts and the tender ministrations of her own tail.  Well, you can't have that yet!");
	
	outputText("\n\nStill holding Hel by the tits, you roll her over face-down into the mud.  You grab her hips, holding her still enough to get a few more rough thrusts into her asscheeks before you decide on the real prize.  At the apex of a thrust, you angle down, the tip of your prick battering into Hel's dark star.  She gasps, clenching down on the crown of your cock; but she's a regular buttslut, and another thrust brings you inside her.  Helia cries out, screaming her pleasure as you bury your thick prick deep into her backside.  \"<i>Oh, FUCK yeah,</i>\" she finally manages to say as your hips push against her butt, cock fully inside her.  \"<i>G-God yes, [name], fuck my ass... you know I love it... Love you...</i>\"");
	
	outputText("\n\nYou run your fingers through her red tresses, as gently as you can even as you withdraw from her ass, taking yourself half way out before starting back inside.  A few more thrusts and you're righteously fucking your piece of hot salamander ass, pounding away at Hel's butthole with swift, powerful strokes that each force a cry from her lips, or a sultry moan of your name, and how much she loves you and the cock buried up her ass.  You let one of your hands drift upwards, taking her by the shoulder, helping her up onto all fours - all the better to hammer her ass.  To your delight, though, she grabs your hand and brings it to her mouth, showering it with kisses and gentle bites, suckling from your digits like little cocks, her tongue wrapping around them and squeezing with every hammerfall that brings your [cock biggest] pounding back into her.");
	
	outputText("\n\n\"<i>N-not yet,</i>\" Hel groans, \"<i>Just a little longer...</i>\"");
	
	outputText("\n\nYou grin down at her, but the salamander twists in your grip, popping off your cock so quickly that a thick pool of pre leaks out of her backside.  She rolls onto her back and grabs your [legs], pulling you onto her so that you straddle her big, soft bust, your cock flopping into the slick mud coating her breasts.  She grins up at you, white fangs gleaming on a darkened face as she cups her tits, pushing them together around your throbbing shaft, so close to release that you want to scream.");
	
	outputText("\n\nHelia plants a dainty kiss on your [cockHead biggest] before starting to move, dragging her breasts up and down your muddy shaft, compressing the soft, yielding orbs around your turgid rod.  She's going slow, at first, letting you down easy from your orgasmic heights.  Letting your heart calm, you rest your hands on her shoulders, caressing her cheek and chest as her hands guide the heavy orbs of her tits to your pleasure. \"<i>Mmm, [name],</i>\" she whispers, letting her eyes flutter closed.");
	
	outputText("\n\n\"<i>I love this cock,</i>\" she adds, giving it another kiss, her slender tongue flicking across your cum-stained slit.  \"<i>I love it so much... more than all the others combined.  The best cock under the sun,</i>\" she chuckles, popping the head into her mouth, her kiss turning into a tongue-laden oral massage across your crown.  She suckles from your head, lapping up the seed that spills from it as her tits coax more and more from you, slowly working a thick load up from deep inside you.  You can feel it coming... closer and closer, so much pent up, so ready to cum.");
	
	outputText("\n\nBut not yet.");

	outputText("\n\nYou brush Helia's mud-stained tresses aside, cupping her cheek as you ask her if she's ready to bring this to an end.  She smiles, kissing your fingers as you help her up onto her knees, resting her in your lap, legs astride your [hips].  High on her knees, your salamander lover shifts to press your prick against the entrance to her eager cunt, her juices flowing so freely that they nearly wash the muck from your [cockHead biggest] before you finally take her hips and guide her down, pulling her onto your [cock biggest].  She shudders as you enter her, breathing ragged gasps into your ear until you've given her all she'll get, leaving her panting and begging for more.  Instead, you take her chin between your fingers and make her look you in the eye as you kiss her, pushing your lips to hers. \"<i>[name]...</i>\" she breaths, letting her tongue caress your own as she starts to move, slowly drawing herself off of you and back down again, taking slow, measured bounces as the passionate kiss persists.");
	
	outputText("\n\nMinutes pass, your tongue long entwined with Helia's, her hips steadily undulating atop your [cock biggest], her sizzling vaginal embrace bringing you closer and closer to the peak you've nearly crested for the better part of an hour, riding you for all you're worth as her muscles milk your prick of every last drop of pre.  This time there's no one trying to stop it; only loving caresses and gentle lovemaking, your slick bodies gliding across each other as you climb tantalizingly close to your limit.");
	
	outputText("\n\n\"<i>I love you, [name],</i>\" Hel whispers, just speaking your name as her voice catches in her throat, her claws digging into your back.  You hold your lover close as the first trembles of orgasm hit her, holding her quivering cheek to your chest as she moans her pleasure, almost whimpering as her hot slit squeezes around you, milking you until finally you can feel sweet, blessed release.  You let out a bestial grunt as the first thick streams of seed burst out of you, a powerful spurt that paints the walls of Helia's womb white, filling her with your cum.  Squirt after squirt shoot into her until thick rivulets of spunk roll out around your [cock], smearing into the mud and sweat that coats your two bodies.");
	
	outputText("\n\n\"<i>God, yes,</i>\" Hel moans, holding you tightly as you stuff her with your seed, \"<i>Just like that, [name].  Oh, God, yes... Oh, [name]....</i>\"");
	
	outputText("\n\nWhen your orgasm subsides minutes later, you're left trembling, shaking with the residual waves of pleasure wracking your bodies.  You pull Helia close against you, letting her rest her head on your chest, her quavering breath hot on your bare, slick skin.  You stroke her hair, holding your lover close, basking in the afterglow of passion.  After a few minutes, Hel nuzzles against you, urging you to lie down.  You do so, letting her snuggle atop you with arms wrapped tight around her waist.");
	
	outputText("\n\nShe gives you a gentle, quick kiss before nestling her head on your [chest], eyes closed and breath calm.  \"<i>Can we just stay like this... just for... just for a few minutes?</i>\"");
	
	outputText("\n\nYou brush her hair and nod, happy to enjoy the loving embrace of your lover.");
	
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Take a Bath
private function takeABath():void {
	clearOutput();
	//{First Time intro}
	if (flags[kFLAGS.HEL_CAN_SWIM] == 0) {
		outputText("Noticing Hel smells particularly strongly of beer and sex - even for her - you ask your salamander lover if she'd like to join you for a dip in the stream.  Rather than with her usual energy, though, Hel's reply is to look quickly away and say, \"<i>Uh, not today, [name]. I'm, uh, not feeling in the swimming mood.</i>\"");
		outputText("\n\nYou slump your shoulders and ask why not.");
		
		outputText("\n\n\"<i>I just don't feel like it, alright?  Can we just do something else instead?</i>\"");
		
		outputText("\n\nYou could just drop the issue.... or push it, and see what's on Hel's mind.");
		//[Drop it] [Push it]
		menu();
		addButton(0,"Drop It",heliaFollowerMenu);
		addButton(1,"Push It",pushHelToSwim);
	}
	//{Repeat Intro (If you taught Hel to swin; else, play 1st Time)}
	else {
		outputText(images.showImage("helia-swim"));
		outputText("You ruffle Hel's hair and ask if the fiery salamander's up for a dip.");
		outputText("\n\n\"<i>With you?  Always,</i>\" she answers with a bright smile.  Before you can blink she's grabbed your hand and is running toward the stream, bits of clothes flying off behind her.");
		
		//Swim With Hel -- Repeat
		outputText("\n\nBy the time you arrive at the riverbank, you and Hel are both buck naked, laughing and teasing each other as clothes and weapons fly to the wayside.  With a gleeful shout, Hel cannonballs into the river ahead of you, creating a shockwave of a splash that sends ripples for yards around her.  You leap in after her, diving into the shimmering liquid behind your friend.  When you surface, Hel's already lined up a splash, showering you with water - already pleasantly warm thanks to the inferno she's carrying with her.");
		
		outputText("\n\nAfter a few playful minutes of splashing and laughing, the two of you wade back to a small rocky outcropping, sheltering you from wandering eyes.  Hel quickly curls up beside you, her head resting on your [chest] and her warm tail lying across your lap.  You wrap an arm around her shoulders, holding your lover close.  Your lake begins to turn into a sauna, the steam rising in thick clouds all around you until all you can see is the salamander and a foot of water in front of you.  So concealed, you choose that moment to give Hel a long kiss on the brow, running your fingers through her long hair and down her shoulders.");
		
		outputText("\n\n\"<i>Mmm, that's nice...</i>\" she moans, nuzzling against you. \"<i>Don't stop....</i>\"");
		//Swim With Hel -- While Wearing Valeria
		if (player.armor.name == "goo armor" && player.lust >= 33 && 9999 == 0) {
			outputText("\n\nYou and Helia cuddle in the steaming river, the minutes passing pleasantly in each other's embrace. After a moment, though, you notice a particularly blue patch of water swirling around Hel's bosom.  Curious, you reach down and cop a feel - of slimy goo.  You recoil, splashing back until a familiar voice drawls, \"<i>Howdy, partner!</i>\"");
			outputText("\n\nHel leaps to her feet, yelping as her tits start to talk...  and form Valeria's face, a circlet of goo surrounding Helia's breasts as a second patch covers her nethers, effectively a bright blue goo bikini.");
			
			outputText("\n\n\"<i>Val!</i>\" Hel groans, sinking back into the water.  \"<i>You can just ASK if you wanna play.</i>\"");
			
			outputText("\n\n\"<i>Hehe, sorry, firebutt,</i>\" the armor goo replies, her face half-hidden beneath the surface.  \"<i>Just wanted to say hi, is all.</i>\"");
			
			outputText("\n\nHel rolls her eyes, but cups her goo-coated breasts, giving Val - and her teats - a playful pinch.  With a yelp of surprise, though, Hel goes tumbling onto the riverbank, propelled by a pair of blue feet, a laughing voice echoing behind her as the two tumble into the sand.  \"<i>Why, you!</i>\" Hel giggles, spanking her own goo-covered ass in punishment.");
			
			outputText("\n\nSince both the girls are here, and in such playful spirits... do you want to have some fun?");
			//[Display Val x Hel Threesome options]
			menu();
			//99999
		}
		//Swim With Hel -- Lust less than 33
		else {
			outputText("\n\nYou and Helia cuddle in the steaming river, the minutes passing pleasantly in each other's embrace.  Eventually Hel looks up at you, her bright eyes shining in the misty air, a small smile on her lips.  You kiss her, leaning in as the salamander presses herself against you, ardently returning your show of passion.  \"<i>I wish we could stay like this forever,</i>\" Hel whispers, breaking the kiss to nuzzle against your neck. You stroke her hair and hold her close until your duties as Champion call you back to your work.");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}

//Push It
private function pushHelToSwim():void {
	clearOutput();
	outputText("You decide to fish for some answers, and ask Hel why she's so insistent on not going for a dip. She seems awfully... defensive... for someone who's just not in the mood (for once).  Hel continues to look away from you, nervously circling in the dirt with her foot-claws as she consciously tries to avoid your gaze.  You stare at her expectantly for a long minute, almost ready to give up when she finally says: \"<i>I... can't swim, okay?  Water scares the living shit outta me.</i>\"");
	
	outputText("\n\nJust as you're about to respond, Hel snaps, \"<i>Don't you make fun of me!  E-everyone's got something they're scared off, you know?</i>\"");
	
	//[Teach Her] [Drop it]
	menu();
	
	addButton(0,"Teach Her",teachHelToSwim);
	addButton(1,"Drop It",heliaFollowerMenu);
}

//Teach Her
private function teachHelToSwim():void {
	clearOutput();
	
	outputText("Putting a hand on Hel's shoulder, you offer to teach her how to swim.");
	
	outputText("\n\n\"<i>I-I don't wanna,</i>\" she whines, seeming to shrink in your embrace.  \"<i>Come on, [name], just let it go.  Please?</i>\"");
	
	outputText("\n\nYou spend the next few minutes urging and coaxing Hel to give it a try, telling her you'll be right there with her, ready to help if she needs it.  It takes some doing, but eventually, you see your friend visibly relax until she finally says, \"<i>Well... alright, I guess.  I trust you, [name].  Just... keep an eye on me, alright?  I don't want to drown.</i>\"  You assure her she won't drown, and wrapping your arm around the salamander's waist, lead her out of camp and down to the stream.");
	
	outputText("\n\nBy the time you arrive at the riverbed, you've already helped Helia out of her skimpy clothes, leaving her in a surprisingly bashful pose, covering her bare breasts with her arm as she approaches the river.  With a bit of urging, the salamander gingerly sticks her foot out, the long pale claw touching the water for the briefest instant before she recoils.");
	
	//If PC has Izma follower:
	if (izmaFollower()) {
		outputText("\n\nJust as Hel is about to put her foot in, a large red fin pokes out of the water.  You have just enough time to grab Hel and yank her back before a familiar shark-girl breaches the water, leaping onto shore with a wolfish grin.  \"<i>Heyya, Alpha,</i>\" Izma says, inclining her head to you as she wrings her hair out, grabbing a towel from behind a nearby rock.  \"<i>Oh, hi, Hel.  Don't see you around here much!</i>\"");
		outputText("\n\n\"<i>Uh, yeah,</i>\" Hel groans, blushing a brighter shade of red.  With a chuckle, Izma gives the two of you a wink and wanders off back to camp, leaving you alone with Hel once more.");
	}
	//If PC don't have no shark dominatrix: 
	else outputText("\n\n\"<i>I-I dunno, [name].  I mean, me being a firebutt... and water...  I feel like I'm gonna boil!</i>\"  You sigh, and tell Hel she'll be fine... she's just got to try.");
	
	outputText("\n\nGently, you nudge Hel back toward the water.  She hesitantly pokes a toe in... then a leg... until soon you've got her wading in, with you right behind her, keeping her steady as the water comes up to your waist, chest, then neck.  As the two of you go deeper into the stream, though, you notice a pillar of steam rising up, the water bubbling wildly as you make your way further in.  It takes you only a moment to see the culprit - Hel's fiery tail is swishing wildly between her legs, curled in like a scared dog's.  Within minutes, the stream looks like a sauna, thick plumes of steam rising up all around you as the water finally becomes so deep that Hel's feet part with the riverbed.");
	
	outputText("\n\nGrabbing the salamander's shoulders, you wade in beside her, keeping her steady as you instruct her in treading the water.  She panics more than once, but you keep a firm grasp on her, keeping her from drowning for nearly an hour until she's finally able to take her first paddle away from you.  She wades out a few feet, shakily at first, but soon gaining confidence as she moves just out of arm's reach.");
	
	outputText("\n\n\"<i>H-hey!  I think I got it!</i>\" Hel laughs, a huge grin on her face.  \"<i>Maybe this isn't so bad after all...</i>\"");
	
	outputText("\n\nYou congratulate the steamy salamander with a surprise splash, raining a wave of water down on her.  She squeals in shock, covering her face just too late to avoid getting drenched.  \"<i>Why you!</i>\"");
	
	outputText("\n\nBefore you know it, you and Hel are splashing each other with abandon, her former fears utterly forgotten as the two of you play happily in the water...");
	outputText("\n\n(You can now go swimming with Hel!)");
	flags[kFLAGS.HEL_CAN_SWIM] = 1;
	doNext(camp.returnToCampUseOneHour);
}


//Threesomes
public function heliaThreesomes():void {
	clearOutput();
	outputText("You slip an arm around Hel's waist and ask if she's up for some... group activities?");
	outputText("\n\nShe grins, her serpentine tongue flicking hungrily across her lips.  \"<i>Oh, you do know what I like, don't you?  So, who do you wanna bring in on the fun, [name]?</i>\"");
	
	//{Must have the appropriate followers, naturally:}
	//Vapula/Hel
//needs wings or 50+ str, dick, added as an option \"<i>Carry her to camp</i>\" when you defeat Hel while she is in Fuckbuddy mode.
	//[Vapula]
	//[Kiha]
	menu();
	if (vapulaSlave() && player.lust >= 33 && player.hasCock()) {
		if (player.cockThatFits(heliaCapacity()) >= 0) {
			addButton(1,"Vapula",heliaAndVapula);
		}
		else outputText("\n\nYou're too big to fuck Helia and Vapula with your cock.");
	}
	if (followerKiha() && player.lust >= 33 && player.gender > 0) {
		addButton(0,"Kiha",campHelAndKihaThreeSome);
	}
	if ((player.armor.name == "goo armor" || flags[kFLAGS.VALARIA_AT_CAMP] == 1) && player.lust >= 33/* && player.hasVagina()*/) {
		addButton(2,"Valeria",helAndValeriaCampThreesomes);
	}
	if (player.lust >= 33 && bimboSophie())
	{
		addButton(3, "Sophie", helAndSluttyHarpy);
	}
	if (player.lust < 33) outputText("\n\n<b>You aren't horny enough to start a threesome.</b>");
	addButton(14,"Back",heliaFollowerMenu);
}


//Vapula/Hel Threesome Scene
//[Needs a dick.  All praise be to PKD!]
//Helia at Camp, Intro
private function heliaAndVapula():void {
	clearOutput();
	var x:int = player.cockThatFits(heliaCapacity());
	var y:int = player.cockThatFits2(heliaCapacity());
	outputText("You gab Hel and start for the edge of camp, where a certain succubus dwells....");
	
	outputText("\n\nYou are greeted by a bunch of imps that scatter as soon as they see you: they appeared to be have been busy on the purple woman.  You smile as you walk up to Vapula, the salamander girl still clinging to your shoulders.  The trembling succubus has trouble keeping an air of composure when she sees you.");
	
	outputText("\n\n\"<i>What- what are you doing here? I hope you have a good reason for interrupting me, I was about to get-</i>\"");
	
	outputText("\n\nSLAP!  Her ass jiggles obscenely as you hit it. Vapula jolts and moans, caught by surprise.");
	
	outputText("\n\n\"<i>You talk too much, slut.  Wipe that precum out of your body, I want you to be clean for my girl.</i>\"  For a moment, she thinks you've decided to replace her and asks with horrified eyes: \"<i>Who is she? Where did you-</i>\"");
	
	outputText("\n\nAnother slap reminds her of her place and shuts her right up. You tell her it doesn't matter where you get your fucks - the least she can do is be polite with your guest.");
	
	outputText("\n\nYou feel hands wandering across your body, Hel slowly, sensuously, pulling off your [armor].  Soon, the two of you are bare, clothes and weapons discarded all around the succubus.  You push Hel over, grinding your hard " + player.cockDescript(x) + " between her legs.  As you grope the salamander girl's body, you gesture at Vapula and tell her to come closer so that you can stroke her, too.  You begin caressing each other, spending a few moments in languid pleasure until your " + player.cockDescript(x) + " looks ready to explode.");
	
	//Combine, Body
	outputText("\n\nYou whisper to your scaly girl: \"<i>That's a nice hard tail you've got there.  Do you know how to use it?</i>\" Hel nods eagerly, too turned on to form coherent words.  \"<i>Is the concept of tail-fucking foreign to you?  No, I guess you know it very well, you little slut.  Well, I want you to fuck my succubus pet senseless with your tail.  I want you to ream her ass over and over until she begs for mercy.  Don't be afraid to be rough, that's what she's here for.  I'll take care of your own fuck-holes myself.  Do you understand?</i>\"");
	
	outputText("\n\nShe doesn't say anything but you can see her long, prehensile appendage moving toward Vapula's pucker.  The succubus, still busy fondling your most sensitive points, gasps as the salamander's tail slithers up her long purple leg.");
	
	outputText("\n\nVapula lets out a piercing shriek, throwing her head back in pleasure and pain as Hel's tail suddenly slithers right up her ass.  The boiling-hotness of Hel's tail is obviously too much for your purple slut!  The succubus clings to you, gripping your flesh in a desperate attempt to put up with the brutal surprise penetration.  You ignore Vapula's efforts and whisper to Hel: \"<i>Good girl.</i>\"");
	
	outputText("\n\nAnd with a mighty thrust, you claim her pussy.");
	
	outputText("\n\nYou don't take any precautions as you brutally plow your salamander lover.  She's more than used to hard and torrid fucks, and her gushing cunt is doing an excellent job at swallowing your " + player.cockDescript(x) + " as it ferociously thrusts up and down.  You hug Hel close, holding her tight in your arms as you repeatedly impale her on your spear.  Every time your cock claps against her, she reflexively responds by pounding Vapula's ass with her own tail, making the succubus moan and grip you tighter.  The way your purple slut stimulates you only entices you to pound Hel harder and faster; the scaly girl screams in agonizing pleasure, her vagina contracting at a mad pace in order to squeeze your " + player.cockDescript(x) + " and milk you of everything you have; her arms are clamping you like a vise and her hands are scratching your back with a passionate, lust-induced fury.  You tighten your grip on Hel's shoulders, crushing her soft chest against yours and using her smooth shoulders as leverage to pump faster.  The internal fire that seems to boil within the reptile girl's body is making you feverishly mad with desire, leaving you oblivious of anything but your ferocious embrace.  The three of you undulate rhythmically against each other, entranced in a feverish sex dance.");

	//[If Multicock 2+] 
	if (y >= 0) outputText("\n\nYou feel a hand darting to your " + player.cockDescript(y) + ".  Completely thrilled by the scaly beast ramming her ass, Vapula has grabbed your second member and is now jerking it off furiously, occasionally leaning down to give it a lick when Hel's tail gives her freedom to do so.  You welcome your slut's efforts and force her to deepthroat you with one hand while the other still holds the salamander girl.  With two voluptuous cock-rings being wrapped around your genitals in such an exquisite way, it won't be long before you've given up your seed.");
	//[/Multicock]
	
	outputText("\n\nYou are now so aroused that you can do nothing but pound harder.  Hel's tail twists and bucks wildly as you wreck her cunt while Vapula lets out a deep growl as her insides are brutally churned, though you don't care much as long as the succubus slut still tries to pleasure you.  With a groan, you pull Vapula even closer to you, grabbing her head and planting a deep kiss on her lips while groping Hel's lewd body, basking in the presence of your two cock-hungry sex-goddesses.");
	
	outputText("\n\nThis libertine orgy cannot last indefinitely, and even your girls are trembling convulsively, ready to reach their climax. You manage to slide your " + player.cockDescript(x) + " up the reptile girl's twat a few more times before blasting her with your spooge.  You fill Hel's interior, pouring cum like a torrent into her womb");
	//[IF cum production massive: 
	if (player.cumQ() >= 750) outputText(" until her belly swells and starts spurting ropes of jism back out of her love-tunnel");
	outputText(".  Your junk palpitates and bulges as globs push their way out of your shaft before being absorbed by her needy pussy, and her skin and scales seem to literally boil with consumed lust.  At the peak of your orgasm, you stare at your girls' faces: Hel's is nothing but complete, insensate bliss, while Vapula is literally crying in ecstasy, tears of joy streaming down her cheeks.");
	
	outputText("\n\nSeeing how much pleasure you're giving them is quite touching, and you give each of them a long, ardent kiss, letting each girl know how the other tastes like.  At last, when your " + player.cockDescript(x) + " has unloaded its last rope of jism, you pull out and break the kiss.  Hel pants and sighs, utterly drained; you see her tail popping out of Vapula's ass, and the released succubus just falls on her back, cunt exposed and mouth open in blissful exhaustion.");
	
	outputText("\n\nThe reptile girl starts complimenting you on your sexual prowess, but you cut her off to order her to turn around.");
	
	outputText("\n\n\"<i>W-what?</i>\"");
	
	outputText("\n\n\"<i>I promised there would be anal if you were a very good girl.  You were a very, very good girl; don't you want to get your reward?</i>\"");
	
	outputText("\n\nStill not believing that you have stamina left to take care of her more lewd hole, Hel slowly lifts her tail, revealing her tight asshole, already moist from the previous fuck.  You tell her to place herself atop Vapula into a proper 69 position so the succubus will be able to lick your cum from her cunt and satisfy her demonic needs.  Knowing full well where this is going, the reptile girl smiles wide and complies, looking forward to a second fuck-session, especially if it involves anal.  The purple hell-girl is still sleeping when Hel shoves her cum-packed pussy in front of her and starts licking her wet twat.");
	
	outputText("\n\nThe stark smell of your cum instantly wakes Vapula up and before she can think of anything her tongue instinctively starts slurping the drops of baby-batter dripping from the salamander's snatch.");
	
	outputText("\n\nThe display of two horny girls eating out each other is quite arousing and your " + player.cockDescript(x) + " is already erect while your ");
	if (player.balls > 0) outputText("[balls] are");
	else outputText("groin is");
	outputText(" slowly filling back with more spunk for them.  You happily stride toward the couple of sluts, your junk ready for some more hole-filling.  Hel's tail is still lifted, the shining scales twisting hypnotically as the reptile girl gives and receives pleasure from both ends.  Her enticing butthole seems to be begging for a nice hard cock to be pierced with.  With a lust-filled grin, you grab her hot, bountiful buttocks for leverage and harshly jam her insides with your " + player.cockDescript(x) + ", knowing the fiery girl won't mind your rough ways. You utterly bury your " + player.cockDescript(x) + " inside her; her asshole obviously used to monstrous members as you have no difficulty sliding everything you can down her slippery colon.  Vapula trembles below her as you adamantly push the salamander girl back and forth with your enthusiastic dick-assaults to her backside.");
	
	outputText("\n\nThe hell-girl and the reptile-girl grind against each other, completely giving to their own pleasure as you have your way with both.  Completely mad with burning lust, Hel raises her head and lets out a huge feminine roar, expressing all her joy and desire with this single, continuous cry of pleasure, and you can swear some sparkles are escaping out of her sweltering tail.  Always eager for more cock inside her, the buttslut wraps her scaly appendage around your back and clamps you against her ass, the blazing heat steaming out of her only serving to redouble your lust.  You pound Hel like there's no tomorrow, working her blistering ass like you were the last dick she'd ever take.  She clings to you desperately and impales her butt further on your " + player.cockDescript(x) + ", as if afraid you might pull out.  Though you'd never give up such a fantastic, near bone-melting ass!");
	
	outputText("\n\nYour hot anal embrace knows no bounds but that of your respective staminas, and with a raging groan of pleasure, you cum. The huge, sticky jet of hot spunk splatters against her colon, making her screech in delight.  Your " + player.cockDescript(x) + " twitches as it releases rope after rope of jism.  Your semen nearly vaporizes as it hits the reptile's interior; you can actually see steam escaping from her cock-filled anal ring.  Her ass clenches and wobbles insanely, desperate to receive everything you have; unfortunately, there is only so much baby-batter that can fit her backdoor, and the few spurts of cum that escape are quickly gulped by Vapula as they rain in sticky globs of goo down Hel's thighs.");
	
	outputText("\n\nSince your salamander lover wants your cum so much, you keep your " + player.cockDescript(x) + " buried in her until it stops pulsing, her anal hotness accelerating and intensifying your orgasm.  At last, you pull out and plunge your cum-coated junk in Vapula's waiting mouth below.  The two girls had been squirting so often that the succubus' face is now sopping with juices.  In her current state of pleasure, Vapula doesn't protest and engulfs all your dickflesh at once, sucking the remaining bits of goo out of your urethra.  You let the demoness feed until she is sated and your " + player.cockDescript(x) + " is only covered with her saliva.");
	
	outputText("\n\nSatisfied, you help your salamander lover to her feet.  She is still dazed from the two violent fucks and keeps chuckling softly as sexual juices are dribbling down every part of her body.");
	if (!followerHel()) {
		outputText("  You kiss her and ask if she'll be able to find her way back to her home.");
	
		outputText("\n\n\"<i>Don't worry, I can take care of myself.  And if I get stuck in your camp, who cares?  If we did this every time I stumbled upon your place I would get lost more often!</i>\" she says with a cute little wink; she's still limping and giggling as she heads toward the plains.  Meanwhile, Vapula is a sorry mess.  Still digesting her copious cum-meal, she doesn't seem to mind the sexual filth coating her face.  You shrug and leave your pet to her digestion.");
	}
	player.orgasm();
	dynStats("sen", -2, "cor", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Helia + Kiha
//[Needs a gender. See the Male scene for Hel and Kiha Footjobs: Rematch Edition]
private function campHelAndKihaThreeSome():void {
	clearOutput();
	outputText("Taking Hel by the hand, you survey your camp, looking for the dusky dragon-girl of your desires.  Finally, your eyes fall upon Kiha: a flurry of red scales hacking wildly at her training dummies.  Sharing a smile, you and Hel head over, creeping up behind Kiha while she's wholly focused on the dummies, her axe hammering into them with brutal arcs, cleaving into the wood and setting it ablaze with its magic.");
	
	outputText("\n\nQuick as can be, Hel taps Kiha on the shoulder and darts out of sight.  The dragon girl gasps in surprise, spinning around with a look of rage etched across her face.  She softens when she sees you, setting her axe aside. \"<i>You got a death wish, Doofus?  Don't sneak up on me when I'm practicing,</i>\" she says, rolling her eyes.  \"<i>So what do you w-</i>\"");
	
	outputText("\n\nBefore Kiha can finish the thought, a pair of strong red arms clasp just beneath her hefty breasts, hauling her off the ground!  You grin as the bigger girl hefts Kiha off her feet, locking her in a tight hug as she struggles, \"<i>Hey, what gives!  Put me down!</i>\"");
	
	outputText("\n\nHel laughs merrily, her long tongue flicking along the nape of Kiha's neck.  \"<i>Relax, firebreath.  It's just me...</i>\"");

	outputText("\n\n\"<i>Dammit, slut, lemme go! [name]!</i>\"  Kiha growls, finally breaking free of Hel's grasp... and falling right into yours.  You grab the dragoness as she falls, and pull her right into a kiss, slipping your tongue into her mouth.  Kiha writhes for a moment, but soon relaxes, nearly melting in your embrace.  Her forked tongue plays across your own, her full red lips pressing passionately against you.  Behind her, Helia puts a hand on Kiha's shoulder, pressing her huge tits into the dragon-girl's back.");
	
	outputText("\n\n\"<i>What do you say to a little fun, huh? Show [name] what two sets of scales can do...</i>\"");
	
	outputText("\n\nKiha looks to you, eyebrow arched questioningly.  You nod, and tell her it'll be fun.");
	
	outputText("\n\n\"<i>Well, if it's okay with [name]...  I guess I could grace you with the sexual prowess of a dragon.</i>\"");
	//[Play sex-appropriate scene; herms can choose]
	menu();
	if (player.gender == 1) addButton(0,"Next",dudeHeliaAndKihaThreeSome);
	else if (player.gender == 2) addButton(0,"Next",girlsThreesomeHelAndKiha);
	else {
		addButton(0,"Male",dudeHeliaAndKihaThreeSome);
		addButton(1,"Female",girlsThreesomeHelAndKiha);
	}
}
//Female Kiha + Helia Scene
private function girlsThreesomeHelAndKiha():void {
	clearOutput();
	outputText("You slowly pull off your [armor], the cool wind stiffening your [nipples] as your sex is laid bare.  Hel and Kiha both step close, leaning in so their breasts press against your own [chest]; scaled hands play across your thighs and hips, caressing your curves and groping your [butt].  A tiny gasp escapes your lips as a pair of long, leathery tails wrap around your [legs], coiling around you as the girls kiss and lick your bare breasts, each finding a sensitive nipple to suckle from.  You groan lewdly as the lizard girls suck gently on your teats, one tail finally slithering up to tease your [clit], the other parting the cheeks of your backside, its very tip pressing against the dark star of your rear.");
	
	outputText("\n\n\"<i>Why do </i>I<i> have to take her ass?</i>\" Kiha gripes, glowering at Hel.");
	
	outputText("\n\n\"<i>Wha? I thought I was saving it for you...</i>\"");
	
	outputText("\n\nYou scowl and grab both girls' red hair, pushing them back down on your [nipples].");
	//{If PC is Lactating:}
	if (player.lactationQ() >= 50) outputText("  A shudder rocks you as the first trickles of milk seep from your teats, a small stream soon flowing out of you into the twin lizards' mouths.  Their cheeks bulge between swallows, but both coo happily as they suckle, their forked tongues lapping up every drop you have to offer.");
	//{If PC has a dick:}
	if (player.hasCock()) outputText("  Even as the girls worship your [chest], you feel a sudden pressure on [oneCock].  Hel's tail deviates from your cunt for a moment, instead wrapping lovingly around your prick.  A groan escapes your lips as her hot leathery tail coils around your manhood before looping back to tease your clitty, ensuring that your dick won't be left out of the fun.  You smile and stroke her hair, eager to get to the main course.");
	
	outputText("\n\nKiha and Hel look to each other for the briefest of moments, and nod.  You shudder as the twin tails go to work, two leather points pressing into your twin lower holes.  For what it's worth you try and relax as their prehensile appendages enter you: agonizingly slowly, Kiha pushes into your ass, her slender tip slipping through your relaxed sphincter as Hel's parts the lips of your [vagina], penetrating you like a hot scaly prick.  Your breath catches in your throat as the twin tails push into you, forging ahead as they stretch your holes wide, getting thicker and thicker with each inch that slithers into you.  The girls pierce your holes slowly but surely, steadily forcing your vaginal and anal walls apart as thicker tailmeat enters you, filling you until you can feel Hel and Kiha's tails nearly touching inside you, tantalizingly close, separated by so little of you that Kiha gasps at a flick of Hel's tip.");
	player.buttChange(20,true,true,false);
	player.cuntChange(20,true,true,false);
	
	outputText("\n\nGiggling, Hel gives Kiha a playful bump with her elbow, which only serves to make the dragoness glower - and move her tail faster, letting it writhe inside you like a mad worm.  Your mouth gapes open in a silent scream of pleasure under her oral assault... but you haven't felt the half of it yet.  Even as Kiha's tail goes wild in your gut, Hel's moves inexorably toward your innermost depths, her tip finally brushing against the lips of your cervix, teasing the guardian of your womb.");
	
	outputText("\n\nThe tip breaches your cervix, leaving you screaming with orgasmic pleasure as Hel and Kiha's tails bury themselves fully inside you, utterly filling you with their scaled appendages.  Hels' tail roughly fucks your cervical passage, needing only a few thrusts to finally bring you to your threshold.  You throw your head back and cry out as you climax, hurtling over the edge as femcum spurts from your hole, smearing onto Hel's tail and both girls' bellies.");
	//{If PC has cock:} 
	if (player.hasCock()) outputText("  As your cunt unleashes a torrent of femcum onto the scaly girls, [eachCock] finally catches up, the first thick squirt catching Hel right in the neck, leaving her with a thick, gooey pearl necklace.  She laughs giddily, quickly locking her mouth around your member so as not to waste another drop, her throat quickly going to work to milk your prick of its salty load.");
	
	outputText("\n\n\"<i>Look what you did!</i>\" Kiha growls, hooking her arm around Hel's neck and pulling the salamander down to her belly. \"<i>You made her cum all over me!</i>\"");
	
	outputText("\n\n\"<i>Gah!  Leggo, bitch!</i>\"");

	outputText("\n\nYou grab Kiha's horns to steady yourself as your cunt and ass spasm around the thick tail-cocks crammed inside you, your [legs] wobbling weakly after the double-penetration.  Even as you recover, though, the dragoness mashes Hel's face into her belly, commanding, \"<i>Come on, firebutt, clean it off!</i>\"");
	
	outputText("\n\nWith the two lizard-girls distracted, you languidly pull their limp tails out of your holes, relishing the blessedly empty feeling left before you collapse into a pool of your own juices... just to catch your breath, you insist.");
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}
//Male Helia + Kiha Threesome (Episode III: Revenge of the Footjobs)
private function dudeHeliaAndKihaThreeSome():void {
	clearOutput();
	outputText(images.showImage("helia-follower-threesome-kiha"));
	outputText("You put a hand on each lizard-girl's shoulder and push them down onto their knees, giving them a good view of the bulge [eachCock] is making in your [armor].  Eagerly, they start stripping you of your grab until [oneCock] is freed, falling out of its restraints to bop Kiha on the nose.  The dragoness recoils, giving Hel the chance to snatch it in her mouth, her lips wrapping around your shaft like a silky wet vice.  Kiha recovers, but too late to get a taste of your head, nor the first thick dollop of pre that rolls off onto Hel's reptilian tongue, but she soon busies herself tending to ");
	//if 1 cock: 
	if (player.cockTotal() == 1) outputText("the rest of your shaft, her own tongue coiling around your tool");
	else outputText("your second erection, taking it in both hands and giving it long, loving strokes before slurping up the [cockHead 1]");
	outputText(".");
	
	outputText("\n\nA pleasured groan escapes you as the fiery ladies tend to your cock");
	if (player.cockTotal() > 1) outputText("s");
	outputText(", licking and sucking with expert skill until you can feel a powerful wave of pleasure building up in your [balls], aching for release.  Just as your orgasm swells, though, Hel looks up at you with a coy grin and lets your prick pop out of her mouth, wet ropes of saliva still connecting you, and pushes Kiha back as well.");
	
	outputText("\n\n\"<i>What the hell, firebutt?</i>\" Kiha snaps, scowling at the salamander.  Hel gives her a cheeky look and, before you can blink, you're swept off your balance and come to rest firmly in the girls' embrace, your [face] pressed between the soft mounds of Kiha's chest.  You start to complain, but fall silent when the dragoness rolls you over and locks her powerful legs around your waist, the leathery soles of her feet brushing the sensitive skin of your [cock].");
	
	outputText("\n\n\"<i>What's better than one lizard footjob...?</i>\"  Hel starts, moving around to loom over you, resting her heel on your groin, her claws teasing your [cockHead].");

	outputText("\n\n\"<i>Hey, who're you calling a fucking lizard!?</i>\"");
	
	outputText("\n\n\"<i>God dammit, Kiha.</i>\"");

	outputText("\n\nBefore the dragon-girl can retort, Helia curls her flexible foot around your cockhead, eliciting a gasp of pleasure from you as your [cockHead] is enveloped in warm, soft, leathery salamander foot. Matching Hel's actions, Kiha locks your shaft in the arches of her feet and starts to move them in sync, using them together like a tender onahole.  You relax in Kiha's embrace, her arms drifting down to wrap around your [chest] as her feet massage your prick.  Your head rests lightly on her dusky bosom, her stiff nipples just beside your ears, your head rising and falling with each of her slow, measured breaths.  Her heartbeat echoes powerfully in her chest, the strong muscle resounding in your ear, the drumbeat nearly mesmerizing, certainly soothing, in its regularity... its power.  You almost feel like drifting off to sleep, though the three feet working tirelessly on your prick ensure that you remain alert enough to enjoy the cushiony embrace of your lovers' feet.");
	
	outputText("\n\nTenderly, Kiha plants a kiss in the nape of your neck, her long forked tongue tickling your " + player.skinFurScales() + ".  You turn and return her kisses, locking lips with the dragoness, your tongues entwining to the rhythm of the feet servicing your [cock].");
	outputText("\n\n\"<i>Oh, come on,</i>\" Hel groans as you and Kiha share the long, passionate kiss. Then, more quietly, \"<i>You two are so cute together....</i>\"");
	
	outputText("\n\nKiha gives the salamander a grave look, but soon softens, nuzzling her chin in your " + player.hairDescript() + ".  Hel sighs, but leans down to give you each a quick kiss on the head; her foot never misses a beat, though, and combined with Kiha's sensual massaging, you realize you're dangerously close to the edge again.  You grit your teeth and let loose an animalistic growl, the only forewarning the distracted lizards get before the first burst issues forth from your [cockHead], smearing the sole of Hel's foot with creamy seed.  The salamander makes a happy gasp as another squirt of cum smears her clawed toes, a particularly strong arc fountaining so high that it smears her thighs.");
	
	outputText("\n\n\"<i>Hey! Save some for me!</i>\" Kiha snaps - just in time for a thick smear to trickle off your cockhead and onto her foot.  She continues to pump your shaft, her feet milking you, going even faster now as your slick seed lubricates the shaft and both her soles, smeared in by the quick movements of her leathery feet.  Kiha laughs, surprisingly girlishly, as her feet are coated in your thick seed, your prick spurting more and more until her red scales are utterly drenched.");
	
	outputText("\n\nFinally, though, your cock finishes, going limp between the arches of her feet.  Kiha gives you another kiss on the cheek, hugging you close as Helia swings around to straddle the two of you, sandwiching  you between her and Kiha's bountiful bosoms.  \"<i>Nothing like a double lizard footjob, eh, Kiha?</i>\" Hel teases, nipping the dragoness's reptilian ear, making her blush.");
	
	outputText("\n\n\"<i>I'm not.  A Lizard,</i>\" Kiha growls.  Rather than answer, Hel hooks her leg around and gives Kiha a foot-full of cum on the face before bounding away, laughing madly.");

	outputText("\n\n\"<i>FIREBUUUUUUUTTT!!!</i>\"");
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Hel x Valeria Threesome
private function helAndValeriaCampThreesomes():void {
	clearOutput();
	//If PC is wearing Valeria: 
	if (player.armor.name == "goo armor") outputText("Giving Hel a little wink, you ask your current clothing if she'd like to come out and play.  The gooey parts of your armor slither out, Valeria's face materializing out of your breastplate with a grin.  \"<i>Howdy, firebutt,</i>\" the armor-goo says, giving Hel a big hug. Your salamander lover giggles, squeezing Val so hard she pops in half, only to reform beside you.  \"<i>Thanks for the invite, partner... I was getting pretty hungry, you know...</i>\"");
	//{if PC is NOT wearing Valeria:}
	else outputText("You look over to your stash and give a sharp whistle, calling Valeria over.  An amorphous blue blob soon pops up, forming into Valeria's shapely body as she strides over to give Helia a big hug.  Your salamander lover giggles, squeezing Val so hard she pops in half, only to reform beside you as you ask if she'd like to join in on your fun.  She beams, nodding quickly.  \"<i>Thanks for the invite, partner... I was getting pretty hungry, you know...</i>\"");
	
	menu();
	addButton(0,"Next",helXValeriaFemalePC);
}

//Hel x Valeria Female Version (Somewhat rewritten to support cocks. Give herm PCs some love!)
//As there's only one version of this scene, let's rework this a bit to support all genders. Quite easy to do a small edit to accommodate male PCs.
private function helXValeriaFemalePC():void {
	clearOutput();
	if (player.hasVagina()) outputText(images.showImage("helia-follower-threesome-valeria-female"));
	else outputText(images.showImage("helia-follower-threesome-valeria-male"));
	outputText("In the blink of an eye, Valeria slithers around Hel's body, almost completely encasing her in thick blue goo, leaving only her head and her resplendent reptilian rack bare.  Hel grins at you, putting a hand to her crotch and taking a handful of goo between her fingers.  With a bit of effort, she shapes a " + (player.hasVagina() ? "pair of thick blue pricks " : "thick blue prick ") + "out of her groin, each shimmering in the sunlight as Hel strokes Valeria's new appendages, coaxing out a drop of slimey pre from both tips.  Valeria's face reappears on Hel's flat belly a moment after she's done, looking down to her groin with glee as she further shapes the erect pillars of slime, morphing them into a thick knotty doggy-dick on top, and a huge-flared horsecock on bottom.  You lick your lips as the dog-dick's knot inflates enticingly.");
	var partArray:Array = [];
	partArray.push("[butt]");
	if (player.hasCock()) partArray.push("your [cock]");
	if (player.hasVagina()) partArray.push("and the slick slit of your cunt");
	outputText("\n\nThe Valeria-covered Hel takes you by the shoulder and bends you down, pushing you up against a nearby rock to expose your " + formatStringArray(partArray) + ".  You dig your fingers into the stone as Hel moves behind you, her clawed hands running roughly along your thighs, hips, and ass, groping and caressing your tender skin.  Her fiery tail brushes your [legs], coiling around before reaching up to tease your " + (player.hasVagina() ? "[clit]" : player.hasCock() ? "[cock]" : "[butt]") + ", her tip running circles around your bud, sending thunderbolts of pleasure arcing through your body.  A look over your shoulder shows the gooey salamander spreading her legs and stroking her twin blue rods with one hand, the other squeezing your [butt], pulling your cheeks apart to reveal your [asshole].");
	
	outputText("\n\nAs the goo-cocks loom in, the pointy tip of Hel's doggy dick just pressing against the dark star of your anus, the salamander lets out a sudden gasp, her breath catching in her throat.  You hear Valeria laugh wickedly, saying, \"<i>What, you think you get all the fun? Hell no, firebutt...  You're gonna get just as good as you give!</i>\" Hel gulps, looking down at the already-sizable goo knot forming at the base of her upper cock, but grabs your hips regardless, preparing to start the fun.");
	
	outputText("\n\nAgain, you feel the cool, wet tip of a cock push against your [ass], demanding entrance as the thick, flared horsemeat below finds the lips of your womanhood, passing your vulva to taste the tiny trickle of lubricant your eager body is already making.  \"<i>Mmm, </i>delicious<i>,</i>\" Valeria says, a grin spreading across the face on Hel's belly.  \"<i>Oh, this is going to be great...</i>\"");
	
	outputText("\n\nYou grit your teeth and try to relax, urging your body to allow the foreign intruders in.  Your efforts seem futile, though, as both cocks slip right in, seemingly without effort, the gooey pricks becoming so thin and so slick that your body can't deny them - only to inflate again once they've gained a foothold inside you.  You cry aloud as Valeria expands inside you, her cocks growing... and growing... thickening and thickening until " + (player.hasVagina() ? "both your holes stretch " : "your anus stretches") + " pleasurably, forced to take more and more goo until you feel as if you're going to burst, filled with more cock than you ever could have taken before.  Hel, too, cries out as the armor-goo pushes a pair of mirror cocks into her, mimicking her movements and the " + (player.hasVagina() ? "cunt" : "ass") + "-stretching size of the members she's giving you.");
	
	outputText("\n\nBoth of you take a moment to recover, trying to let your bodies adjust to the titanic cyan pillars that are forcing your " + (player.hasVagina() ? "holes" : "hole") + " agape.  Soon, though, Hel adjusts her grip on your [hips] and starts to move, slowly pulling back the few inches of length inside you, withdrawing until only the very tip and flare remain within.  You groan lewdly as Hel pushes back in, slowly, gently filling you back up with her cocks, pouring gallons of goo into your " + (player.hasVagina() ? "womb and " : "") + "rectum until her hips finally push into your [butt], both your mouths locked in silent 'O's of pleasure as Valeria's goo stretches all " + (player.hasVagina() ? "four" : "three") + " holes wide.");
	
	outputText("\n\nAnd then you feel the knot.");
	
	outputText("\n\nYou grit your teeth as the gooey knot half-inside your [ass] strains your hole, starting to seriously inflate.  Hel pulls back before you have to scream in pain, suffering the same punishment on her end.  The goo-cocks withdraw a few inches, saving you from the knot and leaving only a single ring of prepuce in your well-stretched " + (player.hasVagina() ? "twat" : "ass") + ".  \"<i>Shit, this knot...</i>\" Hel groans, starting to make shorter, quicker thrusts into you, the huge bulge bouncing against your backdoor.  \"<i>Gotta... gotta get the fucker in.  I want it so bad....  Brace yourself, lover!</i>\"");
	
	outputText("\n\nYou gulp and steel yourself, fingers digging into the stone as you try desperately to relax your sphincter; the gooey dog-cock Hel's sporting slips into you, sliding further and further in until the fully-swelled knot reaches your hole. Valeria giggles as the thick knot tries to force its way in, but the goo does not relent its shape or form, staying rock-hard and unyielding.  Moaning, you wiggle your [hips] and push back against the knot, trying desperately to take it, to finally get the damnable thing in.  But it's too big, too hard; your efforts seem in vain, only serving to get the titanic sphere lodged half-way in you, stretching you until you can't help but cry out in pain and pleasure, your [ass] pulled apart well beyond its limit.");
	player.buttChange(30,true,true,false);
	if (player.hasVagina()) player.cuntChange(20,true,true,false);
	
	outputText("\n\nWith a loud, wet POP, the knot finally pushes in. You scream with pleasure as the wad of goo finally batters its way inside you, a huge gush of blue seed spurting out of Valeria's cockheads and into your " + (player.hasVagina() ? "womb and " : "") + "gut with it.  Just as Hel finally knots you, the horsecock's flared head rams through your cervix, spewing slime freely as Valeria cums, both she and Helia crying out as they orgasm in unison, driven mad with ecstasy by the knotting of their cocks.  You, too, can feel orgasm mounting, " + (player.hasVagina() ? "both your holes " : "your hole ") + "being roughly savaged by the double penetration of Valeria's gooey pillars.  A few short, near-panicked thrusts of the two huge members and the orgasm comes.");
	player.slimeFeed();

	outputText("\n\nGoo pours into you, cold fluid sloshing in your belly" + (player.hasVagina() ? " and womb" : "") + ", more and more pouring in until you're completely gravid, your own orgasm serving only to milk more and more slimey cum from the googirl.  Hel bucks her hips wildly into you, pinned into short, maddeningly fast strokes by the thick knot still locked in your [ass].  " + (player.hasVagina() ? "A great spurt of femcum sprays from your [vag] " : "") + (player.hasCock() && player.hasVagina() ? "while " : "") + (player.hasCock() ? (player.hasVagina() ? "r" : "R") + "opes of jism shoot from your [cock]" : "") + ", largely soaked up by the gooey horsecock; Valeria laughs, grabbing your [nipples] and giving them a hard tweak, urging more and more of your fluids out, her pricks battering into you.");
	
	var fluidArray:Array = [];
	fluidArray.push("goo");
	if (player.hasCock()) fluidArray.push("cum");
	if (player.hasVagina()) fluidArray.push("femcum");
	outputText("\n\nFinally, the orgasm subsides, and you're left trembling in a pool of " + formatStringArray(fluidArray) + ", " + (player.hasVagina() ? "lube leaking freely out of your cunt " : "") + (player.hasCock() && player.hasVagina() ? "while " : "") + (player.hasCock() ? (player.hasVagina() ? "cum still drips from your cock " : "your cum still dripping from your cock ") : "") + "and into Valeria.  Sighing contentedly, Hel reaches around to give you a long kiss before she pulls out... or tries to, anyway.  The knot, however, remains firmly in place.");

	outputText("\n\n\"<i>Uh, Val.... just... why?</i>\" Hel groans, trying to free the knot.");
	
	outputText("\n\n\"<i>Sorry, firebutt... You're in for the FULL experience!</i>\"");
	
	outputText("\n\n\"<i>Oh, for fuck's sake!</i>\" Hel snaps, trying to pull out again and again, tearing at the goo covering her body, only for it to reform a moment later.");
	
	outputText("\n\nHanging her head, Hel moves with you so that you can both get on all fours. Hel swings a leg over your ass, making it so that you're sitting butt-to-butt, the knots in both your asses slowly deflating - a bit too realistically for comfort...");
	player.orgasm();
	dynStats("sen", -3);
	doNext(camp.returnToCampUseOneHour);
}

//Guard Camp / Unguard Camp
private function helGuardToggle():void {
	clearOutput();
	//[If Hel is NOT guarding Camp]
	if (flags[kFLAGS.HEL_GUARDING] == 0) {
		outputText("You ask Hel if she wouldn't mind watching the perimeter for a few hours during the night.");
		outputText("\n\n\"<i>Sure thing, [name]!  I've got your back!</i>\" she says, her tail reaching around to give you a pop on the [butt].");
		flags[kFLAGS.HEL_GUARDING] = 1;
	}
	//[If Hel IS guarding Camp]
	else {
		outputText("You tell Hel she doesn't need to keep watch at night anymore.");
		outputText("\n\n\"<i>Is that a fact?  Well, I guess that gives us more time to party at night!</i>\"");
		flags[kFLAGS.HEL_GUARDING] = 0;
	}
	menu();
	addButton(0,"Next",heliaFollowerMenu);
}

//The Set Up
//Triggered randomly upon visiting Helia in camp. Requires you have a dick bigger than Helia’s butthole.
private function heliaAnalTrainingPrompt():void {
	clearOutput();
	flags[kFLAGS.HELIA_ANAL_TRAINING_OFFERED] = 1;
	outputText("“<i>Hey there, lover mine. Got a minute?</i>” Helia asks with dangerous glint in her eyes.");
	outputText("\n\nYou shrug and answer that you do. You walked up to visit her after all.");
	outputText("\n\nThe fire-tailed nymphomaniac grins and saunters up to you, ");
	if (player.tallness < 60) outputText("her bosom towering over you");
	else if (player.tallness < 72) outputText("towering over you");
	else if (player.tallness < 90) outputText("meeting you eye to eye");
	else outputText("looking up at you confidently");
	outputText(" as she boldly reaches into your [armor] to squeeze your ");
	if (player.cockTotal() > 1) outputText("biggest ");
	outputText("[cock biggest]. “<i>This monster,</i>” she says as she gleefully massages your swelling erection, “<i>is too big to give me the reaming I want right now. That is unacceptable.</i>” She squeezes, dragging sharp nails gently along your sensitive underside as your gear threatens to rupture from sheer tumescence. “<i>So I’d like to undergo a bit of a training regimen to turn your favorite cocksleeve into an elastic pucker capable of serving her special, “little” friend. All I need from you is some of the goblin ale that makes those petite sluts so stretchy.</i>”");
	outputText("\n\nHelia stops her gropes and winks knowingly at you. “<i>I know you could always find a way to shrink that behemoth down, but I’d rather show you just how well I can rise to the challenge, so to speak.</i>” She flashes you another grin. “<i>So, get me some of that whenever you have a chance, and I’ll get some monster dildos to practice with. In the meantime, what’s on your mind, lover?</i>”");
	outputText("\n\n(<b>Anal training is now available under Helia's talk menu so long as you have a penis that is too big for her and a bottle of Goblin of Ale in your inventory.</b>)");
	//Helia menu
	heliaFollowerMenu(false);
}
//Give Her Ale
private function giveHeliaAnalTraining():void {
	clearOutput();
	outputText("You hand Helia a bottle of goblin ale and question if she’s sure this won’t make her loose.");
	outputText("\n\nThe proud salamander berserker explains with a wink, “<i>That won’t make my asshole any looser that it is right now.</i>” She strips naked with aplomb, shaking her hiney in your direction while her tail snuggles around your neck, sinfully warm but less hot than appearances would indicate. A large, knotted buttplug appears in one of her hands, fitted with a tube that dangles down and connects to a bulb. Helia defly attaches the bottle of booze to the sexual contraption, causing the alcoholic beverage to trickle out of a tiny hole in the tip. The device shines wetly in the sun as she pumps it a few times to get it completely coated.");
	outputText("\n\n“<i>I’ve never been able to take the knot on this fucker before. Let’s hope the ale does its job, eh?</i>” Her tail unwraps from your neck as she squats low, positioning the toy on a flat spot so that it’s stable beneath her juicy, toned ass. Helia presses her pucker down on the point and shudders. “<i>Oooh, cold,</i>” she mutters. “<i>I’ve got just the thing.</i>” Her fiery spinal protuberance curls low, right around the base of the plug and begins to glow, hot enough that steam wafts up off her chosen training tool.");
	outputText("\n\n“<i>Ahhh,</i>” she sighs as she starts to sink lower. One of her hands grabs hold of one of her breasts and squeezes while the other dives into her dripping-wet snatch. “<i>Gods, I love the feeling of being stretched, just have my asshole WRECKED by some huge boner.</i>” She winks at you and sinks a little lower, diverting from her large chest to pump some of the transmogrifying ale into her spreading anal passage. “<i>Fuuuuuuuck that feels good! A girl could get addicted to this.</i>”");
	outputText("\n\nHelia spreads her legs as wide as possible to help handle the impressive girth that’s plowing into her bottom. Sometimes she stops, panting and gasping for breath as she vigorously frigs her clit through an orgasm. Other times she goes up a bit before smiling and dropping back down, often taking an inch more than before grinding back to a halt. She idly pumps more and more of the ale straight into her toy-gaped asshole, whimpering excitedly as her exposed skin slowly flushes.");
	outputText("\n\nYour scaley lover slurs, “<i>Shit, this stuff is potent. I forgot it was alcoholic...</i>” Her hand pumps the device a few more times, causing her to almost instantly slide the rest of the way down, her cheeks spreading obscenely around the spherical bulge at the base. “<i>Almosht... almost there...</i>”");
	outputText("\n\nHelia’s hands work in a frenzy, spreading and filling her folds while fervently squeezing the device to push the last of the ale straight up her ass. She bounces up and down hard enough to move the whole toy with her, rivulets of goblin ale trickling out of her plugged pucker to wet the giant-sized dog-dick.");
	outputText("\n\n“<i>Get over ‘ere, lover mine,</i>” she calls, with a lewd lick of her lips. “<i>I need a little more motivation...</i>”");
	outputText("\n\nYou catch her meaning and strip to free [eachCock], ");
	if (player.cockTotal() > 1) outputText("selecting the biggest and heaviest to stroke as you near her");
	else outputText("grabbing it and stroking it as you near her");
	outputText(", admiring the hefty weight slowly and imagining it violating her stretchy sphincter in the same way as her toy. She growls and lashes her tail around your [leg] to drag you closer, impatiently stabbing four fingers into her twat at a time with such force that her juices occasionally splatter out onto the dirt and you, now that you’ve come close. She helps to guide your [cock biggest] onto her face with her free hand, loudly moaning into it as her hips spread wider.");
	outputText("\n\nThe sexual excitement of having your ");
	if (player.tallness < 72) outputText("big, ");
	outputText("scaley girlfriend worshipping your cock from below wars with your marvel at the size of the insertion she’s taking. It shouldn’t be possible for her hips to widen around a big, butt-fucking plug, but they are. Though she isn’t turning green or sprouting elfin ears, Helia’s body does seem to be gaining the elastic properties goblins are known for. She whimpers and cries out, lurching downward a full six inches as the knot vanishes into her belly, rounding her body with a plainly visible paunch. Her fist slips into her twat, and she cries, “<i>It’s soooo biiiiiggggg!</i>” Gushes of femspunk pour out of her relatively neglected cunt with each climactic convulsion, quivering beneath your cock as she lewdly licks as much of your length as her body can reach.");
	
	outputText("\n\nThe sorely stretched salamander thrashes wildly as she cums, but her cock-tending affections somehow remain tender, pumping and toying with the distended dong, sometimes groaning and whispering, “<i>I want you inside me.</i>” into your immense phallus. Still impaled, Helia slowly comes down from her lascivious frenzy, still impaled on a knot so big it would look out of place on a giant hellhound.");
	
	outputText("\n\n“<i>That was EPIC, lover mine!</i>” she raggedly cheers, now focusing both her hands on stroking the lengthy shaft that’s pressing down upon her, keeping her tender backside as firmly impaled as possible. “<i>Let me return the favor.</i>” ");
	if (player.balls > 0) outputText("She tilts forward to press her chin into your [sack] and begins to lather your [balls] with frothy, warm, salamander spit. One hand hefts a weighty nut as she works, caressing it as if it would somehow coax the cum out of it. ");
	outputText("Helia slides her palms along either side of your urethra, letting her fingers handle the central, sensitive bit on the underside, following in the path of slick saliva she left for them to follow. She rubs her nose into the sensitive area just below your [cockHead biggest]. You grunt as pre-cum begins to pour in response, your bloated boner flexing atop Helia’s head as you feel a dangerously powerful orgasm welling up within you.");
	
	outputText("\n\nThe drunken salamander wiggles her stuffed backdoor happily around the impaling object as she strokes you faster and faster, talking into the bottom of your [cock biggest], begging it to dump a huge load all over, to drench her with gallons of spermy jism. As if you could hold back after such a lurid request. Your muscles clench powerfully");
	if (player.balls > 0) outputText(", hard enough to lift your nuts in their [sack]");
	outputText(", and you erupt, cumming a steamy hot load of spunk straight onto Helia’s face, head, and back.");
	if (player.cumQ() < 250) outputText(" You run out before long, but it’s still enough to make her a white painted mess. She licks the excess from her upper lip and shudders happily.");
	else if (player.cumQ() < 2000) outputText(" You spurt rope after rope onto her, actually drenching her hair with alabaster moisture. Her back and face look equally smothered with spooge when you finish. She’s happy to wipe the goop out of her eyes and shovel it into her mouth, swallowing it down with a satisfied smile.");
	else {
		outputText(" You pour ivory waves of spooge across her body, soaking her from head to toe with the fruit of your loins, liberally basting her with baby-batter. She groans as the excess washes out around her knees");
		if (player.cumQ() >= 3000) outputText(", but you keep cumming, cascading fresh waves onto her until there’s not a single part of her that isn’t stained and dripping with your salty outflow");
		outputText(". Helia licks her hands clean, wipes her eyes and devours that as well, and then gives you a dripping-wet, sensuous smile.");
	}
	outputText("\n\n“<i>That’s what I’m talking about!</i>” she cheers as she stands up, her legs looking an inch or two farther apart than normal as she rises. “<i>I’m gonna leave this guy in another half hour or so to make sure this takes, ");
	//increase Helia capacity.
	flags[kFLAGS.HELIA_ANAL_TRAINING] = 1;
	if (player.biggestCockArea() < helAnalCapacity()) {
		outputText("then maybe I can handle you, my hung " + player.mf("stud","breeder") + ".");
	}
	else {
		outputText("then maybe we can see about trying something bigger.");
	}
	outputText("</i>”");
	
	player.consumeItem(consumables.GOB_ALE,1);
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);	
}

private function heliaGapeSceneChoices():void {
	if (flags[kFLAGS.HELIA_ANAL_TRAINING] == 0) giveHeliaAnalTraining();
	else if (flags[kFLAGS.HELIA_ANAL_TRAINING] == 1) heliaAnalTrainingPartTwo();
}

//Anal Training #2
private function heliaAnalTrainingPartTwo():void {
	player.consumeItem(consumables.GOB_ALE,1);
	clearOutput();
	outputText("Pulling out another bottle of ale you dangle it before the slutty salamander, saying, “<i>A present for my favorite buttslut.</i>”");
	outputText("\n\nHelia grabs it out of your hand and produces one of her own, clinking the two bottles together with a wink. “<i>Thanks lover mine, but I bumped into a goblin myself not long ago. Being spit on my tail loosened her pouch strings nearly as much as her twat. She had so much fun that she even helped me modify this beasty with the features my other plug had.</i>” Helia kicks an absolutely massive equine dong with her foot. “<i>Got it from a shop in Tel’Adre. Supposedly it’s designed as a toy for centaur mares that have had gotten a bit big after a few births.... I’m told it’s a life size mold taken off some green imp-morph. Crazy rght?</i>”");
	outputText("\n\nRolling around from her kick, the immense toy flops softly. It’s nearly a foot across and tall enough to make you wonder just where Helia intends all that length to go. It is unmistakably a horsecock, veiny and ridged with a big, flat flare at the tip. A medial ring surrounds the middle, and a pair of giant, juicy balls form the base, just underneath a replica of a sheath, made of soft material. Helia hefts it up onto the flattened underside so that it stands vertically, or at least as vertically as an immense, floppy dildo can be.");
	outputText("\n\nYou do a take from the dildo to her face and back again. How in the gods’ names is she going to take such an expansive member up her ass? You’ve wanted to put your [cock biggest] up there for some time, but seeing something mimicking your unholy size in person really drives home what an absurd insertion this is going to be. It’s not too late - you could stop her now.");
	outputText("\n\nDo you stop Helia?");
	//[Yes] [No]
	menu();
	addButton(0,"Anal Train",yesMakeHeliaAGapeSlut);
	addButton(1,"Stop",noGapeSlutForHelia);
}
//Stop the Asspocalypse
private function noGapeSlutForHelia():void {
	clearOutput();
	outputText("You step up and kiss Helia, telling her that she doesn’t have to this for you, at least not right now.");
	outputText("\n\n“<i>Seriously, lover mine? I thought you’d like to do a little anal adventuring with that massive pole you’re packin’,</i>” the salamander asks while looking at you with some concern. A huge smile suddenly spreads across her mouth as she realizes just what’s going on. “<i>You’re worried about me!</i>” Helia slugs you on the shoulder none too softly before slamming you into a tight hug, pressing you into her heavy breasts and lifting you off the ground, her face nuzzling tenderly against you.");
	outputText("\n\nYour [feet] hit the ground when the confident salamander drops you, and she says, “<i>Your call. I’m gonna pour these into my still to give it a little extra kick. Don’t fret, the transformative shit should burn off right quick.</i>” She turns and depart, her tail giving you a heat slap on the [butt]. “<i>Catch ya later, [name].</i>”");
	doNext(camp.returnToCampUseOneHour);
}



//Buttdevastation Ahoy!
private function yesMakeHeliaAGapeSlut():void {
	clearOutput();
	flags[kFLAGS.HELIA_ANAL_TRAINING] = 2;
	outputText("Helia hooks a finger into your [armor] and begins to tug you out of it, a task made difficult due to your ludicrous size. “<i>Don’t think I’ll let you go without draining this monster, [name].</i>” Inch after inch of semi-hard cock is pulled into Helia’s firm grip, expanding with every passing moment, thickening into a truly monstrous dong. She caress the [cockHead biggest], even going so far as to playfully finger the supersized cumslit at its apex, her eyes playfully flicking up to meet your own. “<i>Now, sit back and enjoy the show.</i>”");
	
	outputText("\n\nThe lustrous lizardwoman prances up onto small flat boulders that have been placed a foot in front of the immense toy. In her hand, the goblin ales clink and chime against each other, promising her the elasticity she so craves. You can’t help but admire the way her tits and ass shake and sway while she upturns the drinks into a more advanced looking reservoir. This time, there is no hand pump. The fluid is trapped inside a large metal canister that whirrs and chugs noisily once Helia pushes a button, though some of it immediately bubbles out from the sextoy’s blunted tip, whetting it will alcoholic moisture.");
	outputText("\n\n“<i>Here goes nothing.</i>” the scaley woman declares a moment before swiveling her hips to plant her shapely rump atop the ale-dripping, prick-shaped fountain. The giant black horsecock bows out in the middle, not sliding in a single inch in spite of Helia’s grunts and groans. Frustrated, she lashes at it with her tail, wrapping it twice over around the medial ring of the titanic tool in order to correct the deformation and more firmly plug her own pucker. She shivers, back going ramrod straight momentarily, then you see her whole body relax slightly.");
	outputText("\n\nHelia groans, “<i>Ohhh, it’s pumping inside me now. Shhhit, that stuff has some kick.</i>” She relaxes a bit more, almost slouching atop the mock horse phallus, right up until you see her hips spread wide, proof of her already enhanced elasticity. There’s a wet pop and then Helia is moaning, rocking her ass back and forth with the big, fat flare lodged firmly inside her rectum. “<i>It’s fucking huge!</i>” she cries while looking incredulously at you. “<i>It doesn’t hurt... warm though.</i>” She wiggles sensually and cups her tits under her forearm, pulling them on display. “<i>...feels purdy good actually,</i>” she half moans half whines, sinking a half inch down the length.");
	outputText("\n\nHelia tweaks her nipples and begs, “<i>Could you... touch yourself for me? I wish it was that going inside me right now, maybe my asshole so soft and forgiving that it’ll cling to small cock or your rigid mast regardless of size. Jack off for me, lover mine. Spank it!</i>” Her pussy glistens with moisture by the time she makes the last statement, dribbling down her taint and onto the black phallus’s length. You languidly handle your [cock biggest] with slow, purposeful strokes. There isn’t a point in blowing your load during the foreplay after all. Helia teases her breasts, squeezing and kneading them with enthusiasm, tweaking her nipples, her body sinking a little further with each excited grope.");
	outputText("\n\nToned skin slowly deforms under the size of the gut-stretching, bitch-breaking bone, turning Helia’s taut middle into a show that proudly displays every ridge and vein of the intruding member. Her legs are splayed out to either side, not even supporting her anymore. The only thing holding her up is the size of her toy and her body’s stubborn insistence that it just won’t fit. Goblin machinery whirrs away down below, pumping more and more of the body-altering chemicals straight into her vulnerable rectum.");
	outputText("\n\nYour lover’s eyelids sink a bit lower as the fluid levels falls below fifty percent, obviously affected by the alcoholic portion of the drink as she slurs. “<i>Okay this feelsh REALLY good, like, great even! I can feel my muscles stretching and my bones giving way for cock. It’s a little weird but it feels so good. My ass feels even better that my puss-</i>” She’s cut off when she bumps to a halt, her toes scraping the dirt as she dangles, suspended on the horse-cock’s middle ring. “<i>Dunno how much-</i>” She hiccups. “<i>-more I can take! Feels like I’m pretty full...</i>”");
	outputText("\n\nThe goblin contraption down below chooses that moment to spin up with a high-pitched whine, visible rocking and rattling around as the rest of the reservoir is rapidly empty straight into Helia’s newly-pliant asshole. She giggles as she’s filled with the elasticity inducing mutagen and rubs her pussy, cumming noisily as her belly button pops out to form an outtie. Ladyspunk pours in an unchecked river from between her legs, washing over the balls. Clouds of dust kick up as her spasming feet settle down, the medial ring long devoured by her hungry butthole. Helia starts to thumb at her clit midway through the anal massacre, eventually curling her tail around to stuff it straight up her wanton hole. Steam fogs the air around her as she lewdly tailfucks herself, chanting, “<i>Fucking yess! Fuck me, [name]! Fuck my ass! Spitroast me on that cock!</i>”");
	outputText("\n\nYou jack off with hungry strokes as you listen to her orgasmic chatter, spurred on by the slutty salamanders smutty mouth. You’re dripping pre-cum from [eachCock] quite readily by the time the steam clears and you see Helia standing there, her lower torso distorted by the veiny intrudor. She’s rubbing her belly and sighing quite happily, but she does have enough sense to crook a finger in your direction, panting, “<i>Bring that bad boy over here, " + player.mf("stud","’stud’") + ". I’m gonna suck out the cream filling.</i>”");
	outputText("\n\nStaggering up, still stroking your [cock biggest], you ");
	if (player.str < 50) outputText("strain to ");
	outputText("heft it up, pressing the [cockHead biggest] on Helia’s thirsty lips. She sandwitches the " + num2Text(Math.round(player.cocks[player.biggestCockIndex()].cockLength)) + "-thick shaft in between her tits and left arm while her right tickles the sensitive underside. Her tongue slides around your urethra, collecting every single drop of pre-cum and stimulating nerve endings you didn’t even know you had. You groan and flex powerfully, preparing to dump a thick load into the hot salamander’s mouth. She spreads her lips around your cum-slit and kisses your cock hard, sucking powerfully, drawing the bubbling tide of wide straight out of your [balls] with her hungry movements.");
	outputText("\n\nYou sigh when the pressure inside you is relieved, pushed straight into Helia’s cock-thirsty lips. Her cheeks bulge as she takes in your load, and she swallows it almost immediately. She’s forced to repeat it again and again");
	if (player.cumQ() < 1000) outputText(", ignoring the way your sheer volume of spunk leaks from the corners of her mouth and nose, her belly gradually rounding with cum in addition to thick dildo");
	outputText(". The slutty salamander eventually pulls it off and ");
	if (player.cumQ() < 2000) outputText("squeezes a last few dollops onto her face, letting them stain her with your scent.");
	else outputText("allows you to hose her down with your ongoing waves of salty jism, soaking her in your sexual scent.");
	outputText(" Helia burps. “<i>Fuck me that was awesome! Whoah, don’t mind me, but I, uh... I think I’m gonna stay here for a little while, maybe just rock up and down till I come down off this buzz. She blushes and begins to finger her snatch again. Just let me... just let me get used to.</i>” She shoos you away and goes back to toying with herself, getting used to her new “flexibility”.");
	outputText("\n\n“<i>You’re gonna fall in love with my asshole, lover mine,</i>” Helia calls after you.");
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}

//It's Helia's Birthday, Bitch (Or, how Helia officially crossed the Mary Sue line)
//{Play the evening of on August 24. Must have completed Tower of the Phoenix & have unlocked Tel'Adre.}
public function heliasBirthday():void {
	clearOutput();
	outputText("Looking around camp, you see just about the strangest thing you've laid eyes on since coming to this accursed world: Helia the salamander, normally wearing her sluttiness on her shoulder with little more than an armored bikin, is striding toward you with hips a-swaying, wrapped up in a brilliant low-cut red evening gown.  Though backless and cut off just below the knees, it's by far the most conservative thing you've ever seen the sexy salamander wearing.  You can't even see a weapon on her, save her razor-like claws and swishing, fiery tail.");
	outputText("\n\n\"<i>Hey, lover mine,</i>\" she says, slipping into your arms to press her lips to yours. \"<i>Hey, do you know what day it is?</i>\"");
	
	outputText("\n\nThe heat of your lover's body pressed to yours, the feeling of her supple leathery scales caressing your " + player.skinFurScales() + " makes your mind skip a beat before you mumble, \"<i>Uh, Saturday?</i>\"");
	
	outputText("\n\nHel rolls her eyes, overly dramatic.  \"<i>Ugh, come on, [name].  I asked you last week to come to town with me.  Dad and Kiri are probably waiting for us.</i>\"");
	
	outputText("\n\nYou can't recall Hel inviting you to anything, but whatever.  You could go along with the sexy salamander - and you can tell by her attire that it's going to be something special - or say no and hang around camp while she goes and has fun.");
	
	flags[kFLAGS.HELIA_BIRTHDAY_OFFERED] = 1;
	menu();
	addButton(1,"Stay Home",stayHomeFromHeliaParty);
	addButton(0,"Go To Party",goWithHelia);
}



//Stay Home
private function stayHomeFromHeliaParty():void {
	clearOutput();
	outputText("\"<i>Aww, lame,</i>\" Hel groans, sighing.  \"<i>Fiiiiiine.  I guess I'll just go have awesome fun and party hard without you. Don't stick too hard into that mud, lover,</i>\" she chuckles, giving you a reassuringly affectionate kiss on the cheek before trucking off.");
	doNext(playerMenu);
}

private function helPartyMenu():void {
	awardAchievement("Happy Birthday, Helia!", kACHIEVEMENTS.HOLIDAY_HELIA_BIRTHDAY);
	menu();
	//heliaDrinks
	if (flags[kFLAGS.HELIA_BDAY_DRINKS] == 0) addButton(0,"Drinks",heliaDrinks);
	//heliaHakonAndKiri
	if (flags[kFLAGS.HELIA_BDAY_HAKON_AND_KIRI] == 0) addButton(1,"Hakon 'n Kiri",heliaHakonAndKiri);
	//heliaPhoenixes
	if (flags[kFLAGS.HELIA_BDAY_PHOENIXES] == 0) addButton(2,"Phoenixes",heliaPhoenixes);
	//heliaAndFoxTwins
	if (flags[kFLAGS.HELIA_BDAY_FOX_TWINS] == 0) addButton(3,"Fox Twins",heliaAndFoxTwins);
	//leaveWithoutSex
	addButton(4,"Leave",leaveWithoutSex);
	//leaveWithGirls
	if (flags[kFLAGS.HELIA_BDAY_FOX_TWINS] > 0) addButton(5,"Leave w/Girls",leaveWithGirls);
}


//Go with Her
private function goWithHelia():void {
	clearOutput();
	outputText("\"<i>Sounds like fun.  Let's go,</i>\" you say, offering your arm to Hel.  She grins and takes it, holding herself close as she takes the lead, steady paces quickly drawing you out into the vast deserts of Mareth beside your lover.");
	//{If Kiha, Isabella, and/or Valeria are at camp:}
	if (isabellaFollower() || followerKiha() || flags[kFLAGS.VALARIA_AT_CAMP] == 1) {
		outputText("  Looking over your shoulder as you depart, though, you notice that camp looks particularly... empty. Perhaps your other camp-mate");
		if (camp.companionsCount() > 1) outputText("s are");
		else outputText(" is");
		outputText(" out, too? You shrug. You and Hel aren't the only ones with lives, you suppose.");
	}
	
	outputText("\n\nThanks to Mareth's strange, ever-shifting geography, the walls of Tel'Adre soon loom high over you.  With every step, Hel seems to be getting giddier, practically ");
	//if less than 7' PC: 
	if (player.tallness < 84) outputText("sweeping you off your feet");
	else outputText("hanging off you");
	outputText(" as you approach the great gates.  The only one on gate duty today is Urta, the grey-coated fox curled up under a small awning beside the gate with a huge canteen resting beside you.  Her centauress partner is noticeably missing, but Urta still gives you a wave and a grin you can't quite read.");
	
	outputText("\n\n\"<i>Hey, cutie,</i>\" she says with a wink, pushing open the door for you.");
	//If PC did UrtaQuest: 
	outputText("\n\n");
	if (flags[kFLAGS.URTA_MET_HEL] == 1) outputText("From the quick look she and the salamander exchange, you get the feeling they've met before. Weird. Still, ");
	outputText("Urta gives you a small nod as Hel leads you into town, past the half-empty guard post and into the bustling main street.  The market way's particularly busy in the late afternoon, bustling with activity as merchants hawk their wares and the first of the street-walkers start to come out, standing in seductive poses in the shade of the alleys.  More than a few send catcalls your way, a few even offering discounts for couples.");
	
	outputText("\n\nHel grins at the attention, suggesting that when your visit with her folks is over, maybe you'd like to \"swing back and pick up a little fun for the night.\"  You consider her suggestion a moment, but before you can give answer, you feel the heat of her body pressing tightly to you");
	if (player.tallness <= 72) outputText(", her head resting on your shoulder");
	outputText(".  \"<i>Hey, thanks for coming, [name],</i>\" she says quietly, squeezing your arm, \"<i>Kiri's done nothing but talk about you since the tower.  I think someone has a crush...</i>\"");
	
	outputText("\n\nHel stifles a laugh as you push your way through the crowd, teasing and laughing together until you see the hermaphroditic centauress looming over the Wet Bitch's doors... which are, rather oddly, closed.  You stop a pace back, looking around for any sign of the usual horde of bar crawlers and tavern dwellers, but the Bitch seems dead empty, and deathly quiet inside.  You exchange a look with your lover before giving the door a sharp rap.  The door creaks open on its own onto the darkened bar, and you have just enough time to see a \"Reserved\" signed flutter past you before Helia takes a step inside.");
	
	outputText("\n\nYour heart just about skips a beat when the lamps suddenly fire up and a chorus of voices cry out, \"<i>SURPRISE!</i>\"");
	
	outputText("\n\nHel jumps back, practically falling into your arms as the bar lights up, filled with people: Hakon and Kiri at the forefront, her family smiling wide.  Behind them, surrounding a great big cake practically as tall as Hel is, stands ");
	var list:Array = ["Edryn"];
	if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) list.push("Valeria");
	if (followerKiha()) list.push("Kiha");
	if (isabellaFollower()) list.push("Isabella");
	list.push("a handful of her wide-hipped and winged half-sisters, the phoenixes");
	outputText(formatStringArray(list) + ". You turn to Helia and cock a grin as you see the surprise etched on her face, followed by the growing smile.  \"<i>Happy birthday, Helia!</i>\" they all shout out at once, raising mugs frothing over with beer.");
/*
	addToList("Edryn");
	if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) {
		addToList("Valeria");
	}
	if (followerKiha()) {
		addToList("Kiha");
	}
	if (isabellaFollower()) {
		addToList("Isabella");
	}
	addToList("a handful of her wide-hipped and winged half-sisters, the phoenixes");
	outputText(outputList() + ". You turn to Helia and cock a grin as you see the surprise etched on her face, followed by the growing smile.  \"<i>Happy birthday, Helia!</i>\" they all shout out at once, raising mugs frothing over with beer.");
*/	
	outputText("\n\n\"<i>Oh my god you remembered!</i>\" the salamander smiles, \"<i>I-I didn't think any of you knew.</i>\"");
	
	outputText("\n\nKiri flutters up on her bright red wings, hugging her sister tight.  \"<i>I... may have mentioned it to a few friends.  Who had some friends.  And then Dad found some of my sisters ");
	if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) outputText("who forgave us for the queen's death");
	else outputText("who wanted to be friends still, even after the Tower");
	outputText(" and... it sort of became a thing.  Hope you don't mind!</i>\"");
	
	outputText("\n\n\"<i>No, I... thanks, sis.</i>\" Hel says, squeezing the little harpy.  Kiri blushes as the gathered crowd approaches, pushing mugs into your hand and Hel's, gathering around their friend and lover to shake her hand or hug and kiss her.");
	
	outputText("\n\nKiri slips out of the crowd to plant a quick kiss on your cheek, followed by Hakon vigorously shaking your hand, great claws scoring your " + player.skinFurScales() + " as he thanks you again for the rescue, and for ");
	if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) outputText("finally killing that bitch of a queen");
	else outputText("setting the queen right, but leaving her alive for when it's finally time to bring the fight to Lethice");
	outputText(".  You nod at his thanks, and his hand is soon replaced by Helia's as she grabs you on her way toward the gigantic cake.  The towering white confectionary seems more than big enough to feed everyone in the group, a huge extravagance on the part of her family.  You hear a quiet whisper about ");
	if (flags[kFLAGS.FREED_VALA] == 1) outputText("a certain waitress fairy having... supplied the icing herself");
	else outputText("a certain minotaur chef having supplied the icing himself");
	outputText(" as Hel is handed an oversized knife and urged to blow out the candles atop it, arranged into a perfect 23.");
	
	outputText("\n\n\"<i>Make a wish, kiddo,</i>\" Hakon says, giving hel a little push toward the over-sized cake.");
	
	outputText("\n\nShe pauses, taking a long moment to think.  The gathering of friends closes in, surrounding her, waiting for the big moment.  She turns to you with a little wink and blows hard, extinguishing the flickering lights in one great huff.");
	
	outputText("\n\nAnd then the cake explodes.");
	
	outputText("\n\nYou and Hel both yelp and stumble back as creamy white blasts everywhere, the top of the cake thrown off as ");
	if (flags[kFLAGS.HEL_FOXY_FOURSOME_WARNED] == 1) outputText("a pair of lovely fox-eared herms");
	else outputText("Miko and Mai");
	outputText(" burst out, their big breasts covered in nothing but tiny pink pasties and an all-too-small thong sheathing their red pricks.  Arm in arm with tail wagging furiously, they cry out \"<i>Happy birthday, Hel!</i>\" before hopping out and slipping into the salamander's arms.  \"<i>Ladies,</i>\" Hel says, grinning like an idiot, a moment before she's pushed into a waiting chair behind her.  One of the girl's busts is quickly shoved into her face as the rest of the group laughs and starts passing out another round of drinks.");
	
	//{PC can play each short scene once}
	helPartyMenu();
}

private function heliaDrinks():void {
	clearOutput();
	//Drinks
	outputText("You saunter up to the bar, where the staff have laid out more than enough beers for the entire party.  Edryn and a handful of phoenixes are milling around, exchanging tips for swordsmanship: Edryn advocating charging in with a greatweapon swinging, as the phoenixes try and explain their shield-wall tactics.  You knock back a drink and listen in, watching with interest as the phoenix girls get progressively more and more flustered");
	//if PC is male:
	if (player.hasCock() && player.hasVagina()) outputText(" just as you do");
	outputText(" in the presence of the steadily mounting pheromone cloud around the lusty centauress.  Before you've finished your drink, all the half-harpies are sporting sizable tents in their britches and are subtly sniffing around, trying to figure out what's happening to them... just before Edryn grabs the lead phoenix by the arm and leads her off into one of the back rooms, shooting the others a wink and a flicking tail over her drooling horse-sex.  The others are quick to follow.");
	flags[kFLAGS.HELIA_BDAY_DRINKS] = 1;
	helPartyMenu();
}

//Hakon & Kiri
private function heliaHakonAndKiri():void {
	clearOutput();
	outputText("You meander over to the veteran salamander and his half-harpy daughter, and quickly find yourself surrounded by fluttering red feathers as Kiri practically jumps on you, hugging you.  \"<i>Hey, [name], long time no see,</i>\" she says, smiling demurely as she leads you back to where she and her father were standing, removed from the real bustle of the party.");
	
	outputText("\n\n\"<i>How're you holding up, " + player.mf("son","kid") + "?</i>\" Hakon says, clapping you on the shoulder and passing you another beer.  \"<i>Hel tells me you're quite a handful.  Treating my girl right, I hope?</i>\"");
	
	outputText("\n\nYou falter at that, not quite sure how to address your lover's father in that regard, but the old salamander just laughs and gives you another rough shoulder-clap.  \"<i>Just teasing, " + player.mf("boy","girl"));
	outputText(".  We salamanders are a bit more open about that sort of thing, though, if you haven't noticed.  Helia's regaled us with more than a few of her 'stories,' let me tell you. Isn't that right, sweetheart?</i>\"");
	
	outputText("\n\nKiri blushes, casting a bashful glance toward you and her sister in the heart of the bar. Poor thing. You ruffle her hair and step away.");
	flags[kFLAGS.HELIA_BDAY_HAKON_AND_KIRI] = 1;
	helPartyMenu();
}

//Phoenixes
private function heliaPhoenixes():void {
	clearOutput();
	outputText("You approach the small squad of phoenixes milling around the cake, mostly talking amongst themselves.  They nod as you approach, a bit wary of the person who recently kicked their asses inside out.  Still, they nod respectfully as you approach.");
	
	outputText("\n\n\"<i>Evening, [name],</i>\" their leader says, snapping you a crisp salute.  \"<i>Fine party we've got here.</i>\"");
	
	outputText("\n\nYou ask what they're doing here, exactly.  Last time you saw them, after all, they were the foot soldiers of a rapey queen.  The troops exchange a glance, \"<i>I'm surprised the town guard let us in, but Sergeant Edryn put in a word for us. Father - Hakon - invited us.  Said that, even with what happened in the Tower, there's no reason for us to be strangers.  BECAUSE of what happened, even.  With father free and mother ");
	if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0) outputText("dead");
	else outputText("deposed");
	outputText(", he thought it would be good to try and at least... know each other.  I'm not complaining.  Things like this party... never would have seen anything like this under Queen Calais.  It's nice to see new things, meet new people.</i>\"");
	
	outputText("\n\nYou see a few glances going toward Edryn and the fox twins");
	if (followerKiha() && isabellaFollower()) outputText(", then to the fiery dragoness and the ultra-busty cowgirl talking in the corner");
	outputText(", and you figure you know what they mean.");
	flags[kFLAGS.HELIA_BDAY_PHOENIXES] = 1;
	helPartyMenu();
}

//Hel & Fox Twins
private function heliaAndFoxTwins():void {
	clearOutput();
	outputText("You approach the foxy strippers, still well into giving Helia a dual lap-dance, their red puppy peckers poking well out of their tiny thongs.  They grin as you approach, and Hel pulls you into her lap, and you quickly find yourself with a pair of big, soft breasts to rest your head on, courtesy of ");
	if (flags[kFLAGS.HEL_FOXY_FOURSOME_WARNED] == 1) outputText("Mai");
	else outputText("one of the foxes");
	outputText(".  Hel plants a deep, serpent-tongue filled kiss on your lips, nuzzling her cheek on your [chest].");

	outputText("\n\n\"<i>Not bad for a surprise party, huh, [name]?</i>\"  Hel laughs, spreading her legs wide enough for the other twin to slip in, giving you a lusty grin as her hand rests on her crotch, rubbing lightly on her cock.");
	
	outputText("\n\nYou nod to your lover and sit back, resting your head in the pillowy valley of the fox-girl's cleavage.  Hel strokes your cheek, her tail reaching around to brush along your [butt].  \"<i>Not a bad party at all... Thanks for coming, lover mine.  Didn't expect my visit to turn out like this, but... I'm glad you came.  Wouldn't be a birthday without you, [name].  Nobody I'd rather spend it with.</i>\"");

	outputText("\n\nThe fox girls give a jealous huff, and Hel just grins and pulls them in close, a cheek pressed hard to each of her breasts.  \"<i>Don't worry, girls, I've got plenty of affection to go around.  Just say the word, [name], and we'll get out of here.  And if you wanna take the girls, well... who'd say no to that?</i>\"");
	//{Unlocks Leave & Leave w/ Girls options}
	flags[kFLAGS.HELIA_BDAY_FOX_TWINS] = 1;
	helPartyMenu();
}
//Leave {Or: Joke's on you, no (special) birthday sex!}
private function leaveWithoutSex():void {
	clearOutput();
	outputText("You decide you've had about enough of the party for now. You slip over to Hel and tell her you're ready to head out when she is.");
	
	outputText("\n\n\"<i>Alright, lover.  Not that I ever get tired of tits in my face, but... well, I think I know who I want to spend the rest of my evening with.</i>\"");
	
	outputText("\n\nShe stands and, turning toward the crowd, announces: \"<i>Thank you all so very, very much for coming out.  I can't even begin to tell you how much it means to me to see you all... I honestly didn't know anybody would come.  I hardly remembered myself.  I love you all, and thanks again.</i>\"");
	
	outputText("\n\nThere's a general murmur of approval as Hel picks up another beer, kicks it back, and then takes your hand. You follow your lover through the crowd, shaking hands and getting patted on the shoulder - and hearing more than a few immature catcalls from the increasingly drunk phoenixes and fox-girls.");

	outputText("\n\nWhen you get to the door, Hel holds you close, snuggling against you as you walk.  \"<i>Thanks for coming, [name].  I love you.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//Leave w/ Girls
private function leaveWithGirls():void {
	clearOutput();
	outputText("You decide you've had about enough of the party for now.  You slip over to Hel and tell her you're ready to head out when she is.");
	
	outputText("\n\n\"<i>Alright, lover.  Not that I ever get tired of tits in my face, but... well, I think I know who I want to spend the rest of my evening with... and with some bare tits and cocks in my face.  Can't ask for more in life!</i>\"");
	
	outputText("\n\nShe stands and, turning toward the crowd, announces: \"<i>Thank you all so very, very much for coming out.  I can't even begin to tell you how much it means to me to see you all... I honestly didn't know anybody would come.  I hardly remembered myself. I love you all, and thanks again.</i>\"");
	
	outputText("\n\nThere's a general murmur of approval as Hel picks up another beer, kicks it back, and then takes your hand.  The fox-girls giggle drunkenly as Hel practically hefts them off their feet and carries them upstairs to the great amusement of the party-goers.  A moment later and you're stumbling into a rented room above the Bitch, struggling out of your [armor] as a pair of tight panties suddenly fly your way, flopping onto your face as Hel practically hangs her chain bikini on your head.  Your give a primal growl at that and quickly push the girls down onto the bed, deciding what to do with them.  By the lusty looks and sensual caresses they're giving each other, they're up for just about anything.");
	if (player.gender == 3) {
		outputText("\n\n\"<i>So what parts do you want to use?</i>\" she asks, looking to your mixed endowments.", false);
		//(Display Options: [As Male] [As Female])
		simpleChoices("As Male", helScene.foxyFluffsFoursomeAsMale, "As Female", helScene.foxyFluffGirlsFuckSex, "", null, "", null, "", null);
	}
	else if (player.gender == 2) doNext(helScene.foxyFluffGirlsFuckSex);
	else doNext(helScene.foxyFluffsFoursomeAsMale);
}

private function helAndSluttyHarpy():void
{
	outputText(images.showImage("hel-follower-threesome-sophie"));
	if (!player.hasCock() && !player.hasVagina())
	{
		helAndSluttyHarpyGenderless();
		return;
	}
	else if (player.hasCock() && !player.hasVagina())
	{
		helAndSluttyHarpyMale();
		return;
	}
	else if (!player.hasCock() && player.hasVagina())
	{
		helAndSluttyHarpyFemale();
		return;
	}

	// Choice
	menu();
	addButton(0, "Cock", helAndSluttyHarpyMale);
	addButton(1, "Pussy", helAndSluttyHarpyFemale);
	addButton(14, "Back",  heliaThreesomes);
}

private function helAndSluttyHarpyMale():void
{
	clearOutput();

	outputText("You take Helia’s hand and lead her through the camp in an attempt to find someone to include in your threesome. After some searching you see Sophie sitting on a rock and get a wonderful idea. You ask Hel if she would be ok with a threesome with the busty harpy. Her smile turns to a serious frown for a moment.");

	outputText("\n\n<i>“She wouldn't be my first choice, but if you really want to...”</i> she says, fidgeting with her tail. You thank her profusely, and give her a quick kiss before going to get Sophie’s attention. Hel’s expression returns to a smile, not quite as big as before, but still happy. You manage to get the harpy's attention, and she beams like a ray of sunshine. She practically bounces over to you on the balls of her feet.");
		
	outputText("\n\n<i>“Hey, are you guys going to have sex? Can I have some too?”</i> Sophie asks with unbound enthusiasm. She makes sure to rub against your body as she asks, making full use of her massive breasts. You ask her if she’d like to join you and Helia in a threesome. Sophie looks over to the taller salamander girl and smiles seductively before walking toward a now cross looking Helia who seems to be rethinking the merits of this choice. ");

	outputText("\n\nSophie’s head barely lines up with Hel’s sizeable cleavage. The slutty harpy gives Hel the biggest hug she can, and then buries her face between Hel’s tits. Helia looks so flustered you can almost see a mushroom cloud of steam bubbling out of her head. She eventually calms down enough to talk, and directs a glare at Sophie. The oblivious bimbo grins up at her and grabs her around the legs, pulling them out from under her and making the taller girl fall onto her back.");

	outputText("\n\n<i>“Oww, you stupid bird, watch what you're do-mpph”</i> Helia growls, but is cut off at the end when Sophie sits directly on her face. You can hear your fiery lover trying to continue her complaints beneath the harpy's massive assflesh, but her voice is so muffled you can’t make out the words. Sophie crooks a finger to beckon you over, pulling aside the salamander’s bikini bottom. You move over to Hel, stripping out of your [armor] as you go, and kneel between her legs");

	outputText("\n\nYou slowly begin to inch your [cock] Into Helia’s love furnace. Her complaints turn into a drawn out moan as you slide inside of her, her body shivering slightly. The shudders nearly set your bimbo slut off, and you see rivulets of her juices flowing over Hel’s chin, down her neck, and pooling on the ground. You gingerly pull up her chainmail bikini and palm one of her breasts, circling it around the nipple as you plant a kiss on the other.");

	outputText("\n\n<i>“Ahhh, your mouth is, like, so good and warm,”</i> Sophie stammers, her massive breasts jiggling as she begins to thrust her hips across Helia’s face. You note that her efforts might be denying the salamander the ability to breathe. Sighing, you remove your hands from Helia’s hips and grab Sophie by the ankles. You pull her off the salamanders face, moving back far enough for your cock to");
	if (player.biggestCockLength() >= 8) outputText(" no longer be hilted inside");
	else outputText(" slip out of");
	outputText(" her sodden cunt, and hear Hel gasp for air. Before the birdslut can comment on the matter, you spin her around and push her down onto Helia, leaving them face to face.");

	outputText("\n\n<i>“Gah... stupid harpy,”</i> Helia says between breaths, but she makes no further action to remove her. You slip your [cock] back into Helia’s burning tunnel and begin thrusting slowly in and out. The transitions between her insides and the cool air make you feel like coming immediately, but the pleasurable moans that arise from your lover make the resistance worth it. ");

	outputText("\n\nSophie silences Hel’s moans by giving her a big sloppy kiss, sliding her tongue into the salamander's mouth. Helia’s eyes widen in surprise at first, but as you continue to pound her they droop back down and she returns Sophie’s kiss. ");

	// 1 cock
	if (player.cocks.length == 1)
	{
		outputText("\n\nYour bimbo’s pussy is beginning to look awfully neglected, and you can’t have that. On the next rock of your hips you pull out of Hel with a pop and transition your [cock] to Sophie’s sopping box.");

		outputText("\n\n<i>“H-hey, don’t leave me hanging like that!”</i> Helia yells as Sophie breaks the kiss to scream in orgasm from the sudden penetration. The bimbo harpie’s cunt feels shockingly cool compared to Hel’s, and allows you to get a better hold on yourself despite the extreme tightness. After a few thrusts you pull out and transition to Hel again, trading between the two every few seconds. Eventually you just slide your [cock] between the two pleasure-drunk girl’s pussies, rubbing into the sopping wet cleft between the two girls combined cunts..");

		outputText("\n\nThe combination of both hot and cool rubbing is too much to handle, and soon causes the pressure in your");
		if (player.balls > 0) outputText(" [balls]");
		else outputText(" groin");
		outputText(" to boil over. White jissom blasts from your [cock], coating Helia and Sophie’s stomachs, as well as the underside of the pair’s tits.");
		if (player.vaginas.length > 0) outputText(" Your unused [vagina] cums with your cock in a show of sympathetic orgasm, coating your thighs with femcum.");
	}
	// 2-3 cocks
	else if (player.cocks.length <= 3)
	{
		outputText("\n\nYou notice that your bimbo’s pussy is looking neglected, dripping warm fluids as she rubs it against your stomach. As you continue to rock your hips you line up your [cock biggest2] with Sophie’s wet snatch and slide it home. You hilt inside both of the lust crazed girls. The heat is tremendous. While you’re aware that Sophie’s insides are less heated than Helia’s the notion is almost lost on you. ");

		outputText("\n\nYou piston a few more times, trying to hold back as long as possible. Your resistance is short lived, and you find yourself on the very edge in under a minute. You make one final thrust into the two girl’s depths and release a torrent of seed. Both girls are pumped");
		if (player.cumQ() < 500) outputText(" with your cum");
		else
		{
			outputText(" full of cum");
		 	if (player.cumQ() <= 1000)
		 	{
		 		outputText(" until it overflows");
		 		if (player.cumQ() >= 5000) outputText(", pooling around your knees");
		 	}
		}
		outputText(".");
		if (player.cocks.length == 3) outputText(" Your unused cock splatters the two with hot, white jizz.");
		if (player.vaginas.length > 0) outputText(" Your unused [vagina] cums with your cocks in a show of sympathetic orgasm, coating your thighs with femcum.");
	}
	// > 4 cocks
	else
	{
		outputText("\n\nYou realize that there's a lot of holes on offer between the two sluts; luckily you have just the right thing to solve the problem, cocks! You unleash [eachCock] upon the three holes that are still open. One [cock biggest2] snakes under the one currently pounding into Helia and slips inside her");
		if (flags[kFLAGS.HELIA_ANAL_TRAINING] == 0) outputText(" tight");
		else if (flags[kFLAGS.HELIA_ANAL_TRAINING] == 1) outputText(" well-trained");
		else if (flags[kFLAGS.HELIA_ANAL_TRAINING] >= 2) outputText(" gaped");
		outputText(" asshole. She gasps at the sudden double penetration, and you reciprocate because of the furnace-like heat of both her holes. Your [cock biggest3] lines up with Sophie’s slutty pussy and drives home while your [cock smallest] does the same to her ass."); // Haha look at me being a lazy shit.

		outputText("\n\nIt takes all of your might to hold out against the need to blast your seed inside all four holes. You try and last as long as you can against the inexorable tide of jizz welling up in your");
		if (player.balls > 0) outputText(" [balls]");
		else outputText(" groin");
		outputText(". The two girls seem to share your problem, their teeth clenched and clinging tightly to each other trying to resist. Seeing their clearly shared pleasure in the moment puts you over the edge, and you let loose the torrent of liquid lust from [eachCock]. Sophie cums as the tsunami of jizz floods her levies, the copious amount spilling back out of her holes and pooling around your knees.");
		if (player.cocks.length > 4) outputText(" Your extra cocks spray pearly cum all over the nearby ground.");
		if (player.vaginas.length > 0) outputText(" Your unused [vagina] cums with your cocks in sympathetic orgasm, coating your thighs with femcum.");
	}
	// Merge

	outputText("\n\nHel grasps handfuls of Sophie’s feathers as her body locks in orgasm. Sophie lies insensate against the taller girl's neck, tongue hanging out and drooling onto her skin. You lean over the senseless bimbo, giving Hel a long apology kiss.");

	outputText("\n\n<i>“Don’t think I’ll just do this whenever you want”</i> She says when the kiss is broken, but she’s smiling as she says it, so you smile back and retrieve your armor. Sophie has fallen asleep on top of Helia, who seems to also have resigned to take a nap.");

	player.orgasm();
	menu();
	doNext(camp.returnToCampUseOneHour);
}

private function helAndSluttyHarpyFemale():void
{
	clearOutput();

	outputText("You grasp Helia’s hand and pull her to another part of your camp. On the way you try to think of someone to include in your threesome. You pause for a moment of serious thought and decide you want a threesome with her and Sophie.  You Inform her of your thoughts, and her smile flattens to a serious look.");

	outputText("\n\n<i>“She wouldn't be my first choice, but I suppose we can,”</i> she says, shifting a little uncomfortably in place. You take her in your arms, giving her a big kiss before tugging her off to find Sophie. Her smile returns, albeit slightly smaller, and she lets herself be led.");

	outputText("\n\nAfter a little searching you find the harpy absent-mindedly preening her platinum blonde feathers. When she notices you she lets out a small cry of joy, plopping off her rock to saunter your way, her massive tits and ass jiggling invitingly with each step. You can see streams of juices trickling from her always ready twat, slicked down the inside of her thick thighs.");
		
	outputText("\n\n<i>“Mm, is there something you wanted babe?”</i> the lusty harpy asks as she squishes her chest against your [chest]. She reaches around, and draws soft circles around your shoulder blades with one of her fingers. Your lust rises at her touch, and you inform her that there most certainly is something you want.");

	outputText("\n\nYou turn to Hel and ask her to lie on the ground. When she is spread at your feet you lightly sit yourself down just below her neck and gingerly pull up her chainmail bikini, tracing your fingers around her hardening nipples. This elicits a small cry of pleasure from the salamander, and you smile over your shoulder at her. Each circle you make causes her to jump slightly as if the tips of your fingers were electrified.");

	outputText("\n\nYou return your attention to Sophie and pull her face near to yours. You whisper in her ear that Helia would really like to see how good she is with her tongue, and there might be a reward in it for her. The feathery bimbo smiles wide and gives you a knowing wink. The fiery girl squirms uncomfortably as you remain seated on her chest.");

	outputText("\n\n<i>“H-hey, what are you two talking about? What are you do-ahhhh!”</i> she says as Sophie crawls over to her. Her second sentence is cut off as the blonde harpy slides onto her stomach and plants a sloppy gold coated kiss onto her slick twat. Hel moans despite herself, and before she can voice any more complaints you move your pussy back over her mouth.");

	outputText("\n\n<i>“Mmmm, her pussy is, like, fiery hot. I love it!”</i> Sophie exclaims before burying her face into the salamander girl’s cunt with all the fervor she can muster. Hel grasps your [hips] in what might have been an attempt to throw you off. Instead a shiver runs through her body causing her to pull your netherlips tighter to her face.");

	outputText("\n\nFinally Hel gives in and starts rubbing her tongue around your vulva. You sigh in sweet bliss as it moves. Her breath feels like it would keep you warm in the middle of a blizzard. You lean to one side and see Sophie lovingly mopping up Helia’s juices with her tongue. Her eyes are glazed over and her licks are slow and long, making sure to get as much as she can with each brushing motion.");

	outputText("\n\nYou look over your shoulder to see Helia in a similar state, her eyelids drooping happily as she moans into you, her tongue caressing your sex with short licks. Sophie’s giant ass and pussy lie before you, glistening with sweat and sexual fluids. You did mention a possible reward for her, and judging by Helia’s state she deserves it.");

	outputText("\n\nYou hoist the bimbo harpy's massive ass up closer to your face and slide your tongue down her moist vulva, settling on her puffy clit at the end and slathering it with your mouth's liquid affection. Her sweet juices dribble over your chin and slide down your [chest] and stomach. Your front half is completely drenched in harpy juices, but you don’t care. Helia’s ministrations are beginning to get to you.");

	outputText("\n\n<i>“Ooooh yeahh, thats like, perfect [name], keep licking mama Sophie like that”</i> Sophie coos between moans, as if you needed to be told. Helia seems to notice that you’re getting more into it, and ups her game. You moan loudly as Helia’s long tongue slips deeper into your cunt, licking your walls as it goes. Her mouth sucks on your hole and her bottom lip brushes against your [clit].");

	outputText("\n\nYou bury your face deeper into Sophie to muffle your moans. Her plush pillowy asscheeks beg to be squeezed, and you happily oblige. Your tongue glides up and into Sophie’s sopping wet box. You lick inside her hole and around its spacious walls. As your tongue reaches as far as it can into her pussy you let your fingers tease at her asshole; its hot depths are tighter than her cunt, but still easily yield to your efforts.");

	outputText("\n\nHelia’s tongue has extended to its full length, and is busy swirling around your cervix. It teases at the entrance, causing shivers to radiate through your body. Remembering the fiery salamander beneath you, you reach an arm under Sophie and squeeze one of Hel’s E cup breasts. You circle your palm over her nipple and tweak it, eliciting gasps of pleasure and moans that vibrate through her long tongue. ");

	outputText("\n\nSuddenly Sophie lets out a squeal of pleasure, and her thighs clench tightly around your head. Her body locks up in a massive orgasm and her femspunk splatters over your face, dripping down onto Helia’s tits. As she recovers from her orgasm she gently falls on to the salamander girl’s stomach, mindlessly suckling at her clit.");

	outputText("\n\nThe feeling proves too much for Helia, and she presses her face into your pussy, trying to push her tongue harder against your sensitive insides. Her legs splay out on the ground as she shudders in orgasmic bliss. Her juices blast Sophie’s face and her own thighs. Her breathing gets even faster as she recovers, blasting your nethers with more hot air.");

	outputText("\n\nSeeing your fiery lover orgasm makes you realize how close your own explosion of pleasure is. You try to hold out as long as possible to feel her wonderfully hot tongue playing across your deepest, most intimate parts. As much as you would want for it to last forever your body can’t take any more of the pleasurable barrage. You cum hard, drenching Helia’s face with freshly heated love juice.");

	// has cock
	if (player.cocks.length == 1)
	{
		outputText("\n\nYour unused cock spurts streams of jizz all over the sandwiched girl’s stomachs. ");
	}
	else if (player.cocks.length > 1)
	{
		outputText("\n\nYour unused cocks spurt streams of jizz all over the sandwiched girl’s stomachs. ")
	}
	if (player.cocks.length >= 1)
	{
	outputText("The blasts spatter against the underside of Sophie’s gigantic melons and slide off Hel’s sides like an overfull cream pastry.");
	}

	// Continue

	outputText("\n\nYou slide off of the two insensate girls, using what strength you have left to retrieve your armor. You give Hel a kiss that she returns to the best of her ability, and ruffle Sophie’s head feathers. In a surprising move Helia swirls Sophie around and plants a big kiss on her lips.");

	outputText("\n\n<i>“But don't think this means I want to do it again,”</i> she says before shakily sauntering off to find somewhere to collapse. Sophie simply giggles and curls up to sleep in the puddle of juices the three of you made. You massage your aching muscles and get back to your champion duties.");

	player.orgasm();
	menu();
	doNext(camp.returnToCampUseOneHour);
}

private function helAndSluttyHarpyGenderless():void
{
	clearOutput();

outputText("You walk up to Helia and ask if she would be up for fucking you with that wondrous tail of hers. She smiles slyly and wraps her arms around you. You take her response as an unspoken yes, hugging her back and pulling her off to find a better place for your loving.");

outputText("\n\n“I’m up for anything with you, lover mine,” Helia responds with a seductive grin. As you move through the camp a massive weight hits you in the side and tackles you to the ground. You see a flash of platinum blond and realize that it’s Sophie who had given you a surprise hug. The harpy begins to shower you with kisses as Helia blushes as red as her hair. She lifts the smaller harpy girl off of you and sets her back on her feet.");

outputText("\n\n<i>“Go away, stupid harpy! I’m going to have some fun alone with [name].”</i>");

outputText("\n\n<i>“Ummm, I’m sure [he] wouldn’t mind if we, like, shared [him] for some fun,”</i> Sophie retorts to Helia’s growl. Before this can get out of hand you grab both of them by the waist and pull them down to sit on either side of you. Helia makes a surprised yelp and Sophie rubs her sizeable hips to comfort them. You look at the both of them and smile wide.");

outputText("\n\n<i>“Now kiss. I don’t want any of this silly fighting over me;”</i> you say in your most commanding voice. They both look like they’re about to start talking, but as soon as they open their mouths you pull their heads together into a forced kiss. Helia tries to fight it, but Sophie gives in almost immediately, giving the salamander girl the biggest kiss she can. She wraps her arms around the taller girl’s shoulders to pull herself up and try to suck Helia’s long tongue into her mouth. ");

outputText("\n\nShe seems to be having moderate success as Helia moans in complaint at her tongue being pulled out of her mouth; Hel’s mouth, nose, and chin  end up coated with golden lipstick from the harpies puffy lips in the process. After trying to pull away for a few moments Helia seems to give in and return the kiss. ");

outputText("\n\nHer body doesn’t know how to react to the sunshine-stained chemicals coursing through her veins, but it seems to have defaulted to good feelings. You wrap your arms around both girls and reach down between their legs. They moan into each others mouths as you begin rubbing their sexes with fervor. Sophie’s eyes glaze over as your rubbing brings her to orgasm. Her mouth hangs open, and Helia takes the opportunity to swirl her tongue around the harpies. ");

outputText("\n\nYour hand slides across Sophie’s stomach to squeeze one of her massive mammaries. The busty harpy responds by doing the same to Hel, squeezing one of her sizeable tits. You double your efforts on Helia and she practically melts despite her natural body heat. The steamy salamander crumples, falling to the side and pulling Sophie with her. You lean over and kiss both girls on the forehead before leaving them to rest, and hopefully feel more open about each other.");

	player.orgasm();
	menu();
	doNext(camp.returnToCampUseOneHour);
}
	}
}
