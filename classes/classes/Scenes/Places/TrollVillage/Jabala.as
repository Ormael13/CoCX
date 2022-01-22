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
        //TrollVillage.JabalaUnlocked = true;
        TrollVillage.ZenjiVillageStage == 1;
        doNext(camp.returnToCampUseOneHour);
    }

    public function JabalaDining():void{

    }
}
}
