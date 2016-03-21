package classes.Scenes.Places.TelAdre{
	import classes.GlobalFlags.kFLAGS;
	import classes.*;

	public class SexMachine extends TelAdreAbstractContent{

	public function SexMachine()
	{
	}

public function exploreShowers():void {
	clearOutput();
	/*if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("You toss ten gems to centaur and head towards the back.\n\n", false);
		player.gems -= 10;
		statScreenRefresh();
	}*/
	hideUpDown();
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00182] <= 1 && flags[kFLAGS.DISABLED_SEX_MACHINE] <= 0) {
		outputText("Having worked your body to a pleasant soreness as well as coating your " + player.skinDesc + " in a thin sheen of sweat and pheromones, you decide to hit up the showers to wash off and relax in the hot water.  ", false);
		outputText("You walk into the back halls of the gym, quickly realizing you aren't quite sure where you're headed.  You turn a couple corners, walking down the halls looking for someone, and are about to turn back when you see a goblin round the corner up ahead.\n\n", false);
	
		outputText("You shout after the short humanoid, jogging lightly in chase, but only come to a closed iron door.  The door has a small window on it, blocked with a wire mesh to prevent breaking.  Inside you see a relatively plain room with a couple doors to the back sides.  A single light illuminates the strange room, right above the most technological piece of weight equipment you've ever seen.  You open the door, hoping to find the goblin, only to find the back two doors are hopelessly locked.  You turn to look once more at the piece of equipment in the center of the room.\n\n", false);
	
		outputText("Made of polished steel, the machine has many foreign parts you couldn't even begin to guess the use of, and some familiar ones from the other work out machines from the main gym floor.  This one, however, even seems to have a small monitoring screen!  You could easily sit down and check out this sophisticated device while waiting for the goblin to come out from the back rooms.\n\n", false);
		
		outputText("Do you use it or not?", false);
		doYesNo(useTheSexMachine, leaveShowers);
		addButton(2, "No way!", disableMachineForGood);
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00182] = 1;
	}
	//Go directly to sex if you know what's in store!
	else {
		if (flags[kFLAGS.BROOKE_MET] == 0) telAdre.brooke.meetBrookeFirstTime();
		else useTheSexMachine();
	}
}

//[If you decide to leave.]
private function leaveShowers():void {
	clearOutput();
	outputText("You shake your head.  You've had enough of a workout for the day, and you remember you're in a land where curiosity almost certainly kills (well, more thoroughly rapes) the cat.  You leave the room and continue to search for the showers, eventually finding them and heading back to camp.", false);
	doNext(camp.returnToCampUseOneHour);
}

private function disableMachineForGood():void {
	clearOutput();
	outputText("No way you are going to use the machine in your life!  You shake your head.  You've had enough of a workout for the day, and you remember you're in a land where curiosity almost certainly kills (well, more thoroughly rapes) the cat.  You leave the room and continue to search for the showers, eventually finding them and heading back to camp.");
	outputText("\n\n<b>You will not encounter the sex machine again but you can still take a shower.</b>");
	flags[kFLAGS.DISABLED_SEX_MACHINE] = 1;
	doNext(camp.returnToCampUseOneHour);
}


private function useTheSexMachine():void {
	clearOutput();
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00182] = 2;
	//[If you decide to mess with the machine: Male]
	if (player.gender == 1) {
		if (flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_MALE] == 0) {
			outputText("You sit on the padded bench, looping your legs behind the machine's soft foam leg lift bars. There's even straps to prevent you from slipping. The machine's monitor blinks to life, instructing you to strap in your legs, your waist, and then place your arms in the cuffs on the lowered bars to either side of your head.\n\n", false);

			outputText("You do as you're told, and as soon as you're all strapped in, and your arms are in place, the cuffs tighten, quickly securing you to the machine! It lifts you off the padded bench, slipping it behind you for you to lean against at an angle on your back. It takes no time at all for the shifting mechanical parts to begin working your already sore arms and legs, leaving you helpless to fight against them as you're already strapped in. You grunt in effort, attempting to get free from the crazed weight machine, only to have it increase the pace. The screen flashes once more, stating that it is beginning \"phase two\". Quickly your pants are removed, revealing " + player.sMultiCockDesc() + " and your " + player.assholeDescript() + " to the cool air. Almost instantly a firm, phallic-shaped metallic object is pressed against your anus, but it goes no further.  Another device slips around your ", false);
			if (player.cockTotal() > 1) outputText("primary ", false);
			outputText("cock, tightening around your member while beginning to hum softly.\n\n", false);

			outputText("It takes little time for " + player.sMultiCockDesc() + " to grow hard, your lust betraying you as another phallic shaped metallic length is presented in front of your face. A small shock is delivered to your " + player.assholeDescript() + ", causing you to gasp, and allowing the phallic length to slip deep into your mouth, giving you little choice but to suck on the device. The tube-like length on your " + player.cockDescript(0) + " continues its assault, humming and stroking your firm cock, starting to suck softly to pleasure your mighty rod; so much that you nearly don't notice as a small tube slips into the tip of your penis, beginning to slowly devour your leaking pre-cum.\n\n", false);

			outputText("Shaking your head as the machine forcibly pleasures you, you quickly realize that with each drop of cum your cock has drained from it, the phallus against your anus gets a little more moist. It's using your own pre-cum to lube your asshole!\n\n", false);

			outputText("It doesn't take long for the phallus to slip past your anal ring, filling your anus with firm strokes while you let out muffled moans.", false);
			player.buttChange(30,true,true,false);
			outputText("  The machine's screen states that it is now entering \"Harvest phase\", and goes into high gear. The phallus in your ass bucks you forward, forcing your hips to buck and grind against the tight mechanical cunt as it quickly grinds against your cock.  Even the device forced inside your mouth begins to vibrate and hum, and you swear you taste your own cum leaking from it.\n\n", false);

			outputText("The phallus in your anus begins to rub firmly against your prostate, as if it was locating it and locking onto it. Within moments you cry out in orgasmic pleasure, ", false);
			if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " pulling up tightly ", false);
			else outputText("prostate pulsing madly ", false);
			outputText("as you pump your thick seed into the machine's waiting tube.\n\n", false);

			outputText("You are surprised when the machine doesn't pump your own seed into your mouth and anus, instead slowly letting you back down. A platform lifts up in front of the machine, with a small metallic mini-keg. Once you're released and the keg is presented, the machine \"dings\", as if it had finished, leaving you exhausted and utterly violated.\n\n", false);

			outputText("Within moments, the goblin comes out of the back room - the small redheaded woman looks surprised to see you. Covered head to toe in thick grease and dirty clothes, she fits every last stereotype of an engineer.\n\n", false);

			outputText("\"<i>What are you doing to my baby?!</i>\" she cries out, until she notices the keg sitting in front of her.  \"<i>Wait, it works? It works!</i>\" she cheers with glee, quickly rushing over and snatching up the keg of your seed. Within moments she's gone back through her locked door, leaving you alone with the machine, whose screen goes blank after noting that it had \"saved your measurements\". Probably to rape you more efficiently next time...\n\n", false);
		}
		//[Male repeat scene]
		else {
			outputText("You get a sly smirk on your face. If you're going to get a full body workout, you need to work out -every- muscle in your body, and there's only one machine that can do that.\n\n", false);

			outputText("Walking down the back halls of the gym, it doesn't take you long to find the back room with the odd machine once more, looking much as it did prior. The room is silent and empty, the machine sitting with its screen turned off until once again, you sit on the padded bench, and the screen flickers to life. It displays your measurements as if it can somehow tell who you are, and asks you in a very polite manner to place your limbs into the safety straps.\n\n", false);

			outputText("You eagerly place your legs into the straps, and buckle your waist down. Placing your arms into the cuffs, the machine whirs to life, revealing its newest additions. It seems there's been improvements since your last visit! The machine raises a onahole to your slowly stiffening " + player.cockDescript(0) + ", already removing your shorts as it works your arms and legs to a tiring stiffness. The false vaginal opening seems to glisten in the light with some form of self lubrication, and you feel a familiar pressure against your " + player.assholeDescript() + ". A second phallus lowers to your lips, and once more you're shocked and gagged with the dildos, the onahole quickly going to work on your stiff cock.\n\n", false);

			outputText("Within moments you're rock hard, being roughly fucked by the wet sex toy. You can feel the machine rippling the length of the slick tunnel, massaging your " + player.cockDescript(0) + " and focusing on your sensitive " + player.cockHead() + ", causing every nerve ending to light up in pleasure.  As you slowly leak pre-cum, the phallus is slipped once more into your anus, almost instantly pressing against your prostate to stroke and milk it as if it were a prehensile finger, not a metal toy in your ass.", false);
			player.buttChange(30,true,true,false);
			outputText("\n\n", false);

			outputText("You're brought to the edge of climax repeatedly, groaning as you grow tender and swollen, being denied your release multiple times by the machine. You willingly begin to buck against the wet vagina-like opening, attempting to force the machine to let you climax, but you're only met with resistance as it pulls on your arms and legs to restrain you.\n\n", false);

			outputText("After another half hour of tormented pleasure, the machine releases your swollen prostate, allowing your torrent of cum to flow violently into the tube inserted into your urethra. It sucks you dry, then slowly lowers you once again with a ding. You see the keg of what you assume to be your semen, once again raised up. The goblin quickly runs out, wearing a white lab coat and goggles.  She takes the keg without so much as a word to you.\n\n", false);

			outputText("As you prepare to leave, you swear you spotted a funnel in her back pocket...", false);
		}
		flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_MALE]++;
	}
	//[If you decide to mess with the machine, female:]
	else if (player.gender == 2) {
		if (flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_FEMALE] == 0) {
			outputText("You gently sit on the padded bench, curious as to what this machine might actually accomplish, noting the various odds and ends that seem more devious in nature than exercise inclined. The screen before you quickly flickers to life, welcoming you and asking you to kindly place your " + player.feet() + " in the appropriate safety straps and place your arms in the secure cuffs. You wonder briefly if this is a good idea, but work your way into the tight fitting straps anyways.\n\n", false);
	
			outputText("Within moments, the machine lifts you up, pulling your arms out and apart, away from your sore aching body.  After such a workout you can do little to fight the strong pull of the mechanical assailant. It whirs to life, stating that it is beginning \"Phase 1: Preconditioning\".\n\n", false);
	
			outputText("You feel the machine begin to tug at your clothes with various mechanical clamps.  It pulls your clothing free in moments, revealing your " + player.allBreastsDescript() + ", " + player.vaginaDescript() + ", and your " + player.buttDescript() + " to the cool room's air. You blush furiously, and it doesn't take the machine but a couple of moments to place a metallic, phallic-shaped device against your labia and anus, the cold metal eliciting a shocked gasp from you, allowing it to slip another cock into your mouth. The tip of the metal cock tastes salty, leaking a fluid slowly from the tip.  You blush with arousal: the machine is force feeding you cum!\n\n", false);
	
			outputText("Continuing its molestations, the machine attaches a small sucker hose to your " + player.clitDescript() + ", quickly suctioning it erect.  The device follows suit with your " + player.nippleDescript(0) + "s.  You begin to moan, unable to hold back the pleasure shooting through your body from the suctioning tubes. You almost don't notice the cum leaking from both phallic devices between your legs, lubing you further until they're both starting to penetrate you at the same time, stuffing you full of cock from nearly every angle.", false);
			player.cuntChange(30,true,true,false);
			player.buttChange(30,true,true,false);
			outputText("\n\n", false);
	
			outputText("You gasp in pleasure, unable to move, fight, or even touch yourself as the machine begins to fuck you with its metallic cocks. The screen flashes, showing 'phase one is completed', and that it has begun phase two, 'implantation'. You don't have time to question the machine's intentions as it begins to fuck you harder and faster, your juices and arousal only helping the machine to continue.", false);
			if (player.biggestTitSize() >= 2) outputText("  It slips a fourth cock between your " + player.chestDesc() + ", using two arms to press them together and fuck your tits as well, splashing a burst of mysterious cum on your face with every thrust.", false);
			outputText("\n\n", false);
	
			outputText("It doesn't take long until the cock in your mouth cums, spraying a thicker, heavier load of the heavenly seed down your throat and into your stomach. You gasp, swallowing without a choice, as your eyes roll back in your head, the machine ramming its cock into your g-spot, pushing you almost instantly to orgasm. You moan out loud, the cock popping out of your mouth now that its finished delivering its load. Your rippling vaginal walls milk the fake dick in your cunt, as it and the prick in your ass begin to cum heavily.  Every hole is quickly filled with mysterious jizz, stuffing you completely.\n\n", false);
	
			outputText("Finally the machine slows down, beginning to lower you back onto the padded bench with ", false);
			if (player.biggestTitSize() >= 2) outputText("your breasts covered in cum and ", false);
			outputText("jizz leaking from every hole on your body. You groan, sore and stiff from the brutal workout but happy with afterglow. The screen before you appears to be saving data on your measurements, as well as physical stress levels. The final number flies past too fast for you to read, but the label sends a chill up your spine: \"Pregnancy percentage chance\".\n\n", false);
	
			outputText("It isn't long until the goblin comes into the room gasping. \"<i>You used my baby? You... wait, it worked? It worked! Tell me, how was it?  Wait no, don't tell me, it was wonderful of course!</i>\" the red-headed goblin beams.  She's covered from head to toe in grease, wearing dirty clothing that has various tools sticking out of every pocket; a stereotypical engineer. \"<i>The machine is made to milk studly men dry and use their cum to impregnate goblin females.  It automates the process!  But if you want to use it too, feel free, sexy.</i>\"  She winks at you lewdly. \"<i>But who knows what kind of cum will knock you up!</i>\"\n\n", false);
	
			outputText("She turns, walking back into the locked backroom, leaving you stunned and speechless.", false);
		}
		//[Female repeat scene]
		else {
			outputText("You grin as you walk down the halls, wiping sweat from your forehead from your recent workout. Tired, but not exhausted, you decide to have a wind down session with your favorite machine in the building. Walking down the back halls, it doesn't take you long to find the quiet back room with the mysterious goblin machine in it. You quickly slip inside, letting the steel door close behind you with a soft metallic click.\n\n", false);

			outputText("As you sit on the bench, the screen once more flares to life, quickly scrolling various body information about you past, not limited to vaginal depth, optimal ovulation periods, bust size... attempting to read it all is dizzying! You rub your forehead, sighing softly as you buckle yourself in.  Then you slip your arms and legs into the restraints of the machine, and once again it lifts you up in the air and strips your " + player.armorName + " off.\n\n", false);

			outputText("The cool air makes your nipples stand out, and you notice a pleasant surprise: the cocks slipping between your ass-cheeks and thighs are made of a soft, but firm, latex.  They warm as they leak cum on your " + player.assholeDescript() + " and labia. You blush, willingly opening your mouth for the cock in front of you.  Sucking it in to taste the heady seed, you close your eyes, enjoying the ride as your labia softly part, wet and ready for the intruding member.\n\n", false);

			outputText("You moan lustfully as the members slip into your " + player.vaginaDescript() + " and " + player.assholeDescript() + ", filling you deeply.", false);
			player.cuntChange(30,true,true,false);
			player.buttChange(30,true,true,false);
			outputText("  They begin to stroke slowly", false);
			if (player.biggestTitSize() >= 2) outputText(", and it doesn't take long for the machine to slip a cock between your breasts as well, starting to tit fuck you as it rotates you in your restraints to optimize your position", false);
			else outputText(" while the machine rotates you in place to optimized your positioning.", false);
			outputText(".\n\n", false);
																														   
			outputText("You moan with your legs lifted high above your head, leaving you surprised as to how flexible you truly are; the positioning of your legs forces your ass and vagina to clamp down on the members, making you feel every ridge and nub as they piston in and out of your wet fuck holes. Once more, the cock in your mouth cums first, pumping globs of hot semen down your throat, filling your stomach while you begin to climax, panting and gasping for air even as you swallow all you can. The latex pricks fucking your other holes bounce you as your girlcum runs down your thighs, and shortly after they cum deep inside you, pumping you full of their mysterious seed.\n\n", false);

			outputText("You pant as you are let down onto the padded bench, rubbing your swollen stomach while cum leaks out of both of your holes. You smile from the afterglow of your climax, truly exhausted, and <b>really</b> needing that shower now.\n\n", false);
		}
		flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_FEMALE]++;
	}
	//[Sexless]
	else if (player.gender == 0) {
		if (flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_EUNUCH] == 0) {
			outputText("You sit down on the padded bench and look around at the odd weight-lifting machine nearby. Various parts look less than pleasant, and less than exercise orientated on further inspection.  It makes you question the uses of this machine. The screen before you flashes to life, politely asking you to place your arms and legs in the cuffs and buckle yourself in.\n\n", false);

			outputText("You raise an eyebrow, wondering what you're getting yourself into as you buckle yourself to the machine, hoping this isn't a mistake. It doesn't take long for you to realize it is. The machine lifts you up, stripping your " + player.armorName + " off of you and spreading your arms and legs. First, a round device that appears to be made to hold a penis slips up, rubbing against your flat pelvis. It tries for a few moments, lifting up two other smaller devices made for smaller dicks before it gives up, the screen reading \"error\". Shortly afterward, a cock-like metallic device is lifted up to your groin, rubbing around as it leaks lubrication, searching for an entrance until once again the screen reads \"error\".\n\n", false);

			outputText("It whirs for a moment, confused. It seems to ponder matters for a second before simply lifting you up into a sitting position. It doesn't take but a moment for you to feel a firm steel tip press against your anus, the machine bouncing you slowly in your restraints on the mechanical cock, each bounce smearing more and more cum on your " + player.assholeDescript() + ", lubing you up for your eventual penetration.\n\n", false);

			outputText("You gasp with each bounce, your ass finally lubed enough that each gentle jostle forces you to sink another half-inch down on the thick phallic member. With a groan you finally bottom out, your anus stretched around the thick member.  ", false);
			player.buttChange(30,true,false,true);
			outputText("The machine forces you forwards, onto your hands and knees, the thick cock beginning to slip in and out of your ass, pounding away with fervor to the sound of your exhausted moans. Each thrust seems to get closer and closer to a pleasurable spot, as if homing in on it slowly.\n\n", false);

			outputText("It doesn't take long for every thrust of the thick metal cock to ram that pleasant spot, pushing you closer and closer to your climax. You close your eyes as they roll back in your head, moaning loudly as you orgasm, the cock erupting inside of you, filling your rectum with thick spurts of cum.\n\n", false);

			outputText("Slowly, the machine pulls out of your asshole, releasing the straps and leaving you unceremoniously on the padded bench, facedown with your gaped anus hanging the air, leaking cum.\n\n", false);

			outputText("After you collect yourself and your gear, you quietly slip out of the room, the machine quiet and inactive now. However, you can't help but feel like you were being watched...", false);
		}
		//[Sexless Repeat]
		else {
			outputText("You walk down the halls after your brisk workout, once more headed for that quiet back room with that wonderful piece of exercise equipment. You smile as you slip in the door, looking around a moment to make sure you're alone in the room.\n\n", false);

			outputText("You casually strip yourself naked, saving the machine the effort, and sit on the padded bench. It whirrs to life, blinking a few statistics on the screen, including what seems to be measurements of your rectum and anus. Why would it need those?\n\n", false);

			outputText("You shrug it off, slipping, as directed, into the various straps and buckles to secure yourself to the machine, and once more it lifts you into the air. You feel a firm pressure against your " + player.assholeDescript() + " once again, teasing you with a surprise: you feel a flexible latex head probing your asscheeks, leaking cum all over them!\n\n", false);

			outputText("You turn your head, look back, and gasp. You expected to see a latex cock molesting your backdoor, but instead see a latex tentacle brushing cum against your anus. What is this machine planning to do?!\n\n", false);

			outputText("It doesn't take long for your " + player.assholeDescript() + " to be slathered in cum, the machine pressing on your muscular ring with the tip of its tentacle cock, starting to fill your ass with its prehensile member. Inch after inch slips inside of you, each humming ring of the cock stroking your anus as it fills your ass, vibrating deep inside of you.", false);
			player.buttChange(30,true,false,true);
			outputText("  You moan, closing your eyes and enjoying the pleasure, only to have a second tentacled cock thrust into your mouth, and down your throat. It doesn't take long for them both to begin thrusting, vibrating in both your holes.\n\n", false);

			outputText("The machine seems to know you well, the latex tentacle in your ass pressing firmly against your prostate with each firm thrust, driving you to a quick orgasm. You pant, realizing sadly that it didn't cum, expecting it to put you down after your climax. Instead it just holds you as you shudder, your body twitching in orgasmic pleasure, held fast by the machine. After a moment it starts again, pistoning harder and faster into your anus, filling you more than ever before. With each thrust you can feel thick spurts of hot pre-cum filling your backside, the tentacled cock swelling with tiny knots along its length, making it feel like you're being fucked by a set of vibrating beads.\n\n", false);

			outputText("They finally can't take it anymore, and the cocks erupt deep inside of you, filling you with cum as you have your hardest climax yet, screaming out loud in pleasure, caring little for if the anyone can hear you. You nearly pass out from the intensity of your orgasm, panting as you lay upon the bench after being released.\n\n", false);

			outputText("About ten minutes pass until you stand up, limping weakly out of the room.", false);
		}
		flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_EUNUCH]++;
	}
	//[Hermaphrodite]
	else {
		if (flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_HERM] == 0) {
			outputText("You sigh with relaxation as you lean back on the padded bench, stretching your arms above your head as you investigate the workings of the machine around you. Various parts are questionable for their purpose and intent, but the machine's complexity leaves their true uses beyond your imaginings. You finally notice the screen in front of you has turned on, politely informing you that you need to place your limbs into the safety straps, and buckle yourself in.\n\n", false);

			outputText("You raise an eyebrow but do as you are told, curious as to what the machine can truly do.  You're quickly strapped down and lifted into the air. You gasp as your limbs are forced apart, leaving you helpless to the machinations of this device. It doesn't take long for you to feel the cold tip of a metallic cock press against your labia, stroking up and down those sensitive folds.\n\n", false);

			outputText("You moan gently, feeling a slight dampness beginning to form between your legs as your ", false);
			if (player.cockTotal() > 1) outputText("primary cock", false);
			else outputText(player.cockDescript(0), false);
			outputText(" is gently stroked by the sheathe-like device now slipping over it. It rubs the flaccid member gently, stroking it up and down as it begins to swell with blood, growing harder by the second. You shudder with pleasure, wondering what could come next, only to be forced to gasp by a firm press on your " + player.assholeDescript() + ". A metallic cock presses hard against your muscular ring, taking the opportunity given by your gasp of surprise to force another cock into your mouth.\n\n", false);

			outputText("It's almost impossible to stay focused on any one stimulation at once, your mind flowing effortlessly between your asshole as the cock lubes it up, your cock as it's milked slowly, your throat as it's slowly fucked by another cock, and your pussy as it grows wet, slowly allowing inch after inch of the invading phallus to penetrate your walls and stretch you wide open.", false);
			player.cuntChange(30,true,true,false);
			player.buttChange(30,true,true,false);
			outputText("  You moan lustfully, your girly juices beginning to flow down your thighs as the cock begins to thrust deep inside of you.  The metallic sleeve on your member thrusts down around you, even as the machine penetrates your " + player.vaginaDescript() + ". It's almost as if you were fucking your own cunt!\n\n", false);

			outputText("You moan around the cock in your mouth, tasting the heady and thick cum it gives you, letting it trickle down the back of your throat slowly as it bucks in your mouth, leaving you helpless to call for help as every part of you is fucked.", false);
			if (player.biggestTitSize() >= 2) outputText("  Well, not every part of you, but that is rapidly fixed as a final cock rubs against your " + player.chestDesc() + ", starting to stimulate your chest as well.", false);
			outputText("\n\n", false);

			outputText("It doesn't take long, the pressure on your prostate from the cock in your ass, your dick being stroked and milked, and your cunt being fucked pushes you over the edge. The sudden outlet of sexual fluids is impressive. Your ass, throat, and cunt are all filled with cum at the same time.", false);
			if (player.biggestTitSize() >= 2) outputText("  The cock on your chest pumps cum onto your " + player.chestDesc() + ", as y", false);
			else outputText("  Y", false);
			outputText("our cock is milked of all its cum by the tube that was gently slipped into the tip of it when you were too lost in your own lusts to notice. You pant as the device gently sets you down onto the padded bench, the screen seeming to save some varied information about you.\n\n", false);

			outputText("Within moments, a small keg appears before you on a stand, the machine dinging as if it was finished. Quickly, the door in the back of the room opens, the goblin you'd seen earlier rushing out. \"<i>My poor baby! What have you done to her?!</i>\" she cries, then pauses.  \"<i>Wait, she worked? My baby worked! Tell me, what did you like more? Being milked dry? Or having your snatch stuffed with cum? Wait, no, don't tell me, I bet it's too hard to tell!</i>\" she practically cackles. The redheaded goblin stands there, covered in grease from head to toe, wearing nothing more than dirty clothes, stained with the various fluids an engineer comes in contact with.\n\n", false);

			outputText("She snatches the keg from the stand in front of you, and without another word, disappears once more into the locked back room. You stare, blinking in confusion, deciding perhaps it's best you finally get that shower you wanted in the first place.", false);
		}
		//[Hermaphrodite repeat scene]
		else {
			outputText("You wipe yourself off with a towel after your extended workout, stretching languidly as you walk down the hallway towards the showers. You stop short, pausing, wondering if perhaps your workout isn't truly over yet. You smirk and turn down the hall, going away from the showers towards the back rooms for one last good session.\n\n", false);

			outputText("With a soft, metallic click, the door behind you closes.  You walk across towards the familiar machine, looking it over once more as you strip off your " + player.armorName + " piece by piece. It looks practically the same, the goblin obviously keeping it clean and in shape. You amuse yourself a moment, stroking your " + player.clitDescript() + " with a finger, pondering if perhaps after you're gone, that the goblin might use it herself. Maybe she even uses your cum to get herself pregnant?\n\n", false);

			outputText("The thought stirs your cock to life, letting it slowly grow hard as you sit on the padded bench, strapping and buckling yourself to the machine as it whirs to life. The machine's screen flickers, scrolling all kinds of information past your eyes at a dizzying speed, until finally it settles on \"Entering stage one\".\n\n", false);

			outputText("You notice several lengthy latex tentacles raise up like snakes, dancing to an invisible snake charmer. Each of their swollen tips begins to leak cum slowly while they position themselves around you, ready to strike their various targets. You lick your lips, opening your mouth for the approaching cock-tentacle as it slips itself into your throat, the length of the member ribbed and vibrating. You shudder, feeling the probing head of yet another tentacle cock rubbing against your anus, lubing it up with the cum that leaks out of its tip; a similar cock does the same to your moist labia.", false);
			player.cuntChange(30,true,true,false);
			player.buttChange(30,true,true,false);
			outputText("\n\n", false);

			outputText("You moan gently, sucking firmly at the tentacle cock in your mouth as your own cock throbs in anxiety, waiting for its sleeve to arrive. You're pleasantly surprised as you feel a warm, wet cunt wrap around your cock. You moan in pleasure, the tube gently slipping into your cock to milk you when you cum, as the faux-vagina begins to stroke the length of your fuckstick. It doesn't take long for you to begin becoming lost in all the varied pleasures, your mind becoming quickly overwhelmed with the multiple inputs of pleasure.\n\n", false);

			outputText("The tentacle cock in your ass begins to bulge up, forming tiny knots not unlike a set of anal-beads, starting to fuck your backdoor more vigorously, before spraying your rectum liberally with thick cum. You groan with pleasure, beginning to drink down the cum from the cock in your mouth as your vaginal walls clamp down on the cock in your cunt, milking it as it also cums in you.\n\n", false);

			outputText("It doesn't take long for the cock in your ass to stroke your prostate, forcing your cock to spray its cum down the tube inserted into it. Your eyes roll back in your head as it milks your testicles dry, placing the contents of your scrotum into a neat little keg, which is once more whisked away quickly by the goblin from the other room.\n\n", false);

			outputText("You pant as you are let down, the straps loosening. Once more toweling yourself off, more from cum than sweat this time, you walk out of the room, heading to the showers.", false);
		}
		flags[kFLAGS.TIMES_USED_SEX_MACHINE_AS_HERM]++;
	}
	//PREG IT UP!
	if (player.hasVagina()) {
		temp = rand(6);
		switch(temp) {
			case 0:
				player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
				break;
			case 1:
				player.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE);
				break;
			case 2:
				player.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE); //I'm betting this was meant to be dog morph chance
				break;
			default:
				player.knockUp(PregnancyStore.PREGNANCY_CENTAUR, PregnancyStore.INCUBATION_CENTAUR);
				break;
		}
	}
	player.changeFatigue(10);
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
	}
}
