package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.TrollVillage;
public class Kalji extends TrollVillageAbstractContent{
    public function Kalji() {
    }

    public function TalkWithKalji():void {
        clearOutput();
        if (TrollVillage.ZenjiFollowing) {
            outputText("Zenji speaks up, \"I’ll be back, [name]. I gotta use da restroom.\"");
        }
        if (TrollVillage.KaljiUnlocked == 0) {
            outputText("Your gaze roams around and you see a somewhat short, slender troll wearing a cape that drapes down to his ankles. You decide to head over to him to get to know him. He quickly notices you approaching him and holds out a hand toward you.\n" +
                    "\n" +
                    "“Halt.” He commands, “Please keep your distance, I am not used to strangers approaching me. If you could kindly introduce yourself before you approach, I would be thankful.”\n" +
                    "\n" +
                    "You introduce yourself, while also stating that you were interested in getting to know the other trolls while you were here.\n" +
                    "\n" +
                    "“Ah, then my name is Kal'ji, the pleasure is mine, [name]. Come, sit next to me. I am but one of the members on the Council of Elders. I govern the place, but mostly take care of the economy. Tell me, what brings you here to the troll village? I don’t think I’ve ever seen someone by the likes of you around.” He replies.\n");
            if (player.femininity < 35) {
                outputText("Kal'ji leans slightly closer, “It is truly a pleasure to meet someone as… unique… as you...”");
            }
            outputText("The two of you spend a moment getting to know each other. He is a rather pleasant person to talk to. Carrying a calm and relaxed demeanor, but you can’t help but feel like he is paying more attention to his surroundings than he is to you. Is he paranoid, or perhaps hiding something?\n" +
                    "\n" +
                    "Soon enough Kal'ji excuses himself. “I’m sorry, but as an Elder, I don’t have as much free time as I would like to talk to friends like you. If you would excuse me there are things I must attend to now, farewell, [name].”\n" +
                    "\n" +
                    "Kal'ji leaves and eventually you leave the Dining hall as well.\n");
            TrollVillage.KaljiUnlocked = 1;
            SceneLib.trollVillage.kuru.KuruExitDialogue();
        } else {
            menu();
            outputText("Since you’re alone again, you approach Kal'ji, he is sitting by himself while eating a salad.\n" +
                    "\n" +
                    "Kal'ji quickly notices you, “Ah, [name]! Welcome! It’s great to see you here again!”\n" +
                    "\n" +
                    "He gestures for you to side beside him, “Come, what is there you wanted to talk about?”\n");
            addButton(0, "Himself", KaljiHimself);
            addButton(1, "Council", KaljiCouncilCheck);
            addButton(14, "Leave", SceneLib.trollVillage.EnterTheVillage);
        }

        function KaljiHimself():void {
            if (!KaljiInteractTrack()) {
                outputText("You tell Kal'ji that you want to get to know him a little more. Who is he, why did he join the council. Does he enjoy his position of power?\n" +
                        "\n" +
                        "“My, you sure have a lot of questions.” He replies, “Let's see…  I am Kal'ji, as you may know. I am not tall or strong by any means. I always felt a little… well, little. It was never a terrible deal, but… It’s as if I had the potential to be more, even if the others couldn’t see it. Childhood was rough, I wasn’t wealthy by any means. I climbed my way out from the dirt, I didn’t want to grow up to be a farmer like my parents. Thankfully my parents were supportive. Sadly they didn’t stick around for long, I don’t want to talk about it.”\n" +
                        "\n" +
                        "“With that aside, I enjoy being on the council, I try to keep things orderly and in conduct when the people get unruly and it’s not bad. People see me as a person in power and I’d have it no other way.”\n" +
                        "\n" +
                        "Kal’ji looks like he’s about to say something, but stops mid-thought. “It was nice talking with you, but I best get going, farewell [name].”\n");
            }
            SceneLib.trollVillage.kuru.KuruExitDialogue();
        }

        function KaljiCouncilCheck():void {
            if (!KaljiInteractTrack()) {
                KaljiCouncil();
            }
            SceneLib.trollVillage.kuru.KuruExitDialogue();
        }

        function KaljiInteractTrack():Boolean {
            if (TrollVillage.KaljiUnlocked < 4) {
                TrollVillage.KaljiUnlocked++;
                return false;
            } else {
                outputText("As you approach Kal'ji, he interrupts you.\n" +
                        "\n" +
                        "“I am terribly sorry, [name], but I am in a serious rush right now. Why don’t you talk to me later at my home? It is a bit closer to the edge of the troll village and fairly ornate. We can catch up later. Farewell.”\n");
                outputText("Kalji's home has been unlocked!");
                TrollVillage.KaljiUnlocked++;
                return true;
            }
        }
    }

    public function KaljiHome():void{
        clearOutput();
        outputText("You knock on the door to Kal'ji’s hut, as you wait patiently eventually the slender troll answers the door.\n" +
                "\n" +
                "“Ah, [name]. Good to see you found my little hovel. It was nice talking to you at the Diner, perhaps we could get to know each other more here, yes?”\n" +
                "\n" +
                "You politely enter his home. It’s fairly small, a few rooms, and a cozy interior. He guides you to a small couch, just big enough for the two of you to sit on together.\n" +
                "\n" +
                "“Tell me, [name], what brings you here on this fine day?”\n");
        KaljiTalkOptions();
    }

    private function KaljiTalkOptions():void{
        menu();
        addButton(0,"Appearance", KaljiAppearance);
        addButton(1, "Himself", KaljiHimself);
        addButton(2,"Council", KaljiCouncil);
        addButton(3, "Sex", KaljiSex);
        addButton(14, "Leave", SceneLib.trollVillage.EnterTheVillage);
    }

    private function KaljiAppearance():void{
        clearOutput();
        outputText("You inspect Kal'ji. He’s about 6’10” tall, clad in a long, brown fur hooded cloak that stretches down to his ankles. He wears only a pair of cured leather pants beneath his cloak and some brown leather boots, but he’s not wearing his shoes within his home right now. Unlike many trolls, he’s very slender and not as muscular as the others. It is extremely difficult to see or even notice, but you know he’s armed with a dagger somewhere.\n" +
                "\n" +
                "His face is sharper and more angular than the more chiseled square jaws you’ve seen other trolls carry. His face is adorned with almond-shaped brown eyes and a sharp nose. He has ivory tusks protruding from his mouth, about 7 inches long.\n" +
                "\n" +
                "He has a fairly standard physique. His manly pectorals are unprotected as he wears nothing over his torso. He may not have broad shoulders like other trolls, but he has what you’d expect. Four fingers on each hand, four toes on each foot, the standard for most trolls. Covered head to toe in an ashen green hair coat. You notice the claws on his fingers, you can’t recall seeing any trolls having claws in the village, did he sharpen them or is it natural?\n" +
                "\n" +
                "You can’t see it beneath his fur clothing, but you know he has the standard humanoid manhood that is about 6 inches long with a duo of fuzzy balls swaying beneath, each about 2 inches across.\n");
        KaljiTalkOptions();
    }

    private function KaljiHimself():void{
        outputText("You tell Kal’Ji that you want to get to know him a little more. You remember what he told you about himself last time, but you’re sure that’s not all there is to him.\n" +
                "\n" +
                "Kal’Ji looks around briefly, almost as if he was worried about being watched. “I’ve already told you a little about my past, but, that’s not entirely who I am now. How I always felt a little… well, little. It was never a terrible deal, but… It’s as if I had the potential to be more, even if the others couldn’t see it. Childhood was rough, I wasn’t wealthy by any means. I climbed my way out from the dirt, I didn’t want to grow up to be a farmer like my parents. Thankfully my parents were supportive. Sadly they didn’t stick around for long, as you may recall.”\n" +
                "\n" +
                "He takes a deep breath, “There was this girl who tried to subdue me, wanting to allure me with her scent, but something about it wasn’t right. I wasn’t falling for her like I was told would happen. At that moment I knew all she wanted from me is my body, I could tell by the lustful look in her eyes, she did not want me for anything else than my essence.” He pauses for a moment, “That day sparked something inside me, a burning rage that could not be quelled. I had to fight, I had to prove myself that I wasn’t just an object or a failure like my parents. The constant ridicule I felt, I had to give them a piece of my mind, and oh how sweet it will be.”\n" +
                "\n" +
                "“I guess you could say I’ve been a little underhanded, doing questionable things to get my way… luring men into what I like to call my ‘dungeon’ and having fun with them. I have all the power, they know they can’t speak up against a member of the council and I love seeing them squirm when they see me around the village.”\n" +
                "\n" +
                "“With that aside, I enjoy being on the council, I try to keep things orderly and in conduct when the people get unruly and it’s not bad. People see me as a person in power and I’d have it no other way.”\n");
        KaljiTalkOptions();
    }

    private function KaljiCouncil():void{
        outputText("You ask Kal'ji what he thinks about the council and the other members.\n" +
                "\n" +
                "“Things have gone well, all things considered. There were a few too many females so adding a second man into the council helped even things out more. Understand that the council has good ideas, but having a more diverse set of minds could help out with responding to the community better. Sure many rules have been set out that mostly focuses on one idea, but that’s because Yubi was only focused on what she wanted, even if she had the best intentions she couldn’t think outside of her own box. She’s a great person, just having trouble dealing with her surroundings.”\n" +
                "\n" +
                "Kal'ji stretches briefly, “Still, I’m glad I’m able to help her see things in a different light, even if she’s a little hard-headed, I know she just wants what’s best for everyone and I can help her with my own ways.”\n" +
                "\n" +
                "“I’d suggest talking to the other members of the council, I’m really not too interested in talking about the inner mechanisms on how things work here, apologies. Besides, I’d best get going, farewell, [name].”\n");
        KaljiTalkOptions();
    }

    private function KaljiSex():void{
        clearOutput();
        menu();
        if (!player.hasCock() || (player.gender == 0  && player.smallestTitSize() >= 3 && player.femininity >= 36)){
            outputText("You ask Kal'ji if he’s willing to get a little more intimate with you.\n" +
                    "\n" +
                    "Kal'ji gives you a small smile, “Thanks [name]. I am very flattered, but I can’t say I’m too interested in you, you’re just… not my type…”\n" +
                    "\n" +
                    "His eyes dart around for a moment, almost as if he was worried about being watched. “Well, perhaps there’s one thing you could do for me if you’d like.”\n" +
                    "\n" +
                    "You ask him what that is.\n" +
                    "\n" +
                    "“Get on your knees and blow me.”\n" +
                    "\n" +
                    "You consider for a moment, this is all you’re gonna get out of him. Do you accept his offer?\n")
            addButton(0,"Blow Him", KjBJY);
            addButton(1,"Do not", KjBJN1)
        }
        else if (!player.hasVagina() || (player.gender == 0  && player.smallestTitSize() <= 1 && player.femininity <= 35)){

        } else{
            outputText("")
        }

        function KjBJY():void{
            outputText("You crawl onto your knees before him, pulling down his leather pants as all 7 inches of his glorious manhood is revealed to you. As his pants are pulled down, you see him pull out a dagger hidden from within them, he places it behind him. You gulp slightly at the sight of it.\n" +
                    "\n" +
                    "You stroke the tip of his length with your [hand], bringing his length up to full mast. His erection pokes out toward you, awaiting your advance. You bring your mouth closer to him. You press your [lips] at the head of his shaft, flitting your tongue along the tip of his erection. You lean forward further, wrapping your [tongue] around his manhood, slowly taking in more of his length.\n" +
                    "\n" +
                    "Kal'ji suddenly grabs the back of your head, forcing you down his cock. You gag as several inches are forced down your throat. You try to resist, but he keeps you locked firmly in place, your [face] pressed against his crotch.\n" +
                    "\n" +
                    "[(pc resisted) “If you’re gonna do your job, you better do a damn good job, slut.”]\n" +
                    "[(pc willing) ”If you don’t want to disappoint me then you better get to work.”]\n" +
                    "\n" +
                    "You choke, trying to pull away from him but he’s not letting you go. After realizing struggling is useless you give in, trying to steady your rhythm and find a good pace to blow him at.\n" +
                    "\n" +
                    "He keeps his hand pressed against the back of your head, pressing your head into his length. Soon a bit of pre hits your tongue, you’ve almost forgotten how virile trolls are and you’re sure he’s no different.\n" +
                    "\n" +
                    "“Getting closer... “ Kal'ji mutters, [(pc resisted“You’re a good pile of dirt, you’re actually not a complete disappointment.”] [(pc willing) “Such a good girl, you’re doing well.”]\n" +
                    "\n" +
                    "You redouble your efforts, working your [tongue] around his shaft, making sure not a single inch of him is neglected. You feel him twitch within you, he’s ready to cum.\n" +
                    "\n" +
                    "“So close, I’m so close now!” He moans.\n" +
                    "\n" +
                    "With a powerful thrust, he finally cums, shooting several loads of cum into your mouth. Despite the sheer volume, you make sure to drink every last drop he has to offer in fear of what may happen if you don’t.\n" +
                    "\n" +
                    "Kal'ji pats your head, “You did rather well, all things considered.” He states. “Now clean me up, you better leave a good impression if I’m gonna let you do this again.”\n" +
                    "\n" +
                    "You lap up the rest of the cum around his length, cleaning him off with your tongue. Once you’re done he pulls up his leather pants.\n" +
                    "\n" +
                    "“Move along now, I have important things to take care of, none of which involve you.”\n" +
                    "\n" +
                    "You take your leave, excusing yourself from his hut.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function KjBJN1():void{
            outputText("You tell him that you’re not going to accept his offer.\n" +
                    "\n" +
                    "Kal'ji shakes his head, “And what makes you think you’re in charge of the situation here? You’re in my hut, I am a member of the council. Who will the people listen to here?”\n" +
                    "\n" +
                    "He gives you a cocky grin. “There are people aware of you inside my hut right now, there’s nothing you can do about it. I will give you one. More. Chance… Blow me.”\n");
            addButton(0, "Submit",KjBJY);
            addButton(1,"Grovel", KjBJN2);
        }

        function KjBJN2():void{
            outputText("You plead, crying out for mercy, you don’t want this, you’re sorry to have provoked him. You didn’t want to take it this far. You beg for him to spare you and let you go.\n" +
                    "\n" +
                    "Kal'ji quickly darts his head around before turning back to you. “Okay! Okay. Understand this, [name], there will be consequences for crossing me. But you’re free to go, for now…”\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }
}
}
