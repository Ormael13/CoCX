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
        outputText("Zenji grabs your hand, \"Follow me [name], dere’s… dere’s something I need to do first…\"\n\n");
        outputText("Zenji gently, but hurriedly drags you along toward a hut. Zenji takes a deep breath before knocking on the wooden door.\n\n");
        outputText("A short, older female troll pushes the door aside. She is about 6’8\" wearing a fur cloak and pants, her long, lime hair drapes down to her hips. Her tusks are a lot shorter than most trolls you’ve seen, barely over an inch past her lips. She staggers back slightly after seeing Zenji.\n\n");
        outputText("Zenji speaks up, \"Mamá soy yo otra vez. Y-\"\n\n");
        outputText("She leaps forward to hug him, \"Oh, Zinny, my little Zinny... I was so worried when you left, you never said anything to me!\" She begins crying, \"I thought something bad might’ve happened to you!\" She lets go of him and Zenji wipes her tears away. \"Your father must know that you’re back!\" She turns around before hollering, \"Halkano! There’s someone here that needs to talk to you, right now!\" She turns around toward you, \"¡Debes ser la flaca! I’ll be sure to get to know you soon.\"\n\n");
        outputText("\"Oh, Jabala…\" A gruff voice replies, \"You say dat everyone needs ta talk ta me right now…\" A large, beefy troll approaches he is easily 8’ as he is just shorter than the ceiling, clad only in fur pants, he is scratching his beard. He gasps audibly upon seeing Zenji. \"Zenji..! I-It’s you!\"\n\n");
        outputText("Zenji gives a small chuckle, \"Wow… dad, it’s good ta see you again… you’ve gotten much bigger since I left.\"\n\n");
        outputText("\"I’m just glad ya are back.\" He consoles, hugging Zenji.\n\n");
        outputText("Halkano chuckles once he breaks the embrace, \"When you left without saying anyting… your mother couldn’t take it…\" He places his large hand on her shoulder, causing her to blush softly, \"I did my best ta cheer her up, and… I decided dat I wanted ta be more for her. I worked on myself tirelessly. I did it for ya mother, but it also helped me deal with losing my son as well...\" Halkano gently pulls Jabala closer to him as she blushes harder, leaning into his dense fur. \"I’m just glad ya are back.\"\n\n");
        outputText("Jabala speaks up, \"Come, come, we have so much to talk about, and you can introduce us to your new friend you have here!\" Jabala leads you to the interior as you follow behind Zenji.\n\n");
        outputText("Zenji speaks up, \"Mom… Dad… dis is [name], dey’re… dey’re my soul mate, my lover, ma one and only..\"\n\n");
        outputText("Halkano’s eyes widen tremendously and Jabala gasps, \"A-after... \" Jabala mutters, \"Oh, It’s a pleasure to meet you, [name]! You two will have the cutest grandchildren for me!\"\n\n");
        outputText("Halkano chuckles softly, \"Good on ya, Zenji. Welcome to de family, [name].\"\n\n");
        outputText("There’s a small couch for you and Zenji to sit on as Halkano is seemingly too big for it now. Halkano seats himself on a sturdy seat as Jabala rests on his lap.\n\n" +
                "Zenji spends some time talking about how the two of you met as he catches up with his parents.\n\n");

        if (flags[kFLAGS.ZENJI_KIDS] != 0) {
            outputText("Zenji mentions that he’s already had children with you.\n\n");
            outputText("Jabala’s face illuminates as she leaps off Halkano’s lap, \"Oh, Zenji! I am so proud of you, really need to bring them here one day.\"\n\n");
            outputText("\"Now, now, Jabala,\" Halkano interjects,  \"Dey’re just babies if anyting we have ta visit dem because it’s too dangerous ta carry babies outside of de village.\"\n\n");
            outputText("Jabala pouts before returning to Halkano’s lap, giving an exasperated sigh, \"Well, I’m sure [name] will be an excellent mother. Zenji knows what it’s like ta have one.\"\n\n");
            outputText("Zenji blushes softly as he forces out some laughter. You caress his face lovingly to reassure him as he rests his face in your palm for a moment.\n\n");
        }

        outputText("You spend nearly an hour talking with them before you decide it’s best to call it for now and return to your camp with Zenji.\n\n");
        outputText("Jabala speaks up, \"I understand, I’m sure you have very important things to take care of.\"\n\n");
        outputText("\"Take care of Zenji for us, [name]. Marae knows how careless he can get sometimes.\" Halkano teased as the two of you leave.\n\n");
        outputText("Jabala’s hut added to the troll village!");
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
                    "\"You think this is a game? Toying with my sweet little boy? Stay away from my family!\" She cries.\n");
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
            outputText("Jabala’s Hut has been added to the troll village!\n");
            doNext(camp.returnToCampUseOneHour);
        } else if (!TrollVillage.ZenjiFollowing) {
            outputText("Your gaze roams around until you decide to approach Jabala. Deciding that you want to talk to her again, you decide to approach her.\n" +
                    "\n" +
                    "She is currently staring off into the distance, unaware of her surroundings as her half-full cup of juice rests beside her.\n" +
                    "\n" +
                    "Once you approach, her eyes zone in before shifting to meet your gaze. \"Oh, [name]! I didn’t notice you there. It’s good to see you, how's everything going?\"\n" +
                    "\n" +
                    "You assure her that things could be worse.\n" +
                    "\n" +
                    "\"Oh, well, I hope things will turn out for the best around you. Come, sit, was there something you wanted to talk about?\"\n");
            addButton(0, "Herself", JabalaSelfIntro);
            addButton(1, "The People", JabalaGossip);
        } else {
            outputText("Your gaze shifts around before spotting Jabala sitting by herself in the diner. You ask Zenji if he wants to meet up with his mother.\n" +
                    "\n" +
                    "Zenji grasps onto your hand. \"Sure, dat sounds nice, [name]. De three of us can have a chat together.\" \n" +
                    "\n" +
                    "He guides you to his mother, she’s looking off into the distance, not noticing your approach.\n" +
                    "\n" +
                    "\"¡Hola mamá!\" Zenji exclaims.\n" +
                    "\n" +
                    "\"Zenji!\" Jabala responds, shaken into reality as she turns to face the two of you. \"[name]! It’s good to see the two of you! Come! Come! I hope everything’s been well.\"\n" +
                    "\n" +
                    "Zenji nods, \"It’s been just great, I love [name] wit all my heart, and I’m sure dey feel de same.\"\n" +
                    "\n" +
                    "Jabala smiles, \"That’s wonderful, glad you two are happy together. You two remind me so much about myself when I was your age. I was dumbstruck, couldn’t even separate myself from Halkano, spent every night together...\" Her gaze sets off into the distance again.\n" +
                    "\n" +
                    "Zenji blushes, \"¡Mamá!\"\n" +
                    "\n" +
                    "\"Oh.. Did I get carried away again..? Oh, what time is it..? I had best get going now. It was a pleasure to meet up with the two of you again!\"\n" +
                    "\n" +
                    "Jabala gives the two of you a hug before leaving.\n" +
                    "\n" +
                    "\"Come, [name]. Let’s go, it was nice ta catch up wit her again, even if she gets lost in thought like always.\"\n" +
                    "\n" +
                    "Zenji holds your hand as he leads you out of the diner.\n");
            doNext(SceneLib.trollVillage.EnterTheVillage);
        }

        function JabalaSelfIntro():void {
            outputText("You tell Jabala that you want to get to know her better, she seems like an interesting person after all. Who is she, what does she do?\n" +
                    "\n" +
                    "\"About myself... Hmm…\" Jabala pauses for a moment, looking off into the distance, \"Well, I am a farmer by profession and a gardener in my free time. I mostly grow greens, and figs… lots of figs… I guess trolls really like their figs, don’t they?\"\n" +
                    "\n" +
                    "Jabala snickers to herself, \"Yeah, all the farming is what led me to the man of my dreams… My husband, Halakno, Such a big... Strong carpenter…\" She says, blushing slightly, \"It just kind of happened. I lost all control when I was near him and he didn’t resist my advance.\"\n" +
                    "\n" +
                    "\"It wasn’t until long until we got married and had our first child together, we loved him with all our hearts, but…");
            if (TrollVillage.ZenjiVillageStage > 0) {
                outputText(" Thanks to you I know he’s safe.");
            }
            outputText("\"\n\n" +
                    "\"Nothing changes here, it’s simple, sweet and I like what I do. Gardening in my free time always lifts my spirits, especially when Halkano is there.\"\n" +
                    "\n" +
                    "Jabala looks off into the distance again. \"I really should get going, [name]. It was nice talking to you, sorry I didn’t give you much of a chance to speak, I kind of got lost in thought. Until we meet again!\"\n" +
                    "\n" +
                    "Jabala stands up and leaves. Seeing that there’s not much left to do now, you decide to exit the dining hall.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaGossip():void {
            outputText("You ask Jabala about the people of the village, she seems fairly sociable for a farmer.\n" +
                    "\n" +
                    "\"The people here are pleasant to talk to… for the most part. Gossip is hard to come by because most people are into their own things, but I tell you, I’ve been hearing a lot of whispers going around about this gay guy… I don’t personally know any gay guys around here, but I hear this guy is almost like a predator for other men. Just what I heard though. Oh, the seamstress, oh no, the seamstress. Don’t talk to her, she has a nose for trouble and should keep her hands to herself. If she ever talks to you, don’t talk to her. Almost reminds me of the elder. All she does is tuck herself into her own thing, disregarding the pleas of others and is generally unaware of the world around her. She’s not bad at keeping rules governed and keeping the rest of the elders in balance, but she’s also hard to even listen to.\"\n" +
                    "\n" +
                    "Jabala’s gaze sets off into the distance for a moment before her eyes roll back to you. \"Where was I..? Oh, is there anything else you had in mind?\"\n");

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
                    "\"Oh, it is.\" She responds. \"Rumor has it’s the elder Kal'ji. ¡Qué cabro! He totally has the hots for this one farmer. Or so I’ve heard…\"\n" +
                    "\n" +
                    "She looks around, almost as if she were worried about eavesdroppers. \"From what I’ve heard, he’s a terrible lover in bed! But you didn’t get this from me.\"\n" +
                    "\n" +
                    "Jabala leans back, adjusting her straw hat. \"Well, I best get going for now, it was nice talking to you [name].\" She leaves after dismissing herself.\n" +
                    "\n" +
                    "You decide to pack up as well and head out the diner.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaSeamstress():void {
            outputText("You want to hear more about the seamstress, did she actively cause trouble?\n" +
                    "\n" +
                    "Jabala sighs, \"Puta de chongo. Yenza has been on the hunt for many men. She attacked my son and if I didn’t stop them, then I don’t know what could’ve happened. I don’t want to talk about that girl anymore. I should get going anyway\"\n" +
                    "\n" +
                    "She adjusts her straw hat before dismissing herself.\n" +
                    "\n" +
                    "You decide to pack up as well and head out the diner\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaElder():void {
            outputText("You want to hear more about the elder, what makes her so difficult?\n" +
                    "\n" +
                    "\"Yubi? She’s mostly in her own world, thinking about what’s best and doing what she would like to do. Sometimes she tries and looks out for the people, but it’s difficult to know if she’s doing it for everyone or herself.\"\n" +
                    "\n" +
                    "Jabala looks into the distance but still talks to you. \"I feel like she wants what’s best for the people. I feel it in my heart, she just wants to do good, but she’s lost her way and is unsure what to do now. She’s been the chief elder for… how long..? I know she means well, but I feel like she’s losing her touch with the people.\"\n" +
                    "\n" +
                    "Jabala’s gaze shifts back to you. \"She’s not a bad person, she never was. Enough about her though, I best get going now. Farewell, [name].\" Jabala packs up her things before leaving.\n" +
                    "\n" +
                    "Once she’s gone you decide to head out of the diner as well.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaLoveLife():void {
            outputText("You want to hear more about her husband, is he that special to her?\n" +
                    "\n" +
                    "Jabala blushes softly, \"Halkano, mi amor…\" Her gaze sets off into the distance, completely ignoring you.\n" +
                    "\n" +
                    "\"We’ve been together for so long, and things have been rough, but I couldn’t ask for a better husband…\" Jabala’s voice trails off again.\n" +
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
                    "\"Zinny! It’s good to see you again.\" Jabala takes a long look at Zenji’s expression, \"Is something wrong..? It looks like you’ve been through a lot.\"\n" +
                    "\n" +
                    "\"You could say dat…\" Zenji responds. \"I’m just glad ta be here… It’s been a difficult couple of days… Can I speak ta dad..? It’s someting personal, you should stay and talk ta [name], keep dem company.\"\n" +
                    "\n" +
                    "Jabala nods her head, \"Sure thing, Dad is in the garden out back.\"\n" +
                    "\n" +
                    "\"Gracias mamá, te amo.\" Zenji replies before leaving you alone with Jabala.\n" +
                    "\n" +
                    "Jabala gestures for you to sit down on the couch beside her. Once Zenji is outside she speaks up. \"I saw what happened at the diner earlier… Everyone did… Rough time..?\"\n" +
                    "\n" +
                    "You tell Jabala that you’ve worked things out with Zenji and that he seems much better now.\n" +
                    "\n" +
                    "Jabala smiles gently, \"That’s so sweet, [name]. Glad you’re there for my son, I know you mean the world to him, not only did he tell me, but I can see it in his eyes.\"\n" +
                    "\n" +
                    "She brings her hands to the locket around her neck. \"Listen, I’ve been keeping this for Zenji to give to someone really important to him, but… I think you should be the one to propose to him. You’re so kind, patient, and caring. You’re the most perfect person I ever could’ve asked for to take care of my son. Please, [name], take this charm. Tell him that he means everything to you the same way you do to him. Make my son happy, I know you can do it.\"\n" +
                    "\n" +
                    "You hold out your hand and Jabala drops the charm into your awaiting palm.\n" +
                    "\n" +
                    "\"When the time is right… propose… I know you’re ready, [name]. Be bold, he will love you no matter what.\"\n" +
                    "\n" +
                    "After a moment of recollection over Zenji, you hear the door swing open and Zenji enters. \n" +
                    "\n" +
                    "\"Let’s go home, [name]. Thanks, mom... for everything.\"\n" +
                    "\n" +
                    "Jabala gives a soft smile, \"Anything for you, Zenji.\" She replies before giving you a wink as the two of you head out.");
            player.createKeyItem("Jabala's Charm", 0, 0, 0, 0);
            TrollVillage.ZenjiVillageStage = 5;
            doNext(camp.returnToCampUseOneHour);
        } else if (!TrollVillage.ZenjiFollowing) {
            outputText("You knock on the door to Jabala’s hut, after a moment you hear very loud footsteps approaching. A massive, burly troll opens the door.\n");
            if (!TrollVillage.HalkanoUnlocked) {
                outputText("He gives you an inquisitive look but quickly shifts to a polite smile. \"Greetings, you must be one of Jabala’s friends. I am Halkano.\" He stretches an arm out to shake your hand.\n" +
                        "\n" +
                        "You shake his hand and tell him your name.\n" +
                        "\n" +
                        "\"Nice ta meetcha, [name].\"\n");
            } else {
                outputText("He gives you a polite smile, \"[name]! Good ta see ya again, come in, come in!\"\n\n");
            }
            outputText("He gestures for you to enter the hut, \"What brings ya here?\"\n");
            addButton(0, "Halkano", JabalaHalkanoTalk, true);
            addButton(1, "Jabala", JabalaSelfTalk, true);
            addButton(2, "Nevermind", JabalaNVM);
        } else if (TrollVillage.ZenjiFollowing) {
            outputText("Zenji knocks on the door to his parent’s hut.\n" +
                    "\n" +
                    "You heard loud footsteps approaching before the door opens. Halkano stands at the doorway scratching his beard. His face lights up as he sees the two of you.\n" +
                    "\n" +
                    "\"Zenji! [name]! It’s good ta see ya, what brings ya here?\"\n" +
                    "\n" +
                    "\"Hey dad, we just wanted ta visit,\" Zenji replies\n" +
                    "\n" +
                    "\"Well, you’re always welcome here, come, come! I’ll get Mom. Why don’t de two of you wait on de couch until den?\"\n" +
                    "\n" +
                    "Zenji guides you to the couch as Halkano goes to the backyard to get his wife. As the two of you wait Zenji grabs hold of your hands, clutching them softly.\n" +
                    "\n" +
                    "\"You just have… the most holdable hands [name].\" Zenji states as he caresses your hand softly with his thumb.\n" +
                    "\n" +
                    "You smile at him, it’s nice to just hold hands sometimes.\n" +
                    "\n" +
                    "After a moment Halkano reenters with Jabala. Halkano plops down onto the sturdy chair beside the couch you’re on\n" +
                    "\n" +
                    "\"It’s nice to see you again, Zenji, [name],\" Jabala says with a friendly wave.\n" +
                    "\n" +
                    "You greet her back and Zenji does as well.\n" +
                    "\n" +
                    "\"What brings you here?\" Jabala asks as she sits on Halkano’s lap. His arms reflexively wrap around her.\n" +
                    "\n" +
                    "\"We came here ta visit and talk about a few tings,\" Zenji replies\n" +
                    "\n" +
                    "Halkano speaks up, \"We always love ya company, son. What d’ya wanna talk about?\"\n" +
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
                            "\"[name]! You can’t just…\" Zenji whispers\n" +
                            "\n" +
                            "Jabala snickers, \"Money problems? Oh no, the two of you must be so desperate and helpless out there!\"\n" +
                            "\n" +
                            "Halkano chuckles, but Jabala elbows his stomach.\n" +
                            "\n" +
                            "Jabala stands up from Halkano’s lap. She reaches into a pouch on her overalls, pulling out a handful of gems. Zenji holds out his hand as he receives the gems.\n" +
                            "\n" +
                            "\"Gracias mamá, te amo.\"\n" +
                            "\n" +
                            "Jabala smiles back at him. \"I hope that helps, I really should get back to my work. Stay safe out there.\"\n" +
                            "\n" +
                            "Jabala waves goodbye as she exits the room.\n" +
                            "\n" +
                            "Halkano chuckles to himself, shaking his head. \"Don’t spend it all in one place now…\" He says, standing up. He approaches the two of you before pulling you both in for a hug. \"Stay safe out dere.\"\n" +
                            "\n" +
                            "\"Gracias papa, te amo.\"\n" +
                            "\n" +
                            "Halkano then leaves the two of you alone in the room. Zenji passes the gems to you, \"Seems ta be about 45 gems… I can’t believe ya did dat.\"\n" +
                            "\n" +
                            "You tell him that times are tough, and a little help never hurts anyway.\n" +
                            "\n" +
                            "Zenji bites his lip, \"Yeah, okay den....\"\n" +
                            "\n" +
                            "You pocket the 45 gems before leaving with Zenji.\n");
                    player.gems += 45;
                    doNext(camp.returnToCampUseOneHour);
                } else {
                    outputText("You state that there have been financial problems with you and Zenji\n" +
                            "\n" +
                            "Zenji looks shocked at your statement, he quickly places his hand over your mouth, shushing you.\n" +
                            "\n" +
                            "\"No, no! We’re fine, we’re fine!\" Zenji states, \"In fact, we forgot someting back at home, we may be back later. Love you!\"\n" +
                            "\n" +
                            "\"Oh, uh, Love you!\" Jabala replies\n" +
                            "\n" +
                            "\"Love ya too, stay safe!\" Halkano chimes in\n" +
                            "\n" +
                            "Zenji lifts your insignificant weight before leaving the house with you in his arms. Once you’ve exited, he plants you firmly onto the ground.\n" +
                            "\n" +
                            "\"I can’t believe ya just did dat! My parents are not a money machine, please be respectful.\"\n" +
                            "\n" +
                            "You apologize.\n" +
                            "\n" +
                            "\"It’s okay, just… Please, I love you, [name]. Don’t abuse dem like dat.\"\n");
                    doNext(camp.returnToCampUseOneHour);
                }
            }

            function JabalaLoveAdvice():void {
                outputText("You ask for advice on what makes a relationship strong and healthy like theirs seems to be.\n" +
                        "\n" +
                        "Zenji raises an eyebrow at you.\n" +
                        "\n" +
                        "\"Trouble in paradise?\" Halkano chimes\n" +
                        "\n" +
                        "\"Er… noting like dat, tings have just been… Strange and we’d like to hear what you have ta say.\" Zenji replies\n" +
                        "\n" +
                        "Jabala gently nudges Halkano before turning her attention back to the two of you. \"Communication is always important. Be honest, be gentle. Don’t be afraid to say what the problem is. If the issue is… each other, then work it out rather than staying silent about it.\"\n" +
                        "\n" +
                        "Halkano speaks up, \"A relationship should work together, but de two pieces should not need each other to survive.\"\n" +
                        "\n" +
                        "\"Love is strange,\" Jabala states, \"There are hundreds of ways to express affection, not all of which are verbal.\"\n" +
                        "\n" +
                        "Zenji nods his head as he absorbs the information.\n" +
                        "\n" +
                        "\"The two of you just need to spend time together, get to know each other. [name]. I’m sure you know that Zenji is only 20 years old, right?\"\n");
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
                        "Jabala continues, \"Tell each other what interests you, perhaps you can have a lot more in common than you think.\"\n" +
                        "\n" +
                        "\"Well, I do really like cooking for [name] sometimes,\" Zenji replies\n" +
                        "\n" +
                        "\"Good, something simple and fun the two of you can do together some time. Never disregard the smaller things we can appreciate.\"\n" +
                        "\n" +
                        "\"De bigger gestures of course are still valid as always.\" Halkano chimes\n" +
                        "\n" +
                        "Jabala continues, \"It’s all about working together. Understand each other. Nothing is ever perfect, but the two of you can work together to make it the best it can be.\"\n" +
                        "\n" +
                        "Zenji speaks to you, \"So, [name]. Is dat any help?\"\n" +
                        "\n" +
                        "You assure him that it was good to hear and sound advice.\n" +
                        "\n" +
                        "\"Dat’s good ta hear, now let’s go home. Bye mom, bye dad. Love you.\"\n" +
                        "\n" +
                        "\"Love you too\" They reply simultaneously.\n" +
                        "\n" +
                        "You wave goodbye as Zenji holds your hand, escorting you out.\n" +
                        "\n" +
                        "Once you’re outside Zenji suddenly stops, he pulls you close to him. \"Is everyting okay, [name]? You know I love you, I never stopped loving you.\"\n" +
                        "\n" +
                        "You assure him that everything is fine\n" +
                        "\n" +
                        "Zenji gently caresses your cheek with his fuzzy hand. \"You can always talk to me. I have big ears like dese for listening, ya know.\"\n" +
                        "\n" +
                        "Before you can respond, he lifts you to his face, planting his lips firmly on yours. You sink into his embrace as he kisses you mercilessly, his long tongue pushes into your mouth, breaking your resistance. You relax into his comfort, his tender kiss being the only thing you can focus on as if he were the only thing that existed in the world. You can feel his hand behind your head, keeping you close to him as the other roams your back, gently caressing your form.\n" +
                        "\n" +
                        "After a moment Zenji breaks the link, strands of saliva drip from his mouth from the raw passion he’s instilled into you.\n" +
                        "\n" +
                        "\"Better..?\"\n" +
                        "\n" +
                        "You nod, definitely better now.\n" +
                        "\n" +
                        "\"Good, let's go home now.\"\n" +
                        "\n" +
                        "Zenji escorts you back home safely.\n");
                doNext(camp.returnToCampUseOneHour);
            }

            function JabalaGossip():void {
                clearOutput();
                outputText("You say that you just wanted to spend some time with them and share stories.\n" +
                        "\n" +
                        "\"Stories..?\" Jabala responds.\n" +
                        "\n" +
                        "Halkano speaks up, \"I tink I have a few tings ta talk about, what d’ya say, honey?\"\n" +
                        "\n" +
                        "\"Sharing stories is fun, gives me time to reflect on what’s been going on lately.\" She responds.");
                switch (rand(4)) {
                    case 0:
                        outputText("Halkano speaks first, \"Do you remember dat one time at de diner, Jabala? When you saw Yenza drinking her juice.\"\n" +
                                "\n" +
                                "Jabala gasps, \"No! How dare you! She had it coming! I grew the figs myself, I should be able to do what I want with it!\"\n" +
                                "\n" +
                                "Zenji chuckles softly, \"Oh mother, what did you do?\"\n" +
                                "\n" +
                                "\"She threw a glass of fig juice in Yenza’s face, completely ruining her dress.\"\n" +
                                "\n" +
                                "You snicker softly and Zenji giggles to himself.\n" +
                                "\n" +
                                "\"I told her since she wanted to be a whore that she should be prepared for a facial at any time.\"\n" +
                                "\n" +
                                "\"Well, since Mom couldn’t control herself, she’s no longer welcome at the diner until next week,\" Halkano replies.\n" +
                                "\n" +
                                "Jabala rolls her eyes playfully.\n");
                        break;
                    case 1:
                        outputText("Halkano speaks up \"What about dat one time when you went ta de Elder’s hut? What were you looking for..?\"\n" +
                                "\n" +
                                "\"When I was looking for straw to weave a new hat?\" Jabala replies, \"Yeah, I knew she some leftover, Rin was just being rude.\"\n" +
                                "\n" +
                                "\"Jabala…\" Halkano says softly, \"Like half of the village needs straw, you’re not going to get any when you go in the evening. I couldn’t get any dat day because I was busy\"\n" +
                                "\n" +
                                "\"Yeah, well… She could’ve been respectful about it.\"\n" +
                                "\n" +
                                "Halkano sighs, \"I tink perhaps next time you shouldn’t try to bribe someone ta give you someting dey don’t have.\"\n");
                        break;
                    case 2:
                        outputText("\"Oh!\" Jabala exclaims, \"What about that time we were in the diner together. Remember? I was eating the Hunter’s stew and you-\"\n" +
                                "\n" +
                                "Halkano cuts her off with his palm, \"I tink dat’s enough, dey don’t need to hear what happened.\"\n" +
                                "\n" +
                                "Zenji raises an eyebrow at his father.\n" +
                                "\n" +
                                "\n" +
                                "Jabala weasels her way out of his grasp, \"Dad was very tense, to put it nicely… It was a funny sight.\"\n" +
                                "\n" +
                                "Halkano sighs, \"Let’s just say dere was an accident in my pants…\"\n");
                        break;
                    default:
                        outputText("Halkano thinks to himself for a moment, \"De elder has been very quiet lately, hasn’t she?\"\n" +
                                "\n" +
                                "Jabala nods, \"Yeah, whenever I try to talk to her about getting more seeds she never seems to have anything to offer.\"\n" +
                                "\n" +
                                "Halkano shakes his head, \"Yubi has been very quiet lately, I worry for her. I dunno what’s going on but I hope everyting is okay.\"\n" +
                                "\n" +
                                "\"I can only hope nothing bad happens to our village,\" Jabala responds\n");
                        break;
                }
                outputText("\"Well, enough about that. What about you? Zenji? [name]? Anything going on back at your place?\" Jabala asks\n");
                switch (rand(5)) {
                    case 0:
                        outputText("\"Actually,\" Zenji responds before you have a chance to speak up, \"Whenever we sleep together, I noticed someting adorable. Whenever I can’t sleep, I will caress your face and you never fail to lean into my palm.\"\n" +
                                "\n" +
                                "You smile softly at him, it’s a strange sense of comfort knowing that he watches you sleep sometimes.\n");
                        break;
                    case 1:
                        outputText("\"Dere was dis goblin one time, not too long ago actually. She kept calling me a stud. It was a little weird coming from a tiny lady. I just ignored her, but she was very pushy and wouldn’t leave me alone. It’s like all some people can tink about is sex all de time. I’m glad you’re not like dat, right, [name]?\"\n");
                        break;
                    case 2:
                        outputText("\"I remember de swamp dat’s not too far from de bog. Dere was dis strange cave wit an egg in it. I dunno who would leave an egg just lying alone in a cave, but it seemed lonely. I didn’t want to incur de wrath of a mother, so I just left it alone. Didn’t bother to get dat close to it.\"\n");
                        break;
                    case 3:
                        outputText("Zenji rolls his shoulders, \"My muscles have been really sore lately… I could use a break and just relax for a while.\"\n" +
                                "\n" +
                                "Halkano chuckles, \"Hey Zenji, come here, why don’t we check out if you’re bigger dan your old man, hmm?\"\n" +
                                "\n" +
                                "Zenji smirks, \"Alright, we’ll see about dat.\"\n" +
                                "\n" +
                                "Jabala hops off of Halkano’s lap before he stands up. She sits back on the chair. Zenji stands up, the weight of the couch shifts as he lifts himself off.\n" +
                                "\n" +
                                "The two of them stand back to back, Halkano being slightly taller than Zenji. They both pose with double biceps flexing. Zenji gives you a coy wink as you watch.\n" +
                                "\n" +
                                "\"Alright, who’s bigger?\" Zenji asks.\n" +
                                "\n" +
                                "You stand up and get closer, Jabala follows as well. It’s very close and difficult to judge by eyeballing it. Zenji, while leaner, is very muscular and perfectly built. Halkano on the other hand is far bulkier and beefy, with a little less muscle tone.\n" +
                                "\n" +
                                "After close inspection from all angles, it’s apparent that Halkano’s arms are bigger, but only slightly.\n" +
                                "\n" +
                                "\"Looks like my husband is the winner!\" Jabala teases.\n" +
                                "\n" +
                                "\"Haha! Can’t beat dad just yet, son!\"\n" +
                                "\n" +
                                "Zenji laughs, \"One day, papa… One day…\"\n" +
                                "\n" +
                                "The four of you return to your seats once the verdict is clear.\n");
                        break;
                    default:
                        outputText("\"Eh… Noting really interesting going on lately.\" He wraps an arm around your shoulder, pulling you closer to him, \"My love for you is as strong as always, [name].\")\n" +
                                "\n" +
                                "The four of you spent the rest of the hour in idle chit chat, talking about irrelevant topics going on with you and Zenji as well as the village.\n" +
                                "\n" +
                                "After some time Zenji speaks up, \"It’s getting a little late, why don’t we go home now, [name]?\"\n" +
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
                if (player.lib < 80) outputText("Zenji looks at you, disappointed. \"No, let’s… not do dat…\"\n");
                else outputText("Zenji takes a deep, long sniff. \"Sorry, not a good time, it’s… weird…\"\n");
                outputText("You decide not to press the issue further and think about what else you wanted to talk about.\n");
                doNext(SceneLib.trollVillage.EnterTheVillage);
            }

            function JabalaSayonara():void {
                clearOutput();
                outputText("You realize that you have nothing left to talk about right now. You apologize to Zenji and his parents for wasting their time.\n" +
                        "\n" +
                        "\"Lost your train of thought? It’s okay [name], happens ta all of us.\"\n" +
                        "\n" +
                        "Jabala doesn’t even register the comment as she’s already staring off into the distance.\n" +
                        "\n" +
                        "\"Come back any time, it’s always nice to see ya,\" Halkano replies, nudging Jabala softly.\n" +
                        "\n" +
                        "\"Oh!\" She responds, \"Farewell!\"\n" +
                        "\n" +
                        "Zenji holds your hand as he escorts you out of the house. You consider where you want to go within the village now.\n");
                doNext(SceneLib.trollVillage.EnterTheVillage);
            }
        }

        function JabalaNVM():void {
            outputText("You realize that you don’t want to be here at this time and apologize for wasting his time.\n" +
                    "\n" +
                    "\"It’s alright, tings happen, I understand. Stay safe\"\n" +
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
                    "\"Ah? Is dat so?\" Halkano responds as he rests on the couch.\n" +
                    "\n" +
                    "You take the seat on the couch next to him, it’s a little cramped with just how massive he is, but there’s enough room for you.\n" +
                    "\n" +
                    "\"What is dere ya wanted ta talk about?\"\n");
        }
        menu();
        addButton(0, "Appearance", SceneLib.trollVillage.halkano.HalkanoAppearance);
        addButton(1, "Gossip", JabalaHalkanoGossip);
        addButton(2, "Sex", SceneLib.trollVillage.halkano.JHalkanoSexScenes);


        function JabalaHalkanoGossip():void {
            outputText("You ask Halkano if he has anything interesting to talk about.\n" +
                    "\n" +
                    "\"Ah, ya want ta hear some stories, do ya? I think I can recall some weird stuff going on lately.\"\n");
            switch (rand(4)) {
                case 0:
                    outputText("\"Yenza asked me ta help build her a table for her tailing store… Honestly, de nerve of some people! I told her ta get lost, I’m neva doing anyting for her, ever and left de diner. Honestly, I’m sure she was looking fa more dan just my work, I tink she wanted de entire package.\"");
                    break;
                case 1:
                    outputText("\"Kal’ji gave me dis weird look de other day... It sent shivers down ma spine… I trust him, but I will neva forget dat look he gave me…\"\n" +
                            "\n" +
                            "Halkano shudders.\n" +
                            "\n" +
                            "\"Creepy…\"\n");
                    break;
                case 2:
                    outputText("\"Don’t tell her I told you dis, but Jabala is getting real frisky. I tink she’s getting into heat or someting! She keeps touching me and I dunno how ta respond because we’re in public! She told me it’s because I’m so big dat her hands constantly touch me ‘on accident’. If I knew getting dis big fa her would make her act like dis den… well… I dunno, maybe I kinda like it I guess.\"");
                    break;
                default:
                    outputText("\"I… actually don’t have anything interesting ta talk about right now…\"");
                    break;
            }
            outputText("A moment of silence passes.\n" +
                    "\n" +
                    "\"Well, it was nice talking ta ya, but I should check on Jabala and see if she’s alright. It was nice talking ta ya, [name].\"\n" +
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
                    "\"Alright, she’s in de back yard taking care of her garden. I’ll lead de way.\"\n" +
                    "\n" +
                    "Halkano shows you to the back yard and Jabala is currently weeding the garden, dressed in her iconic straw hat.\n" +
                    "\n" +
                    "Jabala gives an inattentive wave to Halkano as she continues digging her hands into the soil.\n" +
                    "\n" +
                    "\"Jabala…\"\n" +
                    "\n" +
                    "\"A la izquierda por favor, gordo.\" She replies, shaking her hand toward him dismissively.\n" +
                    "\n" +
                    "Halkano chuckles softly, \"[name] is here ta talk ta ya.\"\n" +
                    "\n" +
                    "Jabala finally looks up, \"¡Ay! Lo siento!\" She shakes her head, \"I always get so sucked into what I do, I forget there’s other stuff going on.\"\n" +
                    "\n" +
                    "\"Good luck,\" Halkano mumbles to you before he re-enters his home.\n" +
                    "\n" +
                    "Jabala now gives you her attention, \"Is there something you wanted..?\"\n");
        }
        menu();
        addButton(0, "Appearance", JabalaAppearance);
        addButton(1, "Gossip", JabalaGossip);
        addButton(2, "Sex", JabalaSex);

        function JabalaGossip():void {
            clearOutput();
            outputText("You ask Jabala if she has anything interesting to talk about.\n" +
                    "\n" +
                    "\"¡Qué roche! I should’ve brought some tea!\" Jabala sighs, \"Ah, well, we can still talk without any. Things have been a little weird lately.\"\n");
            switch (rand(5)) {
                case 0:
                    outputText("\"It happened not too long ago. Yenza was flashing my husband the crazy eye. We had a staring contest in the middle of the diner and Halkano had to drag me out of the place. I’ll never forgive that bitch for raping my son.\"\n" +
                            "\n" +
                            "Jabala sighs. \"It’s the worst feeling when you can no longer protect someone you care about from the trauma. Knowing that my son has been raped… What a whore she is.\"\n");
                    break;
                case 1:
                    outputText("\"I remember when Halkano helped me make this garden such a long time ago… Seeing his strong arms. He’s so much stronger now. Have I mentioned Halkano works out..? He does and he’s definitely gotten stronger.\"\n" +
                            "\n" +
                            "Jabala sighs softly, \"Sometimes all I want is for him to hold me, for him to be there with me and tell me everything will be fine. He’s so calm, gentle, and patient with me and my rambles. I could just go on and on about how great he is… Because he deserves praise. I couldn’t have asked for a better husband.\"\n");
                    break;
                case 2:
                    outputText("\"I was talking to Yubi earlier. We’re running low on seeds and our crops aren’t germinating. She said that the usual trade has been halted and we don’t have any good fertilizer right now. I’ve been growing concerned, but I have trust in her ability to maintain a steady village.\"\n" +
                            "\n" +
                            "Jabala sighs, \"Sometimes I feel like she just wants to help but is unsure how to do so.\"\n");
                    break;
                case 3:
                    outputText("\"I was talking to Kuru at the diner earlier. She works so hard and tirelessly, I honestly think she goes unnoticed for everything she does as a waitress. So I baked her a little cake. Nothing too big, but something special for someone who deserves it. The look on her face is something I’ll never forget.\"\n");
                    break;
                default:
                    outputText("Jabala looks down at her garden intently, \"Sometimes when I’m getting stressed out, I like to have time to myself, just me and my plants. It’s nice to have company I guess, especially from my husband. Although, it’s like my garden understands me, the way they rustle in the wind at my approach. Springing to life under the rain of my watering can. They’re almost like my children…\" \n");
                    if (TrollVillage.ZenjiVillageStage >= 1) {
                        outputText("She sighs softly in relief. \"Thank you… Seeing Zenji again means a lot to me.\"\n");
                    } else {
                        outputText("Jabala sheds a tear.\n");
                    }
                    break;
            }
            outputText("Jabala sets her watering can on the ground. \"It was nice talking to you, but I would like to have some time to myself right now. If you don’t mind....\"\n" +
                    "\n" +
                    "You understand and give her room for herself as you leave their house.\n");
        }

    }

    private function JabalaSex():void {
        clearOutput();
        outputText("You ask Jabala if she’s willing to get a little more intimate with you.\n" +
                "\n" +
                "She sets her watering can down beside her. \"You… You want to do what exactly?\"\n" +
                "\n" +
                "You want to see the rest of her body and have the chance to share an intimate moment with her.\n" +
                "\n" +
                "\"Sorry, I… I really only have a thing for my husband, I hope you don’t mind...  Well… If you really want the chance, I guess I will, but only if my husband isn’t against the idea.\" Jabala mutters softly to herself, \"I can’t believe I’m doing this…\"\n" +
                "\n" +
                "Jabala opens the door and gestures for you to follow. You do so and she instructs you to wait on the couch. She enters her bedroom as you wait for her.\n" +
                "\n" +
                "After a moment of muffled chat Jabala exits the room sheepishly. She nods her head, \"Come in… We’re ready.\"\n" +
                "\n" +
                "The two of you enter together and Halkano is resting on the bed, he places the book he was reading on the nightstand next to the bed. You can hear his tail gently slap against the bed in anticipation.\n" +
                "\n" +
                "\"I heard ya wanted ta get frisky. Well, here we are, dis is whatcha want, dis is what we got.\"\n" +
                "\n" +
                "Jabala climbs onto the bed next to her husband, \"I hope you don’t mind, I just couldn’t do anything without my husband.\"\n" +
                "\n" +
                "You consider what you want to do now with the two of them.\n");
        menu();
        if (player.hasCock() || player.hasVagina()) addButton(0, "SpitRoast", JabalaSpitroasted);
        else addButtonDisabled(0, "SpitRoast", "You don't have a \"chicken\" or a \"cat\" for Jabala to \"eat\"!");
        addButton(1, "Double Worship", JabalaDWorship);
        addButton(2, "Nevermind", JabalaBlueBalls);

        function JabalaBlueBalls():void {
            clearOutput();
            outputText("You apologize and say that you aren’t too keen on the idea anymore.\n" +
                    "\n" +
                    "Jabala holds her hands over her face, embarrassed. Halkano quickly pulls her in for a hug to help her relax.\n" +
                    "\n" +
                    "He turns to you, \"You should leave now.\"\n" +
                    "\n" +
                    "You do so quickly before causing any more conflict.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaSpitroasted():void {
            outputText("Since there’s three of you, you tell them that You think that the two of you could get to work on Jabala.\n" +
                    "\n" +
                    "Halkano raises an eyebrow, \"Sandwich Jabala between us..?\"\n" +
                    "\n" +
                    "You nod, it’s a spit roast.\n" +
                    "\n" +
                    "Jabala looks up toward Halkano with faint hope in her eyes.\n" +
                    "\n" +
                    "\"She’s into it, but I’ll be de one penetrating her. You can get blown.\"\n" +
                    "\n" +
                    "You figure that’s to be expected, but receiving oral could be worse.\n");
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
            outputText("You ask Jabala if she’s willing to help you \"assist\" Halkano with his needs.\n" +
                    "\n" +
                    "Jabala turns to Halkano and he gives her a devious grin, \"Well, two on one, how about dat..?\"\n" +
                    "\n" +
                    "Jabala gives a sheepish grin as she begins to slowly unbutton her blouse. [(pc not nudist) You take off your [armor] as well.]\n" +
                    "\n" +
                    "Jabala climbs onto the bed with her awaiting husband. Halkano gestures for you to approach, \"Come on den, she’s not gonna do all de work. Help me get out of dese pants.\"\n" +
                    "\n" +
                    "You grab one pant leg and Jabala grabs the other, the two of you pull slowly until Halkano has completely slid out of his pants. His length hangs flaccid before the two of you.\n" +
                    "\n" +
                    "Halkano leers at the two of you, \"It’s not gonna raise itself, why don’t da two of you give my little boy some help..?\"\n" +
                    "\n" +
                    "The two of you approach his length. Jabala is at his left flank, gently strokes his leg as she cups his balls with her svelte fingers. As you approach, you run your hand across his beefy legs, they’re dense and muscular to support such a large troll. The two of you press your body against him, Jabala gets close and licks the side of his shaft. You get closer to Halkano as well, pressing your face against his girth as you lick his shaft. The air is musky from Halkano’s scent as you lick him up and down with Jabala. Spurts of pre leak from his tip, cascading down his girth as the two of you take turns licking up his salty favor.\n" +
                    "\n" +
                    "Jabala eagerly presses her lips at the tip of Halkano’s girth, pushing you to the side. Halkano reaches his tail underneath her chin, lifting her face to meet his gaze, \"Now, now, honey… Ya gotta share, let [name] have a turn too.\"\n" +
                    "\n" +
                    "Jabala blushes softly before moving back slightly, giving you a chance to get closer to his length. With your space returned you rest your head against the top of his muscular thigh, wrapping your tongue around his length to the best of your ability as you continue servicing him.\n" +
                    "\n" +
                    "You can feel Halkano’s length twitch slightly underneath your tongue, you can feel your arousal growing beneath him. [(pc has penis) You reach your hand down and grab at your length, gently stroking yourself, getting off as well.) [(pc has vagina, lacks penis) You reach your hand down and probe at your clit as you begin to finger yourself.]\n" +
                    "\n" +
                    "You can hear Jabala moan softly in pleasure as she blows Halkano with you, you can tell she had the same idea.\n" +
                    "\n" +
                    "Halkano lets loose a very deep, low growl. \"Keep it up, I’m getting closer…\"\n" +
                    "\n" +
                    "Jabala redoubles her efforts in licking up and down his length as you help her. You cup his hefty balls, playing around with his meat. His balls are fuzzy and heavy, ready to deposit his load to the two of you.\n" +
                    "\n" +
                    "Halkano moans from your ministrations, \"Mmmm… Keep it up… Touch me... Play wit my balls…\"\n" +
                    "\n" +
                    "Jabala sighs softly, her hand over her clit, dipping past her lips as she masturbates herself as well. Her hand wraps around his length, pulling herself closer to him as she glides her tongue up and down his length.\n" +
                    "\n" +
                    "The two of you almost butt heads, both of you trying to get him off. Halkano begins thrusting slightly, nearing his climax.\n" +
                    "\n" +
                    "Halkano growls louder, \"So close, almost dere! Don’t stop!\" His thrusts become more aggressive, his erection pulses between the two of you, ready to burst.\n" +
                    "\n" +
                    "You continue getting yourself off, so close as well. You can hear Jabala moan quietly as she cums. Halkano roars with vigor as he reaches the height of his orgasm. Thick ropes of cum shoot out before you and all over the bed. You find yourself finally reaching your climax as well. (Unleashing your load onto the bed beneath you.) (Vaginal fluids drip past your lips onto the bed beneath you.)\n" +
                    "\n" +
                    "Halkano sighs as his body begins to relax and his orgasm dies down. The length of his girth is still covered in cum as the two of you help clean him off.\n" +
                    "\n" +
                    "Once you’ve cleaned him off Halkano gives you a knowing smirk, \"Ya did good, de two of you make a good team.\" He says with a small chuckle.\n" +
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
        JabalaSelfTalk();
    }
}
}
