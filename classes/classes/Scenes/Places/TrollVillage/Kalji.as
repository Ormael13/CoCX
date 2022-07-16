/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.Items.ArmorLib;
import classes.Items.UndergarmentLib;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.SceneLib;

public class Kalji extends TrollVillageAbstractContent{
    public function Kalji() {
    }

    public function TalkWithKalji():void {
        clearOutput();
        if (TrollVillage.ZenjiFollowing) {
            outputText("Zenji speaks up, \"<i>I’ll be back, [name]. I gotta use de restroom.</i>\"");
        }
        if (TrollVillage.KaljiUnlocked == 0) {
            outputText("Your gaze roams around and you see a somewhat short, slender troll wearing a cape that drapes down to his ankles. You decide to head over to him to get to know him. He quickly notices you approaching him and holds out a hand toward you.\n" +
                    "\n" +
                    "\"<i>Halt.</i>\" He commands, \"<i>Please keep your distance, I am not used to strangers approaching me. If you could kindly introduce yourself before you approach, I would be thankful.</i>\"\n" +
                    "\n" +
                    "You introduce yourself, while also stating that you were interested in getting to know the other trolls while you were here.\n" +
                    "\n" +
                    "\"<i>Ah, then my name is Kal'ji, the pleasure is mine, [name]. Come, sit next to me. I am but one of the members on the Council of Elders. I govern the place, but mostly take care of the economy. Tell me, what brings you here to the troll village? I don’t think I’ve ever seen someone by the likes of you around,</i>\" he replies.\n");
            if (player.femininity < 35) {
                outputText("Kal'ji leans slightly closer, \"<i>It is truly a pleasure to meet someone as… unique… as you...</i>\"");
            }
            outputText("The two of you spend a moment getting to know each other. He is a rather pleasant person to talk to. Carrying a calm and relaxed demeanor, but you can’t help but feel like he is paying more attention to his surroundings than he is to you. Is he paranoid, or perhaps hiding something?\n" +
                    "\n" +
                    "Soon enough Kal'ji excuses himself. \"<i>I’m sorry, but as an Elder, I don’t have as much free time as I would like to talk to friends like you. If you would excuse me there are things I must attend to now, farewell, [name].</i>\"\n" +
                    "\n" +
                    "Kal'ji leaves and eventually you leave the Dining hall as well.\n");
            TrollVillage.KaljiUnlocked = 1;
            SceneLib.trollVillage.kuru.KuruExitDialogue();
        } else {
            menu();
            outputText("Since you’re alone again, you approach Kal'ji, he is sitting by himself while eating a salad.\n" +
                    "\n" +
                    "Kal'ji quickly notices you, \"<i>Ah, [name]! Welcome! It’s great to see you here again!</i>\"\n" +
                    "\n" +
                    "He gestures for you to side beside him, \"<i>Come, what is there you wanted to talk about?</i>\"\n");
            addButton(0, "Himself", KaljiHimself);
            addButton(1, "Council", KaljiCouncilCheck);
            addButton(14, "Leave", SceneLib.trollVillage.EnterTheVillage);
        }

        function KaljiHimself():void {
            if (!KaljiInteractTrack()) {
                outputText("You tell Kal'ji that you want to get to know him a little more. Who is he, why did he join the council. Does he enjoy his position of power?\n" +
                        "\n" +
                        "\"<i>My, you sure have a lot of questions,</i>\" he replies, \"<i>Let's see…  I am Kal'ji, as you may know. I am not tall or strong by any means. I always felt a little… well, little. It was never a terrible deal, but… It’s as if I had the potential to be more, even if the others couldn’t see it. Childhood was rough, I wasn’t wealthy by any means. I climbed my way out from the dirt, I didn’t want to grow up to be a farmer like my parents. Thankfully my parents were supportive. Sadly they didn’t stick around for long, I don’t want to talk about it.</i>\"\n" +
                        "\n" +
                        "\"<i>With that aside, I enjoy being on the council, I try to keep things orderly and in conduct when the people get unruly and it’s not bad. People see me as a person in power and I’d have it no other way.</i>\"\n" +
                        "\n" +
                        "Kal’ji looks like he’s about to say something, but stops mid-thought. \"<i>It was nice talking with you, but I best get going, farewell [name].</i>\"\n");
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
            if (TrollVillage.KaljiUnlocked >= 5){
                TrollVillage.KaljiUnlocked = 5;
                return false;
            }
            else if (TrollVillage.KaljiUnlocked < 4) {
                TrollVillage.KaljiUnlocked++;
                return false;
            } else {
                outputText("As you approach Kal'ji, he interrupts you.\n" +
                        "\n" +
                        "\"<i>I am terribly sorry, [name], but I am in a serious rush right now. Why don’t you talk to me later at my home? It is a bit closer to the edge of the troll village and fairly ornate. We can catch up later. Farewell.</i>\"\n");
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
                "\"<i>Ah, [name]. Good to see you found my little hovel. It was nice talking to you at the Diner, perhaps we could get to know each other more here, yes?</i>\"\n" +
                "\n" +
                "You politely enter his home. It’s fairly small, a few rooms, and a cozy interior. He guides you to a small couch, just big enough for the two of you to sit on together.\n" +
                "\n" +
                "\"<i>Tell me, [name], what brings you here on this fine day?</i>\"\n");
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
        outputText("You inspect Kal'ji. He’s about 6’10\" tall, clad in a long, brown fur hooded cloak that stretches down to his ankles. He wears only a pair of cured leather pants beneath his cloak and some brown leather boots, but he’s not wearing his shoes within his home right now. Unlike many trolls, he’s very slender and not as muscular as the others. It is extremely difficult to see or even notice, but you know he’s armed with a dagger somewhere.\n" +
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
                "Kal’Ji looks around briefly, almost as if he was worried about being watched. \"<i>I’ve already told you a little about my past, but, that’s not entirely who I am now. How I always felt a little… well, little. It was never a terrible deal, but… It’s as if I had the potential to be more, even if the others couldn’t see it. Childhood was rough, I wasn’t wealthy by any means. I climbed my way out from the dirt, I didn’t want to grow up to be a farmer like my parents. Thankfully my parents were supportive. Sadly they didn’t stick around for long, as you may recall.</i>\"\n" +
                "\n" +
                "He takes a deep breath, \"<i>There was this girl who tried to subdue me, wanting to allure me with her scent, but something about it wasn’t right. I wasn’t falling for her like I was told would happen. At that moment I knew all she wanted from me is my body, I could tell by the lustful look in her eyes, she did not want me for anything else than my essence.</i>\" He pauses for a moment, \"<i>That day sparked something inside me, a burning rage that could not be quelled. I had to fight, I had to prove myself that I wasn’t just an object or a failure like my parents. The constant ridicule I felt, I had to give them a piece of my mind, and oh how sweet it will be.</i>\"\n" +
                "\n" +
                "\"I guess you could say I’ve been a little underhanded with how I get things to go my way... Sometimes, you need to be strict for things to be in order and move how you want them to…</i>\"\n" +
                "\n" +
                "\"<i>With that aside, I enjoy being on the council, I try to keep things orderly and in conduct when the people get unruly and it’s not bad. People see me as a person in power and I’d have it no other way.</i>\"\n");
        KaljiTalkOptions();
    }

    private function KaljiCouncil():void{
        outputText("You ask Kal'ji what he thinks about the council and the other members.\n" +
                "\n" +
                "\"<i>Things have gone well, all things considered. There were a few too many ladies, so adding a second man into the council helped even things out more. Understand that the council has good ideas, but having a more diverse set of minds could help out with responding to the community better. Sure many rules have been set out that mostly focuses on one idea, but that’s because Yubi was only focused on what she wanted, even if she had the best intentions, she couldn’t think outside of her box. She’s a great person, just having trouble dealing with her surroundings.</i>\"\n" +
                "\n" +
                "Kal'ji stretches briefly, \"<i>Still, I’m glad I’m able to help her see things in a different light, even if she’s a little hard-headed, I know she just wants what’s best for everyone and I can help her with my own ways.</i>\"\n" +
                "\n" +
                "\"<i>I’d suggest talking to the other members of the council, I’m really not too interested in talking about the inner mechanisms on how things work here, apologies. Besides, I’d best get going, farewell, [name].</i>\"\n");
        KaljiTalkOptions();
    }

    private function KaljiSex():void{
        clearOutput();
        if (sceneHunter.uniHerms) {
            outputText("How would you pose yourself?\n\n");
            menu();
            addButtonIfTrue(0, "As Male", maleF, "Req. a cock OR low femininity.",
                player.hasCock() || player.looksMale());
            addButtonIfTrue(1, "As Female", femF, "Req. a vagina OR high femininity.",
                player.hasVagina() || player.looksFemale());
        }
        else if (player.gender == 1 || !(player.gender == 2) && player.looksMale()) maleF();
        else femF();
        //===================================================
        function femF():void {
            outputText("You ask Kal'ji if he’s willing to get a little more intimate with you.\n" +
                    "\n" +
                    "Kal'ji gives you a small smile, \"<i>Thanks [name]. I am very flattered, but I can’t say I’m too interested in you, you’re just… not my type…</i>\"\n" +
                    "\n" +
                    "His eyes dart around for a moment, almost as if he was worried about being watched. \"<i>Well, perhaps there’s one thing you could do for me if you’d like.</i>\"\n" +
                    "\n" +
                    "You ask him what that is.\n" +
                    "\n" +
                    "\"<i>Get on your knees and service me.</i>\"\n" +
                    "\n" +
                    "You consider for a moment, this is all you’re gonna get out of him. Do you accept his offer?\n");
            menu();
            addButton(0,"Blow Him", KjBJFY);
            addButton(1,"Do not", KjBJNF1);
        }
        function maleF():void {
            outputText("You tell Kal'ji that you’d like to get a little more intimate with him.\n" +
                    "\n" +
                    "Kal'ji eyes you up and down before giving you a sneering grin. \"<i>Sure, but I’ll warn you… I’m kind of into rope… Hope you don’t mind.</i>\"\n" +
                    "\n" +
                    "Well, everyone has their kinks, are you willing to join in his idea?\n");
            menu();
            addButton(0,"Get Tied", KjBDG);
            addButton(1,"Blow Him", KjBJMY);
            addButton(2,"Do not", KjBJMN);
        }
        //========================================================
        function KjBJFY(resist:Boolean = false):void{
            clearOutput();
            outputText("You crawl onto your knees before him, pulling down his leather pants as all 7 inches of his glorious manhood is revealed to you. As his pants are pulled down, you see him pull out a dagger hidden from within them, he places it behind him. You gulp slightly at the sight of it.\n" +
                    "\n" +
                    "You stroke the tip of his length with your hand, bringing his length up to full mast. His erection pokes out toward you, awaiting your advance. You bring your mouth closer to him. You press your lips at the head of his shaft, flitting your tongue along the tip of his erection. You lean forward further, wrapping your [tongue] around his manhood, slowly taking in more of his length.\n" +
                    "\n" +
                    "Kal'ji suddenly grabs the back of your head, forcing you down his cock. You gag as several inches are forced down your throat. You try to resist, but he keeps you locked firmly in place, your [face] pressed against his crotch.\n" +
                    "\n");
                    if (resist) outputText("\"<i>If you’re gonna do your job, you better do a damn good job, slut.</i>\"\n");
                    else outputText("\"<i>If you don’t want to disappoint me then you better get to work.</i>\"\n");
                    outputText("\n" +
                    "You choke, trying to pull away from him but he’s not letting you go. After realizing struggling is useless you give in, trying to steady your rhythm and find a good pace to blow him at.\n" +
                    "\n" +
                    "He keeps his hand pressed against the back of your head, pressing your head into his length. Soon a bit of pre hits your tongue, you’ve almost forgotten how virile trolls are and you’re sure he’s no different.\n" +
                    "\n" +
                    "\"<i>Getting closer... </i>\" Kal'ji mutters, ");
                    if (resist) outputText("<i>You’re a good pile of dirt, you’re actually not a complete disappointment.</i>\"");
                    else outputText("\"<i>Such a good girl, you’re doing well.</i>\"]\n");
                    outputText("\n" +
                    "You redouble your efforts, working your [tongue] around his shaft, making sure not a single inch of him is neglected. You feel him twitch within you, he’s ready to cum.\n" +
                    "\n" +
                    "\"<i>So close, I’m so close now!</i>\" he moans.\n" +
                    "\n" +
                    "With a powerful thrust, he finally cums, shooting several loads of cum into your mouth. Despite the sheer volume, you make sure to drink every last drop he has to offer in fear of what may happen if you don’t.\n" +
                    "\n" +
                    "Kal'ji pats your head, \"<i>You did rather well, all things considered,</i>\" he states. \"<i>Now clean me up, you better leave a good impression if I’m gonna let you do this again.</i>\"\n" +
                    "\n" +
                    "You lap up the rest of the cum around his length, cleaning him off with your tongue. Once you’re done he pulls up his leather pants.\n" +
                    "\n" +
                    "\"<i>Move along now, I have important things to take care of, none of which involve you.</i>\"\n" +
                    "\n" +
                    "You take your leave, excusing yourself from his hut.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function KjBJNF1():void{
            clearOutput();
            outputText("You tell him that you’re not going to accept his offer.\n" +
                    "\n" +
                    "Kal'ji shakes his head, \"<i>And what makes you think you’re in charge of the situation here? You’re in my hut, I am a member of the council. Who will the people listen to here?</i>\"\n" +
                    "\n" +
                    "He gives you a cocky grin. \"<i>There are people aware of you inside my hut right now, there’s nothing you can do about it. I will give you one. More. Chance… Blow me.</i>\"\n");
            addButton(0, "Submit",KjBJFY, true);
            addButton(1,"Grovel", KjBJNF2);
        }

        function KjBJNF2():void{
            clearOutput();
            outputText("You plead, crying out for mercy, you don’t want this, you’re sorry to have provoked him. You didn’t want to take it this far. You beg for him to spare you and let you go.\n" +
                    "\n" +
                    "Kal'ji quickly darts his head around before turning back to you. \"<i>Okay! Okay. Understand this, [name], there will be consequences for crossing me. But you’re free to go, for now…</i>\"\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function KjBDG():void{
            clearOutput();
            outputText("You say that you’re interested in the idea and don’t mind getting a little bondage.\n" +
                    "\n" +
                    "Kal’ji smirks, \"<i>Good, this’ll be fun then.</i>\"\n" +
                    "\n" +
                    "He guides you to his bedroom, it’s dim, illuminated only by candlelight. His bed is seated at the back of the room, covered neatly in pillows and blankets.\n" +
                    "\n" +
                    "\"<i>Why don’t you get comfortable before lying down on the bed as I get out the ropes..?</i>\"\n" +
                    "\n");
            if (!player.lowerGarment.isNothing || !player.upperGarment.isNothing || !player.armor.isNothing){
                outputText("You take off your [armor] before getting onto the rather comfortable bed.\n");
            }
            else{
                outputText("Since you’re not wearing anything you suppose that you are comfortable enough and get onto the rather comfortable bed.\n");
            }
            outputText("You lie down on his bed, Kal’ji reaches under the frame, pulling out several yards of coiled up rope.\n" +
                    "\n" +
                    "Kal’ji straddles your torso as he spends time fastening your arms above your head. He is mockingly slow, giving you a devious grin. His soft, silky fur grazes your hands and wrists as he makes sure to tie you tightly to the bedpost. \n" +
                    "\n" +
                    "Once you are tied to his satisfaction he kneels himself between your legs, lifting your legs onto his shoulders. He steadily aligns his length to your hole, rubbing his precum over your hole, lubricating you before stroking his furry hand over his length, coating himself as well. You struggle softly beneath him, unable to anything but rest your legs against him.\n" +
                    "\n" +
                    "He gives you a devious smirk at your situation, \"<i>It’s always adorable seeing them shift around…</i>\"\n" +
                    "\n" +
                    "One arm holds your leg up on his shoulder as the other grabs onto your hips as he thrusts into you.\n" +
                    "\n" +
                    "You stir within your restraints as you’re forced to take in all 6 inches of his girth. Your wrists grow weary and tired from the position above you, but there’s a hint of delight Kal’ji seems to be getting from watching you squirm softly.\n" +
                    "\n" +
                    "He drives his length into you, pushing himself deeper into your cavity as you clench your sphincter around his slick girth. [(pc has penis) He grips your erection with his soft palms, groping you tightly within his grasp as he gives you a taunting grin.] [(pc lacks penis) He rubs the underside of your taint with his fuzzy palms, toying with your body as he gives you a taunting grin.)\n" +
                    "\n" +
                    "You moan in pleasure as his girth prods at your prostate and his expression shifts to disdain.\n" +
                    "\n" +
                    "\"<i>Why don’t we silence that noise, hmm..?</i>\" He snickers as he pulls out more rope at the side of the bed. He quickly fastens it over your face, covering your mouth with the makeshift gag.\n" +
                    "\n" +
                    "You groan softly as he continues thrusting into you, he grins in satisfaction at your muffled moans. He grabs hold of your legs, pulling them closer to himself as he presses you down onto the mattress. He keeps you locked beneath his grasp, pinning you down on the bed as he pounds deeper into your backdoor.\n" +
                    "\n" +
                    "You sink into his presence as he keeps you in place, making sure you cannot escape from him. Soon enough a familiar pressure builds up within your loins. [(pc has penis) Your dick begins throbbing harder, aching for release]\n" +
                    "\n" +
                    "Sensing your impending orgasm Kal’ji begins thrusting into you with even more force, groaning softly as he buries his shaft as deep as he can go.\n" +
                    "\n" +
                    "You moan in pleasure through the rope as your orgasm hits. [(pc has penis) Spurts of cum jet out of your length, directly onto his slender chest.\n" +
                    "\n" +
                    "Kal’ji moans louder, thrusting deeper into you as he finally cums. He presses his hips against your backside, plugging up your backdoor with his length as waves of his cum cascade directly into you. You can’t hope to contain all the cum he has to offer as his seed leaks out past his length. He pulls out, dragging more of his seed with him.\n" +
                    "\n" +
                    "\"<i>Hmm, not bad… Perhaps I should tie you up more next time.</i>\"\n" +
                    "\n" +
                    "He smirks softly before untying you. Once you’re free he speaks up, \"<i>Why don’t you spend a moment to clean me off.</i>\"\n" +
                    "\n" +
                    "You oblige and kneel in front of him, wrapping your tongue around his uncut length, ensuring he’s spotless from the ordeal.\n" +
                    "\n" +
                    "Once you’re done you pack up your belongings and take your leave.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function KjBJMY():void{
            clearOutput();
            outputText("You ask him if he’s willing to just let you get a taste of his head and let you have the chance of pleasing him with your mouth instead.\n" +
                    "\n" +
                    "\"<i>Hmm… You want to blow me..? Fine, I’ll allow it. We can do it here, nice and easy.</i>\"\n" +
                    "\n" +
                    "You crawl onto your knees before him, pulling down his leather pants as all 7 inches of his glorious manhood is revealed to you. As his pants are pulled down, you see him pull out a dagger hidden from within them, he places it behind him. You gulp slightly at the sight of it.\n" +
                    "\n" +
                    "You stroke the tip of his length with your hand, bringing his length up to full mast. His erection pokes out toward you, awaiting your advance. You bring your mouth closer to him. You press your lips at the head of his shaft, flitting your tongue along the tip of his erection. You lean forward further, wrapping your [tongue] around his manhood, slowly taking in more of his length.\n" +
                    "\n" +
                    "Kal'ji suddenly grabs the back of your head, forcing you down his cock. You gag as several inches are forced down your throat. You try to resist, but he keeps you locked firmly in place, your [face] pressed against his crotch.\n" +
                    "\n" +
                    "\"<i>If you don’t want to disappoint me then you better get to work.</i>\"\n" +
                    "\n" +
                    "You choke, trying to pull away from him but he’s not letting you go. After realizing struggling is useless you give in, trying to steady your rhythm and find a good pace to blow him at.\n" +
                    "\n" +
                    "He keeps his hand pressed against the back of your head, pressing your head into his length. Soon a bit of pre hits your tongue, you’ve almost forgotten how virile trolls are and you’re sure he’s no different.\n" +
                    "\n" +
                    "\"<i>Getting closer... </i>\" Kal'ji mutters. \"<i>Such a good boy, you’re doing well.</i>\"\n" +
                    "\n" +
                    "You redouble your efforts, working your [tongue] around his shaft, making sure not a single inch of him is neglected. You feel him twitch within you, he’s ready to cum.\n" +
                    "\n" +
                    "\"<i>So close, I’m so close now!</i>\" he moans.\n" +
                    "\n" +
                    "With a powerful thrust, he finally cums, shooting several loads of cum into your mouth. Despite the sheer volume, you make sure to drink every last drop he has to offer in fear of what may happen if you don’t.\n" +
                    "\n" +
                    "Kal'ji pats your head, \"<i>You did rather well, all things considered,</i>\" he states. \"<i>Now clean me up, perhaps there’ll be something more in it for you in the future if you keep this up.</i>\"\n" +
                    "\n" +
                    "You lap up the rest of the cum around his length, cleaning him off with your tongue. Once you’re done he pulls up his leather pants.\n" +
                    "\n" +
                    "\"<i>You should get going now.</i>\"\n" +
                    "\n" +
                    "You take your leave, excusing yourself from his hut.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function KjBJMN():void{
            TrollVillage.KaljiMBJDeny++;
            clearOutput();
            outputText("You politely say that you’re not intrigued by the idea and would prefer something else.\n");
            if (TrollVillage.KaljiMBJDeny == 1){
                outputText("Kal'ji sighs and rolls his eyes, \"<i>Well, that’s what I have to offer, if you don’t enjoy the idea then you’re free to go.</i>\"\n" +
                        "\n" +
                        "You apologize and take your leave.\n");
                doNext(camp.returnToCampUseOneHour);
            }
            else if(TrollVillage.KaljiMBJDeny == 2){
                outputText("Kal'ji sighs, \"<i>Why do you keep bringing it up then? Are you trying to get on my bad side? You. Won’t. Like. My. Bad. Side. This is your LAST warning.</i>\"\n");
                doNext(camp.returnToCampUseOneHour);
            }
            else{
                outputText("Kal'ji sneers, \"<i>Oh really, and since when did you think you were in charge? You’re in my home, hidden from public view. I have all the power here,</i>\" he states, pulling out his dagger. \"<i>When you’re with me, you’re MY property, nothing more. You have no more value than the dirt I walk on. Go ahead, fight back. The villagers will only see a nobody attacking a beloved member of the council.</i>\"\n" +
                        "\n" +
                        "Kal'ji brings his dagger closer to your face. It is extremely sharp. You yelp in pain as he slides the blade down part of your cheek, cutting your face slightly. He holds his dagger at your throat as he pulls out some rope, tying your [handdescription] behind your back. \n" +
                        "\n" +
                        "\"<i>Come along to my dungeon, I’ll show you what happens when you cross me. I’ll show you how worthless you truly are.</i>\"\n" +
                        "\n" +
                        "You try to resist, but it’s no use.\n" +
                        "\n" +
                        "\"<i>Go ahead and struggle, I love watching you squirm.</i>\"\n" +
                        "\n" +
                        "Several thoughts run through your mind at once. Why does he have a dungeon in his home? How often does he do this sort of thing? You start to hyperventilate, fearing for your life on what this sick and twisted troll has planned for you.\n" +
                        "\n" +
                        "Kal'ji speaks up, jutting the dagger at your face, \"<i>All I’m hearing is the noise of someone who needs to be put in their place. Let’s silence that.</i>\" He pulls out some more rope. He ties it around your mouth, gagging you with the thick, coarse hemp.\n" +
                        "\n" +
                        "He drags you to his bedroom, it is dimly lit aside from a ceiling lamp.\n" +
                        "\n" +
                        "\"<i>Now that you’re mine, let me get you seated properly…</i>\" he sneers before tying your body up, making sure you cannot move. He leaves you alone as you fall to the floor, prone and vulnerable. You can see him in the corner of your eye move the mattress. There’s something wooden beneath it but you can’t quite see it.\n" +
                        "\n" +
                        "He moves toward you, you squirm in desperation, but it’s all pointless. As he drags you to where his bed was before, your eyes widen in terror as you can see a medieval torture rack. He places you on top of it. It is very large and very wide, you’re unsure how he obtained it, or just how many people he’s mercilessly tortured on it. It can easily fit almost any sized creature on it with just how massive it is.\n" +
                        "\n" +
                        "Once you’re placed on the rack, he refastens your bindings, tying you to the torture rack until your [armdescription] and [legdescription] are hyperextended, spread far apart from each other.\n");
                if (!player.lowerGarment.isNothing || !player.upperGarment.isNothing || !player.armor.isNothing){
                    outputText("He makes way with your [armor], removing it with deliberate slowness. \"<i>I’m gonna some have fun for a while...</i>\" he snickers\n");
                }
                if (player.hasPerk(PerkLib.Masochist) || silly()){
                    outputText("\"<i>I wonder how far you can stretch until you snap.</i>\" He chuckles, pulling on a crank to the side of the rack. You grin in delight. Finally! This is what you live for! You urge him to go faster, harder.\n" +
                            "\n" +
                            "Kal'ji suddenly stops. \"<i>It’s no fun when you’re enjoying yourself. In that case, begone!</i>\" he shouts as he removes your gag whilst untying you.\n" +
                            "\n" +
                            "You cry out. Please, you just want a little torment.\n" +
                            "\n" +
                            "He gestures for you to leave. You do so dejectedly as you take all your things.\n");
                } else{
                    outputText("\"<i>I wonder how far you can stretch until you snap.</i>\" He chuckles, pulling on a crank to the side of the rack. You scream in agony into your gag as you feel your arms and legs slowly pull further and further. Tears stream down the side of your face as you squirm. Once you feel like your body is going to snap off at any moment he stops.\n" +
                            "\n" +
                            "\"<i>Hmm...</i>\" He sighs, \"<i>Fragile… Like the shopkeepers… Somehow you’re softer than the farmer the other day... I thought you'd take it better than that. So weak… so pitiful...</i>\"\n");
                    if (player.hasCock()){
                        outputText("His hand reaches down to your [cock] as he gently begins to stroke it. \"<i>Perhaps there’s a better way to break you…</i>\"\n" +
                                "\n" +
                                "You cry out in desperation, but your voice is muffled from the gag. You squirm, trying to resist his perverted advance, but to no avail. His hand gently starts to rub your manhood as it spikes to full mast. You despise how good his soft fur feels on your [cock]\n");
                    } else{
                        outputText("His hand reaches down to your groin. Despite your lack of a penis, he gently rubs his soft furred hand across your loins. \"<i>An interesting body, but one that will break nonetheless.</i>\"\n" +
                                "\n" +
                                "You cry out in desperation, but your voice is muffled from the gag. You squirm, trying to resist his perverted advance, but to no avail. His hand continues rubbing your crotch with slow teasing motions. You despite how good his soft fur feels on your body.\n");
                    }
                    outputText("\"<i>Look at you,</i>\" he mocks, \"<i>Putty beneath my touch. A filthy, worthless imp before me.</i>\"\n");
                    if (player.hasCock()){
                        outputText("He brings his hand to his mouth as he lathers it in his saliva, coating it thoroughly as he brings it back down to jerk you off slowly. You cry out in pain and pleasure. Your body is being stretched past its limits while your length is being stimulated. You despise every moment of it. You try to beg him to stop, but he ignores your pleas, giving you a sly grin in response.\n" +
                                "\n" +
                                "He continues stroking your shaft while his free hand gently strokes your stomach. His soft fur tickles you gently as you squirm again. You can’t help but feel your arousal build up at his ministrations. He gropes at your pecs, you struggle beneath him, wanting to be released from this hell, but he still doesn’t yield.\n" +
                                "\n" +
                                "You feel pressure building up within your loins, you’re so close to cumming. Sensing your impending orgasm, Kal'ji stops.\n" +
                                "\n" +
                                "\"<i>You’re not getting off that easily…</i>\" he replies tauntingly.\n");
                    }
                    if (player.lowerBodyPart.legCount < 2){
                        outputText("His hand sensually roams down your [leg], softly grazing your [skin] as he moves closer to your feet.\n" +
                                "\n" +
                                "You shake, stirring in place, desperate to get away from him, but you’re trapped in this hell with him.\n" +
                                "\n" +
                                "\"<i>Keep struggling, maybe if you squirm enough I’ll let you go.</i>\" He smirks with a disparaging grin.\n" +
                                "\n" +
                                "He continues grasping at your feet before leaning his face in closer to you. He sticks his long, sticky tongue out, licking around the sole of your foot before wrapping his hand around your entire foot, dragging his tongue all over the base of your foot.\n" +
                                "\n" +
                                "You squirm and clench your toes as he moves his tongues between the crevices of your toes and creases of your foot. His warm, sticky saliva lingers on your foot before he moves his face away from you.\n" +
                                "\n" +
                                "His soft hands gloss over the soles of your feet. The delicate hairs on his body tingle as he kneads away at your feet. \"<i>Let’s see how much you like this…</i>\"\n" +
                                "\n" +
                                "He slides his fingers around your soles, you twitch and squirm as he tickles you. \"<i>Normally, I’d love to spend more time with soles like these, It really is a shame I'm on quite the schedule today, so I’m just gonna have to speed things up, don’t I? Dirt like you should be thankful for the kind treatment.</i>\"  You squirm and shake violently, shedding more tears as breathing becomes more difficult through the pain and muffled laughter.\n" +
                                "\n" +
                                "Noticing your suffering Kal'ji gives a sinister laugh. \"<i>Haha, there’s the torment! Normally trash like you won’t get good treatment, you truly are lucky today.</i>\" He sneers. \"<i>But now I get to the best part.</i>\"\n" +
                                "\n" +
                                "Kal'ji moves up and stands on top of the torture rack after removing all of his clothes. He balances himself above you before placing his foot on your face. He drags his foot across your face, you constantly shift your face away from his foot, but he simply laughs as he continues using you as a doormat.\n" +
                                "\n" +
                                "Kal'ji slowly begins to displace the rope gag from your mouth. \"<i>If you even think of doing anything funny I’ll snap your arms and legs clean off your body. A footstool like you should be grateful I haven’t done so already.</i>\"\n" +
                                "\n" +
                                "You cough and sputter once the gag is removed, taking a deep breath while you can. Your moment of deliverance doesn’t last long as he places the base of his sole on your lips, digging his heel past your lips. \"<i>Better give me a good cleaning or this doormat is going out with the rest of the trash.</i>\" He croons.\n" +
                                "\n" +
                                "You try to wrap your [tongue] around his sole digging past the hair on his feet. The foul earthy and salty taste pervades your mouth as you do so. You continue licking away at his sole as he slowly moves his foot down your face. You lap away at the arch of his foot before he finally brings his toes down to your mouth. You cough and gag as he digs his large toe in first. His fur coats your tongue, it’s soft and constantly gets between your teeth.\n" +
                                "\n" +
                                "\n" +
                                "\"<i>Such a bad doormat, coughing, and gagging beneath me,</i>\" he growls. \"<i>You need to do better than that,</i>\" he states as he digs his toe in further into your mouth.\n" +
                                "You continuously try to resist, but he constantly presses his foot against you, worming his toe through your lips each time you pull away.\n" +
                                "\n" +
                                "You look up and notice him beginning to jerk himself off. He seems to be getting a lot of pleasure from tormenting you. He strokes his length with long and slow motions.\n" +
                                "\n" +
                                "\"<i>So helpless…</i>\" Kal'ji mumbles, \"<i>So vulnerable…</i>\" He sighs as he prods his toe against your [foot], slowly increasing the pace of his strokes.\n");
                    }
                    if (player.hasCock()){
                        outputText("You don’t know why, but your manhood has erected once more, your own body is betraying you. You feel his foot retract from your lips, sliding down your chest. His foot glides down your body, streaking your torso with your saliva before his foot finally reaches your manhood. He slides your girth between his toes.\n" +
                                "\n" +
                                "\"<i>Oh, you wish I’d get you off, don’t you?</i>\" he croons. \"<i>Look, the filthy peasant wants a king to get him off! Too bad dirt like you doesn’t deserve to know the pleasures of a proper reward.</i>\"\n" +
                                "\n" +
                                "As you orgasm impedes on you, you try to thrust up against him, but before you’re ready to cum he stops.\n" +
                                "\n" +
                                "\"<i>You didn’t forget who’s in charge here, did you?</i>\"\n");
                    }else{
                        outputText("\"<i>Look at you, nothing but a filthy peasant before a king,</i>\" he croons.\n" +
                                "\n" +
                                "You try to back off from him again, but he digs his foot into your face even further. \"<i>I’m the one in charge, you hear? You’re not done until I’m spotless.</i>\"\n");
                    }
                    outputText("Kal'ji shifts his weight on top of you. Bouncing softly as he jerks himself off with more vigor.\n" +
                            "\n" +
                            "\"<i>Getting closer…</i>\" he mumbles. \"<i>A good bitch like you just might be deserving of my load.</i>\"\n" +
                            "\n" +
                            "He begins thrusting his hips forward as he moans softly. He cries out in pleasure as he finally cums. Waves of his seed pour down from above you. You close your eyes and try to tilt your face, but he kicks you back up to make sure you receive his load head-on.\n" +
                            "\n" +
                            "You exhale sharply as droplets seep into your nose. Coughing and sputtering back off all the cum that’s been unloaded directly onto your face.\n" +
                            "\n" +
                            "Once he finally calms down he spends a moment looking at you. \"<i>Pathetic,</i>\"he mutters. \"<i>What a messy doormat you’ve become.</i>\"\n" +
                            "\n" +
                            "He strokes his foot across your torso before sliding down to the floor. He slowly releases the tension on the rack as you feel your hyperextended limbs be released of tension. You cry in pain, swallowing some of his cum as you do so. You choke slightly, but the feeling of finally being granted liberation is overwhelming once you can finally relax your strained limbs, even if only a little bit.\n" +
                            "\n" +
                            "Kal'ji spends a moment reveling in your defenselessness before he slowly undoes the bindings to the ropes that keep you trapped.\n" +
                            "\n" +
                            "You feel humiliated and completely defeated after being untied. You can’t explain why, but it feels as if something is inhibiting your will to fight back.\n" +
                            "\n" +
                            "Kal'ji drops a towel on his foot. \"<i>Better fetch it like the animal you are, lest your face will become stained with a permanent reminder of your impertinence.</i>\"\n" +
                            "\n" +
                            "You scramble to the ground and pick up the cloth to clean yourself up. Kal'ji sneers at your desperate actions, kicking you away from him.\n" +
                            "\n" +
                            "\"<i>Get out before you can, [name]. Oh, and don’t bother telling anyone what happened. You are still a nobody talking poorly about a respected member of the council. After all, who would believe the words of an outsider against a respected troll like me?</i>\"\n" +
                            "\n" +
                            "You leave his hut in all of your shame after putting your [armor] back on.\n");
                }
            }
        }
    }
}
}
