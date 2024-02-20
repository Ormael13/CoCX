package classes {
import classes.Races.*;
import classes.Races.KirinRace;
import classes.Scenes.Monsters.Werespider;
import classes.Scenes.Monsters.WerespiderScene;
import classes.internals.race.RaceTierBuilder;

public class Races {
	/**
	 * All races, including disabled
	 */
	public static const AllRacesWithDisabled:/*Race*/Array = [];
	/**
	 * All races except disabled; use this array to calc racial scores and apply bonuses
	 */
	public static var AllEnabledRaces:/*Race*/Array      = [];
	/**
	 * All races except disabled and hidden
	 */
	public static var AllVisibleRaces:/*Race*/Array = [];
	/**
	 * All visible enabled races, sorted by name
	 */
	public static var AllRacesByName:/*Race*/Array = [];
	
	public static const HUMAN:HumanRace                    = new HumanRace(1);
	public static const CAT:CatRace                        = new CatRace(2);
	public static const NEKOMATA:NekomataRace              = new NekomataRace(3);
	public static const CHESHIRE:CheshireRace              = new CheshireRace(4);
	public static const HELLCAT:HellcatRace                = new HellcatRace(5);
	public static const DISPLACERBEAST:DisplacerBeastRace  = new DisplacerBeastRace(6);
	public static const SPHINX:SphinxRace                  = new SphinxRace(7);
	public static const LIZARD:LizardRace                  = new LizardRace(8);
	public static const DRAGON:DragonRace                  = new DragonRace(9);
	public static const DRAGONNE:DragonneRace              = new DragonneRace(10);
	public static const RACCOON:RaccoonRace                = new RaccoonRace(11);
	public static const DOG:DogRace                        = new DogRace(12);
	public static const WOLF:WolfRace                      = new WolfRace(13);
	public static const WEREWOLF:WerewolfRace              = new WerewolfRace(14);
	public static const FOX:FoxRace                        = new FoxRace(15);
	public static const FERRET:FerretRace                  = new FerretRace(16);
	public static const KITSUNE:KitsuneRace                = new KitsuneRace(17);
	public static const KITSHOO:KitshooRace                = new KitshooRace(18);
	public static const HORSE:HorseRace                    = new HorseRace(19);
	public static const UNICORN:UnicornRace                = new UnicornRace(20);
	public static const CENTAUR:CentaurRace                = new CentaurRace(21);
	public static const MINOTAUR:MinotaurRace              = new MinotaurRace(22);
	public static const COW:CowRace                        = new CowRace(23);
	public static const SANDTRAP:SandTrapRace              = new SandTrapRace(24);
	public static const BEE:BeeRace                        = new BeeRace(25);
	public static const GOBLIN:GoblinRace                  = new GoblinRace(26);
	public static const DEMON:DemonRace                    = new DemonRace(27);
	public static const DEVIL:DevilRace                    = new DevilRace(28);
	public static const SHARK:SharkRace                    = new SharkRace(29);
	public static const ORCA:OrcaRace                      = new OrcaRace(30);
	public static const OOMUKADE:OomukadeRace              = new OomukadeRace(31);
	public static const ONI:OniRace                        = new OniRace(32);
	public static const ELF:ElfRace                        = new ElfRace(33);
	public static const ORC:OrcRace                        = new OrcRace(34);
	public static const RAIJU:RaijuRace                    = new RaijuRace(35);
	public static const THUNDERBIRD:ThunderbirdRace        = new ThunderbirdRace(365);
	public static const BUNNY:BunnyRace                    = new BunnyRace(37);
	public static const HARPY:HarpyRace                    = new HarpyRace(38);
	public static const SPIDER:SpiderRace                  = new SpiderRace(39);
	public static const KANGAROO:KangarooRace              = new KangarooRace(40);
	public static const MOUSE:MouseRace                    = new MouseRace(41);
	public static const SCORPION:ScorpionRace              = new ScorpionRace(42);
	public static const MANTIS:MantisRace                  = new MantisRace(43);
	public static const SALAMANDER:SalamanderRace          = new SalamanderRace(44);
	public static const CAVEWYRM:CaveWyrmRace              = new CaveWyrmRace(45);
	public static const NAGA:NagaRace                      = new NagaRace(46);
	public static const GORGON:GorgonRace                  = new GorgonRace(47);
	public static const VOUIVRE:VouivreRace                = new VouivreRace(48);
	public static const COUATL:CouatlRace                  = new CouatlRace(49);
	public static const HYDRA:HydraRace                    = new HydraRace(50);
	public static const FIRESNAILS:FireSnailRace           = new FireSnailRace(51);
	public static const PHOENIX:PhoenixRace                = new PhoenixRace(52);
	public static const SCYLLA:ScyllaRace                  = new ScyllaRace(53);
	public static const PLANT:PlantRace                    = new PlantRace(54);
	public static const ALRAUNE:AlrauneRace                = new AlrauneRace(55);
	public static const YGGDRASIL:YgddrasilRace            = new YgddrasilRace(56);
	public static const PIG:PigRace                        = new PigRace(57);
	public static const SATYR:SatyrRace                    = new SatyrRace(58);
	public static const RHINO:RhinoRace                    = new RhinoRace(59);
	public static const ECHIDNA:EchidnaRace                = new EchidnaRace(60);
	public static const DEER:DeerRace                      = new DeerRace(61);
	public static const MANTICORE:ManticoreRace            = new ManticoreRace(62);
	public static const REDPANDA:RedPandaRace              = new RedPandaRace(63);
	public static const BEARANDPANDA:BearRace              = new BearRace(64);
	public static const SIREN:SirenRace                    = new SirenRace(65);
	public static const YETI:YetiRace                      = new YetiRace(66);
	public static const YUKIONNA:YukiOnnaRace              = new YukiOnnaRace(67);
	public static const BAT:BatRace                        = new BatRace(68);
	public static const VAMPIRE:VampireRace                = new VampireRace(69);
	public static const JABBERWOCKY:JabberwockyRace        = new JabberwockyRace(70);
	public static const AVIAN:AvianRace                    = new AvianRace(71);
	public static const GARGOYLE:GargoyleRace              = new GargoyleRace(72);
	public static const SLIME:SlimeRace                    = new SlimeRace(73);
	public static const MAGMASLIME:MagmaSlimeRace          = new MagmaSlimeRace(74);
	public static const DARKSLIME:DarkSlimeRace            = new DarkSlimeRace(75);
	public static const JIANGSHI:JiangshiRace              = new JiangshiRace(76);
	public static const POLTERGEIST:PoltergeistRace        = new PoltergeistRace(77);
	public static const BANSHEE:BansheeRace                = new BansheeRace(78);
	public static const MELKIE:MelkieRace                  = new MelkieRace(79);
	public static const EASTERBUNNY:EasterBunnyRace        = new EasterBunnyRace(80);
	public static const CENTIPEDE:CentipedeRace            = new CentipedeRace(81);
	public static const FROSTWYRM:FrostWyrmRace            = new FrostWyrmRace(82);
	public static const CANCER:CancerRace                  = new CancerRace(83);
	public static const USHIONNA:UshiOniRace               = new UshiOniRace(84);
	public static const FAIRY:FairyRace                    = new FairyRace(85);
	public static const GREMLIN:GremlinRace                = new GremlinRace(86);
	public static const KAMAITACHI:KamaitachiRace          = new KamaitachiRace(87);
	public static const GAZER:GazerRace                    = new GazerRace(88);
	public static const RATATOSKR:RatatoskrRace            = new RatatoskrRace(89);
	public static const WENDIGO:WendigoRace                = new WendigoRace(90);
	public static const TROLL:TrollRace                    = new TrollRace(91);
	public static const ATLACH_NACHA:AtlachNachaRace       = new AtlachNachaRace(92);
	public static const WOODELF:WoodElfRace                = new WoodElfRace(93);
	public static const SEA_DRAGON:SeaDragonRace           = new SeaDragonRace(94);
	public static const FMINDBREAKER:FemaleMindbreakerRace = new FemaleMindbreakerRace(95);
	public static const MMINDBREAKER:MaleMindbreakerRace   = new MaleMindbreakerRace(96);
	public static const ELEMENTALFUSION:ElementalRace      = new ElementalRace(97);
	public static const GRYPHON:GryphonRace                = new GryphonRace(98);
	public static const PEACOCK:PeacockRace                = new PeacockRace(99);
	public static const ANGEL:AngelRace                    = new AngelRace(100);
	public static const APOPHIS:ApophisRace                = new ApophisRace(101);
	public static const CYCLOP:CyclopRace                  = new CyclopRace(102);
	public static const ALICORN:AlicornRace                = new AlicornRace(103);
	public static const ANT:AntRace						   = new AntRace(104);
	public static const KIRIN:KirinRace					   = new KirinRace(105);
	public static const FAERIEDRAGON:FaerieDragonRace	   = new FaerieDragonRace(106);
	public static const AZAZEL:AzazelRace	               = new AzazelRace(107);
	public static const CERBERUS:CerberusRace	           = new CerberusRace(108);
	public static const IMP:ImpRace                        = new ImpRace(109);
	public static const SANDWORM:SandWormRace              = new SandWormRace(110);
	public static const RAISUNE:RaisuneRace                = new RaisuneRace(111);
	public static const WEREFOX:WerefoxRace                = new WerefoxRace(112);
	public static const ANUBIS:AnubisRace				   = new AnubisRace(113);
	public static const WERESPIDER:WerespiderRace          = new WerespiderRace(114);
	public static const WERESHARK:WeresharkRace            = new WeresharkRace(115);
	public static const ABYSSAL_SHARK:AbyssalSharkRace     = new AbyssalSharkRace(116);
	public static const ARIGEAN:ArigeanRace                = new ArigeanRace(117);
	public static const DRACULA:DraculaRace                = new DraculaRace(118);
	public static const MOTH:MothRace                      = new MothRace(119);

	// Racial groups
	public static const CatlikeRaces:/*Race*/Array   = [
			CAT, NEKOMATA, DISPLACERBEAST, HELLCAT, CHESHIRE, SPHINX, MANTICORE, DRAGONNE
	];
	public static const SnakelikeRaces:/*Race*/Array = [
			NAGA, GORGON, VOUIVRE, COUATL, HYDRA, APOPHIS
	];
	public static const InsectRaces:/*Race*/Array = [
			BEE, MANTIS, SCORPION, SPIDER, ANT, OOMUKADE, CANCER, ATLACH_NACHA, SANDWORM, WERESPIDER, MOTH
	];
	public static const GoblinoidRaces:/*Race*/Array = [
			GOBLIN, GREMLIN
	];
	public static const HarpylikeRaces:/*Race*/Array = [
			HARPY, THUNDERBIRD, PHOENIX
	];
	public static const KitsunelikeRaces:/*Race*/Array = [
			KITSUNE, KITSHOO, RAISUNE
	];
	public static const RacesForRandomEnchantments:/*Race*/Array = [
			// populated in load() as AllVisibleRaces - RacesExcludedFromRandomEnchantments
	];
	// Don't use these races when generating random enchantment
	private static const RacesExcludedFromRandomEnchantments:/*Race*/Array = [
			ELEMENTALFUSION
	];
	
	function Races() {
	}
	
	public static function load():void {
		RaceTierBuilder.ensureEndCalled();
		// log scary numbers for fun
		var nreq:int=0,nt:int=0,nr:int=0;
		
		for (var id:String in Race.RaceById) {
			var race:Race = Race.RaceById[id];
			AllRacesWithDisabled.push(race);
			try {
				race.setup();
			} catch (e:Error) {
				trace("[ERROR] Error initializing race "+race.name);
				trace(e.getStackTrace());
				continue;
			}
			if (race.disabled) {
				trace("Race "+race.name+" (#"+race.id+") is disabled")
				continue;
			} else if (race.tiers.length == 0) {
				trace("[ERROR] Race "+race.name+" has no tiers, disabling it");
				race.disabled = true;
				continue;
			}
			nr++;
			nreq += race.requirements.length;
			nt += race.tiers.length;
			AllEnabledRaces.push(race);
			if (race.hidden) {
				trace("Race "+race.name+" (#"+race.id+") is hidden")
				continue;
			}
			AllVisibleRaces.push(race);
			if (RacesExcludedFromRandomEnchantments.indexOf(race) == -1) {
				RacesForRandomEnchantments.push(race);
			}
		}
		trace("Loaded "+nr+" races, "+nt+" tiers, "+nreq+" requirements");
		
		AllRacesByName = AllVisibleRaces.slice().sortOn("name",Array.CASEINSENSITIVE);
	}
}
}
