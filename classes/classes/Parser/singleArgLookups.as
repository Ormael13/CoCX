

		// Lookup dictionary for converting any single argument brackets into it's corresponding string
		// basically [armor] results in the "[armor]" segment of the string being replaced with the
		// results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
		// tags not present in the singleArgConverters object return an error message.
		//
		import classes.GlobalFlags.kFLAGS;
		import classes.GlobalFlags.kGAMECLASS;
		
		public var singleArgConverters:Object =
		{
				// all the errors related to trying to parse stuff if not present are
				// already handled in the various *Descript() functions.
				// no need to duplicate them.

				// Note: all key strings MUST be ENTIRELY lowercase.

				"agility"					: function(thisPtr:*):* { return "[Agility]"; },
				"armor"						: function(thisPtr:*):* { return thisPtr.player.armorName;},
				"armorname"					: function(thisPtr:*):* { return thisPtr.player.armorName;},
				"ass"						: function(thisPtr:*):* { return thisPtr.buttDescript();},
				"asshole"					: function(thisPtr:*):* { return thisPtr.assholeDescript(); },
				"balls"						: function(thisPtr:*):* { return thisPtr.ballsDescriptLight(); },
				"boyfriend"					: function(thisPtr:*):* { return thisPtr.player.mf("boyfriend", "girlfriend"); },
				"butt"						: function(thisPtr:*):* { return thisPtr.buttDescript();},
				"butthole"					: function(thisPtr:*):* { return thisPtr.assholeDescript();},
				"chest"						: function(thisPtr:*):* { return thisPtr.chestDesc(); },
				"clit"						: function(thisPtr:*):* { return thisPtr.clitDescript(); },
				"cock"						: function(thisPtr:*):* { return thisPtr.cockDescript(0);},
				"cockhead"					: function(thisPtr:*):* { return thisPtr.cockHead(0);},
				"cocks"						: function(thisPtr:*):* { return thisPtr.multiCockDescriptLight(); },
				"cunt"						: function(thisPtr:*):* { return thisPtr.vaginaDescript(); },
				"eachcock"					: function(thisPtr:*):* { return thisPtr.sMultiCockDesc();},
				"evade"						: function(thisPtr:*):* { return "[Evade]"; },
				"face"						: function(thisPtr:*):* { return thisPtr.player.face(); },
				"feet"						: function(thisPtr:*):* { return thisPtr.player.feet(); },
				"foot"						: function(thisPtr:*):* { return thisPtr.player.foot(); },
				"fullchest"					: function(thisPtr:*):* { return thisPtr.allChestDesc(); },
				"hair"						: function(thisPtr:*):* { return thisPtr.hairDescript(); },
				"hairorfur"					: function(thisPtr:*):* { return thisPtr.hairOrFur(); },
				"he"						: function(thisPtr:*):* { return thisPtr.player.mf("he", "she"); },
				"he2"						: function(thisPtr:*):* { return thisPtr.player2.mf("he", "she"); },
				"him"						: function(thisPtr:*):* { return thisPtr.player.mf("him", "her"); },
				"him2"						: function(thisPtr:*):* { return thisPtr.player2.mf("him", "her"); },
				"himself"					: function(thisPtr:*):* { return thisPtr.player.mf("himself", "herself"); },
				"herself"					: function(thisPtr:*):* { return thisPtr.player.mf("himself", "herself"); },
				"hips"						: function(thisPtr:*):* { return thisPtr.hipDescript();},
				"his"						: function(thisPtr:*):* { return thisPtr.player.mf("his", "her"); },
				"his2"						: function(thisPtr:*):* { return thisPtr.player2.mf("his","her"); },
				"leg"						: function(thisPtr:*):* { return thisPtr.player.leg(); },
				"legs"						: function(thisPtr:*):* { return thisPtr.player.legs(); },
				"man"						: function(thisPtr:*):* { return thisPtr.player.mf("man", "woman"); },
				"men"						: function(thisPtr:*):* { return thisPtr.player.mf("men", "women"); },
				"master"					: function(thisPtr:*):* { return thisPtr.player.mf("master","mistress"); },
				"misdirection"				: function(thisPtr:*):* { return "[Misdirection]"; },
				"multicock"					: function(thisPtr:*):* { return thisPtr.multiCockDescriptLight(); },
				"multicockdescriptlight"	: function(thisPtr:*):* { return thisPtr.multiCockDescriptLight(); },
				"name"						: function(thisPtr:*):* { return thisPtr.player.short;},
				"nipple"					: function(thisPtr:*):* { return thisPtr.nippleDescript(0);},
				"nipples"					: function(thisPtr:*):* { return thisPtr.nippleDescript(0) + "s";},
				"onecock"					: function(thisPtr:*):* { return thisPtr.oMultiCockDesc();},
				"pg"						: function(thisPtr:*):* { return "\n\n";},
				"pussy"						: function(thisPtr:*):* { return thisPtr.vaginaDescript(); },
				"race"						: function(thisPtr:*):* { return thisPtr.player.race(); },
				"sack"						: function(thisPtr:*):* { return thisPtr.sackDescript(); },
				"sheath"					: function(thisPtr:*):* { return thisPtr.sheathDesc(); },
				"skin"						: function(thisPtr:*):* { return thisPtr.player.skin(); },
				"skinfurscales"				: function(thisPtr:*):* { return thisPtr.player.skinFurScales(); },
				"teasetext"					: function(thisPtr:*):* { return thisPtr.teaseText(); },
				"tongue"					: function(thisPtr:*):* { return thisPtr.tongueDescript(); },
				"vag"						: function(thisPtr:*):* { return thisPtr.vaginaDescript(); },
				"vagina"					: function(thisPtr:*):* { return thisPtr.vaginaDescript(); },
				"vagorass"					: function(thisPtr:*):* { return (thisPtr.player.hasVagina() ? thisPtr.vaginaDescript() : thisPtr.assholeDescript()); },
				"weapon"					: function(thisPtr:*):* { return thisPtr.player.weaponName;},
				"weaponname"				: function(thisPtr:*):* { return thisPtr.player.weaponName; },
				
				"latexyname"				: function(thisPtr:*):* { return thisPtr.flags[kFLAGS.GOO_NAME]; },
				"bathgirlname"				: function(thisPtr:*):* { return thisPtr.flags[kFLAGS.MILK_NAME]; },
				"cockplural"				: function(thisPtr:*):* { return (thisPtr.player.cocks.length == 1) ? "cock" : "cocks"; },
				"dickplural"				: function(thisPtr:*):* { return (thisPtr.player.cocks.length == 1) ? "dick" : "dicks"; },
				"headplural"				: function(thisPtr:*):* { return (thisPtr.player.cocks.length == 1) ? "head" : "heads"; },
				"prickplural"				: function(thisPtr:*):* { return (thisPtr.player.cocks.length == 1) ? "prick" : "pricks"; },
				"boy"						: function(thisPtr:*):* { return thisPtr.player.mf("boy", "girl"); },
				"guy"						: function(thisPtr:*):* { return thisPtr.player.mf("guy", "girl"); },
				"wings"						: function(thisPtr:*):* { return thisPtr.wingsDescript(); },
				"tail"						: function(thisPtr:*):* { return thisPtr.tailDescript(); },
				"onetail"					: function(thisPtr:*):* { return thisPtr.oneTailDescript(); }
				//"ecockdescript"				: function(thisPtr:*):* { return thisPtr.eCockDescript(0);}

		}
