package classes {
public class Race {
    public static const ALL_RACES:/*Race*/Array = [];

    public static const HUMAN:Race = new Race("Human",1);
    public static const CAT:Race = new Race("Cat",2);
    public static const NEKOMATA:Race = new Race("Nekomata",3);
    public static const CHESHIRE:Race = new Race("Cheshire",4);
    public static const HELLCAT:Race = new Race("Hellcat",5);
    public static const DISPLACERBEAST:Race = new Race("Displacer beast",6);
    public static const SPHINX:Race = new Race("Sphinx",7);
    public static const LIZARD:Race = new Race("Lizard",8);
    public static const DRAGON:Race = new Race("Dragon",9);
    public static const DRAGONNE:Race = new Race("Dragonne",10);
    public static const RACCOON:Race = new Race("Raccoon",11);
    public static const DOG:Race = new Race("Dog",12);
    public static const WOLF:Race = new Race("Wolf",13);
    public static const WEREWOLF:Race = new Race("Werewolf",14);
    public static const FOX:Race = new Race("Fox",15);
    public static const FERRET:Race = new Race("Ferret",16);
    public static const KITSUNE:Race = new Race("Kitsune",17);
    public static const HORSE:Race = new Race("Horse",18);
    public static const UNICORN:Race = new Race("Unicorn and its variants",19);
    public static const CENTAUR:Race = new Race("Centaur",20);
    public static const MINOTAUR:Race = new Race("Minotaur",21);
    public static const COW:Race = new Race("Cow",22);
    public static const SANDTRAP:Race = new Race("SANDTRAP",23);
    public static const BEE:Race = new Race("Bee",24);
    public static const GOBLIN:Race = new Race("Goblin",25);
    public static const DEMON:Race = new Race("Demon",26);
    public static const DEVIL:Race = new Race("Devil",27);
    public static const SHARK:Race = new Race("Shark",28);
    public static const ORCA:Race = new Race("Orca",29);
    public static const OOMUKADE:Race = new Race("Oomukade",30);
    public static const ONI:Race = new Race("Oni",31);
    public static const ELF:Race = new Race("Elf",32);
    public static const ORC:Race = new Race("Orc",33);
    public static const RAIJU:Race = new Race("Raiju",34);
    public static const THUNDERBIRD:Race = new Race("Thunderbird",35);
    public static const BUNNY:Race = new Race("Bunny",36);
    public static const HARPY:Race = new Race("Harpy",37);
    public static const SPIDER:Race = new Race("Spider",38);
    public static const KANGAROO:Race = new Race("Kangaroo",39);
    public static const MOUSE:Race = new Race("Mouse and hinezumi",40);
    public static const SCORPION:Race = new Race("Scorpion",41);
    public static const MANTIS:Race = new Race("Mantis",42);
    public static const SALAMANDER:Race = new Race("Salamander",43);
    public static const CAVEWYRM:Race = new Race("Cave wyrm",44);
    public static const NAGA:Race = new Race("Naga",45);
    public static const GORGON:Race = new Race("Gorgon",46);
    public static const VOUIVRE:Race = new Race("Vouivre",47);
    public static const COUATL:Race = new Race("Couatl",48);
    public static const HYDRA:Race = new Race("Hydra",49);
    public static const FIRESNAILS:Race = new Race("Fire snails",50);
    public static const PHOENIX:Race = new Race("Phoenix",51);
    public static const SCYLLA:Race = new Race("Scylla",52);
    public static const PLANT:Race = new Race("Plant",53);
    public static const ALRAUNE:Race = new Race("Alraune",54);
    public static const YGGDRASIL:Race = new Race("Yggdrassil",55);
    public static const PIG:Race = new Race("Pig",56);
    public static const SATYR:Race = new Race("Satyr",57);
    public static const RHINO:Race = new Race("Rhino",58);
    public static const ECHIDNA:Race = new Race("Echnida",59);
    public static const DEER:Race = new Race("Deer",60);
    public static const MANTICORE:Race = new Race("Manticore",61);
    public static const REDPANDA:Race = new Race("Red panda",62);
    public static const BEARANDPANDA:Race = new Race("Bear and Panda",63);
    public static const SIREN:Race = new Race("Siren",64);
    public static const YETI:Race = new Race("Yeti",65);
    public static const YUKIONNA:Race = new Race("Yuki Onna",66);
    public static const BAT:Race = new Race("Bat",67);
    public static const VAMPIRE:Race = new Race("Vampire",68);
    public static const JABBERWOCKY:Race = new Race("Jabberwocky",69);
    public static const AVIAN:Race = new Race("Avian",70);
    public static const GARGOYLE:Race = new Race("Gargoyle",71);
    public static const SLIME:Race = new Race("Slime",72);
    public static const MAGMASLIME:Race = new Race("Magma slime",73);
    public static const DARKSLIME:Race = new Race("Dark slime",74);
    public static const JIANGSHI:Race = new Race("Jiangshi",75);
    public static const POLTERGEIST:Race = new Race("Poltergeist",76);
    public static const BANSHEE:Race = new Race("Banshee",77);
    public static const MELKIE:Race = new Race("Yuki Onna",78);
    public static const EASTERBUNNY:Race = new Race("Easter Bunny",79);
    public static const CENTIPEDE:Race = new Race("Centipede",80);

    public var name:String;
    public var id:int;

    function Race(_name:String, _id:int) {
        this.name = _name;
        this.id = _id;
        ALL_RACES[_id] = this;
    }

    }
}
