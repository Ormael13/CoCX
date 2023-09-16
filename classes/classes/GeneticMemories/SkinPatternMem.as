package classes.GeneticMemories {
  import classes.BaseContent;
  import classes.StatusEffects;
  import classes.BodyParts.*;
  import classes.BodyParts.Skin;
	import classes.internals.EnumValue;
	import classes.Transformations.Transformation;
	import classes.CoC;

  public class SkinPatternMem extends BaseContent {
	/**
	 * Entry properties:
	 * - id: the identificator of the Metamorph inside GeneticStorage
	 * - name: how the Metamorph is referred to in displayed texts
	 * - cost: how much SF it costs to metamorph this part (is discounted automatically in Metamorph.as, do not alter the player's SF in metamorphFunc)
	 * - title: name displayed on the metamorph button
	 * - unlockText: additional text displayed when Metamorph is unlocked
	 * - transformation: TF object that refers to what the metamorph does
	 *
	 * Optional properties:
	 * - info: additional text to be shown underneath the Metamorph cost in the menu when hovering over a button
	 * - lockedInfo: additional text to be shown on *locked* Metamorphs when hovering over a button
	 * - permCost: how many Ascension Perk Points it costs to permanentize this Metamorph, defaults to 5 if not added
	 * - permReq: the ID of another Metamorph which must be permanentized first before the current one can be bought

	 * Template:

		public static const [NAME HERE]:int = [ID HERE];
		EnumValue.add(Memories, [NAME HERE], "[NAME HERE]", {
			id: [Name Saved in GeneticStorage],
			name: [Name Displayed in Texts],
			cost: [Cost Here],
			title: [Race Here],
			unlockText: [Text Displayed On Unlocking Metamorph Here],
			transformation: function(): Transformation {
				return CoC.instance.transformations.[TF Object from TransformationLib];
			}
		});

	 */

    public static var Memories:/*EnumValue*/ Array = [];
	  private static var _partid:int = 0;

		public static const NONE:int = _partid++;
		EnumValue.add(Memories, NONE, "NONE", {
			id: "Unlocked Metamorph",
			name: "No Skin Pattern",
			cost: 500,
			title: "None",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternNone;
			}
		});

		public static const MAGICAL:int = _partid++;
		EnumValue.add(Memories, MAGICAL, "MAGICAL", {
			id: "Kitsune Skin Pattern",
			name: "Runic Kitsune Tattoos",
			cost: 100,
			title: "Kitsune",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternKitsune
			}
		});

		public static const PATTERN_VENOMOUS_MARKINGS:int = _partid++;
		EnumValue.add(Memories, PATTERN_VENOMOUS_MARKINGS, "PATTERN_VENOMOUS_MARKINGS", {
			id: "VenomousMarkings Pattern",
			name: "VenomousMarkings Pattern",
			cost: 100,
			title: "VenomousMarkings",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternVenomousMarkings
			}
		});

		public static const BATTLE:int = _partid++;
		EnumValue.add(Memories, BATTLE, "BATTLE", {
			id: "Oni Skin Pattern",
			name: "Oni Battle Tattoos",
			cost: 100,
			title: "Oni",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOni
			}
		});

		public static const LIGHTNING_SHAPED:int = _partid++;
		EnumValue.add(Memories, LIGHTNING_SHAPED, "LIGHTNING_SHAPED", {
			id: "Raiju Skin Pattern",
			name: "Lightning-shaped Raiju Tattoos",
			cost: 100,
			title: "Raiju",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternRaiju
			}
		});

		public static const SCAR_SHAPED:int = _partid++;
		EnumValue.add(Memories, SCAR_SHAPED, "SCAR_SHAPED", {
			id: "Orc Skin Pattern",
			name: "Scar-shaped Orc Tattoos",
			cost: 100,
			title: "Orc",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOrc
			}
		});

		public static const OIL:int = _partid++;
		EnumValue.add(Memories, OIL, "OIL", {
			id: "Gazer Skin Pattern",
			name: "Drips black fluids",
			cost: 100,
			title: "Gazer",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternOil
			}
		});

		public static const BEE_STRIPES:int = _partid++;
		EnumValue.add(Memories, BEE_STRIPES, "BEE_STRIPES", {
			id: "Bee Skin Pattern",
			name: "Bee Stripes",
			cost: 200,
			title: "Bee Stripes",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternBeeStripes
			},
			info: "Includes Chitin skin"
		});

		public static const SHARK_STRIPES:int = _partid++;
		EnumValue.add(Memories, SHARK_STRIPES, "SHARK_STRIPES", {
		  id: "Tiger Shark Skin Pattern",
		  name: "Shark Stripes",
		  cost: 200,
		  title: "Shark Stripes",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.SkinPatternTigerSharkStripes
		  },
		  info: "Includes Aqua Scales skin"
		});

		public static const ORCA_UNDERBODY:int = _partid++;
		EnumValue.add(Memories, ORCA_UNDERBODY, "ORCA_UNDERBODY", {
		  id: "Orca Skin Pattern",
		  name: "Orca Underbody",
		  cost: 100,
		  title: "Orca",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.SkinPatternOrca
		  }
		});

		public static const SEA_DRAGON_UNDERBODY:int = _partid++;
		EnumValue.add(Memories, SEA_DRAGON_UNDERBODY, "SEA_DRAGON_UNDERBODY", {
		  id: "Sea Dragon Skin Pattern",
		  name: "Sea Dragon Underbody",
		  cost: 100,
		  title: "Sea Dragon",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.SkinPatternSeaDragon
		  }
		});

		public static const SCAR_WINDSWEPT:int = _partid++;
		EnumValue.add(Memories, SCAR_WINDSWEPT, "SCAR_WINDSWEPT", {
		  id: "Windswept Scar",
		  name: "Windswept Scar",
		  cost: 100,
		  title: "Kamaitachi",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.SkinPatternScarWindswept
		  }
		});

		public static const BLACK_WHITE_VEINS:int = _partid++;
		EnumValue.add(Memories, BLACK_WHITE_VEINS, "BLACK_WHITE_VEINS", {
		  id: "Black & White Veins",
		  name: "Black & White Veins",
		  cost: 100,
		  title: "Black & White Veins",
		  transformation: function(): Transformation {
			  return CoC.instance.transformations.SkinPatternWhiteBlackVeins
		  }
		});

		public static const GLYPH:int = _partid++;
		EnumValue.add(Memories, GLYPH, "GLYPH", {
			id: "Anubis Glyph Pattern",
			name: "Glyph Tattoos",
			cost: 100,
			title: "Anubis",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternAnubis
			}
		});

		public static const BIOLUMINESCENCE:int = _partid++;
		EnumValue.add(Memories, BIOLUMINESCENCE, "BIOLUMINESCENCE", {
			id: "Bioluminescent Patterns",
			name: "Bioluminescent Patterns",
			cost: 100,
			title: "Bioluminescence",
			transformation: function(): Transformation {
				return CoC.instance.transformations.SkinPatternBioluminescence
			}
		});

		public static function getMemory(memoryId: Number): * {
			return Memories[memoryId] || Memories[0];
		}
  }
}
