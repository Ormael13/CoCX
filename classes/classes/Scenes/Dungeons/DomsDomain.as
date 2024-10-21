/**
 * Story Dungeon: The Demon's Laboratory
 * @author Canadian Snas
 */
package classes.Scenes.Dungeons {
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Races;
import classes.Saves;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.SaveableState;

//Things that will need to be put in other files
//Enemies
//
public class Domsdomain extends DungeonAbstractContent implements TimeAwareInterface implements SaveableState {
    public static var CeraphHumiliation
    public static var CeraphState //1 for in charge, 2 enslaved by Meila 3 public usage 4 hatrack Ceraph
    public static var DomainProfit
    public static var MeilaTrust
    public static var MeilaCeraphSubmissiveness
    public static var EmeraldConfidence
    public static var EmeraldResiliance
    public static var EmeraldFearsCeraph
    public static var SeenCeraph
    public static var SeenDDullahan
    public static var SeenEmerald
    public static var ZetazState //0 for dead, 1 for enslaved, 2 for free, but unseen, 3 for seen here and permitted to stay
    public static var SeenPotionShop
    public static var NolanMet
    public static var WhosInCharge //1 for Ceraph, 2 for Meila, 3 for Nolan
    public static var NolanQuest1State 
    public static var NolanQuest2State
    public static var NolanQuest3State
    public static var NolanQuest4State
    public static var NolanQuest5State
    public static var NolanQuest6State
    public static var NolanQuest7State
    public static var NolanQuestTaken //
    public static var DDullahanTemplateNum //Number of free templates you have
    public static var DDullahanImprintNum //Number of different imprints you have for transplanting
    public static var 
    public static var
    public static var
    public static var
    public static var

    public function resetState():void {
        
    }

    public function stateObjectName():String {
        return "Domsdomain";
    }

    public function saveToObject():Object {
        return {
            
        }
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            
        } else {
            // loading from old save
            resetState();
        }
    }

    public function Domsdomain() {
        Saves.registerSaveableState(this);
    }

    //========================================================
    //Room Code
    //========================================================
    public function EnteringDungeon():void {
        clearOutput();
    
    }

    public function EntertheDomain:void {
        dungeonLoc = DUNGEON_LAB_ENTRANCE;
        clearOutput();
        outputText("You approach the demon’s former lab. The stairs have been polished, handrails added. Lamps have been placed periodically, pink flames burning inside heart-shaped, black steel cages. You’d never have known this place was once supposed to be a secret. You shake your head, making your way to the Former Lab’s secret entrance.  \n\n");
		outputText("Several dozen demons are lined up outside, and a brawny zebra-morph stands guard. Apparently, the place has already become popular. He sees you, and as you near the entrance, he holds up his hand to the other demons.  \n\n");
		if (WhosInCharge == 1 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("“"+ player.mf("master", "mistress") +" [name], welcome to the Dom's Domain. Please enjoy your stay, and be sure to give my regards to Mistress Ceraph.” A flat-chested succubus starts to protest, but he waves you through. As you enter, you hear the bouncer raise his voice. “"+ player.mf("master", "mistress") +[name]" killed Lethice’s best, you half-baked mosquito, and was gracious enough to let us have this place! Mistress Ceraph was EXTREMELY clear on this-!”  \n\n");
		outputText("You leave the zebra-morph to his argument. You’ve got better things to do.\n\n");
        }
        if (WhosInCharge == 2 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("A few dozen demons and various shady citizens of Mareth are lined up outside. A single bouncer watches the lot…but you can tell that this one bouncer is easily worth a dozen demons. He stands nearly fifteen feet tall, with the legs of a Drider, the head of a dragon, the arms of a displacer beast, and three tails, one salamander, one hydra, and one, oddly enough, vastly oversized fox tail, which he seems to be busy caressing with every hand he has, while occasionally waving someone through. As he sees you, however, he quickly lowers his hands, straightening up and giving you a low bow. \n\n");
		outputText("“"+ player.mf("master", "mistress") +" [name]. Welcome. Please enjoy your time here, and if there are any problems, feel free to call upon me and my colleagues to resolve such issues.” He opens the door for you, and you give the bouncer a pat on his furry tail as you pass. “Th-thank you”, he says, shuddering as he returns to his post. \n\n");
        }
        if (WhosInCharge == 3 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("A half-dozen demons mill around outside the Dom’s Domain, blocked from entry by two smaller, suit-clad demons with sleek black pistols on their hips. Several well-dressed imps, also armed with pistols, perch on the neighboring cliffs.  \n\n");
		outputText("“Sir/Ma’am, welcome to the dom’s domain.” One of the demons greets you, opening the door. One of the demons tries to join you, only to have several pistols pointed at them. \n\n");
		outputText("“You have been banned from the premises. Further attempts to enter will be met with force.” \n\n");
		outputText("You thank the suit-clad demons, who give you a simple salute as you enter. \n\n");
        }
        if ( model.time.hours > 18 && model.time.hours < 6) {
        outputText("The doors are closed, but as you draw near, Ceraph’s charm glows, and they open automatically. The silence is a stark contrast to the usual overwhelming noise. The doors close behind you, and you hear the scraping of a few chairs, and a few muffled moans and giggles coming from deeper inside the place. \n\n");
        }
			dungeons.setDungeonButtons(Mainhall1, null, null, null);
            addButton(11, "Leave", LeaveDungeon);
    }


    public function Mainhall1:void {
        clearOutput();
        dungeonLoc = DUNGEON_LAB_BALLROOM_1;
        outputText("The sterile-steel floors of the lab’s entryway have been replaced by ornate tiles, etched with exaggerated, sexualized forms. A single, ten-foot-wide reddish mat is in the middle, covering the floor from the door to the main entrance…as you walk on the mat, you realize…it’s textured to feel like a giant pussy, the folds not damp, but warm under you, nonetheless. \n\n");
		if (WhosInCharge == 1 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("A few burly minotaurs eye you as you walk past, one seemingly interested in your groin, but nobody makes a move. The doors leading into the once-ballroom open as you draw near. \n\n");
		outputText("As you step down a few stairs, the noise hits you all at once. Loud, thumping music, the clink of glasses, the moans of the debilitatingly aroused…Ceraph’s turned the former lab into a massive, rollicking compound. Just in the former ballroom alone you can see a strip club at the far end with a massive stage, a dance floor below it, and closer to you is a dining area.  \n\n");
        }
        if (WhosInCharge == 2 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("A single, large chimera-demon gives you a once-over. His Scylla tentacles are actively penetrating one of Meila’s chimeric goblins, but the gazer eyes on his back are constantly scanning the area. He gives you a nod, lowering the goblin onto his groin as he opens the door with one hand. \n\n");
        outputText("As you step down a few stairs, the noise hits you all at once. Loud, thumping music, the clink of glasses, the moans of the debilitatingly aroused…Ceraph’s turned the former lab into a massive, rollicking compound. Just in the former ballroom alone you can see a strip club at the far end with a massive stage, a dance floor below it, and closer to you is a dining area. \n\n");
        }
        if (WhosInCharge == 3 && model.time.hours >= 6 && model.time.hours < 18) {
outputText("Several bat-like gargoyles stand between you and the door inside, wielding pikes that they cross in front of the door. As you approach, they straighten up, the door swinging open soundlessly.  \n\n");
        outputText("As you step down a few stairs, the noise hits you all at once. Loud, thumping music, the clink of glasses, the moans of the debilitatingly aroused…Ceraph’s turned the former lab into a massive, rollicking compound. Just in the former ballroom alone you can see a strip club at the far end with a massive stage, a dance floor below it, and closer to you is a dining area. \n\n");
        }
        if ( model.time.hours > 18 && model.time.hours < 6) {
        		outputText(" \n\n");
        }
        dungeons.setDungeonButtons(MainHallSouth, (EntertheDomain DDullahanCheck, null /*ArmouryCheck*/);
    }

    public function MainHallSouth():void {
        dungeonLoc = DUNGEON_LAB_BALLROOM_2;
        clearOutput();
        if SeenEmerald = false {
        outputText("As you enter the section, a scantily clad omnibus greets you. She has four displacer arms, a pair of modest B cup breasts, and while her bikini bottom is cut open to reveal her cock and glistening pussy, her human-like cock is only 2 inches long. She has wide red eyes, shining with moisture, and her knees tremble.  \n\n"); 
		outputText("“"+ player.mf("master", "mistress") +" [name], I presume?” She bites her lip, shuddering slightly. “My name is Emerald, but please, call me Em. If you want anything in the restaurant, please talk to me.” A passing demon slaps her on the ass, and she winces.   \n\n");
		outputText("The bar is over there, and the two labs have been converted. One is the Merchant’s…Hng!” She turns around, giving you a clear view of her juicy ass…and the currently vibrating pink toy stuck into it. “I’ll be r-right there! Just give m-me a second!” She shudders. “...Quarter, and there’s a brewery to the west, over there. N-now, I need to go s-serve some drinks.” You notice, as she walks off, that the demon she’s walking over to has a remote in his hand, and that he’s pressing the button repeatedly. Apparently, this restaurant has more than one type of service. \n\n");    
        }
        else 
        if (model.time.hours >= 6 && model.time.hours < 18) {
        outputText("you see a rather plain looking demon in a suit and tie, sitting in the corner. He sips on a cup of coffee, and seems to be entirely focused on the device in front of him. Occasionally he looks up at the lewd goings-on around him, and while the expression on his face barely changes, you get the distinct feeling that he thinks little of the demons around him \n\n");
        }
        if (ZetazState=2 && model.time.hours >= 6 && model.time.hours < 18) {
		outputText("An exhausted-looking, yet very muscular imp lord catches your eye. To your surprise, it’s Xetaz. Apparently, Lethice’s luckless lackey found his way here. From the looks of things, he appears to be acting as some kind of bouncer here. \n\n");
        }
        if (ZetazState=3 && model.time.hours >= 6 && model.time.hours < 18) {
		outputText(" \n\n");
		outputText(" \n\n");
        }
        dungeons.setDungeonButtons(StripperThrone, Mainhall1, FireCheck, IncelLab);
    }

    //TODO: fix fucking italic font

    public function IncelLab():void {
        dungeonLoc = DUNGEON_LAB_INCEL;
        clearOutput();
        
        dungeons.setDungeonButtons(null, null, MainHallSouth, null);
    }

    public function FSpreaderLab():void {
        clearOutput();
		dungeonLoc = DUNGEON_LAB_FSPREADER;
       
    }

    public function StripperThrone():void {
        dungeonLoc = DUNGEON_LAB_BALLROOM_3;
        clearOutput();
        outputText("This section of the main hall has been altered the most from its time as Lethice’s lab. The ballroom has been replaced with glowing pink and black tiles, and the back quarter of the room has been raised into a massive stage, split into sections by large, fancy poles. Music pulses through several devices behind the stage, upon which dance a half-dozen fully naked succubi.\n\n");
        outputText("Several cages float above the stage, a dozen more demons dancing within. Occasionally, the cages lower, and one of the demons on the ground pulls the dancer from the cage. The dancer and the demon then swiftly move to the East, where Project Nightwalker once was, going through the iron door. Almost as quickly, another demon steps into the cage, and it raises towards the ceiling as the demon within begins to dance.\n\n");
        if (SeenCeraph = false) {
            outputText("Ceraph stands, waving a hand. The music slows, fading out over a few seconds. Some of the demons mutter, but she leans down, another demon offering her a small device. \n\n");
            outputText("“Demons and sinners!” She declares warmly. “My eyes do not deceive me. We have a very special guest here today!” She points to you, and the crowd parts. “"+ player.mf("master", "mistress") +" [name] is here!” She pauses as some of the demons mutter, apparently not happy to see you. “Now, now, whores and gentledemons…While some of you may have had…some run-ins with our patron here, they’re the ones responsible for clearing out this lovely place for us. Give them a warm welcome!” She titters. “After all…We wouldn’t want any…unfortunate accidents to befall anyone, now would we?” \n\n");
            outputText("This gets some applause, and none of the assembled demons seem willing to tangle with you…But Ceraph is clearly just using you and your strength to further her own agenda. How do you react?\n\n");
            menu();
        addButton (1, "Humiliate", CeraphHumiliateFirst);
        addButton (2, "Acknowledge", YeahWhateverCeraph);
        addButton (3, "Reprimand", HellnoImTheBossCeraph);
        addButton (4, "Bow", ShowCeraphSupport);
        }
    if (SeenCeraph = true && WhosInCharge == 1 ) {
        if (SeenCeraph = true && model.time.hours >= 6 && model.time.hours < 18) {
            if (CeraphHumiliation <= 40) {
        outputText("\n\n");
            }
            if (CeraphHumiliation > 40 && CeraphHumiliation < 60) {
        outputText("Ceraph lounges on her throne, but her expression is slightly strained. A few of her larger bouncers are positioned between her and the demonic horde, acting as a crude queen’s guard.\n\n");
            }
            if (CeraphHumiliation >= 60) {
        outputText("Ceraph, in her deep-necked crimson dress, lies on a comfortable pillow at the foot of the dark violet throne. She occasionally looks around nervously, as if some of the other demons have been forceful with her. Clearly, she’s no longer really in control. \n\n");
            }
            if (CeraphHumiliation <= 20) {
        outputText("Her eyes meet yours, and her wicked little smile grows slightly. She nods her head, as if acknowledging your presence, before turning her attention back to the party, surveying her realm like a demonic queen.\n\n");
            }
            if (CeraphAffection > 30) {
            outputText(" \n\n");
            }
             if (CeraphHumiliation =< 20 && CeraphHumiliation > 41) {
        outputText("Ceraph sees you, and she inclines her head, acknowledging your dominance. \n\n");
            }
            if (CeraphHumiliation =< 41 && CeraphHumiliation > 60) {
        outputText("As Ceraph sees you, her eyes widen slightly, and her knees shrink inwards. Apparently your demon-slut remembers her last lesson. \n\n");
            }
           dungeons.setDungeonButtons(CheckThePanicDoor, MainHallSouth, null, DemonWhorehouse); 
        }
    }
         if (WhosInCharge == 2 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("The throne lies empty, waiting for you. Meila is presumably managing her part of the business, as nobody else has her expertise. The party rollicks wildly, and several of the dancers seem to have additions they didn’t have before\n\n");
        outputText("\n\n");
         }
         if (WhosInCharge == 2 && model.time.hours > 18 && model.time.hours < 6) {
        outputText("Meila looks down from the throne that had once been Ceraph’s. As she sees you, her eyes light up, and a smile forms on her pale face. Her head detaches, floating over to you, and she rests her head on your shoulder.\n\n");
        outputText("“Hello there, "+ player.mf("master", "mistress") +"” Meila whispers. “If you require anything, just ask. Otherwise, enjoy your stay.” Her head floats over the few demons left after-hours as they wind down the Domain. You notice that more of them are sporting body modifications.\n\n");
         }
        if (WhosInCharge == 3 && model.time.hours >= 6 && model.time.hours < 18) {
        outputText("The throne lies empty, waiting for you. Your subordinate, Nolan, is nowhere to be seen. You assume that the Nullcubus is in the back room, or is working on his experiments somewhere. The party continues unabated, regardless of the more prudish leadership.\n\n");
        }
        var choice0:Number = rand(2);
			switch (choice0) {
				case 0:
				outputText("Two burly male demons stand behind a raised dais, headphones on their ears. One pumps his fists into the air, and the music swells. You can barely hear anything, and the demons on the ground jump, bump and grind on each other. \n\n");
					break;
				case 1:
					outputText("Several succubi beckon, and a few of the demons on the floor join them onstage. A few begin making out, one of the incubi openly fingers his dancer. One of the dancers shimmies up her pole, wrapping her slender legs around her incubus’s neck, and letting him lick her. After a few moments, the dancers, in unison, filter off the stage, taking their chosen toys with them. \n\n");
					break;
                
			}
            var choice0:Number = rand(2);
			switch (choice0) {
				case 0:
				outputText("Several scantily clad demons filter through the crowd, carrying drinks on trays. Swiftly, they’re mobbed by the crowd on the floor, who begin grabbing drinks from them. Not even a minute later, the trays are empty, and the party resumes, at a slightly increased pitch.\n\n");
					break;
				case 1:
					outputText("You catch sight of a few succubi with rabbit ears and puffy tails sauntering through the crowd, wearing little more than tit-stickers and sheer panties. One looks at you, biting her lip, before following the odd procession eastward. \n\n");
					break;

			}

        outputText("\n\n");
        dungeons.setDungeonButtons(CheckThePanicDoor, MainHallSouth, null, DemonWhorehouse);
    }
    private function CeraphHumiliateFirst():void {
        clearOutput();
        outputText("Ceraph’s insinuation, using you to further her own ambition? That cannot stand. You smile darkly, making the demons closest to you back away. You take the stage, and as Ceraph steps down to join you, smugly glaring down at a few of the demons, you step in close. One of the Incubi catches your eye. A smaller specimen, but the anger in his eyes is genuine. He stares at Ceraph openly, then glares at you, so close. A wicked idea pops into your head, and you give the incubus a wink.  \n\n");
		outputText("Right before you grab Ceraph by the neck, sweeping her legs out from beneath her and slamming the Omnibus into the stage floor. Shocked, Ceraph coughs and begins to struggle, but you’ve beaten her so many times already. She knows she’d lose.  \n\n");
		outputText("You glare down at Ceraph. Apparently, she’s forgotten who’s in charge here. Raising your voice, you tell the assembled demons that Ceraph attacked you several times in the mountains, trying to add you to her harem…And that despite her best attempts, Ceraph herself ended up bound to you, not the other way around. On the ground beneath you, Ceraph’s eyes widen in sudden fear.  \n\n");
		outputText("You grab Ceraph’s dress at the thigh slits, ripping it up and off the wannabe demon queen. Ceraph starts to scream, but she cuts it off, whimpering slightly as you stand her back up, more exposed than the skimpiest of her dancers. The party’s stopped entirely, and raising your voice, you call everyone’s attention to the front stage.  \n\n");
		outputText("You tell all the assembled demons that Ceraph put herself above them, sitting on her throne like a demon queen…And that you’re here to set the record straight. Ceraph is one of them.  \n\n");
        outputText("You order Ceraph to dance. To work the pole like the whore she is. She begins to dance, shakily, and you shake your head, stepping in and slapping her ass with all your strength, making the Omnibus’s ass shake violently. She turns to face you, fire in her eyes, but you grab her arms, forcing them behind her back and shoving her into the pole, cold steel between her naked breasts. Snarling, you tell her to try again.  \n\n");
        outputText("Ceraph forces a sultry smile onto her face, beginning to dance again. She’s clearly experienced, but you shake your head as her pussy leaks slimy pre onto the stage.  \n\n");
        outputText("Grabbing her by the arm, you call her useless. You tell her, in front of all the demons, that if she’s going to get herself off, she might as well put that leaky faucet of hers to use. You call for rope and a chair. Ceraph tries to pull away, but you keep a firm hold on her. Most of the demons below are frozen, but the one incubus you saw glaring earlier is all too eager to follow your lead. Grabbing a chair from the back, he tosses the chair onto the stage. You thank him, and tell him to grab a rope. He scampers off, grinning, and Ceraph gasps in horror.  \n\n");
        outputText("“Please.” She leans over, whispering in your ear. “Not him. Anyone but him.” You look at her, saying nothing, and her eyes widen. “"+ player.mf("master", "mistress") +", please. Don’t make me fuck him. I’ll do anything”.  \n\n");
        outputText("You raise your voice, telling Ceraph that if she wants something from you, she can say it out loud, slapping her ass for good measure. Ceraph blushes bright red, sighing before sinking to her knees in front of you.  \n\n");
        outputText("“"+ player.mf("master", "mistress") +"…Please, if you must humiliate me…Don’t let that incubus sully my pussy. I’m sure it would please you more…to do it yourself.” She smiles at you, her nervousness clearly showing on her face. As she does so, the scrawny incubus strides onto the stage, rope in hand. He leers at Ceraph, his demonic cock only 6’ long, but he’s muscular and tan, clearly an outdoorsman.  \n\n");
        outputText("He tosses you the rope, and you bind Ceraph’s hands together, as tight as you can make it. The demon horde below are silent, waiting for your next move, and the incubus licks his lips in anticipation. \n\n");
        outputText("Ceraph turns her head to look at you, eyes pleading. Her legs are shaking, her cock twitching, but she clearly has some history with this scrawny incubus that’s overruling her arousal. \n\n");
        menu();
        addButton (1, "Dismiss", DismissTheIncubus);
        addButton (2, "C'mere", JointhePartyBro);
    }
public function DismissTheIncubus():void {
		clearOutput();
		outputText("You tell the Incubus that his help was welcome…But that Ceraph is part of your harem, and that you intend on humiliating her yourself. He looks angry, but you give him a dark smile. You tell him that bad demons get punished in the Dom’s domain…and that Ceraph isn’t the only one who gets spanked for acting out. \n\n"); 
		outputText("He blanches at that, eyes wide, ignoring the jeers and catcalls as he quickly leaves the stage \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, "GangBang", CeraphGangBang);
addButton (2, "PublicUse", CeraphCumDumpster);
addButton (3, "SitonHer", CeraphPussChoke);
}
public function JointhePartyBro():void {
		clearOutput();
		outputText("You mockingly wipe a tear from Ceraph’s eye. “Oh, don’t worry, pet.” You soothe, loud enough for everyone to hear. “Your "+ player.mf("master", "mistress") +" will be the one to administer the punishment.” The crowd cheers, but you give the Incubus a wink, and he doesn’t leave the stage. Ceraph seems almost relieved, despite the humiliation. How do you want to punish Ceraph? \n\n"); 
menu();
addButton (1, "Dickwich", CeraphDickwich);
addButton (2, "DP_StrpOn", CeraphIncDPen);
addButton (3, "GangBang", CeraphGangBang);
}
public function CeraphDickwich():void {
		clearOutput();
		outputText("Forcing Ceraph to her knees, you tell her to stay down, disrobing and revealing your [cock] (if Pussy) and [Pussy] to the horde. Giving yourself a few, dramatic pumps, you do a slow, predatory walk around Ceraph, who looks up at you, mouth firmly shut. Going behind her, you grab her arms, pulling her back to her feet. She pulls slightly, but you tut, reaching down and slapping the inside of her knees.  \n\n"); 
		outputText("You order her to spread her legs, and she does so reluctantly, giving the assembled crowd a glare as they leer, whistle and jeer, some openly stroking themselves already. Ceraph’s spine stiffens as you slide your [cock] between her legs, getting some lubricant on your shaft, before aligning your tip with her puckered asshole. Ceraph shudders as your crown slides aside her sphincter.  \n\n");
		outputText("You grab her waist with one hand, and as she covers her drooling lips with her spade-like tail, you grab her tail, pulling roughly. The horde cheers as you bottom out, forcing Ceraph’s hips forward. You walk Ceraph forward, to the edge of the stage, and she closes her eyes. You let go of her waist, thrusting deep into her ass, letting the demons in the front catch the drops of Ceraph’s juices. Reaching around and grabbing the demoness’s considerable jugs, you slowly, steadily walk her back, pulling her tail if she doesn’t follow you perfectly.  \n\n");
		outputText("“O-okay…That’s enough.” Ceraph whispers. “Please…You’ve let everyone know that you own me…Now please, just finish.” You tut, loudly telling Ceraph that if she wants something from her [master], then she should speak louder. To emphasize your point, you pull on her tail, thrusting at the same time. You bury yourself into her overly warm ass, tweaking her breast with one hand.  \n\n");
		outputText("Ceraph opens her mouth to speak, but you move as she does, tweaking her clit and making her request turn into a moan. Telling her to speak up, you thrust again. “M-m-[master], p-please…That’s e-enoUGH.” Ceraph shudders as you thrust again, raising her voice so that everyone can hear. “E-everyone here knows that I’m yours.”  \n\n");
		outputText("“N-no!” The bitch has the audacity to lie? “I-I just meant t-that-” You tell Ceraph to shut up. That she lied to all the good people here…And that you know what punishment fits. You sit back into the provided chair, pulling your pliant little toy down on top of you, your throbbing [cock] still in her ass. The chair has wooden handrests on either side, and you gently, firmly spread Ceraph’s legs, putting her thighs on the handrests. \n\n");
        outputText("Ceraph looks out on the horde, anger and humiliation on her face…Until you speak again, from underneath her. You ask for the demon who provided such a lovely seat for you, to join you onstage. This gets an immediate response from Ceraph, who wriggles, trying to get up…But you grab her thighs, pinning them to the armrests. You ask the incubus to introduce himself to the crowd, and he turns to them. \n\n"); 
		outputText("“The name’s Derial”, he says simply. “And once upon a time, I was like you, worshipping the ground this cunt slimes on.” He growls, spitting on the stage floor. “She’s a picky one, Ceraph. Got all her little tricks and kinks all lined up in a row. She took one look at me and told me I would never get my little dick near her…That she wouldn’t even feel if I did.” He grins down at her. “So…Ceraph…” He lines himself up with her sopping twat, rubbing his shaft along her lips. “You feeling it yet?” \n\n");
		outputText("“N-no.” She says defiantly. “All I can feel is my [master] inside me.” You pull yourself almost all the way out, as the incubus grins lecherously. Ceraph grunts, wriggling on top of you, her ass contracting as the incubus sinks himself to the hilt in a single thrust. You can feel his cock pushing Ceraph’s insides back against yours. \n\n");
        outputText("“Oh, Ceraph…I knew you’d be moaning for me…But I didn’t think I’d have such an audience.” He brings a hand to her cheek, a mocking imitation of a lover’s touch.  \n\n"); 
		outputText("You feel Ceraph struggle, but he bears down, picking up the pace. Ceraph squirms on top of you, and you can feel Derial’s demonic cock through Ceraph’s walls. \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}
public function CeraphIncDPen():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}
public function CeraphGangBang():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}

    private function DemonWhorehouse():void {
        clearOutput();
        
    }

    public function NightwalkerLab1():void {
        dungeonLoc = DUNGEON_LAB_NIGHTWALKER_1;
        clearOutput();
       
    }

    private function NightwalkerStairs():void {
        clearOutput();
        outputText("You climb the stairs, slowly and carefully making your way up. More than one metal grate blocks your path, but you swipe your keycard, making swift work of the security. Finally, at the top, a single wooden door bars your path. You open it, walking into Project Nightwalker.");
        doNext(NightwalkerLab2);
    }

    public function NightwalkerLab2():void {
        dungeonLoc = DUNGEON_LAB_NIGHTWALKER_2;
        
            dungeons.setDungeonButtons(null, null, null, null);
            addButton(0, "Tank", NightwalkerLabTank);
            addButton(7, "Downstairs", NightwalkerLab1);
        }
    }

    public function DDullahanCheck():void {
        clearOutput();
        outputText("You walk towards the door, noticing the artwork on the door’s been changed. Instead of the spider motif, a curvy, pale woman is carved into the door, with her head floating in the air. As you near the door, it opens automatically, some kind of piston pushing it aside. A smaller incubus and an extremely brawny lacta bovine stand guard at the stairs leading downward. They both wear a collar, he seems to have his ear tagged, like a cow, and they both have weapons at their side. He wears a pair of daggers, and she has a massive tower shield on her back, and a greataxe in one hand. You’re not sure whether she’s sporting breasts, or pecs. The incubus is soft, almost pudgy-looking, and he steps forward as you approach.  \n\n");
		outputText("“Welcome to the dainty Dullahan, [Master] [name]. If there are any problems, please inform myself or my partner, and we’ll be sure to set things right.” That being said, they stand aside, leaving your path downstairs open.  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
        if (SeenDDullahan == false) {
            menu();
            addButton (1, "DownStairs", DDullahan1stTime);
        }
        else {
            menu();
            addButton (1, "DownStairs", DDullahan);
        }
    }
    public function DDullahan1stTime():void {
		clearOutput();
		outputText("The dark place where the Driders had once been caged is full once more. The place is dark, with some tables placed around. It’s been turned into a small lounge, with the cages around it. A few demons sit in the tables, and despite the frantic activity above, you can’t hear any of it, soothing piano washing through the little lounge as a few demons peruse paper menus on the table.  \n\n"); 
		outputText("To your (If corrupt) satisfaction (If neutral) curiosity (If pure) revulsion, several small creatures float prone in the first cage. You decide to take a closer look, and draw near.  \n\n");
		outputText("Their eyes are all closed, and while they’re bound, they seem well-fed and taken care of. However, they all seem to have been changed. While they all seem to have the same structure as an imp or goblin, they seem to have been transformed into miniature versions of one of the races of Mareth. Six in total levitate, slowly rotating. Pig, Mouse, Fox, Minotaur, Goblin and Imp. You slowly reach out towards the closest. Are they…even still alive in there? \n\n");
		outputText("“Hello?” You hear a soft voice come from behind you, and you turn, whipping around.  \n\n");
		outputText("A small woman jumps back from you. “H-hey!” She protests. “Don’t touch them!” As you step away from the bound creatures, she walks in, putting herself between you and the creatures. \n\n");
		outputText("“Rule one of the Dainty Dullahan: No touching the merchandise.” A woman with porcelain-white skin stands, pointing a finger at you. “And that…goes…” She seems to recognize you, and her pale blue eyes widen. “Wait…Are you…[Master] [name]?” You nod, and her hands begin to shake. “I-I’m so sorry.” She immediately drops to her knees, prostrating herself before you. “I’m Meila, and I’m…Well, I am the Dainty Dullahan.” \n\n");
        outputText("Now that you’re getting a closer look at her, she is rather dainty. Meila stands 5’3, a thin, waifish woman who you could probably pick up with one hand. Her B-cup breasts are covered with a thin pink top, her pale, almost ghostlike midriff bare. She wears a dainty, frilly skirt that barely goes halfway down her thigh, and her legs are covered with thin black stockings. Her ebony, waist-length hair shimmers slightly, woven into a single braid going down her back.  \n\n");
		outputText("“Please don’t tell Ceraph I was rude to you.” She begs. “I…Can’t deal with her being mad with me.” As her shoulders begin to shake, you hear a slight plop sound.  \n\n");
		outputText("“No!” Meila wails, lunging forward as…Her head rolls toward you? Despite your shock, you move your [leg] into the runaway head’s path, stopping it before it gets away. She’s moving to grab her head, but you have some time to react. What do you do? \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        SeenDDullahan = true;
menu();
addButton (1, "TakeHead", Meila1stFuckMenu);
addButton (2, "LetHerGrab", MeilaGrabsherHead);
}

public function Meila1stFuckMenu():void {
		clearOutput();
		outputText("You scoop up the head, a mischievous grin on your face. Meila’s body reaches towards you, but stops in her tracks, and she whimpers pitifully as you turn her head to face you. Her face is cool to the touch. \n\n"); 
		outputText("“What are you going to do to me, [master] [name]?”  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, "Head", MeilaGivesHead);
addButton (2, "LickMe", MeilaEatsYouOut);
addButton (3, "GiveBack", GiveMeilaHead);
}

public function MeilaGivesHead():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}

public function MeilaEatsYouOut():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}

public function GiveMeilaHead():void {
		clearOutput();
		outputText("You decide to be nice to the clearly nervous woman. No sense tormenting her, you don’t even know her yet. You reorient her head to face you, then pass it back. Sighing with relief, Meila hugs her head to her breast for a second, before putting it back on.  \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}
public function MeilaGrabsherHead():void {
		clearOutput();
		outputText("She scoops her head up, shaking slightly. As she puts her head back onto her shoulders, you ask her if she’s alright, offering her a hand up. She takes it, and with no effort, you pull the tiny woman to her feet.  \n\n"); 
		outputText("“I’ll be fine, thank you.” She seems less shaken up, but a little wary of you still. “Anyways…Allow me to introduce my services properly.” She curtseys, the nervousness seeming to vanish instantly. “The Dainty Dullahan is a new startup, courtesy of Mistress Ceraph…and my own magical abilities.”  \n\n");
		outputText("She spins her body, keeping her head pointed towards you as she points back at the cages. “Using our little friends here, as well as some special magic by yours truly, we can help you reach your ideal body type!”  \n\n");
		outputText("You note the lack of selection, and she blushes at that. “Well, I did say that this is a startup.” She sighs, looking at the magically trapped beings. “I haven’t been allowed to leave and gather more templates.”  \n\n");
		outputText("She claps her hands together, spinning on one foot and heading back behind the counter. As you watch, she motions with one hand, levitating her head up and into a basket near the ceiling. “Is there anything I can assist you with today?” \n\n");
		outputText(" \n\n");
menu();
addButton (1, "Next", );
}
public function DDullahan():void {
		clearOutput();
		outputText("As you descend into the Dainty Dullahan’s lounge, you see Meila’s body moving from table to table, occasionally taking an order. You see a demon come out from the back, a brand new \n\n"); 
		outputText("(fox-tail swishing behind them) (Pig’s hoofs clattering on the floor) (Mousey jaw, their teeth chattering slightly) (Insert TFs here \n\n");
		outputText("You hear a quick “Hello, [master] [name], If you need anything, just step up to the counter.” Meila’s head sits in a bucket near the ceiling, overlooking the entire operation while her body works the counter. \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, "Meila", Meila);
addButton (2, "Templates", TemplateLook);
addButton (9, "Leave", Mainhall1);
}
public function Meila():void {
		clearOutput();
		outputText("You step up to the counter, and you feel a chill on your back as Meila’s head floats over your shoulder, deftly reattaching to her neck.  \n\n"); 
		outputText("“[Master] [name], what brings you here?” She asks politely. “Here to get transformed? Help me with selection? Or did you just want to see more of me?” \n\n");
		
menu();
addButton (1, "Stare", MeilaAppearance);
addButton (2, "Talk", MeilaTalk);
addButton (3, "Sex", MeilaSexytimes);
addButton (4, "D.Dul", MeilaBusiness);

}
public function MeilaAppearance():void {
		clearOutput();
		outputText("Meila is a 5’3, waif of a woman. Her porcelain skin seems to reflect the amber light, and her blue eyes are deep and wide. She has a small button-nose and full, red lips. Her arms, legs, and body are thin and petite, but her B-cup breasts and feminine hips give her an unmistakable hourglass figure.  \n\n"); 
		outputText("She wears a pink crop-top that clings to her breasts, showing off the outline of her nipples through the fabric. Her lower half is covered by a frilly pink short skirt, and her legs are clad in warm black stockings that end somewhere inside the skirt.  \n\n");
		outputText("She daintily coughs, and you bring your eyes back to her face. “What do you need, [master]?” \n\n");
menu();
addButton (1, "Back", Meila);
}

public function MeilaTalk():void {
		clearOutput();
        if (MeilaTrust < 33) {
          outputText("Meila looks down slightly. “I’d rather keep things professional, if you don’t mind. Mistress Ceraph doesn’t take too kindly to…Wasted time.”  \n\n");   
          outputText("Maybe she’d open up a little once she trusts you more? \n\n");
          menu();
addButton (1, "Back", Meila);
        }
		if (MeilaTrust > 32 && MeilaTrust < 66) {
        outputText("Meila looks a little bit confused, but also a little flattered. “You just came down here to talk?” She seems a little wary, but looks at you, a small smile forming on her face. “What do you want to talk about, [Master]?”  \n\n");
		outputText(" \n\n");
        }
    if (MeilaTrust >= 66) {
		outputText("Meila smiles, blushing a little. “Well, pull up a stool, [master], I always have time to talk with you.” \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
    }
menu();
addButton (1, "Her", MeilaHerself);
addButton (2, "D.Domain", MeilaTheDomain);
addButton (3, "Adventures", MeilaTalkAdventures);
addButton (4, "Ceraph", MeilaTalkCeraph);
}

public function MeilaSexytimes():void {
		clearOutput();
		outputText("You tell Meila that you intend on claiming her, for a time. As Ceraph’s owner, her harem is yours to command.  \n\n"); 
		 if (MeilaTrust < 33) {
            outputText("Meila closes her eyes, sighing. “As you command, [master]” Her shoulders fall, and she slowly shuffles into the back. You follow, and she begins to slowly, reluctantly peel off her crop-top.  \n\n");
		outputText("“Please be gentle?” She whispers, almost pleading. \n\n");
		
        }
         if (MeilaTrust < 32 && MeilaTrust > 66) {
        outputText("Meila shudders slightly, but doesn’t protest. “Sure thing, [master].” You bring a hand to her shoulder, guiding her gently into the back. Without turning her body around, her head rotates to look at you. With one hand, you take hold of her crop-top, bringing it up and over her neck. Meila’s head floats up, and she watches, slightly nervously, as you slide her skirt down, exposing her thin lower lips.  \n\n");
        outputText("“N-nothing too rough, please.” She asks. “I still need to be able to work after.” \n\n");
         }
        if (MeilaTrust >= 66) {
		outputText(" Meila gives you a knowing wink, her head levitating to your ear. “Come to the back in a few seconds. I’ll be waiting.” She walks toward the back, slowly swaying her thin hips in an attempt to be seductive. Her head gently floats onto her neck, still looking back at you.  \n\n");
		outputText("You join her in the back a few moments later, and the dainty woman wraps her arms around your shoulders. Her head is nowhere to be seen, and you feel her cool breath on the back of your neck.  \n\n");
        outputText("“Hello, [master]”, Meila whispers, her lips on the back of your neck. She drags her lips across your neck, leaving a trail of kisses along the sensitive [skin]. Her head gently lowers back onto her neck, and she inhales, a little shakily, as you bring your hands to the bottom of her crop-top.  \n\n");
        outputText("“How do you want me?” She asks, dropping one hand to your hip. \n\n");
        }
menu();
if player.hasCock {
addButton (1, "FuckPuss", MeilaPussy);
addButton (2, "Anal", MeilaAnal);
addButton (3, "GimmeHead", MeilaGivesHead);
}
if player.hasPussy {
addButton (4, "LickYou", MeilaEatsYouOut);
addButton (5, "MutualFinger", MeilaFingering);
    }
}

public function MeilaPussy():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}
public function MeilaAnal():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}
public function MeilaFingering():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}


public function MeilaBusiness():void {
		clearOutput();
		outputText("“To business, then.” She folds her hands in front of her. “What in particular do you wish to discuss?” \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, "Status", DDullahanStatus);
addButton (2, "TF_ME", DDullahanTFMenu);
addButton (3, "GiveStock", DDullahanStock);
addButton (4, "HowDisWork", MeilaTutorial);
}

public function MeilaTutorial():void {
		clearOutput();
		outputText("“Conceptually, it’s fairly simple”, Meila says slyly. “Magically, it’s a lot more complicated than most would think. As you already know, many items in Mareth are intrinsically linked with the people that inhabit this world. While those of us born in Mareth naturally have an…affinity, so to speak, with the species we’re born as, making it harder for such items to have an effect on us, those born outside Mareth seem to lack that same kind of…Stability.”  \n\n"); 
		outputText("She points at the templates. “While it’s very difficult for most of us native Marethians to…Transform, so to speak, outside of very potent, single-use transformatives, such as Succubus Milk or Incubus Draft, there are those among us who possess more vulnerability than others. Typically, the more volatile of Mareth’s races are the short-lived ones, with less biomass to be altered. It also helps to have a high rate of reproduction, to foster more mutations.”  \n\n");
		outputText("You ask if that’s why her current templates are all goblins, and she nods, head bobbing independently of her body. “Exactly. Goblins and Imps are the ideal templates for my work. Their bodies are small, more easily mutated, and the lack of biomass makes everything easier.” She looks down, ever so slightly.  \n\n");
		outputText("How do you react to this? She’s talking about practically ending lives, using them as…meat donors, so that demons can look different.  \n\n");
		
menu();
addButton (1, "Horror", MeilaReassuresYou);
addButton (2, "Admiration", Reallydudethatscold);
addButton (3, "Neutral", MeilaNeutrality);
}

public function MeilaReassuresYou():void {
		clearOutput();
		outputText(" \n\n"); 
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, " ", );
}


    public function TyrantLab1():void {
        clearOutput();
		dungeonLoc = DUNGEON_LAB_TYRANT_1;
       
            addButton(7, "Downstairs", TyrantPrison);
        }

    public function TyrantPrison():void {
        dungeonLoc = DUNGEON_LAB_TYRANT_PRISON;
        clearOutput();
        dungeons.setDungeonButtons(TyrantLab2, null, null, null);
        addButton(5, "UpStairs", TyrantLab1);
    }

    public function TyrantLab2():void {
        dungeonLoc = DUNGEON_LAB_TYRANT_2;
        clearOutput();
        dungeons.setDungeonButtons(null, TyrantPrison, null, null);
    }

    public function PanicRoom():void {

    }
	
	public function VideoLog():void {
		clearOutput();
		outputText("You open the file, and a video begins to play…Dated just a week or so after you entered this realm.\n\n");
		outputText("A single demon, a grin on his face, fills the screen. “<i>Doctor Hemos’ Log…SHE’s coming here! Finally, I’ll be able to showcase my work!</i>” The camera moves, and is left on a table. As the demon walks backwards, you realise that this room is the white, sterile room at the front of the lab. You watch as the scientists file into view on the other side of the room, and wait. Most are still, sterile, but the demon who’d started the video is bursting with excitement. A moment or so later, the distant flapping of leathery wings sounds.\n\n");
		outputText("“<i>My queen.</i>” A gruff, bullish voice sounds. The door opens, and a massive minotaur enters, facing the line of scientists. “<i>Bow.</i>” The line of demons drop to one knee, and he moves forward, brandishing his axe. The minotaur steps out of frame, and two women enter.\n\n");
		outputText("One is a succubus…Her purple hair is woven with black roses, oversized dragon wings folded against her back. Goat horns curl delicately from her head, and she walks slowly, sensually, on heels of bone. Her breasts, shockingly, are slim. She wears black cloth, cut down to nearly nothing…But her black-rimmed eyes are cold, odd, slitted pupils giving an air of dark intellect.\n\n");
		outputText("“<i>Your Majesty, is there anything in particular you wish to see?</i>” The second woman asks. This one is odd, even by demon standards. She has long, sharp bull horns, a horselike face and a red mane running down her body…A body covered in black and white striped scales. Her hair is red…and appears to be made from thin tendrils. Almost like the anemones from the lake. She turns her head towards the camera, and sticks her forked tongue out. Despite the horse-like shape of her face, she has snake-fangs, but the rest of her teeth are sharp. The back of her throat glows red, and she lets out a puff of smoke.\n\n");
		outputText("Her breasts are C-cups, perky, and held in place by a milking machine repurposed as a bra. She wears a lab coat overtop, unbuttoned. Electricity visibly sparks from her body, and she levitates an inch or so off the ground. Her legs are thin, with a bone spike protruding from her knees, and her legs end in razor-sharp talons. She looks at the camera, and her pupils are…odd. They’re perfect ‘X’s, yellow, with a distinct glow.\n\n");
		outputText("The Chimera has four arms, ending with clawed fingers. One holds an inkpot, and two hold a clipboard in front of her. She dips a single claw into the inkpot, jotting down notes with her remaining hand.\n\n");
		outputText("“<i>No, Lucina. I want to know everything about the projects, and their progress.</i>” Lethice’s voice is firm, but very feminine, and she moves with an air of assured confidence. “<i>We’ve put a lot of effort into these labs of yours.</i>”\n\n");
		outputText("“<i>Of course, my queen.</i>” As Lethice and her two retainers walk past, the quivering demon scientist in the back breaks formation, raising his voice.\n\n");
		outputText("“<i>Queen Lethice! Please, if you would?</i>” He takes two steps towards Lethice, but the massive minotaur turns, hefting his axe.\n\n");
		outputText("“<i>You will speak to the queen when she requests your presence, and not a moment before.</i>” The chimeric woman says. Lethice ignores the disturbance, continuing on into the lab.\n\n");
		outputText("“<i>Doctor Hemos, you will behave yourself.</i>” Another demon says, taking the doctor’s hand and pulling him back in line. “<i>Apologies, Doctor Lucina, for my…colleague's outburst.</i>” He shakes his head. “<i>He’s been working in his own lab for quite some time, and doesn’t know how to interact with others.</i>”\n\n");
		outputText("The odd chimeric woman nods, scribbling down more notes. “<i>Very well…His problematic behaviour has been noted, but we’ll deal with that when we’re off the queen’s clock.</i>” She gives a very direct look to the Incubus who’d started the recording. “<i>Be careful in the future, Doctor Hemos. We wouldn’t want anything to happen to you.</i>” She looks down at the camera, frowning. “And what is this device doing on the table?” She picks it up, and the recording stops.\n\n");
		outputText("Lethice was here, and clearly knew what was happening…But who was that chimaera? Those eyes…You’ve seen their like before.\n\n");
		doNext(PanicRoom);
	}
}

