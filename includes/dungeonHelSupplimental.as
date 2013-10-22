//Project Introduction:
//New Values:
//-HelAffection -- A score measuring Hel's general fondness for the Player Character, measured on a scale of 0 - 100, with \"<i>0</i>\" being immediately after achieving \"<i>Fuckbuddy</i>\" status. Increases by 5 each time you fuck (not Corrupt!Rape) Hel, and 10 each time you engage in one of her threesomes. When HelAffection equals 70 points, the number freezes and Expansion 2 content triggers.
// HEL_AFFECTION_FOLLOWER:int = 478;
// HEL_FOLLOWER_LEVEL:int = 479;
// TOOK_GOO_ARMOR:int = 480;
// LOST_GOO_ARMOR_FIGHT:int = 481;
// WON_GOO_ARMOR_FIGHT:int = 482;
// HEL_REDUCED_ENCOUNTER_RATE:int = 483;
// MET_VALERIA:int = 484;
// HEL_HARPIES_DEFEATED:int = 485;
// HEL_DUNGEON_MEAD_LOOTED:int = 486;
// HEL_BRIGID_DEFEATED:int = 487;
// HEL_PC_TALKED_WITH_HAKON:int = 488;
// HEL_DUNGEON_TAKEN_WHIP:int = 489;
// HEL_DUNGEON_TAKEN_STRAPS:int = 490;
// HEL_DUNGEON_TAKEN_DAGGER:int = 491;
// HEL_PHOENIXES_DEFEATED:int = 492;
// HEL_HARPY_QUEEN_DEFEATED:int = 493;
// HARPY_QUEEN_EXECUTED:int = 494;
// HEL_KNOWS_ABOUT_HAKON:int = 495;
// FOUGHT_WITH_HEL_IN_DUNGEON:int = 496;
// TOOK_QUEEN_STAFF:int = 497;
// VALARIA_AT_CAMP:int = 498;



function followerHel():Boolean {
	if(flags[HEL_FOLLOWER_LEVEL] == 2) return true;
	//This is a temporary fix
	if(flags[HEL_HARPY_QUEEN_DEFEATED] == 1) return false;
	if(flags[HEL_FOLLOWER_LEVEL] > 0) return true;
	return false;
}

function fuckBuddyHel():Boolean {
	return (flags[HEL_FUCKBUDDY] == 1);
}

//Introduction Scene -- Helia's Discovery
//Requirements: 
//-PC has achieved \"<i>Fuckbuddy</i>\" status with Helia.
//-HelAffection >= 70
function heliaDiscovery():void {
	//clearOutput();
	//(Scene proc's the first time all requirements are met and the player chooses [Sleep] at camp.)
	outputText("Before bedding down for the night, you make one last check of your camp's perimeter, making sure all your traps and defenses are still in place and primed in the event of a surprise nighttime assault.  As you come to the outermost parts of your makeshift camp, you notice a cloaked stranger approaching out of the evening darkness.  You're about to ready your [weapon], but you recognize the shapely figure of Hel the salamander walking towards you, hips a-sway underneath her loose traveling cloak.");

	//(If Hel has never been to camp before (ie, no Isabella threesome at camp)
	if(flags[HEL_ISABELLA_THREESOME_ENABLED] == 0) {
		outputText("\n\n\"<i>[name]!</i>\" the salamander shouts, waving emphatically as she approaches.  \"<i>Shit, do you have any idea how hard you are to track down? I've been looking for you everywhere!</i>\"  You ");
		//[(pussy)
		if(player.cor < 50) outputText("quickly rush over and stop Hel before she loses a leg to one of your traps");
		//(dick)
		else outputText("lazily point out your traps to the not-quite-intruder");
		outputText(", and guide her over to the camp proper.");
	}
	//(Else)
	else {
		outputText("\n\n\"<i>Hey there, [name]!</i>\" the salamander calls, handily picking her way through your maze of traps. She gives you a quick embrace and, taking your hand in hers, leads you back to the camp proper.");
	}
	//(Resume All)
	outputText("\n\nYou sit the salamander down near your campfire and ask her what brought her all the way from the plains to your humble abode.  She shrugs lightly and says, \"<i>Maybe I just wanted some company tonight.</i>\"");
	//[If not Centaur: 
	if(!player.isTaur()) outputText("  Her hand slides over to rest on your thigh.");
	else outputText("  \"<i>She gives your flank a slow, affectionate stroke.</i>\"");
	outputText("  You ask her if that's true. With a little wink, she answers, \"<i>Well, it's not entirely untrue...</i>\"");

	outputText("\n\n\"<i>Actually, champ, I wanted to... um, well...  ask a favor, I guess.</i>\"  Hel says awkwardly, suddenly avoiding eye contact.  \"<i>I wouldn't ask if it wasn't important, or something I could do on my own, or...  Ah, shit.</i>\"  From inside her cloak, Hel produces a dirty, dented flask and takes a long swig of what smells like pure grain alcohol.  While she drinks, you urge her to tell you what's on her mind.");

	outputText("\n\nShe belches thunderously, shakes it off, and sighs. \"<i>It's like this, Champ: a little birdie told me that there's this tremendous roost of harpies up in the high mountains, dozens of the bitches all packed together. That's bad enough, right? But now, some of them have been showing up with red scales all over their arms and legs... and fire on their tails.</i>\"");

	outputText("\n\nYou ask her why that's piqued her interest so much; she lives some ways away from the mountains after all.");

	outputText("\n\n\"<i>Normally I wouldn't give two shits about what a bunch of feather-bitches are doing. But scales and fire?  Sound like someone you know?</i>\"  Before you can answer, you feel Hel's warm tail curl around your shoulders, hugging you right up against her.  She takes another long swig from her flask.  It's starting to smell like someone lit a brewery on fire next to you.  \"<i>What I'm saying is that there's a chance that there's a poor, abused salamander tied up in this roost of theirs, being used as breeding stock for years and years now, fathering a whole new generation of harpies.  Even if you don't give a shit about the birds, it would... mean a lot to me if you'd help me break him out.  Look, [name], I'm a mean bitch in a fight - you know that - but even I can't take on a whole roost of harpies solo.  And, well, you're the only person I trust one-hundred percent.  To have my back, you know?</i>\"");

	outputText("\n\nYou spend the next few minutes getting the rest of her information out in the open - they live in an old abandoned watchtower, she says, and number perhaps two dozen.  As she talks, you note a desperate tone in Hel's voice, and more than once she repeats that she can't do it by herself, or trust anyone but you to help.");

	outputText("\n\nDo you agree to help Helia?  She'd probably be <b>very</b> grateful...");
	//(Display Options: [Yes] [No])
	doYesNo(agreeToHelpHeliaDungeon,noDungeon);
}

//Intro Scene -- No
function noDungeon():void {
	clearOutput();
	outputText("You consider for a few moments, but ultimately decide that this is a venture you'd rather not participate in.");
	outputText("\n\n\"<i>W-What? Why not?</i>\" Hel stammers, suddenly glowering at you.");
	outputText("\n\nYou try to explain your reasons, but it seems Hel isn't having any of it.");
	outputText("\n\n\"<i>Well fuck you anyway!</i>\" she shouts, jumping to her feet and waving her scaly arms emphatically, nearly clawing your face off with her sharp talons.  \"<i>I don't need you or your bullshit excuses! I'll just go do it my own goddamn self--see if I don't!</i>\"");
	outputText("\n\nBefore you can even try to calm her down, Hel is running away from the camp and back into the night from whence she came.");
	outputText("\n\nWell then.");
	//(In-Game effect: Reduce Hel's encounter rate, end fuckbuddy mode. Will fight player in plains.)
	flags[HEL_REDUCED_ENCOUNTER_RATE] = 1;
	flags[HEL_FUCKBUDDY] = 0;
	flags[HEL_AFFECTION] = 0;
	helAffection(-70);
	doNext(1);
}

//Intro Scene -- Yes
function agreeToHelpHeliaDungeon():void {
	clearOutput();
	outputText("You mull the salamander's proposition over and eventually agree to assist her.  Not only will you be stopping a new race of monsters from spawning into the mountains, but you'll be getting into the lovely Helia's good graces - a win-win if ever there was one.");
	outputText("\n\nHel breaks out into a great big smile and leaps at you, pulling you into a hug and squeezing until you damn near choke.  You return her tight embrace, and are eventually rewarded by Hel relaxing in your arms");
	//[if has lap: 
	if(!player.isTaur()) outputText(" and cuddling up in your lap");
	outputText(".  She nuzzles your neck and whispers, \"<i>Thanks, Champ. It means a lot to know I can count on you to... watch my back.</i>\"");
	outputText("\n\nYou run a hand through Hel's hair and tell her that you've got her back no matter what.  You give her muscular ass a playful little grope; and she immediately wraps her tail around you, pinning your arms to your chest.  Doesn't look like you're going anywhere now.  With a little smirk, the salamander whispers, \"<i>Let's stay like this 'till morning - what do you say?</i>\"");
	outputText("\n\nResigned to your fate, you curl up with Helia; who throws her cloak over the two of you.");
	
	//[If Marble is in camp:]
	if(player.hasStatusAffect("Camp Marble") >= 0 && silly()) {
		outputText("\n\nJust as you and Hel start to get intimate, you hear a familiar clopping of hooves. You poke your head out of the blanket, rather alarmed to see Marble standing over you.");
		outputText("\n\n\"<i>S-Sweetie?</i>\" Marble says, aghast at Hel's presence in your arms.  \"<i>What... just what do you think you're doing!?</i>\"");
		outputText("\n\nThis could be ba--");
		outputText("\n\n\"<i>Back off, cow-slut!</i>\" Hel growls, baring her talons at the bovine girl. \"<i>[name]'s mine tonight. GOT IT!?</i>\"");
		//(IF SILLYMODE:)
		if(silly()) outputText("\n\nMarble stammers and starts, struggling to find a rebuke against the salamander.  Before she can, though, Hel leaps to her feet and rushes her!  You don't even have a chance to intervene before Marble goes flying with a kick right to her cow-cunt, sending her hurtling toward the swamp.  As Hel settles back into your arms, you're almost certain you hear a rather draconic scream of rage in the distance.");
	}
	//PROC NEXT FUNCTION AT 6AM.  OVERRIDES OTHER SHIIIIITE
	flags[HEL_FOLLOWER_LEVEL] = -1;
	
	doNext(1);
	//(Decrease Player Lust to minimum, increase HP to maximum, etc. etc. You're sleeping, but also fucking. Figure it out.)
	stats(0,0,0,0,0,0,-100,0);
}
	
function morningAfterHeliaDungeonAgreements():void {
	outputText("\nWhen your eyes flicker open at the crack of dawn, you're pleased to see Helia is lying on your chest, ");
	//[If PC has >C Cups, \"<i>
	if(player.biggestTitSize() > 3) outputText("her head nestled between your soft tits and ");
	outputText("snoring boorishly.  The air around you smells like hot booze and sex, yet you awaken feeling as spirited and lively as you ever have.  You give Hel a little shake, waking her.");

	outputText("\n\n\"<i>Huh, wha?</i>\" she groans, rubbing her head.  \"<i>Oh, hey there, lover mine,</i>\" she adds after a moment, giving you a long kiss on the lips.  The two of you untangle yourselves, giving each other the occasional tease and playful slap on the ass, flirting shamelessly as you dress and ready yourselves for the coming day.");
	outputText("\n\nWhen you're dressed and organized, Hel asks, \"<i>So, what's the plan, [name]?</i>\"");

	outputText("\n\nYou tell the salamander you just need to get your affairs in order and you're off to the harpies' nest. She nods, reminding you that each moment you spend waiting around is another moment that poor man suffers.  You tell her you'll be quick, and set about preparing.");
	//(Display: 
	outputText("\n\n(<b>Helia can now be found under the Lovers tab! (For Now!)</b>)");
	flags[HEL_FOLLOWER_LEVEL] = 1;
	doNext(1);
}


//Introduction -- Not Yet.
function notYet():void {
	clearOutput();
	outputText("You tell Hel you were only checking on her, and that you've still got some things to do.  She sighs and quietly asks you to hurry.");
	doNext(1);
}
//Introduction -- Dungeon
function goToHeliaDungeon():void {
	clearOutput();
	outputText("You tell Helia that yeah, you're as ready as you'll ever be.  She beams and grabs you in a tight hug.  \"<i>Thanks again, [name].  You're a real goddamn champion, you know that?</i>\"  You laugh it off, but the salamander gives you a sultry wink and starts off toward the mountains.  You're quick to follow her.");
	//(NEXT)
	doNext(goToHeliaDungeon2);
}
function goToHeliaDungeon2():void {
	clearOutput();
	outputText("Within the hour, you and Helia are hiking up the narrow ledges and crevices of the high mountains, slowly but steadily climbing toward a snow-capped peak.  Hel certainly seems to know where she's going - she blazes a certain and steady trail, as if she knew every path and shortcut up the mountain.  By the time you near the peak, you're convinced she's been up here before - many times, even.");
	outputText("\n\nEventually, you see the crest of a squat, thick stone tower on the mountainside.  Hel easily guides you toward it, giving you a helping hand over an unusually wide gorge that would have kept most stray minotaurs well away from the solitary spire.  As you scramble onto the tower's plateau, Hel grabs your shoulders and pins you to the ground - just in time to avoid the gaze of a low-flying harpy.");
	outputText("\n\n\"<i>Quiet,</i>\" she hisses, lying atop you so that you can't jump up and expose your position.  \"<i>We can't take them all at once out in the open... This is going to be a sneaking mission, got it?</i>\"");
	outputText("\n\nYou quietly nod, and the two of you begin making your way toward the tower, hopping from one rocky outcropping to the next to avoid the harpies' sights.  Eventually, you come to the base of the looming structure.  Now sheltered in its shadow, you can clearly see the bird-women in great numbers, flying through the air to and fro.");
	outputText("\n\nNow safe from the watchful eyes of flying harpies and their sentries, Hel whispers, \"<i>Okay, so here's the plan.  I'm going to climb up the tower and hit them from the top; you go in through the main gates here,</i>\" she says, pointing to a rotting wooden door that seems to have been in disuse for a decade.  \"<i>Divide and conquer, right?  There are three floors, so... meet in the second, as soon as we can.  Yeah?</i>\"");
	outputText("\n\nYou nod again, and give Helia a little boost as she starts to scale the high walls of the aging tower.  You, however, steel yourself and make your way through an opening in the main gates."); 
	//(NEXT)
	dungeonLoc = 17
	inDungeon = true;
	doNext(1);
}


//[Armor]:
function takeGooArmor():void {
	clearOutput();
	outputText("You approach the armor rack.  A suit of heavy plated armor sits upon it, overlaying a flexible chain vest.  Contrasting against the rotting room, the armor seems to be in pristine condition, even shining.  Perhaps someone uses this heavy equipment - but surely not a harpy? You suppose you could take it.");
	//(Display Options: [Take Armor] [Back])
	simpleChoices("Take Armor",11093,"",0,"",0,"",0,"Back",1);
	//(Back takes you back to Room 1 menu)
}

//[Armor] -> [Take]:
function takeGooArmor4Realz():void {
	clearOutput();
	spriteSelect(79);
	outputText("You reach out to grab the armor, but as soon as your finger brushes the shiny surface, a human-like face appears in the helm!  You recoil as a daintily feminine and bright blue face takes shape out of nowhere, staring at you with eyes afire with rage.  More of the gooey substance that makes up the girl's face fills out the armor, yanking it off the racks on feet made of goop.");
	outputText("\n\nQuietly, the armored goo-girl growls, \"<i>You dare to disturb my rest, mortal? Prepare yourself for my vengeance!</i>\"");
	outputText("\n\nWhat the fuck!? Oh well, looks like she wants a fight!");
	startCombat(47);
	doNext(1);
}

function gooArmorAI():void {
	spriteSelect(79);
	if(rand(2) == 0 && player.hasStatusAffect("GooArmorSilence") < 0) gooSilenceAttack();
	else if(rand(3) > 0) gooArmorAttackPhysical();
	else gooArmorAttackTwoGooConsume();
}
//ATTACK ONE: Greatsword
function gooArmorAttackPhysical():void {
	if(combatMiss()) {
		outputText("The goo-armor rushes forward and swings her sword in a mighty arc, but you dodge it!");		
	}
	else if(combatEvade()) {
		outputText("The goo-armor rushes forward and swings her sword in a mighty arc, but you evade the attack!");
	}
	else if(combatFlexibility()) {
		outputText("The goo-armor swings a greatsword at you in a mighty arc, but your cat-like flexibility makes it easy to twist out of the way.");		
	}
	else if(combatMisdirect()) {
		outputText("The goo-armor swings a sword at you in a mighty arc, but your training with Raphael allows you to misdirect her into a miss!");	
	}
	//HIT!
	else {
		outputText("The goo-armor rushes forward and swings her sword in a mighty arc.  You aren't quite quick enough to dodge her blow, and the goopy sword slams into you, throwing you back and leaving a nasty welt.");
		var damage:Number = Math.round((monster.str + monster.weaponAttack) - rand(player.tou) - player.armorDef);
		if(damage <= 0) damage = 1;
		damage = takeDamage(damage);
		outputText(" (" + damage + ")");
	}
	combatRoundOver();
}
//ATTACK TWO: Goo Consume
function gooArmorAttackTwoGooConsume():void {
	outputText("Suddenly, the goo-girl leaks half-way out of her heavy armor and lunges at you.  You attempt to dodge her attack, but she doesn't try and hit you - instead, she wraps around you, pinning your arms to your chest.  More and more goo latches onto you - you'll have to fight to get out of this.");
	player.createStatusAffect("GooArmorBind",0,0,0,0);
	combatRoundOver();
}
//(Struggle)
function struggleAtGooBind():void {
	clearOutput();
	//If fail:
	if(rand(10) > 0 && player.str/5 + rand(20) < 23) {
		outputText("You try and get out of the goo's grasp, but every bit of goop you pull off you seems to be replaced by twice as much!");
		//(If fail 5 times, go to defeat scene)
		player.addStatusValue("GooArmorBind",1,1);
		if(player.statusAffectv1("GooArmorBind") >= 5) {
			if(monster.hasStatusAffect("spar") >= 0) pcWinsValeriaSparDefeat();
			else gooArmorBeatsUpPC();
			return;
		}
	}
	//If succeed: 
	else {
		outputText("You finally pull the goop off of you and dive out of her reach before the goo-girl can re-attach herself to you.  Pouting, she refills her suit of armor and reassumes her fighting stance.");
		player.removeStatusAffect("GooArmorBind");
	}
	combatRoundOver();
}
//ATTACK THREE: Goo Silence
function gooSilenceAttack():void {
	outputText("The goo pulls a hand off her greatsword and shoots her left wrist out towards you.  You recoil as a bit of goop slaps onto your mouth, preventing you from speaking - looks like you're silenced until you can pull it off!");
	//(No spells until PC passes a moderate STR check or burns it away)
	player.createStatusAffect("GooArmorSilence",0,0,0,0);
	combatRoundOver();
}

//Goo Armor -- PC Defeated (PC has Gender)
function gooArmorBeatsUpPC():void {
	spriteSelect(79);
	outputText("\n\nYou collapse, unable to resist the goo-armor's onslaught.  Laughing, she slithers out from underneath her armor, completely encasing you before you can do anything more than scream.  Laughing maniacally, the goo looms over you, hands on her hips.  \"<i>Tsk, tsk, tsk.  Not so eager to steal my armor now, are you?  Well... what am I to do with you, hmm?</i>\"  You struggle, but wrapped snugly in her goo, you can do little more than wiggle your hips and chest, accidentally moving yourself seductively.");
	outputText("\n\nAs you realize your mistake, a little smile spreads on her face.  \"<i>Ah, I know... I haven't had my precious fluids in so very long...</i>\"");
	//(PC has Vagina)
	if(player.hasVagina()) {
		outputText("\n\nShe begins to use her goo to peel back your [armor], soon revealing your defenseless [vagina], and makes a show of licking her lips as tendrils of goo seep into your cunt, filling you utterly.  You writhe and struggle against your gooey bonds, but your efforts are futile.  The goo-girl inside the armor only shakes her head at you, and withdraws herself from your [vagina].");
		outputText("\n\nYou have only a moment to figure out what's coming before her goo -- now perfectly shaped like the inside of your cunt -- slams back into you like a stiff cock. You can't help yourself as a moan escapes your lips, barely audible through the goop covering your mouth."); 
		outputText("\n\n\"<i>Oh, you like that do you?</i>\" the armor-goo asks, smiling evilly.  \"<i>Well, maybe this can be mutually... beneficial.</i>\"  Still grinning, she begins to hammer her cock-like appendage into your pussy, fucking you fast and hard with her goo-dildo.");
		cuntChange(25,true,true,false);
		//[If PC has breasts > A-cups: 
		if(player.biggestTitSize() > 1) {
			outputText("  As she hammers your cunny, bits of her goo swirl around your [chest], squeezing and massaging your tits.  You squirm as she roughly teases your boobs, pinching at your nipples and squeezing your tender flesh roughly.");
			//[if PC is lactating: \"<i>
			if(player.lactationQ() > 0) outputText("  To her delight, a spray of warm milk jets out of your sore nipples, milky white mixing into blue goo like oil in water. \"<i>Mmm, tasty!</i>\" she teases, massaging more and more from you.</i>\"");
		}
		outputText("\n\nShe continues to pound your cunt mercilessly, her grin spreading to inhuman width as your juices begin to flow around and into her gooey penetration.  She soaks your fem-lube up greedily, enjoying the meal, but her fucking is relentless until you feel orgasm approaching.  \"<i>Aw, ");
		//[if height is less than 6': 
		if(player.tallness < 70) outputText("little");
		else outputText("big");
		outputText(" girl ready to cum?  Well, go on then. Feed me!</i>\"");

		outputText("\n\nYou erupt, femspunk gushing out of your [vagina] and into the goo-cock.  Laughing, the goo-girl absorbs your cum, growing larger and larger as you feed her, until she towers over you, her massive cock now wide enough to painfully stretch your walls.  \"<i>Oh, that's good.  Good, girl, good.  Yes, let it all out, just like that... just like that,</i>\" she coos, soaking your juices up until your orgasm finally passes.  Sated, she withdraws from inside you, leaving a decidedly empty feeling in your gut as she allows you to stand."); 

		outputText("\n\n\"<i>Mmm, that was fun,</i>\" the goo-girl says, patting her full belly.  You can see a bit of your cum ");
		if(player.biggestTitSize() > 1 && player.lactationQ() > 0) outputText("and milk ");
		outputText("swirling around inside her.  \"<i>Well, I suppose since you fed me so well, I'll let you go.  This time! See you around, tasty!</i>\"");

		outputText("\n\nBefore you can recover enough to say a word, the goo-girl saunters off out the door.  To your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//(PC has Dick)
	else if(player.hasCock()) {
		outputText("She begins to use her goo to peel back your armor, soon revealing your defenseless, half-erect cock");
		if(player.cockTotal() > 1) outputText("s");
		outputText(".  She makes a show of licking her lips as tendrils of goo wrap tightly around [eachCock] like a warm, wet onahole. You writhe and struggle against your gooey bonds, but your efforts are futile.  The goo-girl inside the armor only shakes her head at you, and squeezes [eachCock] tighter.");
		outputText("\n\nYou gasp with pleasure as she starts to stroke your " + multiCockDescriptLight() + ", jerking you off as she looms over you, grinning wickedly.  \"<i>Oh, you like that do you?</i>\" the armor-goo asks.  \"<i>Well, maybe this can be mutually... beneficial.</i>\"  She starts to increase her tempo, making you squirm and writhe as she wanks your " + multiCockDescriptLight() + ", licking her lips as little bubbles of pre-cum form.  Helpless, you can only submit and try to enjoy yourself as the armored goo-girl continues to milk you.");
		outputText("\n\nShe continues to jerk you off mercilessly, her grin spreading to inhuman width as your pre begins to flow around and into her gooey 'hands'.  She soaks you up greedily, enjoying the meal, but her fucking is relentless until you feel orgasm approaching.  \"<i>Aw, ");
		if(player.tallness < 70) outputText("little");
		else outputText("big");
		outputText(" " + player.mf("boy","girl") + " ready to cum? Well, go on then. Feed me!</i>\"");
		
		outputText("\n\nYou climax, ropes of thick, white jizz shooting out of [eachCock] and into the goo's waiting body.  Laughing, the goo-girl absorbs your cum, growing larger and larger as you feed her until she towers over you, her expanding breasts and belly now hanging over you. \"<i>Oh, that's good. Good, " + player.mf("boy","girl") + ", good.  Yes, let it all out, just like that... Just like that,</i>\" she coos, soaking your cum up until your orgasm finally passes.  Sated, she withdraws from around you, leaving your " + multiCockDescriptLight() + " decidedly empty and sore.");

		outputText("\n\n\"<i>Mmm, that was fun,</i>\" the goo-girl says, patting her full belly.  You can see a bit of your cum swirling around inside her.  \"<i>Well, I suppose since you fed me so well, I'll let you go.  This time!  See you around, tasty!</i>\"");
		
		outputText("\n\nBefore you can recover enough to say a word, the goo-girl saunters off out the door.  To your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//Genderless
	else {
		outputText("You collapse, unable to resist the goo-armor's onslaught.  Laughing, goo slithers out from the bottom of her armor, completely encasing you before you can do anything more than scream.  Laughing maniacally, the goo looms over you, hands on her hips.  \"<i>Tsk, tsk, tsk.  Not so eager to steal my armor now, are you?  Well... what am I to do with you, hmm?</i>\"  You struggle, but wrapped snugly in her goo, you can do little more than wiggle your hips and chest, accidentally moving yourself seductively.");

		outputText("\n\nAs you realize your mistake, a little smile spreads on your face.  \"<i>Ah, I know... I haven't had my precious fluids in so very long...</i>\" She begins to use her goo to peel back your armor, but stops with a look of horror as she reveals you bare, empty crotch.");

		outputText("\n\n\"<i>What. Just... WHAT. How do you... " + player.mf("Dude","Babe") + ", how do you PEE!?</i>\"");

		outputText("\n\nYou struggle weakly, unable to respond.");

		outputText("\n\n\"<i>Oh... fuck it. Just... whatever. Go away, you freak.</i>\"");

		outputText("\n\nThe goo-girl shrugs and saunters out the front door.");
		
		outputText("\n\nSore, you pick yourself up off the floor and wipe a bit of gooey residue off your gear.  To your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	}
	//(PC regains HP)
	HPChange(1000,false);
	stats(0,0,0,0,1,3,-100,0);
	eventParser(5007);
	doNext(1);
	flags[LOST_GOO_ARMOR_FIGHT] = 1;
}

//Goo Armor -- PC is Victorious (Intro)
function beatUpGooArmor():void {
	spriteSelect(79);
	clearOutput();
	outputText("Succumbing to your ");
	if(monster.lust > 99) outputText("erotic abilities");
	else outputText("skill in battle");
	outputText(", the armored goo slumps backwards against the wall, unable to stand.  You loom over her, grinning as you contemplate what to do with your helpless opponent.");

	outputText("\n\n\"<i>Hey... hey wait!</i>\" the goo gasps, waving a hand emphatically to ward you off.  \"<i>It... it doesn't have to be like this.  I think... Hey, yeah, I think we can come to an understanding.  You're a reasonable sort, right? No need to get violent...</i>\"");

	outputText("\n\nYou scowl at the armor-goo, but allow her to speak.");

	outputText("\n\n\"<i>Eheh. Uh, I was only playing, see? Just hungry, is all.  Don't get many folks up hereabouts, except the damn harpies, who don't bother me much.  Uh, so, what do you say we cut a deal, huh?</i>\"  You raise an eyebrow at her.  \"<i>You just kicked my ass royally.  That's damn impressive, considering I used to be pretty hot stuff with a sword back in the day.  Now that I'm, uh, less solid than I was... Well, I'm just not cut out to be an adventurer on my own anymore.  You proved that all right.</i>\"");

	outputText("\n\n\"<i>So what do you say... I come with you? Hmm? How about it?  You can fit right inside me and this old lug,</i>\" she raps her gooey knuckles silently on her shiney breastplate.  She scowls; her fist's lack of solidity seems to perturb her greatly.  \"<i>Seriously, though.  You can wear me just like any other armor - damn good armor at that!  And, if you're feeling antsy on your - our - adventures, then maybe I can help you out with that, too?</i>\"");

	outputText("\n\nWell, that's certainly an interesting offer. Do you take the goo-girl armor with you?");
	//(Display Options: [Take Her] [Refuse Her])
	simpleChoices("Take Her",11095,"Refuse Her",11094,"",0,"",0,"",0);
	flags[WON_GOO_ARMOR_FIGHT] = 1;
}
//[Refuse Her]
function refuseGooArmorOffer():void {
	spriteSelect(79);
	clearOutput();
	outputText("You tell her to fuck off -- you don't need armor that might try to kill or rape you at night.");
	outputText("\n\nShe huffs indignantly and scrambles to her feet.  \"<i>Well fine, and fuck you anyway.  I hope you get raped by harpies, " + player.mf("sir","madam") + ".</i>\"  After a moment, she hesitantly adds, \"<i>But if you change your mind later... Well, we'll see if you live through this place without me!</i>\"  Before you can stop her, she ducks out the front door and off to... Wherever goo-armor-girl-things would go, you guess.  Still, to your surprise, you feel rather invigorated after the battle, and rolling your shoulders, you turn your attention back to the dungeon ahead.");
	HPChange(1000,false);
	eventParser(5007);
	doNext(1);
}
//[Take Her]
function takeGooArmorAndWearIt():void {
	spriteSelect(79);
	clearOutput();
	outputText("You mull the proposition over for a few moments and then agree. Why the hell not.");
	outputText("\n\nWith an ecstatic smile, the goo-armor jumps to her feet and throws her arms around your shoulders.  \"<i>Oh, this is going to be so much fun!  Thank you thank you thank you!  I promise I'll keep you nice and snug and safe, don't you worry.  Oooh, a real adventure again!  WHEEE!</i>\"");
	outputText("\n\nBefore she can get too excited, you remind the goo that she's supposed to be your armor right about now.  Clasping her hands over her mouth in embarrassment, she utters a muted apology and urges you to just \"<i>put me on!</i>\"  Awkwardly, you strip out of your [armor] and open up the platemail armor and clamber in.  It's wet and squishy, making you shudder and squirm as you squash your new friend flat against the metal armor.");
	outputText("\n\nEventually, the two of you get situated. The goo-girl slips around your body inside the heavy armor, maneuvering so that your face is unobstructed and your joints, not protected by the armor, are soundly clad in squishy goo.  She even forms a gooey beaver on your new helm, allowing you to open and close her like a visor in battle.  Eventually, her goo settles around your ");
	if(player.hasVagina()) outputText("[vagina]");
	if(player.hasVagina() && player.hasCock()) outputText(" and ");
	if(player.hasCock()) outputText(multiCockDescriptLight());
	if(player.gender == 0) outputText("groin");
	outputText(", encasing your loins in case you need a little mid-battle release, she says.");

	outputText("\n\nAfter a few minutes, you and your armor-friend are settled and ready to go.  As you ready yourself for the dungeon ahead, the goo giggles into your ear.  \"<i>Oh shit, silly me.  I forgot, my name's Valeria.  Ser Valeria, if you're feeling fancy.</i>\"  You introduce yourself, awkwardly shaking your own hand by way of pleasantries.");

	outputText("\n\n\"<i>Well, alright then, [name]!</i>\" Valeria says excitedly, \"<i>Let's go!</i>\"");

	//(\"<i>You gained ValeriaArmor!</i>\")
	eventParser(5007);
	//(\"<i>You put a (previous armorName) in your X pouch)
	outputText("\n\nTo your surprise, you feel rather invigorated after the battle, thanks to Valeria's strange healing properties, and with a smirk, you turn your attention back to the dungeon ahead.\n\n");
	//(PC regains HP)
	equipArmor("goo armor", false);
	flags[MET_VALERIA] = 1;
	HPChange(1000,false);
	flags[TOOK_GOO_ARMOR] = 1;
}

//ATTACK ONE: Claw Flurry
function harpyHordeClawFlurry():void {
	outputText("The harpies lunge at you, a veritable storm of talons and claws raining down around you.  You stumble back, trying desperately to deflect some of the attacks, but there are simply too many to block them all!  Only a single harpy in the brood seems to be holding back...\n");
	//(Effect: Multiple light attacks)
	monster.createStatusAffect("attacks",3+rand(3),0,0,0);
	eAttack();
	combatRoundOver();
}

//ATTACK TWO: Gangbang
function harpyHordeGangBangAttack():void {
	outputText("Suddenly, a pair of harpies grabs you from behind, holding your arms to keep you from fighting back! Taking advantage of your open state, the other harpies leap at you, hammering your chest with punches and kicks - only one hangs back from the gang assault.\n\n");
	player.createStatusAffect("HarpyBind",0,0,0,0);
	//(PC must struggle:
	harpyHordeGangBangStruggle(false);
}

function harpyHordeGangBangStruggle(clearDisp:Boolean = true):void {
	if(clearDisp) clearOutput();
	//Failure: 
	//If fail:
	if(rand(10) > 0 && player.str/5 + rand(20) < 23) {
		var damage:Number = 80 + rand(40);
		damage = takeDamage(damage);
		outputText("You struggle in the harpies' grasp, but can't quite get free.  The brood continues to hammer away at your defenseless self. (" + damage + ")");
	}
	//Success: 
	else {
		player.removeStatusAffect("HarpyBind");
		outputText("With a mighty roar, you throw off the harpies grabbing you and return to the fight!");
	}
	combatRoundOver();
}

//ATTACK THREE: LUSTY HARPIES!
function harpyHordeLustAttack():void {
	outputText("The harpies back off for a moment, giving you room to breathe - only to begin a mini strip-tease, pulling off bits of clothing to reveal their massive asses and hips or bearing their small, perky tits.  They caress themselves and each other, moaning lewdly.  Distracted by the burlesque, you don't notice a lipstick-wearing harpy approach you until it's too late!  She plants a kiss right on your lips, ");
	if(player.hasPerk("Luststick Adapted") >= 0) outputText("doing relatively little thanks to your adaptation");
	else {
		outputText("sending shivers of lust up your spine");
		stats(0,0,0,0,0,0,5,0);
		if(player.hasCock()) stats(0,0,0,0,0,0,15,0);
	}
	outputText(".");
	stats(0,0,0,0,0,0,10,0);
	combatRoundOver();
}

function harpyHordeAI():void {
	if(rand(3) == 0) harpyHordeLustAttack();
	else if(rand(3) > 0) harpyHordeClawFlurry()
	else harpyHordeGangBangAttack();
}
//Harpy Horde -- PC is Defeated (MAYBE BAD END!!!)
function pcLosesToHarpyHorde():void {
	outputText("\n\nUnable to withstand the ");
	if(player.HP < 1) outputText("brutal assault");
	else outputText("raw sexuality");
	outputText(", you collapse, utterly at the harpies' mercy.  The group looms over you, lusty, evil grins all around, but to your surprise, one of them shouts a harsh command, making the swarm of feathery bitches back off.  A particularly slight harpy with a shock of bright-orange hair waves the brood off, astonishingly commanding for the runt of the litter.  The other harpies hiss and growl at her, but still she speaks, \"<i>Hold it!  We can't have the intruder yet.  Mother will want to talk to " + player.mf("him","her") + " first.</i>\"");
	outputText("\n\nThe brood grumbles, but you are hauled off your feet and dragged upstairs...");
	//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
	doNext(11117);
}

//Harpy Horde -- PC is Victorious
function pcDefeatsHarpyHorde():void {
	clearOutput();
	flags[HEL_HARPIES_DEFEATED] = 1;
	outputText("The harpies collapse in a pile in the center of the room, all utterly defeated... except one.  The lone harpy that did not attack you throughout the fight, a rather slight girl with a shock of bright orange hair, still stands, gaping at the destruction you've wrought.  Eventually, her gaze shifts up to you.");

	outputText("\n\n\"<i>Holy shit, " + player.mf("dude","lady") + ".  You're a goddamn one-" + player.race() + "-army, aren't you? You... you must be [name], right? Hel... er, Miss Helia told me about you.  I'm, uh... I'm Kiri.  Sorry about the other girls - I'd just spiked their drinks, but they didn't have time to finish them.  You're a little earlier than I was expecting.  Sorry,</i>\" she whispers nervously, rubbing the back of her neck.");

	outputText("\n\nYou ask her who she is exactly and how she knows Hel.");

	outputText("\n\n\"<i>Uh, well, I'm the one who told her about this place. You could say I'm her informant, I guess,</i>\" she shrugs and slips her hands behind her inhumanly wide hips.  Cocking an eyebrow, you notice the girl is actually quite pretty - her wings and hair are an orange as bright as the sun, and she has deliciously curvaceous thighs and hips, not to mention cute perky breasts.  Noticing your lusty glances, she makes a little giggle and bites her lower lip.");

	outputText("\n\n\"<i>Anyway, Miss Helia asked me to help you any way I can, so... I guess, just ask me if you need anything.</i>\"");
	eventParser(5007);
}
//Kiri -- [Talk]
function talkToKiri():void {
	clearOutput();
	outputText("You ask Kiri if she wouldn't mind sharing a bit of information with you.");
	outputText("\n\n\"<i>Of course,</i>\" she says pleasantly, \"<i>that's what I'm here for!  What do you want to know?</i>\"");
	//(Display Options: [Hel] [Harpies] [Salamander] [Kiri])
	simpleChoices("Hel",11099,"Harpies",11100,"Salamander",11101,"Kiri",11102,"Nevermind",1);
}

//Kiri -- [Talk] -- [Hel]
function askKirkAboutHel():void {
	clearOutput();
	outputText("You ask the harpy girl how she knows Hel, exactly.");
	outputText("\n\n\"<i>Oh, uh,</i>\" she starts nervously, obviously taken aback by your question.  \"<i>I've known Miss Helia for quite a while now. She saved my life a couple of years ago, and, well, we've been friends ever since.  When I realized what was going on here - who the salamander in the dungeon was - I couldn't help but try and tell her what's up.</i>\"");

	outputText("\n\nKnowing Hel as well as you do, you venture to ask Kiri if she and Hel are just friends.");
	outputText("\n\n\"<i>Wha - what!?</i>\" she stammers, aghast.  \"<i>I, we, uh, I mean... Gah.</i>\"  She slumps her shoulders.  \"<i>Yeah, I guess you could say that. It's not like we're in love or anything, but, you know...</i>\" The harpy trails off with a light shrug.  \"<i>She's been good to me.</i>\"");
	doNext(11098);
}

//Kiri -- [Talk] -- [Harpies]
function askKiriAboutHarpies():void {
	clearOutput();
	outputText("You ask Kiri about the harpies remaining in the tower and their relative strength and position - anything to give you an advantage.");
	outputText("\n\n\"<i>Right, yeah, Hel asked me to scout around and remember that stuff.  Uh... Oh yeah!</i>\" she clears her throat and begins to recite:  \"<i>Dungeon Level: Brigid the Jailer, salamander prisoner.  Mezzanine: Phoenix Heavy Infantry unit, trained but inexperienced.  Second Floor: Honor Guard, elite bodyguards; and our Broodmother, Calais, queen of the tower.</i>\"");
	outputText("\n\nYou nod, then ask, \"<i>Phoenixes?</i>\"");
	outputText("\n\n\"<i>Oh, yes... That's what Hel is here to stop, I think.  They're the half-breeds mother has made with the salamander prisoner down below.</i>\"");
	doNext(11098);
}

//Kiri -- [Talk] -- [Salamander]
function askKiriAboutSalamander():void {
	clearOutput();
	outputText("You ask her about the salamander prisoner you're here to help free.");
	outputText("\n\n\"<i>Oh, yeah...</i>\" Kiri says nervously \"<i>About that...</i>\"");
	outputText("\n\nUh-oh.");
	outputText("\n\n\"<i>No, no!  He's fine! Er, well, as fine as he can be, all things considered.  I just... uh... thought you should know: his name is Hakon en Kahlesin.  He's Hel's dad.  And mine.</i>\"");
	outputText("\n\nWell, shit.");
	outputText("\n\n\"<i>Hel doesn't know yet... I didn't want her to lose her head or do something reckless.  But, yeah, that's dad down there.  I just wish... I could have done something more to help him.</i>\"");
	outputText("\n\nYou ask how you can free him.");
	outputText("\n\n\"<i>Mother keeps the key to his hand shackles on her at all times.  Brigid has the one for his legs.  You'll need to defeat both to free him.</i>\"");
	doNext(11098);
}

//Kiri -- [Talk] -- [Kiri]
function askKiriAboutKiri():void {
	clearOutput();
	outputText("You ask Kiri to tell you a little about herself.");
	outputText("\n\n\"<i>Who, me? Oh, I'm nobody special, really...</i>\" she says with a self-conscious chuckle.");
	outputText("\n\nYou urge her to tell you something anyway.");
	outputText("\n\n\"<i>Well, I guess you could say I'm a half-breed, of sorts.  My dad's the salamander downstairs, mom's the broodmother you're going to fight in a bit.  Mom hadn't quite figured out the magic she needed to produce the phoenixes when I was born - I didn't turn out quite right.  I'm really just a harpy.  Nothing special.</i>\"");
	outputText("\n\nShe doesn't seem to want to say more, so you shrug and carry on.");
	doNext(11098);
}
// Kiri -- [Sex] (Intro)
function kiriSexIntro():void {
	clearOutput();
	outputText("You ask Kiri if she could help you blow off some steam.");
	outputText("\n\n\"<i>Wha-WHAT!?</i>\" she yelps, recoiling.  \"<i>Hey, look, I owe Hel big time, but I never agreed to do... to do that!  You... no way!</i>\"");
	outputText("\n\nYou remind Kiri that here in Mareth an errant tease or stroke of skin can mean the difference between victory and being raped if you're too horny.  And, she promised Hel she'd help you...");
	outputText("\n\n\"<i>I... but... that's not fair!</i>\" she groans.  She hangs her head and sighs.  \"<i>I guess I wouldn't want you getting raped and imprisoned as a breeding slut hanging over my head all my life.  Fine!  Just... use me however you need to.  But be gentle, okay?</i>\"");
	//(Display Options:
	//If Male: [Anal]
	//If Female [Get Licked]
	//If Genderless: \"<i>Unfortunately, there's not much she can do for you...</i>\"
	if(player.gender == 0) outputText("Unfortunately, there's not much she can do for you...");
	var anal:Number = 0;
	var licked:Number = 0;
	if(player.hasCock()) anal = 11104;
	if(player.hasVagina()) licked = 11105;
	simpleChoices("Anal",anal,"Get Licked",licked,"",0,"",0,"Back",1);
}

//Kiri -- [Sex] -- [Anal]
function kiriSexAnal():void {
	clearOutput();
	var x:Number = player.cockThatFits(60);
	if(x < 0) x = player.smallestCockIndex();
	var y:Number = x+1;
	outputText("You whip your [cock " + (y) + "] out of your [armor] and tell Kiri to get on all fours.  She grimaces, but does as you ask.  You hike up her shift to reveal her large, egg-laying pussy and her tight little pucker.");
	outputText("\n\n\"<i>Just make sure you pull out, all right? I don't wanna get pregnant - EEEP!</i>\" she shrieks as your [cock " + y + "] pokes against her backdoor.  Her wings beat furiously around you, nearly lifting you both off the ground.  You give her a swat on the ass to help her get a grip as you take hold of her inhumanly wide hips.  She wriggles around for a bit before finally calming down and trying to relax as best she can.");
	outputText("\n\nIt takes some doing, but you eventually manage to push your prick in past her tight sphincter.  With a relieved sigh, you start to push into her ass, slowly but steadily feeding her inches of your [cock " + y + "] until ");
	if(player.cockArea(x) > 60) outputText("you can fit no more in");
	else outputText("you are buried to the hilt");
	outputText(".  Beneath you, Kiri writhes and groans in pained pleasure as you stuff her ass full of your cock.  When you've finally buried yourself as far as you'll go, you give her lush ass cheeks a little squeeze and start to rock your hips.  Kiri gasps, suddenly feeling empty as you withdraw from inside her - and screams when you slam yourself back in.");
	outputText("\n\nSinking your hands into her soft, plush butt, you start to hammer her asshole, fucking her hard and fast until you're both moaning like whores.  Your combined pre-cum and juices are staining the floor and her inner walls.  To your surprise, Kiri lifts herself off the ground and presses her back to your chest, letting her wings wrap around you.  Grinning, you grope her perky breasts as you continue to ream her ass.  She puts her hands on yours, pinching her nipples and guiding you to all her most sensitive spots.");
	outputText("\n\nYou cum quickly, grunting into her ear and ramming yourself until you're ");
	if(player.cockArea(x) > 60) outputText("as far in as you can manage");
	else outputText("filling her completely");
	outputText(".  Your cock squirts a thick load inside her, shooting creamy ropes of jizz deep into her bowels ");
	//[if High Cum Production: 
	if(player.cumQ() > 500) outputText("until your cream squelches back out around your cock and onto the floor");
	outputText(".  With a scream of delight, Kiri clamps down on your [cock " + y + "] and climaxes too, leaking a pool of fem-spunk onto the ground.  She starts to bounce on your cock, riding out her anal orgasm until she's exhausted and you're deflated inside her.");

	outputText("\n\nYou pull out with a POP, letting a stream of cum leak out her butt.  You clean your cock off and stick it back in your [armor].");
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

//Kiri -- [Sex] -- [Get Licked]
function kiriSexGetLicked():void {
	clearOutput();
	outputText("You ask Kiri to eat you out. She grimaces but drops to her knees and undoes the bottom of your [armor], revealing your lusty [vagina]");
	if(player.hasCock()) outputText(" and " + multiCockDescriptLight());
	outputText(".  With a word of encouragement from you, she leans forward and presses her face into your groin, letting her tongue loose to explore your lower lips.");
	outputText("\n\nThe girl's tongue is surprisingly skilled.  She quickly teases it across your clitty, making you moan with unexpected pleasure.  She begins to tease and play with your pleasure buzzer, using the flat of her tongue to tickle the sensitive flesh around it; you urge her on with little pats of the head and shoulders, even reaching down to cup one of her perky breasts beneath her loose shift or stroke one of her great orange wings.");
	outputText("\n\nShe finally slips her tongue in and starts to caress the walls of your [vagina], running her soft, warm tongue along your innermost depths with delightful speed and gentleness.  You smile and run your hands through her short orange hair, stroking her as she grips your hips and buries her face in your twat.");
	outputText("\n\nYou begin to grind your slit into her face as she eats you out, rubbing your cunt along her nose and forehead to the beat of her tongue's skillful ministrations.  She makes a slow, steady progression inward, slipping her long tongue further and further into your cunny until you can feel her flicking around your cervix.");
	outputText("\n\nYou cannot resist her skillful tongue-fuck for long.  Grabbing Kiri's head, you force her face into your crotch, getting every last bit of her tongue inside you as you can as you climax, spraying your fem-cum all across her face.");
	outputText("\n\nUtterly satisfied, you stagger back from Kiri, letting her whip her head around to flick off your fem-cum.  You clean yourself off and suit up again.");
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

//[Valeria]
function talkToValeria():void {
	clearOutput();
	outputText("Now that you have a few moments to catch your breath, you ask your goo-armor what she thinks about the situation.");
	outputText("\n\n\"<i>Oh, hi,</i>\" she laughs.  She pours half-way out of your armor, forming her face a few inches from yours.  Kiri leaps in shock, wide-eyed as your armor becomes a new person before you.");
	outputText("\n\n\"<i>Well hey there, cutie,</i>\" Valeria says, giving Kiri a little wink.  The harpy shudders slightly and shakes the surprise off.");
	outputText("\n\nYou clear your throat and repeat your question.");
	//[If Broodmother hasn't been defeated]
	if(flags[HEL_HARPY_QUEEN_DEFEATED] == 0) outputText("\n\n\"<i>Oh, right. Well, that harpy broodmother is serious business. She's a powerful mage, and a heavy-hitter besides.  Careful with her, or you're liable to end up drugged out of your mind and used as breeding stock 'till you die.  I've seen it happen to other adventurers coming through.</i>\"");
	//[If Jailer hasn't been defeated]
	if(HEL_BRIGID_DEFEATED == 0) outputText("\n\n\"<i>Brigid the Jailer is a big girl, probably the meanest harpy here. The others give her plenty of space, from what I've seen.  She uses a hot poker as her weapon, too.  Watch out unless you wanna get burned!</i>\"");
	//[If phoenixes haven't been defeated]
	if(flags[HEL_PHOENIXES_DEFEATED] == 0) outputText("\n\n\"<i>There's some freaky-ass half-breed harpy things upstairs that I've seen around a bit.  Phoenixes, I guess they're called.  They breathe fire, so watch your ass.  I can absorb some of the heat, but... Don't get roasted, okay?</i>\"");
	doNext(1);
}

//Attack One: Hot Poker, Right Up Your Ass!
function brigidPoke():void {
	outputText("Brigid stalks forward with confidence, her shield absorbing your defensive blows until she's right on top of you. She bats your [weapon] aside and thrashes you with her hot poker, scalding your " + player.skin() + " and sending you reeling.");
	//(Effect: Heavy Damage)
	var damage:Number = Math.round((monster.str + monster.weaponAttack) - rand(player.tou) - player.armorDef);
	if(damage < 30) damage = 30;
	damage = takeDamage(damage);
	outputText(" (" + damage + ")");
	combatRoundOver();
}

//Attack Two: SHIELD BOP! OOM BOP!
function brigidBop():void {
	outputText("The harpy feints at you with her poker; you dodge the blow, but you leave yourself vulnerable as she spins around and slams her heavy shield into you, knocking you off balance.");
	//(Effect: Stagger/Stun)
	var damage:Number = 5;
	damage = takeDamage(5);
	outputText(" (" + damage + ")");
	if(player.hasPerk("Resolute") >= 0) outputText("  Of course, your resolute posture prevents her from accomplishing much.");
	else player.createStatusAffect("Stunned",0,0,0,0);
	combatRoundOver();
}

//Attack Three: Harpy Ass Grind GO!
function BrigidAssGrind():void {
	outputText("Brigid grins as she approaches you.  She handily deflects a few defensive blows and grabs you by the shoulders.  She forces you onto your knees and before you can blink, has turned around and smashed your face into her ass!  \"<i>Mmm, you like that, don'tcha?</i>\" she growls, grinding her huge, soft ass across your face, giving you an up-close and personal feel of her egg-laying hips.");
	stats(0,0,0,0,0,0,30,0);
	combatRoundOver();
}
function BrigidAI():void {
	if(player.hasStatusAffect("Stunned") >= 0) {
		player.removeStatusAffect("Stunned");
		if(rand(2) == 0) BrigidAssGrind();
		else brigidPoke();
		return;
	}
	if(rand(3) == 0) BrigidAssGrind();
	else if(rand(2) == 0) brigidBop();
	else brigidPoke();
}

//Brigid the Jailer -- PC Victorious
function pcDefeatsBrigid():void {
	clearOutput();
	outputText("The harpy jailer collapses, ");
	if(monster.lust > 99) outputText("too turned on");
	else outputText("too badly beaten");
	outputText(" to continue the fight.  You quickly snatch the keys from inside her shield, and hook them onto your own belt.");
	//(New Key Item: Harpy Key A)
	player.createKeyItem("Harpy Key A",0,0,0,0);
	eventParser(5007);
	flags[HEL_BRIGID_DEFEATED] = 1;
}

//Brigid the Jailer -- PC Defeated
function pcDefeatedByBrigid():void {
	clearOutput();
	if(flags[HEL_HARPY_QUEEN_DEFEATED] == 0) {
		outputText("\"<i>Tsk tsk tsk,</i>\" the harpy jailer croons, looming over you as you slump to the ground. \"<i>You shouldn't have messed with me, bitch!</i>\" she snaps, giving you a rough kick to the side. \"<i>Now, let's see what Mother has to say about this...</i>\"");
		//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
		doNext(11117);
	}
	else {
		outputText("\"<i>That's it?!</i>\" Brigid screams, as you collapse in front of her.  \"<i>A weak little piece of trash like you took out our queen?</i>\"");
		
		outputText("\n\n\"<i>[name]!</i>\" calls a voice from behind you.  Hel bounds down the stairs, summoned by the sound of the fight; when she spies your defeated form, she draws her sword and throws herself at the harpy jailer, completely clearing the ground in her rage.  The scene that plays out next passes through your dazed mind agonizingly, like a nightmare.");
		outputText("\n\nAs Hel launches herself over your body, weapon raised over her head, Brigid turns and raises a taloned foot.  It catches the salamander right in the stomach, bending her double, and the scimitar flies out of her hands to skitter across the stone floor.  You can see the light leave Hel's eyes as she coughs violently, and a small fan of blood and flame is ejected from her mouth.  The man on the table winces as Brigid lowers your partner to the ground.");
		outputText("\n\n\"<i>Completely PATHETIC!</i>\" rants the dyke jailer.  \"<i>Neither of you is anything more than garbage!</i>\"  She turns to her torture rack, holding it steady with one foot as she searches for and discards items from it.");
		
		outputText("\n\n\"<i>Where the fu- AHA!</i>\" she cries in triumph, tossing a dangerous-looking knife aside and claiming something from behind it.  Turning again, Brigid advances on you and Hel with a smouldering smile, carrying two small vials of thick, white liquid.  \"<i>Garbage you may be, but even garbage can be recycled.</i>\"");
		
		outputText("\n\nAn alarm blares in your mind and you reach out sluggishly to try and grab her slim ankle, but she kicks you in the head and your vision goes mazy.  The last thing you make out before slipping into unconsciousness is the harpy standing over Hel, pinning her fiery tail under a shield held down with one claw as she forces the contents of a vial down the salamander's gullet...");
		
		doNext(brigitPostQueenDeathBadEndII);
	}
}

//--Next--
function brigitPostQueenDeathBadEndII():void {
	clearOutput();
	//[(if M, U, or visibly pregnant F/H)
	if(player.gender <= 1 || player.pregnancyIncubation > 0) {
		outputText("A soft, ticklish feeling against your [chest] is the first thing to bring you back to reality.  Your eyes open slowly, revealing a confusing blur of orange and pale.  \"<i>[name],</i>\" murmurs a familiar voice from the unfocused smear, \"<i>you're alright... thank god.</i>\"  As your head clears, the picture slowly resolves into the tear-streaked face of Kiri, the little harpy from before; she smiles as you recognize her, and wraps her arms around your neck.  You try to hold her back, but find you cannot move your hands - looking at them, you notice your wrists secured to the table you're lying on with metal clasps!");
		outputText("\n\n\"<i>S-sorry,</i>\" Kiri whispers, \"<i>Brigid won, remember...</i>\"  The results of the last fight return to you in a flash, explaining your current predicament.  Testing your whole body, you find all your limbs similarly bound to the stone table.");
		
		outputText("\n\n\"<i>The others?</i>\" you ask, blearily.");
		
		outputText("\n\nThe harpy girl atop you frowns unhappily, and darts her eyes to the left.  Turning your head to follow her glance, you see the captured salamander from before and, mounted atop his swollen prick, Hel!  Her face is covered by an iron mask, but the tits are the same familiar, jiggling orbs and you can't imagine there are any other female salamanders here... or rather, formerly female.  You revise your guess hurriedly as the captive grunts and thrusts into her, forcing her hips up and allowing the small cock now growing from her crotch to bob freely!  A drop of pre-cum glides down it, and Hel shivers; the skin on her new dick looks chafed and raw, flushed red where it's not spotted with orange scales.");
		
		outputText("\n\n\"<i>She's been first pick of the remaining women,</i>\" Kiri mumbles, gesturing toward several satisfied harpy and phoenix matrons dozing along the walls.  \"<i>They've spend equal time fighting over and fucking her, poor sis-</i>\"");
		
		outputText("\n\nA sharp crack sounds and Kiri's eyes widen as her chest jerks forward; Brigid stands behind her, holding a leather crop.  \"<i>You're here to fuck, not talk!</i>\" the torturer screams, shaking the whip at you.  \"<i>I don't care if it's salamanders, phoenixes, or just half-breed harpies, but you are going to help make me a new army to replace the one you wiped out!</i>\"  Kiri grimaces at the brutal woman, but begins shifting her hips against you, sending a wave of pleasure to the base of your spine.");
		
		//[(if F or U)
		if(!player.hasCock()) {
			outputText("\n\nYour eyes widen in shock at the sensation, and Kiri flinches at your expression.  \"<i>What,</i>\" Brigid asks, glowering at you, \"<i>did you think we'd let you go after what you did, just because we couldn't breed you?");
			if(player.pregnancyIncubation > 0) outputText("  Once this disgusting thing you're carrying falls out of you, we'll use you more traditionally, but...</i>\"  She pauses to press uncomfortably on your pregnant belly, then resumes speaking.  \"<i>I have no intention of letting you sit idle for however long that takes.");
			outputText("  For now, I've given you the most obvious modification - I can think of something else later.</i>\"");
			outputText("\n\nShe squeezes Kiri's ass firmly with one hand, and lifts the girl partway out of your lap.  A smooth, hot sensation separates from your crotch and glides along nerves you hadn't noticed until now as Kiri's pussy slides upward, partially revealing the erect, " + player.skinTone + " flesh of a brand new cock!  Brigid gloats at your confusion, laughing her delight to the roof of the chamber, then shoves Kiri's ass downward again, spearing her pussy on your new flesh and making the girl wince and grit her teeth.");
			player.createCock();
		}
		outputText("\n\nThe jailer slaps the small half-breed on the butt, sending a pleasing tremor through your cock, then withdraws to a stool in the corner.  \"<i>Fuck... or I'll make you fuck,</i>\" she declares ominously, casting her riding crop aside and beckoning another harpy over.  She picks up a worn journal as the other woman sits on her leg, then begins turning the pages with a thumb as she plays with the harpy's pussy.  \"<i>Watch them for me, sweet,</i>\" Brigid says, kissing the woman on the neck.  \"<i>Make sure they do their jobs while I'm studying mom's notes.</i>\"  Her lover shivers and nods nervously, fixing her eyes on you.");
		
		outputText("\n\nKiri strokes your prick with her body vigorously, pushing you toward your limit and keeping up appearances even as she whispers to you.  \"<i>Please, [name]... just endure it for now.  I'll think of a way to get you out of here, I promise.</i>\"  She shifts her hips downward, engulfing your shaft again, and rolls her head passionately as her cheeks flush.  \"<i>I-it may be a while, though,</i>\" she says, kissing your chest.  \"<i>I - ah! I'm not very much by myself, so... the only thing I can do is make lots of loyal, strong daughters with your seed... s-someday there'll be enough to make a break for it!  J-just hold on and... and... fertilize me!  </i>Fertilize me<i>, [name]!</i>\"");
		
		outputText("\n\nThe harpy's eyes roll back in her head as she moans and sinks down one last time in orgasm, sucking at your cock with her vagina; your throbbing prick obeys, ejaculating a load of semen into the open-mouthed bird-girl.  \"<i>Ohh god,</i>\" Kiri gasps, \"<i>YES!  Cover my eggs in your sticky cum!  Fill me up!</i>\"");
		if(player.cockTotal() > 1 || player.cumQ() > 1000) outputText("  " + SMultiCockDesc() + " holds forth for a while, until Kiri's ass, pussy, and tailfeathers are soaked with oozing, white cum.");
		outputText("  Next to you, the salamander on the other table climaxes as well, dumping a load into Hel that sizzles when it leaks onto his fiery, iron-bound tail.  Your former lover squirms and shivers as the scalding-hot load fills her cunt, and her own prick twitches weakly, depositing a small string of bubbling jism on the stone table.");

		outputText("\n\n\"<i>Oh dad... Hel... I'm sorry,</i>\" Kiri whimpers, unable to pull her eyes away from them as your cock dribbles the last of your seed into her.  The bound man's single eye widens as he hears the name of his partner, and his face deforms with rage as a roar pours out of him with enough volume to shake the room.  Kiri buries her face in your [chest] and shudders as the prisoner bellows his frustration; Hel simply looks left and right, confused and anxious as the echoing roar dies off; Brigid pushes her toy pussy away and rises from her stool.");
		
		outputText("\n\n\"<i>Not bad, old man,</i>\" the jailer quips.  \"<i>I didn't think you had that much life left in you.  Maybe I'll keep you with this woman for a while!</i>\"  The salamander's eye hardens, but he says nothing; Brigid looks from him to you and Kiri, but you both assume expressions of studied incomprehension.  \"<i>... Whatever.  You bitches get up; you've had your turns and I've got a lot more cunts to pack full.</i>\"  She begins pulling Hel's chains free of the iron ring at the end of the table.");
		
		outputText("\n\nKiri frowns unhappily as she slips your cock from her pussy, then kisses you.  \"<i>Remember, [name]... just hold on!  And... save some of your seed for me!</i>\"  She lingers for a while, looking in your eyes affectionately, but Brigid grabs her by the hair and, swearing filthily, pulls her away.  A sadistic-looking phoenix takes her place, straddling you and slipping your sore prick into her cunt... the last thing you manage to do before your head is filled with the agony and ecstasy of having your raw shaft ridden again right after orgasm is to wonder exactly how long salamander-harpy half-breeds gestate...");
		//[GAME THE FUCK OVER, SON; WHERE IS MY MONEY?]
		eventParser(5035);
	}
	//(else if not visibly pregnant F or H)
	else {
		//hymen check]
		cuntChange(15,false,false,false);
		outputText("The heat in your [vagina] is the first thing to stir you.  Your eyes open painfully, fluttering with each soft pulse of your head; it feels like an imp was set loose inside, covering your brain with thick jizz, but eventually you manage to focus and look down.  What greets you is the sight of ");
		if(player.hasCock()) outputText(sMultiCockDesc() + " bobbing up and down, drooling pre-cum, as ");
		outputText("your red, sore pussy is pounded viciously by a thick cock dotted with scales.  Below it dangles a pair of swollen balls, bouncing as the shaft is thrust into you; with an inkling of understanding, you look back to confirm your suspicion.  Sure enough, you're mounted atop the table-bound salamander from before, who grunts as he pushes into you.  The hot cock, hotter than your body, slides in with a sizzle, and some of your juices roll down the shaft, only to evaporate when they hit the salamander's flaming, iron-bound tail.  Your own limbs are chained to the table via a massive iron ring and Brigid stands in front of you, watching you expectantly; behind her are arranged a score of assorted harpies and surviving phoenixes in various stages of coitus.");
		
		outputText("\n\nIt takes you a while to realize that the gasps you're hearing aren't all coming from you and the rabble; you turn your head to the table next to you, upon which is strapped Hel.  The woman is restrained much the same way as your salamander, except her legs are spread wide open, displaying her pussy for all to see, and an additional iron mask completely covers her face.  Atop Hel sits Kiri, the little orange-feathered harpy from before, grinding her feathery pelvis into Hel's.  \"<i>S-sorry dad; [name],</i>\" Kiri says, wincing as she notices your stare.  \"<i>Just... try to... t-to hold on!</i>\"  She reclines and pulls away from Hel, and for the first time you can see what she's grinding on; a small, orange-scaled dick is jutting fron Hel's crotch!  Kiri moans as she stirs her pussy with it, throwing her hips upward to reveal that she, too, sports a brand-new, oozing penis.");
		
		outputText("\n\n\"<i>Talk less, fuck more!</i>\" howls Brigid, striking Kiri across the shoulders.  \"<i>Our queen is gone, and the burden falls on </i>us<i> to repopulate our ranks!  Be glad I consider you worthy enough to use your seed, little half-breed!  Whether it's salamanders, phoenixes, or weak fodder like you, you </i>WILL<i> reproduce!</i>\"");
		
		outputText("\n\nAs Brigid turns away, Kiri scowls and leans forward again, pressing her modest breasts against her lover's and whispering something to the masked Hel, who nods and begins thrusting vigorously.  The sight returns your attention to the cock in your own [vagina], and your head rolls back as the salamander under you fucks faster, drawing closer to orgasm.  His thick, rough prick scrapes your walls angrily, the little lubrication you can generate overtaxed as it tries to cope with his sweltering body heat and the blistering pace of the sex.");
		
		outputText("\n\nA muffled cry comes from the table beside you, as Hel achieves climax and buries her new dick as deeply into Kiri as she can.  As her body convulses, you can see her pussy squeezing out strings of white seed to drool between her legs - likely Kiri's, as the little harpy blushes when she notices the oozing mess over her shoulder.  The room is filled with the smell of semen as the goo hits Hel's tail and begins to bubble, and Kiri lets out a cry as well, falling backward onto her outstretched hands as her hips shake; a little squirt of cum lances from her cock, to land on Hel's tits.  \"<i>F-fuck yeah, fertilize me!  Paint my eggs with your sperm!</i>\" Kiri shouts in ecstasy, proving that she's still a harpy after all.");
		
		outputText("\n\nThe dick in you twitches and a flood of painful warmth in your own womb tenses your body; you slide partway off of the shaft in agony, and you can see the man's wrists straining against his bonds, trying to break free so he can pull you back down.  He roars in frustration as you expose more than half of his cock to the air trying to get away from the intensely hot seed, but there's not enough slack in your bonds, and he finishes inside you, leaving your [face] tear-stained and pinched.  Brigid takes your chin in her hands.");
		
		outputText("\n\n\"<i>Aww, didn't come yet?  Too bad.  There's only one use for a trash " + player.race() + " like you, anyway,</i>\" your jailer coos sweetly, caressing your " + player.skin() + ".  \"<i>You're going to make me more salamanders, so... better luck next time!</i>\"  She unfastens your chains from the loop on the table, violently dragging you clear and covering your [butt] in the scalding seed pouring out of you.  \"<i>I don't care what you bitches do with this one,</i>\" Brigid says, yanking you toward the ongoing harpy orgy, \"<i>just don't ruin her.  That breeding stock on the table won't last much longer once we start to make up for the soldiers we lost, and we might be able to get a replacement out of her womb.  And don't fucking bother me, I need to go over mom's notes and figure out how she was making the phoenixes!</i>\"");
		
		outputText("\n\nWith a shove from the pink-haired jailer, you're tumbled into a pair of lovers; the phoenix stops groping the harpy's tits to wrap her arm around you and pull you to the floor, and no sooner are you laid down than the harpy's stretched, semen-stuffed pussy is atop your mouth, grinding into your face and drooling warm phoenix seed down your throat");
		if(player.hasCock()) outputText(" as the phoenix's cunt slides onto your [cock smallest]");
		outputText(".  Brigid makes her way up the stairs, leaving you and the others at the mercy of the assorted horde.  The harpy rides your mouth greedily, knocking your head into the hard stone floor, and the last thing you can see around her feathery thighs before you slip into unconsciousness again is Kiri being pulled roughly from her resting place atop Hel by a mean-looking, wide-hipped harpy matron who takes her place, sitting sideways and drawing her talons sadistically across Hel's vulnerable chest to smear Kiri's seed around...");
		//[GAME OVER, MOTHERFUCKER]
		eventParser(5035);
	}		
}

//[Torture Gear]
function tortureGear():void {
	clearOutput();
	var whip:Number = 0;
	var straps:Number = 0;
	var dagger:Number = 0;
	outputText("You walk up to the torture rack.  ");
	if(flags[HEL_DUNGEON_TAKEN_WHIP] == 0 || flags[HEL_DUNGEON_TAKEN_STRAPS] == 0 || flags[HEL_DUNGEON_TAKEN_DAGGER] == 0) {
		outputText("The rack contains: ");
		if(flags[HEL_DUNGEON_TAKEN_WHIP] == 0) {
			outputText("A whip");
			whip = 11107;
		}
		if(flags[HEL_DUNGEON_TAKEN_STRAPS] == 0) {
			if(flags[HEL_DUNGEON_TAKEN_WHIP] == 0) outputText(", ");
			outputText("some leather straps");
			straps = 11108;
		}
		if(flags[HEL_DUNGEON_TAKEN_DAGGER] == 0) {
			if(flags[HEL_DUNGEON_TAKEN_STRAPS] == 0 || flags[HEL_DUNGEON_TAKEN_WHIP] == 0) outputText(", ");
			outputText("a lust-draft coated dagger");
			dagger = 11109;
		}
		outputText(".  ");
	}
	//(PC can take a Succubus Whip, Bondage Straps, and a Lust Dagger)
	simpleChoices("Succ. Whip",whip,"BondageStraps",straps,"Lust Dagger",dagger,"",0,"Back",1);
}

//[Prisoner] (First Time)
function helDungeonPrisonerTalk():void {
	clearOutput();
	if(flags[HEL_PC_TALKED_WITH_HAKON] == 0) {
		outputText("You approach the Salamander strapped to the table.  He looks at you with his one good eye, warily gauging you as you approach.");
		outputText("\n\n\"<i>Well, aren't you a sight for sore eyes,</i>\" he laughs, his voice little more than a rasp.  \"<i>About time somebody put a boot up that punk bitch's ass.  Ha!  Hey, the name's Hakon.  I'd shake your hand, but, uh, I'm a bit tied up at the moment as it were.  So, what brings an outsider all the way up here?</i>\"");
		outputText("\n\nYou tell him that you're here to rescue him as it happens.");
		outputText("\n\n\"<i>What!?</i>\" he says, wide-eyed.  \"<i>Hey, I'm not complaining, mind you, but pardon me for being surprised.  I've been locked up in this shithole for... Marae, must have been fifteen, twenty years now.  Why now?  Who sent you?  My wife?</i>\"");
		outputText("\n\nYou shake your head and tell him that it was Helia who sent you.");
		outputText("\n\n\"<i>H... Helia? My little Hel?</i>\" he asks in disbelief. With a slight grin, you tell him that 'little' Hel isn't so little anymore.  He laughs, but for an instant you think he might be about to cry.  \"<i>Of... of course she is.  My little girl's all grown up.  Oh, what I wouldn't give to meet her...</i>\"");
		outputText("\n\nYou tell him that she's not far away at all... just a few floors up, in fact.");
		outputText("\n\n\"<i>WHAT!?</i>\" He yells, straining against the chains that bind him.  \"<i>You brought Hel here!?  What were you thinking?  Go and get her out of here.  NOW!</i>\"");
		flags[HEL_PC_TALKED_WITH_HAKON] = 1;
	}
	//[Prisoner] (Repeat)
	//[IF PC HAS HARPY KEY A & B]
	else if(player.hasKeyItem("Harpy Key A") >= 0 && player.hasKeyItem("Harpy Key B") >= 0) {
		outputText("You smile as you approach Hakon the Salamander.  He starts to yell at you again, but you snap at him to hush.  You explain that Hel and Kiri are waiting outside and that the broodmother has been defeated.  Both sets of keys jingling in your hands.  He watches you approach silently, his eyes wary but hopeful.  You quickly undo his bonds, freeing him for the first time in years.  He struggles to sit, but nearly collapses. You catch him before he hurts himself and, throwing his arm over your shoulder, help the old salamander toward the stairs...");
		//(Go to DUNGEON END scene)
		doNext(11131);
		return;
	}
	//[Else]
	else {
		outputText("You approach Hakon the Salamander.  He strains against his bonds, yelling at you to get Hel and get out before it's too late.  You roll your eyes and carry on.");
	}
	doNext(1);
}


//ATTACK ONE: SPARTAN RUSH
function phoenixPlatoonRush():void {
	outputText("You fall back under a hail of scimitar attacks.  The sheer number of phoenixes attacking is bad enough, but their attacks are perfectly coordinated, leaving virtually no room for escape or maneuver without getting hit!\n");
	//(Effect: Multiple medium-damage attacks)
	//(Effect: Multiple light attacks)
	monster.createStatusAffect("attacks",2+rand(3),0,0,0);
	eAttack();
	combatRoundOver();
}

//ATTACK TWO: FIRE BREATH
function phoenixPlatoonFireBreath():void {
	outputText("Suddenly, the shield wall parts, revealing a single member of the platoon, a particularly muscular girl with a raging erection.  Before you can consider what's going on, she rears back and huffs at you.  To your horror, a great gout of fire erupts from her mouth, rolling towards you.  You dive, but are still caught partially in the inferno.");
	//(Effect: One heavy-damage attack)
	var damage:Number = 100 + rand(50);
	damage = takeDamage(damage);
	outputText(" (" + damage + ")");
	combatRoundOver();
}
//ATTACK THREE: LUSTBANG GRENADE
function phoenixPlatoonLustbang():void {
	outputText("\"<i>LUSTBANG OUT!</i>\" one of the rear-most phoenixes shouts, causing all the other warriors to duck down behind their shields.  Oh, shit!  A large glass sphere rolls out from the shield wall, and immediately explodes in a great pink cloud.  You cough and wave your arms, but by the time the cloud has dissipated, you feel lightheaded and lusty, barely able to resist the urge to throw yourself at the phoenixes and beg for their cocks and cunts.");
	//(Effect: Large lust increase)
	stats(0,0,0,0,0,0,40,0);
	combatRoundOver();
}

function phoenixPlatoonAI():void {
	if(monster.hasStatusAffect("platoon") < 0) {
		phoenixPlatoonRush();
		monster.createStatusAffect("platoon",0,0,0,0);
	}
	else if(monster.statusAffectv1("platoon") == 0) {
		phoenixPlatoonFireBreath();
		monster.addStatusValue("platoon",1,1);
	}
	else {
		phoenixPlatoonLustbang()
		monster.removeStatusAffect("platoon");
	}
}

//Phoenix Platoon -- PC is Defeated
function phoenixPlatoonMurdersPC():void {
	clearOutput();
	outputText("You collapse, too ");
	if(player.lust > 99) outputText("turned on");
	else outputText("badly injured");
	outputText(" to continue the fight.  The platoon of heavy infantry breaks their formation, circling around you with shields still raised, keeping you from making any kind of last-ditch attack.  One prods you with the flat of her blade.  \"<i>Is " + player.mf("he","she") + " down?</i>\"");

	outputText("\n\n\"<i>Yeah,</i>\" another says. \"<i>This one's a goner. Let's bring " + player.mf("him","her") + " up to mom.</i>\"");
	//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
	doNext(11117);
}

//Phoenix Platoon -- PC is Victorious
function phoenixPlatoonLosesToPC():void {
	clearOutput();
	outputText("With one final grunt, the last of the phoenixes collapses onto the pile of defeated warriors you've left in your wake.  The once-mighty platoon of soldiers has been reduced to a bruised, lusty heap of flesh, scales and feathers.  Seeing that the battle is won, you lower your [weapon] and take a look around.");
	flags[HEL_PHOENIXES_DEFEATED]++;
	eventParser(5007);
}

//[Phoenixes]
function checkOutDemBirdBitches():void {
	clearOutput();
	outputText("You loom over the defeated heavy infantry, marveling at them.  The half-breeds were probably the most organized and efficient fighting unit you've ever come across here in Mareth, and though you defeated them, you know most denizens of the region wouldn't have stood a chance.");
	var missionary:Number = 0;
	var wanked:Number = 0;
	var rideAnal:Number = 0;
	var rideVaginal:Number = 0;
	if(player.lust > 33) {
		outputText("\n\nYou suppose you could use one of them to get yourself off.");
		//(Display Options:
		//If Male: [Missionary] [Get Wanked] [Ride Anal] (Capacity: 80)
		if(player.hasCock()) {
			if(player.cockThatFits(80) >= 0) missionary = 11112;
			else outputText("\n\nYou're too big to fuck one of them properly.");
			wanked = 11113;
		}
		if(player.hasVagina()) rideVaginal = 11115;
		//If Female: [Ride Vaginal] [Ride Anal]
		//If Genderless: [Ride Anal]
		rideAnal = 11114;
	}
	choices("Missionary",missionary,"Get Wanked",wanked,"Ride Anal",rideAnal,"Ride Vaginal",rideVaginal,"",0,"",0,"",0,"",0,"",0,"Back",1);
}

//Phoenixes -- [Missionary]
function phoenixMissionary():void {
	clearOutput();
	var x:Number = player.cockThatFits(80);
	if(x < 0) x = player.smallestCockIndex();
	var y:Number = x + 1;
	outputText("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\" Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath.  The phoenix gasps at the sudden exposure and turns her head away, fixing her expression in place like chiseled marble, determined not to look you in the eye as you take your pleasure.");

	outputText("\n\nYou grab her legs and force them apart, revealing her slick pussy and half-rigid cock, surprisingly aroused for someone who seems insistent on not enjoying herself.  You slip a hand into her soaking twat, letting a pair of fingers slither inside her. She groans, gritting her teeth as you go deeper and deeper inside her.  With a grin, you pull out and force those same fingers into her mouth.  Wide-eyed, she sputters and shakes her head, but you don't let up until she's had a good, long taste.");

	outputText("\n\nYou chide her, telling her that if she doesn't want it so much, why is she so wet?");

	outputText("\n\n\"<i>I-I am not! It's natural!</i>\"");

	outputText("\n\nOh, really? Is she sure she doesn't just want your cock?");

	outputText("\n\n\"<i>I... well... maybe...</i>\" she admits, and you nod as her once-struggling legs go a bit limp.");

	outputText("\n\nYou return your attention to between her legs.  Getting her fully erect reptilian cock out of the way, you expose your prize - her sodden cunt");
	if(player.cockTotal() > 1) outputText(" and the tight ring of her pucker");
	outputText(".  You grasp her wide flanks and, lining your [cock " + y + "]");
	if(player.cockTotal() > 1) outputText(" and extra boner up with her holes");
	else outputText(" up with her hole");
	outputText(", push in, penetrating her cunt");
	if(player.cockTotal() > 1) outputText(" and ass");
	outputText(" and sliding into her warm, wet channel");
	if(player.cockTotal() > 1) outputText("s");
	outputText("."); 

	outputText("\n\nThe phoenix squirms as you push into her depths, groaning as more and more of your cockmeat pierces her until you finally hilt her.  Gritting her teeth, the phoenix reaches up and grabs your shoulders, holding onto you as your cock");
	if(player.cockTotal() > 1) outputText("s drive");
	else outputText(" drives");
	outputText(" into her; you roll your hips back and forth for short but powerful strokes into her blazing hot innards.  As the pace picks up, you pull the phoenix-girl into a long, tender kiss.  The kiss soon turns into her moaning into your mouth as you fuck her cunt ");
	if(player.cockTotal() > 1) outputText("and ass ");
	outputText("hard, slamming your hips into hers.");

	outputText("\n\nShe cums first");
	if(player.cockTotal() > 1) outputText(", your double penetration too much for her to handle");
	outputText(".  The phoenix grips your shoulders tight enough for her claws to cut into you as her tight pussy ");
	if(player.cockTotal() > 1) outputText("and tighter sphincter spasm");
	else outputText("spasms");
	outputText(" around your dick");
	if(player.cockTotal() > 1) outputText("s");
	outputText(".  With her squirming in your embrace and squeezing down so hard, you can't help but blow your load.  You press your lips hard into hers and cum, pumping thick ropes of steaming jizz into her wet box");
	if(player.cockTotal() > 1) outputText(" and hot asshole");
	outputText(".  As you cum into her, you feel her reptile prick shoot off, squirting a long white rope onto her chest and yours until her tits are soaked with her spunk.");

	outputText("\n\nYou release the phoenix from your embrace, and are pleased to see she's passed out from the overwhelming pleasure.  Grinning, you pull your cock");
	if(player.cockTotal() > 1) outputText("s");
	outputText(" out of her ravaged hole");
	if(player.cockTotal() > 1) outputText("s");
	outputText(" and gather your gear.");
	//(Return to Mezzanine main menu)
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

//Phoenixes -- [Get Wanked]
function phoenixWanking():void {
	var x:Number = player.biggestCockIndex();
	var y:Number = x + 1;

	clearOutput();
	outputText("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\"  Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath.  The phoenix gasps at the sudden exposure and turns her head away, determined not to look you in the eye as you take your pleasure.  You grope one of her breasts roughly, pinching the nipple between your fingers until she's whimpering with pain and pleasure.  You let up for just a moment and tell the girl that she's going to get you off with her special endowments, or you're going to put her in a world of hurt.");

	outputText("\n\nWith a groan, she nods her head.  You release her sensitive breast and present your [cock " + y + "].  Reluctantly, the phoenix-girl brings her fiery tail around and, extinguishing it, begins to snake it around your prick.  You urge her on as she wraps her long, prehensile appendage around your shaft, wringing it like a sponge as her tail's grip tightens.  You run your hands through the girl's bright red hair, stroking her gently as she starts to jerk your [cock " + y + "] off with her tail.");

	outputText("\n\nIt feels heavenly, and you shudder with delight as her warm, scaly tail rubs and strokes and squeezes you... But it isn't quite enough, not with so many other parts of her left!  You push her looped tail off the tip of your [cock " + y + "] and tell the phoenix to put her soft, feathery red wings to good use.  She gawks at you, but a quick grope of her tits urges her to the task.  She furls her auburn wings around her shoulders, letting the fringes stroke and caress the sensitive [cockHead " + y + "] of your cock.  You barely contain yourself at the downy touch of her feathers along your [cock " + y + "]'s head and length, and urge her onwards with encouraging words and more gentle, loving squeezes and teases of her lush tits.");

	outputText("\n\nYou notice that by now the phoenix-girl is openly fingering herself.  You continue to run your fingers through her hair, whispering encouragements and sweet nothings at her as she continues to squeeze and gently caress your [cock " + y + "].  You feel your orgasm coming, and quickly grab the phoenix by the shoulders and push her forward, forcing her to take your cockhead into her mouth as you cum.");

	outputText("\n\nYour [cock " + y + "] explodes, pumping a thick load into the shocked phoenix's mouth.  She gags on your cum, finally swallowing it as the last of your sperm drips into her mouth.  With a grin, you tell her what a good job she did as you withdraw your [cock " + y + "]  from her grip.  With little rivulets of cum dripping down her face, the half-breed collapses onto her back, rapidly fingering herself.");
	//(Return to Mezzanine main menu)
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}
	
//Phoenixes -- [Git Butt-rode]
function gitButtRoadPhoenix():void {
	clearOutput();
	outputText("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\" Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath. The phoenix gasps at the sudden exposure and turns her head away, determined not to look you in the eye as you take your pleasure.  Gripping the warrior by her hefty boobs, you tell the phoenix that it's her lucky goddamn day: you're going to let her fuck your ass.");

	outputText("\n\nThe phoenix stares up at you with a mix of eagerness and caution.  \"<i>Wait... you're gonna let me... do that? Really?</i>\"");

	outputText("\n\nYou nod.");

	outputText("\n\n\"<i>Uh, well... okay, then. If that's what you want....</i>\"");

	outputText("\n\nYou quickly discard your [armor] and, pushing the girl back onto her back, squat over your prize.  You wrap your hand around her stiff lizard prick and start to stroke it, running your hand along her bulbous purple shaft.  The phoenix makes a pleasured gasp as you start to jerk her off, idly playing with her lush tits or slick pussy as you stroke her to full hardness.");

	outputText("\n\nOnce you're satisfied that she's completely rigid, you shift your [hips] so that your [asshole] is hovering over the phoenix's thick twelve-incher.  You allow her to put her hands on your hips and guide you down, until you can feel her narrow head pressed against your backdoor.  Biting your lip to stifle a cry of pain and pleasure, you do the honors, guiding her wide prick to slip past your relaxed sphincter and into your bowels.");
	buttChange(30,true,true,false);

	outputText("\n\nYou grunt as she bottoms out inside you, leaving you with a feeling of intense fullness and warmth, grinning down at the phoenix-girl and pleased to see the look of rapture on her face as your ass muscles squeeze down on her stiff lizard-cock.  You feel her hands digging into your [hips], and in return you give her soft breasts a playful squeeze.  You start to rock your hips, letting an inch or two of her dick spill out of you before your stretched [asshole] sucks it back up.");

	outputText("\n\nSurprisingly, the phoenix-girl shifts her hands from your hips to your shoulders and pulls you down on top of her, pushing your face into her pillowy breasts.  Before you can chastise her, your lover slams her cock into you, making you scream with pleasure into her soft flesh.  Grinning, she wraps her wings, legs, and tail around you, completely immobilizing you as she starts to hammer your ass, pistoning her cock in and out of you.");

	outputText("\n\nHelpless under the phoenix's surprise attack, you can do little more than grit your teeth and let the pleasure take you.  You return her embrace, taking one of her nipples into your mouth to play with as she fucks you raw.  You can feel an anal orgasm mounting and quickly try to relax yourself, letting in more and more of her cock until she is again hilting you, her hips slamming into your [butt].");

	outputText("\n\nUnable to hold on for long, you bite down on her pink nipple and cum, letting waves of pleasure wash over you from your rectal intruder.  Your sphincter clamps down hard on the lizard prick inside you, milking it just like a pussy would until, spurred on by your orgasm and bite to her most sensitive flesh, the phoenix-girl cums.  You yelp as her burning-hot cum rushes into your ass, scalding your walls until you feel a massive wave of pleasure crash into you - a second orgasm! Your mind goes utterly numb, nearly blacking out as tremors of ecstasy pump into you from her dick.");

	outputText("\n\nWhen you come to your senses a few minutes later, the phoenix-girl is asleep, still holding you tight.  You pull her deflated lizard dick out of your ass and shudder as a torrent of her sizzling hot spunk dribbles out onto her thighs and hips.  You wriggle out of her tight embrace and give her a little kiss on the cheek before collecting your [armor] and heading out.");
	//(Return to Mezzanine main menu)
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

//Phoenix -- [Ride Vaginal]
function phoenixAginal():void {
	clearOutput();
	outputText("You grab the healthiest looking phoenix off the top of the pile and throw the hermaphrodite on her back a few feet from her sisters.  She grunts, looking up at you with grim, fierce eyes.  \"<i>I'll never submit!  I am a proud warrior, not some-</i>\"  Yeah, whatever.  You rip her chain shirt open, revealing the large, soft globes of her D-cups beneath.  The phoenix gasps at the sudden exposure and turns her head away, determined not to look you in the eye as you take your pleasure.  You ignore her temporary defiance and grab her cock.");

	outputText("\n\n\"<i>Heeeey,</i>\" the phoenix whines squirming to get out of your grip.");

	outputText("\n\nYou maintain your grasp on her long, purple lizard dick and tell her that you're doing her a favor: you're going to let her fuck your [vagina].  She stops struggling at the invitation.");

	outputText("\n\n\"<i>Oh. Well,</i>\" she says, smirking slightly.  \"<i>If you want a bit of phoenix seed... I guess I wouldn't mind a chance at being a daddy.</i>\"");

	outputText("\n\n");
	//[If Broodmother, not pregnant: 
	if(player.hasPerk("Broodmother") >= 0) outputText("You assure her she will be soon");
	else outputText("You grin at her");
	outputText(" and strip out of your [armor]. The phoenix, a bit more dominant than you might have liked, roughly grabs your [chest], pinching your nipples as she takes over wringing her cock from you. Oh well. You decide to roll with it and slide a hand down to your [vagina], stroking your pussy as your lover warms up.");

	outputText("\n\nWhen she's nice and hard, you give the phoenix a little push onto her back and clamber into her lap, lining her lizard prick up with your [vagina].  Before you can get properly situated, though, the girl pulls you down onto her cock, impaling you up to her hilt in one massive thrust.  You roll your head back and scream, a mix of pleasure and burning pain shooting through you as her white-hot rod slams into your innermost depths.");
	cuntChange(12,true,true,false);

	outputText("\n\nBy the time you're somewhat recovered from her surprise attack, the phoenix-girl has started rocking her hips into yours, grinding her long prick into you.  You give her hefty tits a rough squeeze and push her back down, holding her down by her mammaries as you start to ride her cock.  Having gotten her thrill, the phoenix-girl submits to you, only venturing to hold onto your [hips] as you fuck her.  For your part, you bask in the sensation of her thick dick sliding in and out of your well-lubricated depths, rubbing and stroking your sensitive inner walls with its bulbous length."); 

	outputText("\n\nNow that you're into the swing of things, you give your phoenix lover a hand up, pulling her into a sitting position and burying her face into your [chest].  She struggles for a moment but, after seeing how nice cuddling against your warm flesh is, she relaxes into your embrace.  You start to bounce on her cock, smushing her face into your breasts at the apex of each bounce, and slamming her prick deep inside you as you fall.");

	outputText("\n\nUnable to take the cumulative pleasure, the phoenix cums.  You go wide-eyed as her burning hot cum pours into your waiting womb, scalding your depths with her sizzling, potent seed.  You can only keep riding her, letting her jizz flow into you until the heat and pleasure sends you over the edge too.  You hug the phoenix tight as orgasm hits you, shuddering and gasping as ecstasy threatens to overwhelm you.  Your [vagina] milks your lover for every last drop until, breathless, you release your death-hold on your lover, letting her flop, insensate, to the ground.");

	outputText("\n\nYou stand, a bit bow-legged, and watch as a bucket's worth of her extra seed pours out of your sodden twat, pooling on the phoenix's breasts and belly.  Giggling, you stumble off her and collect your [armor].");
	player.knockUp(5,120,100);
	//v1 = egg type.
	//v2 = size - 0 for normal, 1 for large
	//v3 = quantity
	player.createStatusAffect("eggs",rand(6),0,(5+rand(3)),0);
	//(Return to Mezzanine main menu)
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

function harpyQueenAI():void {
	if(rand(4) == 0) eldritchRopes();
	else if(rand(2) == 0) lustSpikeAttack();
	else windSlamAttack();
}
//ATTACK ONE: ELDRITCH ROPES
function eldritchRopes():void {
	outputText("The Harpy Queen flicks her left wrist at you. Before you can blink, ropes of white-hot magic hurtle toward you. You manage to duck and dodge a few of them, but a pair still grab your wrists, pulling painfully at your arms.");
	//(Effect: Grab + Physical Damage)
	var damage:int = 25 + rand(10);
	damage = takeDamage(damage);
	outputText(" (" + damage + ")");
	monster.createStatusAffect("QueenBind",0,0,0,0);
	combatRoundOver();
}

function ropeStruggles(wait:Boolean = false):void {
	clearOutput();
	//Struggle Fail: 
	if(rand(10) > 0 && player.str/5 + rand(20) < 23 || wait) {
		outputText("You give a mighty try, but cannot pull free of the magic ropes!  The Harpy Queen laughs uproariously, pulling at your arms harder.");
		var damage:int = 25 + rand(10);
		damage = takeDamage(damage);
		outputText(" (" + damage + ")");
	}
	else {
		outputText("With supreme effort, you pull free of the magic ropes, causing the queen to tumble to her hands and knees.");
		monster.removeStatusAffect("QueenBind");
	}
	combatRoundOver();
}

//ATTACK TWO: LUST SPIKE
function lustSpikeAttack():void {
	outputText("The Harpy Queen draws a strange arcane circle in the air, lines of magic remaining wherever the tip of her staff goes.  You try to rush her, but the circle seems to have created some kind of barrier around her.  You can only try to force it open - but too late!  A great pink bolt shoots out of the circle, slamming into your chest.  You suddenly feel light-headed and so very, very horny...");
	//(Effect: Heavy Lust Damage)
	stats(0,0,0,0,0,0,40,0);
	combatRoundOver();
}

//ATTACK THREE: Wind Slam!
function windSlamAttack():void {
	outputText("The queen swings her arm at you and, despite being a few feet away, you feel a kinetic wall slam into you, and you go flying - right into the harpy brood!  You feel claws, teeth and talons dig into you, but you're saved by a familiar pair of scaled arms.  \"<i>Get back in there!</i>\" Helia shouts, throwing you back into the battle!");
	//(Effect; Heavy Damage)
	var damage:Number = 100 + rand(50);
	damage = takeDamage(damage);
	outputText(" (" + damage + ")");
	combatRoundOver();
}

//HARPY QUEEN -- PC DEFEATED
function harpyQueenBeatsUpPCBadEnd(clearS:Boolean = false):void {
	if(clearS) clearOutput();
	//(Go to \"<i>Harpy Breeding Slut</i>\" Bad End)
	//HARPY BREEDING SLUT BAD END
	outputText("You collapse in front of the Harpy Queen, sitting upon her throne.  She isn't particularly tall or menacing looking, but her hips are truly inhuman, thrice as wide as she is at the least, and her pillowy ass, seated upon her cushions, seems canyon-like in her nudity, the type of butt you could lose yourself in forever.  The harpy matron wields a tall whitewood staff, held in the crook of her arm.");
	outputText("\n\n\"<i>Well, well, what do we have here?</i>\" the harpy croons, licking her lips as she stares down at you.  Defeated, you are utterly helpless.  A pair of her brood step from the shadows and bind you, tying your arms and [legs] in thick leather straps.");
	outputText("\n\n\"<i>So, an interloper wanders into my nest.  Tell me, fool, are you working for the demons?  Surely you must be.  No one else would dare come here...</i>\"");
	outputText("\n\n\"<i>Mother!</i>\" a harpy calls, stepping up to the throne. Behind her come another dozen sisters, struggling to keep Hel bound between them.  The salamander screams and curses and cries, but it is useless - she cannot escape, any more than you can.  Hel is pushed down onto her knees beside you, still defiant, but, at seeing you already captured... the fight goes completely out of her eyes.");
	outputText("\n\n\"<i>Ah, another salamander?  Well well, what a coincidence.  I don't believe our other specimen is going to last much longer.  You seem a healthy girl; with a bit of... modification... you'd make a fine replacement.</i>\"");
	outputText("\n\n\"<i>And you,</i>\" the queen says, looking back to you.  \"<i>I could always use another ");
	if(player.hasCock()) outputText("sperm bank");
	else outputText("incubator");
	outputText(" in my harem.  Yes, you'll do nicely...</i>\"");
	outputText("\n\n<b>SIX MONTHS LATER...</b>\n");
	outputText("You groan, your wrists chafing in the manacles hanging overhead.  The harpy slut riding your huge, engorged dick crosses her eyes, screams, and cums.  Another wave of seed lurches out of your cripplingly-large balls, so massive that they drag on the floor between your [legs].  You shudder slightly, but the act of ejaculation has lost all meaning");
	if(!player.hasCock()) outputText(", even if the sudden new sensations nearly broke your mind when the harpies used their magics to grow these huge male implements on your body");
	outputText(".  Indeed, as soon as that slut's gotten her fill, one of her sisters pushes her roughly off your shaft and mounts you, bending over and backing into your massive schlong.  A little shudder of pleasure courses up your body as the twenty-ninth slut you've serviced today starts to milk you for your magically-enhanced seed.  The tubes pumping enchanted drugs directly into the flesh of your testes goes into overtime, flooding your system with lust and the strange concoction that creates the Phoenixes.");
	outputText("\n\nYou slump as another orgasm plows through you, swelling the harpy's womb until she looks nine months pregnant.  You barely feel it, though your skin flushes hotly as the woman plants a lust-stick kiss on your lips in thanks... Another salamander male was what the Queen needed; you weren't it, but with Hel and the captive that turned out to be her father around, she found use for you, too: breeding harpies to continue her bloodline while the phoenixes go off to war against the demons.");
	outputText("\n\nYou gaze across the subterranean breeding chamber, over tables and toys covered in gallons of spent semen, to where Helia and Hakon the salamanders are chained.  Hakon has long since passed out, his age and years of abuse weakening him to the point where he can only function a small part of the day.  Beside him, though, Hel is awake and kicking, struggling futilely under the huge girth of the Harpy Queen's hips which pin her to the wall in place of chains.");
	outputText("\n\nHel cries out, a full-body orgasm rocking through her tall frame, ending in the magically-endowed pecker between her legs, just like yours, buried to the hilt inside the broodmother harpy.  The Queen coos, rubbing the gaping hole of her twat as a waterfall of salamander cum oozes out of her, pooling on the floor with the leavings of the last dozen of Hel's orgasms.  Despite the orgasm subsiding from your once-lover, the Harpy Queen remains firmly impaled on Hel's giant wang, grinding her hips around in wide circles, her breeding tunnel slurping up every drop of salamander sperm it can.  Finally, she pulls herself off in a long, languid motion, slowly working off the cunt-stretching tool inside her until it flops groundward, still leaking a tiny dribble of cum.  Eagerly, a half-dozen lesser harpies jump toward Hel's used cock, lapping up the leftovers from the Queen's use in hopes of birthing a phoenix of their very own.");
	outputText("\n\nThe Harpy Queen stretches her wings wide as she steps away from Hel, now already being mounted by one of the Queen's daughters, and saunters over to you, salamander seed still freely leaking from her gaping egg-hole. She cups your cheek, sliding her long fingers across your sensitive, thoroughly drugged skin. Your entire body tingles as she smiles upon you, barely aware of the half-dozen sluts slurping at your spent seed as one of her daughters forces herself onto your enhanced member.");
	outputText("\n\n\"<i>You've been a good stud since you came to me, [name],</i>\" the Queen laughs airily, patting your swollen nuts.  \"<i>The size of my brood has quadrupled since you and Hel 'volunteered' to help us.  Mmm, a free Mareth will surely have you to thank for the army that will liberate it from the demons.  You might even be something of a hero, if you want. The Champion of Free Mareth, if you will.  That wouldn't be so bad, would it?  After all, that's why you came here...</i>\"");
	outputText("\n\nBefore you can respond, another orgasm washes over you, and a huge load of seed explodes into the thirty-first slut to claim your seed today.  And over her shoulders, you can see dozens more harpies, half of them your own spawn, waiting their turn.");
	eventParser(5035);
}

//HARPY QUEEN -- PC VICTORIOUS
function harpyQueenDefeatedByPC():void {
	clearOutput();
	outputText("With a final, loud gasp, the Harpy Queen collapses into her throne, unable to oppose you further.  Seeing their broodmother defeated, the other harpies that had been swarming around the room suddenly break off their attack and retreat, edging back to the fringes of the throne room.  Behind you, Hel stumbles out of the melee, covered in little cuts and bruises, but seeming otherwise unhurt.");
	outputText("\n\n\"<i>Y-you'll ruin everything,</i>\" the Harpy Queen groans, trying futilely to stand.  Before she can recover, Hel walks over and plants her clawed foot right on the bitch's chest, pinning her down.  From a small hook on the side of the throne, you take her key-ring for the prisoner down below.");
	//(Acquired Key Item: \"<i>Harpy Key B</i>\")
	player.createKeyItem("Harpy Key B",0,0,0,0);
	flags[HEL_HARPY_QUEEN_DEFEATED] = 1;
	//(PC moves to Throne Room Main Menu:)
	eventParser(5007);
}

//Throne Room -- [Helia]
function HeliaThroneRoom():void {
	clearOutput();
	outputText("You turn your attentions to the salamander, who is currently pinning down the harpy bitch to prevent her from flying off or doing something drastic.");
	outputText("\n\n\"<i>Hey, [name],</i>\" Hel says as you approach.  She grabs you roughly by the [armor] and pulls you into a long kiss, only breaking it to wrap her arms and tail around you.  \"<i>Thank you, lover.  From the bottom of my heart.  I couldn't have done it without you.</i>\"");

	outputText("\n\nYou pat her on the head and tell her it was your pleasure.");

	outputText("\n\nShe grins.  \"<i>So, what's the plan, lover mine?  Teach this bitch a lesson she'll never forget?</i>\"");
	//(Display Options: [Hakon](if PC knows this) [Kiri] [Queen](If not dead/gone))
	var queen:Number = 0;
	if(flags[HARPY_QUEEN_EXECUTED] == 0) queen = 11122;
	var hakon:Number = 0;
	if(flags[HEL_PC_TALKED_WITH_HAKON] > 0) hakon = 11120;
	simpleChoices("Hakon",hakon,"Kiri",11121,"Queen",queen,"",0,"Back",1);
}

//Throne Room -- [Helia] -- [Hakon]
function heliaHakonTalk():void {
	clearOutput();
	outputText("You decide to tell Hel who, exactly, is chained up downstairs.  When you do, she simply stares at you, wide-eyed.");
	outputText("\n\n\"<i>Wha... what. No, that's not... It can't be...</i>\"");
	outputText("\n\nYou assure her that it's true. The salamander she came here to rescue is none other than father, Hakon.");
	outputText("\n\n\"<i>I don't believe it,</i>\" Hel says, rubbing at the corners of her eyes.  \"<i>I thought all these years... I was sure he was dead.  How... No.  It doesn't matter,</i>\" she says, turning to the broodmother beneath her.");
	if(flags[HARPY_QUEEN_EXECUTED] == 0) outputText("  \"<i>You're going to pay for what you did to my father, you bitch.  I promise you that.</i>\"");
	flags[HEL_KNOWS_ABOUT_HAKON] = 1;
	doNext(1);
}

//Throne Room -- [Helia] -- [Kiri]
function heliaKiriTalk():void {
	clearOutput();
	outputText("You ask Hel about the half-breed girl that helped the two of you find this place, and offered you information below.");
	outputText("\n\n\"<i>Oh! You met Kiri? That's great, [name].</i>\" With a little chuckle, Hel adds, \"<i>She's a cutie, isn't she?  Nice ass, too.</i>\"");
	outputText("\n\nYou smack your face with your palm and ask for something a little more concrete about her.");
	outputText("\n\n\"<i>Oh, right.  I met her a couple years back, when she was just a little shit.  Momma bird here hadn't quite gotten the phoenix formula down, I guess.  Anyway, some minotaur had gotten a hold of her, was gonna drag her back home and pump her full of minitaurs or whatever.  Probably 'cause she's so red, you know?  'Taurs hate that color for some reason.</i>\"");
	outputText("\n\n\"<i>So, I bopped the bull on the head and saved her.  More to keep down the 'taur population than actually help her, but hey.  She certainly appreciated it.  Been friends ever since.</i>\"");
	outputText("\n\nWith a knowing look, you ask if they're more than just friends.");
	outputText("\n\n\"<i>" + player.mf("Dude","Babe") + ", come on, you know me.  Give me SOME credit, will ya?  I'm not letting an ass like that go to waste.</i>\"");
	outputText("\n\nYou roll your eyes and laugh with her.");
	doNext(1);
}
//Throne Room -- [Helia] -- [Queen]
function heliaQueenTalk():void {
	clearOutput();
	outputText("You nod your head toward the great big-booty broodmother.  \"<i>Ah, the queen cunt herself,</i>\" Hel says ruefully, cracking her knuckles.  \"<i>We're gonna have some fun with you, little birdie...  Aren't we, [name]?</i>\"");
	outputText("\n\nYou ask Hel exactly what she thinks you ought to do with the 'queen cunt.'");
	outputText("\n\n\"<i>Well, we can start by me shoving my tail so far up her twat that she'll never have kids again.  That's a goddamn start.</i>\"");
	//[If PC has already told her about Hakon: 
	if(flags[HEL_KNOWS_ABOUT_HAKON] == 1) outputText("  \"<i>Maybe snap her neck afterwards.</i>\"");
	doNext(1);
}

//Throne Room -- [Harpy Queen]
function harpyQueenAdvantage():void {
	clearOutput();
	outputText("You loom over the defeated Harpy Queen, who squirms underneath Hel's foot on her chest.");
	outputText("\n\n\"<i>Fool!</i>\" she spits.  \"<i>Kill me and be done with it! I'll not be used by the likes of you, demon-lover!</i>\"");
	outputText("\n\nWhat.");
	//(Display Options: [Fuck Her] [Interrogate] [Kill Her] [Let Her Go])
	var fuck:Number = 0;
	if(player.lust > 33 && player.hasCock()) fuck = 11127;
	simpleChoices("Fuck Her",fuck,"Interrogate",11130,"Kill Her",11126,"Let Her Go",11123,"Back",1);
}

//Throne Room -- [Harpy Queen] -- [Let Her Go]
function letHarpyQueenGo():void {
	clearOutput();
	outputText("You tell Hel to let up. You're letting the bitch go.");
	outputText("\n\n\"<i>What.</i>\" Hel says, deadpan.");
	outputText("\n\n\"<i>Move your damn foot!</i>\"");
	outputText("\n\n\"<i>What's this?</i>\" the broodmother asks, \"<i>Mercy? Why?</i>\"");
	outputText("\n\nYou tell her that you're no demon-loving bastard. To prove it, you're going to let her go.");
	outputText("\n\n\"<i>Just... like that?</i>\"");
	outputText("\n\nJust like that.");
	outputText("\n\nYou nod for Hel to get off.  She does so grudgingly, letting the Harpy Queen stand and roll her shoulders, spreading her great wings wide.");
	outputText("\n\n\"<i>Hmm. You're a fool, Champion,</i>\" she says, \"<i>But perhaps I was wrong about you.  Come, my children!  We are leaving this place!</i>\"");
	//[If you told Hel about Hakon:]
	if(flags[HEL_KNOWS_ABOUT_HAKON] == 1) {
		outputText("\n\nThe harpies beat their wings and croon happily, eager to be away from you.  As the Harpy Queen is ready to take off, she gives you an appreciative nod, with what might have even been a smile.  It looks as though you've made a friend tod-- OH FUCK!");
		outputText("\n\nYou try and yell out, but too late. Hel has lunged forward and, grabbing the broodmother by the neck, spins around.  The sound of neck bones snapping echoes through the tower as the queen falls, hitting the floor with a wet thump.");
		outputText("\n\n\"<i>Bullshit,</i>\" Hel snaps, wringing the dead queen's neck under her arm.  The other harpies around you shriek in outrage, pain, and fear.  \"<i>Do you have ANY IDEA what this bitch did?  To my father--to me?  There was no fucking way I was going to just let her walk off.  No, [name]. No way.</i>\"");
		//(Display Options: [Forgive] [Berate])
		simpleChoices("Forgive",11124,"Berate",11125,"",0,"",0,"",0);
		flags[HARPY_QUEEN_EXECUTED] = 1;
	}
	//[Else; did not tell about Hakon]
	else {
		outputText("\n\nYou stand aside and watch the harpies beat their wings and croon happily, eager to be away from you.   As the Harpy Queen is ready to take off, she gives you an appreciative nod, with what might have even been a smile.  It looks as though you might have made a friend - or at least, lost an enemy.  With a wave, the Harpy Queen commands her children to fly!");
		outputText("\n\nShe turns to you, and says, \"<i>For better or worse, [name], we will meet again.</i>\"");
		outputText("\n\nWith that, the harpies take flight.");
		//(Return PC to Room Menu)
		doNext(1);
		flags[HARPY_QUEEN_EXECUTED] = -1;
	}
	stats(0,0,0,0,0,0,0,-5);
}

//Throne Room -- [Harpy Queen] -- [Let Her Go] -- [Forgive]
function harpyQueenLetHerGoForgive():void {
	clearOutput();
	outputText("You and Hel stare each other down, the dead harpy's body the only thing separating you.  Two dozen enraged harpies screech and caw around you, demanding justice for their fallen queen.");
	outputText("\n\n\"<i>Alright, Hel. Fine.</i>\"");
	outputText("\n\nHer eyes light up.  Not the reaction she was expecting, it seems.  \"<i>So... we're good?</i>\"");
	outputText("\n\nYou nod.");
	outputText("\n\nShe stands up from the body and wraps you in a tight hug. \"<i>...Thank you.</i>\"");
	outputText("\n\nYou pat Helia on the head and with a shout, tell the harpies to get lost.  They do so reluctantly, too afraid to fight you, but still outraged at the murder.  They take flight, hurtling out the hole in the ceiling crying curses and epitaphs behind them.");
	outputText("\n\n\"<i>Alright. You've got the key, so go break ");
	if(flags[HEL_KNOWS_ABOUT_HAKON] == 1) outputText("Dad ");
	else outputText("that poor salamander ");
	outputText("out of the dungeon.  I'll make sure the phoenixes and harpies don't give you two trouble on the way out.</i>\"");
	outputText("\n\nWith that, Hel trots out the door and down the stairs, leaving you alone in the room. You notice that the queen's staff has fallen beside her body.");
	//(Return to Room Menu)
	doNext(1);
}

//Throne Room -- [Harpy Queen] -- [Let Her Go] -- [Berate]
function harpyQueenLetHerGoBerate():void {
	clearOutput();
	outputText("You and Hel stare each other down, the dead harpy's body the only thing separating you.  Two dozen enraged harpies screech and caw around you, demanding justice for their fallen queen.");
	outputText("\n\n\"<i>Hel, what the fuck!?</i>\" you yell.  That was NOT okay--you told the bitch she could leave, and then Hel just MURDERS her; what the FUCK?");
	outputText("\n\n\"<i>Of course you wouldn't understand,</i>\" Hel snaps, dropping the dead queen as she stands.  \"<i>Your parents are probably safe and snug back in wherever the fuck you're from.  Me?  I had to live my whole life thinking my dad was dead; I had to watch a gang of gnolls drag my mother off to be raped to death.  Fuck you anyway, [name].  What do you know?</i>\"");
	outputText("\n\nBefore you can say another word, the salamander runs out the door, back downstairs.  Aw, shit.");
	outputText("\n\nYou notice the queen's staff has fallen beside her body.");
	//(Remove all options but [Go Downstairs]; add [Take Staff]); (Remove Kiri from Stairwell)
	flags[FOUGHT_WITH_HEL_IN_DUNGEON] = 1;
	doNext(1);
}

//Throne Room -- [Harpy Queen] -- [Kill Her]
function killHarpyQueen():void {
	clearOutput();
	outputText("You look from Hel to the Harpy Queen.  This bitch could have bred an entire army - and might try it again. You can't allow that.");
	outputText("\n\nYou reach down and, with one quick stroke, snap her neck.  It twists easily, no harder than popping the cork of a wine bottle.  The sound of bones breaking is drowned out by the screams of harpies, screeching and cawing in horror."); 
	outputText("\n\nHel blinks at you for a second, nods approvingly.  She turns to the aghast brood and shoos them off with her sword.  The winged bitches yell and curse, but don't dare to resist the two of you.");
	outputText("\n\n\"<i>Well then. I guess that's that, then,</i>\" Hel says, swinging her sword over her shoulder into its sheath.");
	outputText("\n\nYou nod your agreement.");
	outputText("\n\n\"<i>Alright. You've got the key, so go break ");
	if(flags[HEL_KNOWS_ABOUT_HAKON] == 1) outputText("Dad ");
	else outputText("that poor salamander ");
	outputText("out of the dungeon.  I'll make sure the phoenixes and harpies don't give you two trouble on the way out.</i>\"");
	outputText("\n\nWith that, Hel trots out the door and down the stairs, leaving you alone in the room. You notice that the queen's staff has fallen beside her body.");
	flags[HARPY_QUEEN_EXECUTED] = 1;
	//(Remove all options but [Go Downstairs]; add [Take Staff]) (Remove Kiri from Stairwell)
	doNext(1);
}

//Throne Room -- [Take Staff]
function takeQueensStaff():void {
	clearOutput();
	outputText("You pick up the Harpy Queen's staff.  It is a tall whitewood staff, nearly six feet in length, and covered in glowing eldritch runes, with a singular shimmering sphere of crystal at its head, which seems to have a swirling mist within.");
	//(New Weapon: EldritchStaff)
	shortName = "E.Staff";
	takeItem();
	//Similar stats to the Wizard's Staff, but with a better Fatigue reduction and a bonus to Magic damage/effect.
	flags[TOOK_QUEEN_STAFF] = 1;
}

//Throne Room -- [Harpy Queen] -- [Fuck Her]
function fuckHarpyQueen():void {
	clearOutput();
	outputText("You decide that the queen bitch deserves to be taught a lesson and you'll use her to get you off in the process.  You whisper this to Hel, who seems quite amused by the idea.");

	outputText("\n\n\"<i>Oh, I was hoping you'd say that. So, what's the plan?</i>\"");
	//(Display Options:
	//If Male: [Anal](Needs big cock) [Vaginal](Basically any size)
	//If Female: [?]
	//If Herm: All Above
	//If Genderless: \"<i>You don't really see how this is going to work out...</i>\" (NO SMUT 4 U)
	var anal:Number = 0;
	if(player.biggestCockArea() > 50) anal = 11128;
	simpleChoices("Anal",anal,"Vaginal",11129,"",0,"",0,"Back",1);
}
//Harpy Queen Sex -- [Dick in Anal]
function harpyQueenSexAnal():void {
	clearOutput();
	outputText("Hel grabs the queen bitch by the shoulders and roughly tosses her onto the floor.  The gathered crowd of harpies gasp as Hel shoves the queen onto all fours for you.  You disrobe, tossing your [armor] aside and stroking your " + cockDescript(0) + " to full hardness.  You kneel down behind the Harpy Queen's massive flanks, so wide that you feel you could stuff your torso between her cheeks.  With great effort, you peel her jiggling ass apart, revealing the tight ring of her pucker and her loose, gaping cunt.");
	outputText("\n\nAs you position yourself behind the broodmother, Hel strips out of her skimpy bikini-mail and, grabbing the bitch by her hair, shoves her slick pussy into the harpy's face.  The queen struggles against Hel's grasp, making her inhuman hips and ass shake and jiggle seductively.  Your cock goes rock hard with the display before you, and you roughly push it into the harpy's buttcheeks.  You let her ass go, and shudder as the queen's soft flesh wraps around your " + cockDescript(0) + ", as tight as a virgin pussy, but at the same time so soft and giving..."); 
	outputText("\n\nYou wrap your arms around her broodmotherly hips and start to thrust into her crack, hotdogging the harpy bitch.  Your dick sinks in and out of her squishy flesh, seeming to swallow your length like quicksand; you feel yourself drawn inexorably inwards, your shaft brushing against her slick pussy and tightly clenched ass.");
	outputText("\n\nYou give Hel a little wink, and though occupied by forcing the harpy to eat her out, she just manages to return it.  With that, you press the head of your " + cockDescript(0) + " against the harpie's sphincter.  Though much of your length is eaten up by her tremendous ass cheeks, her anus still clenches frightfully at your insistent prodding.  Scowling, you rear your hand back and give the harpy bitch a forceful slap on the butt.");
	outputText("\n\nThough her pillowy cheeks absorb much of the blow, she still lets out a pitiful yelp into Hel's pussy, and loosens up for a split second.  You plunge your shaft in, grunting at the incredible tightness of her anal passage.  She must have been a virgin back here before you took her; she screeches and writhes as your force your cock into her immensely tight bumhole, fighting for every inch you can stuff her with.");
	outputText("\n\nYou swat the harpy again to shut her up, but all that does is make her vice-like ass squeeze on your cock, painfully compressing the head.  You growl in pain, and in revenge slam yourself into her ");
	if(player.cockArea(0) < 100) outputText("until your hips sink into her pillowy ass");
	else outputText("until your massive " + cockDescript(0) + " can go no further inside her");
	outputText(".  Sunk in as far as you'll go, you leave your cock where it is and instead give the broodmother a hard slap.  She screeches and clamps down, wringing your " + cockDescript(0) + " hard.  But it's more pleasurable this time, now that she's nice and stretched by your anal intruder.");
	outputText("\n\nYou give her another swat, and another, spanking the harpy bitch until she's outright milking your " + cockDescript(0) + " inside her.  Laughing, Hel starts telling the queen what a good slut she is, taking your " + cockDescript(0) + " up her ass and squeezing it like a whore as she tongue-fucks another woman.  The queen tries to protest, but you give her another hard slap to teach her some manners.");
	outputText("\n\nShe squeezes down so hard on your cock you feel like it's ready to burst.  Instead, though, you feel a sudden surge in your loins.  You have only enough time to sink your hands into the queen's cheeks and let out a powerful roar of pleasure as you cum, shooting a great big rope of hot cum right up her ass.  The queen screeches as you unload inside her, and the sudden motion of the queen's mouth sets Hel right off.  The salamander grabs the queen's head and crushes it against her hips, burying the harpy's nose inside her snatch as she cums over the bitch's face.");
	outputText("\n\nSpent, you pull out of the broodmother's now-gaping asshole.  Her huge asscheeks, however, bottle up your load inside her, preventing it from pooling out.  Laughing, you squeeze her squishy ass one last time before Hel rolls her over and pins her again.");
	//(Return to normal room menu)
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

//Harpy Queen Sex -- [Vaginal]
function vaginalHarpyQueenSex():void {
	clearOutput();
	outputText("You roughly toss the harpy queen to the floor and, grinning, tell her that since you're wrecking her plans to breed phoenixes, you'll just give her a brood of champion-spawn instead.  She gapes at you, wide-eyed in confusion and fear. Hel keeps her pinned down for you as you toss your [armor] aside, revealing your " + cockDescript(0) + ".");

	outputText("\n\nHel swings her leg around, planting herself firmly over the Harpy Queen's face. She crouches down, planting her cunt just an inch above the queen's nose, her long fiery tail swishing just above her cunt.  \"<i>You should feel honored, whore,</i>\" Hel growls, grabbing the queen by the hair.  \"<i>One egg fathered by my friend's seed is worth a thousand of your weakling sluts. Go on, thank " + player.mf("him","her") + "!</i>\"");
	outputText("\n\nThe harpy struggles against Hel's firm grasp, until she gets a good slap from the salamander.  \"<i>Gah! Thank you!  Thank you for the honor of bearing your eggs!</i>\" she pleads, still squirming.  You laugh and grab her massive thighs, pulling them apart to reveal your prize.  Her cunt is a voluminous gash between her legs, gaping and drooling lubricant, stretched beyond human possibility by the dozens - hundreds, even - of eggs she's birthed over her long life."); 

	outputText("\n\nYou kneel down between her legs and experimentally stick your " + cockDescript(0) + " into her; she seems to simply suck it up, swallowing your entire shaft in a heartbeat.  Gods, she's immense!  You feel like you're sticking your shaft into a black hole, a cavern that has no ending.  She groans slightly at the penetration, but has easily taken your entire length with room to spare.  You shift around a bit, pushing her legs together to contract her gaping cunt.");

	outputText("\n\nFinally, you feel her slick walls around your " + cockDescript(0) + ". The queen shudders, but now seeing that you mean to pump her full of your seed, visibly relaxes. Still, she's just too loose to give you the pleasure you're seeking...");

	outputText("\n\nA wicked grin spreads across your face.  You reach forward and grab Hel's tail, wincing at its heat, and drag it back between the Harpy Queen's loins.  Hel looks at you over her shoulder and, grinning, takes over for you.  You brace yourself as her prehensile tail slithers back and, curling once around your " + cockDescript(0) + ", slips inside the queen with you.  You and the broodmother both gasp at once as her burning-hot tail crawls along your cock's shaft and into her gaping cunt until the harpy lets out a little scream into Hel's own crotch.  You guess the salamander found her womb and is wriggling her tail into it.");
	if(player.cockArea(0) < 48) outputText("  Not to be outdone, you slam your hips forward, ramming your " + cockDescript(0) + " into the queen's depths until you catch up with Hel, pounding the entrance to her womb.");
	outputText("\n\nNow that you have a second shaft inside the harpy's birth canal, it seems a lot less roomy. You start to piston your hips into the queen bitch; your shaft runs along three slick walls and Hel's hot tail with each thrust, leaving your " + cockDescript(0) + " feeling like it's in a liquid inferno, and it feels wonderful.  You start to fuck the queen faster, already feeling your own orgasm rising.  Her juices spill freely from her loose cunt, pooling between her thighs as you and Hel fill her utterly, giving her what's probably the first satisfying fuck she's been able to get in years.");
	outputText("\n\nYou aren't surprised when the harpy gets off, rolling her head back and screeching as she climaxes. Laughing, Hel starts to thrash her tail around inside her, nearly managing to wrap it around your " + cockDescript(0) + " inside her.  With the sudden contractions and extra motion around your cock, you aren't able to last any longer; ");
	if(player.cumQ() < 300) {
		outputText("you slam your [hips] into the harpy's groin and ejaculate, launching thick, sperm-filled globs right into her waiting womb.\n\nYou cum and cum, filling the queen with all your seed until your ");
		if(player.balls > 0) outputText("[balls] feel");
		else outputText("crotch feels");
		outputText(" hollow and empty.  Shuddering, you and Hel both withdraw, your cock and her tail a spunk--and juice-covered mess.");
	}
	else {
		outputText("you slam your [hips] into the harpy's groin and ejaculate, releasing a massive torrent of spunk deep inside the queen's womb, causing the harpy to shudder at the sheer amount of sperm you let out.  You continue to coat the harpy's walls for a minute, until your ");
		if(player.balls > 0) outputText("[balls] feel");
		else outputText("crotch feels");
		outputText(" hollow and empty.  You and Hel slowly withdraw, causing some of your semen to leak out of the harpy's massive canal, leaving your cock and Hel's tail a spunk-and-juice-covered mess.");
	}
	outputText("\n\nAfter a fuck like that, the broodmother will be laying a clutch of your eggs in no time.");
	stats(0,0,0,0,0,0,-100,0);
	doNext(1);
}

//Throne Room -- [Harpy Queen] -- [Interrogate]
function harpyQueenInterrogate():void {
	clearOutput();
	outputText("Leaning over the defeated Harpy Queen, you decide to get some answers.  First, you ask her why, exactly, she kidnapped a salamander in the first place.  That's what brought you here, after all.");
	outputText("\n\nGrunting under Hel's foot, the queen spits at you, narrowly missing your face. \"<i>What the fuck kind of question is that? I stole him to steal his seed, foolish " + player.mf("boy","girl") + ".</i>\"");
	outputText("\n\nWell, you suppose you had that one coming.  Next.  How did she get the phoenixes in the first place? Harpies usually don't birth half-breeds.");
	outputText("\n\n\"<i>Ha!  Goblin alchemy.  My true-born daughters brought me all that they could.  I experimented for years trying to get it right.  A bit of this potion and that poison... But I did it.  I created the ultimate race of warriors.  You might kill me, but you cannot erase my creation!</i>\"");
	outputText("\n\nYou roll your eyes. We'll see about that.  You ask her why she went to all that trouble of making a race of 'ultimate warriors' anyway.  Since when did a harpy want to rule the world?");
	outputText("\n\n\"<i>Rule the world? FOOL! That was not my intention - far from it.</i>\"");
	outputText("\n\nOh really?");
	outputText("\n\n\"<i>It is the truth.  I saw what the demons did to our world... What they wreaked upon my beautiful daughters... And I could not turn my back.  So one man had to suffer!  A pittance of a sacrifice to drive back the demons.  With the salamander's seed, and my magic and mighty womb...  An army was not beyond our reach.  The phoenixes were to be the demons' downfall.  Yet you seek to doom us, all for the sake of one.</i>\"");
	outputText("\n\nWait, what.");
	outputText("\n\n\"<i>You heard me, fool! I meant to breed an army to turn back the demons.  And I was so close!  My daughters, you fought them below; were they not beautiful? And so... so very deadly.</i>\"");
	outputText("\n\n\"<i>You bitch!</i>\" Hel snaps, grinding her foot into the harpy's chest.  \"<i>What the fuck is wrong with you people?  Did you even think, for one fucking second, actually THINK to maybe ask one of us?  Just fly down and ask any horny salamander boy, 'Wanna fill me with your seed till my eggs pop and make an army?' Guess what - he'd say yes! Any man in Mareth who's still pure at heart would say YES!</i>\"");
	outputText("\n\nThe harpy queen turns her gaze toward Hel. \"<i>This one did not.</i>\"");
	//[If PC told Hel about Hakon:
	if(flags[HEL_KNOWS_ABOUT_HAKON] == 1) outputText("\n\n\"<i>That's because he was MARRIED, YOU BITCH!</i>\" Hel screams, her tail practically blazing behind her. The queen recoils, but falls silent.");
	else outputText("\n\n\Hel scowls, but says nothing. It doesn't seem like you'll get anything further from the queen.");
	//(Return PC to room menu)
	doNext(1);
}

//Tower of the Phoenix: Outro
//(Play when the PC interacts with Hakon, in the dungeon, while possessing both HARPY KEY key items)
function towerOutro():void {
	clearOutput();
	if(flags[HARPY_QUEEN_EXECUTED] == 0) flags[HARPY_QUEEN_EXECUTED] = 1;
	//[IF PC DID NOT TELL HEL ABOUT HAKON BEFORE]
	if(flags[HEL_KNOWS_ABOUT_HAKON] == 0) {
		outputText("With Hakon's arm slung over your shoulder, you help the long-imprisoned salamander up the stairs and, with great effort, out the ancient doors of the tower.  Outside, you see Helia and her pseudo-phoenix half-sister Kiri.  Hakon recoils as the evening sunlight hits his eyes, his first taste of the sun in years.");
		outputText("\n\nHel and Kiri turn to you, smiling from ear to ear as you bring Hakon outside.");
		outputText("\n\n\"<i>Hel,</i>\" Kiri says, taking the salamander by the hand.  \"<i>I've got someone you might want to meet.</i>\"");
		outputText("\n\nThe elder salamander manages a weak grin as his unknowing daughter walks over to him and extends a hand.  \"<i>Hey there, old scales.  Name's Helia - Hel for short - and I... Why is everyone looking at me like that?</i>\"");
		outputText("\n\n\"<i>Hel,</i>\" Kiri says, \"<i>this is... our dad. Hakon.</i>\"");
		outputText("\n\n\"<i>Old scales, is it?</i>\" Hakon says, grinning ear to ear.  \"<i>Lemme tell you something, little girl.  I - OOF!</i>\"");
		outputText("\n\nBefore 'old scales' can finish his thought, Hel leaps into his arms, hugging him tightly.  You can see tears streaming down her face - and, you think, his too - streaming off them as the two salamanders embrace.");
		outputText("\n\n\"<i>Is it... really you? Dad?</i>\"");
		outputText("\n\n\"<i>It is, little Hel.  And I'm never leaving you again.</i>\"");
		outputText("\n\nYou spend the next few hours sitting on the stoop of the tower, watching as the long-estranged family has a chance to get to know each other again.  You smile the entire time as Hel, Hakon, and Kiri are soon teasing and playing with each other as if they had always been together.");
		outputText("\n\nEventually, it's time to go.  With an arm around his daughters, Hakon steps up to you. \"<i>" + player.mf("Son","Sweetheart") + ", I can't thank you enough.  Not for freeing me, but for... For reintroducing me to my family.  If you ever need anything, you don't hesitate to ask.  If by my life or sword I can help you, I will, without hesitation.</i>\"");
		outputText("\n\n\"<i>Yeah,</i>\" Hel says, grinning.  \"<i>You did all right, lover mine.  Don't worry, I'll drop by soon to show you just how much I appreciate it.</i>\"");
		outputText("\n\n\"<i>Lover mine?</i>\" Hakon says, chuckling. \"<i>I think we have a lot to talk about on the way down, little girl.</i>\"");
		outputText("\n\n\"<i>Well, shit.</i>\"");
		outputText("\n\nYou laugh, shake your head, and start your way down the mountain.");
		//(PC returns to Camp)
		//(If PC has Valeria: add \"<i>Valeria</i>\" to Followers menu)
	}
	//[IF PC DID TELL HEL ABOUT HAKON]
	else {
		outputText("With Hakon's arm slung over your shoulder, you help the long-imprisoned salamander up the stairs and, with great effort, out the ancient doors of the tower.  Outside, you're treated to a sweeping expanse of mountain; it's a gorgeous vista, with the great rocky spires and crags surrounding you until the sun is just a glimmer in the distant.  Hakon squints, covering his eyes as he is bathed in daylight for the first time in years.");
		outputText("\n\nBehind you, you hear a sudden, gleeful cry: \"<i>DADDY!</i>\"");
		outputText("\n\nHakon turns just in time as Hel leaps into his arms, followed shortly by her phoenix half-sister Kiri.  You can see tears streaming down the girls' faces -- and, you think, Hakon's too -- streaming off them as a father is finally reunited with his daughters...");
		outputText("\n\n\"<i>Is it.. really you?  Dad?</i>\" Hel asks, openly crying.  You don't think she's ever seen her father before.");
		outputText("\n\n\"<i>It is, little Hel.  And I'm never leaving you again.</i>\"");
		outputText("\n\nYou spend the next few hours sitting on the stoop of the tower, watching as the long-estranged family has a chance to get to know each other again.  You smile the entire time as Hel, Hakon, and Kiri are soon teasing and playing with each other as if they had always been together.");
		outputText("\n\nEventually, it's time to go.  With an arm around his daughters, Hakon steps up to you. \"<i>" + player.mf("Son","Sweetheart") + ", I can't thank you enough.  Not for freeing me, but for... For reintroducing me to my family.  If you ever need anything, you don't hesitate to ask.  If by my life or sword I can help you, I will, without hesitation.</i>\"");
		outputText("\n\n\"<i>Yeah,</i>\" Hel says, grinning.  \"<i>You did alright, lover mine. Don't worry, I'll drop by soon to show you just how much I appreciate it.</i>\"");
		outputText("\n\n\"<i>Lover mine?</i>\" Hakon says, chuckling.  \"<i>I think we have a lot to talk about on the way down, little girl.</i>\"");
		outputText("\n\n\"<i>Well, shit.</i>\"");
		outputText("\n\nYou laugh, shake your head, and start your way down the mountain.");
	}
	//(PC returns to Camp)
	//(If PC has Valeria: add \"<i>Valeria</i>\" to Followers menu)
	inDungeon = false;
	doNext(14);
}
