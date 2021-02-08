package classes.BodyParts {
import classes.internals.EnumValue;

public class Arms extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "HARPY")
	 * - name: human-readable default name, ("human", "harpy")
	 * - claw:
	 * - scythe:
	 * - armSlam:
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN:int			= 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {name:"human"});
	public static const HARPY:int			= 1;
	EnumValue.add(Types, HARPY, "HARPY", {name:"harpy"});
	public static const SPIDER:int			= 2;
	EnumValue.add(Types, SPIDER, "SPIDER", {name:"spider"});
	public static const MANTIS:int			= 3;
	EnumValue.add(Types, MANTIS, "MANTIS", {name:"mantis", scythe: true});
	public static const BEE:int				= 4;
	EnumValue.add(Types, BEE, "BEE", {name:"bee"});
	public static const SALAMANDER:int		= 5;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {name:"salamander", claw: true});
	public static const PHOENIX:int			= 6;
	EnumValue.add(Types, PHOENIX, "PHOENIX", {name:"phoenix"});
	public static const PLANT:int			= 7;
	EnumValue.add(Types, PLANT, "PLANT", {name:"plant"});
	public static const SHARK:int			= 8;
	EnumValue.add(Types, SHARK, "SHARK", {name:"shark"});
	public static const GARGOYLE:int		= 9;
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {name:"gargoyle", armSlam: true});
	public static const WOLF:int			= 10;
	EnumValue.add(Types, WOLF, "WOLF", {name:"wolf", claw: true, canPounce: true});
	public static const LION:int			= 11;
	EnumValue.add(Types, LION, "LION", {name:"lion", claw: true, canPounce: true});
	public static const KITSUNE:int			= 12;
	EnumValue.add(Types, KITSUNE, "KITSUNE", {name:"kitsune", claw: true});
	public static const FOX:int				= 13;
	EnumValue.add(Types, FOX, "FOX", {name:"fox"});
	public static const LIZARD:int			= 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, LIZARD, "LIZARD", {name:"lizard", claw: true});
	public static const DRAGON:int			= 15;
	EnumValue.add(Types, DRAGON, "DRAGON", {name:"dragon", claw: true});
	public static const YETI:int			= 16;
	EnumValue.add(Types, YETI, "YETI", {name:"yeti", armSlam: true});
	public static const ORCA:int			= 17;
	EnumValue.add(Types, ORCA, "ORCA", {name:"orca"});
	public static const PLANT2:int			= 18;
	EnumValue.add(Types, PLANT2, "PLANT2", {name:"tentacle-covered"});
	public static const DEVIL:int			= 19;
	EnumValue.add(Types, DEVIL, "DEVIL", {name:"devil", claw: true});
	public static const ONI:int				= 20;
	EnumValue.add(Types, ONI, "ONI", {name:"oni", armSlam: true});
	public static const ELF:int				= 21;
	EnumValue.add(Types, ELF, "ELF", {name:"elf"});
	public static const RAIJU:int			= 22;
	EnumValue.add(Types, RAIJU, "RAIJU", {name:"raiju", claw: true});
	public static const RED_PANDA:int		= 23;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {name:"red-panda", claw: true});
	public static const GARGOYLE_2:int		= 24;
	EnumValue.add(Types, GARGOYLE_2, "GARGOYLE_2", {name:"gargoyle", claw: true});
	public static const CAT:int				= 25;
	EnumValue.add(Types, CAT, "CAT", {name:"cat", claw: true, canPounce: true});
	public static const AVIAN:int			= 26;
	EnumValue.add(Types, AVIAN, "AVIAN", {name:"avian"});
	public static const GRYPHON:int			= 27;
	EnumValue.add(Types, GRYPHON, "GRYPHON", {name:"gryphon", claw: true});
	public static const SPHINX:int			= 28;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, SPHINX, "SPHINX", {name:"sphinx", claw: true});
	public static const PIG:int				= 29;
	EnumValue.add(Types, PIG, "PIG", {name:"pig"});
	public static const BOAR:int			= 30;
	EnumValue.add(Types, BOAR, "BOAR", {name:"boar"});
	public static const ORC:int				= 31;
	EnumValue.add(Types, ORC, "ORC", {name:"orc"});
	public static const DISPLACER:int		= 32;
	EnumValue.add(Types, DISPLACER, "DISPLACER", {name:"displacer", claw: true, canPounce: true});
	public static const CAVE_WYRM:int		= 33;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {name:"cave wyrm", claw: true});
	public static const HINEZUMI:int		= 34;
	EnumValue.add(Types, HINEZUMI, "HINEZUMI", {name:"hinezumi", armSlam: true});
	public static const BEAR:int			= 35;
	EnumValue.add(Types, BEAR, "BEAR", {name:"bear", claw: true});
	public static const GOO:int				= 36;
	EnumValue.add(Types, GOO, "GOO", {name:"goo"});
	public static const HYDRA:int			= 37;
	EnumValue.add(Types, HYDRA, "HYDRA", {name:"hydra", claw: true});
	public static const GHOST:int			= 38;
	EnumValue.add(Types, GHOST, "GHOST", {name:"ghost"});
	public static const JIANGSHI:int		= 39;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {name:"jiangshi", claw: true});
	public static const RAIJU_2:int			= 40;
	EnumValue.add(Types, RAIJU_2, "RAIJU_2", {name:"raiju paws", claw: true});
	public static const YUKI_ONNA:int		= 41;
	EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {name:"yuki onna"});
	public static const MELKIE:int			= 42;//button 0 on 4th page of metamorph
	EnumValue.add(Types, MELKIE, "MELKIE", {name:"melkie", claw: true});
	public static const CENTIPEDE:int		= 43;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {name:"centipede"});
	public static const KRAKEN:int			= 44;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {name:"kraken"});
	public static const FROSTWYRM:int		= 45;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {name:"frostwyrm", claw: true});
	public static const CANCER:int			= 46;
	EnumValue.add(Types, CANCER, "CANCER", {name:"cancer"});
	public static const USHI_ONI_ONNA:int	= 47;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {name:"ushi-oni"});
	public static const KAMAITACHI:int		= 48;
	EnumValue.add(Types, KAMAITACHI, "KAMAITACHI", {name:"kamaitachi", scythe: true});
	public static const GAZER:int			= 49;
	EnumValue.add(Types, GAZER, "GAZER", {name:"gazer"});
	public static const RACCOON:int			= 50;
	EnumValue.add(Types, RACCOON, "RACCOON", {name:"raccoon", claw: true});
	public static const WEASEL:int			= 51;
	EnumValue.add(Types, WEASEL, "WEASEL", {name:"weasel", claw: true});
	public static const SQUIRREL:int	    = 52;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {name:"squirrel", claw: true});
	public static const WENDIGO:int	    	= 53;
	EnumValue.add(Types, WENDIGO, "WENDIGO", {name:"wendigo", claw: true});

	public function Arms() {
		super(null, null);
	}
}
}
