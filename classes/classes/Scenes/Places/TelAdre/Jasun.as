﻿package classes.Scenes.Places.TelAdre{
import classes.GlobalFlags.kFLAGS;

public class Jasun extends TelAdreAbstractContent{
public function changingRoom():void {
	//Charge for gym if no lifetime member!
	clearOutput();
	if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("You toss ten gems to centaur and head towards the back.\n\n");
		player.gems -= 10;
		statScreenRefresh();
	}
	//AT CHANGING ROOM (1ST TIME)
	if(flags[kFLAGS.JASUN_MET] == 0) {
		outputText("You walk into the largest of the changing rooms and take a look about.  The room's walls appear to be some kind of adobe material and are rough to the touch, but flush and with few cracks.  You'd hazard that this building must be pretty new.  Looking to the right of the entrance, you find a series of rudimentary sinks and shiny metal plates on the walls above them which function as mirrors.  In front of you are six changing stalls, and immediately to your left are a few bathroom stalls.  You find it pretty practical that all of these things are together in one room, but are rather curious as to why there are so few of these rooms in the first place.\n\n");
	}
	//AT CHANGING ROOM (2ND+ TIME)
	else {
		outputText("You enter back into the largest of the changing rooms. Everything seems to be as it was the last time you poked your head in here. Everything somehow stays so clean in this particular place despite that so much sex and debauchery goes down in this city. You find it all rather refreshing, quite honestly.");
	}
	//[Look Around]
	if (flags[kFLAGS.JASUN_NAME_LEARNED] == 0)
		simpleChoices("Look Around", meetJasun, "", null, "", null, "", null, "Leave", telAdre.gymDesc);
	else simpleChoices("Jasun", meetJasun, "", null, "", null, "", null, "Leave", telAdre.gymDesc);
}

//AT CHANGING ROOM (SELECTING TO SEE THE SHARK OR LOOK AROUND IF FIRST TIME)
private function meetJasun():void {
	clearOutput();
	if(flags[kFLAGS.JASUN_MET] == 0) {
		flags[kFLAGS.JASUN_MET]++;
		outputText("As your eyes survey the room, you see a very thick figure step out from one of the changing stalls.  He is at least six feet tall from your guesstimate and has a massive barreled chest, the kind that could no doubt bench press anything the creature's own weight.  His shoulder span must be at least ");
		if(silly()) outputText("six");
		else outputText("three");
		outputText(" feet given the thickness of his muscles and how they flex passively with every tiny movement of his toned and highly desirable body.  Now that you've used the word creature to describe him, though, you find yourself drawn to the oddities that you find on this man's figure.  He has gray skin that has a sheen over it much like you'd imagine an underwater creature would have to facilitate aquatic travel.  His short and coarse silver hair is pulled back into a tiny ponytail, presumably to keep it out of the way.  A finned tail with a hook on the top fin extends from the back of his pelvis and swishes around, knocking back and forth the towel that covers his butt.  From behind, you find the swish and teasing of his chiseled ass hypnotizing... intoxicating, even...\n\n");

		outputText("Before long, you blink a couple of times and break through your prior distraction.  You can see in the mirror before the man that he has been watching your revelry of his form.  A grin plays across the man's features and within it you find several rows of razor-sharp teeth, forcing you to gulp instinctively as you think of what sort of damage those could do to your tender flesh.  ");
	
		//IF MALE
		if(player.gender <= 1 || player.gender == 3 && player.mf("m", "f") == "m") {
			outputText("\"<i>Eyes to yourself, boy. Try to play any games and I'll tear you apart limb from limb. Now get out of here before I do it anyway.</i>\" The shark-morph snarls threateningly before turning back to the mirror.\n\n");
			outputText("You doubt he'd have the nerve to murder someone here, but you feel like you've wasted your time.");

            if (silly() && player.armor == armors.BONSTRP) {
                outputText("\n\nOn your way out you pass by the drawers, where you notice someone's forgotten bondage straps, just like yours.");
                outputText("\nMaybe you should come here one more time?");
                return;
            }
            else
                strapsRouter();
            return;
		}
		//IF FEMALE
		else {
			outputText("\"<i>You're no better than the women I used to deal with, I see!  Before you assail me anymore with those daring eyes of yours, care to at least tell me your name?</i>\"\n\n");
	
			outputText("You're taken aback by his attitude.  You half expected him to turn around and rip into you like his next meal, but instead find his tone of voice very refined, like someone who has seen the worst of life and fought countless battles to get to the level he's at now.  You reply to him by giving him your name and looking sheepishly to the side, almost ashamed of sizing him up as you had, but tempted to do it again even more now.  The man shuffles back into a changing stall and you see him bend down and pull up some kind of swimsuit to be a little more modest in your presence.  He steps back out, and you can't help but let your eyes widen intensely at the sight you behold; his swimsuit barely contains what you assume is his massive penis.  Completely flaccid it's... 18 inches?  You can't tell, considering that it is practically wrapped around itself inside his skintight bottom.  You almost don't want to see him turned on while wearing that, if only because of how uncomfortable it must be.\n\n");
	
			outputText("\"<i>Excuse me, my lady, but you're staring again.</i>\"  You see that same old smirk play over his features again, clearly proud of himself being so desirable despite his attempts to play it off smoothly.\n\n");
			
			//IF FAIL FITNESS CHECK
			if(player.tone < 75) {
				outputText("\"<i>Hrm, I was going to suggest something, but quite frankly, you'd just hold me back. Maybe we'll meet each other again at some point when you're better fleshed out.</i>\" He grins and thrusts himself past you to leave the changing room. You feel flushed from contact with his skin and otherwise long to be around him more - to think, he hadn't even introduced himself.  You leave the changing room and try to get your wits back about you for whatever happens next.\n\n");
				//(+15 Lust, back to gym entrance)
				dynStats("lus", (10+player.lib/10), "scale", false);
				outputText("You book it out of there.  What a waste.");
				doNext(telAdre.gymDesc);
				return;
			}
			//IF PASS FITNESS CHECK
			outputText("\"<i>You know, looking over your form, maybe this could work out for both of us...</i>\"  As he sort of trails off, your eyebrows perk up, clearly intrigued by whatever he could possibly suggest to you.  \"<i>I've been looking for a challenge in the water... I haven't had a real challenge in a very long time.</i>\"  You aren't sure what he means exactly, especially as he's been very ambiguous with you so far, but you have a pretty good feeling what he needs of you.\n\n");
	
			//IF DONT HAVE THE BIKINI ON
			if(player.armorName != "slutty swimwear") {
				outputText("\"<i>I was going to ask you to swim with me for a bit to get my blood really pumping, but you don't look like you're prepped for swimming at all!  Come back with the right gear on and maybe we can talk more about this.</i>\"  He walks with a very justified pose out of the room, almost exaggeratedly, and brushes by you just enough to make you blush from contact with his rough, and yet very arousing skin.  The right gear? Surely he's talking about a swimsuit?  Where can you get one of those... maybe the tailor in town has one, but if not there, then maybe you'll just have to find one on your journey.\n\n");
				//(+15 Lust, back to gym entrance)
				dynStats("lus", (10+player.lib/10), "scale", false);
				outputText("You book it out of there.  What a waste.");
				doNext(telAdre.gymDesc);
				return;
			}
			//IF YOU HAVE THE BIKINI ON
			outputText("\"<i>Look at that, it's like you were ready for me the whole time!</i>\" He motions with one of his clawed fingers at your attire. You shamelessly pose in a proud manner and it causes him to laugh heartily. He seems unperturbed or even turned on by the fact that your swimsuit barely covers anything at all, almost like he's totally used to seeing people wear this kind of thing. You wonder what world he could possibly be from to end up the way he is. \"<i>Come, come with me. I have something to show you.</i>\" He walks up to you and pushes by you with his humongous frame. As he does, he grabs your left wrist with his right arm and all but drags you from the changing room to show you whatever he's talking about.\n\n");
			//[Continue]
			doNext(meetJasun2);
			return;
		}
	}
	//Met Jasun but not boned!
	else if(flags[kFLAGS.JASUN_MET] > 0 && flags[kFLAGS.JASUN_TIMES_FUCKED] == 0) {
		if(flags[kFLAGS.JASUN_NAME_LEARNED] == 0) {
			outputText("While you look around the changing room, one of the gym's other patron asks you if you're looking for Jasun.  Seeing your confusion, they describe the hunky shark guy you met before.  You nod and smile, happy to have learned his name.\n\n");
			flags[kFLAGS.JASUN_NAME_LEARNED]++;
		}
		//IF MALE
        if (silly() && (player.gender <= 1 || player.gender == 3 && player.mf("m", "f") == "m") && player.armor == armors.BONSTRP) {
            jasunGachi();
            return;
        }
		//If you're a dude.
		if(player.gender <= 1 || player.gender == 3 && player.mf("m", "f") == "m") {
			outputText("Jasun walks out of a stall, his thick and muscular figure still as glorious as the last time you set eyes upon it.  He glances your way and smirks.\n\n");
			outputText("\"<i>Eyes to yourself, boy. Try to play any games and I'll tear you apart limb from limb. Now get out of here before I do it anyway.</i>\" The shark-morph snarls threateningly before turning to walk away.\n\n");
			outputText("You doubt he'd have the nerve to murder someone here, but you feel like you've wasted your time.");
            strapsRouter();
            return;
		}
		//IF YOU FAIL TO MEET ANY OF HIS CRITERIA NOW
		if(player.tone < 75 || player.armorName != "slutty swimwear") {
			outputText("Jasun walks out of a stall, his thick and muscular figure still as glorious as the last time you set eyes upon it. As he turns to greet you, though, you notice that his smirk suddenly turns around to a sense of shock. He's noticed that you're not quite the same as you were before, and you know it. He pauses a moment before turning back toward the mirror and addressing you without eye contact.\n\n");
			
			outputText("\"<i>[name], you know, I still don't think you're quite ready to swim with me. That's fine, and it's entirely up to you, but I think today I should probably swim alone. You can come and visit me anytime, of course, maybe when you're ");
			if(player.tone < 75) outputText("fit enough");
			else if(player.armorName != "slutty swimwear") outputText("properly attired");
			else outputText("a little more compatible with me");
			outputText(", we can go swim.</i>\" He hesitates for a moment at the mirror, and then walks past you quickly without making eye contact. Feeling dejected and suddenly very alone, you ignore the sensation caused by his skin brushing against yours and walk back to the gym's entrance. Maybe you can work yourself back into Jasun's graces with time.\n\n");
			//(-15 Lust, back to gym entrance)
			dynStats("lus", -15, "scale", false);
			doNext(telAdre.gymDesc);
			return;
		}
		outputText("Jasun comes out of his stall and smiles when he sees you, already beginning to strain against the skimpy fabric of his bottom.  He asks, \"<i>Would you like to come swimming with me?</i>\" though his tone indicates that swimming may involve more than a few laps.");
		doYesNo(meetJasun2,turnAwayFromAdj);
		return;
	}
	//Repeat
	else {
		//IF MALE
        if (silly() && (player.gender <= 1 || player.gender == 3 && player.mf("m", "f") == "m") && player.armor == armors.BONSTRP) {
            jasunGachi();
            return;
        }
		//If you're a dude.
		if(player.gender <= 1 || player.gender == 3 && player.mf("m", "f") == "m") {
			outputText("Jasun walks out of a stall, his thick and muscular figure still as glorious as the last time you set eyes upon it.  He glances your way and smirks.\n\n");
			outputText("\"<i>Eyes to yourself, boy. Try to play any games and I'll tear you apart limb from limb. Now get out of here before I do it anyway.</i>\" The shark-morph snarls threateningly before turning to walk away.\n\n");
			outputText("You doubt he'd have the nerve to murder someone here, but it's clear that so long as you lack a vagina Jasun will have no interest in you.  What a waste.");
            strapsRouter();
            return;
		}
		//IF YOU FAIL TO MEET ANY OF HIS CRITERIA NOW
		if(player.tone < 75 || player.armorName != "slutty swimwear") {
			outputText("Jasun walks out of a stall, his thick and muscular figure still as glorious as the last time you set eyes upon it. As he turns to greet you, though, you notice that his smirk suddenly turns around to a sense of shock. He's noticed that you're not quite the same as you were before, and you know it. He pauses a moment before turning back toward the mirror and addressing you without eye contact.\n\n");
			
			outputText("\"<i>[name], you know, I see that a lot has changed with you. That's fine, and it's entirely up to you, but I think today I should probably swim alone. You can come and visit me anytime, of course, maybe things will be like they were before in time.</i>\" He hesitates for a moment at the mirror, and then walks past you quickly without making eye contact. Feeling dejected and suddenly very alone, you ignore the sensation caused by his skin brushing against yours and walk back to the gym's entrance. Maybe you can work yourself back into Jasun's graces with time.\n\n");
			//(-15 Lust, back to gym entrance)
			dynStats("lus", -15, "scale", false);
			doNext(telAdre.gymDesc);
			return;
		}
		//IF YOU MEET ALL CRITERIA STILL
		outputText("Jasun steps out from the stall he usually changes in, already in his skimpy swimsuit. As he turns the corner and sees you, his red eyes open up widely and his characteristic shark-toothed grin plays across his features. He's clearly very excited to see you, and greets you by rubbing his clawed finger along your cheek. The sensation is highly arousing and you lean your face into the razor that is his claw, drawing a slight droplet of blood. He licks his lips seductively, hungry for you in more ways than one, but restraining himself to only sexual advances. The sight of blood has gotten him going, but before he gets totally hard and takes you right here in the stall, he lifts you up in his arms and carries you out the door. Down the hall you go, ignoring anyone you encounter and everyone else looking on with a mix of shock and approval. Jasun practically kicks down the door into the swimming pool area and continues inside, setting you down on the edge of the pool far more gently than he carried you. Stretching his arms and flexing his fin and tail muscles, he leaps through the air into the pool and slices through the surface of the water with the finesse only an aquatic creature could muster. As he swims small circles around where he entered the pool, you kick the water's edge playfully to get his attention. Jasun, sensing the ripples in the water, surfaces a few feet from the edge and grins widely at you. You slip into the water seductively and use your arms to push your breasts together to entice him further. In doing so, you can clearly tell that you've gotten Jasun ready to go as his cock has since elongated to a very impressive size.\n\n");

		//(This is here for the same reason as before)
		//[InVagina]
		doNext(jasunSecks);
		return;
	}
}

private function meetJasun2():void {
	clearOutput();
	outputText("You and he walk together for what can't be a very long time. He winds around the back side of the gym, avoiding the weightlifting room and going past the track altogether. You didn't even know that there were areas of the gym beyond what you had previously seen. He easily pushes aside a very thick door with one arm ");
	if(player.str < 50) outputText("that you're pretty sure you couldn't have moved on your own at all ");
	outputText("and then suddenly stops. The light in the room blinds you for a moment, but then your eyes adjust and what you see makes you gasp. There's an entire swimming pool in here, and it's absolutely gargantuan! You pull away from the shark-man and walk up to the water, running your hand through it and looking about like a kid who just walked into a toy store. He walks up behind you slowly and sits down on the ledge into the pool beside you.\n\n");

	outputText("\"<i>My name is Jasun, [name]. My people love the water, but most of them are ferocious and have lost their way. Seeing as I could no longer stay with them without risking my own life constantly, I came to Tel'Adre and set about working with the gym here to set up this wondrous pool. I spend most of my time here. Not many people get to use it, but I think you are ready.</i>\" He smiles at you without baring his teeth and you're flattered, knowing how difficult that must be for something with his jaw structure. \"<i>Come, let's swim.</i>\" He puts out his hand, palm up, literally asking for your hand for him to take you into the water.\n\n");
	flags[kFLAGS.JASUN_NAME_LEARNED] = 1;
	//[Accept] [Turn Away]
	simpleChoices("Accept", acceptJasunsAdvances, "Turn Away", turnAwayFromAdj, "", null, "", null, "", null);
}

//IF YOU TURN AWAY
private function turnAwayFromAdj():void {
	clearOutput();
	outputText("\"<i>I understand,</i>\" he says dejectedly. He steps up and walks back toward the door. He perks up at the last minute, not letting his being rejected hurt his pride in the least, and says, \"<i>If you ever would like to swim, you know where to find me. Farewell.</i>\" He stands at the door and waits for you to leave before leaping into the water alone, as he has done no doubt many times in the past.\n\n");
	//(Back to gym entrance)
	outputText("You book it out of there.  What a waste.");
	doNext(telAdre.gymDesc);
	return;
}

//IF YOU ACCEPT
private function acceptJasunsAdvances():void {
	clearOutput();
	outputText("He smiles wider as you put your hand into his. He leaps into the pool with a finesse unrivaled and lets go of you just as you're over the edge and dive in yourself. You giggle and throw about your hair in the water, gleeful at being able to swim somewhere without fear of being attacked by assorted demons, slimes, or what-have-you. You swim swiftly through the water and manage to catch up to him as he rounds the second corner of his first lap. He's completely shocked at your adroitness in the water, and smiles a wicked and toothed grin as he speeds up, no longer content to hold back. You struggle to keep up, but find that he is simply designed for this kind of thing. Seeing that you are trying so hard, he lets up again, content with the challenge you've provided as you round out your first lap. He isn't even panting when he holds up and turns toward you. You're so focused on your swimming that you ram right into his chest, bonking your head and causing you to scowl a little and contort in the water to come up. As you come up, rubbing your head, you find that you are intimately close to Jasun and immediately blush.\n\n");

	outputText("From this distance, you see countless pockmarked scars on his torso, no doubt from his life before this one. You can't help yourself as you reach out to touch each one, caressing the spot gently to let him know that you understand the pain that this land can inflict on an individual. You look up into his piercing, red eyes inquisitively, and he understands instantly. He gently grasps the hand of yours that is petting his chest and speaks, \"<i>The women of my people use us males for their whims. They are merciless and cruel in their methods.</i>\" You know what he isn't telling you is that they're used for breeding purposes and instinctively turn your back to him, silently apologetic that you've been so distracted by his masculinity up to now. He pulls at your shoulders and tugs you back around to face him, clearly unperturbed by your presence. \"<i>You're different. You're not like them. You understand.</i>\" He uses one of his clawed fingers and somehow manages a gentle touch to the bottom of your chin, bringing your eyes to meet with his. You can tell that he is being sincere, and find yourself drawn into his visage. The two of you pull together, and his hand moves up to pull your head closer, and you kiss longingly, like the two of you have never kissed before. The kiss lasts for minutes, and at the end of it, you both pull away, flushed by the other's presence and closeness. Just then, while staring into his eyes, you feel a poke at your stomach and instinctively look down, shocked to find beneath the water's surface that Jasun's penis has grown to nearly two feet long and has erupted from his skimpy attire. It is a work of art, you think to yourself, noting how it is long and slender and just barely tipped at the end. It is as smoothly-flowing as his body is in water. He makes no attempt to conceal his desire to have you, and you find that you have no desire to resist him either.\n\n");
	
	//(This is here because it'd be really cool if this wins to expand it and have anal and/or blowjob scenes)
	//[InVagina]
	doNext(jasunSecks);
}

private function jasunSecks():void {
	clearOutput();
	//Increment 'times had sex'
	player.slimeFeed();
	if(flags[kFLAGS.JASUN_TIMES_FUCKED] == 0) {
		outputText("He grips your back firmly in one of his thick, clawed hands and kisses your neck thoroughly. As he does so, he uses his other hand to play with your nipples, working them up to standing on end with little to no work necessary. You gasp as he sucks on your neck, biting down with some of his front teeth slightly in order to tease you further. One of your hands reaches back behind his head, grabs his hair, and tugs. He chuckles in response, finding your aggression refreshing given how soft you've been with each other thus far. He goes back to nibbling at your neck and playing with your nipples. In response to this constant arousal, you use your other hand to start playing with his huge cock, toying with the rim and otherwise stroking his rod under the water. You notice immediately after touching it that it's slick to the touch, as if the males of his species do the lubrication. Swooning from his constant teasing torture, you stroke him up and down, fondling the large sack at the base of his dick with your fingers. He twitches in response to this, and you smile in finding some way to get back at him for his handiwork. He keeps going, but now his hand falls from your nipple down to your womanhood. As his finger trails down the length of your body, he uses one of his claws to cut an ever so thin line down your flesh, mixing pain with pleasure as you yearn for him to reach inside of you.\n\n");
	
		outputText("He reaches your silky folds, pushes aside your skimpy bikini, and reaches in with first one, and then two fingers. His claws poke you thoroughly, but manage to only add in a constant measure of pain to all of the pleasure of the experience; you don't mind at all. The more work he does on you, the more work you do on him, now gripping his shaft with both of your hands and working it ferociously. You fondle the tip and the base at once, and in response to the pain he gives you, occasionally grip hard enough to make him wince. It seems that he enjoys this sort of aggression, though, and presses into you stronger each time you do it. After a bit more work on your part, pre-cum starts bubbling out of his penis and filling the water around the two of you. It's colorless, but nearly causes you to orgasm when it hits your slick cunt, making it practically beg to be filled. You thrust your hips onto his hand, Jasun now ramming his whole hand in and out of you rhythmically, opening you up for him to enter you himself. You almost lose consciousness from the mix of his pre in the water turning you on and the pain and pleasure of your coming orgasm, but somehow manage to keep working him, tightening your grip around his head and shaft, making him grunt more frequently in response. Just then, you throw your head back in ecstasy and cum from his fisting you, and his cock erupts straight into the water at practically the same time, splashing your breasts with his juices underwater. The water seems to be warming up significantly, raising noticeably in temperature from cum mixing in with it. Sighing in release, you find yourself turned on yet again by his cum flushing your skin, and are not quite ready for this to be over. Bringing your head back down to meet his eyes with yours, he knows what you want, and you nod meekly, practically begging for him to join with you.\n\n");
	
		outputText("He uses one of his hands to steady your body in the water with your head just above the surface and his other hand to position his rod between your folds. Shifting the position of both of his hands to your waist, he thrusts so hard that your vagina practically splits from him forcing his way deep inside of you.  ");
		player.cuntChange(60,true,false,true);
		outputText("He only manages to fit in half of his length at first, but with a few more thrusts gets himself entirely inside of you, throwing you in and out of the water with each ramming. You find yourself barely able to breathe during this, as when you fall back into the water, you gurgle and gasp for air, but only manage to catch water in your lungs. The asphyxiating of his working you mixed with the painful stretching of your cunt is nearly unbearable, but is counterbalanced by the sheer euphoria his pushing into you brings. Inside of you, his cock's head pulls in on itself to thrust further and then expands outward to pull out, stroking the walls of your womanhood aggressively. Jasun grabs one of your breasts in his mouth, teasing it with a combination of his tongue and his teeth, biting it to give the nerves something to think about. His head is completely underwater now, but you, assuming that this is intentional for a shark, use one of your free hands to shove his face into your chest and the other hand to rub your free nipple sensitively. This adds to the pleasure and puts you over the edge, causing you to convulse around his dick and practically juice it of all that its worth. You cum HARD and he ejaculates straight into your womb, filling you as your cunt tries its hardest to keep everything inside of it. He bites down on your nipple a little harder than usual, drawing blood and sending him into a frenzy. Jasun thrusts hard back and forth, rocking you to your core as you orgasm and throwing you up and down a few feet each time. Your orgasm seems to extend to infinity, and he keeps cumming for more than a dozen seconds after this thrusting begins, causing you to practically bloat with his seed. As he slows down and pulls out, much of his cum sloshes out of your distended vagina, it no longer able to keep it all in anymore. You both sigh, and with one swift motion he lifts you out of the water onto the side of the pool so you don't drown from muscular exhaustion. He nibbles your ear sensually and then whispers, \"<i>Let's do this again sometime, darling.</i>\" You nod weakly and pull yourself out of the pool before you pass out, but in your last moments of consciousness see him dive into the darkest depths of the pool.\n\n");
	
		outputText("When you come to, you find that your bikini is still on and that everything seems to be in order. Collecting your things, you leave the gym and think fondly of your encounter with Jasun... And what the next encounter might entail.");
	}
	//Repeat
	else {
		//REPEAT SEX
		outputText("Jasun swims over to your lithe form and grips you by your ass. You reach both of your arms around his head and reach out to kiss him, only to pull back just at the last second and tease him with almost-kisses and licks to his rubbery, but slippery, flesh. This sets him off and causes him to grab your ass even harder, causing you enough pain to get your attention and causing you to jump in either surprise or anticipation, you can't tell. You give him what he seeks and kiss him on the lips, using your tongue to line his teeth and slightly pull some blood from you to give him just a taste. In doing so, he shifts his grip of you to using both hands and grabbing you by your hips. Jasun, no longer content with just kissing, pushes your face aside with a gentle force and throws his face into your chest. Your skimpy bikini is no match for the ferocity of this creature and he casts it aside with little effort, revealing your luscious lumps. He licks and teases them with bites until they're practically jumping off of your flesh, giving you goose bumps nearly as prominent as the nipples themselves. You don't let him get away with this, however, and grip his cock between your thighs, pumping against it with your hips. This action sets him off quite nicely, causing him to grunt in sexual arousal and buck back against you. Before long, you're both immeasurably aroused and ready to get going with the real business of this encounter.\n\n");

		outputText("He pulls back from your chest and gives you a cocky smile as he tosses you back before him a few feet. The action catches you off guard at first and forces you to paddle viciously to keep afloat. In this moment, Jasun dives below the water and circles around you, like a shark circling his prey. Thanks to your handiwork, his pre is in the water, and has gotten you hotter than ever before, ready to take his shaft deep inside of you. In moments that feel like hours, he comes up in front of you and practically impales you on his hard rod. With grace unlike anything you've ever encountered, he enters you in one fell swoop, grabs you with both arms, and thrusts the hardest you've ever been hit.");
		player.cuntChange(60,true,true,false);
		outputText("  You bob in and out of the water, practically joined at the hip to Jasun, and cum almost instantly from the brutal attack you just suffered. Still hot, you use your hips as best you can when he is in control and try to push in and out around him, squeezing his dick until he can't take anymore. He starts wincing at the work you're doing to him through his thrusts, and eventually, he cums straight into you, practically flinging you off of him with the force of the ejaculate. You orgasm and nearly pass out immediately from the motion, and he pumps back and forth into you harder than ever trying to get his cum to reach the deepest parts of your folds. Your orgasm keeps going until he finishes and bucks you off of him by letting go and pushing all in one motion.\n\n");

		outputText("You float for awhile, motionless and nearly drowning from the anesthesia of his cumming inside you. Before you go under and truly asphyxiate, however, Jasun recovers from his orgasm enough to lift you up and set you back on the edge of the pool. As he sets you down, he gently claws your left breast and grins. You barely recognize his face after the ecstasy you just experienced, but you nod as he speaks softly, \"<i>I'll see you soon, my dear.</i>\" In one swift motion he disembarks from the edge and returns to the deep underbelly of the pool, far below what you can see with your eyes at this point. You then pass out from physical exhaustion, no longer able to keep yourself together.\n\n");

		outputText("When you wake back up, you find that your bikini is next to you and that everything else seems to be fine. You put your bikini back on and look around, unable to see Jasun anywhere. You walk toward the gym's exit and reminisce of your experience today, ready for whatever your next escapade will bring.");
	}
	flags[kFLAGS.JASUN_TIMES_FUCKED]++;
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

private function strapsRouter():void {
    if (player.armor == armors.BONSTRP || player.hasItem(armors.BONSTRP)) {
        if (silly()) {
            outputText("\n\nYou remember about your bondage straps. Maybe you should try to come to the same place wearing it? It's Mareth, you probably won't get arrested.");
        }
		doNext(telAdre.gymDesc);
        return;
    }
    else {
        outputText("\n\nOn your way out you pass by the drawers, where you notice someone's forgotten bondage straps.");
        if (!silly()) {
            outputText("\nYou blink in amazement and realize that it's just a regular swimsuit.. You aren't <b>silly</b> enough to really think people come in gym dressed in  such fetish junk, are you?");
		    doNext(telAdre.gymDesc);
            return;
        }
        else
            simpleChoices("Steal Them", stealStraps, "", null, "", null, "", null, "Leave", notSteal);
    }
    		
}

private function stealStraps():void {
    outputText("\n\nYou see no witnesses right now. Quickly, you take a strange piece of clothing and put it into your bag. Maybe next time you should try to come to the same place wearing it? In the end, it reveals your muscles good enough to make someone fall for you.");
    inventory.takeItem(armors.BONSTRP, camp.returnToCampUseOneHour);
    return;

}

private function notSteal():void {
    outputText("\n\nIt's probably not a good idea to steal someone else's... <i>clothes</i>, especially where anyone can come in and see you.. maybe you can buy your own at some bazaar?");
    doNext(telAdre.gymDesc);
    return;
}
    

private function jasunGachi():void {
    clearOutput();
    outputText("Jasun is sitting on the bench facing you, dressed in leather pants. Noticing your bizarre clothing, he scowls and rises up from the bench abruptly:");
    outputText("\n\"<i>Hey buddy, I think you've got the wrong door, the leather club is two blocks down.</i>\"");

    outputText("\n\nDisgruntled by your sudden rudeness, you respond: \"<i>Fuck you!.</i>\"");

    outputText("\n\n\"<i>No, fuck <b>you</b>, leather man.</i>\"");

    outputText("\n\nYou're going to show him who is the boss of this gym! You tell him of some fucking slaves who dared to oppose you before and explain how these stories usually end.");

    outputText("\n\n\"<i>Shut the fuck up, boy next door! You like challenges? You got me mad now!</i>\"");
    outputText("\nJasun jumps you, trying to pin you down. Fuck, he's fast! You barely dodge his charge (good thing sharks doesn't have horns, or that would end badly..) to dive under his hands and slap his ass.");
    outputText("\n\"<i>Endure the lash of the spanking</i>\", you sneer at him. \"<i>Do you like that? I'll give you one more round with me.</i>\"");

    outputText("\n\nStunned after his unsuccessful attempt, the shark morph pulls up his pants and prepares for another charge.");
    outputText("\n\"<i>Get your ass back here, <b>NOW</b>! You're playing with fire!!</i>\"");

    outputText("\n\nThis time you didn't have enough time to avoid the charge and he pins you down. Trying to get out of the pin, you grab hold of something and try to pull on it.");
    outputText("\n\"<i><b>AHHHH</b></i>\" - Jasun screams and lets you go, his trousers dropping down revealing him completely. \"<i><b>YOU RIPPED MY FUCKING PANTS</b>!!! That's power, son!</i>\"");

    outputText("\n\nYou can apologize or use the possibility to attack him in return.");

    simpleChoices("Attack!", gachiFight, "Apologize", suckSomeDick, "", null, "", null, "", null);
    return;
}

private function suckSomeDick():void {
    clearOutput();
    outputText("You clearly didn't mind to do that. \"<i>Oh shit, I'm sorry</i>\" - you respond, trying to look away.");

    outputText("\n\nJasun changes his scowl for a grin. \"<i>Sorry for what? Our daddy taught us not to be ashamed of our dicks.</i>\"");

    outputText("\n\nSeeing your 'enemy' calm down, you lean on the closest drawer. \"<i>Yeah, I see that. Your daddy gave you good advice.</i>\"");

    outputText("\n\nJasun proudly stands up. \"<i>It gets bigger when I pull on it. Sometimes, I pull on it so hard, I rip the skin.</i>\"");

    outputText("\n\nYou remember your wrestling sessions in Ingnam. \"<i>Well, my daddy taught me a few things too, like, uh, how not to rip the skin by using someone else's mouth, instead of your own hands.</i>\"");

    outputText("\n\n\"<i>Will you show me?</i>\"");

    outputText("\n\n\"<i>I'd be right happy to.</i>\"");
    outputText("\n\nWithout further interruption, you decide to celebrate your reconciliation.");
    doNext(gachiFinish);
}

private function gachiFight():void {
    clearOutput();
    outputText("You're not going to lose this fight, so you prepare to jump at your distracted foe.");
    outputText("\n\"<i>Oh-ho-ho, it turns me on! Let's have one more round! I bet your ass, you won't be able to catch me this time.</i>\"");

    outputText("\n\nShark-morph throws his pants away and prepares to make the next move.");
    outputText("\n\"<i>You like challenges? <b>SHOW ME WHAT YOU'VE GOT, COLLEGE BOY!</b></i>\"");

    outputText("\n\nYou continue fighting for the next 2 hours trying to show each other who's the boss of this gym. Sadly, Heckel was late for competition.");
    doNext(gachiFinish);
}

private function gachiFinish():void {
    clearOutput();
    outputText("As the last visitors walk out of the gym, the centauress at the entrance finally finds her book and tries to read in silence... or not. Suddenly, screams are heard from the changing room.");
    outputText("\n\n<i>Yes, show me your deep dark fantasies!</i>\"");

    outputText("\n\n<i>Aw, yes, sir! Oh, I'm fucking cumming!</i>\"");

    outputText("\n\n<i>Come on, boy next door! Swallow my cum!</i>\"");

    outputText("\n\n<i><b>AAAAAAAAHHHHHHHHH</b></i>\"");

    outputText("\n\n<i><b>AAAAAAAAHHHHHHHHHHH</b></i>\"");
    player.orgasm();
    dynStats("sen", -1);
    dynStats("str", 1);
    dynStats("tou", 1);
    outputText("\n\nYou gain 300 gems from this 'battle'.");
    player.gems += 300;
    statScreenRefresh();
	doNext(camp.returnToCampUseTwoHours);
}

}
}
