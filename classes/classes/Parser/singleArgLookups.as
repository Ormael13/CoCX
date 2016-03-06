

		// Lookup dictionary for converting any single argument brackets into it's corresponding string
		// basically [armor] results in the "[armor]" segment of the string being replaced with the
		// results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
		// tags not present in the singleArgConverters object return an error message.
		//
		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.GlobalFlags.kFLAGS;
		import classes.GlobalFlags.kGAMECLASS;
		
		public var singleArgConverters:Object =
		{
				// all the errors related to trying to parse stuff if not present are
				// already handled in the various *Descript() functions.
				// no need to duplicate them.

				// Note: all key strings MUST be ENTIRELY lowercase.

				"agility"					: function(thisPtr:*):* { return "[Agility]"; },
				"armor"						: function(thisPtr:*):* { return kGAMECLASS.player.armorName;},
				"armorname"					: function(thisPtr:*):* { return kGAMECLASS.player.armorName;},
				"ass"						: function(thisPtr:*):* { return kGAMECLASS.player.buttDescript();},
				"asshole"					: function(thisPtr:*):* { return kGAMECLASS.player.assholeDescript(); },
				"balls"						: function(thisPtr:*):* { return kGAMECLASS.player.ballsDescriptLight(); },
				"boyfriend"					: function(thisPtr:*):* { return kGAMECLASS.player.mf("boyfriend", "girlfriend"); },
				"butt"						: function(thisPtr:*):* { return kGAMECLASS.player.buttDescript();},
				"butthole"					: function(thisPtr:*):* { return kGAMECLASS.player.assholeDescript();},
				"chest"						: function(thisPtr:*):* { return kGAMECLASS.player.chestDesc(); },
				"clit"						: function(thisPtr:*):* { return kGAMECLASS.player.clitDescript(); },
				"cock"						: function(thisPtr:*):* { return kGAMECLASS.player.cockDescript(0);},
				"cockhead"					: function(thisPtr:*):* { return kGAMECLASS.player.cockHead(0);},
				"cocks"						: function(thisPtr:*):* { return kGAMECLASS.player.multiCockDescriptLight(); },
				"cunt"						: function(thisPtr:*):* { return kGAMECLASS.player.vaginaDescript(); },
				"eachcock"					: function(thisPtr:*):* { return kGAMECLASS.player.sMultiCockDesc();},
				"evade"						: function(thisPtr:*):* { return "[Evade]"; },
				"face"						: function(thisPtr:*):* { return kGAMECLASS.player.face(); },
				"feet"						: function(thisPtr:*):* { return kGAMECLASS.player.feet(); },
				"foot"						: function(thisPtr:*):* { return kGAMECLASS.player.foot(); },
				"fullchest"					: function(thisPtr:*):* { return kGAMECLASS.player.allChestDesc(); },
				"hair"						: function(thisPtr:*):* { return kGAMECLASS.player.hairDescript(); },
				"haircolor"					: function(thisPtr:*):* { return kGAMECLASS.player.hairColor; },
				"hairorfur"					: function(thisPtr:*):* { return kGAMECLASS.player.hairOrFur(); },
				"he"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("he", "she"); },
				"he2"						: function(thisPtr:*):* { return kGAMECLASS.player2.mf("he", "she"); },
				"him"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("him", "her"); },
				"him2"						: function(thisPtr:*):* { return kGAMECLASS.player2.mf("him", "her"); },
				"himself"					: function(thisPtr:*):* { return kGAMECLASS.player.mf("himself", "herself"); },
				"herself"					: function(thisPtr:*):* { return kGAMECLASS.player.mf("himself", "herself"); },
				"hips"						: function(thisPtr:*):* { return kGAMECLASS.player.hipDescript();},
				"his"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("his", "her"); },
				"his2"						: function(thisPtr:*):* { return kGAMECLASS.player2.mf("his", "her"); },
				"horns"						: function(thisPtr:*):* { return kGAMECLASS.player.hornDescript(); },
				"leg"						: function(thisPtr:*):* { return kGAMECLASS.player.leg(); },
				"legs"						: function(thisPtr:*):* { return kGAMECLASS.player.legs(); },
				"lowergarment"				: function(thisPtr:*):* { return kGAMECLASS.player.lowerGarmentName; },
				"man"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("man", "woman"); },
				"men"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("men", "women"); },
				"master"					: function(thisPtr:*):* { return kGAMECLASS.player.mf("master","mistress"); },
				"misdirection"				: function(thisPtr:*):* { return "[Misdirection]"; },
				"multicock"					: function(thisPtr:*):* { return kGAMECLASS.player.multiCockDescriptLight(); },
				"multicockdescriptlight"	: function(thisPtr:*):* { return kGAMECLASS.player.multiCockDescriptLight(); },
				"name"						: function(thisPtr:*):* { return kGAMECLASS.player.short;},
				"nipple"					: function(thisPtr:*):* { return kGAMECLASS.player.nippleDescript(0);},
				"nipples"					: function(thisPtr:*):* { return kGAMECLASS.player.nippleDescript(0) + "s";},
				"onecock"					: function(thisPtr:*):* { return kGAMECLASS.player.oMultiCockDesc();},
				"pg"						: function(thisPtr:*):* { return "\n\n";},
				"pussy"						: function(thisPtr:*):* { return kGAMECLASS.player.vaginaDescript(); },
				"race"						: function(thisPtr:*):* { return kGAMECLASS.player.race(); },
				"sack"						: function(thisPtr:*):* { return kGAMECLASS.player.sackDescript(); },
				"sheath"					: function(thisPtr:*):* { return kGAMECLASS.player.sheathDescript(); },
				"shield"					: function(thisPtr:*):* { return kGAMECLASS.player.shieldName; },
				"skin"						: function(thisPtr:*):* { return kGAMECLASS.player.skin(); },
				"skinfurscales"				: function(thisPtr:*):* { return kGAMECLASS.player.skinFurScales(); },
				"tongue"					: function(thisPtr:*):* { return kGAMECLASS.player.tongueDescript(); },
				"uppergarment"				: function(thisPtr:*):* { return kGAMECLASS.player.upperGarmentName; },
				"vag"						: function(thisPtr:*):* { return kGAMECLASS.player.vaginaDescript(); },
				"vagina"					: function(thisPtr:*):* { return kGAMECLASS.player.vaginaDescript(); },
				"vagorass"					: function(thisPtr:*):* { return (kGAMECLASS.player.hasVagina() ? kGAMECLASS.player.vaginaDescript() : kGAMECLASS.player.assholeDescript()); },
				"weapon"					: function(thisPtr:*):* { return kGAMECLASS.player.weaponName;},
				"weaponname"				: function(thisPtr:*):* { return kGAMECLASS.player.weaponName; },
				"latexyname"				: function(thisPtr:*):* { return kGAMECLASS.flags[kFLAGS.GOO_NAME]; },
				"bathgirlname"				: function(thisPtr:*):* { return kGAMECLASS.flags[kFLAGS.MILK_NAME]; },
				"cockplural"				: function(thisPtr:*):* { return (kGAMECLASS.player.cocks.length == 1) ? "cock" : "cocks"; },
				"dickplural"				: function(thisPtr:*):* { return (kGAMECLASS.player.cocks.length == 1) ? "dick" : "dicks"; },
				"headplural"				: function(thisPtr:*):* { return (kGAMECLASS.player.cocks.length == 1) ? "head" : "heads"; },
				"prickplural"				: function(thisPtr:*):* { return (kGAMECLASS.player.cocks.length == 1) ? "prick" : "pricks"; },
				"boy"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("boy", "girl"); },
				"guy"						: function(thisPtr:*):* { return kGAMECLASS.player.mf("guy", "girl"); },
				"wings"						: function(thisPtr:*):* { return kGAMECLASS.player.wingsDescript(); },
				"tail"						: function(thisPtr:*):* { return kGAMECLASS.player.tailDescript(); },
				"onetail"					: function(thisPtr:*):* { return kGAMECLASS.player.oneTailDescript(); },

				//Prisoner
				"captortitle"				: function(thisPtr:*):* { return kGAMECLASS.prison.prisonCaptor.captorTitle; },
				"captorname"				: function(thisPtr:*):* { return kGAMECLASS.prison.prisonCaptor.captorName; },
				"captorhe"					: function(thisPtr:*):* { return kGAMECLASS.prison.prisonCaptor.captorPronoun1; },
				"captorhim"					: function(thisPtr:*):* { return kGAMECLASS.prison.prisonCaptor.captorPronoun2; },
				"captorhis"					: function(thisPtr:*):* { return kGAMECLASS.prison.prisonCaptor.captorPronoun3; }
				
		}
