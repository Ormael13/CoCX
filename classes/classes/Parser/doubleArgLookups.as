
		// provides rubiLookups and arianLookups
		// note that these are only used in doubleArgLookups, not in Parser.as itself
		//
		// =!= NOTE: MUST BE IMPORTED BEFORE "./doubleArgLookups.as" =!=
		// 
		//Calls are now made through CoC.instance rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.BodyParts.Skin;
		import classes.CoC;
		include "./npcLookups.as";


		// PC ASCII Aspect lookups

		public var cockLookups:Object = // For subject: "cock"
		{
			"all"		: function(thisPtr:*):*{ return CoC.instance.player.multiCockDescriptLight(); },
			"each"		: function(thisPtr:*):*{ return CoC.instance.player.sMultiCockDesc(); },
			"one"		: function(thisPtr:*):*{ return CoC.instance.player.oMultiCockDesc(); },
			"largest"	: function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex()); },
			"biggest"	: function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex()); },
			"biggest2"	: function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex2()); },
			"biggest3"  : function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex3()); },
			"smallest"	: function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex()); },
			"smallest2" : function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex2()); },
			"longest"	: function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.longestCock()); },
			"shortest"	: function(thisPtr:*):*{ return CoC.instance.player.cockDescript(CoC.instance.player.shortestCockIndex()); }
		};


		public var cockHeadLookups:Object = // For subject: "cockHead"
		{
			"biggest"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex()); },
			"biggest2"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex2()); },
			"biggest3"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex3()); },
			"largest"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex()); },
			"smallest"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex()); },
			"smallest2"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex2()); },
			"longest"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.longestCock()); },			// the *head* of a cock has a length? Wut?
			"shortest"	: function(thisPtr:*):*{ return CoC.instance.player.cockHead(CoC.instance.player.shortestCockIndex()); }
		};

		public var monsterLookups:Object = {
			"a"							: function(thisPtr:*):* { return CoC.instance.monster.a; },
			"allbreasts"				: function(thisPtr:*):* { return CoC.instance.monster.allBreastsDescript(); },
			"alltits"				    : function(thisPtr:*):* { return CoC.instance.monster.allBreastsDescript(); },
			"armor"						: function(thisPtr:*):* { return CoC.instance.monster.armorName;},
			"armorname"					: function(thisPtr:*):* { return CoC.instance.monster.armorName;},
			"ass"						: function(thisPtr:*):* { return CoC.instance.monster.buttDescript();},
			"asshole"					: function(thisPtr:*):* { return CoC.instance.monster.assholeDescript(); },
			"balls"						: function(thisPtr:*):* { return CoC.instance.monster.ballsDescriptLight(); },
//			"bodytype"					: function(thisPtr:*):* { return CoC.instance.monster.bodyType(); },
			"boyfriend"					: function(thisPtr:*):* { return CoC.instance.monster.mf("boyfriend", "girlfriend"); },
			"breasts"					: function(thisPtr:*):* { return CoC.instance.monster.breastDescript(0); },
			"butt"						: function(thisPtr:*):* { return CoC.instance.monster.buttDescript();},
			"butthole"					: function(thisPtr:*):* { return CoC.instance.monster.assholeDescript();},
			"chest"						: function(thisPtr:*):* { return CoC.instance.monster.chestDesc(); },
			"claws"						: function(thisPtr:*):* { return CoC.instance.monster.claws(); },
			"clit"						: function(thisPtr:*):* { return CoC.instance.monster.clitDescript(); },
			"cock"						: function(thisPtr:*):* { return CoC.instance.monster.cockDescript(0);},
			"cockhead"					: function(thisPtr:*):* { return CoC.instance.monster.cockHead(0);},
			"cocks"						: function(thisPtr:*):* { return CoC.instance.monster.multiCockDescriptLight(); },
			"cunt"						: function(thisPtr:*):* { return CoC.instance.monster.vaginaDescript(); },
			"eachcock"					: function(thisPtr:*):* { return CoC.instance.monster.sMultiCockDesc();},
			"eyes"						: function(thisPtr:*):* { return CoC.instance.monster.eyesDescript();},
			"eyecolor"					: function(thisPtr:*):* { return CoC.instance.monster.eyeColor;},
//			"face"						: function(thisPtr:*):* { return CoC.instance.monster.face(); },
			"feet"						: function(thisPtr:*):* { return CoC.instance.monster.feet(); },
			"foot"						: function(thisPtr:*):* { return CoC.instance.monster.foot(); },
			"fullchest"					: function(thisPtr:*):* { return CoC.instance.monster.allChestDesc(); },
			"hair"						: function(thisPtr:*):* { return CoC.instance.monster.hairDescript(); },
			"haircolor"					: function(thisPtr:*):* { return CoC.instance.monster.hairColor; },
			"hairorfur"					: function(thisPtr:*):* { return CoC.instance.monster.hairOrFur(); },
			"he"						: function(thisPtr:*):* { return CoC.instance.monster.pronoun1; },
			"him"						: function(thisPtr:*):* { return CoC.instance.monster.pronoun2; },
			"himher"					: function(thisPtr:*):* { return CoC.instance.monster.pronoun2; },
			"himself"					: function(thisPtr:*):* { return CoC.instance.monster.mf("himself", "herself"); },
			"herself"					: function(thisPtr:*):* { return CoC.instance.monster.mf("himself", "herself"); },
			"hips"						: function(thisPtr:*):* { return CoC.instance.monster.hipDescript();},
			"his"						: function(thisPtr:*):* { return CoC.instance.monster.pronoun3; },
			"hisher"					: function(thisPtr:*):* { return CoC.instance.monster.pronoun3; },
			"horns"						: function(thisPtr:*):* { return CoC.instance.monster.hornDescript(); },
			"leg"						: function(thisPtr:*):* { return CoC.instance.monster.leg(); },
			"legs"						: function(thisPtr:*):* { return CoC.instance.monster.legs(); },
			"lowergarment"				: function(thisPtr:*):* { return CoC.instance.monster.lowerGarmentName; },
			"man"						: function(thisPtr:*):* { return CoC.instance.monster.mf("man", "woman"); },
			"men"						: function(thisPtr:*):* { return CoC.instance.monster.mf("men", "women"); },
			"malefemaleherm"			: function(thisPtr:*):* { return CoC.instance.monster.maleFemaleHerm(); },
			"master"					: function(thisPtr:*):* { return CoC.instance.monster.mf("master","mistress"); },
			"multicock"					: function(thisPtr:*):* { return CoC.instance.monster.multiCockDescriptLight(); },
			"multicockdescriptlight"	: function(thisPtr:*):* { return CoC.instance.monster.multiCockDescriptLight(); },
			"name"						: function(thisPtr:*):* { return CoC.instance.monster.short;},
			"nipple"					: function(thisPtr:*):* { return CoC.instance.monster.nippleDescript(0);},
			"nipples"					: function(thisPtr:*):* { return CoC.instance.monster.nippleDescript(0) + "s";},
			"onecock"					: function(thisPtr:*):* { return CoC.instance.monster.oMultiCockDesc();},
			"pussy"						: function(thisPtr:*):* { return CoC.instance.monster.vaginaDescript(); },
			"sack"						: function(thisPtr:*):* { return CoC.instance.monster.sackDescript(); },
			"sheath"					: function(thisPtr:*):* { return CoC.instance.monster.sheathDescription(); },
			"shield"					: function(thisPtr:*):* { return CoC.instance.monster.shieldName; },
			"skin"						: function(thisPtr:*):* {
				return CoC.instance.monster.skin.describe('skin',false,false);
			},
			"skin.noadj": function(thisPtr:*):* {
				return CoC.instance.monster.skin.describe('skin',true,false);
			},
			"skin.notone": function(thisPtr:*):* {
				return CoC.instance.monster.skin.describe('skin',false,true);
			},
			"skin.type": function(thisPtr:*):* {
				return CoC.instance.monster.skin.describe('skin',true,true);
			},
			"skin.color": function (thisPtr:*, aspect:*):* {
				return CoC.instance.monster.skin.tone;
			},
			"skin.isare": function (thisPtr:*, aspect:*):* {
				return CoC.instance.monster.skin.isAre();
			},
			"skin.vs": function (thisPtr:*, aspect:*):* {
				return CoC.instance.monster.skin.isAre("s","");
			},
			"skinfurscales"				: function(thisPtr:*):* {
				return CoC.instance.monster.skin.describe('coat');
			},
			"skintone"					: function(thisPtr:*):* {
				return CoC.instance.monster.skinTone;
			},
			"tallness"					: function(thisPtr:*):* { return Measurements.footInchOrMetres(CoC.instance.monster.tallness); },
			"uppergarment"				: function(thisPtr:*):* { return CoC.instance.monster.upperGarmentName; },
			"vag"						: function(thisPtr:*):* { return CoC.instance.monster.vaginaDescript(); },
			"vagina"					: function(thisPtr:*):* { return CoC.instance.monster.vaginaDescript(); },
			"vagorass"					: function(thisPtr:*):* { return (CoC.instance.monster.hasVagina() ? CoC.instance.monster.vaginaDescript() : CoC.instance.monster.assholeDescript()); },
			"weapon"					: function(thisPtr:*):* { return CoC.instance.monster.weaponName;},
			"weaponname"				: function(thisPtr:*):* { return CoC.instance.monster.weaponName; },
			"weaponrangename"			: function(thisPtr:*):* { return CoC.instance.monster.weaponRangeName; },
			"cockplural"				: function(thisPtr:*):* { return (CoC.instance.monster.cocks.length == 1) ? "cock" : "cocks"; },
			"dickplural"				: function(thisPtr:*):* { return (CoC.instance.monster.cocks.length == 1) ? "dick" : "dicks"; },
			"headplural"				: function(thisPtr:*):* { return (CoC.instance.monster.cocks.length == 1) ? "head" : "heads"; },
			"prickplural"				: function(thisPtr:*):* { return (CoC.instance.monster.cocks.length == 1) ? "prick" : "pricks"; },
			"boy"						: function(thisPtr:*):* { return CoC.instance.monster.mf("boy", "girl"); },
			"guy"						: function(thisPtr:*):* { return CoC.instance.monster.mf("guy", "girl"); },
			"wings"						: function(thisPtr:*):* { return CoC.instance.monster.wingsDescript(); },
			"tail"						: function(thisPtr:*):* { return CoC.instance.monster.tailDescript(); },
			"onetail"					: function(thisPtr:*):* { return CoC.instance.monster.oneTailDescript(); }
		};


		// These tags take a two-word tag with a **numberic** attribute for lookup.
		// [object NUMERIC-attribute]
		// if "NUMERIC-attribute" can be cast to a Number, the parser looks for "object" in twoWordNumericTagsLookup.
		// If it finds twoWordNumericTagsLookup["object"], it calls the anonymous function stored with said key "object"
		// like so: twoWordNumericTagsLookup["object"](Number("NUMERIC-attribute"))
		//
		// if attribute cannot be case to a number, the parser looks for "object" in twoWordTagsLookup.
		public var twoWordNumericTagsLookup:Object =
		{
				"cockfit":
					function(thisPtr:*, aspect:*):*
					{
						if(!CoC.instance.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else
						{
							if(CoC.instance.player.cockThatFits(aspect) >= 0) return CoC.instance.player.cockDescript(CoC.instance.player.cockThatFits(aspect));
							else return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex());
						}
					},
				"cockfit2":
					function(thisPtr:*, aspect:*):*
					{
						if(!CoC.instance.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else {
							if(CoC.instance.player.cockThatFits2(aspect) >= 0) return CoC.instance.player.cockDescript(CoC.instance.player.cockThatFits2(aspect));
							else return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex());
						}
					},
				"cockheadfit":
					function(thisPtr:*, aspect:*):*
					{
						if (!CoC.instance.player.hasCock())
						{
							return "<b>(Attempt to parse cockhead when none present.)</b>";
						}
						else {
							if(CoC.instance.player.cockThatFits(aspect) >= 0) return CoC.instance.player.cockHead(CoC.instance.player.cockThatFits(aspect));
							else return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex());
						}
					},
				"cockheadfit2":
					function(thisPtr:*, aspect:*):*
					{
						if(!CoC.instance.player.hasCock()) return "<b>(Attempt to parse cockhead when none present.)</b>";
						else {
							if(CoC.instance.player.cockThatFits2(aspect) >= 0) return CoC.instance.player.cockHead(CoC.instance.player.cockThatFits2(aspect));
							else return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex());
						}
					},
				"cock":
					function(thisPtr:*, aspect:*):*
					{
						if(!CoC.instance.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else
						{
							if(aspect-1 >= 0 && aspect-1 < CoC.instance.player.cockTotal()) return CoC.instance.player.cockDescript(aspect - 1);
							else return "<b>(Attempt To Parse CockDescript for Invalid Cock)</b>";
						}
					},
				"cockhead":
					function(thisPtr:*, aspect:*):*
					{
						if(!CoC.instance.player.hasCock()) return "<b>(Attempt to parse cockHead when none present.)</b>";
						else
						{
							var intAspect:int = int(aspect - 1);
							if (intAspect >= 0 && intAspect < CoC.instance.player.cockTotal()) return CoC.instance.player.cockHead(intAspect);
							else return "<b>(Attempt To Parse CockHeadDescript for Invalid Cock)</b>";
						}
					}

		};
		private static function skinDescriptionFn(layer:String,noAdj:Boolean,noTone:Boolean):Function {
			return function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.describe(layer,noAdj,noTone)
		}
		}
		public var skinLookups:Object = {
			"skin": skinDescriptionFn("skin", false, false),
			"noadj": skinDescriptionFn("skin", true, false),
			"notone": skinDescriptionFn("skin", false, true),
			"nocolor": skinDescriptionFn("skin", false, true),
			"type": skinDescriptionFn("skin", true, true),
			"color": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.color;
			},
			"color2": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.color2;
			},
			"isare": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.isAre();
			},
			"vs": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.isAre("s","");
			},
			"base": skinDescriptionFn("base", false, false),
			"base.noadj": skinDescriptionFn("base", true, false),
			"base.notone": skinDescriptionFn("base", false, true),
			"base.nocolor": skinDescriptionFn("base", false, true),
			"base.type": skinDescriptionFn("base", true, true),
			"base.color": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.base.color;
			},
			"base.color2": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.base.color2;
			},
			"base.vs": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.base.isAre("s", "");
			},
			"base.isare": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.base.isAre();
			},
			"coat": skinDescriptionFn("coat", false, false),
			"coat.noadj": skinDescriptionFn("coat", true, false),
			"coat.notone": skinDescriptionFn("coat", false, true),
			"coat.nocolor": skinDescriptionFn("coat", false, true),
			"coat.type": skinDescriptionFn("coat", true, true),
			"coat.vs": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.coat.isAre("s", "");
			},
			"coat.isare": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.coat.isAre();
			},
			"coat.color": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.coatColor;
			},
			"coat.color2": function (thisPtr:*, aspect:*):* {
				return CoC.instance.player.skin.coat.color2;
			},
			"full": skinDescriptionFn("full", false, false),
			"full.noadj": skinDescriptionFn("full", true, false),
			"full.notone": skinDescriptionFn("full", false, true),
			"full.nocolor": skinDescriptionFn("full", false, true),
			"full.type": skinDescriptionFn("full", true, true)
		};
		public var faceLookups:Object = {
			"full": function(thisPtr:*,aspect:*):*{
				return CoC.instance.player.facePart.describe(false,true);
			}
		};
		// These tags take an ascii attribute for lookup.
		// [object attribute]
		// if attribute cannot be cast to a number, the parser looks for "object" in twoWordTagsLookup,
		// and then uses the corresponding object to determine the value of "attribute", by looking for
		// "attribute" twoWordTagsLookup["object"]["attribute"]
		public var twoWordTagsLookup:Object =
		{
			// NPCs:
			"rubi"		: rubiLookups,
			"arian"		: arianLookups,
			"monster"	: monsterLookups,

			// PC Attributes:

			"cock"		: cockLookups,
			"cockhead"	: cockHeadLookups,

			"skin"      : skinLookups,
			"face"      : faceLookups
		};
