/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage {
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.TrollVillage;
public class Jabala extends TrollVillageAbstractContent {
    public function Jabala() {
    }

    public function MeetTheParents():void {
        //Side note, not loving the multiple outputTexts here, but the alternative of "" + "" is also not ideal...
        outputText("Zenji grabs your hand, \"<i>Follow me [name], dere’s… dere’s something I need to do first…</i>\"\n\n");
        outputText("Zenji gently, but hurriedly drags you along toward a hut. Zenji takes a deep breath before knocking on the wooden door.\n\n");
        outputText("A short, older female troll pushes the door aside. She is about 6’8\" wearing a fur cloak and pants, her long, lime hair drapes down to her hips. Her tusks are a lot shorter than most trolls you’ve seen, barely over an inch past her lips. She staggers back slightly after seeing Zenji.\n\n");
        outputText("Zenji speaks up, \"<i>It's me again, and-</i>\"\n\n");
        outputText("She leaps forward to hug him, \"<i>Oh, Zinny, my little Zinny... I was so worried when you left, you never said anything to me!</i>\" She begins crying, \"<i>I thought something bad might’ve happened to you!</i>\" She lets go of him and Zenji wipes her tears away. \"<i>Your father must know that you’re back!</i>\" She turns around before hollering, \"<i>Halkano! There’s someone here that needs to talk to you, right now!</i>\" She turns around toward you, \"<i>You must be his friend! I’ll be sure to get to know you soon.</i>\"\n\n");
        outputText("\"<i>Oh, Jabala…</i>\" A gruff voice replies, \"<i>You say dat everyone needs ta talk ta me right now…</i>\" A large, beefy troll approaches he is easily 8’ as he is just shorter than the ceiling, clad only in fur pants, he is scratching his beard. He gasps audibly upon seeing Zenji. \"<i>Zenji..! I-It’s you!</i>\"\n\n");
        outputText("Zenji gives a small chuckle, \"<i>Wow… dad, it’s good ta see you again… you’ve gotten much bigger since I left.</i>\"\n\n");
        outputText("\"<i>I’m just glad ya are back.</i>\" He consoles, hugging Zenji.\n\n");
        outputText("Halkano chuckles once he breaks the embrace, \"<i>When you left without saying anyting… your mother couldn’t take it…</i>\" He places his large hand on her shoulder, causing her to blush softly, \"<i>I did my best ta cheer her up, and… I decided dat I wanted ta be more for her. I worked on myself tirelessly. I did it for ya mother, but it also helped me deal with losing you, my very son, as well...</i>\" Halkano gently pulls Jabala closer to him as she blushes harder, leaning into his dense fur. \"<i>I’m just glad ya are back.</i>\"\n\n");
        outputText("Jabala speaks up, \"<i>Come, come, we have so much to talk about, and you can introduce us to your new friend you have here!</i>\" Jabala leads you to the interior as you follow behind Zenji.\n\n");
        outputText("Zenji speaks up, \"<i>Mom… Dad… dis is [name], dey’re… dey’re my soul mate, my lover, my one and only...</i>\"\n\n");
        outputText("Halkano’s eyes widen tremendously and Jabala gasps, \"<i>Even after... </i>\" Jabala mutters, \"<i>Oh, It’s a pleasure to meet you, [name]! You two will have the cutest grandchildren for me!</i>\"\n\n");
        outputText("Halkano chuckles softly, \"<i>Good on ya, Zenji. Welcome to de family, [name].</i>\"\n\n");
        outputText("There’s a small couch for you and Zenji to sit on as Halkano is seemingly too big for it now. Halkano seats himself on a sturdy seat as Jabala rests on his lap.\n\n" +
                "Zenji spends some time talking about how the two of you met as he catches up with his parents.\n\n");

        if (flags[kFLAGS.ZENJI_KIDS] != 0) {
            outputText("Zenji mentions that he’s already had children with you.\n\n");
            outputText("Jabala’s face illuminates as she leaps off Halkano’s lap, \"<i>Oh, Zenji! I am so proud of you, really need to bring them here one day.</i>\"\n\n");
            outputText("\"<i>Now, now, Jabala,</i>\" Halkano interjects.  \"<i>Dey’re just babies if anyting we have ta visit dem because it’s too dangerous ta carry babies outside of de village.</i>\"\n\n");
            outputText("Jabala pouts before returning to Halkano’s lap, giving an exasperated sigh, \"<i>Well, I’m sure [name] will be an excellent mother. Zenji knows what it’s like ta have one.</i>\"\n\n");
            outputText("Zenji blushes softly as he forces out some laughter. You caress his face lovingly to reassure him as he rests his face in your palm for a moment.\n\n");
        }

        outputText("You spend nearly an hour talking with them before you decide it’s best to call it for now and return to your camp with Zenji.\n\n");
        outputText("Jabala speaks up, \"<i>I understand, I’m sure you have very important things to take care of.</i>\"\n\n");
        outputText("\"<i>Take care of Zenji for us, [name]. Marae knows how careless he can get sometimes.</i>\" Halkano teased as the two of you leave.\n\n");
        outputText("<b>Jabala’s hut added to the troll village!</b>");
        TrollVillage.JabalaUnlocked = true;
        TrollVillage.ZenjiVillageStage = 1;
        doNext(camp.returnToCampUseOneHour);
    }

    public function JabalaDining():void {
        clearOutput();
        menu();
        if (TrollVillage.ZenjiBerated) {
            outputText("You decide to approach Jabala, but before you get too close she notices you and stands up.\n" +
                    "\n" +
                    "\"<i>You think this is a game? Toying with my sweet little boy? Stay away from my family!</i>\" she cries.\n");
            doNext(SceneLib.trollVillage.diningHalls.GrabABite2Eat);
        } else if (!TrollVillage.ZenjiFollowing && !TrollVillage.JabalaUnlocked) {
            outputText("Your gaze roams around until you decide to approach the small troll with long braided hair sitting by herself. She seems very tomboyish in appearance, clad in a simple farmers outfit with a straw hat adorned around her crown. Her svelte body is considerably smaller than almost any troll you’ve seen so far, but she’s still at least 6 feet tall. As you get closer you notice that she’s drinking the fig juice, she sets the cup down as her attention turns toward you.\n" +
                    "\n" +
                    "\"Oh? Have I seen you around here before?. You don’t look like the others. What’s your name?\"\n" +
                    "\n" +
                    "You tell her your name\n" +
                    "\n" +
                    "\"My name is Jabala, it’s nice to meet you, [name]. I’d love to stay and chat, but… I must get going…\" She spends a moment thinking to herself. \"Why don’t we meet up later? You can meet me at my house if I’m there, it’s on the eastern side of the village, the porch has plenty of colorful flowers, you can’t miss it!\"\n" +
                    "\n" +
                    "She dismisses herself and waves goodbye.\n" +
                    "\n" +
                    "Once she’s gone you figure that you can go outside and perhaps check on the other activities around the village\n");
            outputText("<b>Jabala’s Hut has been added to the troll village!</b>\n");
            TrollVillage.JabalaUnlocked = true;
            doNext(camp.returnToCampUseOneHour);
        } else if (!TrollVillage.ZenjiFollowing) {
            outputText("Your gaze roams around until you decide to approach Jabala. Deciding that you want to talk to her again, you decide to approach her.\n" +
                    "\n" +
                    "She is currently staring off into the distance, unaware of her surroundings as her half-full cup of juice rests beside her.\n" +
                    "\n" +
                    "Once you approach, her eyes zone in before shifting to meet your gaze. \"<i>Oh, [name]! I didn’t notice you there. It’s good to see you, how's everything going?</i>\"\n" +
                    "\n" +
                    "You assure her that things could be worse.\n" +
                    "\n" +
                    "\"<i>Oh, well, I hope things will turn out for the best around you. Come, sit, was there something you wanted to talk about?</i>\"\n");
            addButton(0, "Herself", JabalaSelfIntro);
            addButton(1, "The People", JabalaGossip);
        } else {
            outputText("Your gaze shifts around before spotting Jabala sitting by herself in the diner. You ask Zenji if he wants to meet up with his mother.\n" +
                    "\n" +
                    "Zenji grasps onto your hand. \"<i>Sure, dat sounds nice, [name]. The three of us can have a chat together.</i>\" \n" +
                    "\n" +
                    "He guides you to his mother, she’s looking off into the distance, not noticing your approach.\n" +
                    "\n" +
                    "\"¡<i>Hola mamá</i>!\" Zenji greets, cheerfully.\n" +
                    "\n" +
                    "\"<i>Oh, Zenji!</i>\" Jabala responds, eyes widening to focus on her surroundings once more as she faces the two of you. \"<i>[name]! It’s good to see the two of you! Come! Come! I hope everything’s been well.</i>\"\n" +
                    "\n" +
                    "Zenji nods, \"<i>It’s been just great, I love [name] wit all my heart, and I’m sure dey feel de same.</i>\"\n" +
                    "\n" +
                    "Jabala smiles, \"<i>That’s wonderful, glad you two are happy together. You two remind me so much about myself when I was your age. I was dumbstruck, couldn’t even separate myself from Halkano, spent every night together...</i>\" Her gaze sets off into the distance again.\n" +
                    "\n" +
                    "Zenji blushes, \"<i>¡Mamá!</i>\"\n" +
                    "\n" +
                    "\"<i>Oh.. Did I get carried away again..? What time is it..? I had best get going now. It was a pleasure to meet up with the two of you again!</i>\"\n" +
                    "\n" +
                    "Jabala gives the two of you a hug before leaving.\n" +
                    "\n" +
                    "\"<i>Come, [name]. Let’s go, it was nice ta catch up wit her again, even if she gets lost in thought like always.</i>\"\n" +
                    "\n" +
                    "Zenji holds your hand as he leads you out of the diner.\n");
            doNext(SceneLib.trollVillage.EnterTheVillage);
        }

        function JabalaSelfIntro():void {
            outputText("You tell Jabala that you want to get to know her better, she seems like an interesting person after all. Who is she, what does she do?\n" +
                    "\n" +
                    "\"<i>About myself... Hmm…</i>\" Jabala pauses for a moment, looking off into the distance, \"<i>Well, I am a farmer by profession and a gardener in my free time. I mostly grow greens, coffe beans and figs… lots of figs… I guess trolls really like their figs, don’t they?</i>\"\n" +
                    "\n" +
                    "Jabala snickers to herself, \"<i>Yeah, all the farming is what led me to the man of my dreams… My husband, Halakno, Such a big... Strong carpenter…</i>\" She says, blushing slightly, \"<i>It just kind of happened. I lost all control when I was near him and he didn’t resist my advance.</i>\"\n" +
                    "\n" +
                    "\"<i>It wasn’t until long until we got married and had our first child together, we loved him with all our hearts, but…</i>");
            if (TrollVillage.ZenjiVillageStage > 0) {
                outputText(" <i>Thanks to you I know he’s safe.</i>");
            }
            outputText("\"\n\n" +
                    "\"<i>Nothing changes here, it’s simple, sweet and I like what I do. Gardening in my free time always lifts my spirits, especially when Halkano is there.</i>\"\n" +
                    "\n" +
                    "Jabala looks off into the distance again. \"</i>I really should get going, [name]. It was nice talking to you, sorry I didn’t give you much of a chance to speak, I kind of got lost in thought. Until we meet again!</i>\"\n" +
                    "\n" +
                    "Jabala stands up and leaves. Seeing that there’s not much left to do now, you decide to exit the dining hall.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaGossip():void {
            outputText("You ask Jabala about the people of the village, she seems fairly sociable for a farmer.\n" +
                    "\n" +
                    "\"<i>The people here are pleasant to talk to… for the most part. Gossip is hard to come by because most people are into their own things, but I tell you, I’ve been hearing a lot of whispers going around about this gay guy… I don’t personally know any gay guys around here, but I hear this guy is almost like a predator for other men. Just what I heard though. Oh, the seamstress, oh no, the seamstress. Don’t talk to her, she has a nose for trouble and should keep her hands to herself. If she ever talks to you, don’t talk to her. Almost reminds me of the elder. All she does is tuck herself into her own thing, disregarding the pleas of others and is generally unaware of the world around her. She’s not bad at keeping rules governed and keeping the rest of the elders in balance, but she’s also hard to even listen to.</i>\"\n" +
                    "\n" +
                    "Jabala’s gaze sets off into the distance for a moment before her eyes roll back to you. \"<i>Where was I..? Oh, is there anything else you had in mind?</i>\"\n");

            addButton(0, "Gay troll", JabalaHomoSexTalks);
            addButton(1, "Seamstress", JabalaSeamstress);
            addButton(2, "Elder", JabalaElder);
            addButton(3, "Love Life?", JabalaLoveLife);
            addButton(4, "Leave", JabalaLeave);
        }

        function JabalaLeave():void {
            outputText("You tell Jabala that you enjoyed talking to her, but there’s nothing else you wanted to talk about.\n" +
                    "\n" +
                    "\"Oh, carry on then. I’ll be here with my thoughts.\"\n" +
                    "\n" +
                    "You pack up your stuff and leave the dining hall.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaHomoSexTalks():void {
            outputText("You want to hear more about this gay troll because apparently homosexuality is very uncommon among trolls.\n" +
                    "\n" +
                    "\"<i>Oh, it is.</i>\" She responds. \"<i>Rumor has it’s the elder Kal'ji. ¡Qué cabro! He totally has the hots for this one farmer. Or so I’ve heard…</i>\"\n" +
                    "\n" +
                    "She looks around, almost as if she were worried about eavesdroppers. \"<i>From what I’ve heard, he’s a terrible lover in bed! But you didn’t get this from me.</i>\"\n" +
                    "\n" +
                    "Jabala leans back, adjusting her straw hat. \"<i>Well, I best get going for now, it was nice talking to you [name].</i>\" She leaves after dismissing herself.\n" +
                    "\n" +
                    "You decide to pack up as well and head out the diner.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaSeamstress():void {
            outputText("You want to hear more about the seamstress, did she actively cause trouble?\n" +
                    "\n" +
                    "Jabala sighs, \"</i>Puta de chongo. Yenza has been on the hunt for many men. She attacked my son and if I didn’t stop them, then I don’t know what could’ve happened. I don’t want to talk about that girl anymore. I should get going anyway</i>\"\n" +
                    "\n" +
                    "She adjusts her straw hat before dismissing herself.\n" +
                    "\n" +
                    "You decide to pack up as well and head out the diner\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaElder():void {
            outputText("You want to hear more about the elder, what makes her so difficult?\n" +
                    "\n" +
                    "\"<i>Yubi? She’s mostly in her own world, thinking about what’s best and doing what she would like to do. Sometimes she tries and looks out for the people, but it’s difficult to know if she’s doing it for everyone or herself.</i>\"\n" +
                    "\n" +
                    "Jabala looks into the distance but still talks to you. \"<i>I feel like she wants what’s best for the people. I know it in my heart, she just wants to do good, but I think she’s lost her way and is unsure what to do now. She’s been the chief elder for… how long..? I know she means well, but I feel like she’s losing her touch with the people.</i>\"\n" +
                    "\n" +
                    "Jabala’s gaze shifts back to you. \"<i>She’s not a bad person, she never was. Enough about her though, I best get going now. Farewell, [name].\" Jabala packs up her things before leaving.</i>\n" +
                    "\n" +
                    "Once she’s gone you decide to head out of the diner as well.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaLoveLife():void {
            outputText("You want to hear more about her husband, is he that special to her?\n" +
                    "\n" +
                    "Jabala blushes softly, \"<i>Halkano, mi amor…</i>\" Her gaze sets off into the distance, completely ignoring you.\n" +
                    "\n" +
                    "\"<i>We’ve been together for so long, and things have been rough, but I couldn’t ask for a better husband…</i>\" Jabala’s voice trails off again.\n" +
                    "\n" +
                    "After about a moment of silence, it looks like she’s busy staring at the wall in front of her.\n" +
                    "\n" +
                    "You decide to pack up and leave for the time being, she seems very content on sitting in silence for now. You leave the diner.\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }

    public function JabalaHome():void {
        clearOutput();
        menu();
        if (TrollVillage.ZenjiVillageStage == 4 && TrollVillage.ZenjiFollowing) {
            outputText("Zenji knocks on the door to the hut.\n" +
                    "\n" +
                    "You hear light footsteps approach as Jabala moves the door aside.\n" +
                    "\n" +
                    "\"<i>Zinny! It’s good to see you again.</i>\" Jabala takes a long look at Zenji’s expression, \"<i>Is something wrong..? It looks like you’ve been through a lot.</i>\"\n" +
                    "\n" +
                    "\"<i>You could say dat…</i>\" Zenji responds. \"I’m just glad ta be here… It’s been a difficult couple of days… Can I speak ta dad..? It’s someting personal, you should stay and talk ta [name], keep dem company. </i>\"\n" +
                    "\n" +
                    "Jabala nods her head, \" <i>Sure thing, Dad is in the garden out back. </i>\"\n" +
                    "\n" +
                    "\" <i>Gracias mamá, te quiero. </i>\" Zenji replies before leaving you alone with Jabala.\n" +
                    "\n" +
                    "Jabala gestures for you to sit down on the couch beside her. Once Zenji is outside she speaks up. \"<i>I saw what happened at the diner earlier… Everyone did… Rough time..?</i>\"\n" +
                    "\n" +
                    "You tell Jabala that you’ve worked things out with Zenji and that he seems much better now.\n" +
                    "\n" +
                    "Jabala smiles gently, \"<i>That’s so sweet, [name]. Glad you’re there for my son, I know you mean the world to him, not only did he tell me, but I can see it in his eyes.</i>\"\n" +
                    "\n" +
                    "She brings her hands to the locket around her neck. \"<i>Listen, I’ve been keeping this for Zenji to give to someone really important to him, but… I think you should be the one to propose to him. You’re so kind, patient, and caring. You’re the most perfect person I ever could’ve asked for to take care of my son. Please, [name], take this charm. Tell him that he means everything to you the same way you do to him. Make my son happy, I know you can do it.</i>\"\n" +
                    "\n" +
                    "You hold out your hand and Jabala drops the charm into your awaiting palm.\n" +
                    "\n" +
                    "\"<i>When the time is right… propose… I know you’re ready, [name]. Be bold, he will love you no matter what.</i>\"\n" +
                    "\n" +
                    "After a moment of recollection over Zenji, you hear the door swing open and Zenji enters. \n" +
                    "\n" +
                    "\"<i>Let’s go home, [name]. Thanks, mom... for everything.</i>\"\n" +
                    "\n" +
                    "Jabala gives a soft smile, \"<i>Anything for you, Zenji,</i>\" she replies before giving you a wink as the two of you head out.");
            player.createKeyItem("Jabala's Charm", 0, 0, 0, 0);
            TrollVillage.ZenjiVillageStage = 5;
            doNext(camp.returnToCampUseOneHour);
        } else if (!TrollVillage.ZenjiFollowing) {
            outputText("You knock on the door to Jabala’s hut, after a moment you hear very loud footsteps approaching. A massive, burly troll opens the door.\n");
            if (!TrollVillage.HalkanoUnlocked) {
                outputText("He gives you an inquisitive look but quickly shifts to a polite smile. \"<i>Greetings, you must be one of Jabala’s friends. I am Halkano.</i>\" He stretches an arm out to shake your hand.\n" +
                        "\n" +
                        "You shake his hand and tell him your name.\n" +
                        "\n" +
                        "\"<i>Nice t' meetcha, [name].</i>\"\n");
            } else {
                outputText("He gives you a polite smile, \"<i>[name]! Good ta see ya again, come in, come in!</i>\"\n\n");
            }
            outputText("He gestures for you to enter the hut, \"<i>What brings ya here?</i>\"\n");
            addButton(0, "Halkano", JabalaHalkanoTalk, true);
            addButton(1, "Jabala", JabalaSelfTalk, true);
            addButton(2, "Never mind", JabalaNVM);
        } else if (TrollVillage.ZenjiFollowing) {
            outputText("Zenji knocks on the door to his parent’s hut.\n" +
                    "\n" +
                    "You heard loud footsteps approaching before the door opens. Halkano stands at the doorway scratching his beard. His face lights up as he sees the two of you.\n" +
                    "\n" +
                    "\"<i>Zenji! [name]! It’s good ta see ya, what brings ya here?</i>\"\n" +
                    "\n" +
                    "\"<i>Hey dad, we just wanted ta visit,</i>\" Zenji replies\n" +
                    "\n" +
                    "\"<i>Well, you’re always welcome here, come, come! I’ll get Mom. Why don’t de two of you wait on de couch until den?</i>\"\n" +
                    "\n" +
                    "Zenji guides you to the couch as Halkano goes to the backyard to get his wife. As the two of you wait Zenji grabs hold of your hands, clutching them softly.\n" +
                    "\n" +
                    "\"<i>You just have… the most holdable hands [name].</i>\" Zenji states as he caresses your hand softly with his thumb.\n" +
                    "\n" +
                    "You smile at him, it’s nice to just hold hands sometimes.\n" +
                    "\n" +
                    "After a moment Halkano reenters with Jabala. Halkano plops down onto the sturdy chair beside the couch you’re on\n" +
                    "\n" +
                    "\"<i>It’s nice to see you again, Zenji, [name],</i>\" Jabala says with a friendly wave.\n" +
                    "\n" +
                    "You greet her back and Zenji does as well.\n" +
                    "\n" +
                    "\"<i>What brings you here?</i>\" Jabala asks as she sits on Halkano’s lap. His arms reflexively wrap around her.\n" +
                    "\n" +
                    "\"<i>We came here ta visit and talk about a few tings,</i>\" Zenji replies\n" +
                    "\n" +
                    "Halkano speaks up, \"<i>We always love ya company, son. What d’ya wanna talk about?</i>\"\n" +
                    "\n" +
                    "Zenji brushes his shoulder against you, wordlessly asking you to speak up.\n" +
                    "\n" +
                    "You consider what you want to talk about anyway.\n");
            addButton(0, "Money Troubles", JabalaMoneyHelp);
            addButton(1, "Love Advice", JabalaLoveAdvice);
            addButton(2, "Gossip", JabalaGossip);
            addButton(3, "Sex", JabalaSexWZenji);
            addButton(4, "Leave", JabalaSayonara);

            function JabalaMoneyHelp():void {
                clearOutput();
                if (TrollVillage.ZenjiMoneyHelp == 0) {
                    TrollVillage.ZenjiMoneyHelp = 24;
                    outputText("You state that there have been financial problems with you and Zenji\n" +
                            "\n" +
                            "Zenji looks shocked at your statement and blushes softly, embarrassed.\n" +
                            "\n" +
                            "\"<i>[name]! You can’t just…</i>\" Zenji whispers\n" +
                            "\n" +
                            "Jabala snickers, \"<i>Money problems? Oh no, the two of you must be so desperate and helpless out there!</i>\"\n" +
                            "\n" +
                            "Halkano chuckles, but Jabala elbows his stomach.\n" +
                            "\n" +
                            "Jabala stands up from Halkano’s lap. She reaches into a pouch on her overalls, pulling out a handful of gems. Zenji holds out his hand as he receives the gems.\n" +
                            "\n" +
                            "\"<i>Gracias mamá, te quiero.</i>\"\n" +
                            "\n" +
                            "Jabala smiles back at him. \"<i>I hope that helps, I really should get back to my work. Stay safe out there.</i>\"\n" +
                            "\n" +
                            "Jabala waves goodbye as she exits the room.\n" +
                            "\n" +
                            "Halkano chuckles to himself, shaking his head. \"<i>Don’t spend it all in one place now…</i>\" He says, standing up. He approaches the two of you before pulling you both in for a hug. \"<i>Stay safe out dere.</i>\"\n" +
                            "\n" +
                            "\"<i>Gracias papa, te quiero.</i>\"\n" +
                            "\n" +
                            "Halkano then leaves the two of you alone in the room. Zenji passes the gems to you, \"<i>Seems ta be about 45 gems… I can’t believe ya did dat.</i>\"\n" +
                            "\n" +
                            "You tell him that times are tough, and a little help never hurts anyway.\n" +
                            "\n" +
                            "Zenji bites his lip, \"<i>Yeah, okay den....</i>\"\n" +
                            "\n" +
                            "You pocket the 45 gems before leaving with Zenji.\n");
                    player.gems += 45;
                    doNext(camp.returnToCampUseOneHour);
                } else {
                    outputText("You state that there have been financial problems with you and Zenji\n" +
                            "\n" +
                            "Zenji looks shocked at your statement, he quickly places his hand over your mouth, shushing you.\n" +
                            "\n" +
                            "\"<i>No, no! We’re fine, we’re fine!\" Zenji states, </i>\"In fact, we forgot someting back at home, we may be back later. Love you!</i>\"<i>\n" +
                            "\n" +
                            "\"<i>Oh, uh, Love you!</i>\" Jabala replies\n" +
                            "\n" +
                            "\"<i>Love ya too, stay safe!</i>\" Halkano chimes in\n" +
                            "\n" +
                            "Zenji lifts your insignificant weight before leaving the house with you in his arms. Once you’ve exited, he plants you firmly onto the ground.\n" +
                            "\n" +
                            "\"<i>I can’t believe ya just did dat! My parents are not a money machine, please be respectful.</i>\"\n" +
                            "\n" +
                            "You apologize.\n" +
                            "\n" +
                            "\"<i>It’s okay, just… Please, I love you, [name]. Don’t abuse dem like dat.</i>\"\n");
                    doNext(camp.returnToCampUseOneHour);
                }
            }

            function JabalaLoveAdvice():void {
                outputText("You ask for advice on what makes a relationship strong and healthy like theirs seems to be.\n" +
                        "\n" +
                        "Zenji raises an eyebrow at you.\n" +
                        "\n" +
                        "\"<i>Trouble in paradise?</i>\" Halkano chimes\n" +
                        "\n" +
                        "\"<i>Er… noting like dat, tings have just been… Strange and we’d like to hear what you have ta say.</i>\" Zenji replies\n" +
                        "\n" +
                        "Jabala gently nudges Halkano before turning her attention back to the two of you. \"<i>Communication is always important. Be honest, be gentle. Don’t be afraid to say what the problem is. If the issue is… each other, then work it out rather than staying silent about it.</i>\"\n" +
                        "\n" +
                        "Halkano speaks up, \"<i>A relationship should work together, but de two pieces should not need each other to survive.</i>\"\n" +
                        "\n" +
                        "\"<i>Love is strange,</i>\" Jabala states, \"<i>There are hundreds of ways to express affection, not all of which are verbal.</i>\"\n" +
                        "\n" +
                        "Zenji nods his head as he absorbs the information.\n" +
                        "\n" +
                        "\"<i>The two of you just need to spend time together, get to know each other. [name]. I’m sure you know that Zenji is only 20 years old, right?</i>\"\n");
                if (TrollVillage.JabalaLoveChat) {
                    outputText("As you recall, Zenji is very young.");
                } else {
                    outputText("Well, you do now, this is very much news to you.\n" +
                            "\n" +
                            "You turn to Zenji, giving him an inquisitive stare.\n" +
                            "\n" +
                            "Zenji gives you a gentle grin.\n");
                    TrollVillage.JabalaLoveChat = true;
                }
                outputText("\n" +
                        "Jabala continues, \"<i>Tell each other what interests you, perhaps you can have a lot more in common than you think.</i>\"\n" +
                        "\n" +
                        "\"<i>Well, I do really like cooking for [name] sometimes,</i>\" Zenji replies\n" +
                        "\n" +
                        "\"<i>Good, something simple and fun the two of you can do together some time. Never disregard the smaller things we can appreciate.</i>\"\n" +
                        "\n" +
                        "\"<i>De bigger gestures of course are still valid as always.</i>\" Halkano chimes\n" +
                        "\n" +
                        "Jabala continues, \"<i>It’s all about working together. Understand each other. Nothing is ever perfect, but the two of you can work together to make it the best it can be.</i>\"\n" +
                        "\n" +
                        "Zenji speaks to you, \"<i>So, [name]. Is dat any help?</i>\"\n" +
                        "\n" +
                        "You assure him that it was good to hear and sound advice.\n" +
                        "\n" +
                        "\"<i>Dat’s good ta hear, now let’s go home. Bye mom, bye dad. Love you.</i>\"\n" +
                        "\n" +
                        "\"<i>Love you too</i>\" They reply simultaneously.\n" +
                        "\n" +
                        "You wave goodbye as Zenji holds your hand, escorting you out.\n" +
                        "\n" +
                        "Once you’re outside Zenji suddenly stops, he pulls you close to him. \"<i>Is everyting okay, [name]? You know I love you, I never stopped loving you.</i>\"\n" +
                        "\n" +
                        "You assure him that everything is fine\n" +
                        "\n" +
                        "Zenji gently caresses your cheek with his fuzzy hand. \"<i>You can always talk to me. I have big ears like dese for listening, ya know.</i>\"\n" +
                        "\n" +
                        "Before you can respond, he lifts you to his face, planting his lips firmly on yours. You sink into his embrace as he kisses you mercilessly, his long tongue pushes into your mouth, breaking your resistance. You relax into his comfort, his tender kiss being the only thing you can focus on as if he were the only thing that existed in the world. You can feel his hand behind your head, keeping you close to him as the other roams your back, gently caressing your form.\n" +
                        "\n" +
                        "After a moment Zenji breaks the link, strands of saliva drip from his mouth from the raw passion he’s instilled into you.\n" +
                        "\n" +
                        "\"<i>Better..?</i>\"\n" +
                        "\n" +
                        "You nod, definitely better now.\n" +
                        "\n" +
                        "\"<i>Good, let's go home now.</i>\"\n" +
                        "\n" +
                        "Zenji escorts you back home safely.\n");
                doNext(camp.returnToCampUseOneHour);
            }

            function JabalaGossip():void {
                clearOutput();
                outputText("You say that you just wanted to spend some time with them and share stories.\n" +
                        "\n" +
                        "\"<i>Stories..?</i>\" Jabala responds.\n" +
                        "\n" +
                        "Halkano speaks up, \"<i>I tink I have a few tings ta talk about, what d’ya say, honey?</i>\"\n" +
                        "\n" +
                        "\"<i>Sharing stories is fun, gives me time to reflect on what’s been going on lately.</i>\" She responds.");
                switch (rand(4)) {
                    case 0:
                        outputText("Halkano speaks first, \"<i>Do you remember dat one time at de diner, Jabala? When you saw Yenza drinking her juice.</i>\"\n" +
                                "\n" +
                                "Jabala gasps, \"<i>No! How dare you! She had it coming! I grew the figs myself, I should be able to do what I want with it!</i>\"\n" +
                                "\n" +
                                "Zenji chuckles softly, \"<i>Oh mother, what did you do?</i>\"\n" +
                                "\n" +
                                "\"<i>She threw a glass of fig juice in Yenza’s face, completely ruining her dress.</i>\"\n" +
                                "\n" +
                                "You snicker softly and Zenji giggles to himself.\n" +
                                "\n" +
                                "\"<i>I told her since she wanted to be a whore that she should be prepared for a facial at any time.</i>\"\n" +
                                "\n" +
                                "\"<i>Well, since Mom couldn’t control herself, she’s no longer welcome at the diner until next week,</i>\" Halkano replies.\n" +
                                "\n" +
                                "Jabala rolls her eyes playfully.\n");
                        break;
                    case 1:
                        outputText("Halkano speaks up \"<i>What about dat one time when you went ta de Elder’s hut? What were you looking for..?</i>\"\n" +
                                "\n" +
                                "\"<i>When I was looking for straw to weave a new hat?</i>\" Jabala replies, \"<i>Yeah, I knew she some leftover, Rin was just being rude.</i>\"\n" +
                                "\n" +
                                "\"<i>Jabala…</i>\" Halkano says softly, \"<i>Like half of the village needs straw, you’re not going to get any when you go in the evening. I couldn’t get any dat day because I was busy</i>\"\n" +
                                "\n" +
                                "\"<i>Yeah, well… She could’ve been respectful about it.</i>\"\n" +
                                "\n" +
                                "Halkano sighs, \"<i>I tink perhaps next time you shouldn’t try to bribe someone ta give you someting dey don’t have.</i>\"\n");
                        break;
                    case 2:
                        outputText("\"<i>Oh!</i>\" Jabala exclaims, \"<i>What about that time we were in the diner together. Remember? I was eating the Hunter’s stew and you-</i>\"\n" +
                                "\n" +
                                "Halkano cuts her off with his palm, \"<i>I tink dat’s enough, dey don’t need to hear what happened.</i>\"\n" +
                                "\n" +
                                "Zenji raises an eyebrow at his father.\n" +
                                "\n" +
                                "\n" +
                                "Jabala weasels her way out of his grasp, \"<i>Dad was very tense, to put it nicely… It was a funny sight.</i>\"\n" +
                                "\n" +
                                "Halkano sighs, \"<i>Let’s just say dere was an accident...</i>\"\n");
                        break;
                    default:
                        outputText("Halkano thinks to himself for a moment, \"<i>De elder has been very quiet lately, hasn’t she?</i>\"\n" +
                                "\n" +
                                "Jabala nods, \"<i>Yeah, whenever I try to talk to her about getting more seeds she never seems to have anything to offer.</i>\"\n" +
                                "\n" +
                                "Halkano shakes his head, \"<i>Yubi has been very quiet lately, I worry for her. I dunno what’s going on but I hope everyting is okay.</i>\"\n" +
                                "\n" +
                                "\"<i>I can only hope nothing bad happens to our village,</i>\" Jabala responds\n");
                        break;
                }
                outputText("\"<i>Well, enough about that. What about you? Zenji? [name]? Anything going on back at your place?</i>\" Jabala asks\n");
                switch (rand(5)) {
                    case 0:
                        outputText("\"<i>Actually,</i>\" Zenji responds before you have a chance to speak up, \"<i>Whenever we sleep together, I noticed someting adorable. Whenever I can’t sleep, I will caress your face and you never fail to lean into my palm.</i>\"\n" +
                                "\n" +
                                "You smile softly at him, it’s a strange sense of comfort knowing that he watches you sleep sometimes.\n");
                        break;
                    case 1:
                        outputText("\"<i>Dere was dis goblin one time, not too long ago actually. She kept calling me a stud. It was a little weird coming from a tiny lady. I just ignored her, but she was very pushy and wouldn’t leave me alone. It’s like all some people can tink about is sex all de time. I’m glad you’re not like dat, right, [name]?</i>\"\n");
                        break;
                    case 2:
                        outputText("\"<i>I remember de swamp dat’s not too far from de bog. Dere was dis strange cave wit an egg in it. I dunno who would leave an egg just lying alone in a cave, but it seemed lonely. I didn’t want to incur de wrath of a mother, so I just left it alone. Didn’t bother to get dat close to it.</i>\"\n");
                        break;
                    case 3:
                        outputText("Zenji rolls his shoulders, \"<i>My muscles have been really sore lately… I could use a break and just relax for a while.</i>\"\n" +
                                "\n" +
                                "Halkano chuckles, \"<i>Hey Zenji, come here, why don’t we check out if you’re bigger dan your old man, hmm?</i>\"\n" +
                                "\n" +
                                "Zenji smirks, \"<i>Alright, we’ll see about dat.</i>\"\n" +
                                "\n" +
                                "Jabala hops off of Halkano’s lap before he stands up. She sits back on the chair. Zenji stands up, the weight of the couch shifts as he lifts himself off.\n" +
                                "\n" +
                                "The two of them stand back to back, Halkano being slightly taller than Zenji. They both pose with double biceps flexing. Zenji gives you a coy wink as you watch.\n" +
                                "\n" +
                                "\"<i>Alright, who’s bigger?</i>\" Zenji asks.\n" +
                                "\n" +
                                "You stand up and get closer, Jabala follows as well. It’s very close and difficult to judge by eyeballing it. Zenji, while leaner, is very muscular and perfectly built. Halkano on the other hand is far bulkier and beefy, with a little less muscle tone.\n" +
                                "\n" +
                                "After close inspection from all angles, it’s apparent that Halkano’s arms are bigger, but only slightly.\n" +
                                "\n" +
                                "\"Hope you've had your fun, you two.</i>\" Jabala teases.\n" +
                                "\n" +
                                "\"<i>Haha! Can’t beat dad just yet, son!</i>\"\n" +
                                "\n" +
                                "Zenji laughs, \"<i>One day... One day…</i>\"\n" +
                                "\n" +
                                "The four of you return to your seats once the verdict is clear.\n");
                        break;
                    default:
                        outputText("\"<i>Eh… Noting really interesting going on lately.</i>\" He wraps an arm around your shoulder, pulling you closer to him, \"<i>My love for you is as strong as always, [name].</i>\"\n" +
                                "\n" +
                                "The four of you spent the rest of the hour in idle chit chat, talking about irrelevant topics going on with you and Zenji as well as the village.\n" +
                                "\n" +
                                "After some time Zenji speaks up, \"<i>It’s getting a little late, why don’t we go home now, [name]?</i>\"\n" +
                                "\n" +
                                "You nod, figuring it’s about time to continue the day.\n");
                        break;
                }
                outputText("You excuse yourself and say your goodbyes. Halkano and Jabala dismiss you as Zenji escorts you back to camp.\n");
                doNext(camp.returnToCampUseOneHour);
            }

            function JabalaSexWZenji():void {
                clearOutput();
                outputText("You gesture for Zenji to lean closer to you. He does so without hesitation. You ask him quietly if he’s willing to get intimate with his parents right now.\n");
                if (player.lib < 80) outputText("Zenji looks at you with a disappointed glance, \"<i>No, let’s… not do that…</i>\"\n");
                else outputText("Zenji takes a deep, long sniff. \"<i>Hmm... no, not feeling it right now.</i>\"\n");
                outputText("You decide not to press the issue further and think about what else you wanted to talk about.\n");
                doNext(SceneLib.trollVillage.EnterTheVillage);
            }

            function JabalaSayonara():void {
                clearOutput();
                outputText("You realize that you have nothing left to talk about right now. You apologize to Zenji and his parents for wasting their time.\n" +
                        "\n" +
                        "\"<i>Lost your train of thought? It’s okay [name], happens ta all of us.</i>\"\n" +
                        "\n" +
                        "Jabala doesn’t even register the comment as she’s already staring off into the distance.\n" +
                        "\n" +
                        "\"<i>Come back any time, it’s always nice to see ya,</i>\" Halkano replies, nudging Jabala softly.\n" +
                        "\n" +
                        "\"<i>Oh!</i>\" she responds. \"<i>Farewell!</i>\"\n" +
                        "\n" +
                        "Zenji holds your hand as he escorts you out of the house. You consider where you want to go within the village now.\n");
                doNext(SceneLib.trollVillage.EnterTheVillage);
            }
        }

        function JabalaNVM():void {
            outputText("You realize that you don’t want to be here at this time and apologize for wasting his time.\n" +
                    "\n" +
                    "\"<i>It’s alright, tings happen, I understand. Stay safe</i>\"\n" +
                    "\n" +
                    "You dismiss yourself and he closes the door behind you.\n");
            doNext(SceneLib.trollVillage.EnterTheVillage);
        }
    }

    public function JabalaHalkanoTalk(desc:Boolean = false):void {
        clearOutput();
        if (desc) {
            outputText("You tell Halkano that you wanted to talk with him for now.\n" +
                    "\n" +
                    "\"<i>Ah? Is dat so?</i>\" Halkano responds as he rests on the couch.\n" +
                    "\n" +
                    "You take the seat on the couch next to him, it’s a little cramped with just how massive he is, but there’s enough room for you.\n" +
                    "\n" +
                    "\"<i>What is dere ya wanted ta talk about?</i>\"\n");
        }
        else{
            outputText("What do you want to ask Halkano about?");
        }
        menu();
        addButton(0, "Appearance", SceneLib.trollVillage.halkano.HalkanoAppearance);
        addButton(1, "Gossip", JabalaHalkanoGossip);
        addButton(2, "Sex", SceneLib.trollVillage.halkano.JHalkanoSexScenes);


        function JabalaHalkanoGossip():void {
            outputText("You ask Halkano if he has anything interesting to talk about.\n" +
                    "\n" +
                    "\"<i>Ah, ya want ta hear some stories, do ya? I think I can recall some weird stuff going on lately.</i>\"\n");
            switch (rand(4)) {
                case 0:
                    outputText("\"<i>Yenza asked me ta help build her a table for her tailing store… Honestly, de nerve of some people! I told her ta get lost, I’m neva doing anyting for her, ever and left de diner. Honestly, I’m sure she was looking fa more dan just my work, I tink she wanted de entire package.</i>\"");
                    break;
                case 1:
                    outputText("\"<i>Kal’ji gave me dis weird look de other day... It sent shivers down ma spine… I trust him, but I will neva forget dat look he gave me…</i>\"\n" +
                            "\n" +
                            "Halkano shudders.\n" +
                            "\n" +
                            "\"<i>Creepy…</i>\"\n");
                    break;
                case 2:
                    outputText("\"<i>Don’t tell her I told you dis, but Jabala is getting real frisky. I tink she’s getting into heat or someting! She keeps touching me and I dunno how ta respond because we’re in public! She told me it’s because I’m so big dat her hands constantly touch me ‘on accident’. If I knew getting dis big fa her would make her act like dis den… well… I dunno, maybe I kinda like it I guess.</i>\"");
                    break;
                default:
                    outputText("\"<i>I… actually don’t have anything interesting ta talk about right now…</i>\"");
                    break;
            }
            outputText("A moment of silence passes.\n" +
                    "\n" +
                    "\"<i>Well, it was nice talking ta ya, but I should check on Jabala and see if she’s alright. It was nice talking ta ya, [name].</i>\"\n" +
                    "\n" +
                    "You excuse yourself as well and leave his home.\n");
            doNext(camp.returnToCampUseOneHour);
        }

    }

    private function JabalaSelfTalk(desc:Boolean = false):void {
        clearOutput();
        if (desc) {
            outputText("You tell Halkano that you wanted to talk to Jabala right now.\n" +
                    "\n" +
                    "\"<i>Alright, she’s in de back yard taking care of her garden. I’ll lead de way.</i>\"\n" +
                    "\n" +
                    "Halkano shows you to the back yard and Jabala is currently weeding the garden, dressed in her iconic straw hat.\n" +
                    "\n" +
                    "Jabala gives an inattentive wave to Halkano as she continues digging her hands into the soil.\n" +
                    "\n" +
                    "\"<i>Jabala…</i>\"\n" +
                    "\n" +
                    "\"<i>A la izquierda por favor, gordo.</i>\" She replies, shaking her hand toward him dismissively.\n" +
                    "\n" +
                    "Halkano chuckles softly, \"<i>[name] is here ta talk ta ya.</i>\"\n" +
                    "\n" +
                    "Jabala finally looks up, \"<i>¡Ay! Lo siento!</i>\" She shakes her head, \"<i>I always get so sucked into what I do, I forget there’s other stuff going on.</i>\"\n" +
                    "\n" +
                    "\"<i>Good luck,</i>\" Halkano mumbles to you before he re-enters his home.\n" +
                    "\n" +
                    "Jabala now gives you her attention, \"<i>Is there something you wanted..?</i>\"\n");
        }
        else{
            outputText("What do you want to talk to Jabala about?");
        }
        menu();
        addButton(0, "Appearance", JabalaAppearance);
        addButton(1, "Gossip", JabalaGossip);
        addButton(2, "Sex", JabalaSex);

        function JabalaGossip():void {
            clearOutput();
            outputText("You ask Jabala if she has anything interesting to talk about.\n" +
                    "\n" +
                    "\"<i>¡Qué roche! I should’ve brought some tea!</i>\" Jabala sighs, \"<i>Well, we can still talk without any. Things have been a little weird lately.</i>\"\n");
            switch (rand(5)) {
                case 0:
                    outputText("\"<i>It happened not too long ago. Yenza was flashing my husband the crazy eye. We had a staring contest in the middle of the diner and Halkano had to drag me out of the place. I’ll never forgive that bitch for raping my son.</i>\"\n" +
                            "\n" +
                            "Jabala sighs. \"<i>It’s the worst feeling when you can no longer protect someone you care about from the trauma. Knowing that my son has been raped… What a whore she is.</i>\"\n");
                    break;
                case 1:
                    outputText("\"<i>I remember when Halkano helped me make this garden such a long time ago… Seeing his strong arms. He’s so much stronger now. Have I mentioned Halkano works out..? He does and he’s definitely gotten stronger.</i>\"\n" +
                            "\n" +
                            "Jabala sighs softly, \"<i>Sometimes all I want is for him to hold me, for him to be there with me and tell me everything will be fine. He’s so calm, gentle, and patient with me and my rambles. I could just go on and on about how great he is… Because he deserves praise. I couldn’t have asked for a better husband.</i>\"\n");
                    break;
                case 2:
                    outputText("\"<i>I was talking to Yubi earlier. We’re running low on seeds and our crops aren’t germinating. She said that the usual trade has been halted and we don’t have any good fertilizer right now. I’ve been growing concerned, but I have trust in her ability to maintain a steady village.</i>\"\n" +
                            "\n" +
                            "Jabala sighs, \"<i>Sometimes I feel like she just wants to help but is unsure how to do so.</i>\"\n");
                    break;
                case 3:
                    outputText("\"<i>I was talking to Kuru at the diner earlier. She works so hard and tirelessly, I honestly think she goes unnoticed for everything she does as a waitress. So I baked her a little cake. Nothing too big, but something special for someone who deserves it. The look on her face is something I’ll never forget.</i>\"\n");
                    break;
                default:
                    outputText("Jabala looks down at her garden intently, \"<i>Sometimes when I’m getting stressed out, I like to have time to myself, just me and my plants. It’s nice to have company I guess, especially from my husband. Although, it’s like my garden understands me, the way they rustle in the wind at my approach. Springing to life under the rain of my watering can. They’re almost like my children…</i>\" \n");
                    if (TrollVillage.ZenjiVillageStage >= 1) {
                        outputText("She sighs softly in relief. \"<i>Thank you… Seeing Zenji again means a lot to me.</i>\"\n");
                    } else {
                        outputText("Jabala sheds a tear.\n");
                    }
                    break;
            }
            outputText("Jabala sets her watering can on the ground. \"<i>It was nice talking to you, but I would like to have some time to myself right now. If you don’t mind....</i>\"\n" +
                    "\n" +
                    "You understand and give her room for herself as you leave their house.\n");
            doNext(camp.returnToCampUseOneHour);
        }

    }

    private function JabalaSex():void {
        clearOutput();
        outputText("You ask Jabala if she’s willing to get a little more intimate with you.\n" +
                "\n" +
                "She sets her watering can down beside her. \"<i>You… You want to do what exactly?</i>\"\n" +
                "\n" +
                "You want to see the rest of her body and have the chance to share an intimate moment with her.\n" +
                "\n" +
                "\"<i>Sorry, I… I really only have a thing for my husband, I hope you don’t mind...  Well… If you really want the chance, I guess I will, but only if my husband isn’t against the idea.</i>\" Jabala mutters softly to herself, \"<i>I can’t believe I’m doing this…</i>\"\n" +
                "\n" +
                "Jabala opens the door and gestures for you to follow. You do so and she instructs you to wait on the couch. She enters her bedroom as you wait for her.\n" +
                "\n" +
                "After a moment of muffled chat Jabala exits the room sheepishly. She nods her head, \"<i>Come in… We’re ready.</i>\"\n" +
                "\n" +
                "The two of you enter together and Halkano is resting on the bed, he places the book he was reading on the nightstand next to the bed. You can hear his tail gently slap against the bed in anticipation.\n" +
                "\n" +
                "\"<i>I heard ya wanted ta get frisky. Well, here we are, dis is whatcha want, dis is what we got.</i>\"\n" +
                "\n" +
                "Jabala climbs onto the bed next to her husband, \"<i>I hope you don’t mind, I just couldn’t do anything without my husband.</i>\"\n" +
                "\n" +
                "You consider what you want to do now with the two of them.\n");
        menu();
        if (player.hasCock() || player.hasVagina()) addButton(0, "SpitRoast", JabalaSpitroasted);
        else addButtonDisabled(0, "SpitRoast", "You don't have anything for Jabala to eat out!");
        addButton(1, "Double Worship", JabalaDWorship);
        addButton(2, "Never mind", JabalaBlueBalls);

        function JabalaBlueBalls():void {
            clearOutput();
            outputText("You apologize and say that you aren’t too keen on the idea anymore.\n" +
                    "\n" +
                    "Jabala holds her hands over her face, embarrassed. Halkano quickly pulls her in for a hug to help her relax.\n" +
                    "\n" +
                    "He turns to you, \"<i>You should get going now, then.</i>\"\n" +
                    "\n" +
                    "You do so before causing any more conflict.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaSpitroasted():void {
            outputText("Since there’s three of you, you tell them that You think that the two of you could get to work on Jabala.\n" +
                    "\n" +
                    "Halkano raises an eyebrow, \"<i>Sandwich Jabala between us..?</i>\"\n" +
                    "\n" +
                    "You nod, it’s a spit roast.\n" +
                    "\n" +
                    "Jabala looks up toward Halkano with faint hope in her eyes.\n" +
                    "\n" +
                    "\"<i>She’s into it, but I’ll be de one penetrating her. You can have fun wit her mouth.</i>\"\n" +
                    "\n" +
                    "You figure that’s to be expected.\n");
            if (player.hasCock()) {
                outputText("Halkano slowly unbuttons Jabala’s shirt for her, tossing it aside as he removes the rest of her clothing. Once she’s naked she helps Halkano slide out of his pants.\n" +
                        "\n" +
                        "Once everyone is naked Halkano kneels at the edge of the bed, pulling her to him. Jabala is lying stomach down on the mattress, wrapping her legs around Halkano as he aligns his girth with her vagina.\n" +
                        "\n" +
                        "You kneel in front of Jabala as your shaft swells to full erection. Jabala grabs hold of your waist for support as she brings her head to the tip of your penis, cautiously rubbing the underside of your head with her long, grey tongue. Once Halkano is content with his lubrication, you note the bed shaking as he begins thrusting. Jabala moans loudly as her body is rocked by the force of his humping.\n" +
                        "\n" +
                        "She places her lips around your length, trying to stimulate you before she moves further down your length. Her hand glides down to the underside of your dick as she slowly strokes your balls with her svelte fingers.\n" +
                        "\n" +
                        "Jabala is constantly thrusted against you as she continues blowing you. Her soft moans reverberate through you as she struggles to maintain a steady rhythm on you. Her attempts are appreciable, she seems to have enough knowledge about where to place her tongue around your manhood to coax a few pleasured moans from you.\n" +
                        "\n" +
                        "You place your hands on the back of her head, pulling her closer to you, forcing her further down your erection.\n" +
                        "\n" +
                        "You can hear Halkano growling softly as he slowly picks up the pace, getting closer to his orgasm. You can sense your climax rolling up as well.\n" +
                        "\n" +
                        "Jabala moans in pleasure, tensing her grip on you as she rolls her tongue around your girth. Halkano’s growling steadily grows louder as he continues thrusting against her. Jabala cries out softly as her orgasm hits, a sweet scent fills the room.\n" +
                        "\n" +
                        "Pressure builds up within your loins as Jabala continues teasing your clit with her soft fingers. You thrust into her tongue as you cum. Your seed jets into her awaiting mouth as she desperately attempts to swallow every last drop you have to offer.\n" +
                        "\n" +
                        "Halkano roars with force as he cums as well, thrusting into Jabala with greater vigor, causing her to press her face up against your box.\n" +
                        "\n" +
                        "You lie down on the bed, sighing in relief as your orgasm dissipates. Jabala moans softly, satisfied with the loving her husband gave her, and happy to know that she managed to get you off as well.\n" +
                        "\n" +
                        "Halkano is slowly pounding away at Jabala, still leaking copious amounts of cum before he finally relaxes.\n" +
                        "\n" +
                        "He picks you up along with his wife as the three of you take a moment to collect yourselves, lying beside each other.\n" +
                        "\n" +
                        "After a moment passes you decide that it’s best to get going, you say your goodbyes before packing up your stuff and leaving them.\n" +
                        "\n" +
                        "Halkano gives you a lazy wave goodbye as Jabala nestles herself comfortably against him.\n");
            } else {
                outputText("Halkano slowly unbuttons Jabala’s shirt for her, tossing it aside as he removes the rest of her clothing. Once she’s naked she helps Halkano slide out of his pants.\n" +
                        "\n" +
                        "Once everyone is naked Halkano kneels at the edge of the bed, pulling her to him. Jabala is lying stomach down on the mattress, wrapping her legs around Halkano as he aligns his girth with her vagina.\n" +
                        "\n" +
                        "You kneel in front of Jabala, your vagina is wet and dripping occasional beads of lubricant in anticipation for her. Jabala grabs hold of your waist for support as she brings her head to your netherlips, cautiously rubbing the underside of your clit with her long, grey tongue. Once Halkano is content with his lubrication, you can feel the bed shake as he begins thrusting. Jabala moans loudly as her body is rocked by the force of his humping.\n" +
                        "\n" +
                        "She presses her face against your crotch, desperately stimulating your clitoris before she digs her tongue past your lips. Her hand glides down next to her tongue as she slowly probes at your clit with her svelte fingers.\n" +
                        "\n" +
                        "Jabala is constantly thrusted against you as she continues eating you out. Her soft moans reverberate through you as she struggles to maintain a steady rhythm on you. She is making an attempt and is knowledgeable in where to dig her tongue to coax some pleasured moans from you.\n" +
                        "\n" +
                        "You gently rub your breasts with one hand, fondling yourself gently.\n" +
                        "\n" +
                        "You can hear Halkano growling softly as he slowly picks up the pace, getting closer to his orgasm. You can sense your climax rolling up as well.\n" +
                        "\n" +
                        "Jabala moans in pleasure, tensing her grip on you as she rolls her tongue around your inner walls. Halkano’s growling steadily grows louder as he continues thrusting against her. Jabala cries out softly as her orgasm hits, a sweet scent fills the room.\n" +
                        "\n" +
                        "Pressure builds up within your loins as Jabala continues teasing your clit with her soft fingers. You clench around her tongue as you cum. Your girlcum flows down onto her tongue, spilling out onto the bed below her.\n" +
                        "\n" +
                        "Halkano roars with force as he cums as well, thrusting into Jabala with greater vigor, causing her to press her face up against your box.\n" +
                        "\n" +
                        "You lie down on the bed, sighing in relief as your orgasm dissipates. Jabala moans softly, satisfied with the loving her husband gave her, and happy to know that she managed to get you off as well.\n" +
                        "\n" +
                        "Halkano is slowly pounding away at Jabala, still leaking copious amounts of cum before he finally relaxes.\n" +
                        "\n" +
                        "He picks you up along with his wife as the three of you take a moment to collect yourselves, lying beside each other.\n" +
                        "\n" +
                        "After a moment passes you decide that it’s best to get going, you say your goodbyes before packing up your stuff and leaving them.\n" +
                        "\n" +
                        "Halkano gives you a lazy wave goodbye as Jabala nestles herself comfortably against him.\n");
            }
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaDWorship():void {
            outputText("You ask Jabala if she’s willing to help you \"<i>assist</i>\" Halkano with his needs.\n" +
                    "\n" +
                    "Jabala turns to Halkano and he gives her a devious grin, \"<i>Well, two on one, how about dat..?</i>\"\n" +
                    "\n" +
                    "Jabala gives a sheepish grin as she begins to slowly unbutton her blouse." + player.clothedOrNaked("You take off your [armor] as well.", "") + "\n" +
                    "\n" +
                    "Jabala climbs onto the bed with her awaiting husband. Halkano gestures for you to approach, \"<i>Come on den, she’s not gonna do all de work. Help me get out of dese pants.</i>\"\n" +
                    "\n" +
                    "You grab one pant leg and Jabala grabs the other, the two of you pull slowly until Halkano has completely slid out of his pants. His length hangs flaccid before the two of you.\n" +
                    "\n" +
                    "Halkano leers at the two of you, \"<i>It’s not gonna raise itself, why don’t da two of you give my little boy some help..?</i>\"\n" +
                    "\n" +
                    "The two of you approach his length. Jabala is at his left flank, gently strokes his leg as she cups his balls with her svelte fingers. As you approach, you run your hand across his beefy legs, they’re dense and muscular to support such a large troll. The two of you press your body against him, Jabala gets close and licks the side of his shaft. You get closer to Halkano as well, pressing your face against his girth as you lick his shaft. The air is musky from Halkano’s scent as you lick him up and down with Jabala. Spurts of pre leak from his tip, cascading down his girth as the two of you take turns licking up his salty favor.\n" +
                    "\n" +
                    "Jabala eagerly presses her lips at the tip of Halkano’s girth, pushing you to the side. Halkano reaches his tail underneath her chin, lifting her face to meet his gaze, \"<i>Now, now, honey… Ya gotta share, let [name] have a turn too.</i>\"\n" +
                    "\n" +
                    "Jabala blushes softly before moving back slightly, giving you a chance to get closer to his length. With your space returned you rest your head against the top of his muscular thigh, wrapping your tongue around his length to the best of your ability as you continue servicing him.\n" +
                    "\n" +
                    "You can feel Halkano’s length twitch slightly underneath your tongue, you can feel your arousal growing beneath him. " + (player.hasCock() ? "You reach your hand down and grab at your length, gently stroking yourself, getting off as well." : "You reach your hand down and probe at your clit as you begin to finger yourself.") + "\n" +
                    "\n" +
                    "You can hear Jabala moan softly in pleasure as she blows Halkano with you, you can tell she had the same idea.\n" +
                    "\n" +
                    "Halkano lets loose a very deep, low growl. \"<i>Keep it up, I’m getting closer…</i>\"\n" +
                    "\n" +
                    "Jabala redoubles her efforts in licking up and down his length as you help her. You cup his hefty balls, playing around with his meat. His balls are fuzzy and heavy, ready to deposit his load to the two of you.\n" +
                    "\n" +
                    "Halkano moans from your ministrations, \"<i>Mmmm… Keep it up… Touch me... Get dose hands to good use.</i>\"\n" +
                    "\n" +
                    "Jabala sighs softly, her hand over her clit, dipping past her lips as she masturbates herself as well. Her hand wraps around his length, pulling herself closer to him as she glides her tongue up and down his length.\n" +
                    "\n" +
                    "The two of you almost butt heads, both of you trying to get him off. Halkano begins thrusting slightly, nearing his climax.\n" +
                    "\n" +
                    "Halkano growls louder, \"<i>So close, almost dere! Don’t stop!</i>\" His thrusts become more aggressive, his erection pulses between the two of you, ready to burst.\n" +
                    "\n" +
                    "You continue getting yourself off, so close as well. You can hear Jabala moan quietly as she cums. Halkano roars with vigor as he reaches the height of his orgasm. Thick ropes of cum shoot out before you and all over the bed. You find yourself finally reaching your climax as well. " + (player.hasCock() ? "Unleashing your load onto the bed beneath you." : "Vaginal fluids drip past your lips onto the bed beneath you.") + "\n" +
                    "\n" +
                    "Halkano sighs as his body begins to relax and his orgasm dies down. The length of his girth is still covered in cum as the two of you help clean him off.\n" +
                    "\n" +
                    "Once you’ve cleaned him off Halkano gives you a knowing smirk, \"<i>Ya did good, de two of you make a good team.</i>\" He says with a small chuckle.\n" +
                    "\n" +
                    "After a moment in the afterglow, Halkano helps clean you up before you take up your things and leave. Jabala is nestled against him in his bed as, resting quietly as Halkano gives you a wave goodbye.\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }

    private function JabalaAppearance():void{
        clearOutput();
        outputText("Jabala is a 6’10\" female troll. She has long, lime green braided hair that reaches just below her waist. She is currently wearing her iconic straw hat and simple blue-dyed fur overalls.\n" +
                "\n" +
                "She has fairly plain features for a female troll, symmetrical face, and blue, almond-shaped eyes. She has the normal features you’d expect on a troll, a pronounced nose, and long, elven ears. Albeit her tusks are almost nonexistent.\n" +
                "\n" +
                "She has a rather tomboyish figure, rectangular body shape, and flat chest. Her form is svelte and very small compared to most other trolls, especially compared to her husband who is well over twice her size. She has the usual four-fingered hands and toes that trolls have. While some female trolls do have very short tails, she does not have any tail compared to the usual longer tails that male trolls carry.\n" +
                "\n" +
                "Jabala turns back to caring for her garden as you eye her up and down.\n");
        doNext(JabalaSelfTalk);
    }
}
}
