package classes.BodyParts {
import classes.internals.EnumValue;

public class Horns extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "DEMON")
	 * - name: human-readable default name, ("non-existant", "demon")
	 */
	public static var Types:/*EnumValue*/Array = [];
	
	public static const NONE:int                     = 0;
	EnumValue.add(Types, NONE, "NONE", {name:"non-existant"});
	public static const DEMON:int                    = 1;
	EnumValue.add(Types, DEMON, "DEMON", {name:"demon"});
	public static const COW_MINOTAUR:int             = 2;
	EnumValue.add(Types, COW_MINOTAUR, "COW_MINOTAUR", {name:"cow", Gore: true});
	public static const DRACONIC_X2:int              = 3;
	EnumValue.add(Types, DRACONIC_X2, "DRACONIC_X2", {name:"2 draconic"});
	public static const DRACONIC_X4_12_INCH_LONG:int = 4;
	EnumValue.add(Types, DRACONIC_X4_12_INCH_LONG, "DRACONIC_X4_12_INCH_LONG", {name:"four 12\" long draconic"});
	public static const ANTLERS:int                  = 5;
	EnumValue.add(Types, ANTLERS, "ANTLERS", {name:"deer", Gore: true});
	public static const GOAT:int                     = 6;
	EnumValue.add(Types, GOAT, "GOAT", {name:"goat", Gore: true});
	public static const UNICORN:int                  = 7;
	EnumValue.add(Types, UNICORN, "UNICORN", {name:"unicorn", Gore: true});
	public static const RHINO:int                    = 8;
	EnumValue.add(Types, RHINO, "RHINO", {name:"rhino", Gore: true});
	public static const OAK:int                      = 9;
	EnumValue.add(Types, OAK, "OAK", {name:"oak"});
	public static const GARGOYLE:int                 = 10;
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {name:"gargoyle"});
	public static const ORCHID:int                   = 11;
	EnumValue.add(Types, ORCHID, "ORCHID", {name:"orchid"});
	public static const ONI_X2:int                   = 12;
	EnumValue.add(Types, ONI_X2, "ONI_X2", {name:"2 oni"});
	public static const ONI:int                      = 13;
	EnumValue.add(Types, ONI, "ONI", {name:"1 oni"});
	public static const BICORN:int                   = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, BICORN, "BICORN", {name:"bicorn", Gore: true});
	public static const GHOSTLY_WISPS:int            = 15;
	EnumValue.add(Types, GHOSTLY_WISPS, "GHOSTLY_WISPS", {name:"ghostly wisps"});
	public static const SPELL_TAG:int           	 = 16;
	EnumValue.add(Types, SPELL_TAG, "SPELL_TAG", {name:"spell tag"});
	public static const GOATQUAD:int                 = 17;
	EnumValue.add(Types, GOATQUAD, "GOATQUAD", {name:"4 goat", Gore: true});
	public static const KRAKEN:int              	 = 18;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {name:"kraken"});
	public static const FROSTWYRM:int              	 = 19;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {name:"frostwyrm", Gore: true});
	public static const USHI_ONI_ONNA:int            = 20;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {name:"ushi-oni", Gore: true});
	public static const SEADRAGON:int            = 21;
	EnumValue.add(Types, SEADRAGON, "SEADRAGON", {name:"sea dragon"});
	
	public function Horns() {
		super(null, null);
	}
	public var count:int = 0;
}
}
