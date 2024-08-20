/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.HighMountains.*;
import classes.Scenes.Monsters.LightElfScene;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

use namespace CoC;

public class HighMountains extends BaseContent {
    public var phoenixScene:PhoenixScene = new PhoenixScene();
    public var lightelfScene:LightElfScene = new LightElfScene();
    public var cockatriceScene:CockatriceScene = new CockatriceScene();
    public var nekobakeInn:NekobakeInn = new NekobakeInn();
    
    public const areaLevel:int = 76;
    public function isDiscovered():Boolean {
        return SceneLib.exploration.counters.highMountains > 0;
    }
    public function canDiscover():Boolean {
        return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
    }
    public function timesExplored():int {
        return SceneLib.exploration.counters.highMountains;
    }

    public function HighMountains() {
        onGameInit(init);
    }

    private var _highMountainsEncounter:GroupEncounter = null;
    public function get highMountainsEncounter():GroupEncounter {
        return _highMountainsEncounter;
    }

    //High Mountains: lvl 60-90
	private function init():void {
        _highMountainsEncounter = Encounters.group("highmountains", {
            name: "d3",
			label : "Lethice Stronghold",
			kind  : 'place',
			unique: true,
            when: function ():Boolean {
                return flags[kFLAGS.D3_DISCOVERED] == 0 && player.hasKeyItem("Map to the Lethice’s Fortress") >= 0;
            },
            call: SceneLib.d3.discoverD3
        }, {
            name: "snowangel",
			label : "Snow Angel",
			kind  : 'event',
			unique: true,
            when: function ():Boolean {
                return player.gender > 0 && isChristmas()
                    && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0
                    && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0
                    && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0
                        || player.hasKeyItem("North Star Key") >= 0);
            },
            call: SceneLib.holidays.gatsSpectacularRouter
        }, {
            //Helia monogamy fucks
            name: "helcommon",
			label : "Helia",
			kind  : 'npc',
			unique: true,
            night : false,
            call: SceneLib.helScene.helSexualAmbush,
            chance: highMountainsChance,
            when: SceneLib.helScene.helSexualAmbushCondition
        }, {
            name: "etna",
			label : "Etna",
			kind  : 'npc',
			unique: true,
            when: function ():Boolean {
                return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
                    && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
                    && !player.hasStatusEffect(StatusEffects.EtnaOff)
                    && (player.level >= 20 || flags[kFLAGS.HARDCORE_MODE] == 1);
            },
            chance: highMountainsChance,
            call: SceneLib.etnaScene.repeatYandereEnc
        }, {
            name: "templeofthediving",
			label : "Temple of the Divine",
			kind  : 'place',
			unique: true,
            when: function ():Boolean {
                return flags[kFLAGS.FOUND_TEMPLE_OF_THE_DIVINE] < 1;
            },
            call: SceneLib.templeofdivine.firstvisitintro
        }, {
            name: "phoenix",
			label : "Quasi-Phoenix",
			kind  : 'monster',
            when: SceneLib.dungeons.checkPhoenixTowerClear,
            call: phoenixScene.encounterPhoenix
        }, {
            name: "avianCave",
			label : "Avian Cave",
			kind  : 'event',
            when: function ():Boolean {
                return player.hasKeyItem("Gryphon Statuette") < 0 && player.hasKeyItem("Peacock Statuette") < 0 && player.isRace(Races.AVIAN, 1, false);
            },
            call: caveScene
        }, {
            name: "cockatrice",
			label : "Cockatrice",
			kind  : 'monster',
            night : false,
            when: function ():Boolean {
                return flags[kFLAGS.COCKATRICES_UNLOCKED] > 0;
            },
            call: cockatriceScene.greeting
        }, {
			name: "lightelf",
			label : "Light Elf",
			kind : 'monster',
			call: lightelfScene.introLightELfRanger
		}, {
            name: "lightelf",
			label : "Light Elf",
			kind  : 'monster',
            chance: 0.5,
            call: lightelfScene.introLightELfSniper
        }, {
			name: "fetishevangelist",
			label : "F.Evangelist",
			kind  : 'monster',
			call: SceneLib.lake.fetishCultistScene.fetishCultistHMEncounter
		}, {
			name: "fetishpriest",
			label : "F.Priest",
			kind  : 'monster',
			call: SceneLib.lake.fetishZealotScene.zealotHighMountains
		}, {
            name: "nekobakeInn",
			label : "Nekobake Inn",
			kind  : 'place',
            chance: 0.2,
            unique: true,
            when: function ():Boolean {
                return !player.blockingBodyTransformations();
            },
            call: nekobakeInn.encounterNekobakeInn
        }, {
            name: "demonProjects",
			label : "DemLab Subject",
			kind  : 'monster',
            chance: 0.2,
            when: function ():Boolean {
                return SceneLib.exploration.demonLabProjectEncountersEnabled();
            },
            call: SceneLib.exploration.demonLabProjectEncounters
        });
    }

    public function discover():void {
        clearOutput();
        outputText("While exploring the mountain, you come across a relatively safe way to get at its higher reaches.  You judge that with this route you'll be able to get about two thirds of the way up the mountain.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>High Mountain exploration location unlocked!</b>)");
        SceneLib.exploration.counters.highMountains++;
        endEncounter(120);
    }

    //Explore High Mountain
    public function exploreHighMountain():void {
        explorer.prepareArea(highMountainsEncounter);
        explorer.setTags("mountain","highMountain");
        explorer.prompt = "You explore the high mountains.";
        explorer.onEncounter = function(e:ExplorationEntry):void {
            SceneLib.exploration.counters.highMountains++;
        }
        explorer.leave.hint("Leave the high mountains");
        explorer.skillBasedReveal(areaLevel, timesExplored());
        explorer.doExplore();
    }

	public function highMountainsChance():Number {
		var temp:Number = 0.5;
		temp *= player.npcChanceToEncounter();
		return temp;
	}

    public function caveScene():void {
        clearOutput();
        outputText("Wandering once more around the rocky cliffs on the higher area of the mountains, you find yourself increasingly bores, as you spend the most of the hour tossing aside pebbles and rocks that fell on the path, or crushing the solidified snow with your footwear.\n\n");
        outputText("On the middle of your careless, and surprisingly peaceful stroll, you happen to find an alcove carved on the cliff’s stone. It’s not very big, maybe three or four feet tall, five feet wide and two feet deep, resting one feet above the path ground, so you’re forced to get on your knees to examine it better.\n\n");
        outputText("The alcove itself is seemingly empty, though after a better examination, the back has engraved on the cliff rock a long, detailed inscription. Sadly, you can’t get a word from it, since it’s written in a strange, old language that’s doesn’t barely resemble anything that you’ve found in Mareth. Carved on each side there area stylized figures of avian creatures, ");
        outputText("the most noticeable ones being a gryphon with the wings spread, and in the other side, a peacock doing the same with its tail. As you put your hands on them, you notice a that a shape vaguely resembling a hand forming in the floor of the alcove.\n\n");
        outputText("Tentatively you put one hand on place");
        if (!player.isRace(Races.AVIAN, 1, false)) {
            outputText(", but absolutely nothing happens. Maybe the magic or whatever that thing was supposed to do stopped working long ago? In any case, you had enough looking for a while, and since you’re not getting anything useful from there, you resume your walk.\n\n");
            endEncounter();
        } else {
            outputText(" and gasp in surprise as the figures depicting the creatures at the sides of the alcove recede as you do so, leaving in place two smaller alcoves with two statuettes on them.\n\n");
            outputText("The first one, made on brass and bronze, depicts a fierce looking gryphon in an assault stance. Every bit of the artifact emanates an unnatural strength. On the other side, a statue made of alabaster and ruby gemstones is shaped as a graceful peacock. Strangely, besides being pretty, the way it’s crafted gives you a weird, mystic feel.\n\n");
            outputText("You try to grab both, but as soon as you put your hands in one of them, the alcove with the other starts closing. Seems like you’ll have only one choice here.\n\n");
            menu();
            addButton(0, "Gryphon", caveSceneGryphon);
            addButton(1, "Peacock", caveScenePeacock);
        }
    }

    public function caveSceneGryphon():void {
        outputText("Picking the brass-forged statuette, you immediately feel how its energy rushes through your avian body, invigorating it with an unknown force. Carefully putting it on your bag, you see how the other one is stored away by the hidden mechanism.\n\n");
        outputText("With nothing useful left to you here, you resume your walk and return to your camp with the gryphon idol on your bag.\n\n");
        player.createKeyItem("Gryphon Statuette", 0, 0, 0, 0);
        endEncounter();
    }

    public function caveScenePeacock():void {
        outputText("Picking the alabaster statuette, you immediately feel how its energy rushes through your avian body, invigorating it with an unknown force. Carefully putting it on your bag, you see how the other one is stored away by the hidden mechanism.\n\n");
        outputText("With nothing useful left to you here, you resume your walk and return to your camp with the peacock idol on your bag.\n\n");
        player.createKeyItem("Peacock Statuette", 0, 0, 0, 0);
        endEncounter();
    }
}
}
