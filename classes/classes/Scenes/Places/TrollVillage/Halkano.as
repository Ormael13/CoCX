package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.Items.ArmorLib;
import classes.Items.UndergarmentLib;
import classes.Scenes.Places.TrollVillage;
public class Halkano extends TrollVillageAbstractContent{
    public function Halkano() {
    }

    public function TalksWithHalkano():void{
        clearOutput();
        menu();
        if (!TrollVillage.JabalaUnlocked && !TrollVillage.HalkanoUnlocked){ //If Jabala is false, then Zenji has never entered the village yet.
            HalkanoNoZenji();
        }
        else{
            if (TrollVillage.ZenjiFollowing){
                outputText("Your gaze roams around to Zenji’s father, he’s sitting alone by himself.");
                if (player.lib >= 85) {
                    outputText("\nSuch a strong muscle hunk, it’s a shame that he’s not expressing himself more openly. Maybe you could convince him to have some fun right here with you and Zenji, after all, with the effect that you have on Zenji you doubt he’d be against the idea.\n");
                    outputText("\nZenji is already aroused by being near your presence, \"[name]...\" He mumbles with a deep sniff, \"I know dat look you’re giving my fatha… You wanna get down wit him too, don’tcha?\"\n" +
                            "\n" +
                            "You want to, but a thought crosses your mind, do you want to right now?\n");
                    addButton(0, "Spitroast", HalkanoSpitroast);
                    addButton(1, "No", denyThisTime);
                }
                else{
                    outputText(" You ask Zenji if he would mind giving his father some company.\n");
                    outputText("\"Not at all, [name]. I’m sure my fatha has plenty ta talk about, he just chooses not to.\"");
                    doNext(denyThisTime);
                }
            }
            else{
            outputText("You decide to approach Halkano once you’re finished with your food. He notices you as you approach him and waves his hulking arm in a friendly gesture.\n" +
                    "\n" +
                    "\"[name]. It’s good ta see ya again!\" He exclaims, holding out his hand to shake yours. You politely shake his hand in return as you side beside him.\n" +
                    "\n" +
                    "\"I didn’t have much of a chance ta talk de last time I met’cha, why don’t we get ta know each other a little more. Did ya have anything specific ta talk about?\"\n" +
                    "\n" +
                    "You think for a moment, what do you want to talk about exactly anyway.\n");
            addButton(0,"Himself", HalkanoSelfIntro);
            addButton(1, "The People", HalkanoLocals);
            addButton(2, "His Wife", HalkanoJabala);
            }
        }

        function denyThisTime():void{
            outputText("The two of you walk over to Halkano, his face lights up when he notices the two of you approach. He waves his arm welcomingly, Zenji gives a casual wave back in response.\n" +
                    "\n" +
                    "\"Ah, [name], Zenji! Good ta see da two of you again.\" He exclaims, happy to have company.\n" +
                    "\n" +
                    " \"How are da two lovebirds doing? I hope Zenji is treating you right.\" He chortles.\n" +
                    "\n" +
                    "Zenji blushes softly as he gives you a coy grin, \"I do my best, don’t I, [name]?\" He replies, stroking the top of your head gently.\n" +
                    "\n" +
                    "Halkano speaks up, \"It’s such a blessing ta know dat my son is with someone dat cares about him as much as I have. After all, I would be lyin’ if I said de two of you didn’t look great together. Tell me, is all well back at your place? I hope tings are alright outside of de village.\"\n" +
                    "\n" +
                    "Zenji shrugs, rubbing his beard with his strong hands, \"It can be difficult sometimes, but I protect [name]. Making sure nothing happens ta dem during de night… Well, noting dat’s outta my control at least.\" He replies with a wink toward you. \"But it is well. Our love makes us strong, we will always pull through de horrors of de outside.\"\n" +
                    "\n" +
                    "Halkano gives the two of you a soft smile, \"Glad ta hear da two of you are happy.\"\n" +
                    "\n" +
                    "The two of you exchange stories about the time you spend together, Halkano listens intently, but after a moment he stretches, popping his joints loudly.\n" +
                    "\n" +
                    "\"It was nice catching up wit da two of you, but I best get going now goodbye.\" Halkano stands up, taking all of his belongings with him.\n" +
                    "\n" +
                    "\"Let’s get outta here den, sound good. [name]?\"\n" +
                    "\n" +
                    "You agree and leave the dining hall with your lover.\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }

    private function HalkanoNoZenji():void{
        outputText("Your gaze roams around until you decide to approach the rather burly and stout troll sitting down by himself. He is dressed in nothing but some pants. He is easily one of the tallest trolls you’ve seen so far. As you get in closer the big troll doesn’t seem to notice you as he eats a salad slowly. Once you’re closer he finally glances toward you.\n" +
                "\n" +
                "You politely greet yourself, telling him that you’re new here and just wanted to meet the people.\n" +
                "\n" +
                "He gives a nonchalant nod, \"Well… Sit down, why don’tcha? It’s easier on de legs dat way. Least it is for a big guy like me.\"\n" +
                "\n" +
                "You sit down beside him, noting the slight lisp he has. He shifts around slightly to face you. His ashen green eyes carefully inspect you, almost as if he were looking for something to use against you.\n" +
                "\n" +
                "He takes in a slow breath, \"It’s been a while since anyone has really talked ta me I guess… ever since… well. Tings have been a little rough, but I get by with my wife.\" He stirs his fork within his salad, there’s a brief moment of silence between the two of you. \"Well, why don’t I introduce myself? I am Halkano.\" He states as he holds out his massive, calloused hand toward you.\n" +
                "\n" +
                "You shake his hand in response, his grip strong and firm as you tell him your name.\n" +
                "\n" +
                "\"Nice ta meetcha, [name].\" He replies. \"I’d like ta stay and chat, but… Speaking about ma wife, I just remembered dere’s someting I need ta get going back to.\" He says before quickly shoveling the rest of the salad into his mouth, getting up and exiting the building.\n" +
                "\n" +
                "Seeing that there’s not much left to do now, you decide to exit the dining hall.\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoSelfIntro():void{
        clearOutput();
        outputText("You tell Halkano that you wanted to get to know more about him, who he is, and what he does, does he enjoy his time here?\n" +
                "\n" +
                "Halkano thinks for a moment, \"It’s well, I do my best ta keep my wife happy… and well… I tink I did a little too good of a job at dat…\" He gives an infatuated sigh. \"Yeah... \" His dopey expression shifts to dismay, \"It was because my son left us, I can’t say for sure why, or what caused it, but I loved him with everyting I had to give, my heart, my soul…\" [(pc is married to Zenji), \"Tanks ta you though, Zenji is back and I’m honored ta call you family.\"]\n" +
                "\n" +
                "\"Aside from dat though,\" He sighs, \"I am a carpenter, I like what I do and I’m good at it. Good wit my hands, years and years of practice and hard work does pay off.\"\n" +
                "\n" +
                "Halkano bites his lip softly, \"Hmm, I guess I’m not really used ta talking dis much, nobody really talks ta me besides my wife anyway.\" He gives you a firm pat on the shoulder, \"Good talk, [name]. Bye.\"\n" +
                "\n" +
                "He packs up his things and leaves as you say your farewells. You decide to exit the dining hall since there’s nothing left for you at this time now\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoLocals():void{
        clearOutput();
        outputText("You tell Halkano that you wanted to get to know more about the people of the village. After all, he must work with them to some degree, right?\n" +
                "\n" +
                "Halkano shrugs, \"Tings have just been quiet lately. Wit all de tings going on right now, I get de feeling dat dey’re almost intimidated by how big I am. Dey know dat I’ve been going through some rough times and I guess dey just didn’t wanna poke de bear.\"\n" +
                "\n" +
                "His gaze averts as he rolls his head around, popping his joints. \"But… Before dat even, nobody talked ta me, I just neva had anyting ta talk about really. At least, noting I wanna talk about ta anyone but ma wife. De two of us are close, so very close to one another. It’s a long story on how we met… Oh, Jabala…\" He sighs wistfully. \"I can talk about dat another time. Just go out and talk to de people yourself. Most trolls are nice ta talk to, dey won’t bite.\"\n" +
                "\n" +
                "Halkano finishes his food, \"Well, I best get going home now, it was nice chatting wit ya. [name].\" He gets up and leaves with all of his belongings. With nothing left to do, you exit the dining hall for now.\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoJabala():void{
        clearOutput();
        outputText("You wanted Halkano to tell you more about his wife, after all, he appears to be extremely fond of her.\n" +
                "\n" +
                "Halkano blushes softly, \"Mhmm…\" He sighs, taking in an exaggerated pause. \"She really is someting, so strong and determined, always willing to express how she feels and ready ta do what she wants when she wants it. Marae knows how much I may try ta resist her charm, but she’s an unstoppable force of love and compassion. She also knows me too well.\"\n" +
                "\n" +
                "\"I still remember de first time we met, 21 years ago…\" He enthuses, \"I was only 20 at de time, she would be 23. I may not have been as strong as I am now, in fact, I was very soft. She wanted me to build her a garden so she could work on someting personal, being a farmer she liked working wit de greens, but she also wanted someting more personal. When I got dere, she wanted a hands-on approach wit what she wanted me to do. She was very specific and driven, everyting had ta be perfect, and I had no qualms wit doing my job de best way I could. But as she worked next ta me, well… I know de ladies are told ta keep deir emotions to demselves unless it’s fa someone special ta dem… I guess I was special ta her. Dat scent, de smell, so distinct, so enthralling. I got to work, and it was not on de garden. We did finish de garden together, and well… We got along well. Nearly a year later we had our first child together, we loved him with all our hearts as well.\"\n" +
                "\n" +
                "Halkano blushes harder now. \"I… I need ta go now, bye.\"\n" +
                "\n" +
                "He adjusts himself before standing up and leaving a little food on the table. You can’t help but notice a noticeable bulge in his pants. Once he’s gone you decide to leave the dining hall for the time being.\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoSpitroast():void{
        clearOutput();
        outputText("You tell Zenji that you want to be pinned between him and his father, you want both of them inside you, one way or the other.\n" +
                "\n" +
                "Zenji gives you a sultry lick of appreciation across your cheek. \"I was hoping you’d say dat.\"\n" +
                "\n" +
                "The two of you approach Halkano, as you near he gives a gentle wave, but a look of concern smears across his face as the two of you grow near. He sniffs the air intently, \"Dat smell… Zenji… [name]... What… What are de two of you planning..?\"\n" +
                "\n" +
                "He sniffs the air intently again, obviously aroused by your presence. His gaze averts from you as he grows increasingly flustered.\n" +
                "\n" +
                "\"So dad…\" Zenji smirks, \"How about ya get ta know [name] on a… personal level wit me..?\"\n" +
                "\n" +
                "Halkano gives a worried grin, \"Zenji… is dis really what [name] has done ta ya..? Is dis de effect dey have on you..?\"\n" +
                "\n" +
                "\"It’s all good, dad. I love [name]. They’ve only helped me discover who I am. Now I want ta share dem wit you, right here, right now.\"\n" +
                "\n" +
                "Halkano chuckles nervously, but you can already see him beginning to sport an erection.\n" +
                "\n" +
                "He shakes his head, smirking softly, \"Why not, you seem so insistent, is dis whatchu want, [name].\"\n" +
                "\n" +
                "You assure him that you want to be plowed between the two of them.\n" +
                "\n" +
                "Zenji doesn’t even bother surveying his surroundings as he strips himself from his loincloth, revealing his raging erection. \"I’ve been waiting for dis…\" He growls.\n" +
                "\n" +
                "You take a glance around, there are not many people in the diner, around 5 people including the waitress is in the room currently.\n");
        if (player.lowerGarment == UndergarmentLib.NOTHING && player.upperGarment == UndergarmentLib.NOTHING && player.armor == ArmorLib.NOTHING){
            outputText("Since you’re already naked, you press your rear against Zenji, ready to be sandwiched between two hunks.\n\n");
        }
        else{
            outputText("You remove your clothes before pressing your rear against Zenji, ready to be sandwiched between two hunks.\n\n");
        }
        outputText("Zenji holds you tightly by your waist, keeping you held firmly within his grasp. ");
        if (player.tallness < 48) outputText("He is so much taller than you that your feet don’t even reach the ground as you’re suspended in the air at the mercy of his strong arms.\n\n");
        outputText("You can feel Zenji’s length prod at your behind as Halkano approaches your face, removing his pants and unveiling his massive length. It’s about 14 inches long and 2.5 inches wide. It would seem that Zenji did not inherit his father’s size. ");
        if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) >= 15) outputText("Not that it’s an issue given you’ve fixed that problem.");
        outputText("\n");
        outputText("He rests his dick across your face, prodding at your lips. \"Looks like you’ve trained dem a lot for dis.\" He chuckles.\n" +
                "\n" +
                "\"Dey wanted dis, who am I ta deny dem of what dey want, right? Besides, dis was deir idea anyway.\" Zenji replies.\n" +
                "\n" +
                "You reach your [hand] up to Halkano, guiding his length to your lips, licking the tip of his dick.\n" +
                "\n" +
                "Zenji prods at your backdoor, sliding his length between your cheeks. He slavers onto his shaft, lubricating himself for you as he coats his length in his drool. Once he’s sufficiently slicked, he drives himself into your rear.\n\n");
        if (player.analCapacity < 7){
            outputText("His lengthy shaft presses its way deep inside of your tight anus, you feel yourself stretch over his considerable manhood.\n\n");
        }
        else if (player.analCapacity() < 55){
            outputText("His lengthy shaft presses into you, you can feel him accommodating your ass as he presses further and further with each thrust\n\n");
        }
        else{
            outputText("His lengthy shaft presses into you, you can feel him press into your roomy backside as he pushes deeper into you with each thrust.\n\n");
        }
        outputText("Having your backdoor and mouth filled by two massive hunks is pure bliss. You can feel Zenji lean over you as you look up. Zenji forcefully grabs Halkano by his chest tuft, dragging him closer to himself. Halkano grunts slightly in shock and mild protest as he allows his son to drag him closer. Zenji carefully navigates through their tusks as he brings his mouth to his father’s.\n" +
                "\n" +
                "\"Zenji…\" Halkano mutters, but Zenji only gives him a quiet growl in response. He locks his lips with his father, rubbing his beard against him. Zenji gives a low moan as he makes out with his dad. Halkano growls quietly in pleasure as well as he sinks into his son’s advance.\n\n");
        if (silly()){
            outputText("You hear a troll in the distance shout\n" +
                    "\n" +
                    "\"Wait a minute, are you guys fucking? Are you serious? Right in front of my salad?!\"\n" +
                    "\n" +
                    "You see the waitress entering the room out of the corner of your eye. She takes a long pause, staring directly at the three of you.\n" +
                    "\n" +
                    "She takes a deep sigh, \"You know what? I don’t get paid enough for this. That is not my job.\" She mutters before leaving.\n\n");
        }
        outputText("You feel drops of precum emerge from the tip of Halkano’s manhood, the salty, savory taste tingles your taste buds as he thrusts into you. You wrap your [arm] around Halkano for support, doing your best to fit more of his length into your mouth as you suck him off to the best of your abilities.\n" +
                "\n" +
                "It’s so difficult to concentrate on anything as Zenji is simultaneously fucking your brains out. You clench your sphincter around his length, his girthy cock presses deeper into your backdoor, filling you so deliciously, you lose control of yourself as you’re completely held by the two of them.\n" +
                "\n" +
                "You gag slightly as Halkano pushes his entire length down your throat, his meaty cock now dripping pre directly down your stomach. You can hear the two of them growl above you. You moan softly, turned on by their overwhelming presence, their enthralling musk, their soft gentle fur, their massive, muscular bodies are both yours.\n" +
                "\n" +
                "Eventually, Halkano breaks the kiss from his son, turning his attention back to you. He grabs the back of your head, forcefully pulling you over his cock, bobbing your head up and down his length for you. Zenji doesn’t give you a break either, gripping onto your hips tighter, pulling you closer to him with each powerful thrust.\n" +
                "\n" +
                "You can’t take it anymore, you can feel your orgasm hit like electricity through your body. You clamp your ass around Zenji’s girth and desperately suck onto Halkano’s throbbing erection. [(pc has penis) Your dick shoots several ropes of cum onto the ground beneath you.] [(pc has vagina) Your vagina joins in on the fun as well, girlcum dripping down past your lips.] You moan in pleasure as you can feel both of their dicks pulsate within you, ready to cum as well.\n" +
                "\n" +
                "Halkano is first to reach his climax. He howls loudly, growling with his deep, gravelly voice as waves of cum are poured directly down your throat. The warmth of his seed fills your stomach like soft, warm love. You gag slightly, coughing up a little cum as it’s just too much for you to swallow in a single breath. His grip on your head loosens as he holds onto you gently.\n" +
                "\n" +
                "It doesn’t take Zenji long to cum either, he howls with pleasure, gripping onto you tightly as he thrusts his length as deep as he can go into you. He presses his hips against your body, plunging himself deep into you. He grips onto you, making sure you don’t escape, making sure that you take in every last drop he has to offer and none of it spills out of you. Your stomach distends slightly by the copious amounts of cum he unloads into you.\n" +
                "\n" +
                "Soon Zenji slides out, drooling cum from your anus as Halkano retracts from you as well.\n" +
                "\n" +
                "Halkano sighs, \"Dat… wow… Zenji… I didn’t know your lover was so good at dis…\"\n" +
                "\n" +
                "Zenji grins softly, scratching the back of his head softly, \"Dey really are someting else, aren't you, [name]?\"\n" +
                "\n" +
                "You’re at a loss of words, still unable to think straight while in the presence of your lover’s embrace. Zenji maintains his grasp on you, keeping you supported with his strong arms.\n" +
                "\n" +
                "\"I tink we overdid it just a little bit, but we should do dis again.\" Zenji replies, \"Come on [name], let me take ya home ta get cleaned up.\"\n" +
                "\n" +
                "Halkano chuckles to himself, \"I’ll leave an extra tip fa de waitress for de mess.\"\n" +
                "\n" +
                "Zenji carries you home to help you clean up, making sure that nothing is forgotten at the diner before leaving.\n");
        doNext(camp.returnToCampUseOneHour);
    }
}
}
