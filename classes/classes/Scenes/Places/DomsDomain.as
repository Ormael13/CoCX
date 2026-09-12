package classes.Scenes.Places {
import classes.*;
import classes.GlobalFlags.*;
import classes.Items.*;
import classes.Scenes.Areas.Forest.Akbal;
import classes.Scenes.NPCs.CeraphFollowerScene;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.Dungeons.DemonLab;
import coc.view.MainView;
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Saves;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Items.MutationsHelper;
import classes.Transformations.Transformations.*;
import classes.Transformations.TransformationLib;
import classes.Appearance;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Eyes;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Races;
import classes.Races.*;
import classes.Scenes.SceneLib;
import classes.internals.Utils;
use namespace CoC;

public class DomsDomain extends BaseContent implements SaveableState, TimeAwareInterface {
    public static var domenabled:Boolean;
    public static var whosincharge:int; //0 for Ceraph, 1 for Meila, 2 for Nolan, 3 for Submissive Ceraph
    public static var CeraphDominance:int; //how dominant Ceraph is seen by other demons
    public static var CeraphState:int; // 0 for unseen, 1 for seen, 2 for cowed, 3 for enslaved by Meila, 4 enslaved by Nolan/Jabba
    public static var MeilaState:int; //0 for unseen, 1 for seen, 2 for in charge
    public static var MeilaTrust:int; //0-100
    public static var Playerdominance:int; //0-100. Player's perceived dominance in the domain. Increases or decreases the likelihood of certain events happening
    public static var NolanState:int; // 0 for unseen, 1 for Succubus Scene, 2 for second scene, 3 for normal, 4 if he's willing to take over, 5 for in charge
    public static var ZetazState:int; // 0 for unseen, 1 for worker, 2 for slave, 3 for dead
    public static var JabbaState:int; // 0 for unseen, 1 for normal
    public static var AkaassaState:int; //0 for unseen, 1 for normal, 2 for invited to see goblin daughters
    public static var EmeraldState:int; //0 for unseen, 1 for normal, 2 for protected by Zetaz
    public static var NolanQuest1State:int; //0 for uninitiated, 1 for incomplete, 2 for complete
    public static var NolanQuest2State:int; // see above
    public static var NolanQuest3State:int; // see above
    public static var NolanQuest4State:int; // see above
    public static var NolanQuest5State:int; // see above
    public static var NolanQuest6State:int; // see above
    public static var NolanQuest7State:int; // see above
    public static var BendanState:int; //0 for unseen, 1 for seen
    public static var templatenum:int; //how many free templates Meila has
    public static var MeilaTFChoices:int; //how many choices Meila has for TFing
    public static var MeilaTFstashPig:int;
    public static var MeilaTFstashDragon:int; //0 for not given TFs, 1 for TF enabled
    public static var MeilaTFstashKitsune:int; //same as above
    public static var MeilaTFstashCaveWyrm:int; //
    public static var MeilaTFstashRaiju:int; //
    public static var MeilaTFstashHydra:int; //
    public static var MeilaTFstashGazer:int; //
    public static var MeilaTFstashCentaur:int; //
    public static var MeilaTFstashFireMouse:int; //
    public static var MeilaTFstashDog:int; //
    public static var MeilaTFstashElf:int; //
    public static var MeilaTFstashHellhound:int; //
    public static var MeilaTFstashReptillum:int; //
    public static var MeilaTFstashShark:int; //
    public static var MeilaTFstashHarpy:int; //
    public static var MeilaTFstashKangaroo:int; //
    public static var MeilaTFstashMantis:int; //
    public static var MeilaTFstashScorpion:int; //
    public static var MeilaTFstashMoth:int; //
    public static var MeilaTFstashYeti:int; //
    public static var MeilaTFstashTanuki:int; //
    public static var MeilaTFstashGhost:int; //
    public static var MeilaTFstashTrap:int; //
    public static var MeilaTFstashIcicle:int; //
    public static var MeilaTFstashSucciD:int; //
    public static var MeilaTFstashMaraeFruit:int; //
    public static var MeilaTFstashSkyborn:int; //
    public static var MeilaTFstashWindgem:int; //
    public static var MeilaTFstashCentipede:int; //
    public static var MeilaTFstashHuman:int; //
    public static var MeilaTFstashSatyr:int; //
    public static var MeilaTFstashManticore:int; //
    public static var MeilaTFstashBee:int; //
    public static var MeilaTFstashGoo:int; //
    public static var MeilaTFstashSpider:int; //
    public static var MeilaTFstashDrider:int; //
    public static var MeilaTFstashOni:int; //
    public static var MeilaTFstashOrca:int; //
    public static var MeilaTFstashAnubis:int; //
    public static var MeilaTFstashFrostwyrm:int; //
    public static var MeilaTFstashBat:int; //
    public static var MeilaTFstashVampire:int; //
    public static var MeilaTFstashKraken:int; //
    public static var MeilaTFstashSphynx:int; //
    public static var MeilaTFstashFenrir:int; //
    public static var MeilaTFstashGorgon:int; //
    public static var MeilaTFstashSnail:int; //
    public static var MeilaTFstashAnt:int; //
    public static var MeilaTFstashJabberwock:int; //
    public static var MeilaTFstashSeaDragon:int; //
    public static var MeilaTFstashJiangshi:int; //
    public static var MeilaTFstashSalamander:int; //
    public static var MeilaTFstashPhoenix:int; //
    public static var MeilaTFstashRaccoon:int; //
    public static var MeilaTFstashGoblin:int; //
    public static var MeilaTFstashYukiOni:int; //
    public static var MeilaTFstashYukiOnna:int; //
    public static var MeilaTFstashTroll:int; //
    public static var MeilaTFstashArigean:int; //
    public static var MeilaTFstashBear:int; //
    public static var MeilaTFstashBoar:int; //
    public static var MeilaTFstashBunny:int; //
    public static var MeilaTFstashCat:int;//
    public static var MeilaTFstashMinotaur:int; //
    public static var MeilaTFstashBull:int; //
    public static var MeilaTFstashFox:int; //
    public static var MeilaTFstashPanda:int; //
    public static var MeilaTFstashSquirrel:int; //
    public static var MeilaTFstashGremlin:int; //
    public static var MeilaTFstashUnicorn:int; //
    public static var MeilaTFstashAlicorn:int; //
    public static var MeilaTFstashKirin:int; //
    public static var MeilaTFstashAnemone:int; //
    public static var MeilaTFstashRedPanda:int; //
    public static var MeilaTFstashThunderbird:int; //
    public static var MeilaTFstashMelkie:int; //
    public static var AkbalSamples:int;
    public static var NolanLumiTalked:Boolean;
    public static var NolanCatCaught:Boolean;
    public static var TaxesOwed:int; //How many gems you can pick up from the domain
    public static var TaxesOwedLethicite:int; // Only for after Ceraph is beaten
    public static var TaxesOwedMeila:int; //How many specialty items Melia has for pickup
    public static var TaxesOwedNolan:int; //How many specialty items Nolan has for pickup
    public static var SteakEaten:int; //How many Steaks you've eaten
    public static var FishEaten:int; //How many Steaks you've eaten


    public function stateObjectName():String {
        return "DomsDomain";
    }

    public function resetState():void {
        domenabled = false;
        NolanCatCaught = false;
        NolanLumiTalked = false;
        whosincharge = 0;
        BendanState = 0;
         CeraphDominance = 50;
       MeilaState = 0;
        MeilaTrust = 0;
        Playerdominance = 50;
         NolanState = 0;
       ZetazState = 0;
        JabbaState = 0;
        AkaassaState = 0;
        EmeraldState = 0;
         NolanQuest1State = 0;
        NolanQuest2State = 0;
        NolanQuest3State = 0;
        NolanQuest4State = 0;
        NolanQuest5State = 0;
         NolanQuest6State = 0;
        NolanQuest7State = 0;
        TaxesOwed = 0;
        TaxesOwedLethicite = 0;
        TaxesOwedMeila = 0;
        TaxesOwedNolan = 0;
        templatenum = 0;
        MeilaTFChoices = 5;
        MeilaTFstashMinotaur = 1;
        MeilaTFstashDragon = 0;
        MeilaTFstashKitsune = 0;
        MeilaTFstashCaveWyrm = 0;
        MeilaTFstashRaiju = 0;
        MeilaTFstashHydra= 0;
        MeilaTFstashGazer= 0;
        MeilaTFstashCentaur= 0;
        MeilaTFstashFireMouse= 0;
        MeilaTFstashDog= 0;
        MeilaTFstashElf= 0;
        MeilaTFstashHellhound= 0;
        MeilaTFstashReptillum= 0;
        MeilaTFstashShark= 0;
        MeilaTFstashHarpy= 0;
        MeilaTFstashKangaroo= 0;
        MeilaTFstashMantis= 0;
        MeilaTFstashScorpion= 0;
        MeilaTFstashMoth= 0;
        MeilaTFstashYeti= 0;
        MeilaTFstashTanuki= 0;
        MeilaTFstashGhost= 0;
        MeilaTFstashTrap= 0;
        MeilaTFstashIcicle= 0;
        MeilaTFstashSucciD= 0;
        MeilaTFstashMaraeFruit= 0;
        MeilaTFstashSkyborn= 0;
        MeilaTFstashWindgem= 0;
        MeilaTFstashCentipede= 0;
        MeilaTFstashHuman= 0;
        MeilaTFstashSatyr= 0;
        MeilaTFstashManticore= 0;
        MeilaTFstashBee= 0;
        MeilaTFstashGoo= 0;
        MeilaTFstashSpider= 0;
        MeilaTFstashDrider= 0;
        MeilaTFstashOni= 0;
        MeilaTFstashOrca= 0;
        MeilaTFstashAnubis= 0;
        MeilaTFstashFrostwyrm= 0;
        MeilaTFstashBat= 0;
        MeilaTFstashVampire= 0;
        MeilaTFstashKraken= 0;
        MeilaTFstashSphynx= 0;
        MeilaTFstashFenrir= 0;
        MeilaTFstashGorgon= 0;
        MeilaTFstashSnail= 0;
        MeilaTFstashAnt= 0;
        MeilaTFstashJabberwock= 0;
        MeilaTFstashSeaDragon= 0;
        MeilaTFstashJiangshi= 0;
        MeilaTFstashSalamander= 0;
        MeilaTFstashPhoenix= 0;
        MeilaTFstashRaccoon= 0;
        MeilaTFstashGoblin= 1;
        MeilaTFstashYukiOni= 0;
        MeilaTFstashYukiOnna= 0;
        MeilaTFstashTroll= 0;
        MeilaTFstashArigean= 0;
        MeilaTFstashBear= 0;
        MeilaTFstashBoar= 0;
        MeilaTFstashBunny= 0;
        MeilaTFstashCat= 0;
        MeilaTFstashBull= 0;
        MeilaTFstashFox= 1;
        MeilaTFstashPanda= 0;
        MeilaTFstashSquirrel= 0;
        MeilaTFstashGremlin= 0;
        MeilaTFstashUnicorn= 0;
        MeilaTFstashAlicorn= 0;
        MeilaTFstashKirin= 0;
        MeilaTFstashAnemone= 0;
        MeilaTFstashRedPanda= 0;
        MeilaTFstashThunderbird= 0;
        MeilaTFstashMelkie= 0;
        AkbalSamples= 0;
        FishEaten= 0;
        SteakEaten= 0;
    }

    public function saveToObject():Object {
        return {
            "domenabled":domenabled,
            "NolanLumiTalked":NolanLumiTalked,
            "NolanCatCaught":NolanCatCaught,
            "whosincharge":whosincharge,
            "CeraphDominance":CeraphDominance,
            "MeilaState": MeilaState,
            "MeilaTrust": MeilaTrust,
            "Playerdominance": Playerdominance,
            "NolanState": NolanState,
            "ZetazState": ZetazState,
            "JabbaState": JabbaState,
            "AkaassaState": AkaassaState,
            "EmeraldState": EmeraldState,
            "NolanQuest1State": NolanQuest1State,
            "NolanQuest2State": NolanQuest2State,
            "NolanQuest3State": NolanQuest3State,
            "NolanQuest4State": NolanQuest4State,
            "NolanQuest5State": NolanQuest5State,
            "NolanQuest6State": NolanQuest6State,
            "NolanQuest7State": NolanQuest7State,
            "BendanState": BendanState,
            "TaxesOwed": TaxesOwed,
            "TaxesOwedLethicite": TaxesOwedLethicite,
            "TaxesOwedMeila": TaxesOwedMeila,
            "TaxesOwedNolan": TaxesOwedNolan,
            "templatenum": templatenum,
            "MeilaTFChoices": MeilaTFChoices,
            "MeilaTFstashMinotaur": MeilaTFstashMinotaur,
            "MeilaTFstashDragon": MeilaTFstashDragon,
            "MeilaTFstashKitsune": MeilaTFstashKitsune,
            "MeilaTFstashCaveWyrm": MeilaTFstashCaveWyrm,
            "MeilaTFstashRaiju": MeilaTFstashRaiju,
            "MeilaTFstashHydra": MeilaTFstashHydra,
            "MeilaTFstashGazer": MeilaTFstashGazer,
            "MeilaTFstashCentaur": MeilaTFstashCentaur,
            "MeilaTFstashFireMouse": MeilaTFstashFireMouse,
            "MeilaTFstashDog": MeilaTFstashDog,
            "MeilaTFstashElf": MeilaTFstashElf,
            "MeilaTFstashHellhound": MeilaTFstashHellhound,
            "MeilaTFstashReptillum": MeilaTFstashReptillum,
            "MeilaTFstashShark": MeilaTFstashShark,
            "MeilaTFstashHarpy": MeilaTFstashHarpy,
            "MeilaTFstashKangaroo": MeilaTFstashKangaroo,
            "MeilaTFstashMantis": MeilaTFstashMantis,
            "MeilaTFstashScorpion": MeilaTFstashScorpion,
            "MeilaTFstashMoth": MeilaTFstashMoth,
            "MeilaTFstashYeti": MeilaTFstashYeti,
            "MeilaTFstashTanuki": MeilaTFstashTanuki,
            "MeilaTFstashGhost": MeilaTFstashGhost,
            "MeilaTFstashTrap": MeilaTFstashTrap,
            "MeilaTFstashIcicle": MeilaTFstashIcicle,
            "MeilaTFstashSucciD": MeilaTFstashSucciD,
            "MeilaTFstashMaraeFruit": MeilaTFstashMaraeFruit,
            "MeilaTFstashSkyborn": MeilaTFstashSkyborn,
            "MeilaTFstashWindgem": MeilaTFstashWindgem,
            "MeilaTFstashCentipede": MeilaTFstashCentipede,
            "MeilaTFstashHuman": MeilaTFstashHuman,
            "MeilaTFstashSatyr": MeilaTFstashSatyr,
            "MeilaTFstashManticore": MeilaTFstashManticore,
            "MeilaTFstashBee": MeilaTFstashBee,
            "MeilaTFstashGoo": MeilaTFstashGoo,
            "MeilaTFstashSpider": MeilaTFstashSpider,
            "MeilaTFstashDrider": MeilaTFstashDrider,
            "MeilaTFstashOni": MeilaTFstashOni,
            "MeilaTFstashOrca": MeilaTFstashOrca,
            "MeilaTFstashAnubis": MeilaTFstashAnubis,
            "MeilaTFstashFrostwyrm": MeilaTFstashFrostwyrm,
            "MeilaTFstashBat": MeilaTFstashBat,
            "MeilaTFstashVampire": MeilaTFstashVampire,
            "MeilaTFstashKraken": MeilaTFstashKraken,
            "MeilaTFstashSphynx": MeilaTFstashSphynx,
            "MeilaTFstashFenrir": MeilaTFstashFenrir,
            "MeilaTFstashGorgon": MeilaTFstashGorgon,
            "MeilaTFstashSnail": MeilaTFstashSnail,
            "MeilaTFstashAnt": MeilaTFstashAnt,
            "MeilaTFstashJabberwock": MeilaTFstashJabberwock,
            "MeilaTFstashSeaDragon": MeilaTFstashSeaDragon,
            "MeilaTFstashJiangshi": MeilaTFstashJiangshi,
            "MeilaTFstashSalamander": MeilaTFstashSalamander,
            "MeilaTFstashPhoenix": MeilaTFstashPhoenix,
            "MeilaTFstashRaccoon": MeilaTFstashRaccoon,
            "MeilaTFstashGoblin": MeilaTFstashGoblin,
            "MeilaTFstashYukiOni": MeilaTFstashYukiOni,
            "MeilaTFstashYukiOnna": MeilaTFstashYukiOnna,
            "MeilaTFstashTroll": MeilaTFstashTroll,
            "MeilaTFstashArigean": MeilaTFstashArigean,
            "MeilaTFstashBear": MeilaTFstashBear,
            "MeilaTFstashBoar": MeilaTFstashBoar,
            "MeilaTFstashBunny": MeilaTFstashBunny,
            "MeilaTFstashCat": MeilaTFstashCat,
            "MeilaTFstashBull": MeilaTFstashBull,
            "MeilaTFstashFox": MeilaTFstashFox,
            "MeilaTFstashPanda": MeilaTFstashPanda,
            "MeilaTFstashSquirrel": MeilaTFstashSquirrel,
            "MeilaTFstashGremlin": MeilaTFstashGremlin,
            " MeilaTFstashUnicorn":  MeilaTFstashUnicorn,
            "MeilaTFstashAlicorn": MeilaTFstashAlicorn,
            " MeilaTFstashKirin":  MeilaTFstashKirin,
            "MeilaTFstashAnemone": MeilaTFstashAnemone,
            "MeilaTFstashRedPanda": MeilaTFstashRedPanda,
            "MeilaTFstashThunderbird": MeilaTFstashThunderbird,
            "MeilaTFstashMelkie": MeilaTFstashMelkie,
            "AkbalSamples": AkbalSamples,
            "FishEaten": FishEaten,
            "SteakEaten": SteakEaten

        };
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            domenabled = o["domenabled"];
            NolanLumiTalked = o["NolanLumiTalked"];
            NolanCatCaught = o["NolanCatCaught"];
            whosincharge = o["whosincharge"];
            CeraphDominance = o["CeraphDominance"];
            MeilaState = o["MeilaState"];
            MeilaTrust = o["MeilaTrust"];
            Playerdominance = o["Playerdominance"];
            NolanState= o["NolanState"];
            ZetazState = o["ZetazState"];
            JabbaState = o["JabbaState"];
            AkaassaState = o["AkaassaState"];
            EmeraldState= o["EmeraldState"];
            NolanQuest1State= o["NolanQuest1State"];
            NolanQuest2State= o["NolanQuest2State"];
            NolanQuest3State = o["NolanQuest3State"];
            NolanQuest4State= o["NolanQuest4State"];
            NolanQuest5State = o["NolanQuest5State"];
            NolanQuest6State= o["NolanQuest6State"];
            NolanQuest7State  = o["NolanQuest7State"];
            BendanState = o ["BendanState"]
            TaxesOwed= o["TaxesOwed"];
            TaxesOwedLethicite = o["TaxesOwedLethicite"];
            TaxesOwedMeila = o["TaxesOwedMeila"];
            TaxesOwedNolan  = o["TaxesOwedNolan"];
            templatenum = o["templatenum"];
            MeilaTFChoices = o["MeilaTFChoices"];
            MeilaTFstashMinotaur = o["MeilaTFstashMinotaur"];
            MeilaTFstashDragon = o["MeilaTFstashDragon"];
            MeilaTFstashKitsune = o["MeilaTFstashKitsune"];
            MeilaTFstashCaveWyrm = o["MeilaTFstashCaveWyrm"];
            MeilaTFstashRaiju = o["MeilaTFstashRaiju"];
            MeilaTFstashHydra = o["MeilaTFstashHydra"];
            MeilaTFstashGazer= o["MeilaTFstashGazer"];
            MeilaTFstashCentaur= o["MeilaTFstashCentaur"];
            MeilaTFstashFireMouse = o["MeilaTFstashFireMouse"];
            MeilaTFstashDog= o["MeilaTFstashDog"];
            MeilaTFstashElf= o["MeilaTFstashElf"];
            MeilaTFstashHellhound = o["MeilaTFstashHellhound"];
            MeilaTFstashReptillum= o["MeilaTFstashReptillum"];
            MeilaTFstashShark= o["MeilaTFstashShark"];
            MeilaTFstashHarpy= o["MeilaTFstashHarpy"];
            MeilaTFstashKangaroo= o["MeilaTFstashKangaroo"];
            MeilaTFstashMantis= o["MeilaTFstashMantis"];
            MeilaTFstashScorpion= o["MeilaTFstashScorpion"];
            MeilaTFstashMoth= o["MeilaTFstashMoth"];
            MeilaTFstashYeti= o["MeilaTFstashYeti"];
            MeilaTFstashTanuki= o["MeilaTFstashTanuki"];
            MeilaTFstashGhost= o["MeilaTFstashGhost"];
            MeilaTFstashTrap = o["MeilaTFstashTrap"];
            MeilaTFstashIcicle= o["MeilaTFstashIcicle"];
            MeilaTFstashSucciD= o["MeilaTFstashSucciD"];
            MeilaTFstashMaraeFruit= o["MeilaTFstashMaraeFruit"];
            MeilaTFstashSkyborn= o["MeilaTFstashSkyborn"];
            MeilaTFstashWindgem= o["MeilaTFstashWindgem"];
            MeilaTFstashCentipede= o["MeilaTFstashCentipede"];
            MeilaTFstashHuman= o["MeilaTFstashHuman"];
            MeilaTFstashSatyr= o["MeilaTFstashSatyr"];
            MeilaTFstashManticore = o["MeilaTFstashManticore"];
            MeilaTFstashBee= o["MeilaTFstashBee"];
            MeilaTFstashGoo= o["MeilaTFstashGoo"];
            MeilaTFstashSpider = o["MeilaTFstashSpider"];
            MeilaTFstashDrider= o["MeilaTFstashDrider"];
            MeilaTFstashOni = o["MeilaTFstashOni"];
            MeilaTFstashOrca= o["MeilaTFstashOrca"];
            MeilaTFstashAnubis = o["MeilaTFstashAnubis"];
            MeilaTFstashFrostwyrm= o["MeilaTFstashFrostwyrm"];
            MeilaTFstashBat= o["MeilaTFstashBat"];
            MeilaTFstashVampire= o["MeilaTFstashVampire"];
            MeilaTFstashKraken= o["MeilaTFstashKraken"];
            MeilaTFstashSphynx= o["MeilaTFstashSphynx"];
            MeilaTFstashFenrir= o["MeilaTFstashFenrir"];
            MeilaTFstashGorgon= o["MeilaTFstashGorgon"];
            MeilaTFstashSnail = o["MeilaTFstashSnail"];
            MeilaTFstashAnt= o["MeilaTFstashAnt"];
            MeilaTFstashJabberwock= o["MeilaTFstashJabberwock"];
            MeilaTFstashSeaDragon = o["MeilaTFstashSeaDragon"];
            MeilaTFstashJiangshi= o["MeilaTFstashJiangshi"];
            MeilaTFstashSalamander= o["MeilaTFstashSalamander"];
            MeilaTFstashPhoenix = o["MeilaTFstashPhoenix"];
            MeilaTFstashRaccoon= o["MeilaTFstashRaccoon"];
            MeilaTFstashGoblin= o["MeilaTFstashGoblin"];
            MeilaTFstashYukiOni = o["MeilaTFstashYukiOni"];
            MeilaTFstashYukiOnna= o["MeilaTFstashYukiOnna"];
            MeilaTFstashTroll= o["MeilaTFstashTroll"];
            MeilaTFstashArigean = o["MeilaTFstashArigean"];
            MeilaTFstashBear = o["MeilaTFstashBear"];
            MeilaTFstashBoar= o["MeilaTFstashBoar"];
            MeilaTFstashBunny = o["MeilaTFstashBunny"];
            MeilaTFstashCat = o["MeilaTFstashCat"];
            MeilaTFstashBull= o["MeilaTFstashBull"];
            MeilaTFstashFox= o["MeilaTFstashFox"];
            MeilaTFstashPanda= o["MeilaTFstashPanda"];
            MeilaTFstashSquirrel = o["MeilaTFstashSquirrel"];
            MeilaTFstashGremlin= o["MeilaTFstashGremlin"];
            MeilaTFstashUnicorn= o["MeilaTFstashUnicorn"];
            MeilaTFstashAlicorn = o["MeilaTFstashAlicorn"];
            MeilaTFstashKirin = o["MeilaTFstashKirin"];
            MeilaTFstashAnemone= o["MeilaTFstashAnemone"];
            MeilaTFstashRedPanda = o["MeilaTFstashRedPanda"];
            MeilaTFstashThunderbird = o["MeilaTFstashThunderbird"];
            MeilaTFstashMelkie = o["MeilaTFstashMelkie"];
            AkbalSamples = o["AkbalSamples"];
            FishEaten =o["FishEaten"];
            SteakEaten =o["SteakEaten"];

        } else {
            // loading from old save
            resetState();
        }
    }

    public function DomsDomain() {
        Saves.registerSaveableState(this);
        EventParser.timeAwareClassAdd(this);
    }

    public function timeChange():Boolean {
        return false;
    }

    public function timeChangeLarge():Boolean {
        return false;
    }

    //--------------Main Hall Functions--------------

    public function EnterTheDomain():void {
        clearOutput();
        outputText("The sterile-steel floors of the lab’s entryway have been replaced by ornate tiles, etched with exaggerated, sexualized forms. A single, ten-foot-wide reddish mat is in the middle, covering the floor from the door to the main entrance…as you walk on the mat, you realize…it’s textured to feel like a giant pussy, the folds not damp, but warm under you, nonetheless. ");
        if (whosincharge == 0 || whosincharge == 3) {
            outputText("A few burly minotaurs eye you as you walk past, one seemingly interested in your groin, but nobody makes a move. The doors leading into the once-ballroom open as you draw near. ");
            outputText(" \n\n");
        }
        if (whosincharge == 1) {
            outputText("A single, large chimera-demon gives you a once-over. His Scylla tentacles are actively penetrating one of Meila’s chimeric goblins, but the gazer eyes on his back are constantly scanning the area. He gives you a nod, lowering the goblin onto his groin as he opens the door with one hand. ");
        }
        if (whosincharge == 2) {
            outputText("Several bat-like demons with gray scales stand between you and the door inside, wielding pikes that they cross in front of the door. As you approach, they straighten up, the door swinging open soundlessly. ");
        }
        if (model.time.hours > 6 && model.time.hours < 19) {
            outputText("As you step down a few stairs, the noise hits you all at once. Loud, thumping music, the clink of glasses, the moans of the debilitatingly aroused…Ceraph’s turned the former lab into a massive, rollicking compound. Just in the former ballroom alone you can see a strip club at the far end with a massive stage, a dance floor below it, and closer to you is a dining area. ");
            outputText(" \n\n");
        } else {
            outputText("There are far fewer demons around, and you recognise most of them as Ceraph’s crew. The atmosphere is cool, and demons move around quickly and efficiently. The eating area is still open, but only a few demons are eating. The dance floor is empty, and while some music floats through the place, it’s a soothing, refreshing melody, nothing like the rollicking rave you heard earlier.\n\n");
        }


        menu();
        addButton(11, "Leave", camp.returnToCampUseOneHour);
        addButton(6, "Restaraunt", FoodHall);
        addButton(12, "D.Dullahan", DaintyDullahanEnter);
    }

    public function FoodHall():void {
        clearOutput();
        outputText("In this section, booths and tables have been set up, dividing the section into a shockingly large restaurant and bar. ");
        outputText(" \n\n");
        if (model.time.hours > 6 && model.time.hours < 19) {
            outputText("The place is practically boiling with activity, with nearly every table filled, either with a demon, some morphs from across Mareth, or both. \n\n");
        } else {
            outputText("The place is nearly empty, having been cleared out for the night. Only a few demons sit around the tables, almost exclusively demons that work here at the domain.\n\n");
        }
        if (EmeraldState == 0) {
            outputText("As you enter the section, a scantily clad omnibus greets you. She has four displacer arms, a pair of modest B cup breasts, and slender hips, with a surprisingly large backside. She wears a pink crop-top that complements her pale blue skin, and a cut-away bikini bottom. Her bikini bottom is cut open to reveal her cock and glistening pussy, her human-like cock is only 2 inches long. A cockring is clamped firmly around her shaft.  \n\n");
            outputText("She has wide red eyes, shining with moisture and a smooth, almost regal face. Her horns are so small that they’re barely visible, and she carries herself with a kind of shivering submissiveness that you’d normally associate with the very shy…At complete odds with her (lack of) clothing, and the situation she’s in. Most of the demons in the restaurant seem to be eyeing her hungrily, and you get the impression that she was put here for Ceraph’s amusement. \n\n");
            outputText("  Her knees tremble as she walks towards you. Behind her, you notice two catlike tails swaying with her stride.\n\n ");
            outputText("“[Master] [Name], I presume?” She bites her lip, shuddering slightly. “My name is Emerald, but please, call me Em. If you want anything in the restaurant, please talk to me.” A passing demon slaps her on the ass, and she winces.\n\n");
            outputText("The bar is over there, and the labs have been converted. One is the Merchant’s…Hng!” She turns around, giving you a clear view of her juicy ass…and the currently vibrating pink toy stuck into it. “I’ll be r-right there! Just give m-me a second!” She shudders. “...Quarter, and there’s a brewery to the west, over there. N-now, I need to go s-serve some drinks.” You notice, as she walks off, that the demon she’s walking over to has a remote in his hand, and that he’s pressing the button repeatedly. Apparently, this restaurant has more than one type of service.\n\n");
        } else {
            outputText("Emerald notices you at the entrance to the restaurant. You get the feeling that she’ll be rushing over the moment you seem like you need service. \n\n");

        }
        if (ZetazState == 1) {
            outputText("You notice that the oversized imp lord is near the bar, keeping an eye on the place. Despite his gaze frequently being drawn to Emerald’s ass, he seems alert and on-duty, taking his job seriously. He wears a thick suit and pants, befitting his role. You notice that the demons aren’t as heavy with Emerald’s buzzer as they were before. \n\n");
            outputText(" \n\n");
        }
        if (ZetazState == 2) {
            outputText(" \n\n");
        }

        menu();
        addButton(0, "Nolan", NolanTalk);
        if (ZetazState  !=3) {
            addButton(1, "Zetaz", ZetazTalk);
        }
        addButton(2, "Meal", GetFood);
        addButton(6, "StripClub", StripClub);
        addButton(10, "Brewery", BreweryEnter);
        addButton(11, "Entrance", EnterTheDomain);
        addButton(12, "Merchant", Jabbasplace);

    }

    private function GetFood():void {
        clearOutput();
        if (isTimeBetween (6,18)) {
            outputText("You enter the restaurant section, and Emerald sees you, immediately pulling away from the table she’s currently serving. You have several seconds as she walks over to appreciate her slender curves, and the visible shaking of her legs as the annoyed demons she just left press their button, sending vibrations through her body. \n\n");
            outputText("Emerald walks over to you, and nods respectfully, walking you towards a comfortable booth in the corner. It’s empty, with a small sign on the table. Looking at the sign, you notice it has your name on it. How convenient!\n\n");
            outputText("“We only serve two meals, but they’re of the finest quality. Here in the Dom’s Domain, our meals don’t just nourish…They enhance all of our flavors.” She gives you a wink at that. \n\n");
            outputText("“For the testosterone driven, I suggest the steak. You’ll certainly feel more manly afterwards. For the fairer side, I’d suggest the Fish. It’s got more dainty flavors that are guaranteed to impart a little of the sea, downstairs.” \n\n");
            outputText("Emerald puts a remote on the table for you, along with a glass of wine. “If there’s anything you need while you’re here, j-just push the button. It’ll call me r-right over.” She flips off the table she’d been waiting on. “VIPs get priority, you limp-dicks!” She shakes her head, shuddering slightly as the toy in her ass keeps buzzing. “I need to deal with them. When you decide what you want, call me back over.” \n\n");
            outputText("Well, now that you’re seated, what do you feel like eating?\n\n");
        } else {
            outputText("Emerald breaks away from the small group of remaining demons, walking over to you. “Hello, [master], how can I help you today?” She seems exhausted, her legs shaking, but her pussy is dripping. The toy, normally attached to her, dangles limply from her inner thigh. She pulls herself together, putting a strained smile on her face.\n\n");
            outputText("“We only serve two meals, but they’re of the finest quality. Here in the Dom’s Domain, our meals don’t just nourish…They enhance all of our flavors.”\n\n");
            outputText("“For the testosterone driven, I suggest the steak. You’ll certainly feel more manly afterwards. For the fairer side, I’d suggest the Fish. It’s got more dainty flavors that are guaranteed to impart a little of the sea, downstairs.”\n\n ");
            outputText("You get the feeling that Emerald is sick and tired of saying that line by now.\n\n");
            outputText("");
        }
        menu();
        addButton(0, "Fish", EatFish);
        addButton(1, "Steak", EatSteak);
        addButton(2, "Emerald", Gemstone4yourmeal);
    }

    private function EatFish():void {
        clearOutput();
        outputText("Emerald gives you a warm smile. “Personally, that’s my favorite.” Emerald sashays away, giving you ample time to examine her bubble-butt and wide hips as she heads off to the kitchen. In minutes, she comes back with a tender-looking filet, steaming ever so slightly. On a bed of pink rice, the dish is dainty, and you eat slowly, savoring the flavors. As you eat, you feel like the Incubi are eyeing you a bit more…and you find yourself enjoying that thought, your eyes half-lidding as you lazily watch a few Incubi bicker across the bar. \n\n");
        outputText("Soon enough, you’ve finished your meal. You decide to take your leave, and explore the Dom’s Domain a bit more.\n\n");
        outputText("");
        var gain:Number = player.maxHunger();
		gain -= (player.hunger + 1);
		player.refillHunger(gain);
        pc.HPChange(Math.round(player.maxHP() * .05), false, true);
        pc.ManaChange(player.maxMana() * 0.05);
        FishEaten += 1;
        doNext(FoodHall);
    }

    private function EatSteak():void {
        clearOutput();
        outputText("“Very well. I’ll be back momentarily.” Emerald sashays away, giving you ample time to examine her bubble-butt and wide hips as she heads off to the kitchen. In minutes, she comes back with a slab of well-marbled meat, served with a side of tender greens.\n\n");
        outputText("“Enjoy!” Emerald says brightly, topping off a wine glass and putting it down beside you. You tear into the meat…It’s savory to the extreme, the fat practically dripping off it. You finish before you realize it, completely satiated. The warmth from the meal fills your belly…and begins to collect in your loins. Your eye begins to follow the succubi a little more closely.\n\n");
        outputText("Soon enough, you’ve finished your meal. You decide to take your leave, and explore the Dom’s Domain a bit more.\n\n");
        //increase food, virility and cum production
        var gain:Number = player.maxHunger();
		gain -= (player.hunger + 1);
		player.refillHunger(gain);
        pc.HPChange(Math.round(player.maxHP() * .05), false,true);
        pc.ManaChange(player.maxMana() * 0.05);
        SteakEaten +=1;
        doNext(FoodHall);
    }

    private function StripClub():void {
        clearOutput();
        outputText("This section of the main hall has been altered the most from its time as Lethice’s lab. The ballroom has been replaced with glowing pink and black tiles, and the back quarter of the room has been raised into a massive stage, split into sections by large, fancy poles. \n\n");
        //6:00-18:00
        outputText("Music pulses through several devices behind the stage, upon which dance a half-dozen fully naked succubi.\n\n");
        outputText("Several cages float above the stage, a dozen more demons dancing within. Occasionally, the cages lower, and one of the demons on the ground pulls the dancer from the cage. The dancer and the demon then swiftly move to the East, where Project Nightwalker once was, going through the iron door. Almost as quickly, another demon steps into the cage, and it raises towards the ceiling as the demon within begins to dance.\n\n");

        outputText("The stage lies empty, but the place is still bustling with activity. Demons, mostly Incubi, are hauling buckets of water and soap around, while others clean the floors. You can see several dancers and other demons cuddling, fucking, or exchanging light banter as they clean up. A few have even stripped, and are bathing themselves openly, over one of the several drains in the floors. Apparently exhibitionism isn’t uncommon here.\n\n");
        if (whosincharge == 0) {
            if (CeraphDominance > 60) {
                outputText("On a raised dais, above and behind the stage, you can see Ceraph herself in a deep-necked, crimson dress, thigh-slits cut in the ankle-length skirt. She lounges on a dark violet throne, a wicked little smile on her face as she watches the party.\n\n");
                outputText("");
            }
            if (CeraphDominance > 40 && CeraphDominance < 60) {
                outputText("Ceraph lounges on her throne, but her expression is slightly strained. A few of her larger bouncers are positioned between her and the demonic horde, acting as a crude queen’s guard.\n");
                outputText("");
            }
            if (CeraphDominance > 20 && CeraphDominance < 40) {
                outputText("Ceraph, in her deep-necked crimson dress, lies on a comfortable pillow at the foot of the dark violet throne. She occasionally looks around nervously, as if some of the other demons have been forceful with her. Clearly, she’s no longer really in control.\n\n");
                outputText("");
            }
            menu();
            addButton(6, "Throne", SitonYourThrone);
            addButton(10, "Toilets", CumtoiletsEnter);
            addButton(11, "FoodHall", FoodHall);
            addButton(12, "Brothel", BrothelEnter);
        }
        if (whosincharge == 1) {
            //6:00-18:00
            outputText("The throne lies empty, waiting for you. Meila is presumably managing her part of the business, as nobody else has her expertise. The party rollicks wildly, and several of the dancers seem to have additions they didn’t have before.\n\n");
            //18:01-5:59
            outputText("Meila looks down from the throne that had once been Ceraph’s. As she sees you, her eyes light up, and a smile forms on her pale face. Her head detaches, floating over to you, and she rests her head on your shoulder. \n\n");
            outputText("“Hello there, [Master]” Meila whispers. “If you require anything, just ask. Otherwise, enjoy your stay.” Her head floats over the few demons left after-hours as they wind down the Domain. You notice that more of them are sporting body modifications. \n\n");
            outputText("");
            addButton(6, "Throne", SitonYourThrone);
            addButton(7, "BackRoom", Backroom);
            addButton(10, "Toilets", CumtoiletsEnter);
            addButton(11, "FoodHall", FoodHall);
            addButton(12, "Brothel", BrothelEnter);
        }
        if (CeraphState == 0) {
            outputText("Ceraph stands, waving a hand. The music slows, fading out over a few seconds. Some of the demons mutter, but she leans down, another demon offering her a small device.\n\n");
            outputText("“Demons and sinners!” She declares warmly. “My eyes do not deceive me. We have a very special guest here today!” She points to you, and the crowd parts. “[Master] [Name] is here!” She pauses as some of the demons mutter, apparently not happy to see you. “Now, now, whores and gentledemons…While some of you may have had…some run-ins with our patron here, they’re the ones responsible for clearing out this lovely place for us. Give them a warm welcome!” She titters. “After all…We wouldn’t want any…unfortunate accidents to befall anyone, now would we?” \n\n");
            outputText("This gets some applause, and none of the assembled demons seem willing to tangle with you…But Ceraph is clearly just using you and your strength to further her own agenda. How do you react?\n\n");
            CeraphState = 1;
            menu();
            addButton(0, "Humiliate", CeraphHumiliate);
            addButton(1, "Acknowledge", CeraphAcknowledge);
            addButton(2, "Reprimand", CeraphTellOff);
            addButton(3, "Bow", CeraphBow);
        }
        if (CeraphDominance == 100) {
            outputText("Ceraph stands, and you notice her mouth is drawn in a hard line. She expands her wings, and you notice that the Omnibus is dressed in light leather armor.\n\n ");
            outputText("“Welcome to the Dom’s Domain!” She calls, her voice magically amplified. Twin whips rise from either side of the throne, following the movements of her hands as she glares down at you. “Today, ladies and gentledemons, we have a special show for you!” The dancers clear the stage, and Ceraph floats an inch above the floor, violet energy covering her body. The first whip lashes out at you, and you leap back, landing on the stage. \n\n");
            outputText("“You never get to stay on top forever”, Ceraph declares, floating to the stage. “And now…We decide who’s the Dom in MY domain!”\n\n");
            outputText("Sounds like Ceraph’s asking for a beating…And there’s nowhere to hide. You need to put this bitch back in her place! \n\n");
        //Start Fight with Boss Ceraph!
        }

    }

    private function SitonYourThrone():void {
        clearOutput();
        if (whosincharge == 0) {
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
        }
        if (whosincharge == 1) {
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
        }
        if (whosincharge == 2) {
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
        }
        if (whosincharge == 3) {
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
        }
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
    }

    private function BrothelEnter():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        addButton(0, "Centaur", CumtoiletsHeads);
        addButton(1, "Slime", CumtoiletsTails);
        addButton(2, "Twins", CumtoiletsTails);
        addButton(3, "Zetzuko", CumtoiletsTails);
        addButton(14, "Leave", StripClub);
    }


    //-----------------Toilets Scenes---------------------


    private function CumtoiletsEnter():void {
        clearOutput();
        outputText("Instead of male, female and herm signs to denote the bathrooms, the stick figures…are odd. One seems to be a head, with the mouth open. The other, an ass, spaded tail, and pair of legs, as seen from the back. Demons seem to enter and exit at random, with no genders being split. Which of the two do you want to enter?");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(0, "Heads", CumtoiletsHeads);
        addButton(1, "Tails", CumtoiletsTails);
        addButton(14, "Back", StripClub);
    }

    private function CumtoiletsTails():void {
        clearOutput();
        outputText("As you enter the toilets, the first thing to hit you is just how few actual toilets there are. A few demons are either relieving themselves, or going in two at a time, taking the stall for an extended period of time. \n");
        outputText("The next thing you notice is the left wall, lined with odd-looking apparatus. Each one is a purple cushion, with a few buttons beside it. As your gaze goes down the wall, you notice that a few people are in the holes, cushions inflated around them on all sides, pressing in to hold them there. They’re naked, asses sticking out. As you watch, an incubus grins, stepping up to a scaled backside. He forces the legs apart, and you can hear a muffled moan from the other side as he shoves his cock into the lizan’s cunt. \n\n");
        outputText("There are a variety of people stuck in the cushioned ‘toilets’. Each one comes with a shower-head, and a few levers. \n\n");
        outputText("(If you are a wood elf) \n\n" +
                "To your surprise, you see one of your sisters in the devices, trussed up. \n\n" +
                "\n" +
                "(If you aren’t) One of the blonde bitches from the forest, those wood elves. She’s clearly not here of her own free will. \n\n");
        outputText("She struggles, hands bound, flailing her legs to try and get loose. Despite…or maybe because… of her vigor, several demons already have their eyes on her. Her ripped green gown barely covers her backside, and you can see the machine shake slightly as she tries to free her hands. \n\n");
        outputText("A Chocolate-skinned elf, much like the ones around the mountains, lies in the machine, stuck. ");
        outputText("Unlike the others, her ankles are bound in iron, chained to the ground. A warning sign explains that this dark elf was caught while attempting to abduct one of Ceraph’s Harem, and to be as rough as possible. \n\n" +
                "\n" +
                "Her left ass cheek is bright red, despite her darker skin tone, and her ass moves slightly with each breath. Occasionally, her well-toned legs flex, trying to loosen the chains, but it’s clearly in vain. \n");
        outputText("A portly kangaroo morph is stuck in the machine.\n\n");
        outputText("Her ass jiggles with every movement, her thick tail swinging nervously. Her legs are thick and strong, but not as flexible as some. \n\n");
        outputText("A shark girl's back half sits trapped in one of the machines. Her legs, dripping wet with salt water, waggle, and her tail periodically thumps the ground. Somehow, this shark-girl is giving you the impression she’s bored, even though all you can see is her back half. Her cunt drools with anticipation. \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(0, "Elf", CumtoiletElfTail);
        addButton(1, "D.Elf", CumtoiletDElfTail);
        addButton(2, "K.Roo", CumtoiletRooTail);
        addButton(3, "SharkGirl", CumtoiletGuraTail);
        addButton(14, "Leave", StripClub);
    }

    private function CumtoiletGuraTail():void {
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function CumtoiletRooTail():void {
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function CumtoiletDElfTail():void {
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function CumtoiletElfTail():void {
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function CumtoiletsHeads():void {
        clearOutput();
        outputText("You open the door to the toilets…and what you find really shouldn’t have surprised you. In addition to a few stalls for actually relieving oneself…Most of the right wall is taken up by the upper halves of various people of all shapes and sizes, a rubber cushion both keeping them comfortable and firmly in place. The height they’re set at varies, but you can see controls on each one to raise or lower them. You can tell they’re not fakes, either. One bouncer you’ve seen around the place is going to town on a cum-drenched succubus, using her horns for leverage as he face-fucks her. \n\n");
        outputText("A lizan with sizable breasts moans as she bucks, eyes wide. Apparently someone at her rear is giving her a pounding, and she’s grabbing the sides of her ‘wall’ for dear life. \n\n");
        outputText("There are a variety of people stuck in the cushioned ‘toilets’. Each one comes with a shower-head, and a few levers. \n\n");
        outputText("To your surprise, you see one of the blonde bitches from the forest, those wood elves. She’s clearly not here of her own free will. \n\n");
        outputText("Her blue eyes are wild with fear and anger. While she hasn’t really seen you yet, she already has an O-ring in her mouth, and while her bountiful breasts are bound in a ripped green gown, it was already thin. Someone’s poured water on her, and she shivers slightly. \n\n");
        outputText("A Chocolate-skinned elf, much like the ones around the mountains, lies in the machine, stuck.\n\n");
        outputText("She glowers at the demons, somehow intimidating despite her situation. Her D-cup breasts dangle underneath her chest, and she’s been gagged. The sign above her reads “Loudmouth: Only Ungag for BJs”. Unlike the others, she’s bound not just by the machine, but trussed up completely, rope covering most of her body, crisscrossing around her voluptuous breasts. \n\n");
        outputText("A portly kangaroo morph is stuck in the machine.\n\n");
        outputText("Her head doesn’t move, just her eyes. You hear a humming sound, and she lets out a yelp, looking back at the machine holding her nervously. Unlike the others, you notice her hands aren’t bound, but she keeps her hands in her pouch, almost protectively. Her whole body is soft, and from what you can see, she’s pregnant, her stomach bulging. \n\n");
        outputText("One of the shark-girls from the lake sits passively, barely making a sound. A few imps jostle near her, joking. From the sign above her, apparently she’s a troublemaker, and has bitten off a few…Limbs. As such, she’s free for the imps to use. \n\n" +
                "\n" +
                "“Her tits aren’t bad. Put her on her back.” One says. “We can make that work.” \n\n" +
                "\n" +
                "“We could free one arm.” One suggests. “Handy?” \n\n");
        outputText("");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(0, "Elf", CumtoiletElfHead);
        addButton(1, "D.Elf", CumtoiletDElfHead);
        addButton(2, "K.Roo", CumtoiletRooHead);
        addButton(14, "Leave", StripClub);
    }

    private function CumtoiletRooHead():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(0, "BJ", RooHeadHead);
        addButton(1, "EatMe", RooHeadlick);
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function RooHeadlick():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function RooHeadHead():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function CumtoiletDElfHead():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(0, "BJ", DElfHead);
        addButton(1, "Lick", DElfLick);
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function DElfLick():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function DElfHead():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function CumtoiletElfHead():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(0, "BJ", ElfHead);
        addButton(1, "Lick", ElfLick);
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function ElfLick():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    private function ElfHead():void {
        clearOutput();
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton(14, "Back", CumtoiletsHeads);
    }

    //------------------Meila Scenes and Functions-----------------

    public function DaintyDullahanEnter():void {
        clearOutput();

        outputText("You walk towards the door, noticing the artwork on the door’s been changed. Instead of the spider motif, a curvy, pale woman is carved into the door, with her head floating in the air. As you near the door, it opens automatically, some kind of piston pushing it aside. A smaller incubus and an extremely brawny lacta bovine stand guard at the stairs leading downward. They both wear a collar, he seems to have his ear tagged, like a cow, and they both have weapons at their side. He wears a pair of daggers, and she has a massive tower shield on her back, and a greataxe in one hand. You’re not sure whether she’s sporting breasts, or pecs. The incubus is soft, almost pudgy-looking, and he steps forward as you approach. \n");
        outputText("“Welcome to the dainty Dullahan, [Master] [Name]. If there are any problems, please inform myself or my partner, and we’ll be sure to set things right.” That being said, they stand aside, leaving your path downstairs open. You head downstairs into the Dainty Dullahan.\n");


        doNext(DaintyDullahan);
    }
    public function DaintyDullahan():void {
        clearOutput();
if (MeilaState == 0) {
    outputText("The dark place where the Driders had once been caged is full once more. The place is dark, with some tables placed around. It’s been turned into a small lounge, with the cages around it. A few demons sit in the tables, and despite the frantic activity above, you can’t hear any of it, soothing piano washing through the little lounge as a few demons peruse paper menus on the table. \n\n");
    outputText("To your (If corrupt) satisfaction (If neutral) curiosity (If pure) revulsion, several small creatures float prone in the first cage. You decide to take a closer look, and draw near. \n\n");
    outputText("Their eyes are all closed, and while they’re bound, they seem well-fed and taken care of. However, they all seem to have been changed. While they all seem to have the same structure as an imp or goblin, they seem to have been transformed into miniature versions of one of the races of Mareth. Six in total levitate, slowly rotating. Pig, Mouse, Fox, Minotaur, Goblin and Imp. You slowly reach out towards the closest. Are they…even still alive in there?\n\n");
    outputText("“Hello?” You hear a soft voice come from behind you, and you turn, whipping around. \n\n");
    outputText("A small woman jumps back from you. “H-hey!” She protests. “Don’t touch them!” As you step away from the bound creatures, she walks in, putting herself between you and the creatures. “Rule one of the Dainty Dullahan: No touching the merchandise.” A woman with porcelain-white skin stands, pointing a finger at you. “And that…goes…” She seems to recognize you, and her pale blue eyes widen. “Wait…Are you…[Master] [Name]?” You nod, and her hands begin to shake. “I-I’m so sorry.” She immediately drops to her knees, prostrating herself before you. “I’m Meila, and I’m…Well, I am the Dainty Dullahan.” \n\n");
    outputText("Now that you’re getting a closer look at her, she is rather dainty. Meila stands 5’3, a thin, waifish woman who you could probably pick up with one hand. Her B-cup breasts are covered with a thin pink top, her pale, almost ghostlike midriff bare. She wears a dainty, frilly skirt that barely goes halfway down her thigh, and her legs are covered with thin black stockings. Her ebony, waist-length hair shimmers slightly, woven into a single braid going down her back.\n\n");
    outputText("“Please don’t tell Ceraph I was rude to you.” She begs. “I…Can’t deal with her being mad with me.” As her shoulders begin to shake, you hear a slight plop sound. \n\n");
    outputText("“No!” Meila wails, lunging forward as…Her head rolls toward you? Despite your shock, you move your [leg] into the runaway head’s path, stopping it before it gets away. She’s moving to grab her head, but you have some time to react. What do you do?\n\n");
    outputText("");
    outputText("");
    outputText("");
    outputText("");
    outputText("");
    outputText("");
    MeilaState = 1;
    menu();
    addButton(0, "CatchHead", MeilaFirstFuckMenu);
    addButton(1, "LetHerGrab", BeNiceToMeila1stMeeting);
} else {
    outputText("As you descend into the Dainty Dullahan’s lounge, you see Meila’s body moving from table to table, occasionally taking an order. You see a demon come out from the back, a brand new (fox-tail swishing behind them) (Pig’s hoofs clattering on the floor) (Mousey jaw, their teeth chattering slightly) (Insert TFs here)\n\n");
    outputText("You hear a quick “Hello, [master] [Name], If you need anything, just step up to the counter.” Meila’s head sits in a bucket near the ceiling, overlooking the entire operation while her body works the counter. \n\n");
    outputText("You step up to the counter, and you feel a chill on your back as Meila’s head floats over your shoulder, deftly reattaching to her neck. \n\n");
    outputText("“[Master] [Name], what brings you here?” She asks politely. “Here to get transformed? Help me with selection? Or did you just want to see more of me?” \n\n");
    outputText("");
    outputText("");
    menu();
    addButton(0, "Appearance", MeilaCheckOut);
    addButton(1, "Talk", MeilaTalk);
    addButton(2, "Sex", MeilaSexMenu);
    addButton(3, "D.Dull", MeilaBusiness);
    addButton(14,"Leave", EnterTheDomain);
        }
    }

    private function MeilaTalk():void {
        clearOutput();
        if (MeilaTrust < 30) {
            outputText("Meila looks down slightly. “I’d rather keep things professional, if you don’t mind. Mistress Ceraph doesn’t take too kindly to…Wasted time.”\n\n");
            outputText("Maybe she’d open up a little once she trusts you more?\n\n");
            outputText("");
            menu();
            addButton(14,"Back", DaintyDullahan);
        }
        if (MeilaTrust > 30 && MeilaTrust < 50) {
            outputText("Meila looks a little bit confused, but also a little flattered. “You just came down here to talk?” She seems a little wary, but looks at you, a small smile forming on her face. “What do you want to talk about, [Master]?” \n\n");
            outputText("");
            menu();
            addButton(0, "History", MeilaTalkHistory);
            addButton(1, "Others", MeilaTalkOthers);
            if (MeilaTrust > 60) {
                addButton(2, "Betrayal", MeilaTurnOnCeraph);
                addButton(14,"Back", DaintyDullahan);
            }
        }
        if (MeilaTrust > 50) {
            outputText("Meila smiles, blushing a little. “Well, pull up a stool, [master], I always have time to talk with you.”\n\n");
            outputText("");
            menu();
            addButton(0, "History", MeilaTalkHistory);
            addButton(1, "Others", MeilaTalkOthers);
            if (MeilaTrust > 60) {
                addButton(2, "Betrayal", MeilaTurnOnCeraph);
                } else {
                addButtonDisabled(2, "Betrayal", "Maybe if Meila trusted you more?\n\n");
                addButton(14,"Back", DaintyDullahan);
            }
            }
        }

    private function MeilaTurnOnCeraph():void {
        clearOutput();
        outputText("You tell Meila that you aren’t really liking the way things are right now. While Ceraph is your slave, you tell her that she’s too used to being in charge. You bring up Ceraph’s resistance to your commands, and that she seems to think that she’s still in charge. You ask Meila if she’d be willing to step up around here, should Ceraph become…indisposed for a while. \n\n");
        outputText("“...Are you…asking me if I want to be in charge?” Meila seems dumbfounded. You nod, and she frowns thoughtfully, putting a hand on her hip. “Yes. I could take over…But…We’d need to do something about Ceraph. She’s not likely going to just…Let it happen. And what would stop her from just…Taking it back once you left?”\n\n");
        outputText("Struck by a sudden idea, you ask Meila about her own status. Sure, she can control her body, just like normal…But what if she couldn’t? Couldn’t Meila make a way to weaken her connection to her body, or cut it off entirely?");
        outputText("Meila thinks about this. “Yes. It is very possible.” Meila looks at you, what you can only describe as a maniacal grin slowly forming on her face. “And with your help, I think I can do it.” She clenches her fists, giving you a look of determination. “...This isn’t the freedom I envisioned. I’d always hoped to be free…But I’ve made my peace with my lot. If you want to dispose of Ceraph, I will be more than happy to take her place here.” Meila stands. “I’ll need some time to prepare…But when you give the signal, I’ll be there.” \n\n");
        outputText("");

    }

    private function MeilaTalkOthers():void {
        clearOutput();
        outputText("“You wish to know more about the others in Ceraph’s Harem?” She shudders slightly. “Okay, who do you want to know about?” \n\n");
        menu();
        addButton(1, "Ceraph", MeilaTalkCeraph);
        addButton(2, "Jabba", MeilaTalkJabba);
        addButton(3, "Ceraph", MeilaTalkNolan);
        addButton(4, "Emerald", MeilaTalkEmerald);
        addButton(5, "Akaassa", MeilaTalkAkaassa);
        addButton(6, "back", MeilaTalk);

    }

    private function MeilaTalkJabba():void {
        clearOutput();
        outputText("“Honestly, he’s one of the few demons I actually think of as better than just a fuck-monster.” Meila says this honestly. “While his…Dronification collars make my neck itch just looking at them, he doesn’t abuse his “drones”, and so far hasn’t even made a permanent collar. How much of that is worrying someone could turn it on him, I don’t know…But he genuinely seems to care for his regulars, and the girls he’s taken as “his”.\n\n");
        //if Ceraph is in charge
        if (whosincharge == 0 || whosincharge == 3) {
            outputText("Ceraph may own this place, but he can compete with her in power.” Meila grins, leaning in conspiratorially.\n\n ");
            outputText("“Just the other day, Akaassaa had one of Ceraph’s favored boytoys kicked out of the place. Apparently he got it into his stupid head that he could take one of the drones from behind whenever he wanted.” Meila shakes her head. “The idiot dragged her into one of the whore-rooms in the back before the collar let her mind go, and he was halfway in before the bouncers got to him.” She chuckles. “When Jabba found out, he grabbed the idiot by the neck, stormed onto the dance floor, kicked one of Ceraph’s dancers in the ass, and tossed him at her feet, demanding he be kicked out.” She giggles like a little schoolgirl. Apparently Meila has a bit of a gossipy side to her. \n\n");
            outputText("“Ceraph bickered with him for a while, and they eventually agreed on a month-long ban, and for Ceraph to remove one of his penises. But it’s odd, seeing her compromise on ANYthing.”\n\n ");
        }
        outputText("You thank Meila for the information, deciding to change the subject\n\n");
        doNext(MeilaTalk);
    }

    private function MeilaTalkNolan():void {
        clearOutput();
        outputText("“I don’t know what to make of him”. Meila admits. “On the one hand, he acts like a demon, talks like a demon, and looks like a demon…But he doesn’t…Feel like one. Apparently he’s a leftover from when this place was a laboratory…but he has no loyalty to Lethice, unlike the rest of that crowd. I’d keep an eye on him if I were you, [master].” \n\n");
        outputText("You thank Meila for the information, deciding to change the subject\n\n");
        doNext(MeilaTalk);
    }

    private function MeilaTalkEmerald():void {
        clearOutput();
        outputText("“Oh…Poor Emerald.” Meila sighs, putting her hands on her hips. “Before Ceraph got bored of just…Having pets for pets’ sake, she took Emerald. Unlike me, Emerald was just…a waitress before the demons came. Some think she was Ceraph’s first toy, and that’s why she’s still around…But she’s the lowest of us. She’s got no special skills, no usefulness beyond waitressing and fucking, and so she’s got one of the worst jobs in the domain.” \n\n");
        outputText("You’re slightly taken aback by this. While Emerald’s situation isn’t exactly desirable, you’d think that being a dancer or whore would be…”Worse”. \n\n");
        outputText("“...Oh, no.” Meila’s very serious. “Emerald’s in constant, unavoidable contact with some of the horniest demons in Mareth, in a very busy environment. Therefore, she’s not allowed to have sex to relieve herself, and the operation of the place uses anal toys. Emerald may love being a buttslut, but that’s part of the problem. She’s in constant stimuli, and unable to release.” The little Dullahan sighs. “She’d probably go mad if a few people weren’t allowed to take her at will.”\n\n");
        outputText("");
        doNext(MeilaTalk);
    }

    private function MeilaTalkAkaassa():void {
        clearOutput();
        outputText("“Oh, the little goblin? She’s our resident techhead. While she may not let it slip often, Ceraph was around when the goblin city fell, and knows full well how valuable a goblin is…Well, one that still has her brain.” Meila frowns slightly at this. “I wish I could have seen the city before its fall. I’m told that it was a place of wonders.” She sighs. “So much has been lost…It’s a tragedy.” ");
        outputText("");
        outputText("");
        outputText("");
        doNext(MeilaTalk);
    }

    private function MeilaTalkCeraph():void {
        clearOutput();
       //low trust
        if (MeilaTrust < 30) {
            outputText("“Ceraph is…A very capable demon. She’s adept at magic, particularly seduction, and is no slouch in combat, either. You seem to have her well in hand though.” \n\n");
        }
        //medium trust
        if ((MeilaTrust > 30) && (MeilaTrust < 60)) {
            outputText("“Ceraph is the conniving, cunning queen of this domain. Don’t let your guard down around her, even with the totem you have keeping her in check.” \n\n");
        }
       //high trust, pierced token
        if ((MeilaTrust > 59) && (flags[kFLAGS.CERAPH_FOLLOWER_PIERCING] ==1 )) {
            outputText("Meila leans in, looking around. “There is something you should know. You may have some measure of control over Ceraph…But that token you wear is cursed. Ceraph can’t overtly control you through it, but she can manipulate your emotional state.” She whispers this, looking around fearfully. “She submits to you because she enjoys it. It’s a novel experience for her…But she’s stronger than you think, especially since you have that thing attached to you.” \n\n");
        } else if ((MeilaTrust > 59) && (whosincharge == 0) ) {
            //high trust
            outputText("Meila leans in, slightly worried. “Ceraph is still a threat to you, champion. Please, believe me when I say…She’s not a submissive by nature. She lets you think you’re in charge, it makes her wet…But please, don’t make the same mistake that…That I did. Don’t count her as yours forever.” \n\n");
            //Ceraph Ousted, Meila in Charge
        }
if (whosincharge == 1) {
    outputText("Meila gives you a wicked little grin, tapping the side of her head. “Oh, Ceraph’s still in anguish…or at least, she would be, if she could think straight. Poor dear hasn’t had a rest break in a few days. She’s quite the popular attraction.”\n\n");
    outputText("Meila sighs contentedly. “I can feel her losing her grip, you know. Part of me’s been tempted to grow myself a cock, just so I can have the pleasure of taking her…But no. I don’t want to sully myself with that bitch.” \n\n");
}
    //Ceraph Ousted, Nolan in charge
        if (whosincharge == 2) {
            outputText("Meila gives you a smirk. “She’s gotten quite popular. Her mind’s degraded, but she can still feel and understand what’s happening to her. Jabba has her waiting on that imp-like demon she hates, Derail, for most of the day when he’s here. When he’s not, she’s whored out, but she’s unable to cum. I got to watch the last time her collar needed maintenance, and the look of horror on her face was exquisite.” Meila gives you a smoldering look. “I have you to thank for that.” \n\n");
            doNext(MeilaTalk);
        }
    }

    private function MeilaTalkHistory():void {
        clearOutput();
        outputText("“We…Well…If you really want to know…I can’t really deny you, can I?” The thought seems to bother Meila, but she sighs, pushing past it. \n\n");
        outputText("“I was born in a village not far from He Din Xiao. My childhood was peaceful, but the war had started not long after I was born. At first, it wasn’t much. The war started quite far away from our town, and besides, the SoulForce of our neighbors…Well, they still frighten me. My town had a proud history of magic-users and enchanters, and I grew up in relative peace. We saw many people coming through, usually to go to the soul-slingers for help, or to learn their arts as quickly as possible. My mom was a soul-slinger, but she retired when she met my dad.” Meila sighs. \n\n");
        outputText("All the time, we’d hear of towns and cities falling to the demons, along with refugees fleeing to He-Din Xiao. As I grew up, those visits, the refugees, and the warriors heading out to fight…Began to slow. We thought it was a good thing…But we were wrong. Our mayor didn’t tell us, because he didn’t want a panic…But the truth was that the demons were getting closer.” \n\n");
        outputText("Meila looks down at her feet. “During that time, I married. We were happy together, for a time. He was the town alchemist, and I was our healer’s apprentice.” You tilt your head questioningly, and she blushes slightly. “When you have so many different species, it takes a while to learn them all.” \n\n");
        outputText("You ask her his name, and she looks down at her feet. “Bèndàn…He’s like me, I suppose, forced to serve Ceraph.” She spits, scowling at the ground. “Unlike me, he was stupid enough to think he could beat a demoness at her own game.” \n\n");
        outputText("You blink. The bitter party drug zombie? Now that you think about it, it makes sense, in a fucked up kind of way…Wait, did he try to fuck an omnibus like Ceraph down? You ask Meila, and she laughs, a bitter, humorless bark. “He had a concoction. Something he had brewed up that helped to clot internal injuries…That had the side effect of rendering male patients painfully erect, and completely unable to cum.” She hugs herself, looking down. “So when the demons defeated our mages, killed our warriors…and that…CUNT came forth, giving us the option to survive…If a chosen villager could fuck her senseless, dominate her…She’d order the demons to spare our village…Bèndàn slugged back a pitcher of his…concoction, and stepped forward.”\n\n");
        outputText("You hesitate for a moment, before opening your mouth. She knows what you’re going to ask, and she rolls her eyes. “Obviously he lost. Ceraph played with him for nearly a full day, outlasting the effects of his serum, before completely dominating him.” She seems a little saddened. “She forced me to watch, you know. Watch as she toyed with my husband. Let him think he was winning, fucking her ‘senseless’...And any attempt I made to warn him only got me…Punished.” She shudders at that. “I apologize…But I don’t wish to relive that day any more than I already have.” Meila seems fragile, even more so than usual. You can think of more than one way to try and “comfort” her.\n\n");
        menu();
        addButton(1, "GiveHand", MeilaOfferHand);
        addButton(2, "Sex?", MeilaOfferHelpForget);
    }

    private function MeilaOfferHelpForget():void {
        clearOutput();
        outputText("You tell Meila that if she wants to get off the topic, you can think of a few ways to help her…move past it. This gets a frown from her. “With all due respect, [Master], I think I’d rather get back to work.” Meila walks past you and out the door, immediately striking up a conversation with a demon outside. ");
        doNext(DaintyDullahan);
    }

    private function MeilaOfferHand():void {
        clearOutput();
        outputText("You offer your hand, and Meila takes it. “...Thank you for listening. It’s…comforting to know that even in this place of degeneracy, there’s someone who understands how to truly connect with others…In ways other than copulation.” \n\n");
        outputText("For a few moments, you just sit there with the Dainty Dullahan, and she eventually turns, looking away. “S-sorry, but I think I just heard the bell. I should go deal with that.”\n\n");
        outputText("You decide to leave Meila alone for now, and head back to the domain.\n\n");
        MeilaTrust += 5;
        doNext(DaintyDullahan);
    }


    private function MeilaCheckOut():void {
        clearOutput();
        outputText("Meila is a 5’3, waif of a woman. Her porcelain skin seems to reflect the amber light, and her blue eyes are deep and wide. She has neatly braided ebony hair that grows down her back, reaching her waist. She has a small button-nose and full, red lips. Her arms, legs, and body are thin and petite, but her B-cup breasts and feminine hips give her an unmistakable hourglass figure.\n\n");
        outputText("She wears a pink crop-top that clings to her breasts, showing off the outline of her nipples through the fabric. Her lower half is covered by a frilly pink short skirt, and her legs are clad in warm black stockings that end somewhere inside the skirt. \n\n");
        outputText("She daintily coughs, and you bring your eyes back to her face. “What do you need, [master]?”\n\n");
        doNext(DaintyDullahan);
    }

    public function BeNiceToMeila1stMeeting():void {
        outputText("She scoops her head up, shaking slightly. As she puts her head back onto her shoulders, you ask her if she’s alright, offering her a hand up. She takes it, and with no effort, you pull the tiny woman to her feet. \n\n");
        outputText("“I’ll be fine, thank you.” She seems less shaken up, but a little wary of you still. “Anyways…Allow me to introduce my services properly.” She curtseys, the nervousness seeming to vanish instantly. “The Dainty Dullahan is a new startup, courtesy of Mistress Ceraph…and my own magical abilities.” She spins her body, keeping her head pointed towards you as she points back at the cages. “Using our little friends here, as well as some special magic by yours truly, we can help you reach your ideal body type!”\n\n");
        outputText("You note the lack of selection, and she blushes at that. “Well, I did say that this is a startup.” She sighs, looking at the magically trapped beings. “I haven’t been allowed to leave and gather more templates.” She claps her hands together, spinning on one foot and heading back behind the counter. As you watch, she motions with one hand, levitating her head up and into a basket near the ceiling. “Is there anything I can assist you with today?”\n\n");
        MeilaTrust += 5;
        menu();
        addButton(0, "Appearance", MeilaCheckOut);
        addButton(1, "Talk", MeilaTalk);
        addButton(2, "Sex", MeilaSexMenu);
        addButton(3, "D.Dull", MeilaBusiness);
    }

    public function MeilaFirstFuckMenu():void {
        clearOutput();
        outputText("You scoop up the head, a mischievous grin on your face. Meila’s body reaches towards you, but stops in her tracks, and she whimpers pitifully as you turn her head to face you. Her cheeks are soft, her face cool to the touch.\n\n");
        outputText("“What are you going to do to me, [master] [Name]?” \n\n");
        outputText("");

        menu();
        if (player.hasCock()) {
            addButton(0, "Take'Head'", MeilaForcedBJ);
        }
        if (player.hasVagina()) {
            addButton(1, "ForceLick", MeilaForcedLick);
        }
            addButton(2, "GiveBack'", BeNiceToMeila1stMeeting);
    }

    public function MeilaBusiness():void {
        clearOutput();
        outputText("“To business, then.” She folds her hands in front of her. “What in particular do you wish to discuss?” \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton (1, "Status", DDullahanStatus);
        addButton (2, "TF_ME", DDullahanTFMenu);
        addButton (3, "GiveStock", DDullahanStock);
        addButton (4, "HowDisWork", MeilaTutorial);
    }

    private function DDullahanStatus():void {
        clearOutput();
        outputText("You ask about the status of her operation, and she visibly perks up. “Well, the concept is sound”, she declares happily. “Demons have expressed quite a lot of interest in a reliable, safe method of changing their bodies. Most of us have some sort of resistance by now, making most transformatives rather unreliable. And nobody wants to get stuck with body parts they don’t want.”  \n\n");
//10 or less TFs
        outputText("“Options are low, which limits business considerably. I could really use some more choices for customers”  \n\n");
        //11-15 choices

        outputText("“Business has picked up quite a bit since you brought in the last bunch. Thank you for your help.”  \n\n");
        //16-20 choices
        outputText("“Business is booming thanks to you! Customers are extremely happy with their purchases, and I may even need to hire some extra help, just to keep things running.”  \n\n");
        //20+ choices
        outputText("“The place is packed every day, and I’ve booked appointments out to a few months.” Meila smiles at you, a lazy, happy smile with half-lidded eyes. “I couldn’t be more happy with how this turned out, and the Dainty Dullahan is driving almost as much gems into our coffers as the strip club or the brothel.” She gives you a wink. “Thank you so much, [Master]”.\n \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");

    }

    private function DDullahanTFMenu():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        if (player.blockingBodyTransformations()) {
            outputText("Meila gives you a frown and shakes her head. \"Absolutely not, [Master]. Whatever you've done to yourself, it's well beyond my capacity to safely change. Unless you want to end up some deformed cripple, I can't do anything for you.\" \n\n");
            doNext(MeilaBusiness);
        } else {
            outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
            outputText(" \n\n");
            menu();
            addButton(0, "Pig", MeilaTFPigMenu);
            addButton(1, "Goblin", MeilaTFGoblinMenu);
            addButton(2, "Mouse", MeilaTFMouseMenu);
            addButton(3, "Imp", MeilaTFImpMenu);
            addButton(4, "Fox", MeilaTFFoxMenu);
            addButton(5, "Minotaur", MeilaTFMinotaurMenu);
            addButton(6, "A.Shark", MeilaTFAsharkMenu);
            addButton(7, "Alicorn", MeilaTFAlicornMenu);
            addButton(10, "Ant", MeilaTFAntMenu);
            addButton(11, "Anubis", MeilaTFAnubisMenu);
            addButton(12, "Apophis", MeilaTFApophisMenu);
            //addButton (13, "Arigean", MeilaTFArigeanMenu);
            addButton(14, "NextPage", DDullahanTFMenu2);
        }
    }

    private function MeilaTFPigMenu():void {
        menu();
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFGoblinMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void { CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor = randomChoice(GoblinRace.GoblinSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(5, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect();});
        addButton(6, "Hair",  function():void {  player.hairColor1 = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(7, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFMouseMenu():void {
        menu();
        addButton(0, "Face",  function():void {  CoC.instance.transformations.FaceMouse.applyEffect(); });
        addButton(1, "Ears",  function():void {  CoC.instance.transformations.EarsMouse.applyEffect();});
        addButton(2, "Legs",  function():void {  CoC.instance.transformations.LowerBodyMouse.applyEffect(); });
        addButton(3, "L.Fur",  function():void {  CoC.instance.transformations.SkinFur(1).applyEffect(); });
        addButton(4, "LM.Fur",  function():void {  CoC.instance.transformations.SkinFur(2).applyEffect(); });
        addButton(5, "MH. Fur",  function():void {  CoC.instance.transformations.SkinFur(3).applyEffect(); });
        addButton(6, "H.Fur",  function():void {  CoC.instance.transformations.SkinFur(4).applyEffect(); });
        addButton(7, "Tail",  function():void {  CoC.instance.transformations.TailMouse.applyEffect(); });
        addButton(12, "Hinezumi", HinezumiMenu);

        addButton (14, "Back", DDullahanTFMenu);
    }

    private function HinezumiMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHinezumi.applyEffect(); });
        addButton(1, "Eyes",  function():void {  CoC.instance.transformations.EyesHinezumi.applyEffect(); player.eyes.colour = "blazing red";});
        addButton(2, "Legs",  function():void {  CoC.instance.transformations.LowerBodyHinezumi.applyEffect(); });
        addButton(3, "Hair",  function():void { CoC.instance.transformations.HairBurning.applyEffect(); player.hairColor = randomChoice(MouseRace.MouseHairColors); });
        addButton(4, "BurningTail",  function():void {  CoC.instance.transformations.TailHinezumi.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFImpMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor = randomChoice(GoblinRace.GoblinSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFFoxMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsFox.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceFox.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesFox.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsFox.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyFoxBipedal.applyEffect(); });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairHuman.applyEffect(); player.hairColor1 = randomChoice(FoxRace.FoxHairColors); });
        addButton(8, "Fur",  function():void {  CoC.instance.transformations.SkinFur(4).applyEffect(); player.furColor1 = randomChoice(FoxRace.FoxFurColors);});
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailFox(1).applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFMinotaurMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCowMinotaur.applyEffect(); });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsCow.applyEffect();});
        addButton(3, "Legs",  function():void {  CoC.instance.transformations.LowerBodyClovenHoofedBipedal.applyEffect(); });
        addButton(4, "Fur",  function():void { CoC.instance.transformations.SkinFur(3).applyEffect();});
        addButton(5, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(6, "Horns",  function():void {  CoC.instance.transformations.HornsCowMinotaur.applyEffect(); });
        addButton(7, "Tail",  function():void {  CoC.instance.transformations.TailCow.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFAsharkMenu():void {
        menu();
        addButton(0, "ScaleColor",  function():void {  player.skinColor = randomChoice(AbyssalSharkRace.AbyssalSharkScaleColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAbyssalShark.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesDevil.applyEffect();  });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsShark.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyAbyssalShark.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyAbyssalSharkFin.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Scales", AbyssalSharkTFScalechoice);
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "Gills",  function():void {  CoC.instance.transformations.GillsFish.applyEffect();  });
        addButton(12, "SkinPattern",  function():void {  CoC.instance.transformations.SkinPatternBioluminescence.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailAbyssalShark.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function AbyssalSharkTFScalechoice():void {
        menu();
        addButton (0, "Scales", function():void {  CoC.instance.transformations.SkinScales(2).applyEffect();});
        addButton (1, "AquaScales", function():void {  CoC.instance.transformations.SkinAquaScales(2).applyEffect();});
        addButton (2, "DragonScales", function():void {  CoC.instance.transformations.SkinDragonScalesToFull.applyEffect();});
        addButton (14, "Back", MeilaTFAsharkMenu);
    }

    private function MeilaTFAlicornMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHorse.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsHorse.applyEffect();});
        addButton(5, "Hooves",  function():void {  CoC.instance.transformations.LowerBodyHoofedBipedal.applyEffect(); });
        addButton(6, "C.Hooves",  function():void {  CoC.instance.transformations.LowerBodyClovenHoofedBipedal.applyEffect(); });
        addButton(7, "N.Hair",  function():void {  player.hairColor = randomChoice(AlicornRace.NightmareHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "Horns", MeilaTFAlicornHornMenu );
        addButton(11, "U.Hair",  function():void {  player.hairColor = randomChoice(AlicornRace.AlicornHairColors); });
        addButton(12, "Wings", MeilaTFAlicornWingsMenu );
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailHorse.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFAlicornWingsMenu():void {
        menu();
        addButton(0, "Alicorn",  function():void {  CoC.instance.transformations.WingsFeatheredAlicorn.applyEffect();  });
        addButton(1, "Nightmare",  function():void {  CoC.instance.transformations.WingsNightmare.applyEffect();  });
        addButton (14, "Back", MeilaTFAlicornMenu);
    }

    private function MeilaTFAlicornHornMenu():void {
        menu();
        addButton(0, "Bicorn",  function():void {  CoC.instance.transformations.HornsBicorn.applyEffect();  });
        addButton(1, "Unicorn",  function():void {  CoC.instance.transformations.HornsUnicorn.applyEffect();  });
        addButton (14, "Back", MeilaTFAlicornMenu);
    }

    private function MeilaTFAntMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnt.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsInsect.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyAnt.applyEffect(); });
        addButton(6, "AntArms",  function():void {  CoC.instance.transformations.ArmsAnt.applyEffect(); });
        addButton(7, "Chitin",  function():void {  CoC.instance.transformations.SkinChitinToFull.applyEffect(); });
        addButton(8, "Antenna",  function():void {  CoC.instance.transformations.AntennaeAnt.applyEffect(); });
        addButton(9, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(10, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(11, "Wings", MeilaTFAntWingMenu);
        addButton(12, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFAntWingMenu():void {
        menu();
        addButton(0, "BeeSmall",  function():void {  CoC.instance.transformations.WingsBeeSmall.applyEffect();  });
        addButton(1, "Beelarge",  function():void {  CoC.instance.transformations.WingsBeeLarge.applyEffect();  });
        addButton(2, "Antsmall",  function():void {  CoC.instance.transformations.WingsAntSmall.applyEffect();  });
        addButton(1, "AntLarge",  function():void {  CoC.instance.transformations.WingsAntLarge.applyEffect() });
        addButton (14, "Back", MeilaTFAntMenu);
    }
    private function MeilaTFAnubisMenu():void {
        menu();
        addButton(0, "Tongue",  function():void {  CoC.instance.transformations.TongueDog.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceDog.applyEffect(); });
        addButton(2, "Eyes",  function():void {   CoC.instance.transformations.FaceDog.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsJackal.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyDogBipedal.applyEffect(); });
        addButton(6, "Arms",  function():void {  CoC.instance.transformations.ArmsCanine.applyEffect(); });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairHuman.applyEffect(); });
        addButton(8, "GlyphPattern",  function():void {  CoC.instance.transformations.SkinPatternAnubis.applyEffect(); });
        addButton(9, "Coloration", MeilaTFAnubisColors );
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailDog.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFAnubisColors():void {
        menu();
        addButton(0, "EyeColor",  function():void {  player.hairColor = randomChoice(AnubisRace.AnubisHairColors);  });
        addButton(1, "Haircolor",  function():void {  player.hairColor = randomChoice(AnubisRace.AnubisHairColors);  });
        addButton(2, "Furcolor",  function():void {  player.hairColor = randomChoice(AnubisRace.AnubisHairColors);  });
        addButton(3, "Skincolor",  function():void {  player.hairColor = randomChoice(AnubisRace.AnubisHairColors); });
        addButton (14, "Back", MeilaTFAnubisMenu);
    }

    private function MeilaTFApophisMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor1 = "light purple" });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSnakeFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSnakeFiendish.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsSnake.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodySnake.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyCobraHood.applyEffect(); });
        addButton(7, "Arms",  function():void { CoC.instance.transformations.ArmsHuman.applyEffect();  });
        addButton(8, "Scales",  function():void {  CoC.instance.transformations.SkinScales(2).applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  player.hairColor = randomChoice(ApophisRace.ApophisHairColors);  });
        addButton(10, "Tongue",  function():void {  CoC.instance.transformations.TongueSnake.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function MeilaTFArigeanMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesArigean.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElven.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu);
    }

    private function DDullahanTFMenu2():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu);
        addButton (1, "Avian", MeilaTFAvianMenu);
        //addButton (2, "Azazel", MeilaTFAzazelMenu);
        addButton (3, "Banshee", MeilaTFBansheeMenu);
        addButton (4, "Bat", MeilaTFBatMenu);
        addButton (5, "Bear", MeilaTFBearMenu);
        addButton (6, "Bee", MeilaTFBeeMenu);
        addButton (7, "Bunny", MeilaTFBunnyMenu);
        addButton (8, "Cancer", MeilaTFCancerMenu);
        addButton (9, "Cat", MeilaTFCatMenu);
        addButton (10, "C.Wyrm", MeilaTFCWyrmMenu);
        addButton (11, "Centaur", MeilaTFCentaurMenu);
        addButton (12, "Centipede", MeilaTFCentipedeMenu);
        addButton (13, "Cheshire", MeilaTFCheshireMenu);
        addButton (14, "NextPage", DDullahanTFMenu3);
    }

    private function MeilaTFAvianMenu():void {
        menu();
        addButton(0, "HairType",  function():void {  CoC.instance.transformations.HairFeather.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAvian.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesGryphon.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsAvian.applyEffect();});
        addButton(5, "Arms",  function():void {  CoC.instance.transformations.ArmsAvian.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        //addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(11, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredAvian.applyEffect(); });
        addButton(12, "Tail",  function():void {  CoC.instance.transformations.TailAvian.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFAzazelMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFBansheeMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFBatMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsBatWing.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceVampire.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyBatCollar.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFBearMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsBear.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceBear.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesBear.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsBear.applyEffect();});
        addButton(4, "Furcolor",  function():void {  player.furColor1 = randomChoice(BearRace.BearFurColors); });
        addButton(5, "Fur",  function():void {  CoC.instance.transformations.SkinFur(2).applyEffect(); });
        addButton(6, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyBearBipedal.applyEffect(); });
        addButton(7, "Tail",  function():void {  CoC.instance.transformations.TailBear.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFBeeMenu():void {
        menu();
        addButton(0, "Hair",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(1, "Oviposition",  function():void {  CoC.instance.transformations.OvipositorBee.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSandTrap.applyEffect(); });
        addButton(5, "Arms",  function():void {  CoC.instance.transformations.ArmsBee.applyEffect();});
        addButton(6, "Legs",  function():void {  CoC.instance.transformations.LowerBodyBee.applyEffect(); });
        addButton(7, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(8, "Skin",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(9, "Chitin",  function():void {  CoC.instance.transformations.SkinPatternBeeStripes.applyEffect(); });
        addButton(10, "Antennae",  function():void {  CoC.instance.transformations.AntennaeBee.applyEffect(); });
        addButton(13, "Wings", MeilaBeeWings);
        addButton(14, "BeeButt",  function():void {  CoC.instance.transformations.TailBee.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaBeeWings():void {
        menu();
        addButton(0, "SmallWings", function():void {  CoC.instance.transformations.WingsBeeSmall.applyEffect(); });
        addButton(1, "LargeWings", function():void {  CoC.instance.transformations.WingsBeeLarge.applyEffect(); });
        addButton (14, "Back", MeilaTFBeeMenu);
    }

    private function MeilaTFBunnyMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceBunny.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsBunny.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyBunny.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Fur",  function():void {  CoC.instance.transformations.SkinFur(2).applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(6, "Tail",  function():void {  CoC.instance.transformations.TailRabbit.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFCancerMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceKudere.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCancer.applyEffect(); player.eyes.colour = "orange"; });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsHuman.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyCancer.applyEffect(); });
        addButton(7, "Hair",  function():void {  CoC.instance.transformations.HairHuman.applyEffect(); });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        //add Cancer Vagina/Cocks here
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFCatMenu():void {
        menu();
        addButton(0, "Arms",  function():void { CoC.instance.transformations.ArmsCat.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCat.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCat.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsCat.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyCatBipedal.applyEffect(); });
        addButton(6, "Tongue",  function():void {  CoC.instance.transformations.TongueCat.applyEffect(); });
        addButton(8, "Fur", MeilaTFCatFur);
        addButton(9, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailCat.applyEffect(); });
        //Add Breast Reqs and Cock Reqs in submenu
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function MeilaTFCatFur():void {
        menu();
        addButton(0, "Low", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "Medium", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "High", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "Full", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(14, "Back", MeilaTFCatMenu);
    }

    private function MeilaTFCWyrmMenu():void {
        menu();
        addButton(0, "Scales", MeilaTFCWyrmSkin);
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSalamanderFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCaveWyrm.applyEffect(); player.eyes.colour = "orange"; });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsCaveWyrm.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyCaveWyrm.applyEffect(); });
        addButton(6, "Arms",  function():void { CoC.instance.transformations.ArmsCaveWyrm.applyEffect(); });
        addButton(8, "Tongue",  function():void {  CoC.instance.transformations.TongueCaveWyrm.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "GlowNips",  function():void {  CoC.instance.transformations.NipplesGlowing.applyEffect(); });
        addButton(11, "GlowAss",  function():void {  CoC.instance.transformations.AssholeGlowing.applyEffect();  });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailCaveWyrm.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }
    private function MeilaTFCWyrmSkin():void {
        menu();
        addButton(0, "Low", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(1, "Medium", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(2, "High", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(4, "Full", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton(14, "Back", MeilaTFCatMenu);
    }

    private function MeilaTFCentaurMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor = randomChoice(CentaurRace.CentaurSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsHuman.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  CoC.instance.transformations.HairHuman.applyEffect(); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "Legs",  function():void {  CoC.instance.transformations.LowerBodyClovenHoofedToggle(true).applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailHorse.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }



    private function MeilaTFCheshireMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsCat.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCheshireSmile.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsCat.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyCatBipedal.applyEffect(); });
        addButton(6, "Eyecolor",  function():void {  player.eyes.colour = "yellow"; });
        addButton(7, "Tongue",  function():void {  CoC.instance.transformations.TongueCat.applyEffect(); });
        addButton(8, "Fur", MeilaTFCheshireFurAndColor);
        addButton(9, "Tail",  function():void {  CoC.instance.transformations.TailCat.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }
    private function MeilaTFCheshireFurAndColor():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(6, "Eyecolor",  function():void {  player.eyes.colour = "yellow"; });

        addButton(7, "Furcolor",  function():void {  player.furColor2 = "light purple"; });
        addButton(8, "Haircolor",  function():void {  player.hairColor2 = "light purple"; });

        addButton(14, "Back", MeilaTFCheshireMenu);
    }

    private function MeilaTFCentipedeMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Skin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyCentipede.applyEffect(); });
        addButton(5, "Rear",  function():void {  CoC.instance.transformations.RearBodyCentipede.applyEffect(); });
        addButton(6, "Antenna",  function():void {  CoC.instance.transformations.AntennaeCentipede.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu2);
    }

    private function DDullahanTFMenu3():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu2);
        addButton (1, "Couatl", MeilaTFCouatlMenu);
        addButton (2, "Cow", MeilaTFCowMenu);
        addButton (3, "Cyclop", MeilaTFCyclopMenu);
        addButton (4, "D.Slime", MeilaTFDSlimeMenu);
        addButton (5, "Deer", MeilaTFDeerMenu);
        addButton (6, "Demon", MeilaTFDemonMenu);
        addButton (8, "Displacer", MeilaTFDisplacerMenu);
        addButton (9, "Dog", MeilaTFDogMenu);
        addButton (11, "Dragonne", MeilaTFDragonneMenu);
        addButton (12, "Dragon", MeilaTFDragonMenu);
        addButton (13, "E.Bunny", MeilaTFEbunnyMenu);
        addButton (14, "NextPage", DDullahanTFMenu4);
    }

    private function MeilaTFCouatlMenu():void {
        menu();
        addButton(0, "Colors", CouatlColorMenu);
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSnakeFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSnake.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsSnake.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodySnake.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyCobraHood.applyEffect(); });
        addButton(7, "Arms",  function():void { CoC.instance.transformations.ArmsHarpy.applyEffect();  });
        addButton(8, "Scales",  function():void {  CoC.instance.transformations.SkinScales(4).applyEffect(); });
        addButton(10, "Tongue",  function():void {  CoC.instance.transformations.TongueSnake.applyEffect(); });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsCouatl.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function CouatlColorMenu():void {
        menu();
        addButton(0, "HairCrimson", function():void {  player.hairColor1 = "crimson"; });
        addButton(1, "ScaleColorGreen",  function():void {  player.scaleColor1 = "green"; });
        addButton(2, "ScalecolorYellow",  function():void {  player.scaleColor2 = "yellow"; });
        addButton(3, "FeatherColorBlue",  function():void {  player.featherColor1 = "blue"; });
        addButton (14, "Back", DDullahanTFMenu3);
    }
    private function MeilaTFCowMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCowMinotaur.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsCow.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyClovenHoofedBipedal.applyEffect(); });
        addButton(5, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(6, "Horns",  function():void {  CoC.instance.transformations.HornsCowMinotaur.applyEffect(); });
        addButton(7, "Tail",  function():void {  CoC.instance.transformations.TailCow.applyEffect(); });
        //add Vag, tits and lactation
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function MeilaTFCyclopMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eye",  function():void {  CoC.instance.transformations.EyesMonoeye.applyEffect();  });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsHuman.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "No_Rearbody",  function():void {  CoC.instance.transformations.RearBodyNone.applyEffect(); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function MeilaTFDSlimeMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor1 = randomChoice(DarkSlimeRace.DarkSlimeSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void { CoC.instance.transformations.RearBodyMetamorphicGoo.applyEffect(); });
        addButton(7, "Hair",  function():void {  CoC.instance.transformations.HairGoo.applyEffect(); });
        addButton(8, "GooSkin",  function():void {  CoC.instance.transformations.SkinGooToFull.applyEffect(); player.isGooSkin(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function MeilaTFDeerMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsReindeer.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceDeer.applyEffect(); });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsDeer.applyEffect();});
        addButton(3, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyClovenHoofedBipedal.applyEffect(); });
        addButton(4, "Fur",  function():void {  CoC.instance.transformations.SkinFur(4).applyEffect(); });
        addButton(5, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(6, "Horns", DeerHornMenu);
        addButton(7, "Tail",  function():void {  CoC.instance.transformations.TailDeer.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function DeerHornMenu():void {
        addButton(0, "Small",  function():void {  CoC.instance.transformations.HornsAntlers.applyEffect(); });
        addButton(1, "Medium",  function():void {  CoC.instance.transformations.HornsAntlers.applyEffect(); });
        addButton(2, "Large",  function():void {  CoC.instance.transformations.HornsAntlers.applyEffect();});
        addButton (14, "Back", MeilaTFDeerMenu);
    }

    private function MeilaTFDemonMenu():void {
        menu();
        addButton(0, "Tongue",  function():void {  CoC.instance.transformations.TongueDemonic.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceDemon.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesDemon.applyEffect(); });
        addButton(3, "Arms",  function():void {  CoC.instance.transformations.ArmsDemon.applyEffect();});
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(6, "Eyecolor",  function():void {  player.eyes.colour = "red";});
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Skin/Wings", DemonExtraMenu1 );
        addButton(9, "Horns",  function():void {  CoC.instance.transformations.HornsDemonic.applyEffect(); });
        addButton(10, "Tail",  function():void {  CoC.instance.transformations.TailDemonic.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function DemonExtraMenu1():void {
        menu();
        addButton(0, "SmallWings",  function():void {  CoC.instance.transformations.WingsDemonicTiny.applyEffect();  });
        addButton(1, "LargeWings",  function():void {  CoC.instance.transformations.WingsDemonicTiny.applyEffect(); });
        addButton(2, "Skin1",  function():void {  player.skinColor1 = randomChoice(DemonRace.DemonSkinColors); });
        addButton(3, "Skin2",  function():void {  player.skinColor2 = randomChoice(DemonRace.DemonSkin2Colors); });
        addButton(4, "Heels",  function():void {  CoC.instance.transformations.LowerBodyDemonHighHeels.applyEffect(); });
        addButton(5, "G.Feet",  function():void {  CoC.instance.transformations.LowerBodyDemonGracefulFeet.applyEffect(); });
        addButton(6, "ClawFeet",  function():void {  CoC.instance.transformations.LowerBodyDemonClawedBipedal.applyEffect(); });
		addButton(7, "HoofFeet",  function():void {  CoC.instance.transformations.LowerBodyDemonHoofedBipedal.applyEffect(); });
		addButton(8, "Cl.HoofFeet",  function():void {  CoC.instance.transformations.LowerBodyDemonClovenHoofedBipedal.applyEffect(); });
        addButton(9, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
    }

    private function MeilaTFDisplacerMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsDisplacer.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCatCanines.applyEffect(); });
        addButton(2, "Eyes",  function():void {  player.eyes.colour = "yellow"; CoC.instance.transformations.EyesDisplacer.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsDisplacer.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyLionBipedal.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyDisplacerTentacles.applyEffect(); });
        addButton(7, "Fur/Skin", DisplacerFurMenu);
        addButton(9, "Tongue",  function():void {  CoC.instance.transformations.TongueCat.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailCat.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function DisplacerFurMenu():void {
            menu();
            addButton(0, "LowFur", function ():void {
                CoC.instance.transformations.SkinFur(1).applyEffect();
            });
            addButton(1, "MediumFur", function ():void {
                CoC.instance.transformations.SkinFur(2).applyEffect();
            });
            addButton(2, "HighFur", function ():void {
                CoC.instance.transformations.SkinFur(3).applyEffect();
            });
            addButton(4, "FullFur", function ():void {
                CoC.instance.transformations.SkinFur(4).applyEffect();
            });
            addButton(5, "Furcolor",  function():void {  player.furColor1 = randomChoice(DisplacerBeastRace.DisplacerFurColors); });
            addButton(6, "Haircolor",  function():void {  player.skinColor1 = "dark gray"; });

            addButton(14, "Back", MeilaTFDisplacerMenu);
    }

    private function MeilaTFDogMenu():void {
        menu();
        addButton(0, "Face",  function():void {  CoC.instance.transformations.FaceDog.applyEffect(); });
        addButton(1, "Eyes",  function():void {  player.eyes.colour = "yellow"; CoC.instance.transformations.EyesDisplacer.applyEffect();});
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsDog.applyEffect();});
        addButton(3, "Legs",  function():void {  CoC.instance.transformations.LowerBodyDogBipedal.applyEffect(); });
        addButton(4, "RearBody",  function():void {  CoC.instance.transformations.RearBodyDisplacerTentacles.applyEffect(); });
        addButton(5, "Fur", DogFurMenu);
        addButton(6, "Tail",  function():void {  CoC.instance.transformations.TailDog.applyEffect(); });
       // addButton(7, "Nipples", function():void {player.breastRows = 3;});
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function DogFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });

        addButton(14, "Back", MeilaTFDogMenu);
    }

    private function MeilaTFDragonneMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsLion.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCatCanines.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCat.applyEffect(); player.eyes.colour = "red"; });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsCat.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyLionBipedal.applyEffect(); });
        addButton(6, "Mane",  function():void {  CoC.instance.transformations.RearBodyLionMane.applyEffect(); });
        addButton(7, "Fur/Scales",  Dragonneoptions);
        addButton(8, "2Horns",  function():void {  CoC.instance.transformations.HornsDraconicDual.applyEffect(); });
        addButton(9, "4Horns",  function():void {  CoC.instance.transformations.HornsDraconicQuadruple.applyEffect(); });
        addButton(10, "SmallWings",  function():void {  CoC.instance.transformations.WingsDraconicSmall.applyEffect(); });
        addButton(11, "MedWings",  function():void {  CoC.instance.transformations.WingsDraconicLarge.applyEffect();  });
        addButton(12, "LargeWings",  function():void {  CoC.instance.transformations.WingsDraconicHuge.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailCat.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function Dragonneoptions():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(5, "ScaleColor",  function():void {  player.scaleColor1 = randomChoice(DragonneRace.DragonneScaleColors); });
        addButton(6, "FurColor",  function():void {  player.furColor1 = randomChoice(DragonneRace.DragonneFurColors); });
        addButton(7, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(8, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(9, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(10, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });

        addButton(14, "Back", MeilaTFDragonneMenu);
    }

    private function MeilaTFDragonMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsDraconic.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceDragonFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesDraconic.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsDraconic.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyDraconicBipedal.applyEffect(); });
        addButton(6, "Horn/Scale", Dragonoptions );
        addButton(7, "Tail",  function():void {  CoC.instance.transformations.TailDraconic.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function Dragonoptions():void {
        menu();
        addButton(0, "Hornx2", function ():void {
            CoC.instance.transformations.HornsDraconicDual.applyEffect();
        });
        addButton(1, "Hornx4", function ():void {
            CoC.instance.transformations.HornsDraconicQuadruple.applyEffect();
        });
        addButton(2, "SmallWings", function ():void {
            CoC.instance.transformations.WingsDraconicSmall.applyEffect();
        });
        addButton(3, "MedWings", function ():void {
            CoC.instance.transformations.WingsDraconicLarge.applyEffect();
        });
        addButton(4, "MedWings", function ():void {
            CoC.instance.transformations.WingsDraconicHuge.applyEffect();
        });
        addButton(5, "ScaleColor",  function():void {  player.scaleColor1 = randomChoice(DragonRace.DragonScaleColors); });
        addButton(7, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(8, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(9, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(14, "Back", MeilaTFDragonMenu);
    }

    private function MeilaTFEbunnyMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceBuckteeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsBunny.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyBunny.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "FurMenu", EbunnyFurMenu);
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailRabbit.applyEffect(); });
        //Add Bunny Balls,
        addButton (14, "Back", DDullahanTFMenu3);
    }

    private function EbunnyFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton (14, "Back", MeilaTFEbunnyMenu);
    }

    private function DDullahanTFMenu4():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu3);
        addButton (1, "Echidna", MeilaTFEchidnaMenu);
        addButton (2, "Elf", MeilaTFElfMenu);
        addButton (3, "FaeDrag", MeilaTFFaeDragMenu);
        //addButton (4, "Fairy", MeilaTFFairyMenu);
        addButton (5, "Ferret", MeilaTFFerretMenu);
        addButton (6, "F.Snail", MeilaTFFSnailMenu);
        addButton (7, "F.Wyrm", MeilaTFFwyrmMenu);
        addButton (8, "Gazer", MeilaTFGazerMenu);
        addButton (9, "G.Troll", MeilaTFGtrollMenu);
        addButton (10, "Gorgon", MeilaTFGorgonMenu);
        //addButton (11, "Gremlin", MeilaTFGremlinMenu);
        addButton (12, "Gryphon", MeilaTFGryphonMenu);
        addButton (13, "Harpy", MeilaTFHarpyMenu);
        addButton (14, "NextPage", DDullahanTFMenu5);
    }

    private function MeilaTFEchidnaMenu():void {
        menu();
        //addButton(0, "SkinColor",  function():void {  player.skinColor = randomChoice(GoblinRace.GoblinSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceEchidna.applyEffect(); });
       // addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        //addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsEchidna.applyEffect();});
        //addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyE.applyEffect(); });
        //addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Fur", EchidnaFurMenu );
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function EchidnaFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton (14, "Back", MeilaTFEchidnaMenu);
    }

    private function MeilaTFElfMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function MeilaTFFaeDragMenu():void {
        menu();
        addButton(0, "Skin",  function():void { CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor = randomChoice(ElfRace.ElfSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceElf.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElven.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyElf.applyEffect(); });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairSilky.applyEffect(); player.hairColor = randomChoice(ElfRace.ElfHairColors); });
        addButton(8, "Tongue",  function():void {  CoC.instance.transformations.TongueElf.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

   /* private function MeilaTFFairyMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor = randomChoice(GoblinRace.GoblinSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceFairy.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesFairy.applyEffect();  });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElven.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyElf.applyEffect(); });
        addButton(6, "Tongue",  function():void {  CoC.instance.transformations.TongueElf.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsFairy.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }
*/
    private function MeilaTFFSnailMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesFireSnail.applyEffect(); CoC.instance.transformations.EyesChangeColor(FireSnailRace.FireSnailEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodySnailShell.applyEffect(); });
        addButton(7, "Hair",  function():void {CoC.instance.transformations.HairBurning.applyEffect();  player.hairColor = randomChoice(FireSnailRace.FireSnailEyeColors); });
        addButton(8, "Skin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor1 = randomChoice(FireSnailRace.FireSnailSkinColors);});
        addButton(9, "Antenna",  function():void {  CoC.instance.transformations.AntennaeFireSnail.applyEffect(); });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function MeilaTFFerretMenu():void {
        menu();
        addButton(0, "Face",  function():void {  CoC.instance.transformations.FaceFerret.applyEffect(); });
        addButton(1, "Eyes",  function():void { CoC.instance.transformations.EyesWeasel.applyEffect();  player.eyes.colour = "golden"; });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsFerret.applyEffect();});
        addButton(3, "Legs",  function():void {  CoC.instance.transformations.LowerBodyFerret.applyEffect(); });
        addButton(4, "Fur",  FerretFurMenu);
        addButton(5, "Tail",  function():void {  CoC.instance.transformations.TailFerret.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function FerretFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton (14, "Back", MeilaTFFerretMenu);
    }

    private function MeilaTFFwyrmMenu():void {
        menu();
        addButton(0, "Tongue",  function():void {  CoC.instance.transformations.TongueDraconic.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesFrostwyrm.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsDraconic.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyFrostwyrm.applyEffect(); });
        addButton(6, "RearBody",  function():void {   CoC.instance.transformations.RearBodyFrostwyrm.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(FrostWyrmRace.FrostWyrmHairColors); });
        addButton(8, "Scales", FrostwyrmScalesMenu);
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "Horns",  function():void {  CoC.instance.transformations.HornsFrostwyrm.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function FrostwyrmScalesMenu():void {
        addButton(0, "ScaleColor",  function():void {  player.scaleColor1 = randomChoice(FrostWyrmRace.FrostWyrmScaleColos); });
        addButton(1, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(2, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(3, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(4, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton (14, "Back", MeilaTFFwyrmMenu);
    }

    private function MeilaTFGazerMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eye",  function():void {  CoC.instance.transformations.EyesMonoeye.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyGazer.applyEffect(); });
        //Add a Gazer Stalk Submenu
        //addButton(6, "RearBody",  function():void {   });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairHuman.applyEffect(); player.hairColor = randomChoice(GazerRace.GazerHairColors); });
        addButton(8, "Skin",  function():void { player.skinColor1 = randomChoice(GazerRace.GazerSkinColors); CoC.instance.transformations.SkinPlain.applyEffect(); CoC.instance.transformations.SkinPatternOil.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(12, "Levitation",  function():void {  CoC.instance.transformations.WingsLevitation.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function MeilaTFGtrollMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsGlacialTroll.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceGlacialTroll.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsGlacialTroll.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Fur",  function():void {player.furColor1 = randomChoice(GlacialTrollRace.GlacialTrollFurColors);  CoC.instance.transformations.SkinScales(4).applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailGlacialTroll.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function MeilaTFGorgonMenu():void {
        menu();
        menu();
        addButton(0, "Tongue",  function():void {  CoC.instance.transformations.TongueSnake.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSnakeFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSnake.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsSnake.applyEffect();});
        addButton(5, "SnakeLower",  function():void {  CoC.instance.transformations.LowerBodySnake.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  CoC.instance.transformations.HairGorgon.applyEffect(); });
        addButton(8, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(9, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(10, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(11, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function MeilaTFGryphonMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsGryphon.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAvian.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesGryphon.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsGryphon.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyGryphonBipedal.applyEffect(); });
        addButton(6, "RearBody",  function():void { CoC.instance.transformations.RearBodyLionMane.applyEffect(); });
        addButton(7, "Hair",  function():void {  CoC.instance.transformations.HairFeather.applyEffect();  });
        //Add Feathered Skin //addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredAvian.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailGriffin.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function MeilaTFHarpyMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHarpy.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyHarpy.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredLarge.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailHarpy.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu4);
    }

    private function DDullahanTFMenu5():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu4);
        addButton (1, "Hellcat", MeilaTFHellcatMenu);
        addButton (2, "Horse", MeilaTFHorseMenu);
        addButton (3, "Human", MeilaTFHumanMenu);
        addButton (4, "Hydra", MeilaTFHydraMenu);
        addButton (5, "Jabberwock", MeilaTFJabberwockMenu);
        addButton (6, "K.tachi", MeilaTFKtaichiMenu);
        addButton (7, "K.Roo", MeilaTFKrooMenu);
        addButton (8, "Kirin", MeilaTFKirinMenu);
        addButton (9, "Kitshoo", MeilaTFKitshooMenu);
        addButton (10, "Kitsune", MeilaTFKitsuneMenu);
        addButton (11, "Laquine", MeilaTFLaquineMenu);
        addButton (12, "Lizard", MeilaTFLizardMenu);
        addButton (13, "M.Slime", MeilaTFMSlimeMenu);
        addButton (14, "NextPage", DDullahanTFMenu6);
    }

    private function MeilaTFHellcatMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsCat.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCatCanines.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesInfernal.applyEffect();  });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsCat.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyCatBipedal.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(8, "Colors",  function():void {CoC.instance.transformations.SkinFur(4).applyEffect();  player.furColor1 = "midnight black"; player.skinColor1 = "ashen"; });
        addButton(9, "tongue",  function():void {  CoC.instance.transformations.TongueCat.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailTwinkasha.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFHorseMenu():void {
        menu();
        addButton(0, "Arms",  function():void { CoC.instance.transformations.ArmsHuman.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHorse.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Hooves",  function():void {  CoC.instance.transformations.LowerBodyHoofedBipedal.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Fur", HorseFurMenu);
        addButton(7, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(8, "NoTail",  function():void {  CoC.instance.transformations.TailHorse.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function HorseFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(5, "FurColor",  function():void {  player.skinColor = randomChoice(HorseRace.FurColors); });
        addButton (14, "Back", MeilaTFHorseMenu);
    }

    private function MeilaTFHumanMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor = randomChoice(HumanRace.HumanSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsHuman.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void { CoC.instance.transformations.RearBodyNone.applyEffect();});
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFHydraMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHydra.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSnakeFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSnake.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsSnake.applyEffect();});
        addButton(4, "LowerBody", HydraTailMenu);
        addButton(5, "RearBody",  function():void { CoC.instance.transformations.RearBodyNone.applyEffect();});
        addButton(6, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function HydraTailMenu():void {
        //Add the actual code for adding heads.
        addButton(0, "HydraTail",  function():void { CoC.instance.transformations.LowerBodyHydra.applyEffect();});
        addButton(1, "AddHead",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(2, "RemoveHead",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });

        addButton (14, "Back", MeilaTFHydraMenu);
    }

    private function MeilaTFJabberwockMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsJabberwocky.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceJabberwocky.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesDraconic.applyEffect(); player.eyes.colour = "red";});
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsBunny.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyJabberwocky.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairHuman.applyEffect(); player.hairColor1 = "purplish-pink"; });
        addButton(8, "Scales",  function():void {  CoC.instance.transformations.SkinScales(4).applyEffect(); player.scaleColor1 = randomChoice(JabberwockyRace.JabberwockyScaleColors); });
        addButton(9, "Tongue",  function():void {  CoC.instance.transformations.TongueDraconic.applyEffect(); });
        addButton(10, "Horns",  function():void {  CoC.instance.transformations.HornsJabberwocky.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsJabberwocky.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailDraconic.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFKtaichiMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsKamaitachi.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceWeasel.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesWeasel.applyEffect(); player.eyes.colour = "golden";});
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsWeasel.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyWeaselBipedal.applyEffect(); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairWindswept.applyEffect(); player.hairColor = randomChoice(KamaitachiRace.KamaitachiHairColors); });
        addButton(7, "Fur",  function():void {  CoC.instance.transformations.SkinScales(3).applyEffect(); player.furColor1 = randomChoice(KamaitachiRace.KamaitachiFurColors); });
        addButton(8, "Tongue",  function():void {  CoC.instance.transformations.TongueDraconic.applyEffect(); });
        addButton(9, "SkinPattern",  function():void {  CoC.instance.transformations.SkinPatternScarWindswept.applyEffect(); });
        addButton(10, "WindAura",  function():void {  CoC.instance.transformations.WingsWindyAura.applyEffect(); });
        addButton(11, "Tail",  function():void {  CoC.instance.transformations.TailDraconic.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFKrooMenu():void {
        menu();
        addButton(0, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(1, "Ears",  function():void {  CoC.instance.transformations.EarsKangaroo.applyEffect();});
        addButton(2, "Legs",  function():void {  CoC.instance.transformations.LowerBodyKangaroo.applyEffect(); });
        addButton(3, "Fur",  function():void {  CoC.instance.transformations.SkinScales(3).applyEffect(); });
        addButton(4, "Tail",  function():void {  CoC.instance.transformations.TailKangaroo.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFKirinMenu():void {
        menu();
        addButton(0, "Tongue",  function():void { CoC.instance.transformations.TongueDraconic.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesDraconic.applyEffect(); CoC.instance.transformations.EyesChangeColor(KirinRace.KirinEyeColors).applyEffect(); });
        addButton(4, "Glowing",  function():void {  CoC.instance.transformations.AssholeGlowing.applyEffect();  CoC.instance.transformations.NipplesGlowing.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyKirinBipedal.applyEffect(); });
        addButton(6, "R.Mane",  function():void {  CoC.instance.transformations.RearBodyRaijuMane.applyEffect(); });
        addButton(7, "Hair",  function():void {   CoC.instance.transformations.HairStorm.applyEffect(); player.hairColor = randomChoice(KirinRace.KirinHairColors); });
        addButton(8, "Arms",  function():void {  CoC.instance.transformations.ArmsLizard.applyEffect(); });
        addButton(9, "Ears",  function():void {  CoC.instance.transformations.EarsKirin.applyEffect(); });
        addButton(10, "Horns",  function():void {  CoC.instance.transformations.HornsKirin.applyEffect(); });
        //Add size adjusting for horns
        addButton(11, "ThndrAura",  function():void {  CoC.instance.transformations.WingsThunderousAura.applyEffect(); });
        addButton(12, "Tail",  function():void {  CoC.instance.transformations.TailKirin.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFKitshooMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor = randomChoice(KitshooRace.KitshooSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSalamanderFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesFox.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsFox.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodySalamanderBipedal.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(KitshooRace.KitshooHairColors); });
        addButton(8, "Skin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); CoC.instance.transformations.SkinPatternKitsune.applyEffect(); });
        addButton(13, "Tails", KitshooTailsMenu);
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function KitshooTailsMenu():void {
        addButton(0, "1 Tail",  function():void {  CoC.instance.transformations.TailKitshoo(1).applyEffect();  });
        addButton(1, "2 Tails",  function():void {  CoC.instance.transformations.TailKitshoo(2).applyEffect();  });
        addButton(2, "3 Tails",  function():void { CoC.instance.transformations.TailKitshoo(3).applyEffect(); });
        addButton(3, "4 Tails",  function():void {  CoC.instance.transformations.TailKitshoo(4).applyEffect();});
        addButton(4, "5 Tails",  function():void {  CoC.instance.transformations.TailKitshoo(5).applyEffect(); });
        addButton(5, "6 Tails",  function():void {  CoC.instance.transformations.TailKitshoo(6).applyEffect(); });
        addButton (14, "Back", MeilaTFKitshooMenu);
    }

    private function MeilaTFKitsuneMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsFox.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceFox.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesFox.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsFox.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyFoxBipedal.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor1 = randomChoice(KitsuneRace.KitsuneHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(13, "Tails", KitsuneTailsMenu);
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function KitsuneTailsMenu():void {
        addButton(0, "1 Tail",  function():void {  CoC.instance.transformations.TailFox(1).applyEffect();  });
        addButton(1, "2 Tails",  function():void {  CoC.instance.transformations.TailFox(2).applyEffect();  });
        addButton(2, "3 Tails",  function():void { CoC.instance.transformations.TailFox(3).applyEffect(); });
        addButton(3, "4 Tails",  function():void {  CoC.instance.transformations.TailFox(4).applyEffect();});
        addButton(4, "5 Tails",  function():void {  CoC.instance.transformations.TailFox(5).applyEffect(); });
        addButton(5, "6 Tails",  function():void {  CoC.instance.transformations.TailFox(6).applyEffect(); });
        addButton (14, "Back", MeilaTFKitshooMenu);
    }

    private function MeilaTFLaquineMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceBunny.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesHuman.applyEffect();  });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsBunny.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyBunny.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Fur",  function():void { CoC.instance.transformations.SkinFur(3).applyEffect();  });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailRabbit.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function MeilaTFLizardMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsLizard.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceLizard.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesLizard.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsLizard.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyLizardBipedal.applyEffect(); });
        addButton(6, "Scale/Horn", LizardScalesHornMenu);
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailLizard.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }
    private function LizardScalesHornMenu():void {
        menu();
        addButton(0, "DragonHornx2",  function():void {  CoC.instance.transformations.HornsDraconicDual.applyEffect(); });
        addButton(1, "DragonHornx4",  function():void {  CoC.instance.transformations.HornsDraconicQuadruple.applyEffect(); });
        addButton(2, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(3, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(4, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(5, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton(2, "LowDScales", function ():void {
            CoC.instance.transformations.SkinDragonScales(1).applyEffect();
        });
        addButton(3, "MediumDScales", function ():void {
            CoC.instance.transformations.SkinDragonScales(2).applyEffect();
        });
        addButton(4, "HighDScales", function ():void {
            CoC.instance.transformations.SkinDragonScales(3).applyEffect();
        });
        addButton(5, "FullDScales", function ():void {
            CoC.instance.transformations.SkinDragonScales(4).applyEffect();
        });
            addButton (14, "Back", MeilaTFLizardMenu);

    }
    private function MeilaTFMSlimeMenu():void {
        menu();

        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu5);
    }

    private function DDullahanTFMenu6():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu5);
        addButton (1, "Manticore", MeilaTFManticoreMenu);
        addButton (2, "Mantis", MeilaTFMantisMenu);
        addButton (3, "Melkie", MeilaTFMelkieMenu);
        addButton (4, "Moth", MeilaTFMothMenu);
        addButton (5, "Naga", MeilaTFNagaMenu);
        addButton (6, "Nekomata", MeilaTFNekomataMenu);
        addButton (7, "Oni", MeilaTFOniMenu);
        addButton (8, "Oomukade", MeilaTFOomukadeMenu);
        addButton (9, "Orca", MeilaTFOrcaMenu);
        addButton (10, "Orc", MeilaTFOrcMenu);
        addButton (11, "Peecock", MeilaTFHeheheMenu);
        addButton (12, "Phoenix", MeilaTFPhoenixMenu);
        addButton (13, "Plant", MeilaTFPlantMenu);
        addButton (14, "NextPage", DDullahanTFMenu7);
    }

    private function MeilaTFManticoreMenu():void {
        menu();
        addButton(0, "Face",  function():void {  CoC.instance.transformations.FaceManticore.applyEffect(); });
        addButton(1, "Eyes",  function():void {  CoC.instance.transformations.EyesManticore.applyEffect(); });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsLion.applyEffect();});
        addButton(3, "Legs",  function():void {  CoC.instance.transformations.LowerBodyLionBipedal.applyEffect(); });
        addButton(4, "Mane",  function():void {  CoC.instance.transformations.RearBodyLionMane.applyEffect(); });
        addButton(5, "Tongue",  function():void {  CoC.instance.transformations.TongueCat.applyEffect(); });
        addButton(6, "S.Wings",  function():void {  CoC.instance.transformations.WingsManticoreSmall.applyEffect(); });
        addButton(7, "L.Wings",  function():void {  CoC.instance.transformations.WingsManticoreLarge.applyEffect(); });
        addButton(8, "PussyTail",  function():void {  CoC.instance.transformations.TailManticore.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFMantisMenu():void {
        menu();
        addButton(0, "Chitin",  function():void {  player.chitinColor1 = randomChoice(MantisRace.MantisChitinColors); CoC.instance.transformations.SkinChitinToFull.applyEffect();});
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsInsect.applyEffect();});
        addButton(3, "Legs",  function():void {  CoC.instance.transformations.LowerBodyMantisBipedal.applyEffect(); });
        addButton(4, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(5, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(6, "Antenna",  function():void {  CoC.instance.transformations.AntennaeMantis.applyEffect(); });
        addButton(7, "S.Wings",  function():void {  CoC.instance.transformations.WingsMantisSmall.applyEffect(); });
        addButton(8, "L.Wings",  function():void {  CoC.instance.transformations.WingsMantisLarge.applyEffect();  });
        addButton(9, "Abdomen",  function():void {  CoC.instance.transformations.TailMantis.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFMelkieMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsMelkie.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  player.eyes.colour = "blue"; CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsMelkie.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyMelkie.applyEffect(); });
        addButton(6, "Tongue",  function():void {  CoC.instance.transformations.TongueMelkie.applyEffect(); });
        addButton(7, "SkinColor",  function():void {  player.hairColor = randomChoice(MelkieRace.MelkieSkinColors); });
        addButton(8, "Fur/Skin", MelkieFurMenu );
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MelkieFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(5, "FurColor",  function():void {  player.furColor1 = randomChoice(MelkieRace.MelkieFurColors); });
        addButton(5, "Skin",  function():void {  player.skinColor1 = randomChoice(MelkieRace.MelkieSkinColors); });
        addButton (14, "Back", MeilaTFMelkieMenu);
    }


    private function MeilaTFMothMenu():void {
        menu();
        addButton(0, "Chitin",  function():void {  CoC.instance.transformations.SkinChitinToFull.applyEffect(); player.chitinColor1 = randomChoice(MothRace.MothChitinColors);});
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesMoth.applyEffect();});
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsInsect.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyMoth.applyEffect(); });
        addButton(6, "Collar",  function():void {CoC.instance.transformations.RearBodyMoth.applyEffect();});
        addButton(7, "Antenna",  function():void {  CoC.instance.transformations.AntennaeMoth.applyEffect(); });
        addButton(8, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(9, "S.Wings",  function():void {  CoC.instance.transformations.WingsMothSmall.applyEffect();  });
        addButton(10, "L.Wings",  function():void {  CoC.instance.transformations.WingsMothLarge.applyEffect(); });
        addButton(11, "Abdomen",  function():void {  CoC.instance.transformations.TailMoth.applyEffect(); });
        addButton(12, "Arms",  function():void {  CoC.instance.transformations.ArmsMoth.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFNagaMenu():void {
        menu();
        addButton(0, "Scales", MeilaTFNagaScaleMenu);
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSnakeFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSnake.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsSnake.applyEffect();});
        addButton(5, "SnekCoils",  function():void {  CoC.instance.transformations.LowerBodySnake.applyEffect(); });
        addButton(6, "Arms",  function():void {  CoC.instance.transformations.ArmsHuman.applyEffect(); });
        addButton(6, "Tongue",  function():void {  CoC.instance.transformations.TongueSnake.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }
    private function MeilaTFNagaScaleMenu():void {
        menu();
        addButton(0, "ScaleColor", function():void {  player.scaleColor1 = randomChoice(NagaRace.SnakeScaleColors); });
        addButton(1, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(2, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(3, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(4, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton(14, "Back", MeilaTFNagaMenu);
    }
    private function MeilaTFNekomataMenu():void {
        menu();

        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCatCanines.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCat.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsCat.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyCatBipedal.applyEffect(); });
        addButton(6, "Mane",  function():void { CoC.instance.transformations.RearBodyLionMane.applyEffect(); });
        addButton(7, "Arms",  function():void {  CoC.instance.transformations.ArmsCat.applyEffect(); });
        addButton(8, "FurMenu", NekomataFurMenu);
        addButton(9, "Tongue",  function():void {  CoC.instance.transformations.TongueCat.applyEffect(); });
        addButton(10, "TwoTails",  function():void {  CoC.instance.transformations.TailCat2nd.applyEffect();  });
        addButton(11, "NormalTail",  function():void {  CoC.instance.transformations.TailCat.applyEffect(); });
        addButton(12, "ForkedTail",  function():void {  CoC.instance.transformations.TailNekomataTwoThirdsForked.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function NekomataFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton (14, "Back", MeilaTFNekomataMenu);
    }

    private function MeilaTFOniMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsOni.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceOniTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  player.eyes.colour = randomChoice(OniRace.OniEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsOni.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyOni.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyNone.applyEffect(); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Tattoo",  function():void {  CoC.instance.transformations.SkinPatternOni.applyEffect(); });
        addButton(9, "1Horn",  function():void {  CoC.instance.transformations.HornsOni.applyEffect(); });
        addButton(10, "2Horns",  function():void {  CoC.instance.transformations.HornsOniDual.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFOomukadeMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsCentipede.applyEffect();});
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCentipede.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyCentipede.applyEffect(); });
        addButton(6, "RearBody",  function():void {   CoC.instance.transformations.RearBodyCentipede.applyEffect();  });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Pattern",  function():void {  CoC.instance.transformations.SkinPatternVenomousMarkings.applyEffect(); });
        addButton(9, "Antenna",  function():void {  CoC.instance.transformations.AntennaeCentipede.applyEffect(); });
        addButton(10, "NoFurScales",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFOrcaMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsOrca.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceOrca.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); player.eyes.colour = "orange"; });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsOrca.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyOrcaBipedal.applyEffect(); });
        addButton(6, "Blowhole",  function():void {  CoC.instance.transformations.RearBodyOrcaBlowhole.applyEffect(); });
        addButton(7, "Hair",  function():void {  CoC.instance.transformations.HairHuman.applyEffect(); });
        addButton(8, "Skin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "Pattern",  function():void {  CoC.instance.transformations.SkinPatternOrca.applyEffect(); });
        addButton(10, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(11, "NoTail",  function():void {  CoC.instance.transformations.TailOrca.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFOrcMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsOrc.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceOrcFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesOrc.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyOrc.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(7, "OrcSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor1 = randomChoice(OrcRace.OrcSkinColors); });
        addButton(8, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFHeheheMenu():void {
        menu();
        addButton(0, "Arms",  function():void { CoC.instance.transformations.ArmsAvian.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAvian.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesGryphon.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyAvian.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Hair",  function():void {  CoC.instance.transformations.HairPeafowlFeather.applyEffect(); });
        addButton(7, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(8, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(9, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredAvian.applyEffect(); });
        addButton(10, "Tail",  function():void {  CoC.instance.transformations.TailAvian.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function MeilaTFPhoenixMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsPhoenix.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSalamanderFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesLizard.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsLizard.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHarpy.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(7, "Scales", MeilaTFPhoenixScaleMenu);
        addButton(8, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredPhoenix.applyEffect(); });
        addButton(9, "Tail",  function():void {  CoC.instance.transformations.TailSalamander.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }
    private function MeilaTFPhoenixScaleMenu():void {
        menu();
        addButton(0, "ScaleColor", function ():void {
            player.scaleColor1 = randomChoice(NagaRace.SnakeScaleColors);
        });
        addButton(1, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(2, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(3, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(4, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton(14, "Back", MeilaTFPhoenixMenu);
    }

    private function MeilaTFPlantMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsPlant.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Plantheels",  function():void {  CoC.instance.transformations.LowerBodyPlantHighHeels.applyEffect(); });
        addButton(5, "RootClaws",  function():void { CoC.instance.transformations.LowerBodyPlantRootClaws.applyEffect(); });
        addButton(6, "Hair",  function():void { player.hairColor = "green"; CoC.instance.transformations.HairLeaf.applyEffect(); });
        addButton(7, "Skin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor = "leaf green"; });
        addButton(8, "Barkskin",  function():void {  CoC.instance.transformations.SkinBarkToFull.applyEffect(); });
        addButton(9, "Horns",  function():void {  CoC.instance.transformations.HornsOak.applyEffect(); });
        addButton(10, "Wings",  function():void {  CoC.instance.transformations.WingsPlant.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu6);
    }

    private function DDullahanTFMenu7():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu6);
        addButton (1, "P.ghost", MeilaTFghostMenu);
        addButton (2, "Raccoon", MeilaTFRaccoonMenu);
        addButton (3, "Raiju", MeilaTFRaijuMenu);
        addButton (4, "Raisune", MeilaTFRaisuneMenu);
        addButton (5, "Ratatoskr", MeilaTFRatatoskrMenu);
        addButton (6, "R.Panda", MeilaTFRPandaMenu);
        //addButton (7, "Rhino", MeilaTFRhinoMenu);
        addButton (8, "Salamander", MeilaTFSalamanderMenu);
        addButton (9, "SandTrap", MeilaTFSandtrapMenu);
        addButton (9, "Yeti", MeilaTFYetiMenu);
        addButton (11, "Satyr", MeilaTFSatyrMenu);
        addButton (12, "Scorpion", MeilaTFScorpionMenu);
        addButton (13, "Scylla", MeilaTFScyllaMenu);
        addButton (14, "NextPage", DDullahanTFMenu8);
    }

    private function MeilaTFghostMenu():void {
        menu();
        addButton(0, "Arms",  function():void { CoC.instance.transformations.ArmsGhost.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceAnimalTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesGhost.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyGhost2.applyEffect(); });
        addButton(6, "RearBody",  function():void { CoC.instance.transformations.RearBodyGhostlyAura.applyEffect();});
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Skin",  function():void {  player.skinColor1 = randomChoice(PoltergeistRace.PoltergeistSkinColors); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "G.Horns",  function():void {  CoC.instance.transformations.HornsGhostlyWisps.applyEffect(); });
        addButton(11, "SkinPattern",  function():void {  CoC.instance.transformations.SkinPatternWhiteBlackVeins.applyEffect();  });
        addButton(12, "Floating",  function():void {  CoC.instance.transformations.WingsEthereal.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function MeilaTFRaccoonMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsRaccoon.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceRaccoonMask.applyEffect(); });
        addButton(2, "Eyes",  function():void {  player.skinColor ="golden"; });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsRaccoon.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyRaccoon.applyEffect(); });
        addButton(8, "Fur", RaccoonFurMenu);
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailRaccoon.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function RaccoonFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(4, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(5, "FurColor",  function():void {  player.furColor1 = randomChoice(RaccoonRace.RaccoonFurColors); });
        addButton(6, "HairColor",  function():void {  player.hairColor1 = randomChoice(RaccoonRace.RaccoonHairColors); });
        addButton (14, "Back", MeilaTFRaccoonMenu);
    }

    private function MeilaTFRaijuMenu():void {
        menu();
        addButton(0, "Arms",  function():void { CoC.instance.transformations.ArmsRaiju.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceWeasel.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesRaiju.applyEffect(); player.eyes.colour = randomChoice(RaijuRace.RaijuEyeColors);});
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsRaiju.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyRaijuBipedal.applyEffect(); });
        addButton(5, "Mane",  function():void {  CoC.instance.transformations.RearBodyRaijuMane.applyEffect(); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairStorm.applyEffect(); player.hairColor = randomChoice(RaijuRace.RaijuHairColors); });
        addButton(7, "GlowyBits",  function():void {  CoC.instance.transformations.NipplesGlowing.applyEffect(); CoC.instance.transformations.NipplesGlowing.applyEffect(); });
        addButton(8, "Aura",  function():void {  CoC.instance.transformations.WingsThunderousAura.applyEffect(); });
        addButton(9, "Tail",  function():void {  CoC.instance.transformations.TailRaiju.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function MeilaTFRaisuneMenu():void {
        menu();
        addButton(0, "Arms",  function():void { CoC.instance.transformations.ArmsRaiju.applyEffect();  });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceFox.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesFox.applyEffect(); player.eyes.colour = randomChoice(RaijuRace.RaijuEyeColors);});
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsFox.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyRaijuBipedal.applyEffect(); });
        addButton(5, "Mane",  function():void {  CoC.instance.transformations.RearBodyRaijuMane.applyEffect(); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairStorm.applyEffect(); player.hairColor = randomChoice(RaijuRace.RaijuHairColors); });
        addButton(7, "GlowyBits",  function():void {  CoC.instance.transformations.NipplesGlowing.applyEffect(); CoC.instance.transformations.NipplesGlowing.applyEffect(); });
        addButton(8, "Aura",  function():void {  CoC.instance.transformations.WingsThunderousAura.applyEffect(); });
        addButton(9, "Tails",  function():void {  CoC.instance.transformations.TailRaiju.applyEffect(); });
        addButton(10, "Tails/Fur",  RaisuneTailsMenu);
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function RaisuneTailsMenu():void {
        addButton(0, "1 Tail",  function():void {  CoC.instance.transformations.TailFox(1).applyEffect();  });
        addButton(1, "2 Tails",  function():void {  CoC.instance.transformations.TailFox(2).applyEffect();  });
        addButton(2, "3 Tails",  function():void { CoC.instance.transformations.TailFox(3).applyEffect(); });
        addButton(3, "4 Tails",  function():void {  CoC.instance.transformations.TailFox(4).applyEffect();});
        addButton(4, "5 Tails",  function():void {  CoC.instance.transformations.TailFox(5).applyEffect(); });
        addButton(5, "6 Tails",  function():void {  CoC.instance.transformations.TailFox(6).applyEffect(); });
        addButton(6, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(7, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(8, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(9, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton(10, "Pattern",  function():void {  CoC.instance.transformations.TailFox(6).applyEffect(); });
        addButton (14, "Back", MeilaTFKitshooMenu);
    }

    private function MeilaTFRatatoskrMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsSquirrel.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSmug.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesRatatoskr.applyEffect(); player.eyes.colour = "emerald";});
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsSquirrel.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodySquirrel.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairRatatoskr.applyEffect(); player.hairColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors); });
        addButton(7, "FurMenu", RatFurMenu);
        addButton(8, "NoTail",  function():void {  CoC.instance.transformations.TailSquirrel.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function RatFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();  player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect(); player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect(); player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton(3, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect(); player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton (14, "Back", MeilaTFRatatoskrMenu);
    }

    private function MeilaTFRPandaMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsRedPanda.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceRedPanda.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesRatatoskr.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsSquirrel.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Hair",  function():void {  player.hairColor1 = randomChoice(RedPandaRace.RedPandaHairColors); });
        //Add Red Panda Pattern
        //addButton(7, "Pattern",  function():void {  CoC.instance.transformations.SkinPattern.applyEffect(); });
        addButton(8, "Fur", RedPandaFurMenu);
        addButton(9, "Tail",  function():void {  CoC.instance.transformations.TailRedPanda.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }
    private function RedPandaFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();  player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect(); player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect(); player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton(3, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect(); player.furColor1 = randomChoice(RatatoskrRace.RatatoskrHairColors);
        });
        addButton (14, "Back", MeilaTFRPandaMenu);
    }
/*
    private function MeilaTFRhinoMenu():void {
        menu();
        addButton(0, "SkinColor",  function():void {  player.skinColor1 = "gray"; });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceRhino.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(11, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailRhino.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }
*/
    private function MeilaTFSalamanderMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsSalamander.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSalamanderFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesLizard.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsLizard.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodySalamanderBipedal.applyEffect(); });
        addButton(5, "NoRearBody",  function():void {  CoC.instance.transformations.RearBodyNone.applyEffect(); });
        addButton(6, "Scales", MeilaTFSalamanderScaleMenu);
        addButton(7, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(8, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(9, "NoTail",  function():void {  CoC.instance.transformations.TailSalamander.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function MeilaTFSalamanderScaleMenu():void {
        menu();
        addButton(0, "ScaleColor", function ():void {
            player.scaleColor1 = randomChoice(NagaRace.SnakeScaleColors);
        });
        addButton(1, "LowScales", function ():void {
            CoC.instance.transformations.SkinScales(1).applyEffect();
        });
        addButton(2, "MediumScales", function ():void {
            CoC.instance.transformations.SkinScales(2).applyEffect();
        });
        addButton(3, "HighScales", function ():void {
            CoC.instance.transformations.SkinScales(3).applyEffect();
        });
        addButton(4, "FullScales", function ():void {
            CoC.instance.transformations.SkinScales(4).applyEffect();
        });
        addButton(5, "Scalecolor", function ():void {
            player.scaleColor1 = randomChoice(SalamanderRace.SalamanderScaleColors);
        });
        addButton(6, "Skincolor", function ():void {
            player.skinColor1 = randomChoice(SalamanderRace.SalamanderSkinColors);
        });
        addButton(14, "Back", MeilaTFSalamanderMenu);
    }

    private function MeilaTFSandtrapMenu():void {
        menu();
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSandTrap.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        //the following 3 I don't know how to do -Snas
        addButton(5, "BlkVag",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(6, "BlkNips",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "UniBall",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsGiantDragonfly.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function MeilaTFYetiMenu():void {
        menu();
        addButton(0, "Skin",  function():void { CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor = randomChoice(YetiRace.YetiSkinColors); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceYetiFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); CoC.instance.transformations.EyesChangeColor(YetiRace.YetiEyeColors).applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsYeti.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyYeti.applyEffect(); });
        addButton(5, "RearBody",  function():void {  CoC.instance.transformations.RearBodyYetiFur.applyEffect(); });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairFluffy.applyEffect(); player.eyes.colour = "white"; });
        addButton(8, "Fur",  YetiFurMenu);
        //Need to Add thicc butt
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function YetiFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect();
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect();
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect();
        });
        addButton(3, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect();
        });
        addButton (14, "Back", MeilaTFYetiMenu);
    }

    private function MeilaTFSatyrMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsSatyr.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesGoat.applyEffect(); player.eyes.colour = "golden"; });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyClovenHoofedBipedal.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairHuman.applyEffect();  player.hairColor = randomChoice(SatyrRace.SatyrHairColors); });
        addButton(7, "Fur", SatyrFurMenu);
        addButton(8, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(9, "Horns",  function():void {  CoC.instance.transformations.HornsGoatQuadruple.applyEffect(); });
        addButton(10, "Tail",  function():void {  CoC.instance.transformations.TailGoat.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }
    private function SatyrFurMenu():void {
        menu();
        addButton(0, "LowFur", function ():void {
            CoC.instance.transformations.SkinFur(1).applyEffect(); player.furColor1 = randomChoice(SatyrRace.SatyrFurColors);
        });
        addButton(1, "MediumFur", function ():void {
            CoC.instance.transformations.SkinFur(2).applyEffect(); player.furColor1 = randomChoice(SatyrRace.SatyrFurColors);
        });
        addButton(2, "HighFur", function ():void {
            CoC.instance.transformations.SkinFur(3).applyEffect(); player.furColor1 = randomChoice(SatyrRace.SatyrFurColors);
        });
        addButton(3, "FullFur", function ():void {
            CoC.instance.transformations.SkinFur(4).applyEffect(); player.furColor1 = randomChoice(SatyrRace.SatyrFurColors);
        });
        addButton (14, "Back", MeilaTFSatyrMenu);
    }

    private function MeilaTFScorpionMenu():void {
        menu();
        addButton(0, "Ears",  function():void {  CoC.instance.transformations.EarsInsect.applyEffect();});
        addButton(1, "Chitin",  function():void {  CoC.instance.transformations.SkinChitinToFull.applyEffect(); });
        addButton(2, "Tail",  function():void {  CoC.instance.transformations.TailScorpion.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function MeilaTFScyllaMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsKraken.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHuman.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(ScyllaRace.ScyllaEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyKraken.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Skin",  function():void { CoC.instance.transformations.SkinSlippery.applyEffect(); CoC.instance.transformations.SkinPatternBioluminescence.applyEffect(); player.skinColor1 = "ghostly pale"; });
        addButton(9, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(10, "Horns",  function():void {  CoC.instance.transformations.HornsKraken.applyEffect(); });
        addButton(11, "Gills",  function():void {  CoC.instance.transformations.GillsFish.applyEffect();  });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu7);
    }

    private function DDullahanTFMenu8():void {
        clearOutput();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        outputText("Meila gives you a sly smile, sliding you a paper menu. “Making use of my services, [Master]? I promise to make this quick and painless.”  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Previous", DDullahanTFMenu7);
        addButton (1, "S.Dragon", MeilaTFSdragonMenu);
        addButton (2, "Shark", MeilaTFSharkMenu);
        addButton (3, "Siren", MeilaTFSirenMenu);
        addButton (4, "Slime", MeilaTFSlimeMenu);
        addButton (5, "Sphynx", MeilaTFSphynxMenu);
        addButton (6, "Spider", MeilaTFSpiderMenu);
        addButton (7, "T.bird", MeilaTFTbirdMenu);
        addButton (8, "Troll", MeilaTFTrollMenu);
        addButton (9, "Unicorn", MeilaTFUnicornMenu);
        addButton (11, "Vampire", MeilaTFVampireMenu);
        addButton (12, "Vouivre", MeilaTFVouivreMenu);
        addButton (13, "Wolf", MeilaTFWolfMenu);
        addButton (14, "Finalize", MeilaTFConfirm);
    }

    private function MeilaTFSdragonMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsSeaDragon.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceOrca.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesDraconic.applyEffect(); CoC.instance.transformations.EyesChangeColor(SeaDragonRace.SeaDragonEyeColors).applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsOrca.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodySeaDragonBipedal.applyEffect(); });
        addButton(6, "Blowhole",  function():void { CoC.instance.transformations.RearBodyOrcaBlowhole.applyEffect(); });
        addButton(7, "Hair",  function():void { CoC.instance.transformations.HairPrismatic.applyEffect(); });
        addButton(8, "Skin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(9, "Antenna",  function():void {  CoC.instance.transformations.AntennaeSeaDragon.applyEffect(); });
        addButton(10, "Horns",  function():void {  CoC.instance.transformations.HornsSeadragon.applyEffect(); });
        addButton(11, "Tongue",  function():void {  CoC.instance.transformations.TongueDraconic.applyEffect();  });
        addButton(12, "Wings",  function():void {  CoC.instance.transformations.WingsSeaDragon.applyEffect(); });
        addButton(13, "NoTail",  function():void {  CoC.instance.transformations.TailOrca.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFSharkMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsShark.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSharkTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsShark.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodySharkBipedal.applyEffect(); });
        addButton(5, "RearBody",  function():void {  CoC.instance.transformations.RearBodySharkFin.applyEffect(); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairHuman.applyEffect(); player.hairColor1 = randomChoice(SharkRace.SharkHairColors); });
        addButton(7, "tongue",  function():void {  CoC.instance.transformations.TongueHuman.applyEffect(); });
        addButton(8, "Gills",  function():void {  CoC.instance.transformations.GillsFish.applyEffect();  });
        addButton(9, "Tail",  function():void {  CoC.instance.transformations.TailShark.applyEffect(); });
        addButton(10, "Scales",  function():void { player.scaleColor1 = randomChoice(SharkRace.SharkScaleColors); CoC.instance.transformations.SkinAquaScalesToFull.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFSirenMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHarpy.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSharkTeeth.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsShark.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyHarpy.applyEffect(); });
        addButton(5, "RearBody",  function():void {  CoC.instance.transformations.RearBodySharkFin.applyEffect(); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairFeather.applyEffect(); player.hairColor1 = "silver"; });
        addButton(7, "tongue",  function():void {  CoC.instance.transformations.TongueHuman.applyEffect(); });
        addButton(8, "Gills",  function():void {  CoC.instance.transformations.GillsFish.applyEffect();  });
        addButton(9, "Tail",  function():void {  CoC.instance.transformations.TailShark.applyEffect(); });
        addButton(10, "Scales",  function():void { player.scaleColor1 = randomChoice(SirenRace.SirenScaleColors); CoC.instance.transformations.SkinAquaScalesToFull.applyEffect(); });
        addButton(11, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredLarge.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFSlimeMenu():void {
        menu();
        //Have someone look at this one. IDK how slimes work -Snas
        addButton(0, "Skin",  function():void { player.isGooSkin(); player.skinColor = randomChoice(SlimeRace.SlimeSkinColors); });
        addButton(1, "Eyes",  function():void {  CoC.instance.transformations.EyesChangeColor(GoblinRace.GoblinEyeColors).applyEffect(); });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(3, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyGoo.applyEffect(); });
        addButton(4, "RearBody",  function():void { CoC.instance.transformations.RearBodyMetamorphicGoo.applyEffect();});
        addButton(5, "Hair",  function():void { CoC.instance.transformations.HairGoo.applyEffect(); });
        addButton(6, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(7, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(8, "NoGills",  function():void {  CoC.instance.transformations.GillsNone.applyEffect();  });
        addButton(9, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFSphynxMenu():void {
        menu();
        //Need to add cat genitals to this -Snas
        addButton(0, "Skin",  function():void { CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor = randomChoice(SphinxRace.SphinxSkinColor); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceCatCanines.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesCat.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsLion.applyEffect();});
        addButton(5, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyCat(4).applyEffect(); });
        addButton(6, "Arms",  function():void {  CoC.instance.transformations.ArmsSphinx.applyEffect(); });
        addButton(7, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredSphinx.applyEffect(); });
        addButton(8, "NoTail",  function():void {  CoC.instance.transformations.TailCat.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFSpiderMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsSpider.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSpiderFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSpider.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "SpiderLegs",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(5, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(6, "DriderLegs",  function():void {  CoC.instance.transformations.LowerBodyDrider.applyEffect(); });
        addButton(7, "Chitin",  function():void {  CoC.instance.transformations.SkinChitinToFull.applyEffect(); });
        addButton(8, "BlkNipples",  function():void {  CoC.instance.transformations.NipplesBlack.applyEffect(); });
        addButton(9, "Abdomen",  function():void {  CoC.instance.transformations.TailSpider.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFTbirdMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsHarpy.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceWeasel.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesRaiju.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "Legs",  function():void {  CoC.instance.transformations.LowerBodyHarpy.applyEffect(); });
        addButton(5, "RaijuMane",  function():void {  CoC.instance.transformations.RearBodyRaijuMane.applyEffect(); });
        addButton(6, "Hair",  function():void { CoC.instance.transformations.HairStorm.applyEffect(); player.hairColor = randomChoice(ThunderbirdRace.ThunderbirdHairColors); });
        addButton(7, "Wings",  function():void {  CoC.instance.transformations.WingsFeatheredLarge.applyEffect(); });
        addButton(8, "Tail",  function():void {  CoC.instance.transformations.TailThunderbird.applyEffect(); });
        //addButton(9, "SkinPattern",  function():void {  CoC.instance.transformations.Skin.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFTrollMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsTroll.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceTroll.applyEffect(); });
        addButton(2, "Eyes",  function():void { CoC.instance.transformations.EyesHuman.applyEffect();  CoC.instance.transformations.EyesChangeColor(TrollRace.TrollEyeColors).applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(4, "LowerBody",  function():void {  CoC.instance.transformations.LowerBodyTroll.applyEffect(); });
        addButton(5, "Fur",  function():void { player.furColor1 = randomChoice(TrollRace.TrollFurColors); CoC.instance.transformations.SkinFur(4).applyEffect(); });
        addButton(6, "Tail",  function():void {  CoC.instance.transformations.TailTroll.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFUnicornMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceHorse.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesHuman.applyEffect(); });
        addButton(3, "Ears",  function():void {  CoC.instance.transformations.EarsHorse.applyEffect();});
        addButton(4, "Biped",  function():void {  CoC.instance.transformations.LowerBodyHoofedBipedal.applyEffect(); });
        addButton(5, "Quadraped",  function():void {  CoC.instance.transformations.LowerBodyHoofed(4).applyEffect(); });
        addButton(6, "Hair",  function():void {  player.hairColor1 = randomChoice(UnicornRace.UnicornHairColors); });
        addButton(7, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); });
        addButton(8, "UniHorn",  function():void {  CoC.instance.transformations.HornsUnicorn.applyEffect(); });
        addButton(9, "FurColor",  function():void {  player.furColor1 = randomChoice(UnicornRace.UnicornFurColors); });
        addButton(10, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(11, "Tail",  function():void {  CoC.instance.transformations.TailHorse.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFVampireMenu():void {
        menu();
        addButton(0, "Face",  function():void {  CoC.instance.transformations.FaceVampire.applyEffect(); });
        addButton(1, "Eyes",  function():void {  CoC.instance.transformations.EyesVampire.applyEffect(); player.eyes.colour = "blood-red"; });
        addButton(2, "Ears",  function():void {  CoC.instance.transformations.EarsVampire.applyEffect();});
        addButton(3, "Legs",  function():void {  CoC.instance.transformations.LowerBodyHuman.applyEffect(); });
        addButton(4, "PlainSkin",  function():void {  CoC.instance.transformations.SkinPlain.applyEffect(); player.skinColor1 = "pale";});
        addButton(5, "NoAntenna",  function():void {  CoC.instance.transformations.AntennaeNone.applyEffect(); });
        addButton(6, "NoHorns",  function():void {  CoC.instance.transformations.HornsNone.applyEffect(); });
        addButton(7, "Wings",  function():void {  CoC.instance.transformations.WingsVampire.applyEffect(); });
        addButton(8, "NoTail",  function():void {  CoC.instance.transformations.TailNone.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function MeilaTFVouivreMenu():void {
        menu();
        addButton(0, "Arms",  function():void {  CoC.instance.transformations.ArmsDraconic.applyEffect(); });
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceSnakeFangs.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesSnake.applyEffect(); });
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsElfin.applyEffect();});
        addButton(5, "SnakeLegs",  function():void {  CoC.instance.transformations.LowerBodySnake.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton(8, "Horns/Wings",  VouivreHornMenu);
        addButton(9, "L.Scales",  function():void {  CoC.instance.transformations.SkinScales(1).applyEffect(); });
        addButton(10, "LM.Scales",  function():void {  CoC.instance.transformations.SkinScales(2).applyEffect(); });
        addButton(11, "MH.Scales",  function():void {  CoC.instance.transformations.SkinScales(3).applyEffect();  });
        addButton(12, "H.Scales",  function():void {  CoC.instance.transformations.SkinScales(4).applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }

    private function VouivreHornMenu():void {
        addButton(0, "Hornx2",  function():void {  CoC.instance.transformations.HornsDraconicDual.applyEffect(); });
        addButton(1, "Hornx4",  function():void {  CoC.instance.transformations.HornsDraconicQuadruple.applyEffect(); });
        addButton(2, "SmallWings",  function():void {  CoC.instance.transformations.WingsDraconicSmall.applyEffect(); });
        addButton(4, "LrgWings",  function():void {  CoC.instance.transformations.WingsDraconicLarge.applyEffect();});
        addButton(5, "HugeWings",  function():void {  CoC.instance.transformations.WingsDraconicHuge.applyEffect(); });
        addButton(6, "RearBody",  function():void {  player.hairColor = randomChoice(BeeRace.BeeHairColors); });
        addButton(7, "Hair",  function():void {  player.hairColor = randomChoice(GoblinRace.GoblinHairColors); });
        addButton (14, "Back", MeilaTFVouivreMenu);
    }

    private function MeilaTFWolfMenu():void {
        menu();
        addButton(1, "Face",  function():void {  CoC.instance.transformations.FaceWolf.applyEffect(); });
        addButton(2, "Eyes",  function():void {  CoC.instance.transformations.EyesFenrir.applyEffect(); player.eyes.colour = "glacial blue";});
        addButton(4, "Ears",  function():void {  CoC.instance.transformations.EarsWolf.applyEffect();});
        addButton(5, "Legs",  function():void {  CoC.instance.transformations.LowerBodyWolfBipedal.applyEffect(); });
        addButton(6, "RearBody",  function():void {  CoC.instance.transformations.RearBodyFenrirIceSpikes.applyEffect(); });
        addButton(7, "Hairfurcolor",  function():void {  player.hairColor1 = "glacial white"; player.furColor1 = "glacial white"; });
        addButton(8, "L.Fur",  function():void {  CoC.instance.transformations.SkinFur(2).applyEffect(); });
        addButton(9, "H.Fur",  function():void {  CoC.instance.transformations.SkinFur(4).applyEffect(); });
        addButton(12, "NoWings",  function():void {  CoC.instance.transformations.WingsNone.applyEffect(); });
        addButton(13, "Tail",  function():void {  CoC.instance.transformations.TailWolf.applyEffect(); });
        addButton (14, "Back", DDullahanTFMenu8);
    }




    private function MeilaTFConfirm():void {
        clearOutput();
        outputText("You tell Meila what you want, and the dainty dullahan smiles. “Come with me then.” She leads you to the large room where the Driders once were caged. She guides you over to a large throne-like chair. As you sit, you sink noticeably into the velvety seat, soft pillows cradling your body at every possible angle. The seat is…Too comfortable. You can feel your eyes closing, your body suddenly too heavy to move.  \n\n");
        outputText("“That’s it, [master]. Just go to sleep. When you wake up, it’ll be over.” Meila’s voice is soothing. You get the feeling that it’s slightly magical, but you’re already too far under. \n" +
                "\n" +
                "…\n" +
                "\n" +
                "…\n" +
                "\n" +
                "“-nd there we go, that should do it!” Meila’s voice cuts through the fuzzy lethargy around your mind. You open your eyes, suddenly jolted awake. You sit upright, and Meila smiles, offering you a hand. “All done. Enjoy your new you, [master].”  \n\n");
        outputText("You exit the back room into the Dainty Dullahan’s lounge, feeling invigorated.  \n\n");
doNext(StripClub);
    }

    private function DDullahanStock():void {
        clearOutput();
        outputText("“You have something for me to add to my stock?” She asks, interested. “That would be most helpful. What have you brought me today?”  \n\n");
        menu();
        addButton (0, "Template", GiveMeilaGoblin);
        addButton (1, "TF", GiveMeilaTF);
        addButton (14, "Back", DDullahanStatus);
    }

    private function GiveMeilaTF():void {
        clearOutput();
        menu();
        addButton (14, "Back", DDullahanStatus);
    }

    private function GiveMeilaGoblin():void {
        clearOutput();
        //if player has a goblin
        templatenum += 1;
        outputText("You hand over the little creature, bound and gagged, and Meila nods seriously. “Thank you. I now have" +templatenum + "templates ready to imprint.” She reaches out and hands you 500 gems for your efforts. \n\n");
        player.gems += 500;
        //if player doesn't
        outputText("Meila scowls at you, putting her hands on her hips. “Look…You may find this funny, but I don’t. I take my business seriously, and fucking up will hurt people. So…Please don’t do this again.”\n\n");
        outputText("");
        outputText("");
    }

    public function MeilaTutorial():void {
        clearOutput();
        outputText("“Conceptually, it’s fairly simple”, Meila says slyly. “Magically, it’s a lot more complicated than most would think. As you already know, many items in Mareth are intrinsically linked with the people that inhabit this world. While those of us born in Mareth naturally have an…affinity, so to speak, with the species we’re born as, making it harder for such items to have an effect on us, those born outside Mareth seem to lack that same kind of…Stability.”  \n\n");
        outputText("She points at the templates. “While it’s very difficult for most of us native Marethians to…Transform, so to speak, outside of very potent, single-use transformatives, such as Succubus Milk or Incubus Draft, there are those among us who possess more vulnerability than others. Typically, the more volatile of Mareth’s races are the short-lived ones, with less biomass to be altered. It also helps to have a high rate of reproduction, to foster more mutations.”  \n\n");
        outputText("You ask if that’s why her current templates are all goblins, and she nods, head bobbing independently of her body. “Exactly. Goblins and Imps are the ideal templates for my work. Their bodies are small, more easily mutated, and the lack of biomass makes everything easier.” She looks down, ever so slightly.  \n\n");
        outputText("How do you react to this? She’s talking about practically ending lives, using them as…meat donors, so that demons can look different.  \n\n");

        menu();
        addButton (0, "Horror", MeilaReassuresYou);
        addButton (1, "Admiration", Reallydudethatscold);
        addButton (2, "Neutral", MeilaNeutrality);
    }

    private function MeilaNeutrality():void {
        clearOutput();
        outputText("You decide to be polite. You tell her that the idea is interesting, and potentially very useful…But that you have some reservations about how this is done. She nods at this, seemingly understanding. “I understand. But if you feel the need to change yourself, know that the Dainty Dullahan is available.”  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        doNext(DaintyDullahan);
    }

    private function Reallydudethatscold():void {
        clearOutput();
        outputText("You tell the pale woman that you didn’t think such a thing was possible. Looking at the templates, you admire how cleanly the body accepted its template, and the regenerative capabilities put into these bodies allows for clean replacement of parts.  \n\n");
        outputText("“Yes, well…You seem to know a bit about the requirements. Thank you for the compliment, but my selection is rather limited right now.” She mutters, looking down. “It’s far from complete.”  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        (MeilaTrust -=10);
        doNext(DaintyDullahan);
    }

    public function MeilaReassuresYou():void {
        clearOutput();
        outputText("You gag slightly, and Meila raises one eyebrow. “Is there something wrong, [Master]?” Angry, you begin to speak up, raising your voice…and she puts a hand over your mouth. “Come with me, I can show you more, if you’re interested.” Her crop-top choses that moment to slip, revealing pale, smooth skin, and she flicks her eyes over at the demon sitting in the corner. Despite her racy body language, her eyes are wide, and it’s clear that she’s using this as an excuse to get you into the back, and not just for sex.  \n\n");
        outputText("You nod, a barely perceptible movement of your head, and she giggles, pulling you into the storeroom and locking the door behind you.  \n\n");
        outputText("“I know”, she whispers, as soon as the door’s closed. “It’s horrible.” Meila lets out a loud moan, throwing off her top, her voice now far louder. “Come on, [Master], don’t you want to see how dainty I am?”  \n\n");
        outputText("You draw near, stripping down as well. Meila nods, stepping in and removing her skirt.“They’re not dead” She whispers, sitting on a barrel, leaning back against the wall and spreading her legs. “We need to make a little noise, so he doesn’t get suspicious.”  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        (MeilaTrust +=30);
        menu();
        addButton (0, "DickSex", CovertDSex);
        addButton (1, "Finger", CovertFinger);
        addButton (2, "TellMe", MeilaTellsOnCeraph);
    }


    //---------Meila Sex Scenes------------

    private function MeilaSexMenu():void {
        clearOutput();
        outputText("You tell Meila that you intend on claiming her, for a time. \n\n");
        if ((whosincharge == 0) || (whosincharge == 4)) {
            outputText("As Ceraph’s owner, her harem is yours to command. \n\n");
        }
        if (MeilaTrust < 33) {
            outputText("Meila closes her eyes, sighing. “As you command, [master]” Her shoulders fall, and she slowly shuffles into the back. You follow, and she begins to slowly, reluctantly peel off her crop-top. \n\n");
            outputText("“Please be gentle?” She whispers, almost pleading.\n\n");
        }
        if (MeilaTrust > 33 && MeilaTrust < 66) {
            outputText("Meila shudders slightly, but doesn’t protest. “Sure thing, [master].” You bring a hand to her shoulder, guiding her gently into the back. Without turning her body around, her head rotates to look at you. With one hand, you take hold of her crop-top, bringing it up and over her neck. Meila’s head floats up, and she watches, slightly nervously, as you slide her skirt down, exposing her thin lower lips. \n\n");
            outputText("“N-nothing too rough, please.” She asks. “I still need to be able to work after.” \n\n");
        }
        if (MeilaTrust > 66) {
            outputText("Meila gives you a knowing wink, her head levitating to your ear. “Come to the back in a few seconds. I’ll be waiting.” She walks toward the back, slowly swaying her thin hips in an attempt to be seductive. Her head gently floats onto her neck, still looking back at you. \n\n");
            outputText("You join her in the back a few moments later, and the dainty woman wraps her arms around your shoulders. Her head is nowhere to be seen, and you feel her cool breath on the back of your neck. \n\n");
            outputText("“Hello, [master]”, Meila whispers, her lips on the back of your neck. She drags her lips across your neck, leaving a trail of kisses along the sensitive [skin]. Her head gently lowers back onto her neck, and she inhales, a little shakily, as you bring your hands to the bottom of her crop-top.\n\n");
            outputText("“How do you want me?” She asks, dropping one hand to your hip.\n\n");
        }
        menu();
        addButton(0, "Rough", MeilaRoughSex);
        addButton(1, "Gentle", MeilaGentleSex);
        addButton(2, "Back", DaintyDullahan)
    }

    private function MeilaTellsOnCeraph():void {
        clearOutput();
        outputText("");
        outputText("");
        outputText("");
        outputText("");
    }

    private function CovertFinger():void {
        clearOutput();
        outputText("You lean over the dainty girl, licking a finger before bringing it to her lower lips. “Come on, just take it slow so we can talk.” \n\n");
        outputText("You slowly slide your finger in. Meila is cool to the touch, even on the inside. Her walls are slick, and cling to you. She lets out an involuntary grunt, blushing slightly. You give her a look, and she nods, bringing a hand to your own delta. Her fingers brush aside your lower lips, digits cool inside you. You begin to move, slowly, and she begins to talk. \n\n");
        outputText("“They’re not brain-dead, or anything of the sort.” She whispers. “They…Hnn…They can be brought back at any time. For right now, they’re just…sleeping, dreaming about whatever they find to be pleasant.” She lets out a moan, her hips beginning to move. “They’re fed, kept healthy, and safe. I’m not heartless.” She looks back at the door, and you notice her head has gone back to the door. She looks through, letting out another moan, before coming back to you. \n\n");
        outputText("“Look, I don’t know how you came to own Ceraph…But know that you’re lucky.” She looks back at the door, fear in her eyes. “Or…hng…Skilled.” You can feel her pussy slowly tightening around your finger, and you rub her button gently. “Help me make this a successful part of Ceraph’s domain, please. I wasn’t as lucky as you.” \n\n");
        outputText("You can’t really see any reason to deny the odd little woman, or her request, and you nod. She smiles, exhaling as if relieved, wrapping her free hand around you, guiding your body down to hers. She begins gyrating her hips, sinking another finger into your damp honeypot. \n\n");
        outputText("“Thank you so much, [Master.] Not that I have much to offer you now…But I can reward you for your efforts. I promise you won’t regret it.” She gasps, picking up the pace, and you decide it’s time to finish up, grabbing the back of her head, leaning her backward, and gyrating your hips. Meila moans into your mouth, your slow mutual masturbation building. You feel her pussy warming up, her breath increasingly fast. Meila’s moans become higher and higher-pitched, until she seizes up, her legs spasming. Femcum trickles down her love-hole, past your fingers and out. You cum a second later, and both you and Meila bring your fingers to each other’s mouths. \n\n");
        outputText("“Mmm…” She hums, clearly satisfied. “Thank you, [master] [Name]. I hope to see you again soon.” She gently pushes you back, and you stand back up. She closes her legs, putting a finger on her lips. “Give me a few moments to clean up, and I’ll be right back out to join you.” \n\n");
        player.sexReward("vaginalFluids");
        doNext(DaintyDullahan);
    }

    private function CovertDSex():void {
        clearOutput();
        outputText("You step in, lining your [cock] up with Meila’s petite frame. “Come on, just take it slow so we can talk.”  You slowly slide in. Meila is cool to the touch, even on the inside. Her walls are slick, and cling to you. She lets out an involuntary grunt, blushing slightly. You give her a look, and she grabs onto your shoulders for stability. Her head pops off her neck, levitating near your ear. You begin to move, slowly, and she begins to talk. \n\n");
        outputText("“They’re not brain-dead, or anything of the sort.” She whispers. “They…Hnn…They can be brought back at any time. For right now, they’re just…sleeping, dreaming about whatever they find to be pleasant.” She lets out a moan, her hips beginning to move. “They’re fed, kept healthy, and safe. I’m not heartless.” She looks back at the door, and you notice her head has gone back to the door. She looks through, letting out another moan, before coming back to you. \n\n");
        outputText("“Look, I don’t know how you came to own Ceraph…But know that you’re lucky.” She looks back at the door, fear in her eyes. “Or…hng…Skilled.” You can feel her pussy slowly tightening around your [cock], her arms around you shaking. “Help me make this a successful part of Ceraph’s domain, please. I wasn’t as lucky as you.” \n\n");
        outputText("You can’t really see any reason to deny the odd little woman, or her request, and you nod. She smiles, exhaling as if relieved, and wraps her legs around you, bringing her lips to yours. Meila begins to lean into your thrusts, gyrating her hips. ");
        outputText("“Thank you so much, [Master.] Not that I have much to offer you now…But I can reward you for your efforts. I promise you won’t regret it.” She gasps, picking up the pace, and you decide it’s time to finish up, grabbing her shoulders and pinning her against the wall while you ravage her cunt. \n\n");
        outputText("A minute or so in, she gasps, a girlish sound, and as her walls close in, pulsing gently, you feel her legs shake. Most shockingly, her eyes roll up, her tongue lolls out…and her head simply falls off her neck. You catch her with one hand, holding her long braid, and as you feel your own orgasm rising, you pull her head into your arms, holding it close to your [chest] as your cock twitches, balls churning. You cum deep into Meila’s cool cunt, and as your orgasm fades, she gently takes her head back, putting it back onto her neck. \n\n");
        outputText("“Mmm…” She hums, clearly satisfied. “Thank you, [master] [Name]. I hope to see you again soon.” She gently pushes you back with one foot, and as you exit her, [cock] falling limp and dripping some of your baby-batter onto the floor, she closes her legs, putting a finger on her lips. “Give me a few moments to clean up, and I’ll be right back out to join you.” \n\n");
        outputText("");
        player.sexReward("vaginalFluids","Dick");
        doNext(DaintyDullahan);
    }

    private function MeilaGentleSex():void {
        clearOutput();
        outputText("You tell Meila that she’s dainty, and that you don’t want to hurt such a delicate flower…not if it’s going to bloom fully. This gets you a warm smile, and she bites her lower lip. \n\n");
        outputText("“O-oh? I…If you put it like that…” Meila’s head floats over to your ear, and she whispers. “Water my flower then, gentle gardener.”\n\n");
        outputText("");
        outputText("");
        outputText("");
        menu();
        addButton(0, "Rough Fuck", GetRoughWithHer);
        addButton(1, "ForcedLick", MeilaForcedLick);
        addButton(2, "HeadnAss", MeilaDPHeadAss);
        addButton(14, "Nvm", DaintyDullahan);

    }

    private function MeilaRoughSex():void {
        clearOutput();
        outputText("You lean in, pushing Meila roughly against the wall. Telling the woman that you intend on enjoying yourself…Your own way.\n\n");
        if (MeilaTrust < 33) {
            outputText("Meila whimpers, looking up at you with worried eyes.\n\n");
            outputText("");
        }
        if (MeilaTrust > 33 && MeilaTrust < 66) {
            outputText("Meila is silent, but her expression is nervous.\n\n");
            outputText("");
        }
        if (MeilaTrust > 66) {
            outputText("Meila suppresses a giggle and a smirk, eagerly waiting for you to make a move. \n\n");
            outputText("");
             }
        menu();
        addButton(0, "Rough Fuck", GetRoughWithHer);
        addButton(1, "ForcedLick", MeilaForcedLick);
        addButton(2, "HeadnAss", MeilaDPHeadAss);
    }

    private function GetRoughWithHer():void {
        outputText("");
        outputText("");
        outputText("");
        outputText("");
        outputText("");
        outputText("");
        doNext(FoodHall);
    }

    private function MeilaDPHeadAss():void {
        clearOutput();
        outputText("You tell Meila to put her palms against the wall, and she obeys. Her head turns a full 180 to watch you as you yank her skirt and panties down, then lean in, reaching your arms around her, reaching underneath her crop-top and palming her cool, firm globes. Your [cock] rapidly hardening, you run your shaft along her nether-lips from behind, continuing to grope and squeeze Meila’s girls. Her eyes widen, and you can see her mouth open slightly, her hips moving. She’s dripping, and you slather your shaft in her pre. \n\n");
        outputText("You were planning on plowing her tight cunt…but that enticing expression gave you an idea. You tell Meila to rest her tits on a nearby shelf, and you grab her head, taking it off her neck. \n\n");
        outputText("The back room has a few pillows lying around, and the shelf is deep enough for most of Meila’s torso to rest on it. You put one in front of her neck, one under her tits, and you place Meila’s head on her ass, ordering the Dullahan to keep it there with her hands. \n\n");
        outputText("Now nervous, Meila opens her mouth. “Wh-what are you doing, [Master]?” \n\n");
        outputText("You tell Meila that she’d better brace herself. You pull out your [cock1] and [cock2], slapping Meila’s ass with your rapidly hardening shafts. Both her pairs of cheeks blush, and she looks at your [cock1] nervously. \n\n");
        outputText("Before Meila can protest any more, you move your [hips], lining [cock1] up with her open mouth, and [cock2] with her helplessly dangling asshole. She begins to say something, but…\n\n");
        outputText("“H-hey, I-MMPH!” Meila’s words are cut off as you sink in, her tight little ass providing quite a lot more resistance than her mouth. Her eyes are wide, and a tear starts falling down her face as you force your way deeper, another few inches passing her sphincter and lips. Her throat tightens as she attempts to swallow, only giving you more stimulation. Finally, you bottom out inside her, your [cock1 head] now deep in her throat.\n\n ");
        outputText("Cheerfully, you tell Meila that she should probably brace herself as you wrap your arms around her thighs and pull back. Your [cock1] leaves her throat, and just as you would pull out of her mouth, your [cock1 head] against the back of her lips, you thrust forward as hard as you can, slamming her neck into the (padded) back of the shelf. Meila’s arms twitch, but you grab a hand, guiding it back to her head, where you told her to keep them. You chide Meila, telling her that she’s going to need to be better at listening than this. You hear her whimper, the sound traveling up your shaft, and you give her a comforting pat on the top of the head before you thrust as hard as you can, pushing Meila’s neck to the back of the shelf. Her eyes widen, and her legs begin to flail as you pull back with a moist schluck. Her asshole is still very tight, almost painfully so, and with every move you make, you can feel her involuntarily gasp. \n\n");
        outputText("With nothing else for her legs to grip, Meila wraps her legs around your [hips] as you begin to pick up the pace, her ass loosening up slightly. With each thrust, you hear a slight bump, as you drag Meila’s lightweight body back and forth on the shelf. She begins to scream into your shaft as you bury your [cock1] deep into her throat, and her asshole tightens around your [cock2]. You feel her legs shake, and you feel a warm, sticky liquid hit your [legs]. \n\n");
        outputText("“MmMM!” Meila gags, her throat massaging your shaft, and her legs fall limp. You tighten your grip on her slender hips, quickly building to your own orgasm. Each thrust now gets you a little cry, as even with your cock in her mouth, Meila can’t keep quiet. The noise, and extra stimulation, build, and you can feel your shafts twitching inside her. Meila’s lips tighten around you, and you bury yourself into her ass and throat. You hold onto her hips, resting your head against the shelf as your orgasm hits.\n\n ");
        if(player.cumQ() <= 100) {
            outputText("You feel Meila’s throat working, her sphincter almost painfully tight. She locks her legs around you as your balls churn, spurting your load down her throat and up her ass. As your orgasm fades, you feel her tongue around your tender shaft, licking you clean as you pull her head off your shaft. While the dainty Dullahan doesn’t speak, still breathing heavily, she’s grinning from ear to ear, looking up into your eyes with what you can only describe as bliss. She sticks her tongue out, showing your cum on her tongue, before closing her mouth and swallowing. As her breathing slows, you pull your [cock2] out of her ass, your rapidly softening shaft coming out with a trickle of your spooge. \n\n");
            outputText("");
            player.sexReward("vaginalFluids","Dick");
        }
        if(player.cumQ() > 100 && player.cumQ() < 300) {
            outputText("Meila’s eyes widen as she feels your orgasm incoming, and you sink yourself into the hilt of both your shafts. Meila’s legs start to flail, but you bear down as your baby batter begins to flow. Meila makes muffled, sloppy gulping sounds as she begins to swallow your cum, and you can feel some increased pressure on the shaft in her ass as she squirms. Eventually, as your orgasm begins to slow, you pump your shafts a few times, before pulling out.\n\n ");
            outputText("As your [cock1] leaves her mouth, Meila gasps for air. Despite herself, she sticks her tongue out, and you slap your head on her cheek, dislodging the last droplets. Curious, you stick a few fingers in her mouth. She opens her mouth obediently, and you can see her throat, slightly swollen, still glazed in your cum, along with the inside of her mouth. You make a comment about it, and Meila squirms a little. Her cheeks bright red, and her eyes glazed over, the dainty Dullahan looks down at your [cock2], still in her ass. \n\n");
            outputText("“Haa…Huuuah…My…Ass…” You pull out, and with each inch of your shaft removed, Meila bites her lip, groaning. You finally pull your [cock2 head] past her sphincter, and as Meila moans, your cum starts leaking out, making a sizable pool on the floor. Meila gasps as her abused backside gapes, and as you peer into her, she closes her legs. Despite her efforts, she’s still leaking, and she shudders. ");
            outputText("“Thank y-you [master].” \n\n");
            player.sexReward("vaginalFluids","Dick");
        }
        if(player.cumQ() >= 300) {
            outputText("Your [cock] twitches violently, and Meila looks up at you, giving you a split second of panic before your orgasm hits. You groan, your [balls] audibly churning as your baby batter shoots down your shaft in a thick wave. Meila moans, eyes glazing over as she swallows, her throat tightening on your shaft, taking mouthful after mouthful of your cum down her throat. \n\n");
            outputText("Your [cock2] in her ass violently shakes, her sphincter almost painful against you. Her legs shake, and you dimly notice Meila’s stomach…Is getting bigger.\n\n ");
            outputText("As your orgasm drags on, Meila’s ass and stomach swelling with your seed, she begins to moan, weakly trying to pull her head off your shaft. Concerned for her safety, you begin to pull her mouth off…only for a spurt of your load to come, propelling her head off your shaft like a shot from a cannon. You barely manage to grab her by the braid, and even as your load drips from her mouth, Meila’s coughing, moaning in pain as your [cock1] fires another round of sperm across her back. \n\n");
            outputText("“Ow…Ow…OW! E…nough…Please…I’m full…Too full of your…CUM!”  Meila’s legs shudder violently, her own orgasm hitting again. What do you do?\n\n");
            menu();
            addButton(0, "Pull Out", MeilaDPPullOut);
            addButton(1, "Fill'er'up", MeilaInflate);
        }
    }

    private function MeilaInflate():void {
        clearOutput();
        outputText("With a grin and a grunt, you take Meila’s head and shove your head past her lips again. She flails, her body trying to dislodge you, but she’s stuck, impaled on your shaft and unable to wiggle loose. Meila screams against your shaft, her throat tightening almost painfully as your load drags on. You can see her stomach expand, until the Dullahan’s body begins pushing against the shelves, her cum-filled midsection now too large to fit properly. \n\n");
        outputText("Meila wails, trying to dislodge herself from the shelf, but she can’t get her legs to the ground, and the shelves are firmly attached to the wall. You pull out, slathering her gaping ass and thin legs in several ropes of your cum, but as your boner finally starts to deflate, you notice that the dainty Dullahan’s body is firmly stuck, legs twitching as she tries to force your cum out from her abused asshole. You place her head beside her ass, coughing, and take a step back to admire your handiwork. The Dainty Dullahan is going to be here a while, since she needs to eject a LOT of your cum before she can dislodge herself. Her pussy, still untouched, leaks femcum. \n\n ");
        outputText("A thin, almost girly incubus opens the door, looking between you and Meila. “Uh…Hey boss?” He speaks up in a womanly voice. “Can I have some fun with her after you’re done?” \n\n");
        outputText("Meila hears this, and tears form in her eyes. “...No, please. I…I can’t…Not after that…” \n\n");
        menu();
        addButton(0, "Sure", LetIncRapeMeila);
        addButton(1, "GTFO", MeilaKeepForYou);
    }

    private function MeilaKeepForYou():void {
        outputText("You tell the girly incubus that unless he wants to Join Meila on the shelf, he’ll grab what he needs and leave. Meila is part of YOUR Harem, not his, and you earned your rights to her body. He leaves, but you get the feeling that he’s just waiting until you leave. \n\n");
        outputText("You stay with Meila until she deflates enough, and you gently help her off the shelf. You tell Meila to wash up, and she shudders at your touch. \n\n");
        outputText("“...Of course, [master].” Meila seems scared, and you sigh. You genuinely hadn’t meant to hurt her, and you tell her that.\n\n ");
        outputText("“...You didn’t?” Meila says, doubtfully. You offer to walk her to the showers, to make sure nobody gets any ideas. Meila nods, not saying another word as she dons her cum-soaked dress. True to your word, you walk her into the back, and when you reach the showers, you nod, leaving her to wash up. \n\n");
        outputText("“Thanks…For stopping him.” Meila says, one hand over her chest. You turn back, and she gives you an odd smile.\n\n ");
        outputText("");
        player.sexReward("vaginalFluids","Dick");
        MeilaTrust += 10;
        doNext(FoodHall);
    }

    private function LetIncRapeMeila():void {
        clearOutput();
        outputText("You tell the Incubus that as long as he’s not going to fill her up more, or use her ass, he’s more than welcome to have your sloppy seconds. Meila chokes up, puking up a glob of your cum. “Why are you so cruel, [master]?” \n\n");
        outputText("You laugh, leaving for the food hall.\n\n");
        MeilaTrust -= 10;
        player.sexReward("vaginalFluids","Dick");
        doNext(FoodHall);
    }

    private function MeilaDPPullOut():void {
        clearOutput();
        outputText("You pull yourself out of her rapidly filling ass, your cock still twitching as it fires spurt after spurt of cum, slathering Meila in your cum. Swinging from your grip, Meila gags, spitting globs of off-white onto the floor. You let go as she brings her hands to her stomach, pressing down. Almost immediately, she moans in relief as her sphincter opens, drenching the floor in your sperm.\n\n ");
        outputText("“F-fuck…Ow…OW…” Meila seems to be in pain, and you gently help her body sit up, and she wraps her arms around your torso, breathing heavily as she slowly, painfully forces more and more of your cum out of her body. When she’s finally returned to some semblance of normalcy, her stomach somewhat flat again, she gives you a sigh. “As fun as you are…There’s such a thing as too much cum, you know.” You give Meila a grin, and she slaps your shoulder. “No, I mean it. I feel…” She burps, a most unladylike sound, and she covers her mouth. “Ew…It tastes terrible coming back up.” She looks at you, her irritation cutting through her submissive facade. “...Thank you for not blowing me up like a balloon…[Master].” \n\n");
        outputText("You decide that you’re done with Meila for now. After all, she’s going to need to clean up after your recent bout of lovemaking. \n\n");
        outputText("");
        player.sexReward("vaginalFluids","Dick");
        doNext(FoodHall);
    }




    private function MeilaForcedLick():void {
        clearOutput();
        outputText("You gently tell the worried Dullahan that you’re not going to tell Ceraph about how rude she was…but, as Ceraph’s owner, that Meila needs to know where she stands. Namely, under you. Holding her head by the braid, you move around the counter and into the back. Ceraph’s people have carved out a small storage area, and you wait until Meila’s body staggers into the back with you before closing the door.\n\n");
        outputText("As Meila’s body staggers in, you (if clothing) take off your [clothing], (if you have undergarments) pull down your (undergarments) and as Meila begins to shudder in your hands, you guide her body over to the padded chair in the corner, playfully pushing her into it. \n\n");
        outputText("The dullahan opens her mouth as you wedge her head between her thighs, giving her a low chuckle as you peel off her top, exposing her tender breasts. You feel a gasp from Meila as you position your hole above her lips. Her arms begin to move, trying to position her head, but you smack her fingers away, then take each of her B-cups in your hands, kneading the soft, cool tits. This gets a low moan from below you, and you squeeze harder. \n\n");
        outputText("You order Meila to start licking, and sit down on her, lips to lips. You feel her tongue slide past your labia, and you give the Dullahan a low purr, a few words of encouragement, your hands easing up on her tits. \n\n");
        outputText("Now comfortably on top, you lean in over Meila’s body, and begin playing with her. You run your hands along her breasts, then to her flanks. You hear Meila struggling, trying to breathe, and you cover her lips with your muff, telling her to keep licking. You’re not close to done. Her tongue flicks your clit, and you sigh happily as she begins sucking at your pussy, sinking her tongue in as far as she can. \n\n");
        outputText("You reward your eager slut with a low, slow kiss on the neck, moving one hand down to her hips, which shake underneath your weight. You begin rocking your hips, pulling on her nipple with one hand, your other around her waist. This gets you an even more enthusiastic lashing, and you hear Meila gasping for air beneath you with each movement of your [hips]. \n\n");
        if (player.gender == 3) {
            outputText("Your pussy is beginning to drip steadily, and your [cock] is rock-hard, oozing pre already. Meila’s own pussy is drenched, and you look down, ever so close to her lower lips. Do you line up your [cock] with her quim and make her watch?\n\n");
            menu();
            addButton(0, "Yes", MeilaHermLickFuck);
            addButton(1, "No", MeilaForcedLickFinish);
        } else {
           doNext (MeilaForcedLickFinish);
        }
    }

    private function MeilaHermLickFuck():void {
        clearOutput();
        outputText("With a grin, you slow down, tilting Meila’s head slightly. She gasps for air, her eyes focusing, and as you pull her waist in towards yours, Meila’s eyes widen. She can see the underside of your [cock] as you line up with her sopping wet nether-lips. \n\n");
        outputText("As you slide in the first few inches, her girly hips shaking as you slide past her labia, Meila begins breathing rapidly, a high-pitched cry escaping with every movement. Her whole body shudders, and as you bottom out inside her, your own pussy dripping into Meila’s mouth, you sit back down, pulling her body back towards you as you stifle her cries with your quim.\n\n ");
        outputText("Meila’s hips move, her whole body shaking as you begin rocking, fucking her cunt while rubbing your own across her face. Every time your cunt leaves her mouth, Meila gasps, her high-pitched cry barely making it out before getting smothered again. Content with a slower pace for now, you bring one hand to her ass, and begin playing with her backdoor, using a finger to prod her entrance. Meila’s pussy suddenly tightens around you, and she wails, the sound traveling up your spine. Her hips buck, sending shocks up your [cock] as she orgasms. \n\n");
        outputText("You pinch the twat’s nipple for coming first, and pick up the pace, sinking a finger into her ass as you fuck her. You feel her coming down from her first orgasm, her bucking slows, but you’re finally building up to yours. \n\n");
        outputText("Your [cock] twitches, and you let out a low moan as you sink to the hilt into Meila’s love-hole. Your pussy clenches, your legs seizing as your femspunk splatters her trapped face in your juice. At the same time, you spew your load deep inside Meila’s pussy. As you do, her arms wrap around you, and she holds on, your own orgasm setting her off. \n\n");
        outputText("For a moment, you hold on to each other, lost in your own respective highs. You look towards your slave-lover’s face…and remember that her head’s beneath your thighs. Slowly, painfully, you pull your [cock] out of Meila’s pussy, taking her head by the hair and putting it back on her neck.\n\n ");
        outputText("Meila’s tongue is still out, her eyes crossed. Her face and hair are drenched in your femcum, and she barely seems to be able to keep her head on. Your jizz begins to drip from her cunt, and as you stand, she reflexively closes her legs, as if she wants to keep it in there. A minute or so passes, and she moans, her eyes beginning to focus. \n\n");
        outputText("“...Wow.” Meila barely seems able to form words, and you grin. The dainty Dullahan is helpless, covered in your fluids. “I…Wow…” You ask if she’s okay, and she gives you a drunken thumbs-up. “J-just need a few…Minutes. I’ll be back to work soon.” \n\n");
        outputText("You decide to give Meila some time, heading back to the main hall for now.\n\n");
        player.sexReward("Default","Vaginal");
        player.sexReward("vaginalFluids","Dick");
        doNext(FoodHall);
    }

    private function MeilaForcedLickFinish():void {
        clearOutput();
        outputText("You rock back and forth, slowly, surely bringing your hand down from her breasts, to her stomach, occasionally slapping Meila’s ass with your free hand. You feel yourself building, your pussy tightening, and you moan, squirting all over Meila’s face. You ride out your high, then stand back up, looking down and admiring your handiwork. To your surprise, Meila’s flooded her seat with her own femcum, and she looks back up at you with her tongue out, and a dazed, satisfied look in her eyes. ");
        outputText("“You…You done?” She asks dreamily, giving you a winsome smile. You nod, and the dainty Dullahan shakes herself. “If that’s all you wanted, [master], I’ll head back to work. See you soon!” ");
        outputText("");
        outputText("");
        outputText("");
        outputText("");
        player.sexReward("Default","Vaginal");
doNext(FoodHall);
    }

    private function MeilaForcedBJ():void {
        clearOutput();
        outputText("You gently tell the worried Dullahan that you’re not going to tell Ceraph about how rude she was… but, as Ceraph’s owner, that Meila needs to know where she stands, namely, under you. You tell the worried Dullahan that you’ll do as you please. Holding her head by the braid, you move around the counter and into the back. Ceraph’s people have carved out a small storage area, and you wait until Meila’s body staggers into the back with you before closing the door. \n\n");
        outputText("In the back room, there’s a folding chair, and you grab Meila’s outstretched hand, pushing her towards it. Her body falls back into the chair, and you tell her to stay put. (If clothed) You pull down your [armor], revealing your [cock]. With one hand, you dangle Meila’s head in front of your crotch, and she looks at it, nearly crossing her eyes as your length hardens in front of her. \n\n");
        outputText("Not wasting any more time, you take her head in both hands and begin feeding your girth into Meila’s mouth. She closes her lips around you, gagging slightly, and to your surprise, as her body grabs the arms of her chair, you can see the vague outline of your [cock] in her throat!\n\n");
        outputText("More than a little turned on by this, you shove yourself to the base into Meila’s mouth, and as she gags, you can see her throat massaging your length. You begin slow, giving the skinny woman time to adjust, before working up to a quicker pace. Her throat starts cool, but quickly warms up, and as you throat-fuck her, Meila’s body twitches on the chair.\n\n");
        outputText("Her hands grip the seat tighter, and each time you bottom out inside her throat, you can see her legs twitch, toes curling ever so slightly. You pick up the pace, strands of Meila’s saliva dripping down your [legs], and you watch her legs curl out, ever so slightly. One of her hands smacks the armrest, and she moans frantically against your [cock]. Looking down, you see that her already pale face is even paler, and she’s trying to breathe. Not wanting to suffocate her, you pull out, the air cool against your exposed shaft as Meila gasps.\n\n");
        outputText("Turning your attention to her head, you(Pure or moderately corrupt) ask if she’s okay. Meila’s body gives you a thumbs-up, and as her breathing slows, she speaks. (Corrupt) tell the bitch that you’re going to shove it back in now.\n\n");
        outputText("“Yes…Please, use me to your heart’s content, [Master]”. You notice that Meila’s hand is snaking its way under her skirt. As you begin to face-fuck the Dullahan again, Meila spreads her legs, pulling down her panties, and begins to finger herself, spreading her little cunt wide as you slam yourself to the base.\n\n ");
        outputText("Meila moans slightly with each thrust, and you can see her lips twitching as she sinks a finger in, tears dripping onto your shaft as you pick up the pace even further. Her cries get higher, and you feel yourself twitching, aching for release. You try to hold back, to prolong the high, but you can’t hold on anymore. You slam in, dragging your balls across Meila’s chin as you cum deep down her throat. Vaguely, you can see Meila’s throat working as she swallows, mouthful after mouthful of your baby batter heading straight down her throat. \n\n");
        if(player.cumQ() <= 100) {
            outputText("As your orgasm ends, you slowly peel her head off your [cock], holding her up to your face.  Meila still has a bit of your cum on her tongue, and she sticks it out, giving you a wink as she swallows. \n\n");
            doNext(MeilaBJLowMedProductionAfterScenes);
        }
        if(player.cumQ() > 100 && player.cumQ() < 300) {
//medium production
            outputText("You hear her throat working from across the room, and Meila gags a little, a few tears falling as she wraps her lips around your base, drinking for all she’s worth. You see her stomach extend a little, but by the end of your orgasm, Meila’s clearly out of air. You pull her off, ordering her to stick her tongue out. Blindly, gasping for air, Meila obeys, and you run her tongue along your shaft, cleaning the mixed saliva and cum off your shaft. \n\n");
            doNext(MeilaBJLowMedProductionAfterScenes);
        }
        if(player.cumQ() > 300) {
            outputText("");
            outputText("");
            outputText("");
            doNext(MeilaBJHighProductionAfterScenes);
        }
    }

    private function MeilaBJLowMedProductionAfterScenes():void {
        if (MeilaTrust<30) {
            //Low Trust
            outputText("Meila coughs slightly, and you put her head back onto her body. It seemingly sticks in place on her neck, and Meila nods respectfully to you, closing her legs and pulling her panties back up. \n\n");
            outputText("“If that’s all you need from me, [master], then I’ll head back to work.” She pats herself down, brushing off the evidence of your little dalliance, then heads back to her post. \n\n");
            player.sexReward("none", "Dick");
        }
        if (MeilaTrust >= 30 && MeilaTrust <= 59) {
            outputText("For a moment, you stand there, looking at Meila’s body, specifically at the dripping fingers and wide-open cunt in front of you. \n\n");
            outputText("“Um…I know I’ve got a nice pussy, but if you’re not going to do anything else, would you mind putting me back?” Snapping back to reality, you gently put Meila’s head back onto her neck, and she reaches up, rotating it around. Meila sighs in relief, smoothing out her skirt. “I don’t say this to most people…But that was good.” She blushes slightly. “Please feel free to make use of my services again.” She pulls up her panties, ignoring the obvious dampness of them, and heads back out to her post. \n\n");
            player.sexReward("none", "Dick");
        }
            if (MeilaTrust >= 60) {
                outputText("Meila hums a little tune as you put her head back on, giving you a wink and a giggle. \n\n");
                outputText("“Thanks for the meal, [master]”, she purrs. “Always a pleasure to serve.” She pulls up her panties, ignoring the obvious dampness of them, and heads back out to her post. \n\n");
                player.sexReward("none", "Dick");
            }
    }

    private function MeilaBJHighProductionAfterScenes():void {
        outputText("You hear her throat working from across the room, and Meila gags a little, a few tears falling as she wraps her lips around your base, drinking for all she’s worth. Your balls churn, your [cock] twitching mightily as your orgasm drags on. You pull Meila’s head to your base, her cute button nose poking your groin, and watch as her throat distends with your length, her stomach slowly growing as you pour your jizz into her stomach. \n\n");
        outputText("As your orgasm drags on, you hear a muffled, weak moan. Meila’s body twitches, trying to rise, and you look down. A bubble of your jizz is forming on one of Meila’s nostrils, and her eyes are wide, rolling back into her head, clearly panicking. What do you do?\n\n");
        outputText("");
        menu();
        addButton(0, "PullOut", LetMeilaBreathe);
        addButton(1, "KeepGoing", JizzDrownMeila);

         }

    private function LetMeilaBreathe():void {
        clearOutput();
        outputText("You quickly pull Meila’s head off your length, and as she gasps for air, you aim your [cock] at her slender body, jerking yourself off. You splatter her tits, bare stomach, and legs with several ropes of your cum, then place her head onto her tits. Meila weakly holds her head in place, tongue out, as you give her hair, eyes, and mouth a liberal coating of white. \n\n");
        outputText("As you stick your [tongue] out, panting as you come down from your high, you hear a whistle from Meila.\n\n");
        outputText("“D-damn…” Meila says, fingering herself again. “Haven’t been that slathered since the last time…Well…” She trails off, but as you step away, towards the door, she drunkenly stands, wrapping a dainty hand around your waist. \n\n");
        outputText("“H-hey…I know you just…came a lot…” Meila says awkwardly. “But…Do you think you’ve got another round in you? (If Ceraph is in charge) I’m already going to get in shit for being back here for so long, and…I didn’t get to cum.” (If she’s in charge) I didn’t get to cum, and I know you like my body.” You put her head back onto her body, and she reaches down to massage your shaft. \n\n");
    MeilaTrust +=5;
        player.sexReward("none", "Dick");
        doNext(MeilaSexMenu);
    }

    private function JizzDrownMeila():void {
        clearOutput();
        outputText("Harshly, you order Meila to keep sucking. You aren’t going to let her go until you’ve finished dumping your load down her throat. Weakly, you can feel her moan, and you watch with no small satisfaction as her fingering weakens, the dainty Dullahan’s entire fading consciousness focused on sucking the last drop of cum out of you. Her stomach begins to bloat, and by the time you’re done, she looks like a headless pregnant woman. \n\n");
        outputText("You pull her head off your girth with a wet schlurp, cum dripping from her mouth. Her eyes are closed, her body limp, and for a second, you begin to panic…Did you…drown her in your cum?! \n\n");
        outputText("Your panic is dispelled as Meila begins coughing, her body clawing to all fours. You tilt her head to face down, and away from you, as she coughs up your cum. After a few rounds of coughing, she recovers enough to flip you off with both hands. \n\n");
        outputText("“F-Fuck you.” Meila sputters, chest heaving. You toss her head onto her tits, and she takes herself by the ears, reattaching her head. “I-I may be your slave, b-but I still need to breathe!” She coughs up another strand of jizz, eyes widening. “O-oh Gods…I nearly fucking DROWNED just now. In Jizz, like some kind of sexually deprived Goblin with a Bukkake fetish!” Her hands begin to shake. “F-Fuck, a-and…You…” She looks at you, realizing you’re still there. “You’re…Still…Here…” Her eyes widen, and she begins to hyperventilate. \n\n");
        outputText("");
        outputText("");
        MeilaTrust -=5;
        player.sexReward("none", "Dick");
        menu();
        addButton(0, "HelpHer", HelpMeilaRecover);
        addButton(1, "Leave", DrownNDash);

    }

    private function HelpMeilaRecover():void {
        clearOutput();
        outputText("You see a bucket in the corner, and bring it over as Meila heaves again. As she periodically coughs up your sperm, you pat her on the back, encouraging her to get it out, and holding her hair back. When she’s done, you wash out the bucket thoroughly, fill it with water and bring it and a cloth back, wiping her mouth gently. She recoils at your touch, but seems just as afraid that she did. \n\n");
        outputText("You reassure Meila, telling her that you’re sorry. She blinks, and you pass her the cloth. \n\n");
        outputText("“Y-you’re…Sorry?” She seems genuinely confused at this. You tell her that you didn’t mean to…well…\n\n");
        outputText("“To nearly drown me in your jizz?” She says, her voice sharp. “Yeah…I’ve heard that before.” She pauses, shuddering. “Although…Those who did…Didn’t exactly help me clean up afterwards.” You place a hand on her shoulder, telling her that you take responsibility for your actions, and that while she might be your slave…that doesn’t mean she deserves to nearly…die over this. \n\n");
        if (whosincharge == 0) {
            outputText("“Honestly…That may have been the easier way to go.” \n\n");
            outputText("You…You’re not really sure how to unpack that. You figured that Ceraph took people by force, judging from how she tried with you…But you hadn’t…really thought about it before now. \n\n");
            outputText("“...Yeah, I see that look.” She shakes her head slowly. “Ceraph didn’t get you, you got her. Doesn’t mean any of us got a break.” Meila sighs heavily, shuddering. “I need to get back to work…Just don’t mention this to Ceraph, okay?”  You assure her that you won’t, and Meila looks down at herself.\n\n");
        }
        outputText("");
        outputText("“Well…I can’t exactly do my work properly while I’m this covered. I’ll be out soon, just…Let me be for a bit.” You leave, closing the door behind you.\n\n ");
        outputText("");
        MeilaTrust +=10;
doNext(FoodHall);
    }

    private function DrownNDash():void {
        outputText("You tell Meila that her outburst won’t be held against her…But your [cock] very well might. You tell the dainty Dullahan to pull herself together and get back to work. You’re pretty sure she flips you off, coughing up another glob of your cum, but you don’t really care. \n\n");
        outputText("");
        outputText("");
        outputText("");
        MeilaTrust -=5;
        doNext(FoodHall);
    }



    //-----------------Jabba Scenes and Functions------------------
    private function Jabbasplace():void {
        clearOutput();
        outputText("As you enter the room where the Incel lab had been, you notice several demons milling about, carting boxes from place to place. A single, broad-chested, violet-skinned incubus sits in the middle of the hubbub, constantly looking back and forth between a curvy, five-foot omnibus with light green skin, and a slender, much taller succubus with long, thin horns and red skin. Scales form along her arms and legs, giving her a distinct reptilian look. Each wears next to nothing, barely more than a thong and pasties to cover their most enticing bits, but oddly, they wear thick collars around their necks, with thin cords trailing back to the Incubus’s wrists.\n\n");
        if (JabbaState == 0) {
            outputText("Each of the women are holding clipboards up as the incubus writes on them, periodically shuddering from head to toe as he whispers something to them. You approach, and he stops writing, turning towards you. His…attendants? Slaves? Seem to notice at the same time, and turn towards you. Their eyes are glazed over, a languid smile on each of their faces. They sway ever so slightly, side to side, in complete unison. \n\n");
            outputText("“Ah.” He nods respectfully. “You must be [Name]. That’s right, not [Master], I’m not one of Ceraph’s pets.” He chuckles. “Go help with the moving, my dears. You’ll know when I want you back.” They simply nod, the cords detaching from their collars. Their glazed eyes focus, they fly away, and he gives you his full attention. \n\n");
            outputText("“Ceraph brought me in to act as quartermaster for this operation of hers. Every business needs a logistics guy, and I’m the best.” He says this simply, no sense of bragging in his voice. “Instead of a gaggle of variously qualified merchants, I’m the only one selling shit here. Once you order something, my girls will grab what you ordered.” \n\n");
            outputText("You ask what Ceraph could be selling, and he grins. “While the biolabs have been shut down, there was a lot of other stuff being made here. Weapons, armor, that sort of thing.” He spreads his arms wide. “All that needs to be sorted, organized and logged before it can be sold.” He rubs his hands together, and his ladies fly back to him, still holding their clipboards. “Now, if you don’t mind, either buy something, or let me work. And no, the ladies aren’t for sale.” He gives one of the movers an annoyed glance. “As someone else has already found out”. \n\n");
            outputText("“My name is Jabba. I was one of the second generation of demons on Mareth.” He chuckles. “In the early days, there was more…diversity, shall we say, in demonkind. Not everyone turned for sexual pleasure, it’s just the most common.” \n\n");
            if (player.gender == 2) {
                outputText("He looks you up and down, a greedy look on his face. “My, my…I must admit, I’m a little surprised at your beauty…Champion.” He pats a spare collar, dangling from his belt. “Such a stressful life, so much pressure on that pretty face.” You can see the bulge in his pants as he stands, licking his lips. “Should you feel the need to…Destress, my ladies here find that a few hours blissfully unaware can do wonders for one’s mental health.” \n\n") ;
            outputText("Seeing your…less than enthusiastic reaction, he holds up both hands. “Oh, there’s no need to worry. This isn’t anything nefarious, my dear. The collars come off easily, and there are numerous safeties built in. Nothing untoward will happen to you without your permission…Aside from some potentially embarrassing exposure, but nothing we’re not seeing on a daily basis here.” \n\n");
        }
            if (player.gender != 2) {
                outputText("“I offer my services to all demons welcome in the domain, as well as my connections to the various armories worldwide…Although perhaps my collars would be of interest to you. I am told that your life here on Mareth is…Quite stressful. A few hours wearing one of these, and you’ll feel much better.” \n\n");
            }
            outputText("Crossing your arms, you tell him to tell you exactly what he means by that. He seems pleased by this, and he grins widely, revealing slightly stained teeth. \n\n" +
                    "“Simply put, dear champion, these collars temporarily numb the higher functions of your mind. Thoughts become harder to formulate, complex subjects become impossible to grasp. While you wear one, the collar will also nudge you towards things, tasks that have been predetermined.” \n\n");
            outputText("This sounds really suspect, and the look on your face says it all. Jabba rolls his eyes. “Perhaps a demonstration would suffice?” He motions, and an extremely muscular demon woman puts down the box she’s lifting and walks over. While she’s dressed in the same pasties and thong as the others, the black complementing her bright red skin, her muscles are extremely defined. She’s RIPPED. “This beauty here wants the body of an Amazonian Goddess, but struggles with holding the focus required to maintain such a physique. So, her collar nudges her towards physical tasks that require her strength. She’s a huge help around the Domain, maintains her ideal musculature, and gets paid on top of it.” \n\n");
            outputText("He grins, motioning for her to come to him. She does, and he reaches between her legs, rubbing the front of her thong. She grunts, but her eyes remain unfocused. Grinning, Jabba pushes her thong aside with one finger, sliding into the first knuckle. Immediately, her eyes focus, and she grabs Jabba by the neck, blinking as the collar’s trance rapidly fades.\n\n");
            outputText("“What the hell do you think you’re-” She blinks, realizing who she’s holding, and scowls. “Hey, that wasn’t the deal, fat man. You know I didn’t sign up for sex work.” She lets go, and he motions to you with one hand. \n\n");
            outputText("“I know, Hylla. I apologize for waking you early, but your shift is almost over.” He smiles warmly. “I decided to let you off a little early today.” \n\n");
            outputText("She looks at you, rolling her eyes. “And who’s this? I thought Trixy was your favorite right now”.\n\n");
            outputText("“This is [Name], Ceraph’s [Master] and the owner of the domain. I was merely showing them the collars’ safety features. The moment you’re impeded, or accosted, should that not be your function, the collar’s mental dampeners will stop, and you’ll be “woken up”, as it were.” \n\n");
            outputText("The large demon-woman, Hylla, shrugs, taking the collar off and passing it back to Jabba. “Gotta admit, it was weird at first. The concept is a bit backwards to some…But it works. I get my perfect bod, and get paid.” She flexes her biceps, and grins. “Thanks, fat man.” \n\n");
            outputText("You give him a raised eyebrow, asking what he gets out of it. “Isn’t it obvious? While some demons around here are loose, content to fornicate like beasts, with anyone around who reciprocates, I’ve never been as obsessed with the flesh. I enjoy sex as much as any, but that isn’t what truly…Motivates me. No.” \n\n");
            outputText("He gives you a hungry look, spreading his arms magnanimously. “What I enjoy, beyond any fleeting pleasure of the flesh, is control. And while ordering around imps and lesser demons can have its own pleasure, what I truly enjoy, more than anything else, is taking the great, the noteworthy: Those who could be changing the world or doing the deeds that epics are sung about…and having them under my control.”\n\n");
            outputText("You shudder. That sounds…creepy. He tuts, waggling a finger. “Oh, no. Not like that. To completely turn someone like that…Would be wasteful, not to mention a tragedy.” He points at one of the demonesses who’s carrying a box to him, a succubus with a cute face, glasses and a silver ring on her tail, just below the spade. “This fine young woman, for example. She was one of Ceraph’s researchers, and was barely able to get away when you came through and slaughtered her peers. She was one of the brightest enchanters in Lethice’s employ…But for right now, her near-peerless intellect is dedicated solely to carrying a box around, or holding my clipboard for me. And doing it all with a smile on her face.” She puts it down, leaning in towards him. “Good girl. Now, why don’t you take care of a few orders for me, Wanda?” \n\n");
            outputText("“Yes, master”. Wanda’s eyes focus slightly. “W-who’s that?” She seems slightly nervous, even with the collar numbing her mind. “I-I…Know them…” \n\n");
            outputText("“No, you don’t. If they’re bothering you, dear, then why don’t you go help Monty with the swords?” He puts a hand on her head…Petting her? She seems to calm back down. She flies away, and he smiles contentedly. “See? Perfectly safe, consensual…And profitable.”\n\n");
            outputText("");
            JabbaState = 1;
        } else if (JabbaState == 1) {
            outputText("Jabba sits in a wide, throne-like chair behind an intricately carved mahogany desk, on the left side of the room. An incubus, clad only in a loincloth and collar, stands beside him, and you can see several demons flying to and fro, carrying crates full of everything from foodstuffs to skimpy outfits to vials of milk and ale. Jabba has a pen in each hand, looking back and forth between two sets of ledgers, a requisition form, and a few letters. His desk is covered in paper, and he seems quite busy. \n\n");
            outputText("A collar-clad Omnibus with the glazed eyes of a deep trance sits up as you enter, her own table blocking your entry into the market. “Hello, [Master], my name is Trixy…And I am very pleased to be serving you today. Is there anything I can help you with?” ");
            outputText("");

        }
        menu();
            addButton(0, "Shop'", JabbaShop);
            addButton(1, "Dronify", JabbaDroneJob);
        addButton(14, "Back", FoodHall);
    }

    private function JabbaDroneJob():void {
        clearOutput();
        outputText("You tell Jabba that you’re here to check in, and his eyes light up. “Well, this just makes my day. Head on back, dear [Name]. Leave your things back there, my dears will take good care of your equipment. I’ll see you again in a moment…But you’ll see me later. Now, what job should I put you down for?” \n\n");
        outputText("");
        outputText("");
        addButton(0, "Whoring'", DronifyWhore);
        addButton(1, "Dancing", DronifyDance);
        addButton(2, "Moving'", DronifyMove);
        addButton(14, "Back", Jabbasplace);
    }

    private function DronifyMove():void {
        clearOutput();
        outputText("Jabba orders one of his drones to escort you into a changing stall, and you find (if breasts aren’t flats) two fresh stickies for your nipples and (split end) a thong. You shed your own gear, leaving it in the stall and dressing in your ‘uniform’. You open the door, poking your head out, and a femboy incubus with nubs for horns is standing there, a dreamy look on his face. He holds out a collar for you, and as you take it, holding the collar, your hands start to feel numb, twitching slightly, as if the collar’s already influencing your actions. \n\n");
        outputText("“Don’t…Hesitate.” The femboy demon in front of you says, snapping you out of your thoughts. “Makes it harder to relax.” He shakes, like a dog shedding water, and his eyes focus. “I can help if you want.” \n\n");
        outputText("You shake your head. You’ve already made your decision. With less hesitation, you raise the collar to your neck. The smooth satin inside is warm and comfortable, and as you clasp it shut, you…Whoa…\n\n");
        outputText("Your vision blurs around the edges…You feel your hands moving…The very air seems thicker, warmer. The world’s…So nice. You feel your nipples harden (if not flats) under their stickies…(split end)You feel a pulse from the collar, your hands moving on their own. With each twitch, each movement, you feel a warm…fog…It would be so easy to just…Let your body move on its own. To keep that pleasure flowing.\n\n");
        outputText("Obey. The thought rises, unbidden. You try to fight it for a moment, and your hands obey you. Your vision starts returning to normal, the collar’s effect weakening…and the pleasure fades, leaving you cold and exposed. A sliver of panic surges through you at the thought…\n\n");
        outputText("Wait…You’re already at Master’s throne. He’s…Looking down at you, pleased…But he’s noticing your thoughts. Your eyes! They’re…Not pleasing Master. Gulping, you open your mouth to speak…But that isn’t what you…Should…Do…\n\n");
        outputText("The collar guides your mouth into a winsome smile, and you can’t…think…of any reason…to stop it. Your vision blurs, your jaw falls slack…\n\n");
        outputText("“Very good.” Those words send a sudden burst of pleasure through you. (If pussy) Your clit vibrates, your labia shaking as if his words were a cock, right at your entrance. (If both) and (If dick) the thong can’t hide your erection. His words wrap around your [cock] like a warm, slick vice. \n\n");
        outputText("You…Want More…\n\n");
        outputText("“That’s it…Let the collar take control. Rest, [Name], let yourself drown in the pleasure.” Your mouth’s moving, the collar’s warmth spreading. Finally, your eyelids sink, half-covering your vision…Not that you care. You’re so warm, deliciously swathed in the collar’s embrace.\n\n");
        outputText("Master is very happy. You move slowly towards him, and he brings one hand to your cheek. His touch is smooth, comforting…He’s saying something…But it doesn’t matter what. Your body knows what to do. Master’s got plans for you…and even the thought of disobeying sends a sliver of cold panic through your heart. \n\n" +
                "\n" +
                "Good.\n" +
                "\n" +
                "Obey.\n" +
                "\n" +
                "Work.\n");
        outputText("Following the gentle pulsing of your collar, you move to the back of the domain, where several strong-looking drones are already hard at work, picking up boxes of various sizes, carrying them off into different rooms, seemingly with no direction needed. \n\n");
        outputText("You let your mind go blank, the warm, gentle direction of the collar more than sufficient to guide you. Master speaks through the collar, and you obey, grabbing a large box of toys and carrying them deep into the former lab. \n\n");
        outputText("Slowly…You feel yourself breathe more evenly, your eyes heavier. You move steadily, easily, with a languid grace…Not that you care. Deep within your mind, you’re at peace, not a single thought running through you as your body works. \n\n");
    }

    private function DronifyDance():void {
        clearOutput();
        outputText("Jabba orders one of his drones to escort you into a changing stall, and you find (if breasts aren’t flats) two fresh stickies for your nipples and (split end) a thong. You shed your own gear, leaving it in the stall and dressing in your ‘uniform’. You open the door, poking your head out, and a femboy incubus with nubs for horns is standing there, a dreamy look on his face. He holds out a collar for you, and as you take it, holding the collar, your hands start to feel numb, twitching slightly, as if the collar’s already influencing your actions. \n\n");
        outputText("“Don’t…Hesitate.” The femboy demon in front of you says, snapping you out of your thoughts. “Makes it harder to relax.” He shakes, like a dog shedding water, and his eyes focus. “I can help if you want.” \n\n");
        outputText("You shake your head. You’ve already made your decision. With less hesitation, you raise the collar to your neck. The smooth satin inside is warm and comfortable, and as you clasp it shut, you…Whoa…\n\n");
        outputText("Your vision blurs around the edges…You feel your hands moving…The very air seems thicker, warmer. The world’s…So nice. You feel your nipples harden (if not flats) under their stickies…(split end)You feel a pulse from the collar, your hands moving on their own. With each twitch, each movement, you feel a warm…fog…It would be so easy to just…Let your body move on its own. To keep that pleasure flowing.\n\n");
        outputText("Obey. The thought rises, unbidden. You try to fight it for a moment, and your hands obey you. Your vision starts returning to normal, the collar’s effect weakening…and the pleasure fades, leaving you cold and exposed. A sliver of panic surges through you at the thought…\n\n");
        outputText("Wait…You’re already at Master’s throne. He’s…Looking down at you, pleased…But he’s noticing your thoughts. Your eyes! They’re…Not pleasing Master. Gulping, you open your mouth to speak…But that isn’t what you…Should…Do…\n\n");
        outputText("The collar guides your mouth into a winsome smile, and you can’t…think…of any reason…to stop it. Your vision blurs, your jaw falls slack…\n\n");
        outputText("“Very good.” Those words send a sudden burst of pleasure through you. (If pussy) Your clit vibrates, your labia shaking as if his words were a cock, right at your entrance. (If both) and (If dick) the thong can’t hide your erection. His words wrap around your [cock] like a warm, slick vice. \n\n");
        outputText("You…Want More…");
        outputText("“That’s it…Let the collar take control. Rest, [Name], let yourself drown in the pleasure.” Your mouth’s moving, the collar’s warmth spreading. Finally, your eyelids sink, half-covering your vision…Not that you care. You’re so warm, deliciously swathed in the collar’s embrace.\n\n");
        outputText("Master is very happy. You move slowly towards him, and he brings one hand to your cheek. His touch is smooth, comforting…He’s saying something…But it doesn’t matter what. Your body knows what to do. Master’s got plans for you…and even the thought of disobeying sends a sliver of cold panic through your heart. \n\n" +
                "\n" +
                "Good.\n" +
                "\n" +
                "Obey.\n" +
                "\n" +
                "Work.\n");
    }

    private function DronifyWhore():void {
        clearOutput();
        outputText("Jabba orders one of his drones to escort you into a changing stall, and you find (if breasts aren’t flats) two fresh stickies for your nipples and (split end) a thong. You shed your own gear, leaving it in the stall and dressing in your ‘uniform’. You open the door, poking your head out, and a femboy incubus with nubs for horns is standing there, a dreamy look on his face. He holds out a collar for you, and as you take it, holding the collar, your hands start to feel numb, twitching slightly, as if the collar’s already influencing your actions. \n\n");
        outputText("“Don’t…Hesitate.” The femboy demon in front of you says, snapping you out of your thoughts. “Makes it harder to relax.” He shakes, like a dog shedding water, and his eyes focus. “I can help if you want.” \n\n");
        outputText("You shake your head. You’ve already made your decision. With less hesitation, you raise the collar to your neck. The smooth satin inside is warm and comfortable, and as you clasp it shut, you…Whoa…\n\n");
        outputText("Your vision blurs around the edges…You feel your hands moving…The very air seems thicker, warmer. The world’s…So nice. You feel your nipples harden (if not flats) under their stickies…(split end)You feel a pulse from the collar, your hands moving on their own. With each twitch, each movement, you feel a warm…fog…It would be so easy to just…Let your body move on its own. To keep that pleasure flowing.\n\n");
        outputText("Obey. The thought rises, unbidden. You try to fight it for a moment, and your hands obey you. Your vision starts returning to normal, the collar’s effect weakening…and the pleasure fades, leaving you cold and exposed. A sliver of panic surges through you at the thought…\n\n");
        outputText("Wait…You’re already at Master’s throne. He’s…Looking down at you, pleased…But he’s noticing your thoughts. Your eyes! They’re…Not pleasing Master. Gulping, you open your mouth to speak…But that isn’t what you…Should…Do…\n\n");
        outputText("The collar guides your mouth into a winsome smile, and you can’t…think…of any reason…to stop it. Your vision blurs, your jaw falls slack…\n\n");
        outputText("“Very good.” Those words send a sudden burst of pleasure through you. (If pussy) Your clit vibrates, your labia shaking as if his words were a cock, right at your entrance. (If both) and (If dick) the thong can’t hide your erection. His words wrap around your [cock] like a warm, slick vice. \n\n");
        outputText("You…Want More…\n\n");
        outputText("“That’s it…Let the collar take control. Rest, [Name], let yourself drown in the pleasure.” Your mouth’s moving, the collar’s warmth spreading. Finally, your eyelids sink, half-covering your vision…Not that you care. You’re so warm, deliciously swathed in the collar’s embrace.\n\n");
        outputText("Master is very happy. You move slowly towards him, and he brings one hand to your cheek. His touch is smooth, comforting…He’s saying something…But it doesn’t matter what. Your body knows what to do. Master’s got plans for you…and even the thought of disobeying sends a sliver of cold panic through your heart. \n\n" +
                "\n" +
                "Good.\n" +
                "\n" +
                "Obey.\n" +
                "\n" +
                "Work.\n");
        outputText("");
        outputText("");
        outputText("");
    }


    private function JabbaShop():void {
        outputText("");
        outputText("");
        outputText("");
        addButton(14, "Back", Jabbasplace);
    }


    //-----------------Nolan Scenes and Functions------------------

    private function NolanTalk():void {
        clearOutput();
        if (NolanState == 0) {
            outputText("As you walk towards the suit-clad demon, you can hear the whispers of demons around you. Some turn away, not wanting to look, others seem to hold their breath, looking between the two of you like titans about to clash. In particular, a succubus and a flat-chested omnibus watch you closely, talking in what they think are whispers. \n\n");
            outputText("“Oh…Shit. [Name]’s about to talk to…Him.” The Omnibus is wide-eyed. \n\n");
            outputText("“Who the fuck is he?” The Incubus looks unimpressed.\n\n");
            outputText("\"That dude over there? He's a weirdo. He calls himself a Nullcubus, whatever that means.\" The Omnibus speaks with mild fear in his voice, but the incubus scoffs. \n\n");
            outputText("\"Nullcubus? More like Lamecubus, am I right? That suit? BOH-RING!\" \n\n");
            outputText("\"DUDE, shush! You do not want to get on his bad side.\" Deciding to find out a little more, you stop, walking over to the demons and pulling up a chair. They stop cold, looking at you like a pair of startled deer. You tell them to speak up. Who is that odd demon in the corner?\n\n");
            outputText("They stare at you, then at him, scared, then lower their voices, leaning in. A few other demons join you at the table, stealing glances over at the purple-skinned oddball. ");
            outputText("\"I heard he can punch away your sensitivity. Imagine that, how can I enjoy sex if my pussy is numb to the touch?\" This gets a collective shudder from the assembled demons. ");
            outputText("\"Forget punching, I heard he doesn't even need to touch you. Apparently he has some kind of weapon in his clothing, that or it's some custom magic of his. If he turns it on you, he can make your entire body numb\"This gets audible gasps from several of the assembled demons. Some of the succubi even look nauseated by the very thought. \n\n");
            outputText("\"I heard that he's got some weird chemicals stashed in every inner pocket of that damn suit. If so much as a drop gets in you, injection, pill, or hell, it leaks onto a papercut, you will never cum for the rest of your life. You'll just edge forever, and it will never release\". At this, one scrawny incubus’s eyes light up, and he begins to slowly back away in the suited demon's direction. Several others tackle him to the ground and pull him away. \n\n");
            outputText("The male omnibus in front of you, the one who started this conversation, shudders. \"Whatever you do, DON'T ask him about what he actually does. Poor Freya was in a coma for a week, couldn't cum for a month, and all he did was talk.”\n\n");
            outputText("“The only reason Ceraph can even get within 10 feet of that guy is cause she owns the place. Apparently, he's got, like, work ethics or something, so if you're not a boss or a higher up, he will ruin your sex life.\"\n\n");
            outputText("You ask them his name, and the omnibus shudders. “Nolan.” Seriously? NOLAN? You decide you’ve had enough with these silly lesser demons and their ghost stories. Standing, you shoo them away, striding over to the suit-clad demon. \n\n");
            //if silly mode is active
            outputText("As you get close, you see Nolan putting away a screwdriver. Seems he was tinkering with something. In his other hand, he releases a small creature. The critter has wheels for feet, and its body is metallic, a tiny golem perhaps?\n\n");
            outputText("The creature turns to face Nolan and speaks despite having no mouth. Its voice is monotone and dull. “What is my purpose?”\n\n");
            outputText("“Pass the sugar.” The creature wheels over to a small cup of sugar cubes on the other side of Nolan's desk. Using its claw-tipped metal arms, it hooks on the cup's handle and drags it over to Nolan. “Thank you.” Nolan grabs 2 cubes and drops them into his drink before stirring.\n\n");
            outputText("The creature speaks again, “What is my purpose?”\n\n");
            outputText("Nolan sighs, “You pass sugar.” At this, the creature looks around, then onto itself. It then slumps in a moment of realization. “Oh my god.”\n\n");
            outputText("“Welcome to the club pal,” Nolan says nonchalantly as he returns to his work. The creature, seeing its chance, takes the opportunity and rolls itself off the desk. It crashes upon hitting the floor, breaking into many small pieces.\n\n");
            outputText("Nolan looks at the mess that was the tiny golem. His gaze is cold and shows annoyance. “Ugh, fuckin hell.” He quickly picks up the pieces and then tosses them in the nearby trash can.\n\n");
            outputText("Unfazed by what happened, Nolan focuses on his open briefcase. What in the fuck was that?\n\n");
            outputText("");


        //if silly mode is disabled
        outputText("Nolan seems to be entirely focused on his work. A few papers sit on the table, but the center of his attention is clearly his briefcase, opened up to reveal a screen and keyboard, not too unlike the one in the panic room. A mug of black fluid sits to one side of his briefcase, and he picks it up, casually taking a sip.\n\n ");
        outputText("You pull out a chair, sitting down in front of him. You ask who he is, and his gaze doesn’t move. He holds up a single finger, signaling for you to wait, before typing out something short. He then folds his briefcase up, finally looking over the table towards you. \n\n");
        outputText("“I wondered when you’d come speak with me, [Name]. You get bored of listening to those simpletons spread their ghost stories?” Well, he knows who you are, clearly. You ask him his name, and he raises one eyebrow. “I am Nolan. Nolan the Nullcubus. I know you killed many of my former colleagues here in the labs, and I know you’re the [master] of Ceraph, the owner of this new den of debauchery.” He takes a sip of his coffee, inclining his head. “As Ceraph’s [master], you’re... my boss, I suppose.” He looks back to his computer. “If there’s nothing you require of me, I’d prefer to get this done before the end of today.” \n\n");
        outputText("Despite his demonic nature, Nolan seems so…Normal. So mundane and boring. You can almost feel your lust draining from your body as he speaks. No wonder the other demons are afraid of him.\n\n");
            NolanState = 1;
        }
        else if (NolanState ==1) {
            outputText("As you approach Nolan, you see a pink-skinned succubus with a particularly vacant expression trying to talk with him. “Oh, like, come ON, nerd boy. Take a break from your lame papers and have some FUN.” \n\n");
            outputText("Nolan seems mildly irritated and looks up from his computer. “I’ll have you know that the information on one of these ‘papers’ is more than the sum of information your underdeveloped brain is capable of containing.” \n\n");
            outputText("“Wh-what?” The succubus blinks a few times, and you can all but see the gears turning in her head. \n\n");
            outputText("“I just called you stupid.” Nolan looks completely done with this slut and her requests.\n\n ");
            outputText("“Oh yeah? Would someone stupid do... This?” The succubus leans in, forcefully sitting down on Nolan’s lap. She seems to feel something uncomfortable, but ignores it, licking her lips as she brings her hands down to the annoyed demon’s groin. For a second or so, she looks down, confused, then her eyes widen, and she stands back up, a horrified look on her face. \n\n");
            outputText("“Y-you have... Nothing?” She whispers, and Nolan stares into her eyes, lips drawn into a scowl.\n\n");
            outputText("“Yes. Someone stupid WOULD do that, clearly.” He says, deadpan. He points at the succubus, the air warping slightly, like a sudden wave of heat traveling from him to the demoness. As it hits her, she brings her hands down to her pussy, pushing aside her bikini bottom. To her horror, she can’t seem to feel anything. \n\n");
            outputText("“WHAT HAVE YOU DONE?!” She wails, running away from Nolan, and onto the dance floor. \n\n");
            outputText("Nolan sees you, and his scowl softens slightly. He turns back to his coffee and resumes his work.\n\n");
            outputText("“Well? What do you want?” He asks. His tone is polite, but cold. \n\n");
        NolanState = 2;
        }
        else if (NolanState ==2) {
            outputText("You walk over to Nolan, and sit down at his table. He types a few lines, sips his coffee, and glances up. \n\n");
            outputText("“Oh, it’s you.” He shakes his head slightly. “I thought that vapid cunt was back.” You raise one eyebrow, and he sighs. “Some demons don’t even seem to understand consent anymore, let alone think it matters.” He scowls. “Honestly, the sheer irony, that the person literally kidnapping people to harvest for body parts, seems to be the only one who will leave me alone when asked!” \n\n");
            outputText("You ask him if he’s good, and he shrugs. “I’ll live. It’s merely an annoyance, and an occupational hazard now, I suppose.”\n\n");
            outputText("");
            outputText("");
            NolanState = 3;
        }
        else if (NolanState ==3) {
            outputText("As you approach, Nolan looks up, nodding at you. “Pull up a chair. I’ll be right with you.” He folds his laptop, looking you in the eyes. “What brings you to my desk?”\n\n");
        }
        menu();
        addButton(0, "Appearance", NolanAppearance);
        addButton(1, "Talk", NolanTalk);
        addButton(2, "Business", NolanQuestMenu);
        if (NolanState == 4 && NolanQuest1State ==2 && NolanQuest2State ==2 && NolanQuest3State ==2 && NolanQuest4State ==2 && NolanQuest5State ==2 && NolanQuest6State ==2 && NolanQuest7State ==2 ) {
            addButton(3, "TakeOver", NolanTakeOverTalk);
        }
        addButton(14, "Back", StripClub);
    }

    private function NolanAppearance():void {
        clearOutput();
        outputText("You examine the suit-clad demon in front of you. He appears to be somewhere around 5 foot 10 inches. His indigo skin is smooth and his pitch-black hair is combed in a neat fashion, not a single stray strand sticking out. He has 4 horns jutting out the sides of his head, all pointing backward like that of most demons. His ears are large and pointed, similar to that of an elf’s. Unlike other demons, whose tails wrap around their legs when at rest, his tail sticks outwards, dragged down by gravity, only curling up near the end, not too dissimilar to a dog’s tail.\n\n");
        outputText("His dark grey suit is perfectly formed to his body. Unlike other demons whose clothing is revealing and slutty, his clothes are very concealing, not showing any more skin than necessary. The under uniform is also grey, and his necktie is red and orange.\n\n");
        outputText("You recognize the buttons and cufflinks of the suit to be made using icestones and numbrocks. On closer examination, the threads of the suit seem to shine with a similar gleam to that of ebonbloom flowers. The rim of the outer layer of his suit goes down, nearly reaching his knees, similar to a trench coat or lab coat, likely a stylization choice. A vent in the back allows his tail to poke through unimpeded.\n\n");
        outputText("You hear Nolan cough to get your attention. You snap back to reality, realizing you were staring a bit too much. “Are you done gawking?” You quickly apologize, stating that you’ve simply never seen a demon like him before.\n\n");
        outputText("Nolan sighs. “You likely never will. Even among my former colleagues, who were formed from some of the greatest minds in Mareth, even they were nothing like me.” You wouldn’t be surprised if Nolan is a one-of-a-kind demon.\n\n");
        outputText("");
        menu();
        addButton(0, "Appearance", NolanAppearance);
        addButton(1, "Talk", NolanTalk);
        addButton(2, "Business", NolanQuestMenu);
        if (NolanState == 4 && NolanQuest1State ==2 && NolanQuest2State ==2 && NolanQuest3State ==2 && NolanQuest4State ==2 && NolanQuest5State ==2 && NolanQuest6State ==2 && NolanQuest7State ==2 ) {
            addButton(3, "TakeOver", NolanTakeOverTalk);
        }
        addButton(14, "Back", StripClub);
    }

    private function NolanQuestMenu():void {
        clearOutput();
        //First Time seeing this menu
        outputText("You ask Nolan if he has any tasks he would like you to do for him. This gets a reaction from Nolan, who looks at you, an eyebrow raised in confusion.\n\n");
        outputText("“You do realize you are the boss here, right, and yet you want to do work for me?” He tilts his head, intrigued by your request. “Are you sure your head is on straight?”\n\n");
        outputText("Ignoring Nolan's last comment, you tell him to stop thinking of you as a boss. All you did was conquer this place, only to hand it off to someone else. If anything, you're more of an investor or a landlord as opposed to an owner. Besides, you like seeing your projects succeed, and if you have to get your hands dirty to do that, then so be it.\n\n");
        outputText("Nolan smirks, “I see. You truly are an interesting one.” He looks towards the top of his briefcase, unzipping a small flat pocket on the outer case. He pulls out a neat and organized folder full of papers.\n\n");
        outputText("He hands the folder to you. “These are a collection of tasks, a mix of projects and commissions. I meant to finish them in my own time, but due to the high number of more demanding and urgent projects, these smaller ones have been left incomplete.”\n\n");
        outputText("You take the folder and flip through it. Your eyes go wide. They are full of writing, diagrams, and blueprints, most of which are too complex for you to even grasp. \n\n");
        outputText("You hear Nolan chuckling to himself, amused by your failure to grasp his work. “Hey, don't forget that you're the one who offered your assistance, so you have no right to complain.” After a few deep breaths to regain his composure, he continues. “If there is any confusion on a given task, simply ask and I will clarify.”\n\n");
        //Subsequent times
        outputText("You open the folder of tasks that Nolan provided you. You look over your options, each one too confusing for you to grasp your head around. You hear Nolan speak up. “Do you have any questions for me?”\n\n");
        menu();
        addButton(0, "Task 1", Nolan1Quest);
        addButton(1, "Task 2", Nolan2Quest);
        addButton(2, "Task 3", Nolan3Quest);
        addButton(3, "Task 4", Nolan4Quest);
        addButton(4, "Task 5", Nolan5Quest);
        addButton(5, "Task 6", Nolan6Quest);
        addButton(6, "Task 7", Nolan7Quest);
        addButton(14, "back", NolanTalk);
    }

    private function Nolan1Quest():void {
        clearOutput();
        if (NolanQuest2State == 1 || NolanQuest3State == 1 || NolanQuest4State == 1 || NolanQuest5State == 1 || NolanQuest6State == 1 || NolanQuest7State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 0) {
            outputText("You take out one of the neatly stapled groups of paper. To your surprise, the first paper is just a crude drawing of what looks like an evil black cat breathing fire. This catches you off guard, so you question Nolan about this strange art piece.\n\n");
            outputText("Nolan takes the paper and sighs. “Ah, this. I understand your confusion, and that’s exactly what I’m trying to solve.”\n\n");
            outputText("Setting the drawing aside, Nolan begins to regal you with the tale of how he got this drawing. “I was at a small town in the desert. It was difficult getting in, but a few magical deceptions were enough to sneak by. I held no malice towards the place anyway, I was just exploring at the time.”\n\n");
            outputText("So Nolan has been to Tel’Adre. You didn’t think any demon could get in, guess Nolan is just that smart. He continues, “While I was wandering the streets, a small goblin was running up to strangers, asking for help. Everyone was avoiding her, likely deterred by her being a goblin. You know how lustful they are, right?”\n\n");
            outputText("You can’t argue there. Goblins have been quite the pest throughout your journey, so it’s not surprising people wouldn’t trust them.\n\n");
            outputText("Nolan continues, “I had nothing better to do, so when the goblin approached me, I agreed out of curiosity. Imagine my surprise when she didn’t try to sexually assault me, but instead begged me to slay a demon cat in the forest. According to her, the giant cat was a demon who breathed fire. She even drew that picture for me when I asked for more details. I wouldn’t have believed her if it weren’t for the burn marks on her body.”\n\n");
            //if player has met Akbal
            outputText("You recognize that description. You tell Nola that the goblin was probably talking about Akbal. Nola raises an eyebrow in surprise. “So the goblin was telling the truth. Interesting.”\n\n");
            outputText("Nolan strokes his chin in deep thought. Finally, he speaks up, “Regardless, your goal is still the same. I want physical proof of this cat, as well as samples I can study. I wish to learn more of this ‘Akbal’ character.”]");
            //if somehow you haven't met Akbal yet
            outputText("This is awesome! You ask if he’s sending you on a hunt for a cryptid. Nolan nods, “Pretty much. Given the world we live in, I have no reason not to believe such a creature could exist, but the details are a bit too specific, and frankly, the green fire is a bit of a stretch.”\n\n");
            outputText("Clearing his throat, he clarifies your mission. “Specifically, I want you to gather physical proof of this oversized feline. Samples of the creature will do, maybe some fur, blood, or even saliva should be fine. Of course, if the creature doesn’t exist, then I won’t mind you coming back empty-handed”\n\n");
            outputText("You ask Nolan how many samples he would need. “Hmm, if we assume each sample only has the minimum available potency, I’d say to gather five... no, ten, just to be safe.”\n\n");
            outputText("Taking back the drawing, you make your way out. It’s time to go cat hunting.\n\n");
        NolanQuest1State = 1;
            doNext(FoodHall);
        } else if (NolanQuest1State == 1 && AkbalSamples < 10) {
            outputText("You decide to ask Nolan about the drawing again. What was it exactly you were supposed to do?");
            outputText("Nolan sighs, “Look [Name], I don’t mind if you come back empty-handed and all, but I can tell you haven’t even tried to look. Use that drawing as a physical descriptor of the creature you’re hunting. I need at least ten samples.”\n\n");
            outputText("You ask what constitutes a sample and if he needs anything specific.\n\n");
            outputText("“I don’t care what the sample is. Fur, blood, spit, or hell, if you’re really freaky, feel free to fuck the thing and bring back its other bodily fluids. As long as there’s something physical I can analyze.”\n\n");
        outputText("You nod in understanding. You put away the drawing of the large black cat spitting green flames. There are trees in the background of the drawing, so perhaps you should search the forests for the beast.\n\n");
        } else if (NolanQuest1State == 1 && AkbalSamples > 9) {
            outputText("You triumphantly take out the vials of spit and lay them before Nolan. He eyes the vials, clearly skeptical of their validity.\n\n");
            outputText("“And these are?” he asks, clearly wanting an explanation. You tell Nolan about the demon Akbal, a self-proclaimed deity who roams the deepest recess of the forests, tormenting and raping anyone in his path.\n\n");
            outputText("Nolan listens intently. “Fascinating. A demon cursed with the body of an apex predator. Not sure if it’s truly a curse or a gift, after all, I can think of many demons who would love to prowl around assaulting people as a literal predator.”\n");
            outputText("He stares intently at the samples. “After some minimal observation, I can tell there’s some strange magic tied to this stuff, though it’d be barely noticeable for anyone not actively looking for anomalies. I’ll take your word on their validity for now.”\n\n");
            outputText("Carefully, Nolan stashes away the vials. After ensuring they won’t spill, he reaches into another pocket, pulling out a small pouch of what you assume to be gems. He passes the pouch to you, which you take graciously.\n\n");
            outputText(" “For now, I’ll see what I can do with these samples. Perhaps I’ll be able to reverse engineer the curse, or maybe improve upon it.” You can see him smile wickedly to himself.\n\n");
            outputText("Nervously, you ask what use he’d have for such a curse. Nolan simply shrugs. “Truthfully, I don’t really have a use for most of the information in my head. I simply wish to learn all I can, regardless of the intended use of said knowledge. I’m a scientist after all.”\n\n");
            outputText("As reassuring as that is, you can’t help but feel that Nolan has other plans. You ask if he’s sure he doesn’t have any ulterior motives. Nolan just sighs in annoyance, “Obviously I do, who wouldn’t? Besides, that’s not important right now. You got your gems and the task is done, so can we change the subject already?”\n\n");
        //give player 3000 gems
            NolanQuest1State = 2;
        }
    }

    private function Nolan2Quest():void {
        if (NolanQuest1State == 1 || NolanQuest3State == 1 || NolanQuest4State == 1 || NolanQuest5State == 1 || NolanQuest6State == 1 || NolanQuest7State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest2State == 0) {
            outputText("You take out some papers stapled together. Flipping through, you find one page with a very well-drawn sketch of a dark cat-girl with two tentacles and four arms. Several parts of its body are labeled, each with their own detailed descriptors.\n\n");
            outputText("You show this page to Nolan, asking him what this is. Nolan eyes the page. “Ah, I remember that. It’s been a while since I did research on displacers.” He rubs his chin, trying to remember something.\n\n");
            outputText("Suddenly, he snaps his fingers. “Ah yes!” Reaching into his briefcase’s many pockets, he pulls out a blueprint for what looks to be... a bracelet?");
            outputText("You ask Nolan what displacers have to do with jewelry. Nolan rolls his eyes and ignores your comment. “Okay, so listen. I need you to fetch me a live displacer for me to study.”\n\n");
            outputText("What?! Capture a live displacer? Is that even possible, doesn’t he know that those cats can teleport?");
            outputText("“Obviously I know that. I need one alive to study its space-warping properties. You know how firearms are limited by their ammunition, correct?” You nod, it’s a pretty obvious fact after all. “Well then, what if I tell you that you could store an entire army’s worth of ammunition inside of this bracelet. Once I figure out the space-warping magic around the displacers and learn how to replicate it, you’ll be able to effectively shoot nonstop with an endless stream of lead.”\n\n");
            outputText("Okay, when worded like that, the bracelet does sound really cool. Still, the problem remains, how would you contain a creature capable of warping anywhere they wish?");
            outputText("Nolan pats around the surface of his suit until he finds something. He reaches into the suit’s inner pockets and pulls out a small box. It looks like the kind of box one would use to hold sewing equipment.\n\n");
            outputText("“Relax, I have it all figured out. This should have everything you need, a way to calm a displacer, as well as a way to bring it here hassle-free.” You take the box and open it.\n\n");
            outputText("Inside is a small needle in a tube, likely a blowdart. The tip of the needle seems to be laced with a chemical. Taking it out, you sniff it. [{if player is not a cat/cat-like race} The tip has a sweet smell but is so potent it causes your nose to sting uncomfortably. It is not too unlike the scent of mint. Carefully, you put the needle back in the box.] [{if player is a cat/cat-like race} Your mind goes a little numb, and, like... whoa. This is, wow, good shit man... maybe, just, another... Suddenly, Nolan slaps you. “Don’t do that, this is strong stuff, especially towards felines like you.” You quickly put the needle back, careful not to take another whiff.] Moving on, you find a piece of paper with a ritual circle on it.\n\n");
            outputText("You ask Nolan what it is. “That is how you’ll transfer the displacer to me. Once it is neutralized, simply place this sticker on its head, and the rest will take care of itself.”\n\n");
            outputText("You put everything back as it is. “I trust this will be of no issue to you, correct?” You nod in response. You tell Nolan that this shouldn’t take too long, and that an oversized cat won’t cause you any problems.\n\n");
            outputText("Nolan chuckles a bit. “I hope you have the skills to back that confidence. Now go, I have other things to do.” He returns to his work, and you leave. Time to go on a cat hut.\n\n");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            NolanQuest2State = 1;
            doNext(FoodHall);
        } else if (NolanQuest2State == 1 && !NolanCatCaught) {
            outputText("Taking out the box, you ask Nolan if he could give you a recap of your current mission.\n\n");
            outputText("Nolan looks at you blankly, clearly annoyed, but decides to recount his instructions anyway. Sighing, he speaks, “I’ll try to make this as simple as I can this time.”\n\n");
            outputText("“I already gave you everything you need in that kit. Just find a displacer and beat it!” You’re annoyed by his condescending tone, but hey, you did bug him about an obvious mission.\n\n");
            outputText("Holding back the urge to tell him off, you reluctantly thank him and walk off\n\n");
            outputText("");
            doNext(FoodHall);
        } else if (NolanQuest2State == 1 && NolanCatCaught) {
            outputText("You approach the suit-clad demon, but something seems different. Unlike other times when he’s hard at work on his portable computer briefcase, this time he is simply slouched over at his desk, frivolously tapping the table with his fingers in an annoyingly rhythmic pattern. He seems to be disheartened, and possibly a bit angry.\n\n");
            outputText("Approaching the demon, you can hear him profanities muttering to himself. “- damn failure, fuckin piece of shit, garbage motherf -”\n\n");
            outputText("He stops once he notices that you were within earshot. Composing himself, he quickly pats the wrinkles out of his suit and takes several deep breaths to calm down.\n\n");
            outputText("“[Name], I didn’t notice you there.” He’s clearly trying to hide his anger. You decide to ignore it for now. You sit down, telling Nolan that you got the displacer as he requested, but that the creature teleported away.\n\n");
            outputText("Nolan nods. “I know, it teleported to me,” he says nonchalantly. You sigh in relief, thankful that you didn’t mess up the plan. Nolan sighs, “Well, I guess I should have told you that’s what the ritual circle did. Once it is placed on an impaired mind, it causes the host to return to the one who drew the circle.”\n\n");
            outputText("Oh good, it seems things went as planned, or at least, you thought they were. Why was Nolan cursing at himself, did something go wrong?\n\n");
            outputText("Nolan shakes his head. “No, everything went as planned. The problem is this piece of junk!” Angrily, he tosses what looks like a crystal bracelet onto the table. You reflexively flinch a bit as it clangs onto the table, expecting it to shatter. Of course, it doesn’t and instead just tumbles until it slides to a stop.\n\n");
            outputText("You look at the craft in awe, asking if this is the device Nolan had blueprinted. He meekly nods, scowling at the bracelet. You tilt your head in confusion, is something wrong?");
            outputText("“See for yourself.” Nolan grabs his cup of coffee and pours it all over the table. You back away, seeing the boiling liquid still exuding hot steam as it spreads, but soon, it begins to condense.\n\n");
            outputText("You watch in awe as the bracelet absorbs the coffee like an infinitely dry sponge. Pretty soon, the table is just as dry as it was when you first got here. You sit slack-jawed, amazed by what you saw. This is amazing isn’t it, so why is Nolan so upset?\n\n");
            outputText("Nolan scoffs, clearly peeved by the result. “Cause that’s all it can fucking do. LIQUIDS! That’s all this piece of shit can contain!” He slams his fist into the table, causing it to shake. “What kind of gun is gonna benefit from this huh, a super soaker!?”\n\n");
            outputText("Ah, so that’s the problem. You suppose you can understand his frustrations. All that work, only to fail at the last step. You tell Nolan that you can understand why he’d be so frustrated, but this is still impressive nonetheless.\n\n");
            outputText("Eyeing the crystal bracelet, you ask what Nolan is going to do with it now. “I don’t know. It’s garbage as far as I’m concerned. I’ll just have to go back to the drawing board and retry from the very beginning. At least now I know all the components thanks to that displacer.”\n\n");
            outputText("If Nolan’s going to get rid of the bracelet anyway, so would it be okay if you kept it? He did say it was garbage after all, and as the old adage goes, one man’s trash is another man’s treasure.\n\n");
            outputText("Nolan looks at you blankly. “You know that super soaker comment was a joke right?” You nod, saying that doesn’t matter to you. You’re sure you’ll be able to find some use for this. With that, Nolan smirks.\n\n");
            outputText("“Alright then, have it your way. If you’re going to insist that this is, in some way, a treasure, then consider it your payment.” Wait what, that wasn’t what you meant! Nolan chuckles to himself. “Too bad, next time choose your words more carefully.”\n\n");
            outputText("Deciding it’d be best not to push further, you quietly take the bracelet. You think for a moment about what you can use it for. Maybe you can drain a lake with it, or counter floods, or maybe, Nolan’s comment on super soakers wasn’t as much of a joke as he thought it’d be?\n\n");
            outputText("Either way, you quickly pocket it. You turn back to Nolan. “Now that that’s over with, anything else we need to discuss?”\n\n");
            NolanQuest2State = 2;
            //give player the CLS bracelet
            doNext(FoodHall);
        }

    }

    private function Nolan3Quest():void {
        if (NolanQuest1State == 1 || NolanQuest3State == 1 || NolanQuest4State == 1 || NolanQuest5State == 1 || NolanQuest6State == 1 || NolanQuest7State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest3State == 0) {
            outputText("You pull out a small piece of paper. Unlike the rest of the folder's contents, diagrams, calculations, and other things you don't really get, this one is just a small index card folded in half. You open the card, and you read the note inside.\n");
            outputText("\n" +
                    "Reminder:\n" +
                    "deliver Lumi’s blueprints\n" +
                    "due in:\n" +
                    "3 days\n" +
                    "\n");
            outputText("This strikes you as odd. You'd never thought that Nolan would have connections, or hell, even know the goblin alchemist. The card is fairly old, wrinkly, and flaking, so it was likely written a while ago. You ask Nolan about his relationship with her.\n" +
                    "\n" +
                    "“Who, Lumi? Why would you ask about-” Suddenly he stops. His eyes go wide with a sudden realization. “SHIT!”\n\n");
            outputText("Nolan's sudden shouting was loud enough to be heard by everyone in the room. Many demons freeze and turn to look at the two of you, some in shock, and most in panic. Realizing how much attention he just attracted, he facepalms in a moment of self-loathing and disappointment.\n\n");
            outputText("You quickly stand, waving everyone off, telling them nothing's wrong. This calms most of the demons, who try to go back to whatever they were doing, but you can tell many are still a bit uneasy. Ignoring them, you turn back to Nolan.\n\n");
            outputText("You see Nolan digging through his briefcase, pulling out folders, and scattering papers everywhere. You can hear him whispering to himself, “Fuck, fuck, fuck, fuck...”\n\n");
            outputText("Finally, he pulls out a fairly large folder. It's far more wrinkled and is covered in pencil eraser marks and smudges of ink from rubbing against so many other papers. It's clearly older than the others.\n\n");
            outputText("After quickly flipping through the folder to check its contents, Nolan hands it off to you. “Sorry for my outburst, but I have royally fucked up.'' You can see that he is breathing heavily, gritting his teeth.\n\n");
            outputText("You try to calm him down, asking what this is, and what does Lumi have to do with it? “It’s not her fault alright, it's mine. I was supposed to deliver this to her over a year ago!”\n\n");
            outputText("Ah, so that's what this is about.\n\n");
            outputText("“Look, just, give this to her. She paid good money for it, so if she ends up a little upset from the atrociously late delivery, tell her that I'm more than willing to compensate.” With that, Nolan waves you off.\n\n");
            outputText("Walking away with the folder, you flip through it yourself. Diagrams and blueprints for what looks to be a giant machine fills the pages. It's impressive, to say the least, even if you don’t understand any of it.\n\n");
            outputText("You turn back, intending to ask what this is, but Nolan seems too busy cursing at himself as he cleans up his mess. “Stupid, stupid, fucking idiot you, how could you forget, god damn it, fuck!”\n\n");
            outputText("You quietly walk away while Nolan continues to degrade himself.\n\n");
            outputText("");
            NolanQuest3State = 1;
            doNext(FoodHall);
        } else if (NolanQuest3State == 1 && !NolanLumiTalked) {
            outputText("With the index card in hand, you ask Nolan what it was you were supposed to do again.\n\n");
            outputText("“Seriously,” he asks, a little annoyed, “This is the simplest task I could have given you, how do you just forget!”\n\n");
            outputText("You hold your hands up in a surrender pose, stating that things happen, and sometimes you forget even the simplest of things.\n\n");
            outputText("Nolan sighs in annoyance. “Just give that goblin Lumi the folder I gave you. You know, the one with the blueprints, remember?”\n\n");
            outputText("Not wanting to annoy Nolan any more than you already have, you quickly thank him for the reminder and leave.\n\n");
            outputText("");
            doNext(FoodHall);
        } else if (NolanQuest3State == 1 && NolanLumiTalked) {
            outputText("You decide to give Nolan the good news. You toss the small folded index card back to him, telling him that the package has been delivered.\n\n");
            outputText("Nolan sighs in relief. “Oh thank fuck. What did she say? Is she mad about the late delivery?” Nolan has clearly relaxed a bit, but he is definitely still anxious.\n\n");
            outputText("You tell Nolan to calm himself. You inform him that Lumi was actually pretty happy to finally get the blueprints. She also didn’t ask for any compensation because even she had forgotten about the commission.\n\n");
            outputText("Nolan just looks at you with a small hint of disbelief. He shakes his head and lets out a long sigh. “Of course she did, how convenient. What else should I have expected from a goblin as ditzy her.” Quickly reorienting himself, he smiles, “At least I won’t have to worry about it anymore, thank you.”\n\n");
            outputText("Nolan reaches into one of his many inner suit pockets. A pulls out a small bag. It jingles as he drops it onto the small table, pushing it your way.\n\n");
            outputText("“Consider this the shipping cost, and also your reward for completing the task, though, if I had to guess, the real reward for you here is the machine Lumi’s about to build using those blueprints.”\n\n");
            outputText("Curious, you ask what the machine is. Nolan looks uncomfortable, but answers regardless. “Personally, I care not for such vulgar devices, but it’s meant to be a machine that allows better control over altering the size of your... well.”\n\n");
            outputText("He uses his eyes to direct your attention to your crotch. At first confused, you realize what he is saying. Would that machine allow you to control the size of your genitals?\n\n");
            outputText("Nolan waves his hand at you. “Yes, yes alright. I don’t like talking about it, I’m starting to realize why I forgot about that damn delivery. The only reason I agreed to design it was because Lumi paid double the normal rate, so I couldn’t say no.”\n\n");
            outputText("Clearly uncomfortable, Nolan waves you off. “Just take the gems, please. If you want to know how it works, ask the goblin who bought the damn thing.”\n\n");
            outputText("You decide to stop tormenting the demon. Quickly, you pocket the gems and thank Nolan.\n\n");
            outputText("“So, is there anything else?”\n\n");
            outputText("");
            //Give Player 1500 Gems
            NolanQuest3State = 2;
            doNext(NolanTalk);
        }
    }

    private function Nolan4Quest():void {
        if (NolanQuest2State == 1 || NolanQuest3State == 1 || NolanQuest1State == 1 || NolanQuest5State == 1 || NolanQuest6State == 1 || NolanQuest7State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest4State == 0) {
            outputText("Flipping through the pages, you find one that catches your eye. Inside is a folder with papers stapled together, and as you skim the papers, you realize that each one pertains to a specific weapon or object, and beside each diagram are various arcane symbols and rites. Curious, you decide to ask Nolan about the collection of papers.\n\n");
            outputText("Nolan lazily glances at the papers before him. “Oh, I remember those. They were from back when I was doing research on enchanted weapons” Enchanted weapons? Interested, you decide to press on the topic.\n\n");
            outputText("“Simply put, I was doing research on enchanted weapons and objects. You know how you might find odd items from time to time with magical properties not intrinsic to the weapon itself?” You are reminded of a few items you’ve picked up from random fights. Nolan nods, “I wish to disassemble the magic making it possible, and create a more controlled version of enchantment.”\n\n");
            outputText("A controlled method of enchantment? Confused, you ask for more details. “As of now, enchanters are extraordinarily rare. It’s a skill few are capable of, and even fewer actively pursue. Because of this, when enchanting, everything is up to chance. There’s no way to control the effects the object gains, or how many effects enchantment will result in. My goal is to at least make enchanting somewhat easier by finally breaking the art down to a science.”\n\n");
            outputText("Intrigued, you ask if you will be able to enchant your weapons if he succeeds. Nolan nods, “I have a trusted associate currently working under Jabba the merchant in this very domain. Once I break down the art of enchanting, I will be selling him the trademark, and Wanda will handle the rest.”\n\n");
            outputText("Exited by the prospect of making your equipment even stronger, you ask what you need to do. “I need you to collect some items for me. Enchanted items. Specifically, I need to study each enchanted category. Cursed, stat modification, and transformative enchantments.”\n\n");
            outputText("You go wide eyed, isn’t that a bit much for you to handle? Nolan rolls his eyes dismissively. “I need the enchantments themselves, it doesn’t matter what the items are. If 2 types of enchantments are on a single item, then that’s even better.”\n\n");
            outputText("You gulp nervously. This may prove to be your most difficult fetch quest. Nevertheless, the idea of being able to enchant your weapons to become even stronger is too enticing. You gladly accept this challenge.\n\n");
            outputText("Nolan waves you off. “You better not disappoint. I already promised Jabba I’d give him the trademark.” Wow, thanks a lot Nolan. Totally not putting pressure on you. You quickly walk out, getting ready to scavenge as many magical weapons as you can.\n\n");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            NolanQuest4State = 1;
            doNext(FoodHall);
        } else if (NolanQuest4State == 1 ) {
            doNext(FoodHall); //Function for handing in items
        } else if (NolanQuest4State == 1 ) {
            doNext(FoodHall); //Function for handing in items
        }
    }

    private function Nolan5Quest():void {
        if (NolanQuest2State == 1 || NolanQuest3State == 1 || NolanQuest4State == 1 || NolanQuest1State == 1 || NolanQuest6State == 1 || NolanQuest7State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest5State == 0) {
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
        }
    }

    private function Nolan6Quest():void {
        if (NolanQuest2State == 1 || NolanQuest3State == 1 || NolanQuest4State == 1 || NolanQuest5State == 1 || NolanQuest1State == 1 || NolanQuest7State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest6State == 0) {
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
        }
    }

    private function Nolan7Quest():void {
        if (NolanQuest2State == 1 || NolanQuest3State == 1 || NolanQuest4State == 1 || NolanQuest5State == 1 || NolanQuest6State == 1 || NolanQuest1State == 1) {
            outputText("You open the folder again, flipping through it. Before you can pull out another assignment, Nolan stops you.\n\n");
            outputText("Nolan sighs, “Look [Name], I get that you’re trying to help and all, but the whole point of this agreement is to prevent me, and by proxy you, from leaving existing projects unfinished.”\n\n");
            outputText("He looks at the folder and signals you to close it. “You can start another task once you finish your current one. If you’re stuck on what to do, just ask.”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest1State == 2 || NolanQuest2State == 2 || NolanQuest3State == 2 || NolanQuest4State == 2 || NolanQuest5State == 2 || NolanQuest6State == 2 || NolanQuest7State == 2) {
            outputText("You ask Nolan if there’s anything else to do. The folder he gave you is now empty, but surely there’s more work, right?");
            outputText("Nolan chuckles a bit. “As much as I appreciate you helping me with my little pet projects, I’ll have to decline further assistance.”\n\n");
            outputText("You slump as you hear this, saddened by his rejection. Nolan quickly retorts, “It’s not that I don’t trust you, quite the opposite. It’s just that I’m all caught up for once. Unless you want to help me analyze data, solve complex quadratic calculations, or run several diagnostic simulations...”\n\n");
            outputText("You stop Nolan. You get it, the only things left to do are things you aren’t qualified for. Regardless, you thank Nolan for even allowing you to help.\n\n");
            outputText("“No, no. The pleasure was all mine. It’s nice to talk to another person of sane mind for once.”\n\n");
            outputText("After a moment of silence, he continues, “Anything else you want?”\n\n");
            doNext(NolanTalk);
        } else if (NolanQuest7State == 0) {
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
            outputText("");
        }
    }

    private function NolanTakeOverTalk():void {
        clearOutput();
        outputText("You sit down in front of Nolan, a serious look on your face. Seeing your seriousness, Nolan tilts his head, closing his laptop and giving you his full attention. \n\n" +
                "\n" + "“Something is giving you pause.” He says simply. “Considering that I’m ahead of my tasks, I have time. What seems to be the issue?” \n\n");
        outputText("You tell Nolan that Ceraph’s the problem. She’s been getting…ideas. Ideas that she’s the one in charge. You tell the Nullcubus that she’s becoming more of a headache than an asset, and that you’re looking for her replacement, since you have other, more important tasks than managing a strip club. \n" +
                "\n" +
                "“...and you know that I have an intimate understanding of this place, as well as the organizational mind required for the task.” Nolan puts a hand on his chin. “I suppose it also is a point in my favor that I’m not sex-crazed, like everyone else here.” ");
        outputText("You nod. Of course Nolan would understand immediately why you’d think of him.\n\n");
        outputText("“I could do it…But there’s several problems. The first is that I don’t entirely want to be bothered with the daily operations. Too much annoyance.” Nolan thinks. “Although I could just have Jabba do it. He’d jump at the opportunity to run this place, and with minimal effort on my part, I’m sure I can find several ways to improve the efficiency of this establishment.” He nods, but before you can say anything, he continues. \n\n");
        outputText("“The second is the nature of this location, namely the labs: Both the subjects and data from it.” He looks directly at you. “I want what remains. My work so far has been unimpeded by the lack of supporting material, but I want to use what was done here.” He shrugs. “This, I’m afraid, is non-negotiable. Consider it my…Salary. Give me access, and I’ll happily manage this establishment for you…and make sure that Ceraph gets what she has coming to her.” He frowns slightly. “I can think of a fitting…fate. I’ll just need some time. When you’re ready to throw her down, she’ll need to be subdued. I’ll be waiting.\n\n ");
        NolanState = 4;
        doNext(FoodHall);
    }


    //-----------------Ceraph Scenes and Functions-----------------

    public function CeraphHumiliate():void {
        outputText("Ceraph’s insinuation, using you to further her own ambition? That cannot stand. You smile darkly, making the demons closest to you back away. You take the stage, and as Ceraph steps down to join you, smugly glaring down at a few of the demons, you step in close. One of the Incubi catches your eye. A smaller specimen, but the anger in his eyes is genuine. He stares at Ceraph openly, then glares at you, so close. A wicked idea pops into your head, and you give the incubus a wink.\n\n");
        outputText(" Right before you grab Ceraph by the neck, sweeping her legs out from beneath her and slamming the Omnibus into the stage floor. Shocked, Ceraph coughs and begins to struggle, but you’ve beaten her so many times already. She knows she’d lose.\n\n");
        outputText("You glare down at Ceraph. Apparently, she’s forgotten who’s in charge here. Raising your voice, you tell the assembled demons that Ceraph attacked you several times in the mountains, trying to add you to her harem…And that despite her best attempts, Ceraph herself ended up bound to you, not the other way around. On the ground beneath you, Ceraph’s eyes widen in sudden fear. \n\n");
        outputText(" You grab Ceraph’s dress at the thigh slits, ripping it up and off the wannabe demon queen. Ceraph starts to scream, but she cuts it off, whimpering slightly as you stand her back up, more exposed than the skimpiest of her dancers. The party’s stopped entirely, and raising your voice, you call everyone’s attention to the front stage. \n\n");
        outputText("You tell all the assembled demons that Ceraph put herself above them, sitting on her throne like a demon queen…And that you’re here to set the record straight. Ceraph is one of them. \n\n");
        outputText("You order Ceraph to dance. To work the pole like the whore she is. She begins to dance, shakily, and you shake your head, stepping in and slapping her ass with all your strength, making the Omnibus’s cheeks shake violently. She turns to face you, fire in her eyes, but you grab her arms, forcing them behind her back and shoving her into the pole, cold steel between her naked breasts. Snarling, you tell her to try again. \n\n");
        outputText(" Ceraph forces a sultry smile onto her face, beginning to dance again. She’s clearly experienced, but you shake your head as her pussy leaks slimy pre onto the stage. \n\n");
        outputText("Grabbing her by the arm, you call her useless. You tell her, in front of all the demons, that if she’s going to get herself off, she might as well put that leaky faucet of hers to use. You call for rope and a chair. Ceraph tries to pull away, but you keep a firm hold on her. Most of the demons below are frozen, but the one incubus you saw glaring earlier is all too eager to follow your lead. Grabbing a chair from the back, he tosses the chair onto the stage. You thank him, and tell him to grab a rope. He scampers off, grinning, and Ceraph gasps in horror. \n\n");
        outputText("“Please.” She leans over, whispering in your ear. “Not him. Anyone but him.” You look at her, saying nothing, and her eyes widen. “[Master], please. Don’t make me fuck him. I’ll do anything”. \n\n");
        outputText("You raise your voice, telling Ceraph that if she wants something from you, she can say it out loud, slapping her ass for good measure. Ceraph blushes bright red, sighing before sinking to her knees in front of you. \n\n");
        outputText("“[Master]…Please, if you must humiliate me…Don’t let that incubus sully my pussy. I’m sure it would please you more…to do it yourself.” She smiles at you, her nervousness clearly showing on her face. As she does so, the scrawny incubus strides onto the stage, rope in hand. He leers at Ceraph, his demonic cock only 6’ long, but he’s muscular and tan, clearly an outdoorsman. \n\n");
        outputText("He tosses you the rope, and you bind Ceraph’s hands together, as tight as you can make it. The demon horde below are silent, waiting for your next move, and the incubus licks his lips in anticipation. \n\n");
        outputText("Ceraph turns her head to look at you, eyes pleading. Her legs are shaking, her cock twitching, but she clearly has some history with this scrawny incubus that’s overruling her arousal.\n\n");
        outputText("");

        menu();
        addButton(0, "Dismiss", DismissTheIncubus);
        addButton(1, "ComeonUp", JointhePartyBro);
    }

    public function DismissTheIncubus():void {
        clearOutput();
        outputText("You tell the Incubus that his help was welcome…But that Ceraph is part of your harem, and that you intend on humiliating her yourself. He looks angry, but you give him a dark smile. You tell him that bad demons get punished in the Dom’s domain…and that Ceraph isn’t the only one who gets spanked for acting out. \n\n");
        outputText("He blanches at that, eyes wide, ignoring the jeers and catcalls as he quickly leaves the stage \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton (1, "GangBang", CeraphGangBang);
        addButton (2, "PublicUse", CeraphCumDumpster);
        addButton (3, "SitonHer", CeraphPussChoke);
    }

    private function CeraphPussChoke():void {

    }

    private function CeraphCumDumpster():void {

    }
    public function JointhePartyBro():void {
        clearOutput();
        outputText("You mockingly wipe a tear from Ceraph’s eye. “Oh, don’t worry, pet.” You soothe, loud enough for everyone to hear. “Your "+ player.mf("master", "mistress") +" will be the one to administer the punishment.” The crowd cheers, but you give the Incubus a wink, and he doesn’t leave the stage. Ceraph seems almost relieved, despite the humiliation. How do you want to punish Ceraph? \n\n");
        menu();
        addButton (1, "Dickwich", CeraphDickwich);
        addButton (2, "DP_StrpOn", CeraphIncDPen);
        addButton (3, "GangBang", CeraphGangBang);
    }

    private function CeraphBow():void {
        outputText("You take the stage, and Ceraph, curious, descends from her Dais to join you. You bow theatrically before the demon throng, and raising your voice, you tell them to enjoy this place. That Ceraph seems to have done a good job so far…and you raise a hand, telling them to party harder than Mareth’s ever seen!\n\n");
        outputText("This gets a roar of enthusiasm from the horde below you. Ceraph takes your arm, and you lead her into the back room, where you know the place’s control panel is. \n\n");
        outputText("");
        doNext(CeraphBackroomChat);
    }

    private function CeraphAcknowledge():void {
        outputText("You give Ceraph a nod. You know she’s using you, but you don’t really care. The horde around you backs up a little, giving you a clear berth. She gives you a wicked little smile, raising a glass. \n\n");
        outputText("“Your meals are free, Champion. Enjoy the Dom’s domain!” She points towards the back room, giving you a wink and a twirl of her dress. You decide to follow her into the back. \n\n");
        doNext(CeraphBackroomChat);
    }

    private function CeraphTellOff():void {
        outputText("Is she fucking serious? Oh hell no, this will not stand. Angrily, you stomp towards the stage, pushing aside any demons in your way. When you finally reach the stage, you approach Ceraph, rage emanating from your eyes. It seems she’s only now realized that she has angered you. “Uh, [Master] [Name]? Is somethi-”\n\n");
        outputText("Enough talk. You cut her off, grabbing her by the throat, silencing her with little effort. She struggles, dropping the small device in her hand, causing a loud ringing sound to echo painfully throughout the hall.\n\n");
        //if player doesn't have pierced token
        outputText("You angrily demand Ceraph to explain what the hell she thinks she is doing. The audience is in shock. For them to see their boss being treated like this by who they thought was one of Ceraph’s lackeys must be world-shattering. She tries to answer your query, but all that comes out is pained gargling.\n\n");
        outputText("Tightening your grip, you emphasize that YOU are the one in charge here, not her. You didn’t give this place to her because you were being generous. You make it clear that what you did was no different to a person giving away their trash.\n\n");
        outputText("This place is a waste of space, a fortress made to serve your enemies, and after you conquered this place, it lost all purpose. The only reason this place isn’t rotting away is that Ceraph, your loyal pet, just so happens to see it decide that this would make a great whore house. You didn’t agree because you wanted this place to be made anew. Ceraph taking in this place was no different from a dog licking the scraps of their master’s leftovers.\n\n");
        outputText("You toss Ceraph into the crowd, knocking over a few demons with her now fairly limp body. She struggles to breathe for a moment before finally speaking. “[Master] [Name]! I swear, I didn’t mean to-”\n\n");
        outputText("You yell at Ceraph to shut her fucking mouth. She and many other demons freeze in terror. You make it clear that if she ever tries to pull this shit again, tries to make you look like her servant, she will regret it for the rest of her very short life. She couldn’t beat you before, and you are far stronger now, so it’s no question who’s the one in charge, and who’s the washed-up waste of space.\n\n");
        outputText("You step off the stage. You look down at your Omnibus slave, seeing her shiver in fear as other demons turn away, too scared to even look at either of you. Before you leave, you tell Ceraph that she looked like shit, and to go clean herself up. Panicked and hyperventilating, she quickly runs out of the room, covering her face as tears form in her eyes.\n\n");
        //if you do have it pierced
        outputText("Wait, isn’t this going a bit too far? You see Ceraph’s strained face, and a wave of regret suddenly drowns your anger. You blink a few times, take some deep breaths, and set Ceraph down gently.\n\n");
        outputText(" Ceraph wobbles a bit, clearly off balance. Luckily for her, you catch her before she could fall off the stage. “I-I, what are...?” You shush Ceraph, telling her that you overreacted. You pat her down, and back away a bit. You may have been a bit harsh, but still, you need to make her understand her mistake.\n\n");
        outputText("You whisper to her so that the audience doesn’t hear you two, telling her that she can’t be doing this. She was the one who made it clear who was the master and who was the slave.\n\n");
        outputText("You’ll forgive her this one time, after all, this was basically a performance, so it doesn’t matter that much anyway. Besides, you’re not one to hold a grudge, but still, she needs to be more careful in the future. Ceraph nods, “Right, sorry [Master] [Name]. I just went a bit overboard. It won’t happen again, promise.”\n\n");
        outputText("Satisfied, you give Ceraph a few friendly pats on the back. You turn and apologize to everyone for the disturbance before stepping off the stage.\n\n");
        outputText("Strange. Something feels off. Were you really yourself back there? Maybe Ceraph did something to you? Nah, couldn’t be, right? You trust her, don’t you? Hmm, you’ll need to ask her about this later.\n\n");
        outputText("To your surprise, Ceraph also steps off the stage. She motions for you to follow her into the back, and you see no reason to ignore her.\n\n");

        doNext(CeraphBackroomChat);
    }

    private function CeraphBackroomChat():void {
        outputText("“Well…Do you like what I’ve done to the place?” Ceraph asks, the moment you enter.  \n\n");
        outputText("“Oi, it’s too loud, shut the fucking door!” comes a woman’s voice from inside the room. As you enter, closing the door behind you, you see a goblin woman, significantly larger than her forest-bound brethren, sitting on a wide-backed chair, made of shiny black leather. In her hands, she holds a small black device, and her nimble fingers move, green blurs. The odd device from before has been modified…and upgraded. Several screens cover the wall, and the goblin woman stares at one in the very center. You recognize the image on the screen as a gun, and as the goblin’s fingers move, the image changes. Several half-naked women pop up on the screen, and the virtual gun moves, shooting them in rapid succession. Their clothing flies off, and horny moans fill the air. Ceraph rolls her eyes, scowling slightly as she closes the door. \n\n");
        outputText("“That’s better.” The goblin says, somehow still not noticing you, or Ceraph. That is, until Ceraph motions with one finger, and the chair vibrates violently, nearly throwing the goblin from it.  \n\n");
        outputText("“O-oh shit!” She stammers, pressing a few buttons. The middle screen turns back to a view of Ceraph’s throne, and she turns, tossing the controller to one side. “M-mistress Ceraph! I didn’t see you there!” As the goblin shoots to her feet, you notice the slick ebony dildo, stuck to the chair, that she’d been sitting on.  \n\n");
        outputText("“Clearly not.” Ceraph says, disapprovingly. The goblin drops to her knees, shuddering as Ceraph walks towards her. “Here I was hoping to introduce you properly, but I suppose you’ll need to introduce yourself on your way to the slutlocker.” She turns to you. “[Master], this Akaassa. She’s our resident tech-head. Most goblins are brainless sluts…and I thought she was different.”  \n\n");
        outputText("“Mistress, I was still watching the screens, as you told me to!” Akaassa protests, her chest shuddering with fear. “You didn’t say I couldn’t also enjoy myself!”  \n\n");
        outputText("Ceraph grimaces at that. “The center screen is for my throne. Not your toys.” She snaps her fingers, and two incubi walk in. The goblin looks at you, fear in her eyes…along with no small amount of arousal as she looks at the two demons. One picks her up, and she gives you a grin and a wave. “Bye~”  \n\n");
        outputText("Ceraph sighs, giving you an unamused half-smile. “If she wasn’t so useful, I’d have given her to Meila.” She shakes her head. “Anyways, that’s the domain. Your cut of the profits, when we bring them in, will be in here, so nobody else can take them.”  \n\n");
        outputText("Ceraph gives you a nod, returning to the throne. \n\n");
        menu();
        addButton (1, "Next", StripClub);
        AkaassaState = 1;
    }

    public function CeraphDickwich():void {
        clearOutput();
        outputText("Forcing Ceraph to her knees, you tell her to stay down, disrobing and revealing your [cock] (if Pussy) and [Pussy] to the horde. Giving yourself a few, dramatic pumps, you do a slow, predatory walk around Ceraph, who looks up at you, mouth firmly shut. Going behind her, you grab her arms, pulling her back to her feet. She pulls slightly, but you tut, reaching down and slapping the inside of her knees.  \n\n");
        outputText("You order her to spread her legs, and she does so reluctantly, giving the assembled crowd a glare as they leer, whistle and jeer, some openly stroking themselves already. Ceraph’s spine stiffens as you slide your [cock] between her legs, getting some lubricant on your shaft, before aligning your tip with her puckered asshole. Ceraph shudders as your crown slides aside her sphincter.  \n\n");
        outputText("You grab her waist with one hand, and as she covers her drooling lips with her spade-like tail, you grab her tail, pulling roughly. The horde cheers as you bottom out, forcing Ceraph’s hips forward. You walk Ceraph forward, to the edge of the stage, and she closes her eyes. You let go of her waist, thrusting deep into her ass, letting the demons in the front catch the drops of Ceraph’s juices. Reaching around and grabbing the demoness’s considerable jugs, you slowly, steadily walk her back, pulling her tail if she doesn’t follow you perfectly.  \n\n");
        outputText("“O-okay…That’s enough.” Ceraph whispers. “Please…You’ve let everyone know that you own me…Now please, just finish.” You tut, loudly telling Ceraph that if she wants something from her [master], then she should speak louder. To emphasize your point, you pull on her tail, thrusting at the same time. You bury yourself into her overly warm ass, tweaking her breast with one hand.  \n\n");
        outputText("Ceraph opens her mouth to speak, but you move as she does, tweaking her clit and making her request turn into a moan. Telling her to speak up, you thrust again. “M-m-[master], p-please…That’s e-enoUGH.” Ceraph shudders as you thrust again, raising her voice so that everyone can hear. “E-everyone here knows that I’m yours.”  \n\n");
        outputText("“N-no!” The bitch has the audacity to lie? “I-I just meant t-that-” You tell Ceraph to shut up. That she lied to all the good people here…And that you know what punishment fits. You sit back into the provided chair, pulling your pliant little toy down on top of you, your throbbing [cock] still in her ass. The chair has wooden handrests on either side, and you gently, firmly spread Ceraph’s legs, putting her thighs on the handrests. \n\n");
        outputText("Ceraph looks out on the horde, anger and humiliation on her face…Until you speak again, from underneath her. You ask for the demon who provided such a lovely seat for you, to join you onstage. This gets an immediate response from Ceraph, who wriggles, trying to get up…But you grab her thighs, pinning them to the armrests. You ask the incubus to introduce himself to the crowd, and he turns to them. \n\n");
        outputText("“The name’s Derial”, he says simply. “And once upon a time, I was like you, worshipping the ground this cunt slimes on.” He growls, spitting on the stage floor. “She’s a picky one, Ceraph. Got all her little tricks and kinks all lined up in a row. She took one look at me and told me I would never get my little dick near her…That she wouldn’t even feel if I did.” He grins down at her. “So…Ceraph…” He lines himself up with her sopping twat, rubbing his shaft along her lips. “You feeling it yet?” \n\n");
        outputText("“N-no.” She says defiantly. “All I can feel is my [master] inside me.” You pull yourself almost all the way out, as the incubus grins lecherously. Ceraph grunts, wriggling on top of you, her ass contracting as the incubus sinks himself to the hilt in a single thrust. You can feel his cock pushing Ceraph’s insides back against yours. \n\n");
        outputText("“Oh, Ceraph…I knew you’d be moaning for me…But I didn’t think I’d have such an audience.” He brings a hand to her cheek, a mocking imitation of a lover’s touch.  \n\n");
        outputText("You feel Ceraph struggle, but he bears down, picking up the pace. Ceraph squirms on top of you, and you can feel Derial’s demonic cock through Ceraph’s walls. \n\n");
        outputText(" \n\n");
        menu();
        addButton (1, "Next", StripClub);
    }
    public function CeraphIncDPen():void {
        clearOutput();
        outputText("Forcing Ceraph to her knees, you tell her to stay down, disrobing and revealing your [cock] (if Pussy) and [Pussy] to the horde. Giving yourself a few, dramatic pumps, you do a slow, predatory walk around Ceraph, who looks up at you, mouth firmly shut. Going behind her, you grab her arms, pulling her back to her feet. She pulls slightly, but you tut, reaching down and slapping the inside of her knees.  \n\n");
        outputText("You order her to spread her legs, and she does so reluctantly, giving the assembled crowd a glare as they leer, whistle and jeer, some openly stroking themselves already. Ceraph’s spine stiffens as you slide your [cock] between her legs, getting some lubricant on your shaft, before aligning your tip with her puckered asshole. Ceraph shudders as your crown slides aside her sphincter.  \n\n");
        outputText("You grab her waist with one hand, and as she covers her drooling lips with her spade-like tail, you grab her tail, pulling roughly. The horde cheers as you bottom out, forcing Ceraph’s hips forward. You walk Ceraph forward, to the edge of the stage, and she closes her eyes. You let go of her waist, thrusting deep into her ass, letting the demons in the front catch the drops of Ceraph’s juices. Reaching around and grabbing the demoness’s considerable jugs, you slowly, steadily walk her back, pulling her tail if she doesn’t follow you perfectly.  \n\n");
        outputText("“O-okay…That’s enough.” Ceraph whispers. “Please…You’ve let everyone know that you own me…Now please, just finish.” You tut, loudly telling Ceraph that if she wants something from her [master], then she should speak louder. To emphasize your point, you pull on her tail, thrusting at the same time. You bury yourself into her overly warm ass, tweaking her breast with one hand.  \n\n");
        outputText("Ceraph opens her mouth to speak, but you move as she does, tweaking her clit and making her request turn into a moan. Telling her to speak up, you thrust again.  \n\n");
        outputText("“M-m-[master], p-please…That’s e-enoUGH.” Ceraph shudders as you thrust again, raising her voice so that everyone can hear. “E-everyone here knows that I’m yours.”  \n\n");
        outputText("You tell Ceraph that she’s right. Which shocks her, and for a moment, she stops struggling. You tell Ceraph that everyone does know who’s in charge…But…She tried to make everyone here think that you were some kind of enforcer for her. \n\n");
        outputText("“N-no!” The bitch has the audacity to lie? “I-I just meant t-that-” You tell Ceraph to shut up. That she lied to all the good people here…And that you know what punishment fits. You sit back into the provided chair, pulling your pliant little toy down on top of you, your throbbing [cock] still in her ass. The chair has wooden handrests on either side, and you gently, firmly spread Ceraph’s legs, putting her thighs on the handrests.  \n\n");
        outputText("Ceraph looks out on the horde, anger and humiliation on her face…Until you speak again, from underneath her. You ask for the demon who provided such a lovely seat for you, to join you onstage. This gets an immediate response from Ceraph, who wriggles, trying to get up…But you grab her thighs, pinning them to the armrests. You ask the incubus to introduce himself to the crowd, and he turns to them. \n\n");
        outputText("“The name’s Derial”, he says simply. “And once upon a time, I was like you, worshiping the ground this cunt drools on.” He growls, spitting on the stage floor. “She’s a picky one, Ceraph. Got all her little tricks and kinks all lined up in a row. She took one look at me and told me I would never get my little dick near her…That she wouldn’t even feel if I did.” He grins down at her. “So…Ceraph…” He lines himself up with her sopping twat, rubbing his shaft along her lips. “You feeling it yet?”  \n\n");
        outputText("“N-no.” She says defiantly. “All I can feel is my [master] inside me.” You pull yourself almost all the way out, as the incubus grins lecherously. Ceraph grunts, wriggling on top of you, her ass contracting as the incubus sinks himself to the hilt in a single thrust. You sink yourself back in, feeling his cock pushing Ceraph’s insides back against yours.  \n\n");
        outputText("“Oh, Ceraph…I knew you’d be moaning for me…But I didn’t think I’d have such an audience.” He brings a hand to her cheek, a mocking imitation of a lover’s touch.  \n\n");
        outputText("You feel Ceraph struggle, but he bears down, picking up the pace. Ceraph squirms on top of you, and you can feel Derial’s demonic cock through Ceraph’s walls. You sink into a slow, grinding rhythm, completely at odds with the almost manic pace that the Incubus rises to.  \n\n");
        outputText("Ceraph tries to endure the double fuck, struggling, trying to pull away, but the incubus and you grab her arms and legs, keeping her sandwiched between you. Ceraph closes her eyes, gritting her teeth, but she can’t stop herself from moaning with pleasure.  \n\n");
        outputText("You feel her sphincter tighten around you, Ceraph’s hips bucking as she lets out a scream. The incubus in front of you is drenched in her femcum, and as Ceraph’s cock explodes, he grabs it and twists, spraying one of the demons below. The crowd roars as Ceraph’s cheeks burn, and she keeps her eyes closed.  \n\n");
        outputText("Only a few seconds later, the incubus gives Ceraph a wicked grin. “Oh, Ceraph…” He mocks, picking up the pace, pounding her cunt with abandon. “You don’t want my imps, do you?” Ceraph opens her eyes, suddenly scared. “No…[Master]! PleeeEEEEEEASE NO!”  \n\n");
        outputText("It’s too late. Derial grunts, and you can feel him twitch through Ceraph’s tight ass, pumping his hips and cumming deep within Ceraph’s overly warm cunt. He rides his high until the end, small squirts of off-white jizz leaking from her abused twat.  \n\n");
        outputText("“Oh, Ceraph”, he stage-whispers. “I can’t wait to see your belly grow.” He pulls out roughly, making Ceraph audibly whimper. You’re not done yet though, and you keep going, picking Ceraph up, still impaled on your rod, and dangle her over the edge of the stage. Several demons grab at her legs, her feet, but Ceraph’s eyes are glazed over.  \n\n");
        outputText("You finish inside her, dripping your and Ceraph’s mixed fluids onto the horde below, before swinging your [hips], letting her fall off your [cock] and onto the stage. You wipe your [cock] off on the insensate Ceraph’s hair, and decide to keep enjoying the domain.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton (1, "Next", StripClub);
    }
    public function CeraphGangBang():void {
        clearOutput();
        outputText("You call the Incubus back up. Ceraph’s eyes widen, and you raise your voice, mockingly reassuring her. You tell Ceraph not to worry, that the big bad incubus isn’t going to just have his way with her.  \n\n");
        outputText("She seems relieved, but only for a few moments. Your smile grows, and you raise your voice. You tell the horde that, because Ceraph decided to get cocky…She’s going to get…Cocky. You tell Derial that he’s going to get first dibs, but that up to five at a time are going to have Ceraph, until you’re satisfied. You quickly organize the bouncers, to keep the whole horde from rushing the stage, and as Ceraph looks at you in horror, you sit back on your throne, watching as Derial grabs Ceraph’s horns, forcing her to her knees in front of everyone. Ceraph cries out for you, but quickly, her voice is silenced, muffled by the slab of demon-dick slammed into her throat.  \n\n");
        outputText("For a few moments, he roughly fucks Ceraph’s throat, before pulling out to let Ceraph breathe. She coughs, tears starting to run down her cheeks, but the incubus Derial grabs her wrists. You point at two eager Incubi, and as the bouncers let them through, Ceraph struggles, managing to break Derial’s grip on her…Just as they grab hold of her. One incubus grabs her ankles, the other her wrists, and Ceraph lets out a defeated moan as Derial takes her horns again, forcing his crown past her lips again.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton (1, "Next", StripClub);
    }

    //-----------------Zetaz Scenes and Functions------------------
    private function ZetazTalk():void {
        clearOutput();
        if (ZetazState == 0) {
            outputText("Zetaz hasn’t noticed you yet, and he seems moderately happy for once, swigging a reddish fluid from a wine glass. He’s as muscular as the last time you saw him, and quite a bit bigger. He’s almost 6 feet tall, towering over all other imps, and even some demons. He’s oogling Emerald, and presses a button on his remote. Draining the last of his glass, he looks up, sizing up one of the dancers near Ceraph. His back’s to you. How do you proceed? \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            menu();
            addButton (0, "BeatHim", ZetazBeatDown);
            addButton (1, "Terrorize", ZetazScare);
            addButton (2, "Talk", ZetazLayDownLaw);
        }
        if (ZetazState == 1) {
            outputText("“What is it you want, boss? I’m on the clock right now.” He keeps his eyes on Emerald, and the various demons around the bar. “And if you need me for somethin’, then I’ll need to get someone to cover me.”  \n\n");
            outputText(" \n\n");
            outputText("Zetaz looks up from a beer, waving at you. “Hey boss! How’s it going?” He seems a little intimidated, but that really shouldn’t surprise you. “What brings you over to the ‘Domain?” He looks over at one of the other demons at the bar, tossing them a few gems. “One for the boss(man/lady)!” \n\n");
            menu();
            addButton (1, "Next", StripClub);
        }

        if (ZetazState == 2) {
            outputText("As you snap your fingers for your slave, Zetaz shudders, and for a split second, you can see fear in his eyes. He forces a smile onto his face, however, and quickly makes his way over.  \n\n");
            outputText("“Yes, [master]? What can your slave do for you today?” You notice his legs shaking slightly.  \n\n");
            outputText("He’s wearing (one of the following) \n\n");
            outputText("A small, frilly tutu with a crotchless front, and pink slippers that very clearly compress his feet.  \n\n");
            outputText("A skimpy work uniform, similar to Emerald’s. A toy in his ass buzzes frequently, making him shudder ever so slightly. His chest, unlike hers, is bare, and despite his clear musculature, he’s got bruises and bite marks. You hear a drip from behind him, and he blushes. Apparently the toy’s holding something in.  \n\n");
            outputText("Nothing but a condom and the server’s toy in his ass, with a ballooning tip half-full of cum hanging off of it. It’s clearly uncomfortable, and the brawny imp winces as a demon passes him, slapping the condom and sending the fluids inside gushing around.  \n\n");
            outputText("A bra and crotchless panties, the wire of the bra clearly visible…connected to a small battery on a belt. His chest shudders and shakes on its own.  \n\n");
            outputText("A thin layer of pantyhose, roughly shoved down over his horns, then crudely twisted together to make a strap of material that’s clearly giving him a wedgie, covering nothing and chafing his balls and ass.  \n\n");
            outputText("Two red cups, dangling from his horns, a lampshade on his head, and an odd set of flashing red and green lights, wrapped around him like a winter festival tree. Someone also attached needles of some sort to his upper body, gluing them on. His eyes are sunken, and despite his plastered on smile, he’s clearly hit the point where he’s numb to it all.  \n\n");
            menu();
            addButton (1, "Next", StripClub);
        }


        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
    }

    private function ZetazLayDownLaw():void {
        clearOutput();
        outputText("You sit down in front of Zetaz, who immediately shoots to his feet, looking for an exit. “Oh, SHIT!” You give the bulked up imp a predatory grin, telling him to calm his tits. If you’d wanted to hurt him, you’d have done so already. “...I guess so…” He sits back down, draining his glass. “So…What do you want? You wouldn’t come talk with me for no reason. Especially considering our history.”  \n\n");
        outputText("You shrug, admitting that he has a point. You’re not friends, and he did try to turn you into a fluid slave for the factory…But he failed. You remind him that every time you crossed his path, you won…and that you’ve grown much, MUCH stronger since the cave.  \n\n");
        outputText("“Since you came into my home, killed my friends, and beat the shit out of me. Yeah, I remember.” He grumbles this, and Emerald refills his glass. “What’s your point?”  You give him a menacing grin. You ask him how this place came to be free.  \n\n");
        outputText("“Well, obviously Ceraph’s stronger than everyone thought. I’m guessing you got her help clearing this place, for co-ownership.”  \n\n");
        outputText("This gets a chuckle out of you, and you shake your head. You tell Zetaz how you met Ceraph in the mountains. How she tried to trick you into becoming her fetish-bound bitch…and how you dominated her, breaking her dominance and making her your slave. You then tell him what the labs were used for…and how you crushed the scientists and their foul experiments.  \n\n");
        outputText("Stunned, Zetaz sits in silence as you then recount the tale of Ceraph’s realization. Coming to you, begging to use this space for her own.  \n\n");
        outputText("“So…You’re the power behind Ceraph’s throne.” He orders another drink. “And you’re not going to kill me, or stop me from coming?” You consider the question. After all, you’ve paid Zetaz back, a few times over at this point. \n\n");
        outputText("“...So what now?” He says, sullen. “If you’re gonna kill me, just get it over with.”  \n\n");
        menu();
        addButton (0, "Enslave", ZetazChain);
        addButton (1, "Kill", ZetazKill);
        addButton (2, "Spare", ZetazSpare);
    }

    private function ZetazScare():void {
        clearOutput();
        outputText("Taking a knife from one of the nearby tables, you stride up, behind Zetaz, and put the knife to his throat. He begins to protest, but as you align the edge with his adam’s apple, you give him a low, hissing shush. He quiets down.  \n\n");
        outputText("“Wh-what do you want?” He whispers. “Look, if this is about the gems I owe Mikey-” You almost laugh. No, this is something bigger than gems.  \n\n");
        outputText("“O-okay…I-I…” He sighs. “Look, if you’re from Her Fucking Majesty, I’m done running. Just fucking do it or don’t.” Amused, you tell him that Lethice can kiss your ass…(If you haven’t beaten her yet) And she already would be, if he’d done his fucking homework. (If you have) Again. (If you killed her) Although…You’d have to find a way to bring her back to life first.\n \n\n");
        outputText("“...Oh shit.” His red skin is pale. “[Name]?” You take the knife from his throat, and make your way to the other side of the table. As if nothing had happened, you sit. “...Um…” He seems unnerved. Good. “...Look…It was nothing personal, you know that, right?” You say nothing, just looking right at him. He continues to sweat. “Look, I…I’ll leave, okay? I won’t come back.”  \n\n");
        outputText("You shake your head, telling Zetaz that wouldn’t really help him…After all, if he doesn’t come back, you won’t get his hard-earned gems. This seems to throw him for a loop, and he stares blankly at you for what seems like a minute.  \n\n");
        outputText("“B-But…This place is run by Ceraph.” He says dumbly, before blinking a few times. You can practically hear the gears turning in his head, before he sputters. “Wait…So you…Took my map…And…Ceraph and her whores wouldn’t have stood a chance against…Oh Fuck.” His hands begin to shake. “You cleared this place out for her.” You lean back in your chair, giving the imp lord a direct, menacing smile. “...But she wouldn’t share ownership…not unless…” (If you didn’t get her totem pierced) You hold up Ceraph’s charm. (If you did) You show off your piercing, giving him a grin.  \n\n");
        outputText("“You own Ceraph”. He looks up at Ceraph’s throne, to see her directly staring back at him. “...Oh fuck.” He sees the bouncers, looking at him, in a loose circle around the restaurant. “...So what now?” He seems to deflate, any fire in his eyes long-extinguished. “Gonna finish what you started in my cave?”  \n\n");
        (Playerdominance += 5);
        menu();
        addButton (0, "Enslave", ZetazChain);
        addButton (1, "Kill", ZetazKill);
        addButton (2, "Spare", ZetazSpare);
    }

    private function ZetazBeatDown():void {
        clearOutput();
        outputText("You can’t help but smile a little as you walk up to the imp lord’s back. After all, you know what it’s like, being alone on Mareth. This little shit taught you what happens here, when your back is turned, when your defenses are lowered.  \n\n");
        outputText("And now, you’re nobody’s bitch. You cleared this place, and made it your own. You’ve put hundreds down by now, through your strength.  \n\n");
        outputText("Strength you feel like flexing.  \n\n");
        outputText("Emerald gasps, pulling back as you grab the back of Zetaz’s chair, spinning the luckless imp around. His drink spills, and for a split second, you see fire in his eyes. That fight, the first thing you saw when you walked through that portal. It reminds you of a different time…Once, you barely bested him. A far weaker imp…and a far weaker champion…No…A Sacrifice. \n\n");
        outputText("Fear flashes through his eyes, in sudden realization. He tries to get up, to run, but you grab him by the neck, slamming your fist into his jaw with a sickening crack. He falls, too dazed by your sudden blow to respond.  \n\n");
        outputText("“H-hey, stop!” He protests, but you’re already bearing down on him. “What the FU-” He tries to stand, but you’re far too fast for him, knocking the imp lord down again. You bring your fists down again and again, battering the demon into the floor. \n\n");
        outputText("The sudden commotion attracts several bouncers, but they quickly realize who you are and turn back around, not willing to mess with you. Seeing this, Zetaz calls out. “H-hey, aren’t you supposed to stop this shit?! This isn’t consensual!” \n\n");
        outputText("This puts a smile on your face. Leaning over, you ask him how it feels. Pain? Embarrassment? Humiliation, perhaps? All combined into this cold, hard lump in his throat.  \n\n");
        outputText("He growls. “You came into Ceraph’s place, just to take shit out on me? I thought you’d have better things to do.” You punch him again, and he looks at the bouncers. “What the fuck, guys! A little help here?!”  \n\n");
        outputText("You grin, telling them to keep the party going…And any friends of his off you…Assuming anyone’s dumb enough to come here and fuck with you. \n\n");
        outputText("“Wait…What?” As the bouncers turn, pushing the crowd back, he seems to get it, eyes widening. As he puts two and two together, he shakes, realization setting in.  \n\n");
        outputText("Laughing, you ask him why he’s so shocked. He pointed you here, after all. He told you where to find the place and everything…And that Ceraph might own this place…But that slut is yours.  \n\n");
        outputText("“...No.” Despite his words, he believes you. “...Y-You…” In shock, he’s unable to stop you from stepping in again, knocking aside his guard and wrenching his head back with your blow. You bring your fists down again and again, knocking out several of the imp lord’s teeth. Several demons nearby watch, a mixture of fear and arousal in their eyes, as you beat Zetaz within an inch of his life.  \n\n");
        outputText("It only takes a few moments. You break both his arms and several ribs, and by the time you’re done, his face looks like raw meat, battered and bruised. One of his eyes are swollen shut, and the other is barely focused.  \n\n");
        outputText("You stand, looming over the imp lord. Ceraph, seeing that you’re done, slips between two of her bouncers. “[Master] [Name], what seems to be the issue?” Through gritted teeth, you tell Ceraph that Zetaz was the first thing you saw upon getting to Mareth…and how you warned him about crossing paths with you before.  \n\n");
        outputText("“Oh, splendid.” She looks down at the injured imp with a glint in her eye. “Well, if you wish, we have a few options for this one.” Zetaz focuses his gaze on you, single good eye open wide, pleading. “Someone with his muscles, we can have him work around the place. I’m sure Emerald could use someone to help with her…dirtier clientele.”  \n\n");
        outputText("You take in Ceraph’s suggestions, and the ring of bouncers watch him and you, waiting for your word. What do you do with the imp lord? \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        (Playerdominance += 5);
        menu();
        addButton (0, "Enslave", ZetazChain);
        addButton (1, "Kill", ZetazKill);
        addButton (2, "Spare", ZetazSpare);

    }

    private function ZetazChain():void {
        outputText("You ask Zetaz if he fancies Emerald, the little waitress with the four arms. Emerald, hearing you, shudders, looking away…Or was that just another vibration from one of her tables?  \n\n");
        outputText("“W-well, yeah. She’s delightfully submissive. A really fun time.” Zetaz admits. “Why?”  \n\n");
        outputText("You tell Zetaz that you’re happy about that. After all…He’s going to have a ton of time to get to know her better.  \n\n");
        outputText("“So, you’re letting me go?” He breathes a sigh of relief, getting up to leave…and you stop him cold, putting a hand on his shoulder.  \n\n");
        outputText("You tut mockingly, giving him a cold smile. You didn’t say that. You just said he’d have time to get to know Emerald…After all, he’s going to be working under her, as Ceraph’s latest plaything.  \n\n");
        outputText("Horrified, Zetaz breaks from your grip, only to find himself surrounded by Ceraph’s bouncers. You sit back down, taking Zetaz’s last drink, swirling it around as he throws the first punch. It’s blocked easily by the Zebra-morph bouncer, and he counterpunches, knocking Zetaz to the floor. He attempts to jump, wings flapping, but another demon soars in, smacking him back down to the floor.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        ZetazState = 2;
        doNext(FoodHall);
    }

    private function ZetazKill():void {
        outputText("You decide to end the poor Imp Lord’s misery. Motioning to the bouncers, you make a throat-slitting motion. Zetaz doesn’t resist as the demons carry him out back. The music rises, and barely, just barely, you can hear a single gunshot.  \n\n");
        outputText("Fitting, that the true demons killed him. Just another imp. Even if he was the first creature you ever saw on Mareth, he’s worthless. Just another demonspawn to wipe out. \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        ZetazState = 3;
        doNext(FoodHall);
    }

    private function ZetazSpare():void {
        outputText("You consider it, but no. You’ve killed a lot of demons, and frankly, have every reason to kill Zetaz, but something stops you.  \n\n");
        outputText("You tell Zetaz to keep his chin up. He’s not dying today. You tell Zetaz that killing him now wouldn’t benefit you at all…And while you could just have Ceraph and her demons chain him up and make him just another bitch…You don’t really see the fun in that.  \n\n");
        outputText("No, Zetaz is free to be here, enjoy the sights, the sex…But…If he ever puts a foot out of line, gets too rough with one of the girls, gets too drunk, or makes any moves not allowed by your rules? He’ll be lucky to end up like those poor, forgotten cows in the factory. \n\n");
        outputText("This seems to strike a chord with the imp, and he sits back down. “...You shouldn’t need to worry about that. Honestly, I was going to apply to be a bouncer anyways.” He laughs. “I had no idea you owned the place though.” He orders another drink, and you nod. This muscular imp could prove useful as a bouncer, especially if he continues to grow stronger.  \n\n");
        outputText("You chuckle a little at the irony, standing back up. You tell Zetaz to finish his drink…but that you expect him to stay sober and alert on your time.  \n\n");
        outputText("“You got it, boss.” He says, with only a hint of sarcasm in his voice.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        ZetazState = 1;
        doNext(FoodHall);
    }


    //-----------------Akaassa Scenes and Functions----------------

    private function Backroom():void {
        clearOutput();
        outputText("Heading back into the old panic room, you notice the door opening automatically. You head in, and the goblin Akaassa looks up, pussy shamelessly twitching as she turns in her chair, pausing her game. \n\n");
        outputText("“What’s up, boss?” She asks simply. “Terminal to see the place is over there. Some old files are still on there if you’re interested, your cut of the profits should be in the jar over there, and if you’re not talking to me, I’m gonna get back to work.” She shifts in her chair, pressing a button on her keyboard. “Hey, we got a Johnny Rough-Job in room (one-fourteen). Break it up.”  \n\n");
        outputText("You realize, looking at her screens, that she has a complete view over the entire place, including inside the private rooms, where you can see several demons and citizens of Mareth, having every kind of sex imaginable. Akaassa, despite her lazy demeanor, seems to be in charge of monitoring all the goings-on in the place.  \n\n");
        outputText("You watch on the relevant screen as two bouncers enter the room, tearing the two apart. One bouncer grabs the larger incubus by the horns, kicking him out into the hall…Also on a screen. You and the goblin both follow as the bouncers bring him clear out of the domain, throwing his ass to the curb outside.  \n\n");
        outputText("She sees you looking, and shakes her head. She seems moderately annoyed, but sighs. “Look, I don’t need two bosses constantly on my ass, okay? I know it doesn’t look like it, but my job’s important to this place’s safe operation, and I do take it seriously…Well…Seriously enough.”\n \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Computer", AkaassaComputer);
        addButton (1, "Talk", AkaassaTalk);
        addButton (2, "Sex", GamerGirlGoblinSmex);
        addButton (3, "Play", GamerGobPlaytime);
        addButton (4, "Taxes", TakeYourGemsScrooge);
        addButton (5, "Lethicite", TakeYummyDemonCrystals);
        addButton (6, "FreeShit", TakeFreeshit);
        addButton (14, "Back", StripClub);
    }

    private function TakeFreeshit():void {
        clearOutput();
    }

    private function TakeYummyDemonCrystals():void {
        clearOutput();
    }

    private function TakeYourGemsScrooge():void {
        clearOutput();
    }

    private function GamerGobPlaytime():void {
        clearOutput();
        outputText("You tell the odd goblin that you’re interested in playing one of her games with her.  \n\n");
        outputText("(If you don’t have a dick) Akaassaa smiles at you, giving you a once-over. “Okay…So I’ve only got one chair…but we can make this work. Just hold on a sec.” She rummages around before coming up with a strap-on, a large, draconic dildo already mounted on it.\n" +
                "\n" +
                "“Come on!” She seems excited, and not just for the sex. “Put this on for me, and sit down on the chair. We’ll be gaming in no time!” \n\n");
        outputText("(If you have a dick) She gives you an almost manic grin, motioning to her chair. “I’ve only got one chair, but I’m sure we can find a way to share it. I’ll grab you a controller, while you get settled.”  \n\n");

        outputText("Do you want to sit down on the black dildo, or move it before sitting down?  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Move", GamerGobNoDildo);
        addButton (1, "Sit", GamerGobAssPlay);
    }

    private function GamerGobAssPlay():void {
        outputText("YFeeling a little kinky, you decide that the black toy shouldn’t remain unused. You line it up with your [asshole], and slowly pry yourself open, spreading your cheeks as you lower yourself down onto the seat. You hear a slight whistle, and turn your head, to see Akaassaa watching, nodding appreciatively.  \n\n");
        outputText("“Nice!” She declares, giving you a thumbs up. “I’ll just hook that up to your controller.” She does something on the computer, and you feel the dildo vibrate inside your ass.  \n\n");
        outputText("Akaasaa watches your face as you finally insert it all the way, your asscheeks resting comfortably on the chair before returning. She grins, making sure your groin is exposed, before coming around the side. “Uh…Gimme a hand up, wouldya?”  \n\n");
        outputText(" \n\n");
        doNext(GameSelectGoblin);
    }

    private function GamerGobNoDildo():void {
        outputText("You pop the large black toy off the chair before sitting down. The chair is comfortable, and you feel yourself relaxing, sliding back into it. You start to understand why your little goblin friend loves sticking around so much. This chair is incredibly comfortable! \n\n");
        outputText("Akaasaa watches your face as you rest comfortably on the chair before returning. She grins, making sure your groin is exposed, before coming around the side. “Uh…Gimme a hand up, wouldya?”  \n\n");
        doNext(GameSelectGoblin);
    }

    private function GameSelectGoblin():void {
        outputText("You pick the little gamer-goblin up, and she giggles, hopping into your lap and plopping her fat ass down, skewering herself on your (cock/Strap-On). She snuggles back into you, sending a few shocks down your thighs as she gets comfortable.  \n\n");
        //if high tone
        outputText("She rubs her ass once. “Oof. You’re rock-hard, and not just in a fun way. You look fine…but damn, warn a girl next time, would you?”  \n\n");
        //Low tone
        outputText("She bounces up and down a few times, making your thighs jiggle. This seems to amuse the little goblin, and she leans back, humming. “Oh, nice and soft…You’re a perfect seat.” She leans back, nestling her head between your [breasts].  \n\n");

        outputText("“What do you wanna play?” The little goblin’s excitement is infectious, and you find yourself smiling slightly. You begin browsing the many games she has available, and she sits up, already quivering with excitement. \n\n");

        outputText("(Call of Booty: Black Bods)\n" +
                "\n" +
                "“Oh, that’s a classic.” Akaassa raves. “Shoot-em up action, stripping, fast-paced. Soap’s the best character. Let’s go!”  \n\n");
        outputText("(Star Whores: The Last Stripper)\n" +
                "\n" +
                "“The story’s shit, but the gameplay’s not bad, and Daisy Chain was a decent actress. Fuck it, why not?” \n \n\n");
        outputText("(Poke-ya-Mons)\n" +
                "“A bit slow, but the waifus are top-notch, and they even have a minigame that works with the dildos. Sure, I’ll boot it up for ya…Gotta Snatch em all!” \n \n\n");
        outputText("(Taints in Trial: Space)\n" +
                "“Really?” Your gamer goblin scoffs. “Meh, if you want. Personally, I find it boring. It’s a text, choose your own adventure type of game. It’s fine for a playthrough, but it’s a ton of reading. And the sex scenes…They’re overrated. Too much horse dick.”  \n\n");
        outputText("(Rosie the Riveter: Screwdriver Central)\n" +
                "\n" +
                " “Not a huge fan of the story, but hell, it’s a porn game. It gets repetitive, but you’re new, so…” \n \n\n");
        outputText("(Ratchet and Skank)\n" +
                "\n" +
                "“A classic.” She leans back, somewhat nostalgic. “This is the game that clued me into the fact that I like girls. So it’s always gonna have a soft spot in my pussy. I’d say my heart, but we both know where I really feel that.” \n\n");
        outputText("(God of Whore)\n" +
                "“Honestly, fun.” She giggles. “Not a huge fan of dudes, but this man is an EXCEPTION. MMM! And when he goes to town on all the goddesses…Oops…Spoiler…Sorry…”  \n\n");
        outputText("(Metal Cock Solid)\n" +
                "“Never Thought a stealth game would get my interest…But you go around, stealing people’s clothes. The story is convoluted, but if you ignore that, it’s a hell of a time.\n\n\n");
        outputText("(Metal Cock Rising, Refuckening)\n" +
                "“You’d never know this was a Metal Cock game. COMPLETELY different gameplay. Also great characters. The only bad part about this game is that there isn’t more of it.” \n \n\n");
        outputText("(Whorehammer)\n" +
                "“...Orks are best girls, fight me.” Akaassa seems to have little else to say regarding this franchise. \n\n");
        outputText("(CoB: World of Whores)\n" +
                "“The grandpappy of Bimbo Mode. The best thing to happen to this franchise…Too bad they ruined it in later games.” \n \n\n");
        outputText("Akaassa grins up at you from your lap, sending a shock of sensation up your shaft. “Ready to pick? It’s been so long since I’ve had someone to play with!” \n\n");
        doNext(GoblinGameHourly)
    }

    private function GoblinGameHourly():void {
        cheatTime(20);

    }

    private function GamerGirlGoblinSmex():void {
        clearOutput();
        outputText("The goblin’s eyes light up a bit. “Now you’re talking my language.” She gives you a once-over.  \n\n");
if (player.gender == 3) {
    outputText("She gives you a wide grin, pulling herself off the black dildo on her chair with a wet schluck. “Damn…You are a looker, aren’t you. Tell you what, sweetcheeks. I may be a lesbian, but I’m still a goblin, and you are setting off both my switches right now.”  \n\n");
}
        if (player.gender == 1) {
            outputText("“I usually prefer the ladies, but I’m not picky. Besides, you’ve got something I want.” \n\n");
        }
        if (player.gender == 2) {
            outputText("“Damn, girl, really? Thought you’d never ask.” She pulls herself off the black dildo on her chair, wriggling slightly. “Got plenty of others to choose from, if you want.”  \n\n");
        }

        }

    private function AkaassaTalk():void {
        clearOutput();
        outputText("“Really? You just came back here to chat?” Akaassa turns off her game, facing you properly. “Why? Pretty sure you’ve met plenty of goblins already out there. I know that portal you live by has a colony nearby.”  \n\n");
        outputText("You explain that you want to know your operation better, and that means getting to know the people who make it up. The little goblin nods in understanding. “Makes sense. So…What do you wanna gob about, boss?”  \n\n");
        outputText("  \n\n");
        outputText(" \n\n");
        menu();
        addButton (0, "Goblin Colony", AkaassaGoblinInvite);
        addButton (1, "Herself", AkaassaHerself);
        addButton (2, "Games?", GamerGobBlahBlah);
        addButton (3, "Play", GamerGobPlaytime);
        addButton (14, "back", Backroom);
    }

    private function GamerGobBlahBlah():void {
        outputText("  \n\n");
        outputText(" \n\n");
        outputText("  \n\n");
        outputText(" \n\n");
    }

    private function AkaassaGoblinInvite():void {

    }

    private function AkaassaHerself():void {

    }

    private function AkaassaComputer():void {
        clearOutput();
        outputText("Akaassa winces, looking at you skeptically. “Look, I’m not judging, but if that computer ends up like it was when I got here, I swear, I’m going to force-feed you Incubus draft, then rip off what grows in.”  \n\n");
        outputText("You give her a level glare, and to your surprise, she glares right back. “Hey, I threw in with Ceraph because I like girls and dick, I’m not a fucking sub.” She grins. “Ceraph can’t risk breaking me, even if she wanted to. I’m the only one other than Nolan who knows how to fix any of those fucking toys and remotes those assholes out there like so much. And I’m pretty sure if she tried to have Nolan do that, he’d walk.” She gives you a thumbs-up. “Also, if you missed any data on the freaks who were here before, I scanned all that shit for you.”  \n\n");
        outputText("You thank her for her…input, and turn the computer on.  \n\n");
        outputText(" \n\n");
        menu();
        addButton (14, "back", Backroom);
    }


    //-----------------Bendan Scenes and Functions-----------------

    private function BreweryEnter():void {
        clearOutput();
        if (BendanState == 0) {
            outputText("As you enter, you see several demons wandering around, carrying heavy objects. You recognize a few vials, stills, and other alchemical reagents being placed onto shelves. At the center of the hubbub sits a Xiangshi. Unlike the ones you’ve seen out in Mareth, he’s alert, snapping orders at the various demons around him. He’s short, standing only 5’2, with demonic horns curving upward nearly a half-foot beyond that. He wears a long-sleeved robe and tight pants that show off the length of his shaft. A name tag on his chest reads Bèndàn. \n\n");
            outputText("He alternates between leering at the various demons around him and shouting orders. A particularly ditzy-looking succubus walks by him, and he reels back, slapping her on the ass. She nearly drops the vials she’s holding, and she spins on one foot, glaring daggers at him, but says nothing, continuing on her way. He sees you, frowning, and stalks toward you.  \n\n");
            outputText("“Well, who the fuck are you?” He demands. You can see that his left ear’s been pierced three times, now that he’s closer, and he turns his head slightly, hiding it from view. “And what are you doing here? If you’re not part of my moving crew, then open up. I ordered a slut…Which one are you?” He’s already pulling down his pants. What do you do? \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            BendanState = 1;
            menu();
            addButton (0, "T.Slap", BendanTSlap);
            addButton (1, "Aggro", BendanInFace);
            addButton (2, "Punish", BendanPunish);
            addButton (3, "Talk", BendanAdmonish);
        } else if (BendanState == 1) {
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            outputText(" \n\n");
            menu();
            addButton (0, "Shop", BendanTSlap);
            addButton (14, "Back", StripClub);
        }

    }

    private function BendanAdmonish():void {
        outputText(" Giving the irate Xianshi the benefit of the doubt, you turn your head, telling him to put his dick away…and not to talk to his boss that way.  \n\n");
        outputText("“Boss? Bitch, please. I only answer to Ceraph. Last time I checked, I’m in *her* Harem. You new or something?”  \n\n");
        outputText("You tell him that he’s…not wrong. However, Ceraph DID recently get an owner…The same owner that got her this place.  \n\n");
        outputText("“...Oh. Oh…Shit.” His expression morphs from a confident sneer, to realization, to fear, all in less than a second. Before he can open his mouth, however, you cut him off, telling him to save it. You’re not going to punish him for his ignorance. But you’re going to be watching him, and if he’s out of line… You make a snipping gesture, and his face loses what little color it had left.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
    }

    private function BendanInFace():void {
        clearOutput();
        outputText("Wordlessly, you grab his crotch and squeeze as hard as you can. You tell the suddenly white, squeaking alchemist that you’re nobody’s slut…But that if you wanted, you could have everyone run a train on his ass, and Ceraph wouldn’t save him. Gripping harder, you ask him if he understands, and he nods frantically, hands up in surrender.  \n\n");
        outputText("You tell Bendan to think before opening his stupid mouth next time, and head back to the main hall. \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        doNext(StripClub);
    }

    private function BendanPunish():void {
        clearOutput();
        outputText("You decide to take a more aggressive approach. As he begins to free his foot-long demonic dong, you stride forward, slamming your fist into his jaw. The Jianshi falls stiffly, but as he looks up, suddenly angry, you tell him that you’re [Name], champion of Ignam, and owner of Ceraph…and that if he wants to keep his dick, and/or life, he’ll put it away, and get back to work.  \n\n");
        outputText("Several of the other demons gasp, eyeing you nervously, and he blanches, hands shaking. Without another word, you turn your back, leaving the room. Turning your head back, you tell him to spend less time worrying about sex, and more about doing his job, if he wants to stay in his position. You tell the arrogant undead that you could think of a few, less pleasant jobs for him.  \n\n");
        outputText("You let go of his balls, but before he can do much more than sigh in relief, you grab his ear, dragging the short-ass zombie into the main area. “H-Hey, what are y-you doing? F-fuck off, I’m not just some stupid…OW!” Demons in the crowd instinctively part as you drag him onto the stage by his ear, then grab the back of his labcoat, tossing him bodily into the center of the stage. The music stops, and you raise your voice, announcing to the assembled demons that this idiot just volunteered to be entertainment for the next hour.  \n\n");
        outputText("“No, I didn’t!” Bendan protests, looking hopefully towards Ceraph…Who shakes her head as you ascend. She stands to one side, fluffing your throne for you, and as you sit, you give the luckless Xiangshi a devilish grin. Motioning to the succubi that had danced before, you tell them to bind him. He protests, but is quickly overwhelmed, hands bound, stripped of his labcoat and clothing, just another toy for the horde.  \n\n");
        outputText("For an hour, you take requests, ranging from the humiliatingly comedic, to the sexually tormenting, toying with Bendan. At first, he’s feisty, pulling at his restraints and spitting at anyone who gets close…But it doesn’t take much to break him. Somewhere between clamping electrifying clamps to his nipples and sandwiching him between two succubi and letting them play tug of war with his cock, he stops struggling, accepting the punishment.  \n\n");
        outputText("You begin to feel bored with this game, and raise your hands, opening your mouth to give the order…until Ceraph steps down from her throne, putting a hand on your shoulder. “[Master], I hate to interrupt the festivities, but I have a fun idea, if you would humor me.” You feel magnanimous, and tell Ceraph to speak her mind.  \n\n");
        outputText("“There is someone who I know Bendan would absolutely HATE to have dominate him. As we all know, my dears…The touch must be…Personal…To be a true mark of dominance.” The crowd roars, and she whispers into your ear. “It’s Emerald, my dear [master]. The girl’s taken so much abuse from him…and letting her have her way with him…would REALLY drive the point home.”  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        MeilaTrust += 10;
        Playerdominance +=5;
        menu();
        addButton (0, "Emerald", BendanEmerald);
        addButton (1, "Nah", BendanNah);
    }

    private function BendanNah():void {
        clearOutput();
        outputText("You tell Ceraph that maybe next time you’ll consider it. She seems disappointed, but as you release the nearly comatose Bendan, letting him fall to the stage, he wakes up. He scrabbles at the floor, looking towards his discarded labcoat, but you stop him, putting a foot on the back of his head and slamming him back down to the floor.  \n\n");
        outputText("You tell Bendan to consider this his warning. You’re not to be disrespected. From the floor, he groans. “U-understood…” You place more of your weight on his head. Understood…What? “Understood…[Master].” You tell him to clean himself up and get back to work, walking back to your throne. The crowd cheers and jeers, laughing at the unfortunate alchemist.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        doNext(StripClub);
    }

    private function BendanEmerald():void {
        outputText("You tell Ceraph that she just had a wonderful idea. Patting her on the head, you raise your voice. You call Emerald to the stage. From her spot at the bar, watching the festivities, the Omnibus’s eyes widen, locking onto you. You call her again, this time firmer, and she lights up, grinning. “Really? For ME?!” She practically skips over to the stage, and ascends, giving you a giddy little squeal as a few incubi workers wheel in an entire dungeon’s worth of toys. Paddles, whips, plugs, gags…Pretty much everything an aspiring Dominatrix could ask for.  \n\n");
        outputText("Before she picks anything out however, Emerald kneels at your throne. “Thank you for this opportunity, my [master]. I won’t disappoint you.” You nod, telling her to give him all she’s got.  \n\n");
        outputText("She removes the toy from her own ass, and considers it briefly before jamming it between two fingers. Walking around to Bendan’s already abused ass, she pops the egg-shaped toy in there, before sliding the tip of a small dildo in behind it.  \n\n");
        outputText("“Oh Bendaaan~” She sings, and the abused undead opens one eye. Seeing her, his eyes widen, and he begins to struggle again. The gag in his mouth prevents him from speaking, but his muffled cries and shaking head are loud enough for everyone to tell what he’s trying to say.  \n\n");
        outputText("She gleefully skips around to his backside, and takes a novelty plastic hammer from the wall. Taking her time to line it up, she taps the dildo, getting a whine, before rearing back and slamming the back of the dildo with the hammer. The Xiangshi demon’s cock is painfully erect, and he lets out a pained groan. \n\n");
        outputText("You take a step back as Emerald slides in behind him, a wicked grin on her face. His punishment seems to be well in hand. You doubt that Bendan will have the balls to mess with you again, after this. \n\n");
        Playerdominance +=5;
        doNext(StripClub);
    }

    private function BendanTSlap():void {
        clearOutput();
        Playerdominance +=5;
        outputText("You pull out Ceraph’s token, and promptly slap the demonic undead across the face with it. While his face begins to turn red with anger, as he steps forward, he recognizes the token, and staggers back, dropping to one knee.  \n\n");
        outputText("“O-Oh shit.” He looks up at you, face suddenly white with fear. “Um…[Master] [Name], I didn’t know it was you. I apologize profusely.” He shudders, eyes wide. “Mistress Ceraph told us you’d be coming to check on our progress…But I didn’t know you’d be so…Attractive.”  \n\n");
        outputText("You tell the undead that if you wanted so much brown on his nose, you’d tell him to sniff minotaur ass. Roughly, you tell the alchemist that you expect better customer service in the future…and that you’d better not hear of him harassing your guests…not unless they want it.  \n\n");
        outputText(" \n\n");
        outputText(" \n\n");
        doNext(StripClub);
    }

    //-----------------Emerald Scenes and Functions----------------
    private function Gemstone4yourmeal():void {
        clearOutput();
        outputText("You decide you’re in the mood for something more valuable than a meal…And the Emerald right in front of you will do nicely.  \n\n");
        outputText("You grab Emerald’s hand, pulling her into you. She offers no resistance, melting into your arms. She brings her lips to yours, sighing slightly. You kiss her, and she pulls back after a few seconds, biting her lip and rubbing her thigh against your groin.\n\n");
        outputText("“Oh, [master], I was hoping you’d want some…service.” She brings her lips to your ear. “Most customers aren’t allowed to fuck me…And it gets so…Frustrating.” She drops a hand between your legs. \n\n");
        if (player.hasCock()) {
            outputText("Your [cock] begins to harden, and as she brushes her soft hand into it, rubbing gently, you stand erect. \n\n");
        }
        if (player.hasVagina()) {
            outputText("She finds your button, and sinks one finger into your quim. Your juices cover her fingers, and she pulls it out, licking her finger clean. \n\n");
        }
        outputText("“How do you want me, [master]? Emerald purrs, looking deep into your eyes. \n\n");
        menu();
        addButton(0, "BendOver", BendGemOver);
        addButton(1, "Table", GemOnTable);
        addButton(2, "SitOnHer", ShoveGemUpThere);
        addButton(3, "back", FoodHall);
    }

    private function GemOnTable():void {
        outputText("\n\n");
        outputText("\n\n");
        outputText("\n\n");
        outputText("\n\n");
        outputText("\n\n");
        doNext(FoodHall);
    }

    private function ShoveGemUpThere():void {
        outputText("\n\n");
        outputText("\n\n");
        outputText("\n\n");
        outputText("\n\n");
        outputText("\n\n");
        doNext(FoodHall);
    }

    private function BendGemOver():void {
        clearOutput();
        outputText("You free your [cock], then take Emerald by the shoulders, spinning her around so her back’s to you. Pushing her upper body down, almost to the table, Emerald gasps as you pull her scanty skirt down. \n\n");
        outputText("“Ooh, how forceful.” She looks around, and it seems you’ve already attracted an audience. Several demons are giving you side-eye, and Emerald seems to sense it as you pause, leaning back into you, your [cock] between her asscheeks. “Oh, don’t worry about them, [Master]”, she moans. “Please…I’ve been…Hnnngh!” The toy in her ass pulses rapidly, and she bites her lip. “Don’t you want to take that thing out and fuck me?” \n\n");
        outputText("You decide that Emerald’s being a bit too forward…Not exactly what you were looking for. You decide to respond in kind. Looking around at the demons watching, you make a button pressing motion, and get all kinds of grins back. You pull the toy out, then stick it back in, into her pussy.\n\n");
        outputText("You line your [cock] up with Emerald’s purple pucker, and as she realizes what you’re about to do, the first demon decides to push the button. She sees it, glaring daggers at the demon.\n");
        outputText("“H-hey asshole, I-” A fun choice of words! You grind your [cockhead] against her backdoor. For a moment, her pucker resists, pushing back against your entry, but you pull on Emerald’s arms, and she gasps as you push past her sphincter, into her back passage. You sink, inch by inch, into her ass. Meila’s eyes are wide, and you can feel her twist, jerking as the demons in the restaurant begin hammering on their buttons. She turns her head to look back at you, knees shaking, and you grin back, letting one arm go as you bend down, copping a feel. She’s leaking like a faucet, and even the lightest touch nearly sets her off. \n\n");
        outputText("You pull your [cock] back, getting constant shuddering from Emerald, and as you thrust, the overeager omnibus’s upper half slams into the table. Her sphincter tightens, almost painful on your shaft, and as you push past her resistant asshole, sinking into her innards, Emerald lets out a shuddering gasp, and you hear a clattering noise and a trickle of warm fluids down your [legs]. Looking down, you realize that the overeager slut’s forced the toy out by cumming. \n\n");
        outputText("You pick up the pace, not wanting to remove yourself from her warm, cozy ass. Emerald is loud, gripping the table with both hands and moaning with every thrust. Only a minute in, she lets out an orgasmic moan, covering your pelvis with clear femcum as she arches her back, toes curling off the ground. Her little cock spurts her spooge across the table. \n\n");
        outputText("“Ah-ah-ah-ah-AHN!” Emerald leans back, rolling her eyes up, tongue out as she tries to find your eyes, looking back at you…And you put one hand between her shoulder blades, roughly pushing her back down to the table. This gets a giggle from the submissive Omnibus, and she bites her lip, ass tightening even more around your shaft as she spasms, cumming for a third time. Her stomach and breasts are slick with her cum, and she swings her hips wildly.\n\n");
        outputText("You slap her ass, feeling your own orgasm starting to hit. Your [cock] begins to twitch in her now-abused ass, and Emerald lets out a yip as you pin her down, slamming your hips into hers as hard as you can, slamming her thighs into the side of the table. The Omnibus squeals as you shove your shaft in as far as it’ll go, unleashing your sperm into her ass.\n\n");
        outputText("Your high lasts for a few seconds before you pull out, spraying her back with the last of your cum. You wipe your tip off on her asscheek, and as Emerald flops onto her back, tongue out and eyes rolled back into her head, you tell her to clean off the table and get back to work. You pick up the toy, popping it back into her ass and trapping your cum inside. Sternly, you tell her that unless she wants punishment, she’ll stay on for the rest of her shift. \n\n");
        outputText("“Eh…Heh…Heh…EeeYes SIR!” Emerald says, slowly closing her legs. “Ah…Ah’ll…Start with this table…Don’t know how it got…so dirty…” You notice several demons licking their lips, cocks erect and damp spots on their clothing as they watch Emerald try to bring herself back from a smoldering puddle of fuck. \n\n");
        outputText("");

    }



}
}
