/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage {
import classes.Scenes.Places.TrollVillage;

public class Yubi extends TrollVillageAbstractContent {
    public function Yubi() {
    }

    public function TalkWithYubi():void{
        clearOutput();
        if (!TrollVillage.YubiUnlocked){
            if (TrollVillage.ZenjiFollowing){
                outputText("Zenji speaks up, \"<i>I’ll be back, [name]. I gotta use da restroom.</i>\"\n");
            }
            outputText("You see an older troll sitting by herself, she is wearing little clothing aside from her cloak that covers her entire back and simpler garb beneath it. Her cloak is ornate, but the peasant-like rags she wears beneath almost gives her a sense of humility. She is of average height compared to other trolls and is hunched over a drink. Most notably her tusks grab your attention, they’re longer than most trolls you’ve seen so far, easily almost a foot long.\n" +
                    "\n" +
                    "She talks an exaggerated sip from the juice, \"<i>Mucho mejor.</i>\" She mutters.\n" +
                    "\n" +
                    "You decide to approach her, as you do so she continues staring intently at her drink. You sit beside her and she still doesn’t even register you.\n" +
                    "\n" +
                    "Her head slowly tilts over to you, a tired expression is plastered across her face. She speaks in a fairly slow manner, \"<i>Hello… You must be new here, I don’t recognize you. I am Yubi, the lead elder of the village. And you are..?</i>\"\n" +
                    "\n" +
                    "You tell Yubi your name.\n" +
                    "\n" +
                    "\"<i>[name]... Hmm…</i>\"\n" +
                    "\n" +
                    "She stares back at her drink. \"<i>Sorry, I’m not in the mood to chat, but it was nice speaking to you.</i>\" Her gaze doesn’t budge, she seems intent on being alone for now. \"<i>If you have any further query, I’m afraid I cannot help you at this time, perhaps later, but not now.</i>\"\n" +
                    "\n" +
                    "You decide to leave her alone for now, it appears she’s not in the mood for speaking at this hour. Once you exit the diner you consider what you want to do now.\n");
            TrollVillage.YubiUnlocked = true;
            doNext(camp.returnToCampUseOneHour);
        }
        else{
            menu();
            outputText("You see Yubi sitting by herself again, staring intently at her cup of juice. You decide to approach her.\n" +
                    "\n" +
                    "She doesn’t turn to face you, \"<i>Hello, [name]. It’s nice to see you again… Is there something you wanted to talk about?</i>\"\n");
            addButton(0,"Herself", YubiHerself);
            addButton(1,"Elders", YubiElders);
            addButton(2,"The People", YubiPeople);
        }

        function YubiHerself():void{
            clearOutput();
            outputText("You ask Yubi to tell her more about herself, how did she get to where she is now, and if she enjoys what she does.\n" +
                    "\n" +
                    "\"<i>My name is Yubi…</i>\" She sighs, \"<i>I am Chief Elder of our village. We call ourselves trolls because in the earliest days when we made this place our home, females were ill-mannered and violent. It was common for a female to cast out her scent to lure as many different men to her, this is known as trolling. I don’t know how or when, but the name stuck with us and we’ve called ourselves trolls ever since.</i>\" She takes a deep sigh, \"<i>I often miss the days I read about when we kept a large part of our drow ancestry and could turn to stone if we spent too much time in the sun... All this light is irritating, and this fur gets too hot…</i>\"\n" +
                    "\n" +
                    "Yubi shakes her head, \"<i>The title of troll has since lost its significance because it’s frowned to abuse our power over men and I keep the people in check to the best of my abilities.</i>\"    \n" +
                    "\n" +
                    "\"<i>Alas, I grew up as a descendant from a long line of elders. The title of elder isn’t inherited, it’s earned. I worked to stay in line and I do my best to keep the people happy to the best of my abilities…</i>\" Her voice trails off. \"<i>I enjoy what I do… It can be difficult to make everyone happy, but that’s why I’m not the only elder.</i>\"\n" +
                    "\n" +
                    "She stares deeply into her cup of juice. \"<i>I best get going now, [name].</i>\" She stands up without another world and leaves for her unnamed reasons.\n" +
                    "\n" +
                    "You decide to leave the diner as well.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function YubiElders():void{
            clearOutput();
            outputText("You ask Yubi about the other elders and if they’re living up to expectations and keeping things regulated with her.\n" +
                    "\n" +
                    "Yubi sighs softly, \"<i>The other elders are nice, they keep things in check with me. We have Kal’ji, he focuses mostly on the economy and social events; he's also the only man in the council. Maru, she focuses on health and resource management so the people are safe, healthy and that we have a proper amount of supplies for a new generation. Lastly, there’s Akuri, she focuses on justice and enforcing laws. I do whatever’s left really. City-planning, managing trade with outsiders and watching over the other council members among other things.</i>\"\n" +
                    "\n" +
                    "She pauses for a moment, \"<i>Everyone seems to work well together, but maybe I can’t speak for them… So far everything seems fine. Everything looks fine in my eyes at least.</i>\"\n" +
                    "\n" +
                    "Yubi sighs again, \"<i>I really should get going now.</i>\" She picks up her drink and leaves the diner with her cup.\n" +
                    "\n" +
                    "Once she’s gone you decide to leave the diner as well.\n");
            doNext(camp.returnToCampUseOneHour);
        }

        function YubiPeople():void{
            clearOutput();
            outputText("You ask Yubi how it is managing the people and how she views their society as a whole.\n" +
                    "\n" +
                    "\"<i>The people are boring, they all want the same thing and don’t enjoy change. Some people claim they want change, but I know that any significant changes will stir fear and distress in everyone. I keep things the same and try not to change anything if possible. It works and nobody cares that nothing changes anyway. We like having things simple and repetitive. I suppose people are too busy to realize how boring things can be. I have a lot more free time than people realize because I know how to get things done on time.</i>\"\n" +
                    "\n" +
                    "Yubi shrugs, still looking at her cup of juice. \"<i>Same thing, really. The people never speak up, they’re too shy anyway. Nothing changes and they like it that way, so it’s not difficult to keep people in line.</i>\"\n" +
                    "\n" +
                    "She sighs again, \"<i>I best get going now.</i>\" She picks up her drink and leaves the diner with it.\n" +
                    "\n" +
                    "Once she’s gone you decide to leave the diner as well.\n");
            doNext(camp.returnToCampUseOneHour);
        }
    }

}
}
