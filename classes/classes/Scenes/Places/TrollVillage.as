/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */

package classes.Scenes.Places {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.TrollVillage.*;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;

public class TrollVillage extends BaseContent implements SaveableState{
    public var diningHalls:DiningHalls = new DiningHalls();
    public var jabala:Jabala = new Jabala();
    public var kuru:Kuru = new Kuru();
    public var yubi:Yubi = new Yubi();
    public var halkano:Halkano = new Halkano();
    public var kalji:Kalji = new Kalji();
    public var yenza:Yenza = new Yenza();
    public var elderstore:ElderStoreHut = new ElderStoreHut();

    public static var ZenjiVillageStage:Number;    //0 = Initstate, 1 = ZenjiCompanion Intro Complete, 2 = Zenji forgives you, 3 = Consolation, 4 = Opening up to problems , 5 = Marriage, -1 = Banished. 0.5 might be needed for found but no Zenji yet.
    public static var ZenjiFollowing:Boolean;
    public static var ZenjiBerated:Boolean;
    public static var YenzaLockdown:int;
    public static var ZenjiTrollVillageTimeChk:Number;
    public static var YenzaUnlocked:int;
    public static var JabalaUnlocked:Boolean;
    public static var KaljiUnlocked:int;
    public static var KuruUnlocked:Boolean;
    public static var HalkanoUnlocked:Boolean;
    public static var YubiUnlocked:Boolean;
    public static var KaljiMBJDeny:int;
    public static var ZenjiMoneyHelp:int;
    public static var JabalaLoveChat:Boolean;
    public static var ZenjiSleep:Boolean;
    public static var ZenjiMarriageDress:int;

    public function stateObjectName():String {
        return "TrollVillage";
    }
    public function resetState():void {
        ZenjiVillageStage = 0;
        ZenjiFollowing = false;
        ZenjiBerated = false;
        YenzaLockdown = 0;
        ZenjiTrollVillageTimeChk = 0;
        YenzaUnlocked = 0;
        JabalaUnlocked = false;
        KaljiUnlocked = 0;
        KuruUnlocked = false;
        HalkanoUnlocked = false;
        YubiUnlocked = false;
        KaljiMBJDeny = 0;
        ZenjiMoneyHelp = 0;
        JabalaLoveChat = false;
        ZenjiSleep = false;
        ZenjiMarriageDress = 0;

    }
    public function saveToObject():Object {
        return{
            "ZenjiVillageStage": ZenjiVillageStage,
            "JabalaUnlocked": JabalaUnlocked,
            "YenzaUnlocked": YenzaUnlocked,
            "KaljiUnlocked": KaljiUnlocked,
            "ZenjiFollowing": ZenjiFollowing,
            "KuruUnlocked": KuruUnlocked,
            "HalkanoUnlocked": HalkanoUnlocked,
            "ZenjiBerated": ZenjiBerated,
            "YenzaLockdown": YenzaLockdown,
            "ZenjiTrollVillageTimeChk": ZenjiTrollVillageTimeChk,
            "YubiUnlocked": YubiUnlocked,
            "KaljiMBJDeny": KaljiMBJDeny,
            "ZenjiMoneyHelp": ZenjiMoneyHelp,
            "JabalaLoveChat": JabalaLoveChat,
            "ZenjiSleep": ZenjiSleep,
            "ZenjiMarriageDress": ZenjiMarriageDress
        };
    }
    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            ZenjiVillageStage = o["ZenjiVillageStage"];
            JabalaUnlocked = o["JabalaUnlocked"];
            YenzaUnlocked = o["YenzaUnlocked"];
            KaljiUnlocked = o["KaljiUnlocked"];
            ZenjiFollowing = o["ZenjiFollowing"];
            KuruUnlocked = o["KuruUnlocked"];
            HalkanoUnlocked = o["HalkanoUnlocked"];
            ZenjiBerated = o["ZenjiBerated"];
            YenzaLockdown = o["YenzaLockdown"];
            YubiUnlocked = o["YubiUnlocked"];
            KaljiMBJDeny = o["KaljiMBJDeny"];
            ZenjiTrollVillageTimeChk = o["ZenjiTrollVillageTimeChk"];
            ZenjiMoneyHelp = o["ZenjiMoneyHelp"];
            JabalaLoveChat = o["JabalaLoveChat"];
            ZenjiSleep = o["ZenjiSleep"];
            ZenjiMarriageDress = o["ZenjiMarriageDress"];
        } else {
            // loading from old save
            resetState();
        }
    }

    public function TrollVillage() {
        Saves.registerSaveableState(this);
    }

    public function FirstEncountersoftheTrollKind():void{
        clearOutput();
        menu();
        outputText("As you are exploring you come across a jungle, upon closer inspection you see a clearing and what appears to be a cut-out trail. You hear some idle chatter as you quietly make your way closer. You don’t get too much closer until a guard quickly spots and halts you.\n" +
                "\n" +
                "The Guard stands tall, easily over 7 feet, he is covered in green fur and is wearing simple leather armor. He has tusks protruding from his mouth, but his features are fairly handsome all things considered.\n" +
                "\n" +
                "One of the guards peers at you, he is relaxed, but watching you carefully.\n");
        if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji" || flags[kFLAGS.PLAYER_COMPANION_2] == "Zenji" || flags[kFLAGS.PLAYER_COMPANION_3] == "Zenji"){
            outputText("Zenji steps forward, \"Hello, Suul…\"\n" +
                    "\n" +
                    "The guard’s brow furrows, \"Zenji? It’s been some time… You have been gone for a while, you didn’t even say why.\"\n" +
                    "\n" +
                    "Zenji shakes his head, \"I don’t want ta talk about it… But I am here now… with my lover, [name].\"\n" +
                    "\n" +
                    "Suul raises an eyebrow as he turns his attention toward you again.\n" +
                    "\n" +
                    "\"Hmm, never thought you’d want to… you know… after Yenza… Never mind, you may enter.\"\n");
            addButton(0, "Enter Village",EnterTheVillage,true);
        }
        else{
            if (player.cor > 66 + player.corruptionTolerance){
                outputText("His brow furrows, \"You corrupted don’t belong here… Leave now.\"\n" +
                        "\n" +
                        "You look around, there are far too many trolls for you to handle. More and more trolls turn their attention to you as you decide to take your leave.\n");
                doNext(explorer.done);
            }
            else{
                outputText("His brow furrows, \"Why are you here, what do you want from the trolls?\"\n" +
                        "\n" +
                        "You state that you’ve been exploring around and thought that you could take a moment to rest here.\n" +
                        "\n" +
                        "The guard remains fixated on you, \"You may enter, but if you cause a ruckus then we’ll be forced to escort you out.\"\n");
                addButton(0, "Enter Village",EnterTheVillage,true);
            }
        }
    }

    public function EnterTheVillage(firsttime:Boolean = false):void{
        clearOutput();
        menu();
        var lockVillage:Boolean = false;
        ZenjiFollowing = (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji");
        if (firsttime){
            outputText("You emerge at the troll village, the guard gives you a stern look but doesn’t obstruct you as you enter.\n");
        }
        else{
            if (player.cor > 66 + player.corruptionTolerance){
                outputText("You emerge at the troll village once again, the guard jabs his spear in your direction. \"Get back!\" he shouts \"You are outnumbered, leave this place!\"\n" +
                        "\n" +
                        "Not wanting to provoke the wrath of the entire village, you decide that the best course of action is to leave.\n");
                endEncounter();
                lockVillage = true;
            }
            else{
                outputText("You emerge at the troll village once again, the guard gives you a stern look but doesn’t obstruct you as you enter.\n");
            }
        }
        if (!lockVillage){
            if (ZenjiFollowing && (ZenjiVillageStage == 0 || ZenjiVillageStage == 0.5)){
                SceneLib.trollVillage.jabala.MeetTheParents();
            }
            else{
                outputText("You look around the troll village, it’s quiet and there’s a bunch of trolls conversing with each other, not paying too much attention to you.\n");
                outputText("You look at the large hall with a Chimney on it, the smell of food emanating from it.\n");
                outputText("The Elder’s hut stands tall, you can probably talk to someone there.\n");
                if (JabalaUnlocked) outputText("You can meet with Jabala and her husband if you like.\n");
                if (YenzaUnlocked > 0) outputText("You remember where Yenza’s hut is.\n");
                if (KaljiUnlocked) outputText("You can meet Kal’ji at his personal hut.\n");
                if (ZenjiVillageStage == 0) ZenjiVillageStage = 0.5;
                var zenjiPreCheck:String = (ZenjiVillageStage < 1)?"Look for the nice couple":"Look for Zenji's Parents";
                addButton(0,"Dining Hall", SceneLib.trollVillage.diningHalls.GrabABite2Eat).hint("Catch a bite to eat.");
                addButton(1,"Elder's Hut", SceneLib.trollVillage.elderstore.ElderShops).hint("Look for the elder of the village.");
                addButton(2,(JabalaUnlocked && !ZenjiBerated)?"Jabala's Hut":"???", SceneLib.trollVillage.jabala.JabalaHome).hint(zenjiPreCheck).disableIf((!JabalaUnlocked && ZenjiBerated),  "You don't want to disturb the nice couple.");
                addButton(3,(YenzaUnlocked > 0)?"Yenza's Hut":"???", SceneLib.trollVillage.yenza.YenzaHome).hint("Look for Yenza").disableIf((YenzaUnlocked == 0),"You don't know who lives there.");
                addButton(4,(KaljiUnlocked == 5)?"Kalji's Hut":"???", SceneLib.trollVillage.kalji.KaljiHome).disableIf(KaljiUnlocked != 5);
                addButton(14, "Return", explorer.done);
            }
        }
    }
    }
}
