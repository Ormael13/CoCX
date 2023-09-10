/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage {
import classes.Scenes.Places.TrollVillage;
public class Kuru extends TrollVillageAbstractContent{
    public function Kuru() {
    }
    public function KuruDining():void{
        clearOutput();
        if (TrollVillage.ZenjiFollowing) outputText("\"<i>Ah, sorry, [name]. I need ta use the restroom, I’ll be back in a bit.</i>\"\n" +
                "\n" +
                "He gives you a brief kiss on the cheek before excusing himself.\n");
        if (!TrollVillage.KuruUnlocked){
            outputText("While waiting around, you flag down the waitress as she passes by your table, feeling that you could get to know her in the idle time. She looks at you earnestly, but despite her serious tone, there’s a hint of comfort in her presence.\n\n");
            outputText("You want to get to know the people around the village, and she seemed like a pleasant person to talk to.\n\n");
            outputText("\"<i>My name is Kuru</i>\" She replies with a soft grin, \"<i>It’s been a fairly calm life, nothing too special. My parents are the chefs here and I work around the hall.</i>\"\n\n");
            outputText("Kuru looks around idly for a moment, \"<i>I don’t know. Things are nice, I wouldn’t really have it any other way. My parents love me and I feel comfortable with what I do.</i>\" Kuru takes a sip of water from a small canteen on her hip. \"<i>What about you, are you comfortable with how things are going in your life?</i>\"\n\n");
            outputText("You think about her question, the memory of everything you’ve done so far, all the things that led you up to this moment. It has not been a bad journey, you’ve met some rather nice people after all. You tell her that things are going well, all things considered.\n\n");
            outputText("\"<i>That’s nice, glad to hear that all is well. I hope you’re enjoying the village too.</i>\" Kuru replies\n\n");
            outputText("You tell her that it is nice and you’re glad to enjoy some company that’s as good as hers.\n\n");
            outputText("Kuru gives you a warm smile, \"<i>Cool, thanks, I must get back to work now though. Bye.</i>\"\n\n");
            outputText("She unceremoniously stands up and leaves you alone for the time being. You exit the dining hall once you’ve decided there’s nothing left for you at this time.\n\n");
            TrollVillage.KuruUnlocked = true;
            KuruExitDialogue();
        }
        else{
            outputText("While waiting around, you flag down Kuru, the waitress as she passes by your table, feeling that you could get to know her in the idle time. She looks at you earnestly, but despite her serious tone, there’s a hint of comfort in her presence.\n" +
                    "\n" +
                    "\"<i>You wanted something?</i>\"\n" +
                    "\n" +
                    "You tell the waitress that she seemed like a pleasant person, and you just wanted to talk to her.\n" +
                    "\n" +
                    "The waitress glances around the hall, before turning her attention to you. \"<i>Alright, I have some time to spare, what did you want to talk about?</i>\"\n" +
                    "\n");
            menu();
            addButton(0, "Herself", KuruSelfIntro);
            addButton(1, "Her Job", KuruJob);
            addButton(2, "The People", KuruLocals);
        }
    }

    private function KuruSelfIntro():void{
        clearOutput();
        outputText("You want to get to know more about her, who is Kuru and what does she do?\n" +
                "\n" +
                "Kuru looks around idly for a moment, \"<i>I don’t know. Things have been going well lately, I wouldn’t really have it any other way. My parents love me and I feel comfortable with what I do.</i>\" Kuru takes a sip of water from a small canteen on her hip.\n" +
                "\n" +
                "\"<i>Business is the same as always, nothing special about it honestly. I know I will grow up to take care of the dining hall, it is a very nice place after all. I wouldn’t change a thing about it.</i>\"\n" +
                "\n" +
                "You tell her that’s good to hear, you’re glad she enjoys what she does.\n" +
                "\n" +
                "Kuru gives you a warm smile, \"<i>Cool, thanks, I must get back to work now though. Bye.</i>\"\n");
        outputText("She unceremoniously stands up and leaves you alone for the time being. You exit the dining hall once you’ve decided there’s nothing left for you at this time.\n\n");
        KuruExitDialogue();
    }

    private function KuruJob():void{
        outputText("You want to get to know how she feels about working here, how she does it, and what it’s like dealing with the people.\n" +
                "\n" +
                "\"<i>It’s all well,</i>\" she replies, placing a platter full of glasses on the table and sitting down. \"<i>Most people are very pleasant and besides, we’re all trying to get back to business. For many, there’s not too much time to socialize, so it’s best to finish your food and get back to work.</i>\"\n" +
                "\n" +
                "Kuru glances around nervously, \"<i>There is this one guy… I’m not saying names, but I swear, he’s out there… hunting for his next victim every time he eats. I’ve seen the way he eyes other guys, why other guys specifically?</i>\" She shakes her head. \"<i>Other than that creep, it’s calm and actually rather pleasant dealing with other people, sometimes they have something exciting that happened earlier today.</i>\"\n" +
                "\n" +
                "\"<i>I still remember when my parents told me it was time I learned how to manage the dining hall, cleaning up, and interacting with the others. I was so scared, but it was actually easy since I knew most of the people, I didn’t need to be nervous around them.</i>\"\n" +
                "\n" +
                "Kuru glances at the platter beside the table again. \"<i>I must get back to work now though, bye.</i>\"\n" +
                "\n" +
                "She quickly stands up, picking up her things before leaving you.\n");
        KuruExitDialogue();
    }

    private function KuruLocals():void{
        outputText("You want to get to know more about the people in the village. After all, being the waitress of the dining hall she must have heard many interesting stories and tales from the other trolls and have a good sense of the people around the village. \n" +
                "\n" +
                "\"<i>The people here are nice,</i>\" Kuru replies, placing the platter on the table and sitting beside you. \"<i>It can be a little hectic at times. Plenty of people are trying to do things quickly to get back to their business, whatever it may be. What do they do in their free time I’m not sure. I’m just cleaning the tables and serving the food my parents prepare.</i>\"\n" +
                "\n" +
                "\"<i>I must say though,</i>\" she states, giving a nervous glance around the room, \"<i>While most trolls are calm and peaceful, that only makes the worst seem worse. Trust me, there are some nasty people even in this village, but we can’t do anything about it because everyone serves an important role, no matter how small it may seem.</i>\"\n" +
                "\n" +
                "Kuru looks at the platter on the table again. \"<i>Speaking of which, I best get back to my job, after all, the food won't serve itself.</i>\"\n" +
                "\n" +
                "She quickly stands up, picking up her things before leaving you.\n");
        KuruExitDialogue();
    }

    public function KuruExitDialogue():void{
        if (TrollVillage.ZenjiFollowing){
            outputText("After another minute Zenji returns.\n" +
                    "\n" +
                    "\"<i>Alright, let's get going back ta camp, sound good, [name]?</i>\"\n" +
                    "\n" +
                    "You nod, deciding it’s about time to go back home with your lover.\n");
        }
        else{
            outputText("You decide to head home for the time being\n");
        }
        endEncounter();
    }
}
}
