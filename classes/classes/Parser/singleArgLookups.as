

		// Lookup dictionary for converting any single argument brackets into it's corresponding string
		// basically [armor] results in the "[armor]" segment of the string being replaced with the
		// results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
		// tags not present in the singleArgConverters object return an error message.
		//
		//Calls are now made through CoC.instance rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
        import classes.Appearance;
        import classes.GlobalFlags.kFLAGS;
        import classes.CoC;
        import classes.Measurements;

        public var singleArgConverters:Object =
		{
				// all the errors related to trying to parse stuff if not present are
				// already handled in the various *Descript() functions.
				// no need to duplicate them.

				// Note: all key strings MUST be ENTIRELY lowercase.

				"agility"					: function(thisPtr:*):* { return "[Agility]"; },
				"allbreasts"				: function(thisPtr:*):* { return CoC.instance.player.allBreastsDescript(); },
				"alltits"				    : function(thisPtr:*):* { return CoC.instance.player.allBreastsDescript(); },
				"armor"						: function(thisPtr:*):* { return CoC.instance.player.armorName;},
				"armorname"					: function(thisPtr:*):* { return CoC.instance.player.armorName;},
				"ass"						: function(thisPtr:*):* { return CoC.instance.player.buttDescript();},
				"asshole"					: function(thisPtr:*):* { return CoC.instance.player.assholeDescript(); },
				"balls"						: function(thisPtr:*):* { return CoC.instance.player.ballsDescriptLight(); },
				"bodytype"					: function(thisPtr:*):* { return CoC.instance.player.bodyType(); },
				"boyfriend"					: function(thisPtr:*):* { return CoC.instance.player.mf("boyfriend", "girlfriend"); },
				"breasts"					: function(thisPtr:*):* { return CoC.instance.player.breastDescript(0); },
				"butt"						: function(thisPtr:*):* { return CoC.instance.player.buttDescript();},
				"butthole"					: function(thisPtr:*):* { return CoC.instance.player.assholeDescript();},
				"chest"						: function(thisPtr:*):* { return CoC.instance.player.chestDesc(); },
				"claws"						: function(thisPtr:*):* { return CoC.instance.player.claws(); },
				"clit"						: function(thisPtr:*):* { return CoC.instance.player.clitDescript(); },
				"cock"						: function(thisPtr:*):* { return CoC.instance.player.cockDescript(0);},
				"cockhead"					: function(thisPtr:*):* { return CoC.instance.player.cockHead(0);},
				"cocks"						: function(thisPtr:*):* { return CoC.instance.player.multiCockDescriptLight(); },
				"cunt"						: function(thisPtr:*):* { return CoC.instance.player.vaginaDescript(); },
				"eachcock"					: function(thisPtr:*):* { return CoC.instance.player.sMultiCockDesc();},
				"evade"						: function(thisPtr:*):* { return "[Evade]"; },
				"eyes"						: function(thisPtr:*):* { return CoC.instance.player.eyesDescript();},
				"eyecolor"					: function(thisPtr:*):* { return CoC.instance.player.eyeColor;},
				"face"						: function(thisPtr:*):* { return CoC.instance.player.face(); },
				"feet"						: function(thisPtr:*):* { return CoC.instance.player.feet(); },
				"foot"						: function(thisPtr:*):* { return CoC.instance.player.foot(); },
				"fullchest"					: function(thisPtr:*):* { return CoC.instance.player.allChestDesc(); },
				"hair"						: function(thisPtr:*):* { return CoC.instance.player.hairDescript(); },
				"haircolor"					: function(thisPtr:*):* { return CoC.instance.player.hairColor; },
				"hairorfur"					: function(thisPtr:*):* { return CoC.instance.player.hairOrFur(); },
				"he"						: function(thisPtr:*):* { return CoC.instance.player.mf("he", "she"); },
				"he2"						: function(thisPtr:*):* { return CoC.instance.player2.mf("he", "she"); },
				"him"						: function(thisPtr:*):* { return CoC.instance.player.mf("him", "her"); },
				"him2"						: function(thisPtr:*):* { return CoC.instance.player2.mf("him", "her"); },
				"himher"					: function(thisPtr:*):* { return CoC.instance.player.mf("him", "her"); },
				"himself"					: function(thisPtr:*):* { return CoC.instance.player.mf("himself", "herself"); },
				"herself"					: function(thisPtr:*):* { return CoC.instance.player.mf("himself", "herself"); },
				"hips"						: function(thisPtr:*):* { return CoC.instance.player.hipDescript();},
				"his"						: function(thisPtr:*):* { return CoC.instance.player.mf("his", "her"); },
				"hisher"					: function(thisPtr:*):* { return CoC.instance.player.mf("his", "her"); },
				"his2"						: function(thisPtr:*):* { return CoC.instance.player2.mf("his", "her"); },
				"horns"						: function(thisPtr:*):* { return CoC.instance.player.hornDescript(); },
				"leg"						: function(thisPtr:*):* { return CoC.instance.player.leg(); },
				"legs"						: function(thisPtr:*):* { return CoC.instance.player.legs(); },
				"lowergarment"				: function(thisPtr:*):* { return CoC.instance.player.lowerGarmentName; },
				"man"						: function(thisPtr:*):* { return CoC.instance.player.mf("man", "woman"); },
				"men"						: function(thisPtr:*):* { return CoC.instance.player.mf("men", "women"); },
				"malefemaleherm"			: function(thisPtr:*):* { return CoC.instance.player.maleFemaleHerm(); },
				"master"					: function(thisPtr:*):* { return CoC.instance.player.mf("master","mistress"); },
				"misdirection"				: function(thisPtr:*):* { return "[Misdirection]"; },
				"multicock"					: function(thisPtr:*):* { return CoC.instance.player.multiCockDescriptLight(); },
				"multicockdescriptlight"	: function(thisPtr:*):* { return CoC.instance.player.multiCockDescriptLight(); },
				"name"						: function(thisPtr:*):* { return CoC.instance.player.short;},
				"nipple"					: function(thisPtr:*):* { return CoC.instance.player.nippleDescript(0);},
				"nipples"					: function(thisPtr:*):* { return CoC.instance.player.nippleDescript(0) + "s";},
				"onecock"					: function(thisPtr:*):* { return CoC.instance.player.oMultiCockDesc();},
				"pg"						: function(thisPtr:*):* { return "\n\n";},
				"pussy"						: function(thisPtr:*):* { return CoC.instance.player.vaginaDescript(); },
				"race"						: function(thisPtr:*):* { return CoC.instance.player.race(); },
				"sack"						: function(thisPtr:*):* { return Appearance.sackDescript(CoC.instance.player); },
				"sheath"					: function(thisPtr:*):* { return CoC.instance.player.sheathDescription(); },
				"shield"					: function(thisPtr:*):* { return CoC.instance.player.shieldName; },
				"skin"						: function(thisPtr:*):* {
					return CoC.instance.player.skin.describe('skin',false,false);
				},
				"skin.noadj": function(thisPtr:*):* {
					return CoC.instance.player.skin.describe('skin',true,false);
				},
				"skin.notone": function(thisPtr:*):* {
					return CoC.instance.player.skin.describe('skin',false,true);
				},
				"skin.type": function(thisPtr:*):* {
					return CoC.instance.player.skin.describe('skin',true,true);
				},
				"skin.color": function (thisPtr:*, aspect:*):* {
					return CoC.instance.player.skin.tone;
				},
				"skin.isare": function (thisPtr:*, aspect:*):* {
					return CoC.instance.player.skin.isAre();
				},
				"skin.vs": function (thisPtr:*, aspect:*):* {
					return CoC.instance.player.skin.isAre("s","");
				},
				"skinfurscales"				: function(thisPtr:*):* {
					return CoC.instance.player.skin.describe('coat');
				},
				"skintone"					: function(thisPtr:*):* {
					return CoC.instance.player.skinTone;
				},
				"tallness"					: function(thisPtr:*):* { return Measurements.footInchOrMetres(CoC.instance.player.tallness); },
				"teasetext"					: function(thisPtr:*):* { return SceneLib.combat.teaseText(); },
				"tongue"					: function(thisPtr:*):* { return Appearance.tongueDescription(CoC.instance.player); },
				"uppergarment"				: function(thisPtr:*):* { return CoC.instance.player.upperGarmentName; },
				"vag"						: function(thisPtr:*):* { return CoC.instance.player.vaginaDescript(); },
				"vagina"					: function(thisPtr:*):* { return CoC.instance.player.vaginaDescript(); },
				"vagorass"					: function(thisPtr:*):* { return (CoC.instance.player.hasVagina() ? CoC.instance.player.vaginaDescript() : CoC.instance.player.assholeDescript()); },
				"weapon"					: function(thisPtr:*):* { return CoC.instance.player.weaponName;},
				"weaponname"				: function(thisPtr:*):* { return CoC.instance.player.weaponName; },
				"weaponrangename"			: function(thisPtr:*):* { return CoC.instance.player.weaponRangeName; },
				"latexyname"				: function(thisPtr:*):* { return CoC.instance.flags[kFLAGS.GOO_NAME]; },
				"bathgirlname"				: function(thisPtr:*):* { return CoC.instance.flags[kFLAGS.MILK_NAME]; },
				"cockplural"				: function(thisPtr:*):* { return (CoC.instance.player.cocks.length == 1) ? "cock" : "cocks"; },
				"dickplural"				: function(thisPtr:*):* { return (CoC.instance.player.cocks.length == 1) ? "dick" : "dicks"; },
				"headplural"				: function(thisPtr:*):* { return (CoC.instance.player.cocks.length == 1) ? "head" : "heads"; },
				"prickplural"				: function(thisPtr:*):* { return (CoC.instance.player.cocks.length == 1) ? "prick" : "pricks"; },
				"boy"						: function(thisPtr:*):* { return CoC.instance.player.mf("boy", "girl"); },
				"guy"						: function(thisPtr:*):* { return CoC.instance.player.mf("guy", "girl"); },
				"wings"						: function(thisPtr:*):* { return CoC.instance.player.wingsDescript(); },
				"tail"						: function(thisPtr:*):* { return CoC.instance.player.tailDescript(); },
				"onetail"					: function(thisPtr:*):* { return CoC.instance.player.oneTailDescript(); },

				//Prisoner
				"captortitle"				: function(thisPtr:*):* { return SceneLib.prison.prisonCaptor.captorTitle; },
				"captorname"				: function(thisPtr:*):* { return SceneLib.prison.prisonCaptor.captorName; },
				"captorhe"					: function(thisPtr:*):* { return SceneLib.prison.prisonCaptor.captorPronoun1; },
				"captorhim"					: function(thisPtr:*):* { return SceneLib.prison.prisonCaptor.captorPronoun2; },
				"captorhis"					: function(thisPtr:*):* { return SceneLib.prison.prisonCaptor.captorPronoun3; }
				
		};
