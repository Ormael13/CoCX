package classes {
import classes.Races.*;
import classes.internals.race.RaceTierBuilder;

public class Races {
	
	public static const HUMAN:Race = new Race("Human",1, "humanScore", 1);
	public static const CAT:CatRace = new CatRace(2);
	public static const NEKOMATA:NekomataRace = new NekomataRace(3);
	public static const CHESHIRE:CheshireRace = new CheshireRace(4);
	public static const HELLCAT:HellcatRace = new HellcatRace(5);
	public static const DISPLACERBEAST:DisplacerBeastRace = new DisplacerBeastRace(6);
	public static const SPHINX:SphinxRace = new SphinxRace(7);
	public static const LIZARD:Race = new Race("Lizard",8, "lizardScore", 8);
	public static const DRAGON:DragonRace = new DragonRace(9);
	public static const DRAGONNE:DragonneRace = new DragonneRace(10);
	public static const RACCOON:Race = new Race("Raccoon",11,"raccoonScore", 8);
	public static const DOG:Race = new Race("Dog",12,"dogScore", 4);
	public static const WOLF:WolfRace = new WolfRace(13);
	public static const WEREWOLF:WerewolfRace = new WerewolfRace(14);
	public static const FOX:Race = new Race("Fox",15,"foxScore", 7);
	public static const FERRET:Race = new Race("Ferret",16,"ferretScore", 4);
	public static const KITSUNE:KitsuneRace = new KitsuneRace(17);
	public static const HORSE:Race = new Race("Horse",18, "horseScore", 7);
	public static const UNICORN:Race = new Race("Unicorn",19,"unicornScore", 8);
	public static const CENTAUR:Race = new Race("Centaur",20, "centaurScore", 8);
	public static const MINOTAUR:Race = new Race("Minotaur",21,"minotaurScore", 10);
	public static const COW:Race = new Race("Cow",22,"cowScore", 10);
	public static const SANDTRAP:Race = new Race("SANDTRAP",23,"sandTrapScore", 5);
	public static const BEE:Race = new Race("Bee",24,"beeScore", 17);
	public static const GOBLIN:GoblinRace = new GoblinRace(25);
	public static const DEMON:Race = new Race("Demon",26,"demonScore", 11);
	public static const DEVIL:Race = new Race("Devil",27,"devilkinScore", 11);
	public static const SHARK:Race = new Race("Shark",28, "sharkScore", 10);
	public static const ORCA:Race = new Race("Orca",29, "orcaScore", 14);
	public static const OOMUKADE:Race = new Race("Oomukade",30, "oomukadeScore", 15);
	public static const ONI:Race = new Race("Oni",31, "oniScore", 12);
	public static const ELF:Race = new Race("Elf",32, "elfScore", 11);
	public static const ORC:Race = new Race("Orc",33, "orcScore", 11);
	public static const RAIJU:Race = new Race("Raiju",34, "raijuScore", 10);
	public static const THUNDERBIRD:Race = new Race("Thunderbird",35, "thunderbirdScore", 16);
	public static const BUNNY:Race = new Race("Bunny",36, "bunnyScore", 10);
	public static const HARPY:Race = new Race("Harpy",37, "harpyScore", 8);
	public static const SPIDER:Race = new Race("Spider",38, "spiderScore", 7);
	public static const KANGAROO:Race = new Race("Kangaroo",39, "kangaScore", 4);
	public static const MOUSE:Race = new Race("Mouse and hinezumi",40,"mouseScore", 8);
	public static const SCORPION:Race = new Race("Scorpion",41, "scorpionScore", 4);
	public static const MANTIS:Race = new Race("Mantis",42, "mantisScore", 12);
	public static const SALAMANDER:Race = new Race("Salamander",43, "salamanderScore", 7);
	public static const CAVEWYRM:Race = new Race("Cave wyrm",44, "cavewyrmScore", 10);
	public static const NAGA:Race = new Race("Naga",45, "nagaScore", 8);
	public static const GORGON:Race = new Race("Gorgon",46, "gorgonScore", 11);
	public static const VOUIVRE:Race = new Race("Vouivre",47, "vouivreScore", 11);
	public static const COUATL:Race = new Race("Couatl",48, "couatlScore", 11);
	public static const HYDRA:Race = new Race("Hydra",49, "hydraScore", 14);
	public static const FIRESNAILS:Race = new Race("Fire snails",50, "firesnailScore", 15);
	public static const PHOENIX:Race = new Race("Phoenix",51, "phoenixScore", 10);
	public static const SCYLLA:Race = new Race("Scylla",52, "scyllaScore", 7);
	public static const PLANT:Race = new Race("Plant",53, "plantScore", 4);
	public static const ALRAUNE:Race = new Race("Alraune",54, "alrauneScore", 13);
	public static const YGGDRASIL:Race = new Race("Yggdrassil",55, "yggdrasilScore", 10);
	public static const PIG:Race = new Race("Pig",56, "pigScore", 10);
	public static const SATYR:SatyrRace                    = new SatyrRace(57);
	public static const RHINO:RhinoRace                    = new RhinoRace(58);
	public static const ECHIDNA:EchidnaRace                = new EchidnaRace(59);
	public static const DEER:DeerRace                      = new DeerRace(60);
	public static const MANTICORE:ManticoreRace            = new ManticoreRace(61);
	public static const REDPANDA:RedPandaRace              = new RedPandaRace(62);
	public static const BEARANDPANDA:BearRace              = new BearRace(63);
	public static const SIREN:SirenRace                    = new SirenRace(64);
	public static const YETI:YetiRace                      = new YetiRace(65);
	public static const YUKIONNA:YukiOnnaRace              = new YukiOnnaRace(66);
	public static const BAT:BatRace                        = new BatRace(67);
	public static const VAMPIRE:VampireRace                = new VampireRace(68);
	public static const JABBERWOCKY:JabberwockyRace        = new JabberwockyRace(69);
	public static const AVIAN:AvianRace                    = new AvianRace(70);
	public static const GARGOYLE:GargoyleRace              = new GargoyleRace(71);
	public static const SLIME:SlimeRace                    = new SlimeRace(72);
	public static const MAGMASLIME:MagmaSlimeRace          = new MagmaSlimeRace(73);
	public static const DARKSLIME:DarkSlimeRace            = new DarkSlimeRace(74);
	public static const JIANGSHI:JiangshiRace              = new JiangshiRace(75);
	public static const POLTERGEIST:PoltergeistRace        = new PoltergeistRace(76);
	public static const BANSHEE:BansheeRace                = new BansheeRace(77);
	public static const MELKIE:MelkieRace                  = new MelkieRace(78);
	public static const EASTERBUNNY:EasterBunnyRace        = new EasterBunnyRace(79);
	public static const CENTIPEDE:CentipedeRace            = new CentipedeRace(80);
	public static const FROSTWYRM:FrostWyrmRace            = new FrostWyrmRace(81);
	public static const CANCER:CancerRace                  = new CancerRace(82);
	public static const USHIONNA:UshiOniRace               = new UshiOniRace(83);
	public static const FAIRY:FairyScore                   = new FairyScore(84);
	public static const GREMLIN:GremlinRace                = new GremlinRace(85);
	public static const KAMAITACHI:KamaitachiRace          = new KamaitachiRace(86);
	public static const GAZER:GazerRace                    = new GazerRace(87);
	public static const RATATOSKR:RatatoskrRace            = new RatatoskrRace(88);
	public static const WENDIGO:WendigoRace                = new WendigoRace(89);
	public static const TROLL:TrollRace                    = new TrollRace(90);
	public static const ATLACH_NACHA:AtlachNachaRace       = new AtlachNachaRace(91);
	public static const WOODELF:WoodElfRace                = new WoodElfRace(92);
	public static const SEA_DRAGON:SeaDragonRace           = new SeaDragonRace(93);
	public static const FMINDBREAKER:FemaleMindbreakerRace = new FemaleMindbreakerRace(94);
	public static const MMINDBREAKER:MaleMindbreakerRace   = new MaleMindbreakerRace(95);
	public static const ELEMENTALFUSION:Race               = new Race("Elemental Fusion", 96, "fusedElementalScore", 5);
	public static const GRYPHON:GryphonRace                = new GryphonRace(97);
	public static const PEACOCK:PeacockRace                = new PeacockRace(98);
	public static const ANGEL:AngelRace                    = new AngelRace(99);
	public static const APOPHIS:ApophisRace                = new ApophisRace(100);
	public static const CYCLOP:CyclopRace                  = new CyclopRace(101);
	public static const ALICORN:AlicornRace                = new AlicornRace(102);
	
	// Racial groups
	public static const FelineRaces:/*Race*/Array = [
			CAT, NEKOMATA, DISPLACERBEAST, HELLCAT, CHESHIRE, SPHINX
	];
	
	function Races() {
	}
	
	public static function load():void {
		RaceTierBuilder.ensureEndCalled();
		
		Race.AllEnabledRaces = Race.AllRacesWithDisabled.filter(
				function(e:Race,...rest:Array):Boolean {
					return !e.disabled;
				});
		Race.AllVisibleRaces = Race.AllRacesWithDisabled.filter(
				function(e:Race,...rest:Array):Boolean {
					return !e.disabled && !e.hidden;
				});
		Race.AllRacesByName = Race.AllVisibleRaces.slice().sortOn("name");
	}
}
}
