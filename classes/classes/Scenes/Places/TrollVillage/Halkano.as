/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.SceneLib;

public class Halkano extends TrollVillageAbstractContent{
    public function Halkano() {
    }

    public function TalksWithHalkano():void{
        clearOutput();
        menu();
        if (TrollVillage.ZenjiVillageStage != 0 && !TrollVillage.HalkanoUnlocked){
            HalkanoNoZenji();
        }
        else{
            if (TrollVillage.ZenjiFollowing){
                outputText("Your gaze roams around to Zenji’s father, he’s sitting alone by himself.");
                if (player.lib >= 85) {
                    outputText("\nSuch a burly, muscled hunk, it’s a shame that he’s not expressing himself more openly. Maybe you could convince him to have some fun right here with you and Zenji, after all, with the effect that you have on Zenji you doubt he’d be against the idea.\n");
                    outputText("\nZenji is already aroused by being near your presence, \"<i>[name]...</i>\" He mumbles with a deep sniff, \"I know dat look you’re giving my fatha… You wanna get down wit him too, don’tcha?\"\n" +
                            "\n" +
                            "You want to, but a thought crosses your mind, do you want to right now?\n");
                    addButton(0, "Spitroast", HalkanoSpitroast);
                    addButton(1, "No", denyThisTime);
                }
                else{
                    outputText(" You ask Zenji if he would mind giving his father some company.\n");
                    outputText("\"<i>Not at all, [name]. I’m sure my fatha has plenty ta talk about, he just chooses not to.</i>\"");
                    doNext(denyThisTime);
                }
            }
            else{
            outputText("You decide to approach Halkano once you’re finished with your food. He notices you as you approach him and waves his hulking arm in a friendly gesture.\n" +
                    "\n" +
                    "\"<i>[name]. It’s good ta see ya again!</i>\" He exclaims, holding out his hand to shake yours. You politely shake his hand in return as you side beside him.\n" +
                    "\n" +
                    "\"<i>I didn’t have much of a chance ta talk de last time I met’cha, why don’t we get ta know each other a little more. Did ya have anything specific ta talk about?</i>\"\n" +
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
                    "\"<i>Ah, [name], Zenji! Good ta see da two of you again,</i>\" he exclaims, happy to have company.\n" +
                    "\n" +
                    " \"<i>How are da two lovebirds doing? I hope Zenji is treating you right,</i>\" he chortles.\n" +
                    "\n" +
                    "Zenji blushes softly as he gives you a coy grin, \"<i>I do my best, don’t I, [name]?</i>\" he replies, stroking the top of your head gently.\n" +
                    "\n" +
                    "Halkano speaks up, \"<i>It’s such a blessing ta know dat my son is with someone dat cares about him as much as I have. After all, I would be lyin’ if I said de two of you didn’t look great together. Tell me, is all well back at your place? I hope tings are alright outside of de village.</i>\"\n" +
                    "\n" +
                    "Zenji shrugs, rubbing his beard with his strong hands, \"<i>It can be difficult sometimes, but I protect [name]. Making sure nothing happens ta dem during de night… Well, noting dat’s outta my control at least.</i>\" He replies with a wink toward you. \"<i>But it is well. Our love makes us strong, we will always pull through de horrors of de outside.</i>\"\n" +
                    "\n" +
                    "Halkano gives the two of you a soft smile, \"<i>Glad ta hear da two of you are happy.</i>\"\n" +
                    "\n" +
                    "The two of you exchange stories about the time you spend together, Halkano listens intently, but after a moment he stretches, popping his joints loudly.\n" +
                    "\n" +
                    "\"<i>It was nice catching up wit da two of you, but I best get going now. Goodbye.</i>\" Halkano stands up, taking all of his belongings with him.\n" +
                    "\n" +
                    "Zenji turns to you, \"<i>Let’s get outta here den, sound good, [name]?</i>\"\n" +
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
                "He gives a nonchalant nod, \"<i>Well… Sit down, why don’tcha? It’s easier on de legs dat way. Least it is for a big guy like me.</i>\"\n" +
                "\n" +
                "You sit down beside him, noting the slight lisp he has. He shifts around slightly to face you. His ashen green eyes carefully inspect you, almost as if he were looking for something to use against you.\n" +
                "\n" +
                "He takes in a slow breath, \"<i>It’s been a while since anyone has really talked ta me I guess… ever since… well. Tings have been a little rough, but I get by with my wife.</i>\" He stirs his fork within his salad, there’s a brief moment of silence between the two of you. \"<i>Well, why don’t I introduce myself? I am Halkano,</i>\" he states as he holds out his massive, calloused hand toward you.\n" +
                "\n" +
                "You shake his hand in response, his grip strong and firm as you tell him your name.\n" +
                "\n" +
                "\"<i>Nice ta meetcha, [name],</i>\" he replies. \"<i>I’d like ta stay and chat, but… Speaking about ma wife, I just remembered dere’s someting I need ta get going back to,</i>\" he states before quickly shoveling the rest of the salad into his mouth, getting up and exiting the building.\n" +
                "\n" +
                "Seeing that there’s not much left to do now, you decide to exit the dining hall.\n");
        TrollVillage.HalkanoUnlocked = true;
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoSelfIntro():void{
        clearOutput();
        outputText("You tell Halkano that you wanted to get to know more about him, who he is, and what he does, does he enjoy his time here?\n" +
                "Halkano thinks for a moment, \"<i>It’s well, I do my best ta keep my wife happy… and well… I tink I did a little too good of a job at dat…</i>\" He gives an infatuated sigh. \"<i>Yeah... </i>\" His dopey expression shifts to dismay, \"<i>It was because my son left us, I can’t say for sure why, or what caused it, but I loved him with everyting I had to give, my heart, my soul…</i>\"\n");
                if (sceneHunter.married("Zenji")){
                    outputText(", \"<i>Tanks ta you though, Zenji is back and I’m honored ta call you family.</i>\"\n");
                }
                outputText("\"<i>Aside from dat though,</i>\" He sighs, \"<i>I am a carpenter, I like what I do and I’m good at it. Good wit my hands, years and years of practice and hard work does pay off.</i>\"\n" +
                "Halkano bites his lip softly, \"</i>Hmm, I guess I’m not really used ta talking dis much, nobody really talks ta me besides my wife anyway.</i>\" He gives you a firm pat on the shoulder, \"<i>Good talk, [name]. Bye.</i>\"\n" +
                "\n" +
                "He packs up his things and leaves as you say your farewells. You decide to exit the dining hall since there’s nothing left for you at this time now\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoLocals():void{
        clearOutput();
        outputText("You tell Halkano that you wanted to get to know more about the people of the village. After all, he must work with them to some degree, right?\n" +
                "\n" +
                "Halkano shrugs, \"<i>Tings have just been quiet lately. Wit all de tings going on right now, I get de feeling dat dey’re almost intimidated by how big I am. Dey know dat I’ve been going through some rough times and I guess dey just didn’t wanna poke de bear.</i>\"\n" +
                "\n" +
                "His gaze averts as he rolls his head around, popping his joints. \"<i>But… Before dat even, nobody talked ta me, I just neva had anyting ta talk about really. At least, noting I wanna talk about ta anyone but ma wife. De two of us are close, so very close to one another. It’s a long story on how we met… Oh, Jabala…</i>\" He sighs wistfully. \"I can talk about dat another time. Just go out and talk to de people yourself. Most trolls are nice ta talk to, dey won’t bite.\"\n" +
                "\n" +
                "Halkano finishes his food, \"<i>Well, I best get going home now, it was nice chatting wit ya. [name].\" He gets up and leaves with all of his belongings. With nothing left to do, you exit the dining hall for now.</i>\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoJabala():void{
        clearOutput();
        outputText("You wanted Halkano to tell you more about his wife, after all, he appears to be extremely fond of her.\n" +
                "\n" +
                "Halkano blushes softly, \"<i>Mhmm…</i>\" He sighs, taking in an exaggerated pause. \"<i>She really is someting, so strong and determined, always willing to express how she feels and ready ta do what she wants when she wants it. Marae knows how much I may try ta resist her charm, but she’s an unstoppable force of love and compassion. She also knows me too well.</i>\"\n" +
                "\n" +
                "\"<i>I still remember de first time we met, 21 years ago…</i>\" he enthuses. \"<i>I was only 20 at de time, she would be 23. I may not have been as strong as I am now, in fact, I was very soft. She wanted me to build her a garden so she could work on someting personal, being a farmer she liked working wit de greens, but she also wanted someting more personal. When I got dere, she wanted a hands-on approach wit what she wanted me to do. She was very specific and driven, everyting had ta be perfect, and I had no qualms wit doing my job de best way I could. But as she worked next ta me, well… I know de ladies are told ta keep deir emotions to demselves unless it’s fa someone special ta dem… I guess I was special ta her. Dat scent, de smell, so distinct, so enthralling. I got to work, and it was not on de garden. We did finish de garden together, and well… We got along well. Nearly a year later we had our first child together, we loved him with all our hearts as well.</i>\"\n" +
                "\n" +
                "Halkano blushes harder now. \"<i>I… I need ta go now, bye.</i>\"\n" +
                "\n" +
                "He adjusts himself before standing up and leaving a little food on the table... It's as if he's hiding something within his pants. Once he’s gone you decide to leave the dining hall for the time being.\n");
        doNext(camp.returnToCampUseOneHour);
    }

    private function HalkanoSpitroast():void{
        clearOutput();
        outputText("You tell Zenji that you want to be pinned between him and his father, you want both of them inside you, one way or the other.\n" +
                "\n" +
                "Zenji gives you a sultry lick of appreciation across your cheek. \"<i>I was hoping you’d say dat.</i>\"\n" +
                "\n" +
                "The two of you approach Halkano, as you near he gives a gentle wave, but a look of concern smears across his face as the two of you grow near. He sniffs the air intently, \"Dat smell… Zenji… [name]... What… What are de two of you planning..?\"\n" +
                "\n" +
                "He sniffs the air intently again, obviously aroused by your presence. His gaze averts from you as he grows increasingly flustered.\n" +
                "\n" +
                "\"So dad…\" Zenji smirks, \"<i>How about ya get ta know [name] on a… personal level wit me..?</i>\"\n" +
                "\n" +
                "Halkano gives a worried grin, \"<i>Zenji… is dis really what [name] has done ta ya..? Is dis de effect dey have on you..?</i>\"\n" +
                "\n" +
                "\"<i>It’s all good, dad. I love [name]. They’ve only helped me discover who I am. Now I want ta share dem wit you, right here, right now.</i>\"\n" +
                "\n" +
                "Halkano chuckles nervously, but you can already see him beginning to sport an erection.\n" +
                "\n" +
                "He shakes his head, smirking softly, \"<i>Why not, you seem so insistent, is dis whatchu want, [name].</i>\"\n" +
                "\n" +
                "You assure him that you want to be taken between the two of them.\n" +
                "\n" +
                "Zenji doesn’t even bother surveying his surroundings as he strips himself from his loincloth, revealing his raging erection. \"<i>I’ve been waiting for dis…</i>\" he growls.\n" +
                "\n" +
                "You take a glance around, there are not many people in the diner, around 5 people including the waitress is in the room currently.\n");
        if (player.isNaked()){
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
        outputText("He rests his dick across your face, prodding at your lips. \"<i>Looks like you’ve trained dem a lot for dis,</i>\" he chuckles.\n" +
                "\n" +
                "\"<i>Dey wanted dis, who am I ta deny dem of what dey want, right? Besides, dis was their idea anyway.</i>\" Zenji replies.\n" +
                "\n" +
                "You reach your hand up to Halkano, guiding his length to your lips, licking the tip of his dick.\n" +
                "\n" +
                "Zenji prods at your backdoor, sliding his length between your cheeks. He slavers onto his shaft, lubricating himself for you as he coats his length in his drool. Once he’s sufficiently slicked, he drives himself into your rear.\n\n");
        if (player.analCapacity() < 7){
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
                "\"<i>Zenji…</i>\" Halkano mutters, but Zenji only gives him a quiet growl in response. He locks his lips with his father, rubbing his beard against him. Zenji gives a low moan as he makes out with his dad. Halkano growls quietly in pleasure as well as he sinks into his son’s advance.\n\n");
        if (silly()){
            outputText("You hear someone in the distance shout toward you.\n" +
                    "\n" +
                    "\"<i>Wait a minute... You don't have pants on? Are you guys fucking?! Are you serious?! Right in front of my salad?!</i>\"\n" +
                    "\n" +
                    "You see the waitress entering the room out of the corner of your eye. She takes a long pause, staring directly at the three of you.\n" +
                    "\n" +
                    "She takes a deep sigh, \"<i>You know what? I don’t get paid enough for this. That is not my job.</i>\" She mutters before leaving.\n\n");
        }
        outputText("You feel drops of precum emerge from the tip of Halkano’s manhood, the salty, savory taste tingles your taste buds as he thrusts into you. You wrap your arm around Halkano for support, doing your best to fit more of his length into your mouth as you suck him off to the best of your abilities.\n" +
                "\n" +
                "It’s so difficult to concentrate on anything as Zenji is simultaneously fucking your brains out. You clench your sphincter around his length, his girthy cock presses deeper into your backdoor, filling you so deliciously, you lose control of yourself as you’re completely held by the two of them.\n" +
                "\n" +
                "You gag slightly as Halkano pushes his entire length down your throat, his meaty cock now dripping pre directly down your stomach. You can hear the two of them growl above you. You moan softly, turned on by their overwhelming presence, their enthralling musk, their soft gentle fur, their massive, muscular bodies are both yours.\n" +
                "\n" +
                "Eventually, Halkano breaks the kiss from his son, turning his attention back to you. He grabs the back of your head, forcefully pulling you over his cock, bobbing your head up and down his length for you. Zenji doesn’t give you a break either, gripping onto your hips tighter, pulling you closer to him with each powerful thrust.\n" +
                "\n" +
                "You can’t take it anymore, you can feel your orgasm hit like electricity through your body. You clamp your ass around Zenji’s girth and desperately suck onto Halkano’s throbbing erection. ");
        if (player.hasCock()) {
            outputText("Your dick shoots several ropes of cum onto the ground beneath you.")
        }
        if (player.hasVagina()){
            outputText(" Your vagina joins in on the fun as well, girlcum dripping down past your lips.")
        }
        outputText("You moan in pleasure as you can feel both of their dicks pulsate within you, ready to cum as well.\n" +
                "Halkano is first to reach his climax. He howls loudly, growling with his deep, gravelly voice as waves of cum are poured directly down your throat. The warmth of his seed fills your stomach like soft, warm love. You gag slightly, coughing up a little cum as it’s just too much for you to swallow in a single breath. His grip on your head loosens as he holds onto you gently.\n" +
                "\n" +
                "It doesn’t take Zenji long to cum either, he howls with pleasure, gripping onto you tightly as he thrusts his length as deep as he can go into you. He presses his hips against your body, plunging himself deep into you. He grips onto you, making sure you don’t escape, making sure that you take in every last drop he has to offer and none of it spills out of you. Your stomach distends slightly by the copious amounts of cum he unloads into you.\n" +
                "\n" +
                "Soon Zenji slides out, drooling cum from your anus as Halkano retracts from you as well.\n" +
                "\n" +
                "Halkano sighs, \"<i>Dat… wow… Zenji… I didn’t know your lover was so good at dis…</i>\"\n" +
                "\n" +
                "Zenji grins softly, scratching the back of his head softly, \"<i>You really are someting else, aren't you, [name]?</i>\"\n" +
                "\n" +
                "You’re at a loss of words, still unable to think straight while in the presence of your lover’s embrace. Zenji maintains his grasp on you, keeping you supported with his strong arms.\n" +
                "\n" +
                "\"<i>I tink we overdid it just a little bit, but we should do dis again.</i>\" Zenji replies, \"<i>Come on [name], let me take ya home ta get cleaned up.</i>\"\n" +
                "\n" +
                "Halkano chuckles to himself, \"<i>I’ll leave an extra tip fa de waitress for de mess.</i>\"\n" +
                "\n" +
                "Zenji carries you home to help you clean up, making sure that nothing is forgotten at the diner before leaving.\n");
                        player.refillHunger(100);
        statScreenRefresh();
        doNext(camp.returnToCampUseOneHour);
    }

    public function HalkanoAppearance():void{
        clearOutput();
        outputText("He is an 8’6\" tall male troll with a massive, portly build and ashen green fur. His face is chiseled and handsome, as many trolls are. His short, trimmed hair is grey and neatly combed. His face is symmetrical with deep-set almond eyes. He has a bushy, murky green beard that covers his entire jaw. Two tusks protrude from his mouth, each about 10 inches long.\n" +
                "\n" +
                "His body is very muscular with considerable heft. His bare chest is chunky and beefy, almost invitingly comfortable with his soft fur. He is currently only wearing fur pants that cover his lower body and legs, held up by a silky sash. He has the average features you’d expect on a male troll. Toned and muscular arms and legs, each supporting 4 fingers or toes. A fuzzy tail, about 3 feet long, as well as fur covering his entire body.\n" +
                "\n" +
                "Halkano gives a polite smile as you eye him up and down.\n");
        doNext(SceneLib.trollVillage.jabala.JabalaHalkanoTalk);
    }

    public function JHalkanoSexScenes():void{
        clearOutput();
        outputText("You ask Halkano if he’s willing to get a little intimate with you. Such a strong, handsome troll deserves to have some fun once in a while.\n" +
                "\n" +
                "Halkanao’s brow narrows, \"<i>Are… are ya really asking ta get down wit a married man?</i>\"\n" +
                "\n" +
                "You tell him as long as he’s okay with it.\n" +
                "\n" +
                "\"<i>I dunno…</i>\" Halkano responds nervously\n" +
                "\n" +
                "You shout to the backyard where Jabala is tending to her plants carefully. You ask if it’s okay to spend some quality alone time with her husband.\n" +
                "\n" +
                "\"<i>Stay safe!</i>\" You hear Jabala shout back reflexively, obviously not paying attention.\n" +
                "\n" +
                "Halkano still seems nervous about disgracing his faith. You assure him that it’s fine, in this world, it could be far worse. At least you’re not an evil demon.\n" +
                "\n" +
                "Halkano relaxes slightly, \"<i>Well… she seemed okay wit it… Shall we go to de bedroom..?</i>\"\n" +
                "\n" +
                "Halkano holds out his massive hand, you take his grasp as he guides you to the bedroom.\n" +
                "\n" +
                "Once the two of you are inside he sheepishly removes his pants, unveiling all 14 inches of his uncut, meaty troll girth. It’s about 2 and a half inches wide as well.\n" +
                "\n" +
                "\"<i>I’ve… I’ve neva done dis wit anyone else but my wife before… What makes you tink I’m so special..?</i>\"\n" +
                "\n" +
                "\n");
                if (!player.isNaked()){
                    outputText("\"You begin to undress, making sure that nothing is concealed from him.");
                }
                outputText("You tell him that a handsome lad such as himself deserves some appreciation and you wanted to be able to show you how much you appreciate his presence. [(pc has clothes) Your clothes fall to the floor with a soft thud.] You approach him with a coy smile, encroaching on his personal space.\n" +
                "Halkano blushes, still nervous. \"<i>Well…</i>\"\n" +
                "\n" +
                "You press your body against his burly figure, bringing a hand up to his lips and silencing him softly. You gently push him back until he falls back onto his bed, he’s lying down as you straddle him.\n");
        if (player.hasVagina()){
            outputText("Halkano speaks softly, still blushing \"<i>Please, [name]... I… No vaginal stuff… I… I can’t do dat to my wife...</i>\"");
        }
        outputText("You consider what you want to do with him.");
        menu();
        addButton(0,"Blow Him", HalkanoBlown);
        addButton(1,"Ride Anal", HalkanoAnal);

        function HalkanoBlown():void{
            outputText("You decide a little reward is in order for such a hunk. You slide off of his body and kneel at the side of the bed where his strong legs are resting against the bed, feet still on the ground.\n" +
                    "\n" +
                    "He spreads his legs aside for you, giving you a chance to get closer to his rising erection. He sits up and gives you a worried glance.\n" +
                    "\n" +
                    "\"<i>Oh… You… Ya just wanted ta service me dis time…</i>\"\n" +
                    "\n" +
                    "You smile at him as you bring yourself closer to his shaft, already at full mast. You reach your hand toward the base of his length, gently cupping his hefty balls. He has considerable heft to himself, virile as you’ve come to expect from trolls.\n" +
                    "\n" +
                    "You bring your tongue to the tip of his mouth as your other hand gently slides around the base of his length.\n" +
                    "\n" +
                    "Halkano moans softly and you’re met with a steady stream of precum leaking from the tip of his length. The salty taste of his seed instills you with purpose as you carry on with servicing him. You wrap your tongue beneath his foreskin, lapping up around his sensitive head as you coax more pre onto your tongue.\n" +
                    "\n" +
                    "Halkano growls contentedly, \"<i>So good… How are you so good…</i>\"\n" +
                    "\n" +
                    "You move your tongue to the underside of his head as you press your lips at his tip. You bob your head down, inching more of his girthy erection into your mouth as you try to blow his entire length.\n" +
                    "\n" +
                    "You force more of his length into you as Halkano growls softly in satisfaction. He shifts his hand to the back of your head, softly pushing you into his crotch as you bury your face deeper down his length. His legs shift around as well, brushing against you, almost trying to keep you trapped between him, but they don’t close around you.\n" +
                    "\n" +
                    "He presses your head down with a firm push as you manage to swallow the entirety of his girth, his precum now dripping directly down your throat.\n" +
                    "\n" +
                    "\"<i>Mmm…</i>\" he growls, \"<i>Getting... closer... Keep going...</i>\"\n" +
                    "\n" +
                    "As if you had any other options. You circle your tongue around his length, trying to coat every inch of his massive length with your mouth as you gently suck on him with more force. You feel his girth begin to convulse, twitching and pulsing within your throat, ready to burst at any given moment.\n" +
                    "\n" +
                    "Halkano moans loudly, bucking into you as he cums, shooting waves of his seed directly into your stomach. He growls again as his body begins to relax as he continuously cums into your awaiting stomach.\n" +
                    "\n" +
                    "You lap up his cum contentedly, making sure that not a single drop escapes you. You feel so full after the event, Halkano is still virile as ever.\n" +
                    "\n" +
                    "He gently pats the top of your head, \"<i>Dat… Dat was really good, [name]... I… Uh, tanks… You really should leave now though…</i>\"\n" +
                    "\n" +
                    "You pack up your things and leave following his wishes, but not before he gives you a brief hug in his warm embrace.\n");
                                player.refillHunger(100);
            statScreenRefresh();
            doNext(camp.returnToCampUseOneHour);
        }

        function HalkanoAnal():void{
            outputText("Given your position over him, you tell him that you’re gonna take him for a ride.\n" +
                    "\n" +
                    "Halkano shifts, slightly discomforted beneath you. He brings his legs onto the bed, lying propped up against the head of the bed, depressing the mattress slightly with his considerable weight.\n" +
                    "\n" +
                    "You bring your hand down to his girth, he’s already leaking precum at the thought of penetrating your backdoor.\n" +
                    "\n" +
                    "\"<i>[name]... Please… please put it in…</i>\" he begs, reaching his dense hand toward his length, rubbing his pre over himself, lubing up for you.\n" +
                    "\n" +
                    "You hover over his backdoor, teasing the tip of his length with your behind.\n" +
                    "\n" +
                    "Halkano grabs onto your hips with his firm hands, pulling you down onto him. You gasp slightly in surprise, but he’s needy for you now.\n");
            if (player.analCapacity() < 7){
                outputText("His lengthy shaft presses its way deep inside of your tight backdoor, you feel yourself stretch over his massive manhood.\n");
            }
            else if (player.analCapacity() < 55){
                outputText("His lengthy shaft presses into you, you can feel him accommodating your ass as he presses further and further with each thrust\n");
            }
            else{
                outputText("His lengthy shaft presses into you, you can feel him press into your roomy backside as he presses deeper into you with each thrust.\n");
            }
            outputText("You moan softly as he clutches onto your waist, pulling you up and down his girthy pecker. He bucks into you, trying to fit more of his length into your backdoor as you bounce atop him.\n" +
                    "\n" +
                    "You can feel the warmth of his pre seep into your rear, lubricating your further and allowing his shaft to slide into you with ease. Halkano begins growling softly, getting closer to his climax.\n" +
                    "\n" +
                    "You can feel yourself getting closer to the edge as well, being pushed into further pleasure by the occasional twitch of his massive length being buried deeper into your hole.\n" +
                    "\n" +
                    "You moan in pleasure, leaning down over him, pressing your body against his burly torso. You hold onto him tightly as he continues pounding away at you.\n" +
                    "\n" +
                    "Your body is pressed against the soothing warmth of his fur and you can feel yourself getting closer. You cry in pleasure as your orgasm hits. \n");
            if (player.hasVagina()){
                outputText("Girlcum leaks from your vagina, spilling out past your lips and onto him.\n");
            }
            if (player.hasCock()){
                outputText("Your erection twitches before finally cumming, spraying jizz all over his chest.\n");
            }
            outputText("Halkano growls louder, clutching onto you tightly as he cums. Jets of his warm seed shoot into your back door. You clench your sphincter over his throbbing girth, trying to milk him of everything he has to offer you. His orgasm is aggressive, you couldn’t hope to take all the cum he has to offer.\n" +
                    "\n" +
                    "Halkano slowly relaxes as you relax atop him. \"<i>Dat… I… You really are someting, I still don’t know what you see in me dat’s so special.</i>\"\n" +
                    "\n" +
                    "You smile at him in response, he’s just a very attractive dad.\n" +
                    "\n" +
                    "Halkano blushes softly. After a moment of respite together he helps clean you up.\n" +
                    "\n" +
                    "Once you’re cleaned you take your things and exit the hut. Halkano still seems a little nervous around you.\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }
}
}
