package classes {
import classes.BodyParts.*;
import classes.Races.*;

public class Races {
	
	private static const raceClass:Class = Race;
	
	public static const HUMAN:Race = new Race("Human",1, "humanScore", 1);
	public static const CAT:Race = new Race("Cat",2,"catScore", 8);
	public static const NEKOMATA:Race = new Race("Nekomata",3,"nekomataScore", 10);
	public static const CHESHIRE:Race = new Race("Cheshire",4, "cheshireScore", 11);
	public static const HELLCAT:Race = new Race("Hellcat",5, "hellcatScore", 10);
	public static const DISPLACERBEAST:Race = new Race("Displacer beast",6, "displacerbeastScore", 14);
	public static const SPHINX:Race = new Race("Sphinx",7, "sphinxScore", 14);
	public static const LIZARD:Race = new Race("Lizard",8, "lizardScore", 8);
	public static const DRAGON:Race = new DragonRace(9);
	public static const DRAGONNE:Race = new Race("Dragonne",10, "dragonneScore", 6);
	public static const RACCOON:Race = new Race("Raccoon",11,"raccoonScore", 8);
	public static const DOG:Race = new Race("Dog",12,"dogScore", 4);
	public static const WOLF: Race = new WolfRace(13);
	public static const WEREWOLF:Race = new Race("Werewolf",14, "werewolfScore", 12);
	public static const FOX:Race = new Race("Fox",15,"foxScore", 7);
	public static const FERRET:Race = new Race("Ferret",16,"ferretScore", 4);
	public static const KITSUNE:Race = new KitsuneRace(17);
	public static const HORSE:Race = new Race("Horse",18, "horseScore", 7);
	public static const UNICORN:Race = new Race("Unicorn",19,"unicornScore", 8);
	public static const CENTAUR:Race = new Race("Centaur",20, "centaurScore", 8);
	public static const MINOTAUR:Race = new Race("Minotaur",21,"minotaurScore", 10);
	public static const COW:Race = new Race("Cow",22,"cowScore", 10);
	public static const SANDTRAP:Race = new Race("SANDTRAP",23,"sandTrapScore", 5);
	public static const BEE:Race = new Race("Bee",24,"beeScore", 17);
	public static const GOBLIN: Race = new GoblinRace(25);
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
	public static const SATYR:Race = new Race("Satyr",57, "satyrScore", 4);
	public static const RHINO:Race = new Race("Rhino",58, "rhinoScore", 4);
	public static const ECHIDNA:Race = new Race("Echnida",59, "echidnaScore", 4);
	public static const DEER:Race = new Race("Deer",60, "deerScore", 4);
	public static const MANTICORE:Race = new Race("Manticore",61, "manticoreScore", 15);
	public static const REDPANDA:Race = new Race("Red panda",62, "redpandaScore", 8);
	public static const BEARANDPANDA:Race = new Race("Bear and Panda",63,"bearpandaScore", 10);
	public static const SIREN:Race = new Race("Siren",64, "sirenScore", 10);
	public static const YETI:Race = new Race("Yeti",65, "yetiScore", 14);
	public static const YUKIONNA:Race = new Race("Yuki Onna",66, "yukiOnnaScore", 14);
	public static const BAT:Race = new Race("Bat",67, "batScore", 10);
	public static const VAMPIRE:Race = new Race("Vampire",68, "vampireScore", 10);
	public static const JABBERWOCKY:Race = new Race("Jabberwocky",69, "jabberwockyScore", 10);
	public static const AVIAN:Race = new Race("Avian",70, "avianScore", 9);
	public static const GARGOYLE:Race = new Race("Gargoyle",71, "gargoyleScore", 22);
	public static const SLIME:Race = new Race("Slime",72, "gooScore", 11);
	public static const MAGMASLIME:Race = new Race("Magma slime",73, "magmagooScore", 13);
	public static const DARKSLIME:Race = new Race("Dark slime",74, "darkgooScore", 13);
	public static const JIANGSHI:Race = new JiangshiRace(75);
	public static const POLTERGEIST:Race = new Race("Poltergeist",76, "poltergeistScore", 6);
	public static const BANSHEE:Race = new Race("Banshee",77, "bansheeScore", 4);
	public static const MELKIE:Race = new Race("Melkie",78, "melkieScore", 18);
	public static const EASTERBUNNY:Race = new Race("Easter Bunny",79, "easterbunnyScore", 12);
	public static const CENTIPEDE:Race = new Race("Centipede",80, "centipedeScore", 8);
	public static const FROSTWYRM:Race = new Race("Frost Wyrm",81, "frostWyrmScore", 18);
	public static const CANCER:Race = new Race("Cancer",82, "cancerScore", 13);
	public static const USHIONNA:Race = new Race("Ushi-Onna",83, "ushionnaScore", 11);
	public static const FAIRY:Race = new Race("Fairy",84,"fairyScore", 23);
	public static const GREMLIN:Race = new Race("Gremlin",85,"gremlinScore", 15);
	public static const KAMAITACHI:Race = new Race("Kamaitachi",86, "kamaitachiScore", 14);
	public static const GAZER:Race = new Race("Gazer",87, "gazerScore", 14);
	public static const RATATOSKR:Race = new Race("Ratatoskr",88, "ratatoskrScore", 12);
	public static const WENDIGO:Race = new Race("Wendigo",89, "wendigoScore", 10);
	public static const TROLL:Race        = new Race("Troll",90, "trollScore", 10);
	public static const ATLACH_NACHA:Race = new Race("Atlach Nacha", 91, "atlachNachaScore", 10);
	public static const WOODELF:Race      = new Race("Wood Elf",92, "woodElfScore", 22);
	public static const SEA_DRAGON:Race = new Race("Sea Dragon",93, "leviathanScore", 20);
	public static const FMINDBREAKER:Race = new Race("Female Mind Breaker",94, "femaleMindbreakerScore", 20);
	public static const MMINDBREAKER:Race = new Race("Male Mind Breaker",95, "maleMindbreakerScore", 20);
	public static const ELEMENTALFUSION:Race = new Race("Elemental Fusion",96, "fusedElementalScore", 5);
	public static const GRYPHON:Race = new Race("Gryphon",97, "gryphonScore", 4);
	public static const PEACOCK:Race = new Race("Peacock",98, "peacockScore", 4);
	public static const ANGEL:Race = new Race("Angel",99, "angelScore", 11);
	public static const APOPHIS:Race = new Race("Apophis",100, "apophisScore", 23);
	public static const CYCLOP:Race = new Race("Cyclop",101, "cyclopScore", 12);
	public static const ALICORN:Race = new Race("Alicorn",102, "alicornScore", 8);
	
	Race.AllRacesByName = Race.AllRaces.slice()
										.filter(function(e:Race,...rest:Array):Boolean {
											return !!e
										})
										.sortOn("name");
	
	
	function Races() {
	}
}
}
