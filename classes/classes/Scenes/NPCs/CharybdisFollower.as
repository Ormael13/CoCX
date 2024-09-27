/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp;
//import classes.Scenes.NPCs.Charybdis;
import classes.internals.SaveableState;
	
public class CharybdisFollower extends NPCAwareContent implements SaveableState
{
	public static var CharyAffectionMeter:int;
	public static var CharyLandShipQuestState:int;
	public static var CharyMet:Boolean;
	public static var CharySpar:Boolean;
	public static var CharySeenSkulls:Boolean;
	public static var CharySeenSkulls2:Boolean;
	public static var CharyGivenSkulls:int;
	public static var CharyAnalEnabled:Boolean;
	public static var CharyJammed:int;
	public static var CharyVocalTrained:int;
	public static var CharyAtCamp:Boolean;
	public static var CharyPreg:Boolean;
	public static var CharyKids:int;
	public static var CharyVocalNumber:int;
	public static var CharyDrumNumber:int;
	public static var CharyGuitarNumber:int;
	public static var CharyTrumpetNumber:int;
	
	public function stateObjectName():String {
		return "CharybdisFollower";
	}
	
	public function resetState():void {
		CharyAffectionMeter = 0;
		CharyLandShipQuestState = 0;
		CharyMet = false;
		CharySpar = false;
		CharySeenSkulls = false;
		CharySeenSkulls2 = false;
		CharyGivenSkulls = 0;
		CharyAnalEnabled = false;
		CharyJammed = 0;
		CharyAtCamp = false;
		CharyPreg = false;
		CharyKids = 0;
		CharyVocalNumber = 0;
		CharyDrumNumber = 0;
		CharyGuitarNumber = 0;
		CharyTrumpetNumber = 0;
	}
	
	public function saveToObject():Object {
		return {
			"CharyAffectionMeter":CharyAffectionMeter,
			"CharyLandShipQuestState":CharyLandShipQuestState,
			"CharyMet":CharyMet,
			"CharySpar":CharySpar,
			"CharySeenSkulls":CharySeenSkulls,
			"CharySeenSkulls2":CharySeenSkulls2,
			"CharyGivenSkulls":CharyGivenSkulls,
			"CharyAnalEnabled":CharyAnalEnabled,
			"CharyJammed":CharyJammed,
			"CharyVocalTrained":CharyVocalTrained,
			"CharyAtCamp":CharyAtCamp,
			"CharyPreg":CharyPreg,
			"CharyKids":CharyKids,
			"CharyVocalNumber":CharyVocalNumber,
			"CharyDrumNumber":CharyDrumNumber,
			"CharyGuitarNumber":CharyGuitarNumber,
			"CharyTrumpetNumber":CharyTrumpetNumber
		}
	}
	
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			CharyAffectionMeter = o["CharyAffectionMeter"];
			CharyLandShipQuestState = o["CharyLandShipQuestState"];
			CharyMet = o["CharyMet"];
			CharySpar = valueOr(o["CharySpar"], false);
			CharySeenSkulls = o["CharySeenSkulls"];
			CharySeenSkulls2 = valueOr(o["CharySeenSkulls2"], false);
			CharyGivenSkulls = valueOr(o["CharyGivenSkulls"], 0);
			CharyAnalEnabled = o["CharyAnalEnabled"];
			CharyJammed = o["CharyJammed"];
			CharyVocalTrained = o["CharyVocalTrained"];
			CharyAtCamp = o["CharyAtCamp"];
			CharyPreg = o["CharyPreg"];
			CharyKids = o["CharyKids"];
			CharyVocalNumber = o["CharyVocalNumber"];
			CharyDrumNumber = o["CharyDrumNumber"];
			CharyGuitarNumber = o["CharyGuitarNumber"];
			CharyTrumpetNumber = o["CharyTrumpetNumber"];
		} else {
			// loading from old save
			resetState();
		}
	}
	
	public function CharybdisFollower() 
	{
		Saves.registerSaveableState(this);
	}
	
	public function charyAffection(changes:Number = 0):Number
	{
		CharyAffectionMeter += changes;
		if (CharyAffectionMeter > 100) CharyAffectionMeter = 100;
		if (CharyAffectionMeter < 0) CharyAffectionMeter = 0;
		return CharyAffectionMeter;
	}
	
	public function charyFirstEncounter():void {
		clearOutput();
		outputText("As you walk along the beach, you hear a lone male voice, drifting in and out on the breeze. <i>\"Somewhere...Beyond the Sea…\"</i> As you get closer, you can make out some...Instruments? You remember back in Ingnam, some people played the lute, or that one guy who played the trumpet. You pad your way along the sand, peeking around a rocky cliff…\n\n");
		outputText("A lone man sits on the beach, facing away from you. Oddly, two instruments sit in some contraption, keeping them at the sides of his neck. A tentacle wraps around each instrument, holding them and pressing valves in an impressive display of multitasking. You realize that he has gills, and is using them to play. Two more flick at the wooden box he’s sitting on, making noises not unlike a drum. Suddenly, the music stops, and he spins around on his box. His arms are covered with Brass armor, lined with sharp spines, and he stands on two tentacles, his other six pulling various knives from his drum-box.\n\n"); 
		outputText("<i>\"Who are you?\"</i> He asks, his purple eyes narrowing. <i>\"Not many people come around here anymore. ‘Cept them demon folk.\"</i> Unlike his singing, his speaking voice is deep, almost husky. He spits on the sand, scowling. <i>\"Well? Speak up.\"</i>\n\n");
		flags[kFLAGS.CHARYBDIS_FOLLOWER] = 1;
		menu();
		addButton(1, "Speak", charyFirstSpeak);
		addButton(2, "Sing", charyFirstSing);
		addButton(3, "Attack!", charyFirstFight);
	}
		
	public function charyFirstSpeak():void {
		clearOutput();
		outputText("You raise your hands in mock surrender, cracking a joke about the music man and eyeing those knives of his. That gets a guffaw from the stocky octopus, and he lowers his knives. <i>\"Okay, fair enough.\"</i> He puts the knives away, looking back at you. <i>\"So, if you’re not with those horned-y orgy bastards, who are ya, and what’re you doing on the beach?\"</i>\n\n");
		outputText("You explain that you’re the champion of Ingnam, from another world, and your adventures so far. He listens intently, and when you’re done, he nods sagely. <i>\"You’re a brave soul, [name]. I only fight when I have to. Seeking them out like that?\"</i> He smiles, baring his teeth. <i>\"Almost makes me feel like getting my blades wet again\"</i>. He blinks, turning back to you. <i>\"I’m Charybdis, but my friends call me Chery\"</i>.\n\n");
		outputText("You make a little small talk, but you excuse yourself soon, heading back to camp. Charybdis seems a little put out, but waves you off, wishing you well as you head back to camp.\n\n"); 
		endEncounter();
	}
	
	public function charyFirstSing():void {
		clearOutput();
		outputText("You snap your fingers, beginning a sea shanty from your homeland. You can barely remember any of the words. Something to do with a drunken sailor? You start, and he joins in, harmonizing seamlessly and picking up the lyrics when you forget. After a verse or two, he breaks down, laughing hysterically, and you can’t help but join him. The laughter is infectious, and for a moment, you forget where you are. You keel over, laughing at the absurdity of it all, only for a black tentacle to break your fall.\n\n"); 
		outputText("<i>\"Anyone who can break out spontaneously like that, faced with nearly a dozen angry knives, no less, is good in my book\"</i>. The Scylla grins good naturedly. <i>\"I’m Charybdis, but my friends call me Chary\"</i>.\n\n");
		outputText("You introduce yourself, and the two of you chat for a little while. You excuse yourself and head back to camp.\n\n"); 
		endEncounter();
	}
	
	public function charyFirstFight():void {
		clearOutput();
		outputText("Charybdis’s eyes widen as his tendrils stop their usual playful movements, wrapping around weapons hidden inside his drum-seat. He pulls the knives free, brandishing them with the same precision he showed playing his instruments. Despite their small size, there’s eight blades, and he knows how to use them.\n\n"); 
		startCombat(new Charybdis());
	}
	public function charyWin():void {
		clearOutput();
		if (CharySpar) {
			CharySpar = false;
			outputText("Cherybdis falls backwards, tendrils splaying out on the sand around him. He tries to rise, but you’re on him before he can, your [weapon] pointed at his throat. He raises his hands in surrender, the red light faded from his eyes. <i>\"You’re good, champion.\"</i> His head lowers towards your "+(player.hasCock()?"[cocks]":"[cunt]")+", his eyes a mix of worry and arousal. <i>\"Well, I guess you have options now.\"</i>\n\n");
			menu();
			//addButton(1, "", );
			addButton(2, "Help Up", charyWinHelpUp);
			addButton(3, "Leave", cleanupAfterCombat);
			/*outputText("The Scylla grins good naturedly. \n\n");
			outputText("The Scylla grins good naturedly. <i>\"\"</i>\n\n");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");*/
		}
		else {
			outputText("The scylla is defeated, 'ops we got no text for this so come back later when we got it ^^'");
			/*if (player.canSwimUnderwater()) {
				outputText("You could take advantage of her and punish her for trying to impose herself on you. Do you rape her?\n\n");
				menu();
				addButton(14, "No", oceanScyllaWin2);
				if (player.lust >= 33 && player.gender > 0) {
					addButton(0, "Fuck Her", oceanScyllaWin3);
					SceneLib.uniqueSexScene.pcUSSPreChecksV2(oceanScyllaWin);
				}
				else outputText("You're not aroused enough to rape her.");
			}
			else {
				outputText("You could rape her but, sadly, you would have trouble fucking anything underwater without drowning in the first place. Therefore, you head back to your boat and row back to the beach.");
				*/doNext(cleanupAfterCombat);
			//}
		}
	}
	public function charyWinHelpUp():void {
		clearOutput();
		outputText("You lean down, offering the squat Scylla your hand. He takes it, and you pull the surprisingly heavy Scylla to his feet.\n\n");
		outputText("<i>\"Oh, thanks. Whoa…\"</i> He’s shaky on his tentacles, and he nearly falls over again. You catch him, and he gives you a wry grin.\n\n");
		outputText("<i>\"Kick my ass a little harder, why don’tcha?\"</i> He mutters, still smiling. <i>\"Nah, I can use the practice.\"</i> You spend a few minutes making sure he’s fine, before heading back to camp.\n\n");
		charyAffection(5);
		cleanupAfterCombat();
	}
	public function charyLoss():void {
		clearOutput();
		if (CharySpar) {
			CharySpar = false;
			outputText("You kneel, your [legs] shaking with exhaustion. You black out, and when you come to, your body itches. You sit up, but your head pounds. <i>\"Black Algae;\"</i> he explains apologetically. <i>\"Sticks to your injuries, and staunches the bleeding.\"</i> He offers you an unarmored hand, and helps you to your feet. <i>\"Sorry about that. I…\"</i> He waves his hand. <i>\"You were out for a while.\"</i>\n\n");
			HPChange(Math.round(player.maxHP() * 0.5), false);
			cleanupAfterCombat();
		}
		else {
			if (player.cor > 80) {
				outputText("You snarl your anger, sinking to your knees as the Scylla stands over you, tentacles still wrapped around his knives. His eyes have turned reddish, glowing brighter than before, and he clenches his teeth in a snarling scowl.\n\n");
				outputText("<i>\"You would have raped me, had I lost,\"</i> he mutters to himself, looking down at the sand. <i>\"Only seems fair I respond in kind.\"</i> Your head falls, and although you try to dodge, his tendrils are far too fast, wrapping around your arms and pulling you up by them. He then pushes you onto your back on the sands, easily pinning you down. You try and wiggle your [ass], presenting yourself, but this seems to anger him further. You realize, with a sudden burst of fear, that he’s still got his knives out.\n\n");
				outputText("You cry out in fear and realization as the first knife falls, the entire world turning red as the jagged edge rips through your back. You barely have time to register the pain before the second, and third, open gashes just underneath your ribs. You roll, bringing your arms up to shield your face, but the fourth and fifth open your arms up, pouring your precious blood into the thirsty sands.\n\n");
				outputText("You stop feeling anything about seven stabs in, by the fifteenth, you’re all but dead, coughing what little blood you have left from your lungs. Your arms and legs are unfeeling hunks of meat at this point, and you can dreamily see one of your ribs being pulled out of its cage. With a sudden *SNAP* you stop feeling entirely.\n\n");
				outputText("Charybdis hangs your head over the entrance to his cove, your skull providing a warning for others who’d try to harm him.\n\n");
				outputText("<b>YOU ARE DEAD.</b>\n\n");
				EventParser.gameOver();
			}
			else {
				outputText("As you sink to the ground, defeated, The short Scylla stands over you, a dark scowl on his face. His elvish ears twitch, and as he looms over you, he hits upon an idea. He grins devilishly, tendrils lifting your dead-tired body. He fishes around in his boat, pulling out a rope. He hogties you, binding your hands and feet, leaving no slack whatsoever. You struggle, but he slaps your face with his tentacle. <i>\"No.\"</i> ");
				outputText("He rumbles. <i>\"You behaved like a demon, but you aren’t one. You’re going to take your punishment and leave my home.\"</i> He wraps a much thicker rope around your torso, binding your arms to your sides, then dragging you over to a nearby tree. ");
				if (player.gender > 0) outputText("Despite (or maybe because of) the rough treatment, your "+(player.hasCock()?"[cock] begins to throb ":"")+(player.gender == 3?"and ":"")+(player.hasVagina()?"cooter begins to drool a little":"")+".");
				outputText("\n\nThe Scylla hangs you from the rope around your torso, the crude rope digging into your stomach. You can’t see him anymore, and for a few seconds, nothing happens. Then you hear a sound like a whip cracking. A burst of hot pain erupts on your back. You hold in your groan, but a second burst of pain comes in right after, making you groan in pain. He didn’t give you anything to bite down on, so as he begins slapping your ass with his tendrils, you have no choice but to moan or risk losing your teeth.\n\n");
				if (player.gender > 0) {
					outputText("You quickly lose track of time, your first orgasm hitting you like a minotaur charge to the gut."+(player.hasCock()?" Your [cock] spurts your off-white spooge onto the ground as you buck, whether from pain or arousal you honestly can’t tell.":"")+(player.hasVagina()?" Your vaginal muscles contract hard, but there’s nothing for them to milk. You drool a steady drip of vaginal fluids onto the sand below.":"")+"\n\n");
					outputText("You lose track of how many orgasms he forces out of you, your mind slipping in and out of consciousness, but ");
				}
				if (rand(2) == 0) {
					outputText("you come to with the sun almost completely gone from the sky, unbound, just outside of Charybdis’s cove. As you sit up, a pair of purple eyes gleam at you from the dark. Your armor is unceremoniously tossed at you, hitting you in the breast, and a deep voice rumbles in anger.\n\n");
					outputText("<i>\"You’re lucky. Much more corruption, and I’d have killed you.\"</i> You decide not to press your luck with the pissed off music man, donning your [armor] and beating a hasty retreat.\n\n");
				}
				else {
					outputText("you come to, wrapped in a blanket on the sand. Your clothing is right next to you, and as you look up, Charybdis looks away from you. <i>\"Sorry if I overdid it.\"</i> he mutters. You laugh, standing, still naked, and playfully slug the Scylla on the shoulder. You tell him that you asked for it, and judging from the boner he still has, he enjoyed it too.\n\n");
					outputText("Chary blushes at that. <i>\"Okay, maybe I did.\"</i> He sighs. <i>\"Just because it was you, though.\"</i> He wraps his tendrils around you in a warm (if moist) hug. <i>\"Just look after yourself [name], I don’t want any demons having that kind of fun with you, eh?\"</i>\n\n");
					outputText("You don your [armor] and leave the cove, Chary waving you off. You grin and head back to camp. You had quite a bit of fun with your Scylla pal today!\n\n");
				}
				cleanupAfterCombat();
			}
		}
	}
	
	public function charyBeachMeetings():void {
		clearOutput();
		/*if (flags[kFLAGS.CEANI_FOLLOWER] < 1 && rand(4) > 0) {
			outputText("You find yourself wandering to Charybis’s cove. You hear a female voice saying muffled words of encouragement, and the familiar Whizz *thunk* of target practice. You turn the corner to see Charybdis throwing his multiple knives, two or three at a time, while Ceani watches, her mouth full of fish.\n\n");
			outputText("<i>\"Watch your stance, you’re too far forward\",</i> she says, and then sees you. <i>\"Oh hey, it’s [name]. I’d ask if you want to join us, but that’s Chary’s call.\"</i>\n\n");
			outputText("<i>\"The more the merrier, I say!\"</i> Charybdis cries, taking a break for a moment. <i>\"Don’t worry, I’ll pay ya extra.\"</i>\n\n");
			outputText("<i>\"Not needed.\"</i> Ceani replies happily. <i>\"As long as I’m not hungry, I’m good\"</i>.\n\n");
			menu();
			//addButton(1, "Stay", charyRangedTraining);
			addButton(3, "Leave", explorer.done);
		}
		else */charyBeachMeetings2();
	}
	public function charyBeachMeetings2():void {
		if (rand(2) == 0) {
			outputText("As you near the cove where Charybdis hangs out, you hear the clash of steel, and screams of the dying. You run over, to see several demons fleeing in terror. Three lie dead, their throats slashed, and two more are gurgling, held up by the neck, their blood spilling from their throats. Charybdis turns, flinging one of the held demons in your general direction, before scuttling towards you, his purple eyes tinged with red rage.\n\n");
			outputText("The improvised projectile thankfully misses, hitting a rock, and you raise your arms. <i>\"Hey, it’s me, [name]!</i> The Scylla slams two tendrils down into the sand, nearly faceplanting, before blinking twice, apparently recognizing you. <i>\"Oh.\"</i> His black skin turns greyish. <i>\"Oh, [name]. I’m sorry you had to see that.\"</i> He turns his back, his deep voice shaking. <i>\"Lemme just deal with these.\"</i> He seems to realize he’s still holding an Incubus in one of his tentacles. He snaps its neck, chucking the dead demon back into the water. He looks at you, worried, the odd red gone from his eyes.\n\n");
			outputText("You put a hand on his shoulder and tell him not to worry. They were demons, and they attacked him, did they not?\n\n");
			outputText("<i>\"Well, yeah, but…\"</i> He scowls. <i>\"Never mind.\"</i> He tries to put a smile on his face, but it’s obviously hard for the guy. <i>\"Thanks for coming. Who knows? Next time, maybe you’ll be my hero, eh?\"</i> He bats his eyelashes, a clear mockery of a swooning maid, made all the funnier by the obvious maleness of the person doing it. You give him a laugh, and he smiles for real this time. <i>\"What can I do for ya?\"</i>\n\n");
		}
		else outputText("<i>\"Hey there [name], what’s a fine G"+player.mf("uy","irl")+" like yourself doing back here?\"</i> Despite his joking tone, he’s clearly happy to see you, and he walks over to his boat, pulling a few instruments out of the hull. Charybdis comes back, waiting for your answer.\n\n");
		menu();
		addButton(1, "Talk", charyTalk);
		addButton(2, "Hang", charyHang);
		addButton(3, "Spar", charySpar);
		/*addButton(4, "Music", charyMusic);
		addButton(5, "Sex", charySex);*/
		addButton(14, "Leave", explorer.done);
	}
	
	public function charyTalk():void {
		clearOutput();
		outputText("<i>\"Oh, you wanted to chat?\"</i> He rests his upper body on a chair made of his own tendrils, reclining happily. <i>\"What’re ya in the mood to talk about?\"</i>\n\n");
		menu();
		addButton(0, "RedEyes", charyTalkEyes);
		addButton(1, "Him", charyTalkHim);
		addButton(2, "Scylla", charyTalkRace);
		addButton(3, "Demons", charyTalkDemons);
		//addButton(4, "Towns", charyTalkTowns);
		//if (CharyAffectionMeter > 79 && CharyLandShipQuestState == 2) addButton(5, "CampJoin", charyJoinCamp);
		if (CharySeenSkulls) addButton(6, "Skulls", charyGiveSkulls);
		addButton(14, "Back", charyBeachMeetings2);
	}
	public function charyTalkEyes():void {
		clearOutput();
		outputText("His eyes narrow at that. <i>\"Look, [name]. Some people have issues, okay? Some can be worked through, others...can be managed.\"</i>\n\n");
		if (CharyAffectionMeter > 79) outputText("<i>\"...Okay, fine. I have an issue. My anger is...explosive. When something sets me off, I can just…\"</i> he sighs. <i>\"Music helps, but I don’t like fighting because of it\".</i> He gives you a worried look. <i>\"Can we talk about anything else? Like, anything else?\"</i>\n\n");
		outputText("You realise you’ve made your Scylla friend feel very self-conscious, and you change the topic.\n\n");
		doNext(charyTalk);
	}
	public function charyTalkHim():void {
		clearOutput();
		outputText("<i>\"Not much to say, really.\"</i> He shrugs, strumming on a lute. <i>\"The caves, they weren’t for me, and I longed to be free, so I...Just left.\"</i> He chuckles. <i>\"Not much to say beyond that.\"</i>\n\n");
		if (CharyAffectionMeter >= 20 && CharyAffectionMeter < 40) outputText(" <i>\"Well...I had a lot of sisters growing up, so...Had to deal with a lot of that\".</i> He rolls his shoulders. <i>\"Enough of the past, my friend. How about a song to liven the day, eh?\"</i>\n\n");
		if (CharyAffectionMeter >= 40) {
			outputText("<i>\"...Okay, I guess I can tell ya.\"</i> He looks down at his lute. <i>\"My mom and sisters wanted to trade me to another tribe. They decided that since they had too many people, and another male, they’d lump me in with some girls I’d never met, toss me out of the cave, and that I’d shack up with them, give them tons of babies, and never leave the cave.\"</i> You look at him oddly, and he throws his hands up into the air.\n\n");
			outputText("<i>\"Well, that’s what happens, when the tribe’s run by women who need their fix, and…\"</i> He stops, looking at you. <i>\""+(player.gender == 2?"I didn’t mean you. You’re cool, [name]. I just…":"")+"Not that it matters anymore, eh?\"</i>\n\n");
			outputText("You tell him that he doesn’t need to continue if he doesn’t want to, and that you’re not like them. He smiles, putting a hand on your shoulder. <i>\"No, you certainly aren’t.\"</i>\n\n");
		}
		charyAffection(5);
		doNext(charyTalk);
	}
	public function charyTalkRace():void {
		clearOutput();
		outputText("<i>\"Wanted to know about my race, eh?\"</i> He shrugs his shoulders. <i>\"Well, take a seat if’n ya want. We’re an odd race, we are. Mostly female...Well...Almost entirely female. We live in the caves, well below the waves, and we don’t need no soap to make laves.\"</i> The last few lines are sung, and he rolls his eyes at the bad rhyme. <i>\"The Anemone girls can be nice. They live around us sometimes. Now, the Orcas…\"</i> he gives you a wink. <i>\"Well, we usually don’t get along well with ‘em. Honestly, I’ve never understood why, myself. The ones I’ve met were quite nice...If a little gluttonous.\"</i>\n\n"); 
		charyAffection(5);
		doNext(charyTalk);
	}
	public function charyTalkDemons():void {
		clearOutput();
		outputText("<i>\"Nasty buggers, those,\"</i> he murmurs, stringing his lute. <i>\"Didn’t really see many of em before I came to the surface, but now…\"</i> His face darkens. <i>\"I’ve seen what they do, what they enjoy, and…\"</i> His tentacles grab at the sand, and his face darkens. <i>\"If I see any around my boat, they die. Vile things.\"</i> He rubs his chin thoughtfully. <i>\"You think I should keep a few of the skulls, maybe decorate the cove? Maybe that’d keep em out.\"</i>\n\n"); 
		charyAffection(5);
		menu();
		addButton(1, "Yes", charyTalkDemonsYes);
		addButton(3, "No", charyTalk);
	}
	public function charyTalkDemonsYes():void {
		outputText("You nod, and Charybdis gives you a thoughtful look. <i>\"Well, alright. Bring me some, and I’ll pay ya for ‘em.\"</i>");
		CharySeenSkulls = true;
		doNext(charyTalk);
	}
	public function charyTalkTowns():void {
		clearOutput();
		outputText("<i>\"Well, not sure if you’d call em ‘towns’, exactly\"</i>. He shrugs. <i>\"More like five or six families livin’ in a cave. Get a bunch of caves near each other, and you get more likelihood for anger, disputes, that kinda thing.\"</i> He shrugs.\n\n");
		outputText("<i>\"Mostly, density’s related to how many guys you can get. Usually it’s one or two in every group, and the amount of groups we have swimming around depends on how many guys we have. Reason you’ve likely never seen another before, is cuz we tend to be...well...sheltered, to put it mildly\"</i>. He shakes himself, pointing a tendril at you. <i>\"What about you?\"</i>\n\n");
		if (CharyLandShipQuestState == 0) {
			outputText("You tell him a bit about Ingnam, but quickly remember Tel’adre, that city in the desert. His face lights up as you describe the shops, the bar, the people you’ve met there...and then you gently let him know where it is.\n\n");
			outputText("<i>\"Of course, it’d be in the bloody desert,\"</i> he mutters, his tentacles wiggling oddly. <i>\"Can’t bring my boat that way. Not without...hmm…\"</i> He eyes his boat. <i>\"Could you do me a favor, [name]? I want to be able to go to this city. But I can’t leave my boat. You think you could get some wheels made? I can pull her to the city, then.\"</i>\n\n");
			menu();
			//addButton(1, "Yes", charyQuestStart);
			//addButton(2, "NotNow", charyNotNow);
		}
		else {
			
			charyAffection(5);
			endEncounter();
		}	
	}
	
	public function charyGiveSkulls():void {
		clearOutput();
		outputText("You tell Chary that you brought him some skulls, and he nods in appreciation.\n\n");
		outputText("<i>\"Aight, let’s see ‘em then.\"</i>\n\n");
		if (player.hasItem(useables.DEMSKLL, 1, true)) {
			outputText("You pull out demon skull from your bag. Charybdis takes it wordlessly, handing over the gems in exchange.\n\n");
			player.destroyItems(useables.DEMSKLL, 1, true);
			CharyGivenSkulls += 1;
			if (CharySeenSkulls2) player.gems += 100;
			else player.gems += 60;
			if (CharyGivenSkulls >= 10 && CharySeenSkulls2 == false) {
				outputText("As you pass over the skulls, he sighs. <i>\"Okay, I have a bit of a confession to make. I don’t really want to use these for decoration. Frankly, I find it abhorrent.\"</i>\n\n");
				outputText("You ask him what he wants with them, then. He isn’t making an instrument out of them, is he?\n\n");
				outputText("<i>\"Ew. No. I don’t want my music sullied with the likes of them.\"</i> Charybdis seems a little nauseated by the thought. <i>\"No…The truth is, I don’t want the skulls for anything, they’re just…proof of kill.\"</i> He rolls his shoulders. <i>\"While I kill the bastards if I have to, it takes a special kind of crazy to go out hunting the damned things.\"</i> ");
				outputText("He gives you a wink. <i>\"Crazy I like, but that’s beside the point.\"</i> He takes a deep breath. <i>\"I make quite a lot of gems performing, so I…Want to pay it forward, so to speak. Motivating those who can to kill them? That I can do.\"</i> He grins, putting a hand on your shoulder. <i>\"I’ll give you 100 from now on. Just keep giving them hell, [name].\"</i>\n\n");
				CharySeenSkulls2 = true;
				charyAffection(10);
			}
		}
		else {
			outputText("You look into your bag, but don’t find any skulls. You could’ve sworn you had some. Charybdis laughs a little, but stops quickly to preserve your pride.\n\n");
			outputText("<i>\"It’s okay, [name]. Take your time.\"</i>\n\n");
		}
		doNext(charyTalk);
	}

	public function charyHang():void {
		clearOutput();
		outputText("You tell your Scylla friend that you’d enjoy taking a break for a bit and spending some time with him. At this, Charybdis’s eyes light up, and he gives you a winning grin, his tentacle-legs moving slightly more than before. <i>\"Alright then!\"</i> He rubs his hands together. <i>\"What did you have in mind?\"</i>\n\n");
		menu();
		addButton(1, "JamSesh", charyJamOut);
		addButtonIfTrue(2, "Instruments", charyInstruments, "Req. 30%+ affection", CharyAffectionMeter >= 30);
		addButtonIfTrue(3, "Vocals", charyVocalTraining, "Req. 50%+ affection (and have less then 20 trainings)", CharyAffectionMeter >= 50 && CharyVocalTrained < 20);
		addButtonIfTrue(4, "Sail", charySail, "Req. 60%+ affection", CharyAffectionMeter >= 60);
		addButton(14, "Back", charyBeachMeetings2);
	}

	public function charySpar():void {
		clearOutput();
		CharySpar = true;
		outputText("You ask Charybdis to bring out his knives. He looks at you, his eyes saddening. <i>\"Everything, either fight or fuck.\"</i> He shakes his head, scowling. You assure him that you just want to get stronger, so you can fulfil your duties as champion. This seems to make him feel a little better, but he’s still reluctant, drawing his knives slowly. His purple eyes darken, his gills flaring up as he lowers his stance.\n\n");
		outputText("<i>\"Come on then, Champion,\"</i> he says roughly, his eyes flashing red. <i>\"Let us duel.\"</i>\n\n");
		startCombat(new Charybdis());	
	}

	public function charyJamOut():void {
		clearOutput();
		outputText("Charybdis leans back on his box-drum-seat thing, offering you one of a plethora of instruments. Picking a shell-shaker, you join Charybdis for a few songs. The merry Scylla keeps you going, and an hour passes before you know it. You excuse yourself, somewhat reluctantly, but before you can leave, he offers a vial to you, filled with a black fluid. <i>\"Thanks for the company [name],\"</i> he says simply. <i>\"If you ever want to find me in the Ocean, or grow a few extra limbs of your own, drink a few of these.\"</i> He smiles. <i>\"Or don’t. You’re fine either way.\"</i>\n\n"); 
		charyAffection(5);
		CharyJammed += 1;
		endEncounter(60);
	}

	public function charyInstruments():void {
		clearOutput();
		outputText("You ask about his instruments, and he grins his crooked grin. He walks you through several stringed instruments, a few percussion ones, and a brass tube with a funnel at the end. <i>\"I’d be happy to teach ya a few tricks, if ya want.\"</i>\n\n");
		menu();
		addButton(1, "Drums", charyDrums).hint("Percussion Training (train str+)");
		addButton(2, "Guitar", charyGuitar).hint("String Training (train spe+)");
		addButton(3, "Trumpet", charyTrumpet).hint("Trumpet Training (train tou+)");
	}
	public function charyDrums():void {
		outputText("<i>\"Oh, the drums? Good choice. It’s a great workout for your arms…But if you really know what you’re doing, it’s your wrists that gain the most.\"</i>\n\n");
		outputText("Charybdis spends an hour with you, going through the minutia of drumming. Despite your experience in slaying, you come away with your wrists burning from the workout. You feel like you could put a little more force into a blow without breaking your wrists.\n\n");
		player.trainStat("str", 5, player.trainStatCap("str",100));
		endEncounter(60);
	}
	public function charyGuitar():void {
		outputText("<i>\"Ah, there’s nothing in the world quite like a well-tuned violin, or the thrum of a cello.” Charybdis shakes himself. “Let’s start with something more…natural.\"</i>\n\n");
		if (player.hasClaws()) outputText("<i>\"No need for a guitar pick for you.\"</i> He chuckles. <i>\"You’ve got a nice set of them already.\"</i>\n\n");
		outputText("Charybdis pulls out a guitar, old and worn, and gently places it into your hands. <i>\"I’ve had that old thing since before I left the cave.\"</i> He gives you a smile. <i>\"Let’s see what we can do.\"</i>\n\n");
		outputText("For an hour, he teaches you the basics of the guitar, from chord progressions to basic runs. When you excuse yourself, you pass the guitar back, thanking him for his time.\n\n");
		outputText("<i>\"I should say the same for you,\"</i> he fires back cheerfully. <i>\"It’s nice, knowing that a busy G"+player.mf("uy","irl")+" like you is still willing to waste a bit of time with me.\"</i>\n\n");
		player.trainStat("spe", 5, player.trainStatCap("spe",100));
		endEncounter(60);
	}
	public function charyTrumpet():void {
		outputText("<i>\"Ah, the brass section. Not for the faint of heart, weak of lips, or short on air.\"</i> He laughs at his bad joke. <i>\"Not really something we used, under the sea. Passing water through these things doesn’t really work.\"</i> He shrugs. <i>\"I’m nowhere near as good with these as the others, but sure, we can mess around.\"</i> He produces two trumpets from his boat, and the two of you spend an hour or so just goofing around, making goofy sound effects and little noises with the trumpets.\n\n");
		outputText("You excuse yourself, and Charybdis looks almost disappointed. <i>\"I get it.\"</i> He says. <i>\"You’ve got your own life to live, no time to waste with the likes of me…\"</i> He then sticks his tongue out, blowing a massive raspberry through the trumpet. <i>\"Just kiddin’,\"</i> he says. <i>\"Give ‘em hell, [name].\"</i>\n\n");
		player.trainStat("tou", 5, player.trainStatCap("tou",100));
		endEncounter(60);
	}
	
	public function charyVocalTraining():void {
		clearOutput();
		outputText("Charybdis smiles as you raise the subject. <i>\"The voice is a wonderful thing, so vibrant, and changing. Every voice is unique, and…\"</i> He trails off, a tinge of red coming to his cheeks. <i>\"Sorry, you don’t want me to blather on, I’d bore ya.\"</i> You fire back that no, you’d be interested in learning. Hearing this, his smile comes back, and he hugs you with three tendrils, quickly backing off.\n\n");
		outputText("<i>\"You mean that?\"</i> He brings one hand to his chin. <i>\"Not sure how much use it’d be for you, champ.\"</i> He puffs out his chest, pride brimming in his voice. <i>\"But if you want, I can teach you how to use your voice to the fullest.\"</i>\n\n");
		outputText("You start with some breathing exercises, "+((player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3)?"not unlike the ones you’ve done with Jojo, ":"")+"before starting to hum different notes, up and down. Charybdis notes your range, and flips through a folder, filled with different pieces of music.\n\n"); 
		outputText("To your surprise, the piece he picks out fits your voice perfectly, and you don’t need to strain to hit any of the notes. After a few plays through, you find yourself singing without needing the music, and Charybdis grins, nodding in approval.\n\n"); 
		outputText("After an hour, you gently place the sheet of music back into Charybdis’s hands before excusing yourself.\n\n"); 
		outputText("<i>\"Of course,\"</i> he says simply. <i>\"Come back soon. I’d love to hear your voice more often.\"</i>\n\n");
		if (CharyVocalTrained == 4) {
			outputText("<b>Gained 'Commanding Tone' Perk: Minion and Follower Damage increased by 10%</b>\n\n");
			player.createPerk(PerkLib.CommandingTone,0,0,0,0);
		}
		if (CharyVocalTrained == 9) {
			outputText("<b>Gained 'Diaphragm control' perk: Minion and Follower Damage increased by an additional 10%, and followers will act more often</b>\n\n");
			player.createPerk(PerkLib.DiaphragmControl,0,0,0,0);
		}
		if (CharyVocalTrained == 14) {
			outputText("<b>Gained 'Vocal Tactician' perk: Minion and Follower Damage increased by another 15%. Followers will act even more frequently</b>\n\n");
			player.createPerk(PerkLib.VocalTactician,0,0,0,0);
		}
		if (CharyVocalTrained == 19) {
			outputText("<b>Gained 'Drill Sergeant' perk: Your voice and bearing now commands respect, even among the surliest of recruits. Your followers will attack an additional time per round, and are guaranteed to attack</b>\n\n");
			player.createPerk(PerkLib.DrillSergeant,0,0,0,0);
		}
		if (CharyVocalTrained < 20) CharyVocalTrained += 1;
		endEncounter(60);
	}
	
	public function charySail():void {
		clearOutput();
		outputText("Charybdis smiles as you bring up his boat. <i>\"I’m kinda glad you brought it up. I’ve wanted to take you on my craft for a while now.\"</i> The boat itself is large enough to comfortably house five people on the deck, with a clearly marked ladder to a lower deck inside. There are a variety of heavy fishing rods stored underneath the railings, and he hoists a canvas sail, clearly experienced in its use. He casts off, the salty air running through your [hair] as the boat picks up speed. After a few minutes, he pulls down the sail, turning to you and nodding respectfully. <i>\"So, what do you feel like doing, [name]?\"</i>\n\n");
		charyAffection(5);
		menu();
		addButton(1, "Fish", charyFish);
		addButton(2, "Swim", charySwimBoat);
		addButton(3, "Meal", charySushi);
		addButton(4, "Shore", charyBeachMeetings);
	}
	public function charyFish():void {
		clearOutput();
		outputText("He nods, pulling the rods out. He hands you one, then brings five out, leaning back in his odd-looking chair and using tentacles and hands to string bait and set out line. He leans back, humming, and looking out over the water contentedly. After an hour or so on the water, you’ve caught a few sizable fish, and he’s caught...Only a few more than you, despite his many rods in the water. You pat him on the shoulder, telling him that you should be heading back to camp.\n\n");
		outputText("<i>\"What?\"</i> He says in surprise. <i>\"But we just got out here!\"</i>\n\n");
		outputText("Despite his protests, he packs his rods away, bringing you back to shore.\n\n");
		outputText("<i>\"One of these days, you need to just take one for yourself, champ. If ya need a break, come back sometime. We’ll do lunch.\"</i>\n\n");
		advanceMinutes(60);
		inventory.takeItem(consumables.FREFISH, charyFish2);
	}
	public function charyFish2():void {
		if (rand(2) == 0) inventory.takeItem(consumables.FREFISH, charyFish3);
		else inventory.takeItem(consumables.FREFISH, endEncounter);
	}
	public function charyFish3():void {
		if (rand(2) == 0) inventory.takeItem(consumables.FREFISH, charyFish4);
		else inventory.takeItem(consumables.FREFISH, endEncounter);
	}
	public function charyFish4():void {
		if (rand(2) == 0) inventory.takeItem(consumables.FREFISH, charyFish5);
		else inventory.takeItem(consumables.FREFISH, endEncounter);
	}
	public function charyFish5():void {
		inventory.takeItem(consumables.FREFISH, endEncounter);
	}
	
	public function charySwimBoat():void {
		clearOutput();
		outputText("He looks at you once, before giving you a maniacal grin. With a loud <i>\"Whoop!\"</i> He wraps his tendrils around your arms before bodily lobbing you over the side of the boat. He tosses a heavy looking scrap of iron the other way before jumping in after you, splashing down in the salty water and spraying your face just as you surface.\n\n");
		outputText("The two of you laugh, playing in the ocean’s spray. He constantly cracks jokes, splashes you playfully with his tentacles, and an hour passes quickly underneath the sun. You eventually climb back onto the boat, realizing what time it is, and reluctantly tell him that you need to go. ");
		outputText("<i>\"No worries, champ.\"</i> He replies. <i>\"Just come back sometime, eh? It’s nice to talk to someone who isn’t a demon.\"</i> He brings the boat back to shore, and waves as you leave.\n\n");
		endEncounter(60);
	}

	public function charySushi():void {
		clearOutput();
		outputText("<i>\"You sure you want my cooking?\"</i> He jokes, but his eyes gleam with amusement. <i>\"Aight. You’re pretty busy, so I’ll make it a quick prep.\"</i> He goes back above, and guts a large tuna, fresh from the live net, his many knives working in concert to make quick work of the fish. He grabs a bucket from below his metal range, pulling what looks like...Rice? He makes the rice into small patties, draping the Tuna over them. Less than ten minutes from gutting the fish, he offers you a small wooden plate.\n\n");
		outputText("The tuna and rice are arranged into a rough flower, with a pile of green goop at the center. <i>\"Wasabi,\"</i> he explains. <i>\"It’s a bit spicy. Goes well with the Tuna.\"</i> He serves a plate for himself, sitting down on the side of his bed.\n\n");
		outputText("You feel a little dubious, raw fish and all, but he grins, putting a tentacle on your shoulder. <i>\"[name], it’s perfectly safe when it’s fresh like this. Besides, wasabi’s good for getting rid of bugs. Trust me, I’ve been eating this stuff for years.\"</i>\n\n");
		menu();
		addButton(1, "Try", charyEat);
		addButton(2, "NoThx", charyBeALittleBitch);
	}
	public function charyEat():void {
		clearOutput();
		outputText("The food itself is surprisingly good. The raw fish has a completely different taste and texture than its cooked counterpart, and the plain rice makes a good counterbalance to the fishy taste. The Wasabi, while a bit spicy, adds flavor to the otherwise relatively plain fare.\n\n");
		outputText("Charybdis digs in, and before long, both you and the Scylla have eaten your fill.\n\n");
		outputText("<i>\"Thanks.\"</i> You reply that you should be the one saying that, and he laughs a little. <i>\"Nah. The demons may have fucked up the farming on the surface, but the fish are as plentiful as ever. Food isn’t a problem for me. Time spent in good company is worth way more to me than the fish you just ate.\"</i> He pats you on the shoulder. <i>\"I’ll bring us back to shore. You probably need to get back to your duties, right?\"</i> You nod, and he gives you a wide smile. <i>\"Then just relax ‘til then. I’ll get us back in no time.\"</i>\n\n");
		outputText("You sit, relaxed by your full stomach, and the gentle rolling of the waves…Your eyes close…\n\n");
		outputText("<i>\"We’re back!\"</i> You sit upright, suddenly awake. Charybdis comes down the stairs, and seeing you, he holds back a laugh. <i>\"Yeah, the open water does that to me sometimes. Anyways, we’ve arrived at the cove.\"</i> You thank Charybdis, and he waves you off. <i>\"Go on, champ. Kill some demons for me, eh?\"</i>\n\n");
		outputText("You leave the boat, and head back to camp, the rolling of the waves echoing in your head.\n\n");
		player.refillHunger(50);
		charyAffection(10);
		endEncounter(60);
	}
	public function charyBeALittleBitch():void {
		clearOutput();
		outputText("You wave your hand, the concept of raw fish a little off-putting to you. He shrugs, but you can tell he’s disappointed.\n\n");
		outputText("He brings you back to shore, waving you goodbye. You head back to camp, but you feel like Charybdis will be a little less enthusiastic next time.\n\n");
		charyAffection(-5);
		endEncounter(60);
	}
/*
public function charySex():void {
		clearOutput();
		outputText("You give Chary a warm look, and step in, wrapping your arms around the stocky octopus. The Scylla’s eyes light up, a warm smile crossing his face as his tendrils wrap gently around you, teasing your (genitals if any) and (Butt description here). <i>\"Well, what’s your pleasure?\"</i>\n\n");
menu();
if (player.hasPussy()) {
addButton(1, "Bondage",CharyBondage );
}
addButton(2, "TentFun",CharyTentFun );
if (player.hasCock()) {
addButton(3, "Anal",CharyAnal );
}
if (player.hasPussy()) && (player.has ) // need to know code for Kraken/Scylla limbs.
{
addButton(4, "L.Spaghett",CharyLimbSpaghetti );
		}
	}
	
public function CharyBondage():void {
		clearOutput();
		outputText("you tell him that he could do whatever he wants, crossing your arms in front of your [breasts]. You remind him that you’re both out in the ocean, on his boat. Chary bares his teeth, a little uneasy. <i>\"I’d never do something you wouldn’t want me to.\"</i> You reassure him that you want this, but...you also don’t.\n\n");
		outputText("He nods in understanding, before lowering his voice. <i>\"The safeword is ‘Flutist’.\"</i> You nod, barely able to get the gesture out before his octopus limbs shoot out, grabbing your arms and [legs]. Two limbs twine around your forearms, pinning them together. You struggle, but a limb wraps around each of your ankles, robbing you of your leverage.\n\n");
		outputText("Charybdis walks you over to the bed. You pull at his rubbery tentacles, but a free tentacle snakes up your leg, sliding aside your [armor] and rubbing against your clit. The stimulus robs you of your movement for just a split second, more than enough time for him to get to work on your [armor]. You struggle, arms and legs thrashing, but he grins evilly, his dick clearly tenting the rubbery fabric of his vest-apron as he slowly peels off your [armor].\n\n"); 
		outputText(<i>"\"My, my, what an adorable little clam we had under this shell.\"</i> he says in a deep basso, teasing your clit more, dragging his suckers across, letting each one stick a little before moving it on. You writhe involuntarily, bringing your [legs] together. He laughs, tossing your [uppergarment] to one side instead. You open your mouth to scream, but another tendril stifles your voice. <i>\"Shh...It’s time to play.\"</i>\n\n");
		outputText("His tendrils wrap around your [breasts], kneading the soft flesh as the tips of his tentacles flick your nipples. Resistance drains from your body as the multi-pronged attack targets your most sensitive areas. One tendril tickles your lips, one prods your ass, one holds your arms together, he seems to be everywhere at once...Everywhere, you realize in horror, except for filling your needy cunt.\n\n"); 
		outputText("He toys with you for the better part of an hour, but it feels like days, kissing your lips while his tentacles caress your body, bringing you to the edge time and time again. His rock-hard, viney tendril rubs up and down your thigh, but he hasn’t put anything deeper than an inch inside you. Every time you speak up, begging him to fill you, he puts a tentacle over your mouth. You buck, trying to bring his tentacle deeper, but he pulls the slippery appendage loose without a problem, dragging it over your nose and making you inhale the scent of your own quim.\n\n"); 
		outputText(<i>"\"My my, you’re quite the needy little clam, aren’t you?\"</i> He asks, and you nod. You need him, you need something to fill your pussy, to- You’re shaking with need. <i>\"Do you want this?\"</i> His voice is deep, amused, but in your current state, all you can register is the cock pressed against your entrance. You buck again, trying to get it in, but he pulls back. <i>\"No, no. What do we say?\"</i>\n\n");
		outputText("You inhale a ragged breath before starting to beg. You scream at the top of your lungs, begging for his touch, his wiggling cock inside you. At that, he obliges, slamming it home to the base in one smooth motion.\n\n"); 
		outputText(<i>"\"CUMMING!\"</i> You howl right away, your femspunk drenching the bed. Now just along for the ride, your legs fall limp as he ravages your cunt. He pistons in and out, and your tongue lolls out as you surrender to the pleasure…\n\n");
		outputText("You come back to your senses a moment later, as your asshole gapes open. He’s stuck a flexible tendril inside, feeling your pussy through your ass. He picks you up, slamming your body back down onto him as he forces you to ride him, bucking and screaming in ecstasy. As you cum again, your eyes close, and you feel your stomach bloating as his orgasm finally comes, burying his cock deep into your womb. Your eyes roll back into your head as you fall back to the covers.\n\n"); 
		outputText("You wake up, a warm, wet feeling covering your entire body. You come to, and he’s wrapped his tentacles around you protectively. You open your eyes, and he’s staring at your sweat and cum-soaked face with concern. <i>\"Did I overdo it?\"</i> He seems genuinely concerned, and you laugh gently, cupping his face in your hands.\n\n");
		outputText("You tell him not to worry, that it was what you asked for, after all. He smiles, kissing you on the cheek. <i>\"I wasn’t sure about this\"</i>, he says simply. <i>\"I’ve never done that before...But if it was good for you...I’d be down for it any time you wish.\"</i> You both dunk in the ocean to wash the fluids from you, before he puts his vest back on. He sails you back to shore, leaving you to dress under the deck.\n\n");
		outputText("You step up into the sun as he lands the ship, but before you leave, you feel a tentacle wrap around your waist. <i>\"I hope to see you again soon.\"</i> he whispers, his voice mixing with the wind coming off the sea.\n\n");
doNext(camp.returnToCampUseOneHour);
}

public function CharyTentFun():void {
		clearOutput();
		outputText("You rub the closest of his tentacles, saying that you could get into using some of his extra limbs to have some fun.\n\n");
		outputText(<i>"\"Only if you return the favor\"</i>, he says, wrapping two of his tendrils around your feet. You shiver as his sucker-tipped limbs slither up your legs, then pull down your [armor]’s lower parts.\n\n");
		outputText("As he works, you grin, grabbing a hold on his vest-apron and tugging it over his head. With a grin, you pull it most of the way off, leaving the neck-hole over his eyes. Even blinded, he doesn’t miss a beat, dropping your (Lower Undergarment) with shocking speed.\n\n"); 
		outputText(<i>"\"So, how do you want this to go?\"</i> you pull off the apron, one finger on your lip as you consider your options.\n\n");
menu();
if (player.hasCock()) {
addButton(1, "Dick",CharyTentDick);
}
if (player.hasPussy()) {
addButton(2, "Pussy",CharyTentPussy);
}
}

public function CharyTentDick():void {
		clearOutput();
		outputText("You get your hands down onto his throbbing black tendril, and as you do, he begins to (If you have pussy) tease your clit, batting at it with the tips of his octopus-like legs. (split end) He gets to the main event quickly, though, wrapping one limb around your [cock], the slippery skin and your own slathered pre making for a comfortable, warm channel for your [cock]. He begins jerking you off with the tendril, and you buck involuntarily, his muscular limb clearly practiced at such ministrations.\n\n");
		outputText("You cum, and he supports you as your knees fold. You splatter the floor below the boat with your jizz. You stand back up, and he gives you a knowing smile, his own tentacle-shaft wriggling. \n\n");
doNext (CharySexAfterward);
}
public function CharyTentPussy():void {
		clearOutput();
		outputText("The tentacle enters your box, expanding and wiggling around inside you. His sucker-tipped tendrils pull on your insides, an odd but extremely pleasurable sensation. You gasp involuntarily as the tip of his tendril hits a certain spot near the back of your passage. Hearing this, Charybdis smiles. His tendril probes you harder, hitting that spot more frequently. Unable to hold your voice back any more, your groans and gasps begin filling the boat’s little space \n\n"); 
		outputText("Your legs give out at some point, but he lays you down on the bed, pistoning his thick viney tendril in and out of you. \n\n");
		outputText("Not one to sit idly by, you get your (legs) under you and push against the side of the bed. Surprised by the sudden movement, Charybdis falls to the floor of the yacht...and you follow him down, the tip of his slippery limb still inside you. You let out a wail as the force causes him to bottom out inside you, and he looks up, wrapping a tendril around your shoulders and pulling your upper body down to him. Your eyes shoot open as his tongue enters your mouth, and he kisses you passionately. He guides one of your hands to his black shaft, and you begin stroking, jacking your ebony-hued lover off. Wrapped up in his limbs, your pussy and mouth filled, he continues at a moderate pace, making sure to go all the way in every time. His tentacles begin playing with your clit, sucker attaching. You let out a guttural groan as he begins massaging, tweaking and pulling your sensitive button, and it isn’t long before you wail your orgasm, drenching his lower body with femspunk. \n\n");
		if (player.hasCock()) {
		outputText("Your [cock] twitches and pulses, spraying his chest and your [breasts] with cum.  \n\n");
		}
		outputText("After your orgasm, he grunts, picking up the pace. Your orgasm has left you sensitive, and each thrust begins to tip between pain and pleasure. He kisses you again, groaning into your mouth as he finally cums, his tentacles tightening around you. The one on your clit wrenches up, pulling more at your oversensitive nub. The warmth filling your womb and the sudden pleasure/pain on your clit pushes you over the edge once more. You can’t even feel your legs over the full feeling in your belly, the raw sensitivity of your lips. Your breathing is ragged, and you keel over together, his still wriggling tentacle still inside you.  \n\n");
		outputText(" \n\n");
doNext (CharySexAfterward);
}
public function CharySexAfterward():void {
		clearOutput();
		outputText("You wake up on the floor of the lower deck, your mixed fluids soaking into the floorboards. Some time has passed, and as you stretch your [legs], you feel a single sucker latch onto your waist. \n\n");
		outputText("“Did you enjoy yourself?” Charybdis asks from the floor, not even bothering to get up. He grins up at you, his signature crooked grin. “Cuz I did...mmhmm.” He’s looking up at your groin, apparently enjoying the view. You cover yourself with a hand instinctively, making him laugh. “Oh, come off it [Name], You know I like the look of ya”. He slithers to an upright position, yawning loudly. “You gotta go, huh?” You nod, beginning to explain the portal, and he raises a hand. “No need to explain. You got purpose and drive. I ain’t gonna stand in your way. Just take some time for yourself now and then, eh?” \n\n");
		outputText("\n\n");
		outputText("\n\n");
		outputText("\n\n");
doNext(camp.returnToCampUseOneHour);

public function CharyAnal():void {
		clearOutput();
		if (CharyAnalEnabled = true) {
		doNext (CharyAnalFuck);
		}
		else {
		outputText("He winces, looking away. \"Look, [Name], I’m not up for that\".\n\n");
		menu();
addButton(1, "Pry", CharyAnalPry);
addButton(2, "Drop", CharyAnalDrop);

		}
}
public function CharyAnalPry():void {
		clearOutput();
		if (CharyAffectionMeter <=90) {
		outputText(" <i>\"Look, I don't want to get into it. Just...Drop it, okay?!\"</i>\n\n");
		
		}
		else 
		outputText(<i>"\"...There’s a reason I hate the demons.\"</i> He looks at your concerned face, lowering his head in shame. <i>\"Look, when I ran away from home, I thought the surface was gonna be nice. A vacation, right?\"</i> He shakes his head. <i>\"A few months in, I’d made a friend. An Orca girl, named Frealla.\"</i> He chuckles darkly. <i>\"Really liked her, y’know?\"</i>\n\n");
		outputText("His eyes turn red again, his brass-armoured arms clenching in suppressed anger. <i>\"One day, she called out to me, from behind the treeline. She was crying. Told me that her village was being attacked. And me, the foolish, naive idiot that I was…\"</i> He looks into your eyes, his eyes now red from crying, not rage. <i>\"She was already gone. They’d taken her and...As soon as I saw those eyes, I knew. I knew she was gone, but it was too late.\"</i> He hugs himself with all ten of his limbs, rocking gently on the bed. <i>\"She’d grown a...a penis, and…\"</i> His normally vibrant voice trails off. <i>\"She...Mocked me. Slathering her juices on me while she...she…\"</i>\n\n");
		menu();
addButton(1, "Comfort", CharyAssComfort);
addButton(2, "Berate", CharyAssBerate);
}

public function CharyAssComfort():void {
		clearOutput();
		outputText("You sit down on the bed beside him, prying gently at the closest tentacle. After a few minutes, it releases. You repeat the process until you can reach his torso, wrapping your [arms] around his slippery black skin. He hugs you back, all of his limbs wrapping around you, holding you close. You keep quiet as he whimpers. Eventually, he stops, and you put your hand on his face.\n\n"); 
		outputText("You tell him that he survived, he lived, for a reason. That you’re going to save this world, and he’s got a part to play. Your gentleness seems to strike a cord in him, and he looks at you, his violet eyes shimmering with tears, but something else. For the first time, his crooked smile is straight, and he looks unblinking into your eyes. <i>\"What do you want of me, Champion?\"</i>\n\n");
CharyAffection (10); 
menu();
addButton(1, "Talk",CharyTalk );
addButton(2, "Hang",CharyHang );
addButton(3, "Spar",CharySpar );
addButton(4, "Music", CharyMusic );
addButton(5, "Sex", CharySex );
if (CharySeenSkulls = true) {
addButton(6, "Skulls", CharyGiveSkulls );
}


public function CharyLimbSpaghetti():void {
		clearOutput();
		outputText("You wrap your closest lower limbs around his, your suckers latching onto his supple flesh.\n\n"); 
		outputText(<i>"\"Oh? You like my tentacles?\"</i> He asks slyly, entwining your limbs further. Struck with a playful idea, you push off with the rest of your tentacles, wrapping them quickly around his remaining limbs. Charybdis gasps as you immobilise him and rob him of balance, forcing him down onto the bed. He begins to laugh, but you lever yourself on top of him and kiss his full lips, your [breasts] bouncing off of his burly chest with every lunge of your face. You wrap a tendril around his slick member as it hardens, and he lies back on the bed. One of his tentacles runs along the crack of your ass, but he waits for you to make the first move.\n\n");
		outputText("You lower yourself onto him, your lips parted ever so slightly by his tip. Struck by a mischievous thought, you lower yourself about an inch down, then back up, so slowly. After the first few times, he tries to rise, bucking his hips, but you see it coming, pulling yourself away.\n\n"); 
		outputText("<i>\"Ah ah\"</i>, you tease, putting a finger to his lips. <i>\"When I’m ready\".</i> You continue with the slow tease for another five minutes, but at the pleading look on his face, you decide to stop teasing him. You take a dollop of his pre with your tentacle, slathering your entrance. You lower yourself slowly onto him, gasping slightly as he parts your lips. He slides in smoothly, and as you revel in the feeling of being filled, he grins, twining his tentacles around each of yours. The added contact, the rubbing of smooth skin, feels wonderful, and as you open your mouth, he spins you around, gently pressing your back against the wall. He moves, your wet, tight channel clamping down on him.\n\n");
		outputText("Two of his tentacles wrap around you, one around your waist, one around your heads, cutting off your vision of everywhere except for him, his violet eyes right there, so close to yours as he kisses your cheek. His limbs are suddenly everywhere, one on each of your (breast description), pulling on your nipples, one hotdogging your [ass], two more like warm, squishy bands around you, kneading your back and neck. You’re far less experienced than he is with your many limbs, but you try and return the favor, imitating his posture and pace, kneading the muscles and tracing his barrel-chest.\n\n"); 
		outputText("As you return the favor, his eyes smoulder, and he kisses you, first on the lips, then slowly, surely, he moves down to your neck. As he runs his lips along the soft front of your throat, you shudder, moaning slightly. It takes a few minutes for you to even realize that he’s stopped moving his cock inside your box, leaving it halfway in. You give him a kiss back, going in reverse, from his barrel-chest back up to his thick lips. As you kiss his lips, he leans in, pinning you against the wall, continuing his slow, sensuous pace, his head scraping every fold of your pussy, every limb in use as it caresses your entire body. Your nipples puff up, the areolae like nubs of iron. Your clit aches with all the tweaks and pressure. After about fifteen minutes of this slow, sensous torture, you can’t take it anymore. You slam your pelvis down as you push with your arms, pinning Charybdis down onto the bed as you pull back again.\n\n"); 
		outputText("He quickly picks up the pace, and the multi pronged attack on your senses takes its’ toll. You howl, cumming hard onto his squirming cock-tendril. You slump, and he takes over, ravaging your box as fast as he can. You’re sensitive, and you try to communicate that, but all that escapes your mouth are the moans and howls of a bitch in heat, getting the dicking she didn’t even know she wanted. Your tentacles flail, some trapped underneath him as he pounds you from below. His cock twitches inside you, and you can feel the impending orgasm. You wrench, trying to get off this crazy, amazing ride before-\n\n"); 
		outputText("You feel the warmth flood you, your tentacles instinctively moving to your box, to fill it, to stop the flow, to stop him leaving you...But despite your instincts screaming at you, he doesn’t try to pull out. You collapse on top of Charybdis, both of you panting uncontrollably.\n\n"); 
		outputText(<i>"\"Uh…\"</i> You moan, trying to get words out, and he nods, your limbs entwined.\n\n");
		outputText("<i>\"Yeah…\"</i> He falls asleep, and for the life of you, you can’t think of anything better to do right now.\n\n");
		outputText("You wake up in Charybdis’s bed. He stands, butt naked, by the cutting board, and he turns around as you groan. <i>\"Hey, are you okay?\"</i> He asks, taking your hand as you sit up. <i>\"I hope you at least enjoyed yourself.\"</i> You rub your aching mons and grin ruefully, telling him that of course you did, otherwise you wouldn’t have gone off like that.\n\n");
		outputText(<i>"\"Look...If you got pregnant…\"</i> You blink. You hadn’t even thought of that! Before you can open your mouth, he puts a hand on your shoulder. <i>\"I’ll come by your camp in a week or so. If you are, I’ll...Well...I’ll look after ya, okay?\"</i> He hugs you, still naked, and rests his head on your shoulder.\n\n");
		outputText(<i>"\"You’ve got to go now, don’tcha?\"</i> He asks. You nod, and he inhales, closing his eyes. <i>\"Well, we gotta get back to shore, then. I’ll throw on my apron and get us back. Take what time you need to get...clean.\"</i> He kisses you once more, a chaste kiss on the forehead, before doing exactly what he said, throwing on his smocklike garb and clambering back up to the deck.\n\n");
		outputText("You leave the cove, and you can feel his eyes following you. You turn back around, and he waves goodbye. <i>\"Come back soon, [name]!\"</i> You head back to camp, a smile on your face.\n\n");

}

public function CharyAnalFuck():void {
		clearOutput();
		outputText("You tell him that Anal is a lot of fun, when done right. He looks at you, hesitantly, but he squares his shoulders, looking you in the eyes. <i>\"I trust you, [Name]. I...can’t promise I won’t pussy out on ya, but...If it’s you, I’ll give it a shot.\"</i> He lays down on his bed, back up, spreading his legs for you. <i>\"But...I want to be able to see what’s going on\".</i>\n\n");
		outputText("You nod, leaning down over the bed, placing a kiss on his thick lips. You assure him that you won’t hurt him, and if he doesn’t want to continue, you’ll stop. He seems to relax a little, and as you straighten up, rubbing your [cock] against his slick, gropable behind, he breathes a little heavier, his tendrils twitching, trying not to lash inward.\n\n"); 
		outputText("You grasp one of those tendrils, rubbing the smooth skin along its length while your other hand dips down to his nethers. A single finger slides smoothly in, then another. He wriggles a little, clearly trying to let you have your fun, and you chuckle at his sensitivity. Rubbing a little bit of pre from your own throbbing member, you slather it along your length. You prod his pucker, and he watches, a mixture of fear and pleasure on his face.\n\n"); 
		outputText("Your [cock] slowly forces his asshole open, each twitch and groan from your Scylla lover a fresh motivation to continue. You finally bottom out, and looking up, you can see his eyes, glazed over, staring at yours. You ask him if he wants to continue, and he looks back, his eyes momentarily focusing. He smiles, before his tendrils wrap around your waist and shoulders, massaging your thighs, abs and shoulders. You groan at the feeling, pulling back before ramming your [cock] home again.\n\n"); 
		outputText("You pick up the pace, each thrust getting you another breathy exhale or groan from the Scylla. He wraps one tentacle around your hand, leading your fingers to his own member, swollen with blood and desperate for release.\n\n"); 
menu();
addButton(1, "JerkHim", CharyAnalJerk );
addButton(2, "Nah",CharyAnalNah );
}
	public function CharyAnalNah():void {
		outputText("You flick his rubbery dick away, and he begins tending to it himself with another tendril. You focus on pounding your Scylla lover’s rear as hard as you can, and one by one, his tendrils begin to fall limp as he leans back, insensate at the pounding you’re giving him. You realise the tendrils that he’s standing on are about to give out, and you wrestle his upper body down onto the bed. He comes first, soaking your nethers with his cum. The warm fluid and sudden smell pushes you over the edge, and you empty your balls with a roar, pulling your lover back against you, his body weight keeping you bottomed out inside him. His stomach bulges out a little before your cum begins to trickle out, and you pull out, exhausted. Between the two of you, you stagger back to his bed, plopping down exhausted next to each other.\n\n"); 
		outputText(<i>"\"That...Was good.\"</i> Despite his misgivings, the breathless Scylla evidently had a good time. <i>\"Thank you, [name].</i>\"  He slides a tentacle under your head to use as a pillow, and between the warmth of the Scylla and the post-nut exhaustion, you fall asleep\n\n");
		outputText("You come to, still in his bed, a moment later. Charybdis is standing, tentacles spreading his ass. Your seed spills from his behind, and he looks over at you, his face turning bright red. <i>\"Sorry\"</i>, he mutters. <i>\"Couldn’t really get comfortable, since...Y’know.\"</i> You laugh at the look on his face, and he shakes his head. <i>\"Laugh it up, asshole\".</i> he says, but the slight smile on his face takes the sting out of the language. You get up, hugging your Scylla lover, and he sighs happily, wrapping four tendrils around your still naked body.\n\n");
		outputText(<i>"\"You’ve got to go now, don’tcha?\"</i> He asks. You nod, and he inhales, closing his eyes. <i>\"Well, we gotta get back to shore, then. I’ll throw on my apron and get us back. Take what time you need to get...clean.\"</i> He kisses you once more, a chaste kiss on the forehead, before doing exactly what he said, throwing on his smocklike garb and clambering back up to the deck.\n\n");
		outputText("You clean up, and join Charybdis at the helm of his ship. He grins, giving you a nod, and you stand beside him, putting a hand on his shoulder as he steers you back. You step off the boat, and you can feel his eyes following you. You turn back around, and he waves goodbye. <i>\"Come back soon, [name]!\"</i> You head back to camp, a smile on your face.\n\n");
		
}

	public function CharyAnalJerk():void {
		outputText("As you wrap your fingers around him, Chary’s groans increase. You feel his other tendrils playing with your body, [breasts], and even groping your [ass] as you continue to nail his tight rump. Eventually, you can’t contain it anymore, and your [cock] explodes, painting the Scylla’s asshole white. At nearly the same time, he lets out a roar, and his own 13’ spasming tentacle shoots a deluge of cum into the air, splashing down against both of your bodies. Your knees weaken, and his tentacles pull you out of him, then down onto the bed beside him, where his arms wrap lovingly around your waist. He pulls you in for a tender kiss, and you return the gesture, wrapping an arm around his shoulder so the stocky guy can use it as a pillow. Your spooge leaks out onto the bed, but the Scylla doesn’t seem to give a shit.\n\n"); 
		outputText("\"That...Was good.\" Despite his misgivings, the breathless Scylla evidently had a good time. \"Thank you, [name].\"  He slides a tentacle under your head to use as a pillow, and between the warmth of the Scylla and the post-nut exhaustion, you fall asleep\n\n");
		outputText("You come to, still in his bed, a moment later. Charybdis is standing, tentacles spreading his ass. Your seed spills from his behind, and he looks over at you, his face turning bright red. \"Sorry\", he mutters. \"Couldn’t really get comfortable, since...Y’know.\" You laugh at the look on his face, and he shakes his head. \"Laugh it up, asshole\". he says, but the slight smile on his face takes the sting out of the language. You get up, hugging your Scylla lover, and he sighs happily, wrapping four tendrils around your still naked body.\n\n");
		outputText("\"You’ve got to go now, don’tcha?\" He asks. You nod, and he inhales, closing his eyes. \"Well, we gotta get back to shore, then. I’ll throw on my apron and get us back. Take what time you need to get...clean.\" He kisses you once more, a chaste kiss on the forehead, before doing exactly what he said, throwing on his smocklike garb and clambering back up to the deck.\n\n");
		outputText("You clean up, and join Charybdis at the helm of his ship. He grins, giving you a nod, and you stand beside him, putting a hand on his shoulder as he steers you back. You step off the boat, and you can feel his eyes following you. You turn back around, and he waves goodbye. \"Come back soon, [name]!\" You head back to camp, a smile on your face.\n\n");
		

}
	}
*/
}
}