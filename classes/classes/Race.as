package classes {
import flash.utils.getAliasName;

public class Race {
    public static const ALL_RACES:/*Race*/Array = [];

    public static const HUMAN:Race = new Race("Human",1, "humanScore");
    public static const CAT:Race = new Race("Cat",2,"catScore");
    public static const NEKOMATA:Race = new Race("Nekomata",3,"nekomataScore");
    public static const CHESHIRE:Race = new Race("Cheshire",4, "cheshireScore");
    public static const HELLCAT:Race = new Race("Hellcat",5, "hellcatScore");
    public static const DISPLACERBEAST:Race = new Race("Displacer beast",6, "displacerbeastScore");
    public static const SPHINX:Race = new Race("Sphinx",7, "sphinxScore");
    public static const LIZARD:Race = new Race("Lizard",8, "lizardScore");
    public static const DRAGON:Race = new Race("Dragon",9, "dragonScore");
    public static const DRAGONNE:Race = new Race("Dragonne",10, "dragonneScore");
    public static const RACCOON:Race = new Race("Raccoon",11,"raccoonScore");
    public static const DOG:Race = new Race("Dog",12,"dogScore");
    public static const WOLF:Race = new Race("Wolf",13, "wolfScore");
    public static const WEREWOLF:Race = new Race("Werewolf",14, "werewolfScore");
    public static const FOX:Race = new Race("Fox",15,"foxScore");
    public static const FERRET:Race = new Race("Ferret",16,"ferretScore");
    public static const KITSUNE:Race = new Race("Kitsune",17, "kitsuneScore");
    public static const HORSE:Race = new Race("Horse",18, "horseScore");
    public static const UNICORN:Race = new Race("Unicorn and its variants",19,"unicornScore");
    public static const CENTAUR:Race = new Race("Centaur",20, "centaurScore");
    public static const MINOTAUR:Race = new Race("Minotaur",21,"minotaurScore");
    public static const COW:Race = new Race("Cow",22,"cowScore");
    public static const SANDTRAP:Race = new Race("SANDTRAP",23,"sandTrapScore");
    public static const BEE:Race = new Race("Bee",24,"beeScore");
    public static const GOBLIN:Race = new Race("Goblin",25, "goblinScore");
    public static const DEMON:Race = new Race("Demon",26,"demonScore");
    public static const DEVIL:Race = new Race("Devil",27,"devilkinScore");
    public static const SHARK:Race = new Race("Shark",28, "sharkScore");
    public static const ORCA:Race = new Race("Orca",29, "orcaScore");
    public static const OOMUKADE:Race = new Race("Oomukade",30, "oomukadeScore");
    public static const ONI:Race = new Race("Oni",31, "oniScore");
    public static const ELF:Race = new Race("Elf",32, "elfScore");
    public static const ORC:Race = new Race("Orc",33, "orcScore");
    public static const RAIJU:Race = new Race("Raiju",34, "raijuScore");
    public static const THUNDERBIRD:Race = new Race("Thunderbird",35, "thunderbirdScore");
    public static const BUNNY:Race = new Race("Bunny",36, "bunnyScore");
    public static const HARPY:Race = new Race("Harpy",37, "harpyScore");
    public static const SPIDER:Race = new Race("Spider",38, "spiderScore");
    public static const KANGAROO:Race = new Race("Kangaroo",39, "kangaScore");
    public static const MOUSE:Race = new Race("Mouse and hinezumi",40,"mouseScore");
    public static const SCORPION:Race = new Race("Scorpion",41, "scorpionScore");
    public static const MANTIS:Race = new Race("Mantis",42, "mantisScore");
    public static const SALAMANDER:Race = new Race("Salamander",43, "salamanderScore");
    public static const CAVEWYRM:Race = new Race("Cave wyrm",44, "cavewyrmScore");
    public static const NAGA:Race = new Race("Naga",45, "nagaScore");
    public static const GORGON:Race = new Race("Gorgon",46, "gorgonScore");
    public static const VOUIVRE:Race = new Race("Vouivre",47, "vouivreScore");
    public static const COUATL:Race = new Race("Couatl",48, "couatlScore");
    public static const HYDRA:Race = new Race("Hydra",49, "hydraScore");
    public static const FIRESNAILS:Race = new Race("Fire snails",50, "firesnailScore");
    public static const PHOENIX:Race = new Race("Phoenix",51, "phoenixScore");
    public static const SCYLLA:Race = new Race("Scylla",52, "scyllaScore");
    public static const PLANT:Race = new Race("Plant",53, "plantScore");
    public static const ALRAUNE:Race = new Race("Alraune",54, "alrauneScore");
    public static const YGGDRASIL:Race = new Race("Yggdrassil",55, "yggdrasilScore");
    public static const PIG:Race = new Race("Pig",56, "pigScore");
    public static const SATYR:Race = new Race("Satyr",57, "satyrScore");
    public static const RHINO:Race = new Race("Rhino",58, "rhinoScore");
    public static const ECHIDNA:Race = new Race("Echnida",59, "echidnaScore");
    public static const DEER:Race = new Race("Deer",60, "deerScore");
    public static const MANTICORE:Race = new Race("Manticore",61, "manticoreScore");
    public static const REDPANDA:Race = new Race("Red panda",62, "redpandaScore");
    public static const BEARANDPANDA:Race = new Race("Bear and Panda",63,"bearpandaScore");
    public static const SIREN:Race = new Race("Siren",64, "sirenScore");
    public static const YETI:Race = new Race("Yeti",65, "yetiScore");
    public static const YUKIONNA:Race = new Race("Yuki Onna",66, "yukiOnnaScore");
    public static const BAT:Race = new Race("Bat",67, "batScore");
    public static const VAMPIRE:Race = new Race("Vampire",68, "vampireScore");
    public static const JABBERWOCKY:Race = new Race("Jabberwocky",69, "jabberwockyScore");
    public static const AVIAN:Race = new Race("Avian",70, "avianScore");
    public static const GARGOYLE:Race = new Race("Gargoyle",71, "gargoyleScore");
    public static const SLIME:Race = new Race("Slime",72, "gooScore");
    public static const MAGMASLIME:Race = new Race("Magma slime",73, "magmagooScore");
    public static const DARKSLIME:Race = new Race("Dark slime",74, "darkgooScore");
    public static const JIANGSHI:Race = new Race("Jiangshi",75,"jiangshiScore");
    public static const POLTERGEIST:Race = new Race("Poltergeist",76, "poltergeistScore");
    public static const BANSHEE:Race = new Race("Banshee",77, "bansheeScore");
    public static const MELKIE:Race = new Race("Melkie",78, "melkieScore");
    public static const EASTERBUNNY:Race = new Race("Easter Bunny",79, "easterbunnyScore");
    public static const CENTIPEDE:Race = new Race("Centipede",80, "centipedeScore");
    public static const FROSTWYRM:Race = new Race("Frost Wyrm",81, "frostWyrmScore");
    public static const CANCER:Race = new Race("Cancer",82, "cancerScore");
    public static const USHIONNA:Race = new Race("Ushi-Onna",83, "ushionnaScore");
    public static const FAIRY:Race = new Race("Fairy",84,"fairyScore");
    public static const GREMLIN:Race = new Race("Gremlin",85,"gremlinScore");
    public static const KAMAITACHI:Race = new Race("Kamaitachi",86, "kamaitachiScore");
    public static const GAZER:Race = new Race("Gazer",87, "gazerScore");
    public static const RATATOSKR:Race = new Race("Ratatoskr",88, "ratatoskrScore");
    public static const WENDIGO:Race = new Race("Wendigo",89, "wendigoScore");
    public static const TROLL:Race        = new Race("Troll",90, "trollScore");
    public static const ATLACH_NACHA:Race = new Race("Atlach Nacha", 91, "atlachNachaScore");
    public static const WOODELF:Race      = new Race("Wood Elf",92, "woodElfScore");
    public static const SEADRAGON:Race = new Race("Sea Dragon",93, "leviathanScore");
    
    public var name:String;
    public var id:int;
    private var playerFunctionName:String;
    
    /**
     * @param _name Display name of the race
     * @param _id Unique number id
     * @param _playerFunctionName Function in Player class that returns score for this race
     */
    function Race(_name:String, _id:int, _playerFunctionName: String) {
        this.name = _name;
        this.id = _id;
        this.playerFunctionName = _playerFunctionName;
        ALL_RACES[_id] = this;
        //ALL_RACES.sort(getAliasName.length)
    }
    
    public function score(player:Player):int {
        return player[playerFunctionName]();
    }

    }
}
