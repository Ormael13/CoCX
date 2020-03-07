package classes.Parser {
import classes.Appearance;
import classes.CoC;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Measurements;
import classes.Scenes.SceneLib;

public class ParserTags {

    /**
     * Provides singleArgConverters.
     *
     * Lookup dictionary for converting any single argument brackets into it's corresponding string
     * basically [armor] results in the "[armor]" segment of the string being replaced with the
     * results of the corresponding anonymous function, in this case: function():* {return player.armorName;}
     * tags not present in the singleArgConverters object return an error message.
     *
     * Calls are now made through CoC.instance rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
     *
     *  all the errors related to trying to parse stuff if not present are
     *  already handled in the various *Descript() functions.
     *  no need to duplicate them.
     *
     *  Note: all key strings MUST be ENTIRELY lowercase.
     */
    internal static var singleArgConverters:Object = {
        "agility"               : function ():* { return "[Agility]"; },
        "allbreasts"            : function ():* { return CoC.instance.player.allBreastsDescript(); },
        "alltits"               : function ():* { return CoC.instance.player.allBreastsDescript(); },
        "armor"                 : function ():* { return CoC.instance.player.armorName; },
        "armorname"             : function ():* { return CoC.instance.player.armorName; },
        "ass"                   : function ():* { return CoC.instance.player.buttDescript(); },
        "asshole"               : function ():* { return CoC.instance.player.assholeDescript(); },
        "balls"                 : function ():* { return CoC.instance.player.ballsDescriptLight(); },
        "bodytype"              : function ():* { return CoC.instance.player.bodyType(); },
        "boyfriend"             : function ():* { return CoC.instance.player.mf("boyfriend", "girlfriend"); },
        "breasts"               : function ():* { return CoC.instance.player.breastDescript(0); },
        "butt"                  : function ():* { return CoC.instance.player.buttDescript(); },
        "butthole"              : function ():* { return CoC.instance.player.assholeDescript(); },
        "camp"                  : function ():* { return CoC.instance.player.campDevelopmentStage(); },
        "chest"                 : function ():* { return CoC.instance.player.chestDesc(); },
        "claws"                 : function ():* { return CoC.instance.player.claws(); },
        "clit"                  : function ():* { return CoC.instance.player.clitDescript(); },
        "cock"                  : function ():* { return CoC.instance.player.cockDescript(0); },
        "cockhead"              : function ():* { return CoC.instance.player.cockHead(0); },
        "cocks"                 : function ():* { return CoC.instance.player.multiCockDescriptLight(); },
        "cunt"                  : function ():* { return CoC.instance.player.vaginaDescript(); },
        "eachcock"              : function ():* { return CoC.instance.player.sMultiCockDesc(); },
        "ears"                  : function ():* { return CoC.instance.player.earsDescript(); },
        "evade"                 : function ():* { return "[Evade]"; },
        "eyes"                  : function ():* { return CoC.instance.player.eyesDescript(); },
        "eyecolor"              : function ():* { return CoC.instance.player.eyes.colour; },
        "face"                  : function ():* { return CoC.instance.player.face(); },
        "feet"                  : function ():* { return CoC.instance.player.feet(); },
        "foot"                  : function ():* { return CoC.instance.player.foot(); },
        "fullchest"             : function ():* { return CoC.instance.player.allChestDesc(); },
        "hair"                  : function ():* { return CoC.instance.player.hairDescript(); },
        "haircolor"             : function ():* { return CoC.instance.player.hairColor; },
        "hairorfur"             : function ():* { return CoC.instance.player.hairOrFur(); },
        "he"                    : function ():* { return CoC.instance.player.mf("he", "she"); },
        "he2"                   : function ():* { return CoC.instance.player2.mf("he", "she"); },
        "him"                   : function ():* { return CoC.instance.player.mf("him", "her"); },
        "him2"                  : function ():* { return CoC.instance.player2.mf("him", "her"); },
        "himher"                : function ():* { return CoC.instance.player.mf("him", "her"); },
        "himself"               : function ():* { return CoC.instance.player.mf("himself", "herself"); },
        "herself"               : function ():* { return CoC.instance.player.mf("himself", "herself"); },
        "hips"                  : function ():* { return CoC.instance.player.hipDescript(); },
        "his"                   : function ():* { return CoC.instance.player.mf("his", "her"); },
        "hisher"                : function ():* { return CoC.instance.player.mf("his", "her"); },
        "his2"                  : function ():* { return CoC.instance.player2.mf("his", "her"); },
        "horns"                 : function ():* { return CoC.instance.player.hornDescript(); },
        "leg"                   : function ():* { return CoC.instance.player.leg(); },
        "legs"                  : function ():* { return CoC.instance.player.legs(); },
        "lowergarment"          : function ():* { return CoC.instance.player.lowerGarmentName; },
        "man"                   : function ():* { return CoC.instance.player.mf("man", "woman"); },
        "men"                   : function ():* { return CoC.instance.player.mf("men", "women"); },
        "malefemaleherm"        : function ():* { return CoC.instance.player.maleFemaleHerm(); },
        "master"                : function ():* { return CoC.instance.player.mf("master", "mistress"); },
        "misdirection"          : function ():* { return "[Misdirection]"; },
        "multicock"             : function ():* { return CoC.instance.player.multiCockDescriptLight(); },
        "multicockdescriptlight": function ():* { return CoC.instance.player.multiCockDescriptLight(); },
        "name"                  : function ():* { return CoC.instance.player.short; },
        "nipple"                : function ():* { return CoC.instance.player.nippleDescript(0); },
        "nipples"               : function ():* { return CoC.instance.player.nippleDescript(0) + "s"; },
        "onecock"               : function ():* { return CoC.instance.player.oMultiCockDesc(); },
        "pg"                    : function ():* { return "\n\n"; },
        "pussy"                 : function ():* { return CoC.instance.player.vaginaDescript(); },
        "race"                  : function ():* { return CoC.instance.player.race(); },
        "sack"                  : function ():* { return Appearance.sackDescript(CoC.instance.player); },
        "sheath"                : function ():* { return CoC.instance.player.sheathDescription(); },
        "shield"                : function ():* { return CoC.instance.player.shieldName; },
        "skin"                  : function ():* { return CoC.instance.player.skin.describe('skin', false, false); },
        "skin.noadj"            : function ():* { return CoC.instance.player.skin.describe('skin', true, false); },
        "skin.notone"           : function ():* { return CoC.instance.player.skin.describe('skin', false, true); },
        "skin.type"             : function ():* { return CoC.instance.player.skin.describe('skin', true, true); },
        "skin.color"            : function ():* { return CoC.instance.player.skin.tone; },
        "skin.isare"            : function ():* { return CoC.instance.player.skin.isAre(); },
        "skin.vs"               : function ():* { return CoC.instance.player.skin.isAre("s", ""); },
        "skinfurscales"         : function ():* { return CoC.instance.player.skin.describe('coat'); },
        "skintone"              : function ():* { return CoC.instance.player.skinTone; },
        "tallness"              : function ():* { return Measurements.footInchOrMetres(CoC.instance.player.tallness); },
        "teasetext"             : function ():* { return SceneLib.combat.teaseText(); },
        "tongue"                : function ():* { return Appearance.tongueDescription(CoC.instance.player); },
        "uppergarment"          : function ():* { return CoC.instance.player.upperGarmentName; },
        "vag"                   : function ():* { return CoC.instance.player.vaginaDescript(); },
        "vagina"                : function ():* { return CoC.instance.player.vaginaDescript(); },
        "vagorass"              : function ():* { return (CoC.instance.player.hasVagina() ? CoC.instance.player.vaginaDescript() : CoC.instance.player.assholeDescript()); },
        "weapon"                : function ():* { return CoC.instance.player.weaponName; },
        "weaponname"            : function ():* { return CoC.instance.player.weaponName; },
        "weaponrange"       	: function ():* { return CoC.instance.player.weaponRangeName; },
        "weaponrangename"       : function ():* { return CoC.instance.player.weaponRangeName; },
        "latexyname"            : function ():* { return CoC.instance.flags[kFLAGS.GOO_NAME]; },
        "bathgirlname"          : function ():* { return CoC.instance.flags[kFLAGS.MILK_NAME]; },
        "cockplural"            : function ():* { return (CoC.instance.player.cocks.length == 1) ? "cock" : "cocks"; },
        "dickplural"            : function ():* { return (CoC.instance.player.cocks.length == 1) ? "dick" : "dicks"; },
        "headplural"            : function ():* { return (CoC.instance.player.cocks.length == 1) ? "head" : "heads"; },
        "prickplural"           : function ():* { return (CoC.instance.player.cocks.length == 1) ? "prick" : "pricks"; },
        "boy"                   : function ():* { return CoC.instance.player.mf("boy", "girl"); },
        "guy"                   : function ():* { return CoC.instance.player.mf("guy", "girl"); },
        "wings"                 : function ():* { return CoC.instance.player.wingsDescript(); },
        "tail"                  : function ():* { return CoC.instance.player.tailDescript(); },
        "onetail"               : function ():* { return CoC.instance.player.oneTailDescript(); },

        //Prisoner
        "captortitle": function ():* { return SceneLib.prison.prisonCaptor.captorTitle; },
        "captorname" : function ():* { return SceneLib.prison.prisonCaptor.captorName; },
        "captorhe"   : function ():* { return SceneLib.prison.prisonCaptor.captorPronoun1; },
        "captorhim"  : function ():* { return SceneLib.prison.prisonCaptor.captorPronoun2; },
        "captorhis"  : function ():* { return SceneLib.prison.prisonCaptor.captorPronoun3;}

    };
    /**
     * provides lookups for subject: "arian"
     * note that these are only used in doubleArgLookups
     *
     * unhandled terms (I have not decided how to support them yet):
     * arianMF("mas","mis")
     * arianMF("master","mistress")
     * arianMF("male","girly")
     */
    internal static var arianLookups:Object = {
        "man": function ():String {return SceneLib.arianScene.arianMF("man", "woman"); },
        // argh! "Man" is the mass-noun for humanity, and I'm loathe to choose an even more esoteric variant.
        // Elverson/Spivak terminology is already esoteric enough, and it lacks a ungendered mass noun.

        "ey"    : function ():String {return SceneLib.arianScene.arianMF("he", "she"); },
        "em"    : function ():String {return SceneLib.arianScene.arianMF("him", "her"); },
        "eir"   : function ():String {return SceneLib.arianScene.arianMF("his", "her"); },
        "eirs"  : function ():String {return SceneLib.arianScene.arianMF("his", "hers"); },
        "emself": function ():String {return SceneLib.arianScene.arianMF("himself", "herself"); },

        "chestadj": function ():String {return SceneLib.arianScene.arianChestAdjective(); },
        "chest"   : function ():String {return SceneLib.arianScene.arianChest();}
    };
    /**
     * provides lookups for subject: "rubi"
     * note that these are only used in doubleArgLookups
     *
     * unhandled terms:
     * rubiMF("boy","girl")
     * rubiMF("demon","demoness")
     * rubiMF("gentleman","lady")
     */
    internal static var rubiLookups:Object = {
        "man": function ():String {return SceneLib.telAdre.rubi.rubiMF("man", "woman"); },

        "ey"    : function ():String {return SceneLib.telAdre.rubi.rubiMF("he", "she"); },
        "em"    : function ():String {return SceneLib.telAdre.rubi.rubiMF("him", "her"); },
        "eir"   : function ():String {return SceneLib.telAdre.rubi.rubiMF("his", "her"); },
        "eirs"  : function ():String {return SceneLib.telAdre.rubi.rubiMF("his", "hers"); },
        "emself": function ():String {return SceneLib.telAdre.rubi.rubiMF("himself", "herself"); },

        "cock"   : function ():String {return SceneLib.telAdre.rubi.rubiCock(); },
        "breasts": function ():String {return SceneLib.telAdre.rubi.rubiBreasts();}

    };
    /** PC ASCII Aspect lookups for subject: "cock"*/
    internal static var cockLookups:Object = {
        "all"      : function ():* { return CoC.instance.player.multiCockDescriptLight(); },
        "each"     : function ():* { return CoC.instance.player.sMultiCockDesc(); },
        "one"      : function ():* { return CoC.instance.player.oMultiCockDesc(); },
        "largest"  : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex()); },
        "biggest"  : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex()); },
        "biggest2" : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex2()); },
        "biggest3" : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.biggestCockIndex3()); },
        "smallest" : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex()); },
        "smallest2": function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex2()); },
        "longest"  : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.longestCock()); },
        "shortest" : function ():* { return CoC.instance.player.cockDescript(CoC.instance.player.shortestCockIndex());}
    };
    /** PC ASCII Aspect lookups for subject: "cockHead"*/
    internal static var cockHeadLookups:Object = {
        "biggest"  : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex()); },
        "biggest2" : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex2()); },
        "biggest3" : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex3()); },
        "largest"  : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.biggestCockIndex()); },
        "smallest" : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex()); },
        "smallest2": function ():* { return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex2()); },
        "longest"  : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.longestCock()); },			// the *head* of a cock has a length? Wut?
        "shortest" : function ():* { return CoC.instance.player.cockHead(CoC.instance.player.shortestCockIndex());}
    };
    internal static var monsterLookups:Object = {
        "a"                     : function ():* { return CoC.instance.monster.a; },
        "allbreasts"            : function ():* { return CoC.instance.monster.allBreastsDescript(); },
        "alltits"               : function ():* { return CoC.instance.monster.allBreastsDescript(); },
        "armor"                 : function ():* { return CoC.instance.monster.armorName; },
        "armorname"             : function ():* { return CoC.instance.monster.armorName; },
        "ass"                   : function ():* { return CoC.instance.monster.buttDescript(); },
        "asshole"               : function ():* { return CoC.instance.monster.assholeDescript(); },
        "balls"                 : function ():* { return CoC.instance.monster.ballsDescriptLight(); },
        //			"bodytype"					: function():* { return CoC.instance.monster.bodyType(); },
        "boyfriend"             : function ():* { return CoC.instance.monster.mf("boyfriend", "girlfriend"); },
        "breasts"               : function ():* { return CoC.instance.monster.breastDescript(0); },
        "butt"                  : function ():* { return CoC.instance.monster.buttDescript(); },
        "butthole"              : function ():* { return CoC.instance.monster.assholeDescript(); },
        "chest"                 : function ():* { return CoC.instance.monster.chestDesc(); },
        "claws"                 : function ():* { return CoC.instance.monster.claws(); },
        "clit"                  : function ():* { return CoC.instance.monster.clitDescript(); },
        "cock"                  : function ():* { return CoC.instance.monster.cockDescript(0); },
        "cockhead"              : function ():* { return CoC.instance.monster.cockHead(0); },
        "cocks"                 : function ():* { return CoC.instance.monster.multiCockDescriptLight(); },
        "cunt"                  : function ():* { return CoC.instance.monster.vaginaDescript(); },
        "eachcock"              : function ():* { return CoC.instance.monster.sMultiCockDesc(); },
        "eyes"                  : function ():* { return CoC.instance.monster.eyesDescript(); },
        "eyecolor"              : function ():* { return CoC.instance.monster.eyes.colour; },
        //			"face"						: function():* { return CoC.instance.monster.face(); },
        "feet"                  : function ():* { return CoC.instance.monster.feet(); },
        "foot"                  : function ():* { return CoC.instance.monster.foot(); },
        "fullchest"             : function ():* { return CoC.instance.monster.allChestDesc(); },
        "hair"                  : function ():* { return CoC.instance.monster.hairDescript(); },
        "haircolor"             : function ():* { return CoC.instance.monster.hairColor; },
        "hairorfur"             : function ():* { return CoC.instance.monster.hairOrFur(); },
        "he"                    : function ():* { return CoC.instance.monster.pronoun1; },
		"heshe"					: function ():* { return CoC.instance.monster.mf("he", "she"); },
        "him"                   : function ():* { return CoC.instance.monster.pronoun2; },
        "himher"                : function ():* { return CoC.instance.monster.pronoun2; },
        "himself"               : function ():* { return CoC.instance.monster.mf("himself", "herself"); },
        "herself"               : function ():* { return CoC.instance.monster.mf("himself", "herself"); },
        "hips"                  : function ():* { return CoC.instance.monster.hipDescript(); },
        "his"                   : function ():* { return CoC.instance.monster.pronoun3; },
        "hisher"                : function ():* { return CoC.instance.monster.pronoun3; },
        "horns"                 : function ():* { return CoC.instance.monster.hornDescript(); },
        "leg"                   : function ():* { return CoC.instance.monster.leg(); },
        "legs"                  : function ():* { return CoC.instance.monster.legs(); },
        "lowergarment"          : function ():* { return CoC.instance.monster.lowerGarmentName; },
        "man"                   : function ():* { return CoC.instance.monster.mf("man", "woman"); },
        "men"                   : function ():* { return CoC.instance.monster.mf("men", "women"); },
        "malefemaleherm"        : function ():* { return CoC.instance.monster.maleFemaleHerm(); },
        "master"                : function ():* { return CoC.instance.monster.mf("master", "mistress"); },
        "multicock"             : function ():* { return CoC.instance.monster.multiCockDescriptLight(); },
        "multicockdescriptlight": function ():* { return CoC.instance.monster.multiCockDescriptLight(); },
        "name"                  : function ():* { return CoC.instance.monster.short; },
        "nipple"                : function ():* { return CoC.instance.monster.nippleDescript(0); },
        "nipples"               : function ():* { return CoC.instance.monster.nippleDescript(0) + "s"; },
        "onecock"               : function ():* { return CoC.instance.monster.oMultiCockDesc(); },
        "pussy"                 : function ():* { return CoC.instance.monster.vaginaDescript(); },
        "sack"                  : function ():* { return CoC.instance.monster.sackDescript(); },
        "sheath"                : function ():* { return CoC.instance.monster.sheathDescription(); },
        "shield"                : function ():* { return CoC.instance.monster.shieldName; },
        "skin"                  : function ():* { return CoC.instance.monster.skin.describe('skin', false, false); },
        "skin.noadj"            : function ():* { return CoC.instance.monster.skin.describe('skin', true, false); },
        "skin.notone"           : function ():* { return CoC.instance.monster.skin.describe('skin', false, true); },
        "skin.type"             : function ():* { return CoC.instance.monster.skin.describe('skin', true, true); },
        "skin.color"            : function ():* { return CoC.instance.monster.skin.tone; },
        "skin.isare"            : function ():* { return CoC.instance.monster.skin.isAre(); },
        "skin.vs"               : function ():* { return CoC.instance.monster.skin.isAre("s", ""); },
        "skinfurscales"         : function ():* { return CoC.instance.monster.skin.describe('coat'); },
        "skintone"              : function ():* { return CoC.instance.monster.skinTone; },
        "tallness"              : function ():* { return Measurements.footInchOrMetres(CoC.instance.monster.tallness); },
        "uppergarment"          : function ():* { return CoC.instance.monster.upperGarmentName; },
        "vag"                   : function ():* { return CoC.instance.monster.vaginaDescript(); },
        "vagina"                : function ():* { return CoC.instance.monster.vaginaDescript(); },
        "vagorass"              : function ():* { return (CoC.instance.monster.hasVagina() ? CoC.instance.monster.vaginaDescript() : CoC.instance.monster.assholeDescript()); },
        "weapon"                : function ():* { return CoC.instance.monster.weaponName; },
        "weaponname"            : function ():* { return CoC.instance.monster.weaponName; },
        "weaponrangename"       : function ():* { return CoC.instance.monster.weaponRangeName; },
        "cockplural"            : function ():* { return (CoC.instance.monster.cocks.length == 1) ? "cock" : "cocks"; },
        "dickplural"            : function ():* { return (CoC.instance.monster.cocks.length == 1) ? "dick" : "dicks"; },
        "headplural"            : function ():* { return (CoC.instance.monster.cocks.length == 1) ? "head" : "heads"; },
        "prickplural"           : function ():* { return (CoC.instance.monster.cocks.length == 1) ? "prick" : "pricks"; },
        "boy"                   : function ():* { return CoC.instance.monster.mf("boy", "girl"); },
        "guy"                   : function ():* { return CoC.instance.monster.mf("guy", "girl"); },
        "wings"                 : function ():* { return CoC.instance.monster.wingsDescript(); },
        "tail"                  : function ():* { return CoC.instance.monster.tailDescript(); },
        "onetail"               : function ():* { return CoC.instance.monster.oneTailDescript();}
    };
    /**
     *These tags take a two-word tag with a **numberic** attribute for lookup.
     * [object NUMERIC-attribute]
     * if "NUMERIC-attribute" can be cast to a Number, the parser looks for "object" in twoWordNumericTagsLookup.
     * If it finds twoWordNumericTagsLookup["object"], it calls the anonymous function stored with said key "object"
     * like so: twoWordNumericTagsLookup["object"](Number("NUMERIC-attribute"))
     *
     * if attribute cannot be case to a number, the parser looks for "object" in twoWordTagsLookup.
     */
    internal static var twoWordNumericTagsLookup:Object = {
        "cockfit"     : function (aspect:*):* {
            if (!CoC.instance.player.hasCock()) {
                return "<b>(Attempt to parse cock when none present.)</b>";
            } else {
                if (CoC.instance.player.cockThatFits(aspect) >= 0) {
                    return CoC.instance.player.cockDescript(CoC.instance.player.cockThatFits(aspect));
                } else {
                    return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex());
                }
            }
        },
        "cockfit2"    : function (aspect:*):* {
            if (!CoC.instance.player.hasCock()) {
                return "<b>(Attempt to parse cock when none present.)</b>";
            } else {
                if (CoC.instance.player.cockThatFits2(aspect) >= 0) {
                    return CoC.instance.player.cockDescript(CoC.instance.player.cockThatFits2(aspect));
                } else {
                    return CoC.instance.player.cockDescript(CoC.instance.player.smallestCockIndex());
                }
            }
        },
        "cockheadfit" : function (aspect:*):* {
            if (!CoC.instance.player.hasCock()) {
                return "<b>(Attempt to parse cockhead when none present.)</b>";
            }
            else {
                if (CoC.instance.player.cockThatFits(aspect) >= 0) {
                    return CoC.instance.player.cockHead(CoC.instance.player.cockThatFits(aspect));
                } else {
                    return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex());
                }
            }
        },
        "cockheadfit2": function (aspect:*):* {
            if (!CoC.instance.player.hasCock()) {
                return "<b>(Attempt to parse cockhead when none present.)</b>";
            } else {
                if (CoC.instance.player.cockThatFits2(aspect) >= 0) {
                    return CoC.instance.player.cockHead(CoC.instance.player.cockThatFits2(aspect));
                } else {
                    return CoC.instance.player.cockHead(CoC.instance.player.smallestCockIndex());
                }
            }
        },
        "cock"        : function (aspect:*):* {
            if (!CoC.instance.player.hasCock()) {
                return "<b>(Attempt to parse cock when none present.)</b>";
            } else {
                if (aspect - 1 >= 0 && aspect - 1 < CoC.instance.player.cockTotal()) {
                    return CoC.instance.player.cockDescript(aspect - 1);
                } else {
                    return "<b>(Attempt To Parse CockDescript for Invalid Cock)</b>";
                }
            }
        },
        "cockhead"    : function (aspect:*):* {
            if (!CoC.instance.player.hasCock()) {
                return "<b>(Attempt to parse cockHead when none present.)</b>";
            } else {
                var intAspect:int = int(aspect - 1);
                if (intAspect >= 0 && intAspect < CoC.instance.player.cockTotal()) {
                    return CoC.instance.player.cockHead(intAspect);
                } else {
                    return "<b>(Attempt To Parse CockHeadDescript for Invalid Cock)</b>";
                }
            }
        }

    };

    internal static var skinLookups:Object = {
        "skin"        : skinDescriptionFn("skin", false, false),
        "noadj"       : skinDescriptionFn("skin", true, false),
        "notone"      : skinDescriptionFn("skin", false, true),
        "nocolor"     : skinDescriptionFn("skin", false, true),
        "type"        : skinDescriptionFn("skin", true, true),
        "color"       : function ():* {return CoC.instance.player.skin.color;},
        "color2"      : function ():* {return CoC.instance.player.skin.color2;},
        "isare"       : function ():* {return CoC.instance.player.skin.isAre();},
        "vs"          : function ():* {return CoC.instance.player.skin.isAre("s", "");},
        "base"        : skinDescriptionFn("base", false, false),
        "base.noadj"  : skinDescriptionFn("base", true, false),
        "base.notone" : skinDescriptionFn("base", false, true),
        "base.nocolor": skinDescriptionFn("base", false, true),
        "base.type"   : skinDescriptionFn("base", true, true),
        "base.color"  : function ():* {return CoC.instance.player.skin.base.color;},
        "base.color2" : function ():* {return CoC.instance.player.skin.base.color2;},
        "base.vs"     : function ():* {return CoC.instance.player.skin.base.isAre("s", "");},
        "base.isare"  : function ():* {return CoC.instance.player.skin.base.isAre();},
        "coat"        : skinDescriptionFn("coat", false, false),
        "coat.noadj"  : skinDescriptionFn("coat", true, false),
        "coat.notone" : skinDescriptionFn("coat", false, true),
        "coat.nocolor": skinDescriptionFn("coat", false, true),
        "coat.type"   : skinDescriptionFn("coat", true, true),
        "coat.vs"     : function ():* {return CoC.instance.player.skin.coat.isAre("s", "");},
        "coat.isare"  : function ():* {return CoC.instance.player.skin.coat.isAre();},
        "coat.color"  : function ():* {return CoC.instance.player.coatColor;},
        "coat.color2" : function ():* {return CoC.instance.player.skin.coat.color2;},
        "full"        : skinDescriptionFn("full", false, false),
        "full.noadj"  : skinDescriptionFn("full", true, false),
        "full.notone" : skinDescriptionFn("full", false, true),
        "full.nocolor": skinDescriptionFn("full", false, true),
        "full.type"   : skinDescriptionFn("full", true, true)
    };

    internal static var faceLookups:Object = {
        "full": function ():* {return CoC.instance.player.facePart.describe(false, true);}
    };

    /**
     * These tags take an ascii attribute for lookup.
     * <pre>
     *     [object attribute]
     * </pre>
     * if attribute cannot be cast to a number, the parser looks for "object" in twoWordTagsLookup,
     * and then uses the corresponding object to determine the value of "attribute", by looking for
     * "attribute" twoWordTagsLookup["object"]["attribute"]
     */
    internal static var twoWordTagsLookup:Object = {
        // NPCs:
        "rubi"   : rubiLookups,
        "arian"  : arianLookups,
        "monster": monsterLookups,

        // PC Attributes:

        "cock"    : cockLookups,
        "cockhead": cockHeadLookups,

        "skin": skinLookups,
        "face": faceLookups
    };

    /**
     * Provides the conditionalOptions object
     * Possible text arguments in the conditional of a if statement
     * First, there is an attempt to cast the argument to a Number. If that fails,
     * a dictionary lookup is performed to see if the argument is in the conditionalOptions[]
     * object. If that fails, we just fall back to returning 0
     */
    internal static var conditionalOptions:Object = {
        "strength"      : function ():* { return CoC.instance.player.str; },
        "toughness"     : function ():* { return CoC.instance.player.tou; },
        "speed"         : function ():* { return CoC.instance.player.spe; },
        "intelligence"  : function ():* { return CoC.instance.player.inte; },
        "wisdom"        : function ():* { return CoC.instance.player.wis; },
        "libido"        : function ():* { return CoC.instance.player.lib; },
        "sensitivity"   : function ():* { return CoC.instance.player.sens; },
        "corruption"    : function ():* { return CoC.instance.player.cor; },
        "soulforce"     : function ():* { return CoC.instance.player.soulforce; },
        "mana"          : function ():* { return CoC.instance.player.mana; },
        "fatigue"       : function ():* { return CoC.instance.player.fatigue; },
        "wrath"         : function ():* { return CoC.instance.player.wrath; },
        "hp"            : function ():* { return CoC.instance.player.HP; },
        "hunger"        : function ():* { return CoC.instance.player.hunger; },
        "minute"        : function ():* { return CoC.instance.model.time.minutes; },
        "hour"          : function ():* { return CoC.instance.model.time.hours; },
        "days"          : function ():* { return CoC.instance.model.time.days; },
        "tallness"      : function ():* { return CoC.instance.player.tallness; },
        "hairlength"    : function ():* { return CoC.instance.player.hairLength; },
        "femininity"    : function ():* { return CoC.instance.player.femininity; },
        "masculinity"   : function ():* { return 100 - CoC.instance.player.femininity; },
        "cocks"         : function ():* { return CoC.instance.player.cockTotal(); },
        "breastrows"    : function ():* { return CoC.instance.player.bRows(); },
        "biggesttitsize": function ():* { return CoC.instance.player.biggestTitSize(); },
        "vagcapacity"   : function ():* { return CoC.instance.player.vaginalCapacity(); },
        "analcapacity"  : function ():* { return CoC.instance.player.analCapacity(); },
        "balls"         : function ():* { return CoC.instance.player.balls; },
        "cumquantity"   : function ():* { return CoC.instance.player.cumQ(); },
        "milkquantity"  : function ():* { return CoC.instance.player.lactationQ(); },
        "hasvagina"     : function ():* { return CoC.instance.player.hasVagina(); },
        "istaur"        : function ():* { return CoC.instance.player.isTaur(); },
        "isnaga"        : function ():* { return CoC.instance.player.isNaga(); },
        "isgoo"         : function ():* { return CoC.instance.player.isGoo(); },
        "isbiped"       : function ():* { return CoC.instance.player.isBiped(); },
        "isscylla"      : function ():* { return CoC.instance.player.isScylla(); },
        "hasbreasts"    : function ():* { return (CoC.instance.player.biggestTitSize() >= 1); },
        "hasballs"      : function ():* { return (CoC.instance.player.balls > 0); },
        "hascock"       : function ():* { return CoC.instance.player.hasCock(); },
        "isherm"        : function ():* { return (CoC.instance.player.gender == 3); },
        "cumnormal"     : function ():* { return (CoC.instance.player.cumQ() <= 150); },
        "cummedium"     : function ():* { return (CoC.instance.player.cumQ() > 150 && CoC.instance.player.cumQ() <= 350); },
        "cumhigh"       : function ():* { return (CoC.instance.player.cumQ() > 350 && CoC.instance.player.cumQ() <= 1000); },
        "cumveryhigh"   : function ():* { return (CoC.instance.player.cumQ() > 1000 && CoC.instance.player.cumQ() <= 2500); },
        "cumextreme"    : function ():* { return (CoC.instance.player.cumQ() > 2500); },
        "issquirter"    : function ():* { return (CoC.instance.player.wetness() >= 4); },
        "ispregnant"    : function ():* { return (CoC.instance.player.pregnancyIncubation > 0); },
        "isbuttpregnant": function ():* { return (CoC.instance.player.buttPregnancyIncubation > 0); },
        "hasnipplecunts": function ():* { return CoC.instance.player.hasFuckableNipples(); },
        "canfly"        : function ():* { return CoC.instance.player.canFly(); },
        "islactating"   : function ():* { return (CoC.instance.player.lactationQ() > 0); },
        "true"          : function ():* { return true; },
        "false"         : function ():* { return false; },
	    "silly"         : function ():* { return EngineCore.silly();},

        //Prison
        "esteem": function ():* { return CoC.instance.player.esteem; },
        "obey"  : function ():* { return CoC.instance.player.obey; },
        "will"  : function ():* { return CoC.instance.player.will;}
    };

    internal static function skinDescriptionFn(layer:String, noAdj:Boolean, noTone:Boolean):Function {
        return function ():* { return CoC.instance.player.skin.describe(layer, noAdj, noTone);};
    }
}
}
