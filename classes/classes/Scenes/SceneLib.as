package classes.Scenes {
import classes.CoC;
import classes.Items.ItemSetChecks;
import classes.Scenes.API.ExplorationEngine;
import classes.Scenes.Areas.*;
import classes.Scenes.Areas.Battlefield.DilapidatedShrine;
import classes.Scenes.Areas.Bog.TrollScenes;
import classes.Scenes.Areas.Caves.DisplacerBeastScene;
import classes.Scenes.Areas.DeepSea.AbyssalSharkScene;
import classes.Scenes.Areas.Forest.ErlKingScene;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Areas.GlacialRift.YuWinterGearShop;
import classes.Scenes.Areas.Ocean.ScyllaScene;
import classes.Scenes.Camp.*;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Dungeons.AnzuPalace.AnzuScene;
import classes.Scenes.Dungeons.D3.D3;
import classes.Scenes.Dungeons.DeepCave.ValaScene;
import classes.Scenes.Dungeons.DungeonEngine;
import classes.Scenes.Dungeons.HelDungeon.BrigidScene;
import classes.Scenes.Explore.*;
import classes.Scenes.Monsters.*;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.*;
import classes.Scenes.Places.Boat.SharkGirlScene;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;
import classes.Scenes.Places.HeXinDao.JourneyToTheEast;
import classes.Scenes.Places.TelAdre.Loppe;
import classes.Scenes.Quests.UrtaQuest;

public class SceneLib {
    public static var camp:Camp = new Camp(/*campInitialize*/);
	
	public static var campMakeWinions:CampMakeWinions = new CampMakeWinions();
	
	public static var campUpgrades:CampUpgrades = new CampUpgrades();

    public static var combat:Combat = new Combat();

    public static var exploration:Exploration = new Exploration();
    
    public static var explorationEngine:ExplorationEngine = new ExplorationEngine();

    public static var followerInteractions:FollowerInteractions = new FollowerInteractions();

    public static var inventory:Inventory = new Inventory(CoC.instance.saves);

    public static var masturbation:Masturbation = new Masturbation();

    public static var battlefiledboundary:BattlefieldBoundary = new BattlefieldBoundary();

    public static var battlefiledouter:BattlefieldOuter = new BattlefieldOuter();

    public static var beach:Beach = new Beach();

    public static var blightridge:BlightRidge = new BlightRidge();

    public static var defiledravine:DefiledRavine = new DefiledRavine();

    public static var bog:Bog = new Bog();

    public static var desert:Desert = new Desert();

    public static var forest:Forest = new Forest();

    public static var highMountains:HighMountains = new HighMountains();

    public static var lake:Lake = new Lake();

    public static var mountain:Mountain = new Mountain();

    public static var ocean:Ocean = new Ocean();

    public static var plains:Plains = new Plains();
    
    public static var kihaFollower:KihaFollower = new KihaFollower();
    
    public static var kihaScene:KihaScene = new KihaScene();

    public static var swamp:Swamp = new Swamp();

    public static var caves:Caves = new Caves();

    public static var tundra:Tundra = new Tundra();

    public static var glacialRift:GlacialRift = new GlacialRift();

    public static var ashlands:Ashlands = new Ashlands();

    public static var volcanicCrag:VolcanicCrag = new VolcanicCrag();

    public static var brigidScene:BrigidScene = new BrigidScene();

    public static var d3:D3 = new D3();

    public static var gargoyle:Gargoyle = new Gargoyle();

    public static var lumi:Lumi = new Lumi();

    public static var giacomoShop:Giacomo = new Giacomo();

    public static var angelScene:AngelScene = new AngelScene();

    public static var impScene:ImpScene = new ImpScene();

    public static var goblinScene:GoblinScene = new GoblinScene();

    public static var priscillaScene:PriscillaScene = new PriscillaScene();

    public static var trollScene:TrollScenes = new TrollScenes();
	
	public static var displacerbeastScene:DisplacerBeastScene = new DisplacerBeastScene();
    
    public static var dridertown:DriderTown = new DriderTown();

    public static var aethertwins:AetherTwinsFollowers = new AetherTwinsFollowers();

    public static var alvinaFollower:AlvinaFollower = new AlvinaFollower();

    public static var amilyScene:AmilyScene = new AmilyScene();

    public static var kidAScene:KidAScene = new KidAScene();

    public static var ariaScene:AriaFollower = new AriaFollower();

    public static var arianScene:ArianScene = new ArianScene();

    public static var auroraFollower:AuroraFollower = new AuroraFollower();

    public static var ayaneFollower:AyaneFollower = new AyaneFollower();

    public static var bashemathScene:BashemathFollower = new BashemathFollower();
    
    public static var belisa:BelisaFollower = new BelisaFollower();

    public static var ceraphScene:CeraphScene = new CeraphScene();

    public static var ceraphFollowerScene:CeraphFollowerScene = new CeraphFollowerScene();

    public static var charybdisScene:CharybdisFollower = new CharybdisFollower();

    public static var chichiScene:ChiChiFollower = new ChiChiFollower();

    public static var ceaniScene:CeaniScene = new CeaniScene();

    public static var dianaScene:DianaFollower = new DianaFollower();

    public static var dinahScene:DinahFollower = new DinahFollower();

    public static var electraScene:ElectraFollower = new ElectraFollower();

    public static var emberScene:EmberScene = new EmberScene();
	
	public static var erlkingScene:ErlKingScene = new ErlKingScene();

    public static var etnaScene:EtnaFollower = new EtnaFollower();

    public static var etnaDaughterScene:EtnaDaughterScene = new EtnaDaughterScene();

    public static var evangelineFollower:EvangelineFollower = new EvangelineFollower();

    public static var excelliaFollower:ExcelliaFollower = new ExcelliaFollower();

    public static var exgartuan:Exgartuan = new Exgartuan();
	
	public static var forgefatherScene:Forgefather = new Forgefather();

    public static var galiaFollower:GaliaFollower = new GaliaFollower();

    public static var graydaScene:GraydaRetainer = new GraydaRetainer();

    public static var helFollower:HelFollower = new HelFollower();

    public static var helScene:HelScene = new HelScene();

    public static var helSpawnScene:HelSpawnScene = new HelSpawnScene();

    public static var holliScene:HolliScene = new HolliScene();

    public static var iridesianFollower:IridesianFollower = new IridesianFollower();

    public static var isabellaScene:IsabellaScene = new IsabellaScene();

    public static var isabellaFollowerScene:IsabellaFollowerScene = new IsabellaFollowerScene();

    public static var izmaScene:IzmaScene = new IzmaScene();

    public static var jojoScene:JojoScene = new JojoScene();

    public static var joyScene:JoyScene = new JoyScene();

    public static var kindraFollower:KindraFollower = new KindraFollower();

    public static var konstantin:Konstantin = new Konstantin();

    public static var latexGirl:LatexGirl = new LatexGirl();
    
    public static var lily:LilyFollower = new LilyFollower();

    public static var lunaFollower:LunaFollower = new LunaFollower();

    public static var marbleScene:MarbleScene = new MarbleScene();

    public static var marblePurification:MarblePurification = new MarblePurification();

    public static var michikoFollower:Michiko = new Michiko();

    public static var midokaScene:MidokaScene = new MidokaScene();

    public static var milkWaifu:MilkWaifu = new MilkWaifu();

    public static var nadiaScene:NadiaFollower = new NadiaFollower();

    public static var neisaFollower:NeisaFollower = new NeisaFollower();

    public static var mitziFollower:MitziFollower = new MitziFollower();

    public static var patchouliScene:PatchouliScene = new PatchouliScene();

    public static var raphael:Raphael = new Raphael();

    public static var rathazul:Rathazul = new Rathazul();

    public static var ryubi:RyuBiFollower = new RyuBiFollower();

    public static var siegweirdFollower:SiegweirdFollower = new SiegweirdFollower();

    public static var sheilaScene:SheilaScene = new SheilaScene();

    public static var samirah:SamirahScene = new SamirahScene();

    public static var shouldraFollower:ShouldraFollower = new ShouldraFollower();

    public static var shouldraScene:ShouldraScene = new ShouldraScene();

    public static var sidonieFollower:SidonieFollower = new SidonieFollower();

    public static var sophieBimbo:SophieBimbo = new SophieBimbo();

    public static var sophieFollowerScene:SophieFollowerScene = new SophieFollowerScene();

    public static var sophieScene:SophieScene = new SophieScene();

    public static var tedScene:TedScenes = new TedScenes();

    public static var tifaFollower:TifaFollower = new TifaFollower();

    public static var tyrantia:TyrantiaFollower = new TyrantiaFollower();

    public static var loppe:Loppe = new Loppe();

    public static var urta:Urta = new Urta();

    public static var urtaHeatRut:UrtaHeatRut = new UrtaHeatRut();

    public static var urtaPregs:UrtaPregs = new UrtaPregs();

    public static var vala:ValaScene = new ValaScene();
    
    public static var valeria:ValeriaScene = new ValeriaScene();

    public static var vapula:Vapula = new Vapula();

    public static var waizabi:WaizAbiFollower = new WaizAbiFollower();

    public static var werefoxScene:WerefoxScene = new WerefoxScene();

    public static var werespiderScene:WerespiderScene = new WerespiderScene();

    public static var weresharkScene:WeresharkScene = new WeresharkScene();

    public static var woodElves:WoodElves = new WoodElves();

    public static var mindbreaker:Mindbreaker = new Mindbreaker();

    public static var zenjiScene:ZenjiScenes = new ZenjiScenes();

    public static var sharkgirlScene:SharkGirlScene = new SharkGirlScene();

    public static var scyllaScene:ScyllaScene = new ScyllaScene();

    public static var abyssalsharkScene:AbyssalSharkScene = new AbyssalSharkScene();

    public static var ghoulishVampireServant:GhoulishVampireServant = new GhoulishVampireServant();

    public static var trollVillage:TrollVillage = new TrollVillage();

    public static var bazaar:Bazaar = new Bazaar();

    public static var boat:Boat = new Boat();

    public static var farm:Farm = new Farm();

    public static var owca:Owca = new Owca();

    public static var telAdre:TelAdre = new TelAdre();

    public static var theTrench:TheTrench = new TheTrench();

    public static var ruinedTown:RuinedTownRebuilt = new RuinedTownRebuilt();

    public static var dungeons:DungeonEngine = new DungeonEngine();

    public static var ingnam:Ingnam = new Ingnam();

    public static var hexindao:HeXinDao = new HeXinDao();

    public static var kitsuneScene:KitsuneScene = new KitsuneScene();
	
	public static var dilapidatedShrine:DilapidatedShrine = new DilapidatedShrine();
	
	public static var anzu:AnzuScene = new AnzuScene();

    public static var urtaQuest:UrtaQuest = new UrtaQuest();

    public static var debugMenu:DebugMenu = new DebugMenu();

    public static var soulforce:Soulforce = new Soulforce();

    public static var metamorph:Metamorph = new Metamorph();

    public static var crafting:Crafting = new Crafting();

    public static var garden:Garden = new Garden();

    public static var aikoScene:AikoScene = new AikoScene();
	
	public static var glacialYuShop:YuWinterGearShop = new YuWinterGearShop();
	
	public static var journeyToTheEast:JourneyToTheEast = new JourneyToTheEast();
	
	public static var adventureGuild:AdventurerGuild = new AdventurerGuild();
	
	public static var fleshGolemScenes:FleshGolemScene = new FleshGolemScene();

    public static var phyllaScene:PhyllaScene = new PhyllaScene();

    public static var templeofdivine:TempleOfTheDivine = new TempleOfTheDivine();

    public static var uniqueSexScene:UniqueSexScenes = new UniqueSexScenes();

    public static var setItemsChecks:ItemSetChecks = new ItemSetChecks();

    public static var mimicScene:MimicScene = new MimicScene();

    public static var ivorySuccubusScene:IvorySuccubusScene = new IvorySuccubusScene();

    public static var holidays:Holidays = new Holidays();

    public static var werewolfFemaleScene:WerewolfFemaleScene = new WerewolfFemaleScene();

    public static var astridFollower:AstridFollower = new AstridFollower();
}
}
