package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.TrollVillage;
public class Jabala extends TrollVillageAbstractContent{
    public function Jabala() {
    }
    public function MeetTheParents():void{
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

        if (flags[kFLAGS.ZENJI_KIDS] != 0){
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
        TrollVillage.ZenjiVillageStage == 1;
        doNext(camp.returnToCampUseOneHour);
    }

    public function JabalaDining():void{
        clearOutput();
        menu();
        if (TrollVillage.ZenjiBerated){
            outputText("You decide to approach Jabala, but before you get too close she notices you and stands up.\n" +
                    "\n" +
                    "“You think this is a game? Toying with my sweet little boy? Stay away from my family!” She cries.\n");
            doNext(SceneLib.trollVillage.diningHalls.GrabABite2Eat);
        }
        else if (!TrollVillage.ZenjiFollowing && !TrollVillage.JabalaUnlocked){
            outputText("Your gaze roams around until you decide to approach the small troll with long braided hair sitting by herself. She seems very tomboyish in appearance, clad in a simple farmers outfit with a straw hat adorned around her crown. Her svelte body is considerably smaller than almost any troll you’ve seen so far, but she’s still at least 6 feet tall. As you get closer you notice that she’s drinking the fig juice, she sets the cup down as her attention turns toward you.\n" +
                    "\n" +
                    "“Oh? Have I seen you around here before?. You don’t look like the others. What’s your name?”\n" +
                    "\n" +
                    "You tell her your name\n" +
                    "\n" +
                    "“My name is Jabala, it’s nice to meet you, [name]. I’d love to stay and chat, but… I must get going…” She spends a moment thinking to herself. “Why don’t we meet up later? You can meet me at my house if I’m there, it’s on the eastern side of the village, the porch has plenty of colorful flowers, you can’t miss it!”\n" +
                    "\n" +
                    "She dismisses herself and waves goodbye.\n" +
                    "\n" +
                    "Once she’s gone you figure that you can go outside and perhaps check on the other activities around the village\n");
            outputText("Jabala’s Hut has been added to the troll village!\n");
            doNext(camp.returnToCampUseOneHour);
        }
        else if (!TrollVillage.ZenjiFollowing){
            outputText("Your gaze roams around until you decide to approach Jabala. Deciding that you want to talk to her again, you decide to approach her.\n" +
                    "\n" +
                    "She is currently staring off into the distance, unaware of her surroundings as her half-full cup of juice rests beside her.\n" +
                    "\n" +
                    "Once you approach, her eyes zone in before shifting to meet your gaze. “Oh, [name]! I didn’t notice you there. It’s good to see you, how's everything going?”\n" +
                    "\n" +
                    "You assure her that things could be worse.\n" +
                    "\n" +
                    "“Oh, well, I hope things will turn out for the best around you. Come, sit, was there something you wanted to talk about?”\n");
            addButton(0,"Herself", JabalaSelfIntro);
            addButton(1,"The People", JabalaGossip);
        }
        else{
            outputText("Your gaze shifts around before spotting Jabala sitting by herself in the diner. You ask Zenji if he wants to meet up with his mother.\n" +
                    "\n" +
                    "Zenji grasps onto your hand. “Sure, dat sounds nice, [name]. De three of us can have a chat together.” \n" +
                    "\n" +
                    "He guides you to his mother, she’s looking off into the distance, not noticing your approach.\n" +
                    "\n" +
                    "“¡Hola mamá!” Zenji exclaims.\n" +
                    "\n" +
                    "“Zenji!” Jabala responds, shaken into reality as she turns to face the two of you. “[name]! It’s good to see the two of you! Come! Come! I hope everything’s been well.”\n" +
                    "\n" +
                    "Zenji nods, “It’s been just great, I love [name] wit all my heart, and I’m sure dey feel de same.”\n" +
                    "\n" +
                    "Jabala smiles, “That’s wonderful, glad you two are happy together. You two remind me so much about myself when I was your age. I was dumbstruck, couldn’t even separate myself from Halkano, spent every night together...” Her gaze sets off into the distance again.\n" +
                    "\n" +
                    "Zenji blushes, “¡Mamá!”\n" +
                    "\n" +
                    "“Oh.. Did I get carried away again..? Oh, what time is it..? I had best get going now. It was a pleasure to meet up with the two of you again!”\n" +
                    "\n" +
                    "Jabala gives the two of you a hug before leaving.\n" +
                    "\n" +
                    "“Come, [name]. Let’s go, it was nice ta catch up wit her again, even if she gets lost in thought like always.”\n" +
                    "\n" +
                    "Zenji holds your hand as he leads you out of the diner.\n");
            doNext(SceneLib.trollVillage.EnterTheVillage);
        }

        function JabalaSelfIntro():void{
            outputText("You tell Jabala that you want to get to know her better, she seems like an interesting person after all. Who is she, what does she do?\n" +
                    "\n" +
                    "“About myself... Hmm…” Jabala pauses for a moment, looking off into the distance, “Well, I am a farmer by profession and a gardener in my free time. I mostly grow greens, and figs… lots of figs… I guess trolls really like their figs, don’t they?”\n" +
                    "\n" +
                    "Jabala snickers to herself, “Yeah, all the farming is what led me to the man of my dreams… My husband, Halakno, Such a big... Strong carpenter…” She says, blushing slightly, “It just kind of happened. I lost all control when I was near him and he didn’t resist my advance.”\n" +
                    "\n" +
                    "“It wasn’t until long until we got married and had our first child together, we loved him with all our hearts, but…");
            if (TrollVillage.ZenjiVillageStage > 0){
                outputText(" Thanks to you I know he’s safe.");
            }
            outputText("”\n\n" +
                    "“Nothing changes here, it’s simple, sweet and I like what I do. Gardening in my free time always lifts my spirits, especially when Halkano is there.”\n" +
                    "\n" +
                    "Jabala looks off into the distance again. “I really should get going, [name]. It was nice talking to you, sorry I didn’t give you much of a chance to speak, I kind of got lost in thought. Until we meet again!”\n" +
                    "\n" +
                    "Jabala stands up and leaves. Seeing that there’s not much left to do now, you decide to exit the dining hall.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaGossip():void{
            outputText("You ask Jabala about the people of the village, she seems fairly sociable for a farmer.\n" +
                    "\n" +
                    "“The people here are pleasant to talk to… for the most part. Gossip is hard to come by because most people are into their own things, but I tell you, I’ve been hearing a lot of whispers going around about this gay guy… I don’t personally know any gay guys around here, but I hear this guy is almost like a predator for other men. Just what I heard though. Oh, the seamstress, oh no, the seamstress. Don’t talk to her, she has a nose for trouble and should keep her hands to herself. If she ever talks to you, don’t talk to her. Almost reminds me of the elder. All she does is tuck herself into her own thing, disregarding the pleas of others and is generally unaware of the world around her. She’s not bad at keeping rules governed and keeping the rest of the elders in balance, but she’s also hard to even listen to.”\n" +
                    "\n" +
                    "Jabala’s gaze sets off into the distance for a moment before her eyes roll back to you. “Where was I..? Oh, is there anything else you had in mind?”\n");

            addButton(0,"Gay troll", JabalaHomoSexTalks);
            addButton(1, "Seamstress", JabalaSeamstress);
            addButton(2,"Elder", JabalaElder);
            addButton(3,"Love Life?",JabalaLoveLife);
            addButton(4,"Leave",JabalaLeave);
        }

        function JabalaLeave():void{
            outputText("You tell Jabala that you enjoyed talking to her, but there’s nothing else you wanted to talk about.\n" +
                    "\n" +
                    "“Oh, carry on then. I’ll be here with my thoughts.”\n" +
                    "\n" +
                    "You pack up your stuff and leave the dining hall.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaHomoSexTalks():void{
            outputText("You want to hear more about this gay troll because apparently homosexuality is very uncommon among trolls.\n" +
                    "\n" +
                    "“Oh, it is.” She responds. “Rumor has it’s the elder Kal'ji. ¡Qué cabro! He totally has the hots for this one farmer. Or so I’ve heard…”\n" +
                    "\n" +
                    "She looks around, almost as if she were worried about eavesdroppers. “From what I’ve heard, he’s a terrible lover in bed! But you didn’t get this from me.”\n" +
                    "\n" +
                    "Jabala leans back, adjusting her straw hat. “Well, I best get going for now, it was nice talking to you [name].” She leaves after dismissing herself.\n" +
                    "\n" +
                    "You decide to pack up as well and head out the diner.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaSeamstress():void{
            outputText("You want to hear more about the seamstress, did she actively cause trouble?\n" +
                    "\n" +
                    "Jabala sighs, “Puta de chongo. Yenza has been on the hunt for many men. She attacked my son and if I didn’t stop them, then I don’t know what could’ve happened. I don’t want to talk about that girl anymore. I should get going anyway”\n" +
                    "\n" +
                    "She adjusts her straw hat before dismissing herself.\n" +
                    "\n" +
                    "You decide to pack up as well and head out the diner\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaElder():void{
            outputText("You want to hear more about the elder, what makes her so difficult?\n" +
                    "\n" +
                    "“Yubi? She’s mostly in her own world, thinking about what’s best and doing what she would like to do. Sometimes she tries and looks out for the people, but it’s difficult to know if she’s doing it for everyone or herself.”\n" +
                    "\n" +
                    "Jabala looks into the distance but still talks to you. “I feel like she wants what’s best for the people. I feel it in my heart, she just wants to do good, but she’s lost her way and is unsure what to do now. She’s been the chief elder for… how long..? I know she means well, but I feel like she’s losing her touch with the people.”\n" +
                    "\n" +
                    "Jabala’s gaze shifts back to you. “She’s not a bad person, she never was. Enough about her though, I best get going now. Farewell, [name].” Jabala packs up her things before leaving.\n" +
                    "\n" +
                    "Once she’s gone you decide to head out of the diner as well.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function JabalaLoveLife():void{
            outputText("You want to hear more about her husband, is he that special to her?\n" +
                    "\n" +
                    "Jabala blushes softly, “Halkano, mi amor…” Her gaze sets off into the distance, completely ignoring you.\n" +
                    "\n" +
                    "“We’ve been together for so long, and things have been rough, but I couldn’t ask for a better husband…” Jabala’s voice trails off again.\n" +
                    "\n" +
                    "After about a moment of silence, it looks like she’s busy staring at the wall in front of her.\n" +
                    "\n" +
                    "You decide to pack up and leave for the time being, she seems very content on sitting in silence for now. You leave the diner.\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }

    public function JabalaHome():void{
        clearOutput();
        menu();
        if (!TrollVillage.ZenjiFollowing){
            outputText("You knock on the door to Jabala’s hut, after a moment you hear very loud footsteps approaching. A massive, burly troll opens the door.\n");
            if (!TrollVillage.HalkanoUnlocked){
                outputText("He gives you an inquisitive look but quickly shifts to a polite smile. “Greetings, you must be one of Jabala’s friends. I am Halkano.” He stretches an arm out to shake your hand.\n" +
                        "\n" +
                        "You shake his hand and tell him your name.\n" +
                        "\n" +
                        "“Nice ta meetcha, [name].”\n");
            }
            else{
                outputText("He gives you a polite smile, “[name]! Good ta see ya again, come in, come in!”\n\n");
            }
            outputText("He gestures for you to enter the hut, “What brings ya here?”\n");
            addButton(0,"Halkano", JabalaHalkanoTalk);
            addButton(1,"Jabala", JabalaSelfTalk);
            addButton(2,"Nevermind", JabalaNVM);
        }

        function JabalaNVM():void{
            outputText("You realize that you don’t want to be here at this time and apologize for wasting his time.\n" +
                    "\n" +
                    "“It’s alright, tings happen, I understand. Stay safe”\n" +
                    "\n" +
                    "You dismiss yourself and he closes the door behind you.\n");
            doNext(SceneLib.trollVillage.EnterTheVillage);
        }
    }

    private function JabalaHalkanoTalk():void{
        clearOutput();
        menu();
    }

    private function JabalaSelfTalk():void{
        clearOutput();
        menu();
    }
}
}
