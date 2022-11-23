package classes.Scenes.Places.TelAdre {
import classes.GlobalFlags.*;
import classes.Races;
import classes.StatusEffects;
import classes.display.SpriteDb;

/**
 * Pablo the Maleherm Pseudo-Imp by worldofdrakan
 * @author Kitteh6660
 * Ported to CoCX by Svalkash.
 */
public class PabloScene extends TelAdreAbstractContent {

    public function PabloScene() {
    }

    public function pabloIntro(textOutput:Boolean = true):Boolean {
        if (model.time.hours > 14 && model.time.hours <= 20) {
            if (textOutput) {
                if (flags[kFLAGS.PABLO_MET] == 0)
                    outputText("\n\nOver in the back, there is a short, no, -really- short figure doing chin-ups. He couldn’t possibly stand more than three and a half feet tall. He is shirtless, wearing only a pair of shorts. His skin is a bright peach color with a hint of blush on his nose and cheeks. He is lithe, but still noticeably muscular. Behind him swings a tail that nearly matches his body height in length, tipped with a tiny, arrowhead-like shape. A pair of small, bat-like wings grow out from his shoulderblades. His toes end in sharp claws, as well as his fingers. Your attention then turns to his face. It is slightly effeminate, though still visibly masculine. Atop his head is a mop of shaggy, curly, unkempt hair, sandy blonde hair. Squinting, you can make out a pair of tiny horns under the mop on his head, as well as a pair of cute, pointed ears. His eyes are almost completely black, save for his vermillon irises. Come to think of it, he kind of looks like… an imp? No, not in Tel’Adre. There’s no way he can be an imp. Or is there?");
                else
                    outputText("\n\nAs usual, Pablo is in the back doing his usual chin-up workout.");
            }
            return true;
        } else {
            return false;
        }
    }

    public function pabloAffection(mod:int = 0):int {
        flags[kFLAGS.PABLO_AFFECTION] += mod;
        if (flags[kFLAGS.PABLO_AFFECTION] < 0) flags[kFLAGS.PABLO_AFFECTION] = 0;
        if (flags[kFLAGS.PABLO_AFFECTION] > 100) flags[kFLAGS.PABLO_AFFECTION] = 100;
        return flags[kFLAGS.PABLO_AFFECTION];
    }

    private function checkPablosVirginity():void {
		if (flags[kFLAGS.PABLO_GOT_DICKED_VAGINALLY] == 0) outputText("<b>You have claimed Pablo's vaginal virginity!</b>");
    }

    //Introduction to Pablo
    public function approachPablo():void {
        spriteSelect(SpriteDb.s_pablo);
        clearOutput();
        if (flags[kFLAGS.PABLO_MET] == 0) {
            outputText("You approach the imp-like creature, a whole swarm of questions flooding your mind. Noticing you, he hops down from his bar.");
            outputText("\n\n\"<i><i>Hello there. I don’t believe we’ve met. The name’s Pablo. And you?</i></i>\"");
            outputText("\n\n\"<i>" + player.short + ",</i>\" you respond.");
            outputText("\n\nAlthough you imagine it to be rude to ask, as you’ve only just met, but you must know.");
            outputText("\n\n\"<i>Are you?...</i>\"");
            outputText("\n\nYou hesitate for a moment.");
            outputText("\n\n\"<i>An imp?</i>\" Pablo interrupts. He seems to have anticipated your question. \"<i>I get that question a lot. I guess I am, but not quite.</i>\"");
            outputText("\n\nHe certainly looks like an imp, though. You’re curious. How exactly did he get into Tel’Adre. They had to have thought he was an imp.");
            outputText("\n\n\"<i>They did,</i>\" he begins, lowering his head and shuffling his feet. He can’t help but chuckle as he looks back on the day he first arrived in the city. \"<i>I had a lot of explaining to do, and it certainly wasn’t easy. In the end, it all came down to this weird corruption scan with some kind of special crystal. You could imagine how surprised they were when I passed their test.</i>\"");
            outputText("\n\nIf he wasn’t always like this, what was he? And how did he get this way? You really hope he doesn’t mind you asking.");
            outputText("\n\n\"<i>If you can believe it, I was a human once. I was an adventurer, you see. One day, I stumbled through this portal, and voilà! I was in this place, the land of Mareth!</i>\"");
            outputText("\n\nYour eyes widen. He used to be a human, just like you " + (player.isRace(Races.HUMAN, 1, false) ? "are" : "were") + "!");
            outputText("\n\n\"<i>Eventually, I got hungry, -really- hungry. For a while, food was hard to come by, and I had to make do with whatever I could find. Sometimes the imps would have this strange food on them, and sometimes they would have drinks. I think you can see where I’m going here. Long story short, the things I ate ended up changing me.</i>\"");
            outputText("\n\nYou intently continue to listen to his story.");
            outputText("\n\n\"<i>My hair wasn’t always this color, either. It was black.</i>\" he says, twirling one of his sandy blonde locks. \"<i>Some crazy bitch out in the desert made it that way, called herself a Sand Witch. Heh. She threw this hissy fit when I refused to let her cast a spell on me. What else was I supposed to do? She wouldn’t even tell me what kind of spell it was. In the end, I gave in just to calm her crazy tits. I’ve gotten kinda used to this color, actually. But I guess that’s enough about me. Perhaps you and I could work out together?</i>\"");
            flags[kFLAGS.PABLO_MET] = 1;
            pabloAffection(10);
        } else if (flags[kFLAGS.PABLO_AFFECTION] < 80) {
            outputText("You approach Pablo.");
            outputText("\n\n\"<i>Oh, hey there, " + player.short + "! Stopping by for another workout?</i>\"");
        } else {
            outputText("Smiling, you approach Pablo, glad to see your friend again.");
            outputText("\n\n\"<i>Well look who’s here,</i>\" the imp says, grinning widely as he turns to face you. \"<i>Hey there, friend. You stopping by for a workout? You know you’re always welcome. Or did you just drop in to say hi?</i>\"");
        }
        doYesNo(workoutWithPablo, declineWorkout);
    }

    //Stop! Workout time!
    private function workoutWithPablo():void {
        clearOutput();
        if (flags[kFLAGS.PABLO_WORKOUT_COUNTER] == 0) {
            outputText("You nod at the faux imp, telling him that you could use some exercise.");
            if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("\n\nThe centauress working the door walks up to collect her fee, and you drop 10 gems for an hour workout into her hand.");
            outputText("\n\n\"<i>Great,</i>\" Pablo responds with a grin. \"<i>There’s another bar next to mine. Maybe you could try doing some chin-ups?</i>\"");
            outputText("\n\nWith that, Pablo flutters his wings, lifting himself to his bar.");
            outputText("\n\n");
        }
        if (flags[kFLAGS.PABLO_AFFECTION] < 80) {
            outputText("You work out for about an hour or so, exchanging a few stories of your own travels in Mareth as you do so. He pays close attention to his stories, adding commentary whenever appropriate.");
            outputText("\n\nYou depart to take a quick shower before returning to camp, Pablo waving goodbye at you as you go.");
        } else {
            outputText("You accept the imp-morph’s invitation eagerly.");
            outputText("\n\n\"<i>Great! You know how much I enjoy our workouts. There’s a bar you can use right next to mine, as per the usual.</i>\"");
            outputText("\n\nNodding, you hop up, grasping the bar. You work out for an hour, exchanging various stories of your adventures in Mareth. He adds in commentary whenever appropriate, as well as the occasional witty banter.");
            outputText("\n\nWhen your hour is up, you hop down from your bar and make your way to the showers, Pablo waving goodbye to you as you do so. Once you finish with your shower, you return to camp.");
        }
        if (player.str100 < 40) dynStats("str", 0.5);
        if (player.str100 < 60) dynStats("str", 0.5);
        if (player.str100 < 80) dynStats("str", 0.5);
        if (player.str100 < 90) dynStats("str", 0.4);
        dynStats("str", 0.1);
        player.modTone(90);
        flags[kFLAGS.PABLO_WORKOUT_COUNTER]++;
        if (flags[kFLAGS.PABLO_AFFECTION] < 60) pabloAffection(5);
        pabloAffection(5);
        doNext(camp.returnToCampUseOneHour);
    }

    private function declineWorkout():void {
        clearOutput();
        if (flags[kFLAGS.PABLO_WORKOUT_COUNTER] == 0) {
            outputText("You politely decline, not really feeling up to working out at the moment.");
            outputText("\n\n\"<i>It’s alright,</i>\" the imp says. \"<i>You’re welcome to work out with me anytime, though.</i>\"");
            outputText("\n\nWith that, you make your leave.");
            pabloAffection(5);
        } else if (flags[kFLAGS.PABLO_AFFECTION] < 80) {
            outputText("You decline, explaining that you just dropped by to say hello.");
            outputText("\n\nPablo smiles, seemingly flattered at the gesture.");
            outputText("\n\n\"<i>It’s alright, " + player.short + ". It was nice of you to drop by, though.</i>\"");
        } else {
            outputText("You smile at your friend, explaining that you just dropped by to say hello, and to ask how he’s been.");
            outputText("\n\n\"<i>Well that’s nice of you,</i>\" Pablo remarks, chuckling slightly. \"<i>I’ve been doing great, even better after our encounter in the showers.</i>\"");
            outputText("\n\nYou can feel yourself beaming with pride. You’re so glad that you were able to help him out. You tell him that you’ll see him later.");
            outputText("\n\n\"<i>I look forward to it!</i>\" the imp replies happily, giving you a quick wave.");
        }
        doNext(telAdre.gymDesc);
    }

    //Pablo has let the cat out of the bag.
    public function pabloSecret():void {
        spriteSelect(SpriteDb.s_pablo_nude);
        clearOutput();
        outputText("You raise an arm, smelling your armpit. You wrinkle your nose in disgust. The smell is absolutely rank! Bashfully looking around, making certain that everyone around you is out of detection range, you make your way to the lockers. " + player.clothedOrNaked("There, you remove your " + player.armorDescript() + ", stripping naked before grabbing", "There, being naked already, you grab") + " a towel to cover yourself. You hear the sound of running water as you approach the showers, confirming the presence of someone else. Before reaching the entrance to the room, the water stops. Whoever it is, they must be getting out. As you reach the entrance, you see Pablo leaving one of the stalls, getting a full glimpse of his naked figure. He doesn’t appear to have noticed you.");
        outputText("\n\nBetween his legs is a generous human cock, at least for someone of his stature. You estimate it to be about six inches in length and one and a half inches in width. His balls, the average, each about an inch across. He turns to the stall, giving you a full glimpse of his backside as he flaps his wings, lifting himself in the air to grab his towel which hung over the door. You can now see the small slit which would otherwise be hidden by his balls. He’s a herm!");
        outputText("\n\nDeciding that you’ve stared at him long enough, you pick a stall and make your way over to it.");
        outputText("\n\nYou greet him as you enter the stall, hanging your towel over the door as you shut it behind you.");
        outputText("\n\nPablo jumps back, covering his crotch as he reels in shock at the fact that you’ve seen him naked. His expression of shock soon turns to one of despair, tears of embarrassment welling up in his eyes.");
        outputText("\n\n\"<i>No, no, damn it, no!</i>\" he whimpers, hastily wrapping the towel around him. \"<i>I was hoping that no-one would ever see me like this!</i>\"");
        outputText("\n\nYou look down at him, confused. Was he referring to the fact that he was a maleherm? Why, in a place like Mareth, would someone be embarrassed by such a thing, let alone want to keep it a secret? You elect to ask him that exactly.");
        outputText("\n\nThe imp-morph removes his hands from his face at looks up at you, nodding sadly.");
        outputText("\n\nBut why does that embarrass him so much? You’ve come across many just like him" + (player.gender == 3 ? ", and you happen to be one yourself." : "."));
        outputText("\n\nHe looks to the side for a moment, and then back to you.");
        outputText("\n\n\"<i>You mean… You’re actually interested in me, and why I’d want to hide it?</i>\" he asks.");
        outputText("\n\nOf course you’re interested. You’re friends, aren’t you?");
        outputText("\n\nThe imp stands silent for a moment, going through the options in his head.");
        outputText("\n\n\"<i>Alright,</i>\" he begins, leaning against your stall door, \"<i>I’ll tell you. If you can believe it, there’s a real stigma against people like me, people with both sexes. I’m pretty sure it has something to do with the demons. Apparently possessing both sexes was practically unheard of before they came. So I guess people just came to associate us with them, the demons… It’s also kinda my fault that I’m this way. Remember when I said that some of the things I ate and drank changed me? That’s how I ended up getting a vagina. I used to just have a penis.</i>\"");
        outputText("\n\nAs you listen, a frown crosses your face. It all becomes clear to you. You feel nothing but pity for your faux imp friend. You turn back to Pablo, giving him a reassuring smile. You tell him that he’s your friend. Of course his extra equipment doesn’t bother you.");
        outputText("\n\nThe imp-morph’s face lights up, his usual friendly smile returning.");
        outputText("\n\n\"<i>You don’t? Oh, " + player.short + "! You really have been a great friend to me!</i>\"");
        outputText("\n\nYou let out a sigh of relief, glad to have cheered up your friend.");
        outputText("\n\nIt was nothing, really.");
        outputText("\n\nFinishing your shower, you shut off the water, grabbing the towel to dry. Once dry, you wrap yourself in it and leave your stall, making your way to the locker room. You wave goodbye to Pablo as you reach the entrance. There, you " + player.clothedOrNaked("re-equip your [Armor] and ") + "make your way back to camp, satisfied.");
        flags[kFLAGS.PABLO_SECRET_LEARNED] = 1;
        pabloAffection(20);
        player.fatigue -= 10;
        doNext(camp.returnToCampUseOneHour);
    }

    //Shower sexy times!
    public function pabloShowerSexIntro():void {
        spriteSelect(SpriteDb.s_pablo);
        clearOutput();
        outputText("After a long, hard workout, you rest for a moment, wiping your brow of sweat as you catch your breath. If your forehead is that sweaty, surely the rest of your body must be the same way. As such, you elect to take a quick shower before you head back to camp.");
        outputText("\n\nAs usual, you retreat to the locker room, removing your [Armor] and covering yourself with a towel. As you enter your stall, you see a familiar face enter the room. It’s Pablo. Judging by the towel around his waist, he must be wanting a shower, too. He appears to be very nervous, looking at the floor and twiddling his thumbs.");
        outputText("\n\n\"<i>Ah… Hey there, " + player.short + ".</i>\" He reaches a hand to his head, scratching behind one of his ears. \"<i>There’s been something that I’ve been meaning to talk to you about- for a while now, as a matter of fact.</i>\"");
        outputText("\n\nAfter turning on the water, you turn to face your imp friend. What could he possibly be getting at?");
        outputText("\n\n\"<i>Well,</i>\" he gulps, \"<i>you’ve done so much for me in the time that we’ve been friends. It’s unreal. No-one has ever treated me as nicely as you have. I’ve been having a hard time sleeping at night, and it’s because I’ve always been thinking of you, dreaming of you. I was thinking that maybe we… I don’t know, could do some other things together. Like, um, dates, and maybe even,</i>\" he pauses, hesitating, \"<i>sex.</i>\"");
        outputText("\n\nYour mouth hangs agape, shocked at your friend’s confession. At the same time, you can’t help but feel incredibly flattered by it. He clearly likes you in more ways than one!");
        outputText("\n\n\"<i>Oh, forget it! Forget I said anything! I should’ve known that this was a stupid idea!</i>\" he cries, his head in his hands. He appears to have taken your stunned silence as a rejection. He turns toward the entrance of the room, intent on leaving. Should you stop him, or maybe it’d be better to just let him go?");
        menu();
        addButton(0, "Let him go", pabloShowerLetGo).hint("Let Pablo go. There's no harm in letting him go. You're sure you'll be able to see him again.");
        addButton(1, "Stop him", pabloShowerStopHim).hint("Stop Pablo. This will lead to some sexy times.");
    }

    private function pabloShowerLetGo():void {
        clearOutput();
        outputText("You sigh, resolving yourself to let him go. Pablo seemed embarrassed, ashamed even. He may need some time alone. Perhaps this was for your own good as well. You may need some time to think about all of this, to take it all in. It’s not every day that someone admits to touching themselves to the thought of you.");
        outputText("\n\nYou look to the ground, watching the water go down the drain. The water goes cold, and you find that you’re not enjoying yourself as much as you did with your other showers. Are you certain that you made the right decision?");
        outputText("\n\nShivering, you turn off the water, drying yourself off as quickly as you can. You rush to the locker room, discarding your towel and re-equipping your [Armor]. With that, you make your way back to camp.");
		player.fatigue -= 10;
        doNext(camp.returnToCampUseOneHour);
    }

    private function pabloShowerStopHim():void {
        clearOutput();
        outputText("Intent on stopping Pablo, you swing open your stall door, not even bothering to cover yourself. You run to him frantically, nearly slipping on the wet floor as you do so. You drop to your knees and wrap your arms around him, preventing his escape. The imp-morph freezes, speechless.");
        outputText("\n\n\"<i>...But… why, " + player.short + "?</i>\"");
        outputText("\n\nDid it ever occur to him that you find his attraction to you flattering? Not even once?");
        outputText("\n\nYou turn your head to face his, giving him a soft kiss on the cheek. Never would you think that his cheeks could possibly get any redder, but at that moment, you would swear that they did. To your surprise, Pablo slips from your grasp, wrapping his arms about your neck in a tight hug. He wastes no time in giving you a passionate kiss on the lips, his entire body shivering in excitement.");
        outputText("\n\n\"<i>Oh, " + player.short + "!</i>\" he begins, breaking the kiss. \"<i>You just have no idea how relieved I am to hear that!</i>\"");
        outputText("\n\nYou think you have an idea.");
        outputText("\n\nOnly then does Pablo stop to admire your naked figure. He nods in approval as he scales your body, just taking it all in. Already you can make out the shape of an erection tenting the towel around his waist. His eyes widen as he realizes just what’s going on down below, quickly covering his crotch with his hands.");
        outputText("\n\n\"<i>Oh, sorry. Maybe that’s a bit too straightforward.</i>\"");
        outputText("\n\nYou wouldn’t say so. In fact, maybe you could help him with that?");
        outputText("\n\n\"<i>You mean you really want to?</i>\" Pablo asks, his face lighting up at the notion.");
        outputText("\n\nOf course you do. Your stall is still open, and you motion inside.");
        outputText("\n\n\"<i>Y-yes, I’d like that very much,</i>\" he says, nodding furiously.");
        outputText("\n\nWith that, you make your way to the stall, swinging your hips in a teasing fashion. Pablo is not far behind. On your way there, you consider how to tackle this. Should you take charge, or let Pablo run the show? What parts will you use?");
        if (player.hasStatusEffect(StatusEffects.Infested)) pabloGetsGrossedOutByWorms();
        else pabloSexMenu();
    }

    public function pabloSexMenu():void {
        spriteSelect(SpriteDb.s_pablo_nude);
        menu();
        //Dick
        addButtonIfTrue(0, "T.Charge (D)", curry(pabloDickingTime, true), "You need to have a cock for that.",
            player.hasCock(), "You'll take charge and fuck his vagina.", "Take Charge (Dick)");
        addButtonIfTrue(5, "P.Leads  (D)", curry(pabloDickingTime, false), "You need to have a cock for that.",
            player.hasCock(), "You'll let Pablo lead and he'll take your dick vaginally.", "Pablo Leads (Dick)");
        //Vagina
        addButtonIfTrue(1, "T.Charge (V)", curry(pabloPussPuss, true), "You need to have a pussy for that.",
            player.hasVagina(), "You'll take charge and take his dick vaginally.", "Take Charge (Vagina)");
        addButtonIfTrue(6, "P.Leads  (V)", curry(pabloPussPuss, false), "You need to have a pussy for that.",
            player.hasVagina(), "You'll let Pablo lead and he'll put his dick to a good use.", "Pablo Leads (Vagina)");
        //Ass
        addButton(2, "T.Charge (A)", pabloButtSecks, true)
            .hint("You'll take charge and take his dick anally.", "Take Charge (Ass)");
        addButton(7, "P.Leads  (A)", pabloButtSecks, false)
            .hint("You'll let Pablo lead and he'll fuck your ass.", "Pablo Leads (Ass)");
    }

    private function pabloDickingTime(inCharge:Boolean = false):void {
        clearOutput();
        if (inCharge) {
            if (player.tallness >= 60 && !player.isTaur()) {
                outputText("You look down at your imp friend, your [cock] hardening as you inspect his naked body. You are significantly taller than him, and you contemplate on how you can fuck him comfortably. You smile slyly as you remember the back wall of the stall. You know just what to do.");
                outputText("\n\nAbruptly, you scoop up the imp-morph, hugging him tightly. He lets out a surprised gasp, but he welcomes your sudden embrace, planting a kiss on your cheek. You look deeply into his eyes, and ask him if he’s ready to make some good use of the back of this stall. He seems to have taken the hint.");
                outputText("\n\n\"<i>Yes, y-yes. Take me, please!</i>\" Pablo whimpers as he wraps his legs around you, his foot-claws digging softly into your back.");
                outputText("\n\nYou decide not to keep the excited imp waiting any longer. Carefully, you prop him up against the back of the stall, telling him to keep his legs wrapped around you for support. Right as you’ve lined your [cock] up with his already-drooling cunt, he lightly shoves you.");
                outputText("\n\n\"<i>Um, wait,</i>\" he says nervously.");
                outputText("\n\n\"<i>What’s wrong?</i>\" you ask.");
                outputText("\n\nYour friend hesitates for a moment before answering. \"<i>It… It’s my first time. Uh, in there at least. Could you, ah, maybe go a bit easy on me?</i>\"");
                outputText("\n\nOf course you can. All he needed to do was ask. With that, you carefully ease your length into him. He winces slightly, and you worry that you may have hurt him. You ask him if he’s alright, and he insists that he is, urging you to continue. You oblige him, but you keep your pace slow and easy, just as promised. ");
                checkPablosVirginity();
                outputText("\n\nPablo continues to whine softly as you thrust in and out of his needy puss. As if on reflex, he reaches a hand down to his throbbing manhood, pumping it furiously until the tip begins to dribble precum. You smile widely at the imp-morph’s enthusiasm, upping your pace a bit.");
                outputText("\n\nHe practically squeals at the sensation of your rod pistoning in and out of his cooch. It isn’t long before the shambling mess of an imp-morph completely loses it, his pecker twitching violently as rope upon rope of spooge erupts from his tip and onto your chest. The inner walls of his cunt feverishly clamping down on your own member, milking it for all that it’s worth. He slumps against the back of the stall, exhausted from your lovemaking. You opt to hold him there until he completely catches his breath, despite being more than a little exhausted yourself.");
                outputText("\n\nHe finally speaks up, his breathing still labored. \"<i>That was amazing, " + player.short + ". I don’t think I’ve ever cum that quickly before. You can put me down now.</i>\"");
                outputText("\n\nYou waste no time in returning him to the ground, allowing both of you to clean up under the running water. Pablo exits the stall, drying off and wrapping his towel around his waist. You follow suit. Before leaving, he gives you one last hug and kiss.");
                outputText("\n\n\"<i>Thank you, lover. I couldn’t have asked for better.</i>\"");
            } else {
                outputText("You look at your imp friend, your [cock] hardening as you inspect his naked body. Both of you aren’t very far off in terms of height. This is good. You have an idea, and given your lack of significant height difference(/’your body type’ if centaur), it shouldn’t be too hard to pull off. You smile slyly at him, abruptly flipping him onto his hands and knees and mounting him. He seems startled at first, but does not seem to be taking unkindly to your actions. As you press your stiff pecker against his wet folds, his tail blocks your way. Is something wrong?");
                outputText("\n\n\"<i>Hey, could you maybe go a bit easy on me? I may not be new to sex, but I’m still a virgin, ah, in there.</i>\"");
                outputText("\n\nOf course you can. All he needed to do was ask. With that, Pablo’s tail moves out of the way, and you’re able to carefully ease your length into him. He winces slightly, and you can feel him shuddering under you. For a moment, you worry that you might have hurt him. You ask him if he’s alright, and he insists that he is, urging you to continue. You oblige him, but you keep your pace slow and easy, just as promised. ");
                checkPablosVirginity();
                outputText("\n\nHe practically squeals at the sensation of your rod pistoning in and out of his cooch. It isn’t long before the shambling mess of an imp-morph completely loses it, his pecker twitching violently as rope upon rope of spooge erupts from his tip and washes down the drain below. The inner walls of his cunt feverishly clamping down on your own member, milking it for all that it’s worth. He slumps to the floor of the stall, exhausted from your lovemaking. You move off of the imp and give him some space, needing a little breather yourself.");
                outputText("\n\nHe finally speaks up, his breathing still labored. \"<i>That was amazing, " + player.short + ". I don’t think I’ve ever cum that quickly before. You can move now. I can’t exactly get up with you looming over me like that.</i>\"");
                outputText("\n\nYou waste no time in getting up, allowing both of you to clean up under the running water. Pablo exits the stall, drying off and wrapping his towel around his waist. You follow suit. Before leaving, he gives you one last hug and kiss.");
                outputText("\n\n\"<i>Thank you, lover. I couldn’t have asked for better.</i>\"");
            }
        } else {
            outputText("Pablo eyeballs you with a look of confusion as you lay down on the floor of the shower stall, scratching his head. He doesn’t seem to be taking the hint. You can’t help but chuckle at his confusion. You would think that he’d know what you were getting at. Still, you expose yourself to him, and that’s all it takes for it to sink in.");
            outputText("\n\n\"<i>You actually want me to lead?</i>\" the imp-morph asks. \"<i>Wow, and I thought you would be the one taking charge. That’s not a bad thing, though. I’ll do it. I just wasn’t expecting it.</i>\"");
            outputText("\n\nPablo is hovering over you now, clearly thinking to himself. You can only guess that he’s trying to figure out exactly what he wants to do here. He takes your [cock] in his clawed hand, stroking it lovingly.");
            outputText("\n\n\"<i>You know, I might be far from a stranger to sex, but I’m still a virgin in the vagina, if that makes sense. Maybe you’re just the right one to help me break it in, hm? What do you say?</i>\"");
            outputText("\n\nYou give your partner a nod in approval. If that’s what he wants, go right ahead.");
            outputText("\n\nThe imp licks his lips in anticipation. His already-drooling is already right above your stiff pecker. Carefully, he lowers himself down to where your leaking tip is just barely pressing against his entrance. From there, he takes a deep breath, allowing you to slip inside of him. For a moment, the imp-morph gasps at the sensation of your rod in his folds. You’re concerned that he might have hurt himself, and you ask him if he’s alright.");
            checkPablosVirginity();
            outputText("\n\n\"<i>Yeah, I’m fine,</i>\" he responds. \"<i>I just have to get used to it, that’s all. I’ll be ready to go in a minute.</i>\"");
            outputText("\n\nSmiling, you give the imp-morph’s body all the time it needs to adjust to you, stroking his wet, sandy blonde hair from time to time. Eventually, he moves about experimentally, letting out a pleasured sigh as he does so. He’s probably about ready to continue. Indeed, he is. By now, he’s begun to gyrate his hips at a steady pace, and he only gets faster as he goes along.");
            outputText("\n\n\"<i>Oooh, " + player.short + ",</i>\" the imp moans. \"<i>This feels amazing!</i>\"");
            outputText("\n\nHe isn’t doing a half bad job himself. If he keeps going like this, it won’t be long before both of you are sent over the edge. In fact, you’re already struggling to hold back your orgasm. You’re really hoping that both of you will be able to cum together.");
            outputText("\n\nIn that moment, you would swear that Pablo was reading your thoughts. You can feel his inner walls contracting rapidly around your [cock] as he tosses his head back, wailing in pleasure. Rope after rope of cum sprays from your partner’s ample cock and onto your chest. As you blow your own load, you’re forced to grip Pablo’s firm ass for support, and he’s loving every second of it.");
            outputText("\n\nOnce you both come down from your high, all you can do is stay there and catch your breaths. The first to try and get up is Pablo, but even then his breathing is still noticeably labored. You can see little droplets of your seed dripping from his snatch as your prick pops free. You can’t help but smile triumphantly at the fact that you’ve filled him to the brim with cum.");
            outputText("\n\n\"<i>That was great, " + player.short + ",</i>\" he finally speaks up. \"<i>I don’t think I’ve ever cum that quickly before.</i>\"");
            outputText("\n\nWhat’s he talking about, you ask. He did all the work after all. Pablo chuckles bashfully as you point this out.");
            outputText("\n\n\"<i>I guess you’re right, but I still had a great time. That’s all that matters, right? Oh, and before I forget. Thanks, lover.</i>\"");
            outputText("\n\nWith that, the imp-morph leaves, allowing you to finish cleaning yourself up before returning to camp.");
        }
        flags[kFLAGS.PABLO_GOT_DICKED_VAGINALLY]++;
        pabloAffection(5);
        player.sexReward("vaginalFluids", "Dick");
        doNext(camp.returnToCampUseOneHour);
    }

    private function pabloPussPuss(inCharge:Boolean = false):void {
        clearOutput();
        if (inCharge) {
            if (player.tallness >= 60 && !player.isTaur()) {
                outputText("You look down at your imp friend, your cunt moistening as you inspect his naked body. You are significantly taller than him, and you contemplate on how you can fuck him comfortably. You smile slyly as you remember the back wall of the stall. You know just what to do.");
                outputText("\n\nAbruptly, you scoop up the imp-morph, hugging him tightly. He lets out a surprised gasp, but he welcomes your sudden embrace, planting a kiss on your cheek. You look deeply into his eyes, and ask him if he’s ready to make some good use of the back of this stall. He seems to have taken the hint.");
                outputText("\n\n\"<i>Yes, y-yes. Take me, please!</i>\" Pablo whimpers as he wraps his legs around you, his foot-claws digging softly into your back.");
                outputText("\n\nYou decide not to keep the excited imp waiting any longer. Carefully, you prop him up against the back of the stall, telling him to keep his legs wrapped around you for support. Right as you’ve lined your muff up with his eager prick, you can already see him licking his lips in anticipation.");
                outputText("\n\n\"<i>Come on, " + player.short + ". Stop teasing me like this!</i>\" he whines.");
                outputText("\n\nYou find yourself grinning from ear to ear at Pablo’s eagerness to start. He really is ready for you, isn’t he? Well, you figure that it isn’t really worth making him wait any longer. You’re quite eager to start yourself, after all. So, without further ado, you ease yourself onto the imp-morph’s throbbing cock. He sighs dreamily as you allow him into the warm confines of your inviting folds, his eyes rolling into the back of his head.");
                player.cuntChange(20, true, true, true);
                outputText("\n\nAt first, you start out slow, gyrating your hips at a steady pace, but you aren’t able to keep this pace for long. The sensation of Pablo’s twitching prick inside you is already close to driving you off the edge. Judging by your partner’s rapid breathing, he isn’t very far off himself. At this point, both of you are rutting like animals. Any gym-goers who come in for a shower are sure to get an earful of the lewd sounds of your lovemaking. Pablo is the first to lose it, releasing a guttural moan as he fills you to the brim with his seed. You follow soon after, your rapidly-clamping inner walls milking his pecker for all that its worth" + (player.hasCock() ? " while your " + player.cockDescript() + " shoots jism all over his belly" : "") + ". You both are forced to take a breather, and you struggle to keep the imp-morph pinned to the wall.");
                outputText("\n\nPablo finally speaks up, his breathing still labored. \"<i>That was amazing, " + player.short + ". I don’t think I’ve ever cum that quickly before. You can put me down now.</i>\"");
                outputText("\n\nYou waste no time in returning him to the ground, allowing both of you to clean up under the running water. Pablo exits the stall, drying off and wrapping his towel around his waist. You follow suit. Before leaving, he gives you one last hug and kiss.");
                outputText("\n\n\"<i>Thank you, lover. I couldn’t have asked for better.</i>\"");
            } else {
                outputText("You look at your imp friend, your cunt moistening as you inspect his naked body. Both of you aren’t very far off in terms of height. This is good. You have an idea, and given your lack of significant height difference, it shouldn’t be too hard to pull off. You smile slyly at him, abruptly pushing him to the ground and onto his back. From there, you’re able to mount him comfortably. He seems startled at first, but does not seem to be taking unkindly to your actions.");
                outputText("\n\n\"<i>Ahh, I see where this is going,</i>\" Pablo comments, smirking. \"<i>I like this. I like this a lot.</i>\"");
                outputText("\n\nAlready, you’re hovering just above his stiff member. You lower yourself to where his cock is just barely pressed against your entrance and stop, teasing him. He seems to know exactly what you’re doing, and he isn’t amused.");
                outputText("\n\n\"<i>Come on, " + player.short + ". There’s no sense in teasing me like this. You want to get started as much as I do, and you know I’m right.</i>\"");
                outputText("\n\nPablo isn’t wrong. What a smart imp-morph he is! And for being so smart, you figure that now would be the appropriate time to give him exactly what he wants. So, without further ado, you impale yourself upon Pablo’s pulsating rod. It feels just as wonderful as you imagined. It’s clear how your partner feels about you, too. For the brief moment that they were open, you could see his eyes rolling into the back of his head.");
                player.cuntChange(20, true, true, true);
                outputText("\n\nAt first, you start out slow, gyrating your hips at a steady pace, but you aren’t able to keep this pace for long. The sensation of Pablo’s twitching prick inside you is already close to driving you off the edge. Judging by your partner’s rapid breathing, he isn’t very far off himself. At this point, both of you are rutting like animals. Any gym-goers who come in for a shower are sure to get an earful of the lewd sounds of your lovemaking. Pablo is the first to lose it, releasing a guttural moan as he fills you to the brim with his seed. You follow soon after, your rapidly-clamping inner walls milking his pecker for all that its worth" + (player.hasCock() ? " while your " + player.cockDescript() + " shoots jism all over his belly" : "") + ". You both have no choice but to rest for a moment, taking a much-needed breather.");
                outputText("\n\nPablo finally speaks up, his breathing still labored. \"<i>That was amazing, " + player.short + ". I don’t think I’ve ever cum that quickly before. You can get off of me now.</i>\"");
                outputText("\n\nYou waste no time in returning him to the ground, allowing both of you to clean up under the running water. Pablo exits the stall, drying off and wrapping his towel around his waist. You follow suit. Before leaving, he gives you one last hug and kiss.");
                outputText("\n\n\"<i>Thank you, lover. I couldn’t have asked for better.</i>\"");
            }
        } else {
            outputText("Pablo eyeballs you with a look of confusion as you lay down on the floor of the shower stall, scratching his head. He doesn’t seem to be taking the hint. You can’t help but chuckle at his confusion. You would think that he’d know what you were getting at. Still, you expose yourself to him, and that’s all it takes for it to sink in.");
            outputText("\n\n\"<i>You actually want me to lead?</i>\" the imp-morph asks. \"<i>Wow, and I thought you would be the one taking charge. That’s not a bad thing, though. I’ll do it. I just wasn’t expecting it.</i>\"");
            outputText("\n\nPablo is hovering over you now, clearly thinking to himself. You can only guess that he’s trying to figure out exactly what he wants to do here. He grabs onto your naked body for support, effectively mounting you..");
            outputText("\n\n\"<i>You know, I might be far from a stranger to sex, but I still want to be sure that I’m not hurting you when we do this. If I start to get carried away, please tell me.</i>\"");
            outputText("\n\nYou let out a chuckle at Pablo’s concern for your well-being. You tell him that you’ll be just fine, playfully messing with his wet hair. He smiles at you, his tail swishing about happily.");
            outputText("\n\n\"<i>Alright, " + player.short + ", if you say so,</i>\" the imp-morph replies. His throbbing cock is already lined up with your [vagina], its dribbling cock pressed against your waiting entrance. \"<i>I hope you’re ready for this, because I’m going in!</i>\"");
            outputText("\n\nAnd go in he does! Despite your best efforts, you can’t help but sigh dreamily at the sensation of Pablo’s wonderful cock making itself at home in your warm folds. He’s only been inside you for a moment, and already he feels absolutely magnificent! You’ll have to do everything in your power to be sure that this lovemaking session goes on for as long as humanly possible.");
            player.cuntChange(20, true, true, true);
            outputText("\n\nAt first, the imp-morph start out slow, pistoning in and out of you at a steady pace, but he isn’t able to keep this pace for long. The heavenly feeling your sweet muff is providing him is already beginning to drive him off the edge. You aren’t very far off yourself, and you greatly encourage him to go faster. He happily obliges. At this point, both of you are rutting like animals. Any gym-goers who come in for a shower are sure to get an earful of the lewd sounds both of you are making. Pablo is the first to lose it, releasing a guttural moan as he fills you to the brim with his seed. You follow soon after, your rapidly-clamping inner walls milking his pecker for all that it’s worth. You both have no choice but to rest for a moment, taking a much-needed breather.");
            outputText("\n\n\"<i>That was great, " + player.short + ",</i>\" he finally speaks up. \"<i>I don’t think I’ve ever cum that quickly before.</i>\"");
            outputText("\n\nWhat’s he talking about, you ask. He did all the work after all. Pablo chuckles bashfully as you point this out.");
            outputText("\n\n\"<i>I guess you’re right, but I still had a great time. That’s all that matters, right? Oh, and before I forget. Thanks, lover.</i>\"");
            outputText("\n\nWith that, the imp-morph leaves, allowing you to finish cleaning yourself up before returning to camp.");
        }
        flags[kFLAGS.PABLO_USED_YOUR_PUSSY]++;
        pabloAffection(5);
        player.sexReward("cum", "Vaginal");
        doNext(camp.returnToCampUseOneHour);
    }

    private function pabloButtSecks(inCharge:Boolean):void {
        clearOutput();
        if (inCharge) {
            outputText("Pablo eyeballs you with a look of confusion as you lay down on the floor of the shower stall, scratching his head. He doesn’t seem to be taking the hint. You find yourself chuckling at his confusion. You would think that he’d know what you were getting at. Still, you expose your [ass] to him, wiggling it enticingly, and that’s all it takes for it to sink in.");
            outputText("\n\n\"<i>Oh… Oh! So you want me to put it in there? Up your bum?</i>\"");
            outputText("\n\nPablo can’t help but chuckle at his own comment. Though it’s funny to you as well, you still shake a finger at him in response, scolding him playfully. He should keep his mouth shut and put it in already, lest he’s willing to be teased back.");
            outputText("\n\n\"<i>Okay, okay, if you say so,</i>\" the imp-morph responds to your scolding. \"<i>Alright, " + player.short + ", prepare thine anus!</i>\"");
            outputText("\n\nJust as the tip of Pablo’s eager cock presses against your entrance, you move, denying him entry. The imp-morph gasps in surprise, an obvious disappointment evident in his voice. He backs away from you with a raised eyebrow, crossing his arms.");
            outputText("\n\n\"<i>Come on, " + player.short + ". What are you doing?</i>\" he asks.");
            outputText("\n\nYou warned him, didn’t you? With a smirk on your face, you remind him how you told him to cut out the witty banter unless he was willing to be on the receiving end of the teasing. So here he is, on the receiving end of the teasing. You burst into laughter as Pablo shakes his head at you.");
            outputText("\n\n\"<i>You and I both know that you want to get this started as much as I do,</i>\" he says. He’s not wrong. \"<i>I’m gonna try again, and please don’t move this time!</i>\"");
            outputText("\n\nWell, he did say please. That was nice of him. Alright, you suppose that you’ve made him wait long enough. Pablo mounts you once again, and this time, you make no effort to stop him as he slips past your anal ring.");
            player.buttChange(20, true, true, true);
            outputText("As hard as it must be for him, he stays still for now, making absolutely sure that you’re ready. You tell him that you’ll be just fine and give him the okay to go ahead. Pablo nods in response, and wastes no time in getting started.");
            outputText("\n\nAt first, the imp-morph start out slow, pistoning in and out of you at a steady pace, but he isn’t able to keep this pace for long. The heavenly feeling your sweet ass is providing him is already beginning to drive him off the edge. You aren’t very far off yourself, and you greatly encourage him to go faster. He happily obliges. At this point, both of you are rutting like animals. Any gym-goers who come in for a shower are sure to get an earful of the lewd sounds both of you are making. Pablo is the first to lose it, releasing a guttural moan as he fills you to the brim with his seed. You follow soon after, reflexively clamping down on his hot, throbbing pecker. Both of you have no choice but to rest for a moment, taking a much-needed breather.");
            outputText("\n\n\"<i>That was great, " + player.short + ",</i>\" he finally speaks up. \"<i>I don’t think I’ve ever cum that quickly before.</i>\"");
            outputText("\n\nWhat’s he talking about, you ask. He did most of the work after all. Pablo chuckles bashfully as you point this out.");
            outputText("\n\n\"<i>I guess you’re right, but I still had a great time. That’s all that matters, right? Oh, and before I forget. Thanks, lover.</i>\"");
            outputText("\n\nWith that, the imp-morph leaves, allowing you to finish cleaning yourself up before returning to camp.");
        } else {
            outputText("Pablo eyeballs you with a look of confusion as you lay down on the floor of the shower stall, scratching his head. He doesn’t seem to be taking the hint. You find yourself chuckling at his confusion. You would think that he’d know what you were getting at. Still, you expose your [ass] to him, wiggling it enticingly, and that’s all it takes for it to sink in.");
            outputText("\n\n\"<i>Oh… Oh! So you want me to put it in there? Up your bum?</i>\"");
            outputText("\n\nPablo can’t help but chuckle at his own comment. You would tell him to cut it out, but you find it pretty funny yourself. For now, you’ll let the imp-morph have his fun. He quickly mounts you, gripping the sides of your [ass] for support.");
            outputText("\n\n\"<i>Alright, " + player.short + ", prepare thine anus! I’m going in!</i>\" Pablo announces for all to hear.");
            outputText("\n\nHe quickly slips past your anal ring, hardly giving you any time to react.");
            player.buttChange(20, true, true, true);
            outputText("As hard as it must be for him, he stays still for now, making absolutely sure that you’re ready. You tell him that you’ll be just fine and give him the okay to go ahead. Pablo nods in response, and wastes no time in getting started.");
            outputText("\n\nAt first, the imp-morph start out slow, pistoning in and out of you at a steady pace, but he isn’t able to keep this pace for long. The heavenly feeling your sweet ass is providing him is already beginning to drive him off the edge. You aren’t very far off yourself, and you greatly encourage him to go faster. He happily obliges. At this point, both of you are rutting like animals. Any gym-goers who come in for a shower are sure to get an earful of the lewd sounds both of you are making. Pablo is the first to lose it, releasing a guttural moan as he fills you to the brim with his seed. You follow soon after, reflexively clamping down on his hot, throbbing pecker. Both of you have no choice but to rest for a moment, taking a much-needed breather.");
            outputText("\n\n\"<i>That was great, " + player.short + ",</i>\" he finally speaks up. \"<i>I don’t think I’ve ever cum that quickly before.</i>\"");
            outputText("\n\nWhat’s he talking about, you ask. He did most of the work after all. Pablo chuckles bashfully as you point this out.");
            outputText("\n\n\"<i>I guess you’re right, but I still had a great time. That’s all that matters, right? Oh, and before I forget. Thanks, lover.</i>\"");
            outputText("\n\nWith that, the imp-morph leaves, allowing you to finish cleaning yourself up before returning to camp.");
        }
        flags[kFLAGS.PABLO_USED_YOUR_PUSSY]++;
        pabloAffection(5);
        player.sexReward("cum", "Anal");
        doNext(camp.returnToCampUseOneHour);
    }

    public function pabloGetsGrossedOutByWorms():void {
        //clearOutput();
        outputText("\n\nAs you contemplate just how you want to go about fucking the imp-morph, he jumps backwards, reeling in shock. What’s got him so frightened? He points at your already-erect penis, finger shaking. It doesn’t take long for you to see what the big deal is. You look down at yourself just in time to see a worm inching its way out of the tip of your pecker. It falls to the floor with a splat and is flushed down the drain.");
        outputText("\n\n\"<i>Worms!</i>\" Pablo exclaims, gagging. At that moment, his stiff dick went immediately limp. \"<i>I… I’m sorry, " + player.short + ". I don’t think I can be with you like this, with those things. I don’t want to get them too!</i>\" The imp-morph heads for the shower stall exit, but stops for a moment, sighing. He turns to face you. \"<i>This doesn’t mean that I don’t want to be with you at all, though. I do! Just… Come see me if you get rid of those worms, then we can do it!</i>\"");
        outputText("\n\nWith that, he makes his leave. You swear you could hear him whisper, \"<i>please get rid of them,</i>\" on his way out. He must have really wanted to do this. You can feel his disappointment. You were really looking forward to this yourself. Still, you suppose that it’s not worth dwelling on, and finish your shower before heading back to camp.");
        pabloAffection(-10);
        flags[kFLAGS.PABLO_FREAKED_OUT_OVER_WORMS] = 1;
        doNext(camp.returnToCampUseOneHour);
    }

    public function pabloComesBackAfterWormCure():void {
        spriteSelect(SpriteDb.s_pablo);
        clearOutput();
        outputText("Pablo’s eyes light up as you approach him. He’s clearly happy to see you. But why does he avoid eye contact as you draw closer. What’s got him so bothered? Maybe he’s embarrassed over what happened between the two of you in the showers?");
        outputText("\n\n\"<i>Oh, hey " + player.short + ",</i>\" he greets you, tail limp. \"<i>I’m… Ah, sorry about before. I really did want to, you know, do it. It’s just… The worms! Whoa, wait a minute. Did you, by chance, come back because you got rid of them?</i>\"");
        outputText("\n\nIn that moment, the cheerful gleam in his eyes returns, his tail swishing to and fro happily. Indeed, you have gotten rid of the worms, and you’re more than willing to pick up where you left off. Pablo is positively beaming at this development. It’s hard to say for certain, but you swear that you can make out the beginnings of an erection in his shorts.");
        outputText("\n\n\"<i>Wow, " + player.short + ", that’s great!</i>\" the imp-morph exclaims, already heading for the showers. \"<i>Come on, let’s go!</i>\"");
        outputText("\n\nHe really is an eager one, isn’t he? As you make your way to the showers, you consider how to tackle this. Should you take charge, or let Pablo run the show? What parts will you use?");
        pabloAffection(10);
        flags[kFLAGS.PABLO_FREAKED_OUT_OVER_WORMS] = 0;
        pabloSexMenu();
    }

}

}