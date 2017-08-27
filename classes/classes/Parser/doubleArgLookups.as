
		// provides rubiLookups and arianLookups
		// note that these are only used in doubleArgLookups, not in Parser.as itself
		//
		// =!= NOTE: MUST BE IMPORTED BEFORE "./doubleArgLookups.as" =!=
		// 
		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.BodyParts.Skin;
		import classes.GlobalFlags.kGAMECLASS;
		include "./npcLookups.as";


		// PC ASCII Aspect lookups

		public var cockLookups:Object = // For subject: "cock"
		{
			"all"		: function(thisPtr:*):*{ return kGAMECLASS.player.multiCockDescriptLight(); },
			"each"		: function(thisPtr:*):*{ return kGAMECLASS.player.sMultiCockDesc(); },
			"one"		: function(thisPtr:*):*{ return kGAMECLASS.player.oMultiCockDesc(); },
			"largest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex()); },
			"biggest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex()); },
			"biggest2"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex2()); },
			"biggest3"  : function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex3()); },
			"smallest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex()); },
			"smallest2" : function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex2()); },
			"longest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.longestCock()); },
			"shortest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.shortestCockIndex()); }
		}


		public var cockHeadLookups:Object = // For subject: "cockHead"
		{
			"biggest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex()); },
			"biggest2"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex2()); },
			"biggest3"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex3()); },
			"largest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex()); },
			"smallest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex()); },
			"smallest2"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex2()); },
			"longest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.longestCock()); },			// the *head* of a cock has a length? Wut?
			"shortest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.shortestCockIndex()); }
		}


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
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else
						{
							if(kGAMECLASS.player.cockThatFits(aspect) >= 0) return kGAMECLASS.player.cockDescript(kGAMECLASS.player.cockThatFits(aspect));
							else return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cockfit2":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else {
							if(kGAMECLASS.player.cockThatFits2(aspect) >= 0) return kGAMECLASS.player.cockDescript(kGAMECLASS.player.cockThatFits2(aspect));
							else return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cockheadfit":
					function(thisPtr:*, aspect:*):*
					{
						if (!kGAMECLASS.player.hasCock())
						{
							return "<b>(Attempt to parse cockhead when none present.)</b>";
						}
						else {
							if(kGAMECLASS.player.cockThatFits(aspect) >= 0) return kGAMECLASS.player.cockHead(kGAMECLASS.player.cockThatFits(aspect));
							else return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cockheadfit2":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cockhead when none present.)</b>";
						else {
							if(kGAMECLASS.player.cockThatFits2(aspect) >= 0) return kGAMECLASS.player.cockHead(kGAMECLASS.player.cockThatFits2(aspect));
							else return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cock":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else
						{
							if(aspect-1 >= 0 && aspect-1 < kGAMECLASS.player.cockTotal()) return kGAMECLASS.player.cockDescript(aspect - 1);
							else return "<b>(Attempt To Parse CockDescript for Invalid Cock)</b>";
						}
					},
				"cockhead":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cockHead when none present.)</b>";
						else
						{
							var intAspect:int = int(aspect - 1);
							if (intAspect >= 0 && intAspect < kGAMECLASS.player.cockTotal()) return kGAMECLASS.player.cockHead(intAspect);
							else return "<b>(Attempt To Parse CockHeadDescript for Invalid Cock)</b>";
						}
					}

		};
		private static function skinDescriptionFn(layer:String,noAdj:Boolean,noTone:Boolean):Function {
			return function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.describe(layer,noAdj,noTone)
		}
		}
		public var skinLookups:Object = {
			"skin": skinDescriptionFn("skin", false, false),
			"noadj": skinDescriptionFn("skin", true, false),
			"notone": skinDescriptionFn("skin", false, true),
			"nocolor": skinDescriptionFn("skin", false, true),
			"type": skinDescriptionFn("skin", true, true),
			"color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.color;
			},
			"color2": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.color2;
			},
			"isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.isAre();
			},
			"vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.isAre("s","");
			},
			"base": skinDescriptionFn("base", false, false),
			"base.noadj": skinDescriptionFn("base", true, false),
			"base.notone": skinDescriptionFn("base", false, true),
			"base.nocolor": skinDescriptionFn("base", false, true),
			"base.type": skinDescriptionFn("base", true, true),
			"base.color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.color;
			},
			"base.color2": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.color2;
			},
			"base.vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.isAre("s", "");
			},
			"base.isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.isAre();
			},
			"coat": skinDescriptionFn("coat", false, false),
			"coat.noadj": skinDescriptionFn("coat", true, false),
			"coat.notone": skinDescriptionFn("coat", false, true),
			"coat.nocolor": skinDescriptionFn("coat", false, true),
			"coat.type": skinDescriptionFn("coat", true, true),
			"coat.vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.isAre("s", "");
			},
			"coat.isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.isAre();
			},
			"coat.color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.color;
			},
			"coat.color2": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.color2;
			},
			"full": skinDescriptionFn("full", false, false),
			"full.noadj": skinDescriptionFn("full", true, false),
			"full.notone": skinDescriptionFn("full", false, true),
			"full.nocolor": skinDescriptionFn("full", false, true),
			"full.type": skinDescriptionFn("full", true, true)
		};
		public var faceLookups:Object = {
			"full": function(thisPtr:*,aspect:*):*{
				return kGAMECLASS.player.facePart.describe(false,true);
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

			// PC Attributes:

			"cock"		: cockLookups,
			"cockhead"	: cockHeadLookups,

			"skin"      : skinLookups,
			"face"      : faceLookups
		}
