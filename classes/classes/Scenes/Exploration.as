/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.DeepSea.Kraken;
import classes.Scenes.Areas.Forest.AlrauneMaiden;
import classes.Scenes.Areas.Forest.WapsHuntress;
import classes.Scenes.Areas.Forest.WaspAssassin;
import classes.Scenes.Areas.Forest.WaspGirl;
import classes.Scenes.Areas.Ocean.Scylla;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.Dungeons.DemonLab.ProjectFlameSpreader;
import classes.Scenes.Dungeons.DemonLab.ProjectNightwalker;
import classes.Scenes.Dungeons.DemonLab.ProjectTyrant;
import classes.Scenes.Dungeons.DemonLab.UltimisFlamespreader;
import classes.Scenes.Dungeons.HiddenCave;
import classes.Scenes.Explore.*;
import classes.Scenes.Monsters.*;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.KihaFollower;
import classes.Scenes.NPCs.RyuBiDragon;
import classes.Scenes.Places.TrollVillage;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

//import classes.Scenes.Areas.nazwa lokacji;
	//import classes.Scenes.Areas.nazwa lokacji;
public class Exploration extends BaseContent implements SaveableState
	{
		public var exploreDebug:ExploreDebug = new ExploreDebug();
		public var hiddencave:HiddenCave = new HiddenCave();
		
		// Discovering an area counts as exploring it for the 1st time
		// It is safe to add/remove areas to this object without changing loadFromObject
		public var counters:Object = {
			explore: 0,
			
			forestOuter: 0,
			forestInner: 0,
			deepwoods: 0,
			
			lake: 0,
			boat: 0,
			
			desertOuter: 0,
			desertInner: 0,
			// desertDeep: 0,
			
			battlefieldBoundary: 0,
			battlefieldOuter: 0,
			
			hills: 0,
			mountainsLow: 0,
			mountainsMid: 0,
			highMountains: 0,
			
			plains: 0,
			
			swamp: 0,
			bog: 0,
			
			blightRidge: 0,
			defiledRavine: 0,
			
			beach: 0,
			ocean: 0,
			// deepSea: 0,
			
			caves: 0,
			// deepCaves or cavesDeep: 0,
			
			tundra: 0,
			glacialRiftOuter: 0,
			
			ashlands: 0,
			volcanicCragOuter: 0
		};
		private var emptyCounters:Object = deepCopy(counters);
		public function resetState():void {
			counters = deepCopy(emptyCounters);
		}
		public function stateObjectName():String {
			return "Exploration";
		}
		public function saveToObject():Object {
			return {
				"counters": deepCopy(counters)
			}
		}
		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o && "counters" in o) {
				// Fill counters with empty counters, then with contents of `o`
				extend(counters, emptyCounters, o["counters"]);
				// Validate counters - delete bad fields and convert to int if needed
				for (var k:String in counters) {
					if (!(k in emptyCounters)) delete counters[k];
					else counters[k] = int(counters[k]);
				}
			} else {
				resetState();
			}
		}
		public function Exploration()
		{
			Saves.registerSaveableState(this);
			onGameInit(init);
		}

		public function furriteMod():Number {
			return furriteFnGen()();
		}

		public function lethiteMod():Number {
			return lethiteFnGen()();
		}

		// Why? Because what if you want to alter the iftrue/iffalse?
		// Default values: mods:[SceneLib.exploration.furriteMod]
		// Non-default:    mods:[SceneLib.exploration.furriteFnGen(4,0)]

		public function furriteFnGen(iftrue:Number = 3, iffalse:Number = 1):Function {
			return function ():Number {
				return player.hasPerk(PerkLib.PiercedFurrite) ? iftrue : iffalse;
			}
		}

		public function lethiteFnGen(iftrue:Number = 3, iffalse:Number = 1):Function {
			return function ():Number {
				return player.hasPerk(PerkLib.PiercedLethite) ? iftrue : iffalse;
			}
		}
		private function btnExploreForestOutskirts():ButtonData {
			return new ButtonData("Forest (O)", SceneLib.forest.exploreForestOutskirts)
					.hint("Visit the lush forest. "
							+ "\n\nTimes explored: " + SceneLib.forest.timesExploredOuter())
					.disableIf(!SceneLib.forest.isDiscoveredOuter(), "You need to 'Explore' Mareth more." +
							" (Lvl "+SceneLib.forest.discoverLevelOuter+"+)")
		}
		private function btnExploreForestInner():ButtonData {
			return new ButtonData("Forest (I)", SceneLib.forest.exploreInnerForest)
					.hint("Visit the lush forest. "
							+ (player.level < 12 ? "\n\nBeware of Tentacle Beasts!" : "")
							+ "\n\nTimes explored: " + SceneLib.forest.timesExploredInner())
					.disableIf(!SceneLib.forest.isDiscoveredInner(), "You need to be ready (lvl 3+) to reach this area." +
							" (Lvl "+SceneLib.forest.areaLevelInner+"+)");
		}
		private function btnExploreDeepwoods():ButtonData {
			return new ButtonData("Deepwoods", SceneLib.forest.exploreDeepwoods)
					.hint("Visit the dark, bioluminescent deepwoods. "
							+ (debug ? "\n\nTimes explored: " + SceneLib.forest.timesExploredDeepwoods() : ""))
					.disableIf(!SceneLib.forest.isDiscoveredDeepwoods(), "Discovered when exploring Forest (I)." +
							" (Lvl "+SceneLib.forest.areaLevelDeepwoods+"+)");
		}
		private function btnExploreLake():ButtonData {
			return new ButtonData("Lake", SceneLib.lake.exploreLake)
					.hint("Visit the lake and explore the beach. "
							+ (player.level < 3 ? "\n\nLooks like it's still quiet here!" : "")
							+ "\n\nTimes explored: " + SceneLib.lake.timesExplored())
					.disableIf(!SceneLib.lake.isDiscovered(), "You need to 'Explore' Mareth more." +
							" (Lvl "+SceneLib.lake.discoverLevel+"+)");
		}
		private function btnExploreLakeBoat():ButtonData {
			return new ButtonData("Boat", SceneLib.boat.boatExplore)
					.hint("Get on the boat and explore the lake. \n\nRecommended level: 12" +
							"\n\nTimes explored: " + SceneLib.boat.timesExplored())
					.disableIf(!SceneLib.boat.isDiscovered(), "Search the lake." +
							" (Lvl "+SceneLib.boat.discoverLevel+"+)");
		}
		private function btnExploreDesertOuter():ButtonData {
			return new ButtonData("Desert (O)", SceneLib.desert.exploreOuterDesert)
					.hint("Visit the dry desert (outer part). "
							+ "\n\nTimes explored: " + SceneLib.desert.timesExploredOuter())
					.disableIf(!SceneLib.desert.isDiscoveredOuter(), "You need to 'Explore' Mareth more." +
							" (Lvl "+SceneLib.desert.discoverLevelOuter+"+)");
		}
		private function btnExploreDesertInner():ButtonData {
			return new ButtonData("Desert (I)", SceneLib.desert.exploreInnerDesert)
					.hint("Visit the dry desert (inner part). "
							+ "\n\nTimes explored: " + SceneLib.desert.timesExploredInner())
					.disableIf(!SceneLib.desert.isDiscoveredInner(), "Discovered when exploring Desert (Outer)." +
							" (Lvl "+SceneLib.desert.areaLevelInner+"+)");
		}
		private function btnExploreBattlefieldBoundary():ButtonData {
			return new ButtonData("Battlefield (B)", SceneLib.battlefiledboundary.exploreBattlefieldBoundary)
					.hint("Visit the battlefield boundary. "
							+ (player.level < 16 ? "\n\nIt's still too dangerous place to visit lightly!" : "")
							+ "\n\nTimes explored: " + SceneLib.battlefiledboundary.timesExplored())
					.disableIf(!SceneLib.battlefiledboundary.isDiscovered(), "Discovered when using 'Explore' after finding Desert (Outer)." +
							" (Lvl "+SceneLib.battlefiledboundary.discoverLevel+"+)")
		}
		private function btnExploreBattlefieldOuter():ButtonData {
			return new ButtonData("Battlefield (O)", SceneLib.battlefiledouter.exploreOuterBattlefield)
					.hint("Visit the outer battlefield. "
							+ (player.level < 18 ? "\n\nIt's still too dangerous place to visit lightly!" : "")
							+ "\n\nTimes explored: " + SceneLib.battlefiledouter.timesExplored())
					.disableIf(!SceneLib.battlefiledouter.isDiscovered(), "Discovered when exploring Battlefield (Boundary)." +
							" (Lvl "+SceneLib.battlefiledouter.areaLevel+"+)")
		}
		private function btnExploreHills():ButtonData {
			return new ButtonData("Hills", SceneLib.mountain.exploreHills)
					.hint("Visit the hills. "
							+ "\n\nTimes explored: " + SceneLib.mountain.timesExploredHills())
					.disableIf(!SceneLib.mountain.isDiscoveredHills(), "Discovered when using 'Explore' after finding Battlefield (Boundary)." +
							" (Lvl "+SceneLib.mountain.areaLevelHills+"+)");
		}
		private function btnExploreMountainsLow():ButtonData {
			return new ButtonData("Low Mountain", SceneLib.mountain.exploreLowMountain)
					.hint("Visit the low mountains. "
							+ "\n\nTimes explored: " + SceneLib.mountain.timesExploredLow())
					.disableIf(!SceneLib.mountain.isDiscoveredLow(), "Discovered when exploring Hills." +
							" (Lvl "+SceneLib.mountain.areaLevelLow+"+)");
		}
		private function btnExploreMountainsMid():ButtonData {
			return new ButtonData("Mountain", SceneLib.mountain.exploreMidMountain)
					.hint("Visit the mountain. "
							+ "\n\nTimes explored: " + SceneLib.mountain.timesExploredMid())
					.disableIf(!SceneLib.mountain.isDiscoveredMid(), "Discovered when exploring Low Mountains." +
							" (Lvl "+SceneLib.mountain.areaLevelMid+"+)");
		}
		private function btnExploreMountainsHigh():ButtonData {
			return new ButtonData("High Mountain", SceneLib.highMountains.exploreHighMountain)
					.hint("Visit the high mountains where basilisks and harpies are found. "
							+ "\n\nTimes explored: " + SceneLib.highMountains.timesExplored())
					.disableIf(!SceneLib.highMountains.isDiscovered(), "Discovered when exploring Mountain." +
							" (Lvl "+SceneLib.highMountains.areaLevel+"+)");
		}
		private function btnExplorePlains():ButtonData {
			return new ButtonData("Plains", SceneLib.plains.explorePlains)
					.hint("Visit the plains. "
							+ "\n\nTimes explored: " + SceneLib.plains.timesExplored())
					.disableIf(!SceneLib.plains.isDiscovered(), "Discovered when using 'Explore' after finding Hills." +
							" (Lvl "+SceneLib.plains.areaLevel+"+)");
		}
		private function btnExploreSwamp():ButtonData {
			return new ButtonData("Swamp", SceneLib.swamp.exploreSwamp)
					.hint("Visit the wet swamplands. "
							+ "\n\nTimes explored: " + SceneLib.swamp.timesExplored())
					.disableIf(!SceneLib.swamp.isDiscovered(), "Discovered when using 'Explore' after finding Plains." +
							" (Lvl "+SceneLib.swamp.areaLevel+"+)");
		}
		private function btnExploreBog():ButtonData {
			return new ButtonData("Bog", SceneLib.bog.exploreBog)
					.hint("Visit the dark bog. \n\nRecommended level: 28"
							+ "\n\nTimes explored: " + SceneLib.bog.timesExplored())
					.disableIf(!SceneLib.bog.isDiscovered(), "Discovered when exploring Swamp." +
							" (Lvl "+SceneLib.bog.areaLevel+"+)");
		}
		private function btnExploreBlightRidge():ButtonData {
			return new ButtonData("Blight Ridge", SceneLib.blightridge.exploreBlightRidge)
					.hint("Visit the corrupted blight ridge. "
							+ "\n\nTimes explored: " + SceneLib.blightridge.timesExplored())
					.disableIf(!SceneLib.blightridge.isDiscovered(), "Discovered when using 'Explore' after finding Swamp." +
							" (Lvl "+SceneLib.blightridge.areaLevel+"+)");
		}
		private function btnExploreDefiledRavine():ButtonData {
			return new ButtonData("Defiled Ravine", SceneLib.defiledravine.exploreDefiledRavine)
					.hint("Visit the defiled ravine. \n\nRecommended level: 41"
							+ "\n\nTimes explored: " + SceneLib.defiledravine.timesExplored())
					.disableIf(!SceneLib.defiledravine.isDiscovered(), "Discovered when exploring Blight Ridge." +
							" (Lvl "+SceneLib.defiledravine.areaLevel+"+)");
		}
		private function btnExploreBeach():ButtonData {
			return new ButtonData("Beach", SceneLib.beach.exploreBeach)
					.hint("Visit the sunny beach. "
							+ "\n\nTimes explored: " + SceneLib.beach.timesExplored())
					.disableIf(!SceneLib.beach.isDiscovered(), "Discovered when using 'Explore' after finding Blight Ridge." +
							" (Lvl "+SceneLib.beach.areaLevel+"+)");
		}
		private function btnExploreOcean():ButtonData {
			return new ButtonData("Ocean", SceneLib.ocean.exploreOcean)
					.hint("Explore the ocean surface. But beware of... sharks. "
							+ "\n\nTimes explored: " + SceneLib.ocean.timesExplored())
					.disableIf(!SceneLib.ocean.isDiscovered(), "You need to find first some way to sail over the water surface to explore this area.")
					.disableIf(!SceneLib.beach.isDiscovered(), "Need to find Beach first and then finding some way to sail on the water.");
		}
		private function btnExploreCaves():ButtonData {
			return new ButtonData("Caves", SceneLib.caves.exploreCaves)
					.hint("Visit the gloomy caves. "
							+ "\n\nTimes explored: " + SceneLib.caves.timesExplored())
					.disableIf(!SceneLib.caves.isDiscovered(), "Discovered when using 'Explore' after finding Beach." +
							" (Lvl "+SceneLib.caves.areaLevel+"+)");
		}
		private function btnExploreTundra():ButtonData {
			return new ButtonData("Tundra", SceneLib.tundra.exploreTundra)
					.hint("Visit the tundra. "
							+ "\n\nTimes explored: " + SceneLib.tundra.timesExplored())
					.disableIf(!SceneLib.tundra.isDiscovered(), "Discovered when exploring Caves." +
							" (Lvl "+SceneLib.tundra.areaLevel+"+)");
		}
		private function btnExploreGlacialRiftOuter():ButtonData {
			return new ButtonData("Glacial Rift(O)", SceneLib.glacialRift.exploreGlacialRift)
					.hint("Visit the chilly glacial rift (outer part). "
							+ "\n\nTimes explored: " + SceneLib.glacialRift.timesExplored())
					.disableIf(!SceneLib.glacialRift.isDiscovered(), "Discovered when exploring Tundra." +
							" (Lvl "+SceneLib.glacialRift.areaLevel+"+)");
		}
		private function btnExploreAshlands():ButtonData {
			return new ButtonData("Ashlands", SceneLib.ashlands.exploreAshlands)
					.hint("Visit the ashlands. "
							+ "\n\nTimes explored: " + SceneLib.ashlands.timesExplored())
					.disableIf(!SceneLib.ashlands.isDiscovered(), "Discovered when exploring Caves." +
							" (Lvl "+SceneLib.ashlands.areaLevel+"+)");
		}
		private function btnExploreVolcanicCragOuter():ButtonData {
			return new ButtonData("VolcanicCrag(O)", SceneLib.volcanicCrag.exploreVolcanicCrag)
					.hint("Visit the infernal volcanic crag (outer part). "
							+ "\n\nTimes explored: " + SceneLib.volcanicCrag.timesExplored())
					.disableIf(!SceneLib.volcanicCrag.isDiscovered(), "Discovered when exploring Ashlands." +
							" (Lvl "+SceneLib.volcanicCrag.areaLevel+"+)");
		}
		
		public function doExplore():void {
			clearOutput();
			if (SceneLib.exploration.counters.explore <= 0) {
				outputText("You tentatively step away from your campsite, alert and scanning the ground and sky for danger.  You walk for the better part of an hour, marking the rocks you pass for a return trip to your camp.  It worries you that the portal has an opening on this side, and it was totally unguarded...\n\n...Wait a second, why is your campsite in front of you? The portal's glow is clearly visible from inside the tall rock formation. Even the warning sign about the cursed site or worn down training dummy you found when looking around camp earlier are here. Looking carefully, you see your footprints leaving the opposite side of your camp, then disappearing. You look back the way you came and see your markings vanish before your eyes. ");
				outputText("The implications boggle your mind as you do your best to mull over them. Distance, direction, and geography seem to have little meaning here, yet your campsite remains exactly as you left it. A few things click into place as you realize you found your way back just as you were mentally picturing the portal! Perhaps memory influences travel here, just like time, distance, and speed would in the real world!\n\nThis won't help at all with finding new places, but at least you can get back to camp quickly. You are determined to stay focused the next time you explore and learn how to traverse this gods-forsaken realm.");
				player.createStatusEffect(StatusEffects.EzekielCurse, 0, 0, 0, 0);
				doNext(tryDiscover);
				return;
			} else if (SceneLib.exploration.counters.explore > 1) outputText("You can continue to search for new locations, or explore your previously discovered locations.\n");
			if (flags[kFLAGS.EXPLORE_MENU_STYLE] == 1) {
				oldExploreMenu();
				return;
			}
			hideMenus();
			menu();
			var bd:ButtonDataList = new ButtonDataList();
			// Row 1
			bd.append(btnExploreForestOutskirts());
			bd.append(btnExploreForestInner());
			bd.append(btnExploreDeepwoods());
			bd.add("");
			bd.add("");
			// Row 2
			bd.append(btnExploreLake());
			bd.append(btnExploreLakeBoat());
			//bd.add("Shore").hint("TBA"); //Discovered when exploring using Lake Boat.
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 3
			bd.append(btnExploreDesertOuter());
			bd.append(btnExploreDesertInner());
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 4
			bd.append(btnExploreBattlefieldBoundary());
			bd.append(btnExploreBattlefieldOuter());
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 5
			bd.append(btnExploreHills());
			bd.append(btnExploreMountainsLow());
			bd.append(btnExploreMountainsMid());
			bd.append(btnExploreMountainsHigh());
			bd.add("");
			// Row 6
			bd.append(btnExplorePlains());
			bd.add(""); // plains inner part
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 7
			bd.append(btnExploreSwamp());
			bd.append(btnExploreBog());
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 8
			bd.append(btnExploreBlightRidge());
			bd.append(btnExploreDefiledRavine());
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 9
			bd.append(btnExploreBeach());
			bd.append(btnExploreOcean());
			bd.add(""); // Deep Sea
			// if (flags[kFLAGS.DISCOVERED_DEEP_SEA] > 0 && player.canSwimUnderwater()) addButton(2, "Deep Sea", SceneLib.deepsea.exploreDeepSea).hint("Visit the 'almost virgin' deep sea. But beware of... krakens. " + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_DEEP_SEA] : ""));
			bd.add("");
			bd.add("");
			// Row 10
			bd.append(btnExploreCaves());
			bd.add("");
			bd.add("");
			bd.add("");
			bd.add("");
			// Row 11
			bd.add("");
			bd.append(btnExploreTundra());
			bd.append(btnExploreGlacialRiftOuter());
			bd.add("");
			bd.add("");
			// Row 12
			bd.add("");
			bd.append(btnExploreAshlands());
			bd.append(btnExploreVolcanicCragOuter());
			bd.add("");
			bd.add("");
			
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(5, "",	//Wuxia related area - ?latająca wyspa?
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(9, "",	//Wuxia related area - ?latająca wyspa?
			//if (flags[kFLAGS.DISCOVERED_PIT] > 0) addButton(10, "Pit", CoC.instance.abyss.explorePit).hint("Visit the pit. " + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_PIT] : ""));
			//if (flags[kFLAGS.DISCOVERED_ABYSS] > 0) addButton(12, "Abyss", CoC.instance.abyss.exploreAbyss).hint("Visit the abyss. " + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_ABYSS] : ""));
			
			
			bigButtonGrid(bd);
			addButton(0, "Explore", tryDiscover)
					.hint("Explore to find new regions and visit any discovered regions.");
			addButton(4, "Menu Style", toggleMenuStyle)
					.hint("Switch to old menu style");
			addButton(5, "LL Explore", tryDiscoverLL)
					.hint("Explore to find weakest new enemies.")
					.disableIf(player.level < 31,"Req. lvl 31+");
			addButton(6, "ML Explore", tryDiscoverML)
					.hint("Explore to find weaker new enemies.")
					.disableIf(player.level < 51,"Req. lvl 51+");
			addButton(7, "HL Explore", tryDiscoverHL)
					.hint("Explore to find below averange new enemies.")
					.disableIf(player.level < 70,"Req. lvl 70+");
			addButton(8, "XHL Explore", tryDiscoverXHL)
					.hint("Explore to find bit above averange new enemies.")
					.disableIf(player.level < 95,"Req. lvl 95+");
			addButton(9, "XXHL Explore", tryDiscoverXXHL)
					.hint("Explore to find strong new enemies.")
					.disableIf(player.level < 125,"Req. lvl 125+");
			addButton(12, "42", tryRNGod)
					.hint("Explore to find the answer for your prayers. Or maybe you really not wanna find it, fearing answer will not be happy with you?")
					.disableIf(!silly(), "Only in Silly Mode...", "???");
			if (debug) addButton(13, "Debug", exploreDebug.doExploreDebug);
			addButton(14, "Back", playerMenu);
		}
		
		private function toggleMenuStyle():void {
			flags[kFLAGS.EXPLORE_MENU_STYLE] = 1 - flags[kFLAGS.EXPLORE_MENU_STYLE];
			doExplore();
		}
		
		private function oldExploreMenu():void {
			if (flags[kFLAGS.EXPLORATION_PAGE] == 2) {
				explorePageII();
				return;
			}
			if (flags[kFLAGS.EXPLORATION_PAGE] == 3) {
				explorePageIII();
				return;
			}
			if (flags[kFLAGS.EXPLORATION_PAGE] == 4) {
				explorePageIV();
				return;
			}
			if (flags[kFLAGS.EXPLORATION_PAGE] == 5) {
				explorePageV();
				return;
			}
			hideMenus();
			menu();
			addButton(0, "Explore", tryDiscover).hint("Explore to find new regions and visit any discovered regions.");
			btnExploreForestOutskirts().applyTo(button(1));
			btnExploreLake().applyTo(button(2));
			btnExploreDesertOuter().applyTo(button(3));
			
			btnExploreBattlefieldBoundary().applyTo(button(5));
			btnExploreHills().applyTo(button(6));
			btnExplorePlains().applyTo(button(7));
			btnExploreSwamp().applyTo(button(8));
			
			btnExploreBlightRidge().applyTo(button(10));
			btnExploreBeach().applyTo(button(11));
			btnExploreCaves().applyTo(button(12));
			
			addButton(4, "Next", explorePageII);
			addButton(9, "Menu Style", toggleMenuStyle).hint("Switch to new menu style");
			if (debug) addButton(13, "Debug", exploreDebug.doExploreDebug);
			
			addButton(14, "Back", playerMenu);
		}
		
		private function explorePageII():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 2;
			hideMenus();
			menu();
			
			btnExploreBattlefieldOuter().applyTo(button(0));
			btnExploreForestInner().applyTo(button(1));
			btnExploreLakeBoat().applyTo(button(2));
			btnExploreDesertInner().applyTo(button(3));
			
			btnExploreDefiledRavine().applyTo(button(5));
			btnExploreMountainsLow().applyTo(button(6));
			// 7 - plains inner part
			btnExploreBog().applyTo(button(8));
			
			btnExploreTundra().applyTo(button(10));
			btnExploreAshlands().applyTo(button(11));
			//12 - darkness area
			//13 - lightning area
			
			addButton(4, "Next", explorePageIII);
			addButton(9, "Previous", goBackToPageI);
			if (debug) addButton(13, "Debug", exploreDebug.doExploreDebug);
			addButton(14, "Back", playerMenu);
		}
		
		private function explorePageIII():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 3;
			hideMenus();
			menu();
			// 0 - battlefield inner part
			btnExploreDeepwoods().applyTo(button(1));
			//addButtonDisabled(2, "Shore", "TBA");//Discovered when exploring using Lake Boat.
			
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(5, "",	//Wuxia related area - ?latająca wyspa?
			//if (flags[kFLAGS.DISCOVERED_] > 0) addButton(9, "",	//Wuxia related area - ?latająca wyspa?
			//if (flags[kFLAGS.DISCOVERED_PIT] > 0) addButton(5, "Pit", CoC.instance.abyss.explorePit).hint("Visit the pit. " + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_PIT] : ""));
			//if (flags[kFLAGS.DISCOVERED_ABYSS] > 0) addButton(5, "Abyss", CoC.instance.abyss.exploreAbyss).hint("Visit the abyss. " + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_ABYSS] : ""));
			btnExploreMountainsMid().applyTo(button(6));
			btnExploreOcean().applyTo(button(8));
			
			btnExploreGlacialRiftOuter().applyTo(button(10));
			btnExploreVolcanicCragOuter().applyTo(button(11));
			
			addButton(4, "Next", goBackToPageIV);
			addButton(9, "Previous", goBackToPageII);
			if (debug) addButton(13, "Debug", exploreDebug.doExploreDebug);
			addButton(14, "Back", playerMenu);
		}
		
		private function explorePageIV():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 4;
			hideMenus();
			menu();
			
			btnExploreMountainsHigh().applyTo(button(6));
			//if (flags[kFLAGS.DISCOVERED_DEEP_SEA] > 0 && player.canSwimUnderwater()) addButton(8, "Deep Sea", SceneLib.deepsea.exploreDeepSea).hint("Visit the 'almost virgin' deep sea. But beware of... krakens. " + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_DEEP_SEA] : ""));
			
			addButton(4, "Next", goBackToPageV);
			addButton(9, "Previous", goBackToPageIII);
			if (debug) addButton(13, "Debug", exploreDebug.doExploreDebug);
			addButton(14, "Back", playerMenu);
		}
		
		private function explorePageV():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 5;
			hideMenus();
			menu();
			if (player.level >= 31) addButton(0, "LL Explore", tryDiscoverLL).hint("Explore to find weakest new enemies.");
			else addButtonDisabled(0, "LL Explore", "Req. lvl 31+");
			if (player.level >= 51) addButton(1, "ML Explore", tryDiscoverML).hint("Explore to find weaker new enemies.");
			else addButtonDisabled(1, "ML Explore", "Req. lvl 51+");
			if (player.level >= 70) addButton(2, "HL Explore", tryDiscoverHL).hint("Explore to find below averange new enemies.");
			else addButtonDisabled(2, "HL Explore", "Req. lvl 70+");
			if (player.level >= 95) addButton(3, "XHL Explore", tryDiscoverXHL).hint("Explore to find bit above averange new enemies.");
			else addButtonDisabled(3, "XHL Explore", "Req. lvl 95+");
			if (player.level >= 125) addButton(4, "XXHL Explore", tryDiscoverXXHL).hint("Explore to find strong new enemies.");
			else addButtonDisabled(4, "XXHL Explore", "Req. lvl 125+");
			
			addButton(9, "Previous", goBackToPageIV);
			if (silly()) addButton(12, "42", tryRNGod).hint("Explore to find the answer for your prayers. Or maybe you really not wanna find it fearing answer will not be happy with you?");
			else addButtonDisabled(12, "???", "Only in Silly Mode...");
			if (debug) addButton(13, "Debug", exploreDebug.doExploreDebug);
			addButton(14, "Back", playerMenu);
		}
		
		private function goBackToPageI():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 1;
			doExplore();
		}
		
		private function goBackToPageII():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 2;
			doExplore();
		}
		
		private function goBackToPageIII():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 3;
			doExplore();
		}
		
		private function goBackToPageIV():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 4;
			doExplore();
		}
		
		private function goBackToPageV():void {
			flags[kFLAGS.EXPLORATION_PAGE] = 5;
			doExplore();
		}
		
		private function golemEncountBasic():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered dummy golem! You ready your [weapon] for a fight!");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_GOLEMS);
			startCombat(new GolemDummy());
		}
		private function golemEncounterImproved():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered improved dummy golem! You ready your [weapon] for a fight!");
			startCombat(new GolemDummyImproved());
		}
		private function golemEncounterAdvanced():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered advanced dummy golem! You ready your [weapon] for a fight!");
			startCombat(new GolemDummyAdvanced());
		}
		private function golemEncounterAdvancedGroup():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge group of golems. Looks like you have encountered advanced dummy golems! You ready your [weapon] for a fight!");
			startCombat(new GolemsDummyAdvanced());
		}
		private function golemEncounterSuperior():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered superior dummy golem! You ready your [weapon] for a fight!");
			startCombat(new GolemDummySuperior());
		}
		private function golemEncounterSuperiorGroup():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge group of golems. Looks like you have encountered superior dummy golems! You ready your [weapon] for a fight!");
			startCombat(new GolemsDummySuperior());
		}
		private function golemEncounterTrueBasic():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered basic true golem! You ready your [weapon] for a fight!");
			startCombat(new GolemTrueBasic());
		}
		private function golemEncounterTrueBasicGroup():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge group of golems. Looks like you have encountered basic true golems! You ready your [weapon] for a fight!");
			startCombat(new GolemsTrueBasic());
		}
		private function golemEncounterTrueImproved():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered improved true golem! You ready your [weapon] for a fight!");
			startCombat(new GolemTrueImproved());
		}
		private function golemEncounterTrueImprovedGroup():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge group of golems. Looks like you have encountered improved true golems! You ready your [weapon] for a fight!");
			startCombat(new GolemsTrueImproved());
		}
		private function golemEncounterTrueAdvanced():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge golem. Looks like you have encountered advanced true golem! You ready your [weapon] for a fight!");
			startCombat(new GolemTrueAdvanced());
		}
		private function golemEncounterTrueAdvancedGroup():void {
			clearOutput();
			outputText("As you take a stroll, out of nearby bushes emerge group of golems. Looks like you have encountered advanced true golems! You ready your [weapon] for a fight!");
			startCombat(new GolemsTrueAdvanced());
		}
		
		private function feralImpEncounter():void {
			clearOutput();
			spriteSelect(SpriteDb.s_imp);
			outputText("A feral imp wings out of the sky and attacks!");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
			flags[kFLAGS.FERAL_EXTRAS] = 1;
			startCombat(new FeralImps());
		}
		private function impEncounter():void {
			clearOutput();
			spriteSelect(SpriteDb.s_imp);
			outputText("An imp wings out of the sky and attacks!");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
			startCombat(new Imp());
		}
		public function genericGobImpAngEncounters(even:Boolean = false):void {
			var gobImpAngChooser:int = rand(20);
			if (gobImpAngChooser >= 8) SceneLib.goblinScene.goblinShamanEncounter();
			//else if (gobImpAngChooser >= 16) angeloid
			//else if (gobImpAngChooser >= 18) angeloid
			else {
				SceneLib.impScene.impOverlordEncounter();
				spriteSelect(SpriteDb.s_impOverlord);
			}
		}
		public function genericImpEncounters2(even:Boolean = false):void {
			var sss:Number = 75;
			if (player.level >= 16) sss += 25;
			//Imptacular Encounter
			var impChooser:int = rand(sss);
			//Imp Warlord
			if (impChooser >= 50 && impChooser < 75) {
				if (rand(4) == 0) SceneLib.impScene.impWarlordFeralEncounter();
				else SceneLib.impScene.impWarlordEncounter();
				spriteSelect(SpriteDb.s_impWarlord);
				return;
			}
			//Imp Overlord
			else if (impChooser >= 75) {
				SceneLib.impScene.impOverlordEncounter();
				spriteSelect(SpriteDb.s_impOverlord);
				return;
			}
			//Pack of Imps
			else {
				if (rand(4) == 0) SceneLib.impScene.impPackEncounter2();
				else SceneLib.impScene.impPackEncounter();
				return;
			}
		}
		public function genericDemonsEncounters1(even:Boolean = false):void {
			//Imptacular Encounter
			var demonChooser:int = rand(15);
			//Succubus
			if (demonChooser >= 5 && demonChooser < 10) {
				SceneLib.defiledravine.demonScene.SuccubusEncounter();
				return;
			}
			//Incubus
			else if (demonChooser >= 10) {
				SceneLib.defiledravine.demonScene.IncubusEncounter();
				return;
			}
			//Omnibus
			else {
				SceneLib.defiledravine.demonScene.OmnibusEncounter();
				return;
			}
		}
		public function genericGolemsEncounters1(even:Boolean = false):void {
			var sss:Number = 10;
			if (player.level >= 12) sss += 10;
			if (player.level >= 18) sss += 10;
			if (player.level >= 24) sss += 10;
			if (player.level >= 33) sss += 10;
			var golemsChooser:int = rand(sss);
			//Limit chooser range
			clearOutput();
			//Improved dummy golems
			if (golemsChooser >= 10 && golemsChooser < 20) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered improved dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyImproved());
				return;
			}
			//Advanced dummy golems
			if (golemsChooser >= 20 && golemsChooser < 30) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered advanced dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummyAdvanced());
				return;
			}
			//Superior dummy golems
			if (golemsChooser >= 30 && golemsChooser < 40) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered superior dummy golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsDummySuperior());
				return;
			}
			//Basic true golems
			if (golemsChooser >= 40 && golemsChooser < 50) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered basic true golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsTrueBasic());
				return;
			}
			//Improved true golems
			if (golemsChooser >= 50) {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered improved true golems! You ready your [weapon] for a fight!");
				startCombat(new GolemsTrueImproved());
				return;
			}
			//Dummy golems
			else {
				outputText("As you take a stroll, from behind of nearby combatants remains emerge group of golems. Looks like you have encountered dummy golems! You ready your [weapon] for a fight!");
				camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_GOLEMS);
				startCombat(new GolemsDummy());
				return;
			}
		}
		public function genericGobImpEncounters1(even:Boolean = false):void {
			var sss:Number = 20;
			if (player.level >= 18) sss += 10;
			if (player.level >= 30) sss += 10;
			var gobimpChooser:int = rand(sss);
			//Limit chooser range
			clearOutput();
			if (gobimpChooser >= 10 && gobimpChooser < 20) {
				SceneLib.impScene.impPackEncounter2();
			}
			else if (gobimpChooser >= 20 && gobimpChooser < 30) {
				if (rand(10) == 0 && flags[kFLAGS.ANGELIC_FRACTION_TOGGLE] == 0) SceneLib.angelScene.angeloidGroupEncounter();
				else SceneLib.impScene.impPackEncounter();
			}
			else if (gobimpChooser >= 30) {
				if (flags[kFLAGS.TIMES_ENCOUNTERED_GOBLIN_WARRIOR] >= 1) SceneLib.goblinScene.goblinWarriorsEncounter();
				else {
					if (rand(10) == 0 && flags[kFLAGS.ANGELIC_FRACTION_TOGGLE] == 0) SceneLib.angelScene.angeloidGroupEncounter();
					else SceneLib.impScene.impPackEncounter();
				}
			}
			else {
				if (flags[kFLAGS.TIMES_ENCOUNTERED_GOBLIN_ASSASSIN] >= 1) SceneLib.goblinScene.goblinAdventurersEncounter();
				else SceneLib.impScene.impPackEncounter2();
			}
		}
		private function angelEncounterLow():void {
			clearOutput();
			outputText("A low-ranked angeloid wings out of the sky and attacks!");
			player.createStatusEffect(StatusEffects.AngelsChooser, 1, 0, 0, 0);
			startCombat(new Angeloid());
		}
		private function angelEncounterMid():void {
			clearOutput();
			outputText("A mid-ranked angeloid wings out of the sky and attacks!");
			player.createStatusEffect(StatusEffects.AngelsChooser, 2, 0, 0, 0);
			startCombat(new Angeloid());
		}
		private function angelEncounterHigh():void {
			clearOutput();
			outputText("A high-ranked angeloid wings out of the sky and attacks!");
			player.createStatusEffect(StatusEffects.AngelsChooser, 3, 0, 0, 0);
			startCombat(new Angeloid());
		}
		public function demonLabProjectEncountersEnabled():Boolean {
			return DemonLab.MainAreaComplete >= 4;
		}
		public function demonLabProjectEncounters(type:Number = 0):void {
			clearOutput();
			var choices:Array = [];
			if (type == 1) {
				choices.push(0);
				choices.push(1);
			}
			else {
				if (isNightTime) {
					choices.push(0);
					choices.push(1);
				}
			}
			choices.push(2);
			if (!KihaFollower.FlameSpreaderBossKilled && KihaFollower.FlameSpreaderKillCount >= 20 && InCollection("Kiha", flags[kFLAGS.PLAYER_COMPANION_0], flags[kFLAGS.PLAYER_COMPANION_1], flags[kFLAGS.PLAYER_COMPANION_2] ,flags[kFLAGS.PLAYER_COMPANION_3]))
				choices.push(3);
			if (KihaFollower.FlameSpreaderKillCount < 20 && InCollection("Kiha", flags[kFLAGS.PLAYER_COMPANION_0], flags[kFLAGS.PLAYER_COMPANION_1], flags[kFLAGS.PLAYER_COMPANION_2] , flags[kFLAGS.PLAYER_COMPANION_3])) {
				choices.push(4);
				choices.push(5);
				choices.push(6);
			}
			var select:int = rand(choices.length)
			switch (choices[select]) {
				case 0:
					nightwalkerEncounter();
					break;
				case 1:
					tyrantEncounter();
					break;
				case 2:
					flamespreaderEncounter();
					break;
				case 3:
					ultimisEcounter();
					break;
				case 4:
				case 5:
				case 6:
					flamespreaderEncounter();
					break;
			}
			function nightwalkerEncounter():void {
				outputText("You find yourself feeling somewhat nervous. Your [skin] crawls, but as you wheel about, you see nothing. You hear nothing but a faint whisper on the wind.[pg]");
				outputText("“<i>Blood.</i>” A faint dripping sound comes from behind you. You turn, slowly, to face a corpse-pale woman in a crotchless skintight latex suit that leaves nothing to the imagination. Her eyes shine red, and her fangs stick out well beyond her lips. A spadelike tail flicks back and forth, dripping red, and she smiles, curved black horns and ebony tresses combining to make her seem...well, you assume the intent was to make her beautiful, but unlike the succubi, there’s almost no sex appeal in those eyes, no carnal desire as she glances between your legs, scraping one of her fingernails along her swollen pussy lips, cutting herself and drawing a trickle of blood.[pg]");
				outputText("“<i>Sweet blood, come... Sate yourself.</i>” Her nails are like black claws, but as she licks the blood off her fingers, part of you recoils in fear. “<i>Sate you...Then you’ll sate...me.</i>” You draw your [weapon], bracing yourself, but as you do, this gets only a smile as the curvy, short woman tilts her head. She launches herself toward you, claws outstretched, the eerie grin still on her face.[pg]");
				outputText("“<i>Blood! Blood for me!</i>”");
				outputText("[pg]“<b>You are now fighting Project Nightwalker.</b>”");
				startCombat(new ProjectNightwalker());
			}
			function tyrantEncounter():void {
				outputText("Your wanderings bring you in front of a massive form vaguely resembling a Drider. Easily seventeen feet tall and thirty feet long, the creature turns to face you, six crimson eyes gleaming. It wears blackened full plate armor thicker than any you’ve ever seen, with glistening spikes on its shoulders. Twin horns poke through the creature’s helmet. Those, and the eyes, are the only part of its body not covered in metal. It breathes heavily, and as it takes a step, the spikes on its legs sink a half-inch into the ground below. Corruption oozes from this creature in a sickening aura. It holds a massive halberd in each meaty fist, using them like axes.");
				outputText("[pg]On the creature’s back sits a heavily muscled Incubus, armored lightly, and holding an odd crossbow in one hand. He looks at you, smirking, and points.");
				outputText("[pg]“<i>Tyrant? Kill!</i>”");
				outputText("[pg]“<b>You are now fighting Project Tyrant.</b>”");
				startCombat(new ProjectTyrant());
			}
			function flamespreaderEncounter():void {
				outputText("Hearing the flapping of leathery wings, you look skyward. A reddish figure is already swooping down towards you, and you throw yourself backwards. A massive spear barely misses your head, and a cloud of dust is thrown up by the impact. You draw your [weapon], the dust settling, and you finally get a glimpse of your attacker.[pg]");
				outputText("Your attacker has dusky brown skin, red scales from calf to neck, and slender curves. You look at her face, with draconic fangs, demonic horns and reptilian eyes. Flames jet from her nose with every breath, and she shifts her weight from side to side. She’s an odd mix of dragon and demon, with wide, womanly hips. She plants her spear, wings flapping.[pg]");
				outputText("You ready yourself for battle, and you hear the cracking of bones as the creature almost violently twists its own neck one way, then the other, laughing as it takes off, flying towards you with malice in its gaze.");
				outputText("[pg]“<b>You are now fighting Project Flamespreader.</b>”");
				startCombat(new ProjectFlameSpreader());
			}
			function ultimisEcounter():void {
				outputText("You and your dragoness lover travel through area, stopping for a moment. The air smells vaguely of sulphur...and it’s getting stronger. Casting your gaze skyward, you see a massive form, bright red, flying low to the ground...and heading right towards you. You barely have any time at all to react, but you manage to leap to the side, narrowly dodging a veritable pillar of flame. Kiha roars her rage, taking to the sky, but as she does, no less than five Flamespreaders fly in, forcing her to evade their deadly spears. Kiha looks back at you for a moment, before banking away, taking all five of the fakers with her.");
				if (silly()) outputText("[pg]Having seen plenty of Kiha’s ass, child-bearing hips and bountiful breasts, you conclude that they’re not even good enough to be Kiha’s fakes! You just hope she doesn’t eat those words.");
				outputText("[pg]“<b>You are now fighting the Ultimis Flamespreader.</b>”");
				startCombat(new UltimisFlamespreader());
			}
		}

		public function impFactor():Number {
			if (player.hasPerk(PerkLib.PiercedLethite)) return 2;
			return 1;
		}
		public function feralImpFactor():Number {
			if (flags[kFLAGS.GALIA_LVL_UP] > 0 && flags[kFLAGS.GALIA_LVL_UP] < 0.5) return 2;
			return 1;
		}
		private function angelicFraction():Boolean {
            return flags[kFLAGS.ANGELIC_FRACTION_TOGGLE] == 0;
        }
		
		private var _explorationEncounters:GroupEncounter = null;
		private var _commonEncounters:GroupEncounter = null;
		private var _angelEncounters:GroupEncounter = null;
		public function get commonEncounters():GroupEncounter { return _commonEncounters }
		public function get angelEncounters():GroupEncounter { return _angelEncounters }
		private function init():void {
			const fn:FnHelpers = Encounters.fn;
			_angelEncounters = Encounters.group("angels",
					{
						name: "angel1",
						label: "Angeloid I",
						kind: "monster",
						call: angelEncounterLow
					}, {
						name: "angel2",
						label: "Angeloid II",
						kind: "monster",
						when: fn.ifLevelMin(6),
						call: angelEncounterMid
					} , {
						name: "angel3",
						label: "Angeloid III",
						kind: "monster",
						when: fn.ifLevelMin(12),
						call: angelEncounterHigh
					}
			).withCondition(angelicFraction);
			
			_commonEncounters = Encounters.group("common",
					{
						name: "Imp",
						kind: "monster",
						mods: [impFactor],
						call: impEncounter
					}, {
						name: "feralImp",
						label: "Feral Imp",
						kind: "monster",
						when: function():Boolean {
							return player.level >= 3 || player.statusEffectv2(StatusEffects.AdventureGuildQuests2) > 0
						},
						call: feralImpEncounter,
						mods: [impFactor, feralImpFactor]
					}, {
						name: "impLord",
						label: "Imp Lord",
						kind: "monster",
						chance: 0.5,
						mods: [impFactor],
						when: fn.ifLevelMin(8),
						call: SceneLib.impScene.impLordEncounter
					}, {
						name: "feralImpLord",
						label: "Feral Imp Lord",
						shortLabel: "FI Lord",
						kind: "monster",
						chance: 0.5,
						mods: [impFactor, feralImpFactor],
						when: fn.ifLevelMin(8),
						call: SceneLib.impScene.impLordFeralEncounter
					}, {
						name: "impWarlord",
						label: "Imp Warlord",
						kind: "monster",
						chance: 0.5,
						mods: [impFactor],
						when: fn.ifLevelMin(12),
						call: SceneLib.impScene.impWarlordEncounter
					}, {
						name: "feralImpWarlord",
						label: "Feral Imp Warlord",
						shortLabel: "FI Warlord",
						kind: "monster",
						chance: 0.5,
						mods: [impFactor],
						when: fn.ifLevelMin(12),
						call: SceneLib.impScene.impWarlordFeralEncounter
					}, {
						name: "impOverlord",
						label: "Imp Overlord",
						kind: "monster",
						chance: 0.25,
						mods: [impFactor],
						when: fn.ifLevelMin(16),
						call: SceneLib.impScene.impOverlordEncounter
					}, {
						name: "goblin",
						label: "Goblin",
						kind: "monster",
						call: SceneLib.goblinScene.goblinEncounter
					}, {
						name: "goblinAssassin",
						label: "Goblin Assassin",
						shortLabel: "Gob. Assassin",
						kind: "monster",
						when: fn.ifLevelMin(8),
						call: SceneLib.goblinScene.goblinAssassinEncounter
					}, {
						name: "goblinWarrior",
						label: "Goblin Warrior",
						shortLabel: "Gob. Warrior",
						kind: "monster",
						when: fn.ifLevelMin(16),
						call: SceneLib.goblinScene.goblinWarriorEncounter
					}, {
						name: "goblinShaman",
						label: "Goblin Shaman",
						shortLabel: "Gob. Shaman",
						kind: "monster",
						when: fn.ifLevelMin(24),
						call: SceneLib.goblinScene.goblinShamanEncounter
					}, {
						name: "priscilla",
						label: function():String {
							if (flags[kFLAGS.TIMES_ENCOUNTERED_PRISCILLA] == 0) return "Gob. Elder";
							return "Priscilla"
						},
						kind: "npc",
						unique: true,
						when: fn.ifLevelMin(24),
						call: SceneLib.priscillaScene.goblinElderEncounter
					}, {
						name: "golem1",
						label: "Dummy Golem",
						shortLabel: "Golem I",
						kind: "monster",
						call: golemEncountBasic
					}, {
						name: "golem2",
						label: "Improved Golem",
						shortLabel: "Golem II",
						kind: "monster",
						when:fn.ifLevelMin(12),
						call: golemEncounterImproved
					}, {
						name: "golem3",
						label: "Advanced Golem",
						shortLabel: "Golem III",
						kind: "monster",
						when:fn.ifLevelMin(18),
						call: golemEncounterAdvanced
					}, {
						name: "golem3group",
						label: "Advanced Golem Group",
						shortLabel: "Golem III+",
						kind: "monster",
						when:fn.ifLevelMin(18),
						chance: 0.25,
						call: golemEncounterAdvancedGroup
					}, {
						name: "golem4",
						label: "Superior Golem",
						shortLabel: "Golem IV",
						kind: "monster",
						when:fn.ifLevelMin(24),
						call: golemEncounterSuperior
					}, {
						name: "golem4group",
						label: "Superior Golem Group",
						shortLabel: "Golem IV+",
						kind: "monster",
						when:fn.ifLevelMin(18),
						chance: 0.25,
						call: golemEncounterSuperiorGroup
					}, {
						name: "golem5",
						label: "Basic True Golem",
						shortLabel: "Golem V",
						kind: "monster",
						when:fn.ifLevelMin(33),
						call: golemEncounterTrueBasic
					}, {
						name: "golem5group",
						label: "Basic True Golem Group",
						shortLabel: "Golem V+",
						kind: "monster",
						when:fn.ifLevelMin(33),
						chance: 0.25,
						call: golemEncounterTrueBasicGroup
					}, {
						name: "golem6",
						label: "Improved True Golem",
						shortLabel: "Golem VI",
						kind: "monster",
						when:fn.ifLevelMin(42),
						call: golemEncounterTrueImproved
					}, {
						name: "golem6group",
						label: "Improved True Golem Group",
						shortLabel: "Golem VI+",
						kind: "monster",
						when:fn.ifLevelMin(42),
						chance: 0.25,
						call: golemEncounterTrueImprovedGroup
					}, {
						name: "golem7",
						label: "Advanced True Golem",
						shortLabel: "Golem VII",
						kind: "monster",
						when:fn.ifLevelMin(51),
						call: golemEncounterTrueAdvanced
					}, {
						name: "golem5group",
						label: "Basic True Golem Group",
						shortLabel: "Golem V+",
						kind: "monster",
						when:fn.ifLevelMin(33),
						chance: 0.25,
						call: golemEncounterTrueAdvancedGroup
					}
			);
			
			_explorationEncounters = Encounters.group("exploration",
					{
						name  : "Evangeline",
						kind  : "npc",
						unique: true,
						chance: 2,
						when  : function ():Boolean {
							return player.level > 0 && (
									EvangelineFollower.EvangelineAffectionMeter < 1
									|| (EvangelineFollower.EvangelineAffectionMeter == 1 || EvangelineFollower.EvangelineAffectionMeter == 2) && player.statusEffectv1(StatusEffects.TelAdre) >= 1 && flags[kFLAGS.HEXINDAO_UNLOCKED] >= 1)
						},
						call  : function ():void {
							if (EvangelineFollower.EvangelineAffectionMeter < 1) {
								SceneLib.evangelineFollower.enterTheEvangeline();
							} else {
								SceneLib.evangelineFollower.alternativEvangelineRecruit();
							}
						}
					}, {
						name  : "Pearl",
						kind  : "item",
						unique: true,
						chance: 1,
						when  : function ():Boolean {
							return player.level > 2 && player.hasKeyItem("Sky Poison Pearl") < 0 && flags[kFLAGS.SKY_POISON_PEARL] < 1;
						},
						call  : pearldiscovery
					}, {
						name  : "hiddencave",
						label : "Hidden Cave",
						kind  : "place",
						unique: true,
						when  : function ():Boolean {
							return player.level > 5 && flags[kFLAGS.HIDDEN_CAVE_FOUND] < 1
						},
						call  : hiddencavediscovery
					}, {
						name  : "troll",
						label : "Troll Village",
						kind  : "place",
						unique: true,
						when  : function ():Boolean {
							return flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && TrollVillage.ZenjiVillageStage == 0
						},
						call  : SceneLib.trollVillage.FirstEncountersoftheTrollKind
					}, {
						name  : "pocketwatch",
						label : "Pocket Watch",
						kind  : "item",
						unique: true,
						when  : function ():Boolean {
							return player.level >= 9 && player.hasKeyItem("Pocket Watch") < 0
									&& (!player.hasStatusEffect(StatusEffects.PocketWatch) || player.superPerkPoints > 0)
						},
						call  : pocketwatchdiscovery
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						label : "Helia",
						kind  : 'npc',
						unique: true,
						night : false,
						call  : SceneLib.helScene.helSexualAmbush,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "VS",
						kind  : "npc",
						unique: true,
						night : true,
						when  : function ():Boolean {
							return (player.racialScore(Races.VAMPIRE) >= 20 || player.racialScore(Races.DRACULA) >= 22) && player.hasStatusEffect(StatusEffects.Familiar) && player.statusEffectv3(StatusEffects.Familiar) == 0;
						},
						call  : creatingTheServant
					}, {
						name  : "NPC (New)",
						kind  : "npc",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : function ():Boolean {
							return flags[kFLAGS.ALVINA_FOLLOWER] < 1
						},
						call  : SceneLib.alvinaFollower.alvinaFirstEncounter
					}, {
						name  : "HeXinDao",
						kind  : "place",
						unique: true,
						when  : function ():Boolean {
							return flags[kFLAGS.HEXINDAO_UNLOCKED] < 1
						},
						call  : discoverHXD
					}, {
						name  : "Tel'Adre",
						kind  : "place",
						unique: true,
						when  : function ():Boolean {
							return (!player.hasStatusEffect(StatusEffects.TelAdre) || player.statusEffectv1(StatusEffects.TelAdre) < 1);
						},
						call  : SceneLib.telAdre.discoverTelAdre
					}, {
						name  : "Bazaar",
						kind  : "place",
						unique: true,
						when  : function ():Boolean {
							return flags[kFLAGS.BAZAAR_ENTERED] == 0;
						},
						call  : SceneLib.bazaar.findBazaar
					}, {
						name  : "Forest",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.forest.canDiscoverOuter,
						call  : SceneLib.forest.discoverOuter
					}, {
						name  : "Lake",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.lake.canDiscover,
						call  : SceneLib.lake.discover
					}, {
						name  : "Desert",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.desert.canDiscoverOuter,
						call  : SceneLib.desert.discoverOuter
					}, {
						name  : "Battlefield",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.battlefiledboundary.canDiscover,
						call  : SceneLib.battlefiledboundary.discover
					}, {
						name  : "Hills",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.mountain.canDiscoverHills,
						call  : SceneLib.mountain.discoverHills
					}, {
						name  : "Plains",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.plains.canDiscover,
						call  : SceneLib.plains.discover
					}, {
						name  : "Swamp",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.swamp.canDiscover,
						call  : SceneLib.swamp.discover
					}, {
						name  : "blightRidge",
						label : "Blight Ridge",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.blightridge.canDiscover,
						call  : SceneLib.blightridge.discover
					}, {
						name  : "Beach",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.beach.canDiscover,
						call  : SceneLib.beach.discover
					}, {
						name  : "Caves",
						kind  : "place",
						unique: true,
						chance: Encounters.ALWAYS,
						when  : SceneLib.caves.canDiscover,
						call  : SceneLib.caves.discover
					}, {
						name  : "Cathedral",
						kind  : "place",
						unique: true,
						when  : function ():Boolean {
							return flags[kFLAGS.FOUND_CATHEDRAL] != 1
						},
						call  : function ():void {
							if (flags[kFLAGS.GAR_NAME] == 0) SceneLib.gargoyle.gargoylesTheShowNowOnWBNetwork();
							else SceneLib.gargoyle.returnToCathedral();
						}
					}, {
						name  : "Giacomo",
						kind  : "npc",
						unique: true,
						call  : SceneLib.giacomoShop.giacomoEncounter
					}, {
						name  : "Dinah",
						kind  : "npc",
						unique: true,
						when  : function ():Boolean {
							return flags[kFLAGS.DINAH_LVL_UP] < 1
						},
						call  : SceneLib.dinahScene.DinahIntro1
					}, {
						name  : "Lumi",
						kind  : "npc",
						unique: true,
						when  : function ():Boolean {
							return flags[kFLAGS.LUMI_MET] == 0
						},
						call  : SceneLib.lumi.lumiEncounter
					}, _commonEncounters
			);
		}
		//Try to find a new location - called from doExplore once the first location is found
		public function tryDiscover():void
		{
			explorer.prepareArea(_explorationEncounters);
			explorer.setTags("explore");
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.explore++;
			}
			explorer.skillBasedReveal(1, SceneLib.exploration.counters.explore);
			explorer.doExplore();
/*			if (player.level > 5 && flags[kFLAGS.RYUBI_LVL_UP] < 1 && rand(4) == 0) {
				ryubifirstenc();
				return;
			}
			if (player.level > 5 && flags[kFLAGS.RYUBI_LVL_UP] >= 1 && rand(4) == 0) {
				ryubirepenc();
				return;
			}
*/
				/*
				//Discover Abyss
				if (SceneLib.exploration.counters.blightRidge > 0 && flags[kFLAGS.] <= 0 && (player.level + combat.playerLevelAdjustment()) >= 10) {
					flags[kFLAGS.] = 1;
					clearOutput();
					outputText("You walk \n\n");
					outputText("<b>You've discovered the Abyss!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				//Discover Pit
				if (flags[kFLAGS.] > 0 && flags[kFLAGS.] <= 0 && ((rand(3) == 0 && player.level >= 16) || player.level >= 21)) {
					flags[kFLAGS.] = 1;
					clearOutput();
					outputText("You walk \n\n");
					outputText("<b>You've discovered the Pit!</b>");
					doNext(camp.returnToCampUseTwoHours);
					return;
				}
				*/
		}
		
		private function discoverHXD():void {
			clearOutput();
			outputText("Against your better judgment, curiosity gets the better of you, and you find yourself walking into a strange area.");
			outputText("\n\nNot long into your journey, you see a hooded figure looming across the landscape, moving at the same speed as it goes across the terrain. The odd creature captures your interest, and you start to follow it. You glance around, there's still no one else nearby, so you continue to tail the mysterious being.");
			outputText("\n\nHalf an hour or so later, still following the cloaked figure, you begin to hear the sound of running water. Moving on, you eventually come across the source: a decently sized river flows across the land, populated by variously sized islands. Stopping for a second to take a look around, the hooded person seems to be moving towards one of the several islands. He? She? It is still oblivious to your presence.");
			outputText("\n\nA voice rings from behind you, \"<i>Come to visit He'Xin'Dao, stranger?</i>\"");
			outputText("\n\nTurning around, you see a few hooded figures similar to the one you have been following. You curse at the thought that someone could've ambushed you so easily without you noticing them sooner. You state that you've been exploring and found this place. The figure peers at you through the veiled hood.\n\n"
					+ "\"<i>You seem lacking in soulforce, but luckily your soul is enough intact to allow future cultivation. So, since you are already here, what do you think about visiting our village? Maybe you would come more often to it in the future?</i>\"");
			outputText("\n\nYou ponder for a moment over the offer. The hooded beings don't seem to carry any malice, given they haven't attacked you nor attempted rape. Perhaps it would be of interest to explore this place?  You decide to accept their offer as they lead you over the wide bridge to one of the islands.  Several heavily armored guards peer at you searchingly, to which one of your new companions state that you are a new guest.  The guard gives a stoic nod as they step aside, no longer barring you from entry.  Your hooded friends guide you to a small island to properly register you as a guest. They give you a small guide on a piece of parchment, telling you places of interest and instructions on how to find this place again.");
			outputText("\n\nAfterwards, you're left alone.  You wander around, checking a few places of interest before you decide it's time to return to your camp.  With the guide in your hands, you're sure you'll find this place again with ease if you need to.");
			outputText("\n\n\n<b>You have unlocked He'Xin'Dao in Places menu!</b>");
			flags[kFLAGS.HEXINDAO_UNLOCKED] = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function creatingTheServant():void {
			clearOutput();
			outputText("While traveling the world, a sudden thirst overtakes you. And here you thought you had your fill of blood recently!");
			outputText("\n\nDesperate for a quick drink, you listen for a heartbeat and fly straight to the nearest one spotting a vague form drudging through the wilderness. Seeing red with hunger, you wrap your wings around the humanoid and bite straight into her neck. As you slowly regain your sanity, a closer look reveals your victim for what it was.");
			outputText("\n\nThis peachy vulnerable skin, normal face and round ears. These five toed clawless feet and 5 fingered hands. The absence of a tail or wings. No matter how you look at it, that's a damn human you just drank from, one of your own kind!.. At least… former kind, Hardly anything remotely human about you anymore. You check and confirm that at least she wasn't a virgin, or it would have made you feel even worse!");
			if (player.cor >= 50) outputText("\n\nThat human ain't going to survive much longer, you're about to throw the body into a ditch when a sinister idea comes to your mind suggested by your instinct. You first bite your palm then begin to forcefully feed her your blood to her.");
			else outputText("\n\nWell, fuck… by the look of her, she's going to die any minute now from all that blood loss! A small nagging thought appears in the back of your mind. Diva did mention vampire blood being infectious right? What if you simply turned that human into a vampire? It would solve all of your problems! Without hesitating, you cut your hand and begin to force feed your blood to the human in your arms attempting for a last ditch save before you formally become a murderer!");
			outputText("\n\nThe reaction is instantaneous as her body begins to shake and convulse. Her body starts by taking on a more voluptuous, womanly figure like the original vampire transformation, but the following changes confuse you. What's going on? You watch as the girl's nails deform into sharp claws, her teeth sharpening into vicious needles as your corrupted blood taint her eyes red with hunger. Her ears do become pointed not unlike those of a vampire but her form is anything but. ");
			outputText("To complete this, her tongue suddenly elongates to ridiculous length and becomes quite dexterous as it licks your palm obscenely, trying to catch any remaining drop of blood before your regeneration kicks in. Instinctively you already know something went hell of wrong with her transformation and it might have to do with something in your blood or maybe some other factor.");
			outputText("\n\nThe crouching ghoul before you, because what else could this fiendish looking damaged soul of an undead be, licks your hand amorously like a well trained dog. Feeling a little awkward at your new pet you pause thinking about what to do with it now. To your surprise though the soul broken undead speaks up intelligently with a refined voice that does not exactly match its behavior and feral look.");
			outputText("\n\n\"<i>"+player.mf("Master","Mistress")+" I await your order…please tell me your will.</i>\"");
			outputText("\n\nWell, the thing turns out to be quite obedient and well behaved. Perhaps with some clothing you could even make it pass for a maid or a butler. You tell your new pet to head to your camp asap once there you will think what to do with her.");
			outputText("\n\n\"<i>As the good "+player.mf("master","mistress")+" command!</i>\"");
			outputText("\n\nThe ghoul leap into the shadows how it will find your camp you don't know but somehow the blood tells you it will.");
			if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) outputText(" You ponder in amusement how your maid is going to react to this new servant sharing her chore and turf. Luna is in for a funny surprise you guess.");
			flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME] = "Helia";
			player.addStatusValue(StatusEffects.Familiar, 3, 1);
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}
//Temporaly place of finding enemies for lvl between 31 and 49
		public function tryDiscoverLL():void {
			clearOutput();
			if (rand(4) == 0 && flags[kFLAGS.ANGELIC_FRACTION_TOGGLE] == 0) {
                if (silly()) {
                    outputText("You're walking in the woods\n\n");
                    outputText("There's no one around\n\n");
                    outputText("And your phone is dead\n\n");
                    outputText("Out of the corner of your eye you spot him/her/it/them\n\n");
                }
				outputText("<b>A Low-Rank Angel...</b>");
				startCombat(new AngelLR());//lvl 15
				return;
			}
			else if (rand(3) == 0) {
                if (silly()) {
                    outputText("You're walking in the woods\n\n");
                    outputText("There's no one around\n\n");
                    outputText("And your phone is dead\n\n");
                    outputText("Out of the corner of your eye you spot her\n\n");
                }
				outputText("<b>A Wasp Girl...</b>");
				startCombat(new WaspGirl());//lvl 33
				return;
			}
			else if (rand(2) == 0) {
				outputText("Traversing Mareth vast areas you're stopped by the arrow to the <u>kne</u> 'place between ground and your waist'.");
				outputText("\n\n<b>A wild Light Elf Ranger Appears.</b>");
				flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] = 12;
				startCombat(new LightElfs());//lvl 47
				return;
			}
			else {
                if (silly()) {
                    outputText("You're walking in the woods\n\n");
                    outputText("There's no one around\n\n");
                    outputText("And your phone is dead\n\n");
                    outputText("Out of the corner of your eye you spot her\n\n");
                }
				outputText("<b>A Wasp Huntress...</b>");
				startCombat(new WapsHuntress());//lvl 48
				return;
			}
		}
		//Temporaly place of finding enemies for lvl between 51 and 69
		public function tryDiscoverML():void {
			clearOutput();
			if (rand(4) == 0) {
				outputText("Traversing Mareth vast areas you're stopped by the arrow to the <u>kne</u> 'place between ground and your waist'.");
				outputText("\n\n<b>A wild Light Elf Sniper Appears.</b>");
				flags[kFLAGS.DARK_OR_LIGHT_ELF_SUBTYPE] = 13;
				startCombat(new LightElfs());//lvl 51
				return;
			}
			else if (rand(3) == 0) {
                if (silly()) {
                    outputText("You're walking in the woods\n\n");
                    outputText("There's no one around\n\n");
                    outputText("And your phone is dead\n\n");
                    outputText("Out of the corner of your eye you spot her\n\n");
                    outputText("<b>An Alraune Maiden...</b>");
                }
				startCombat(new AlrauneMaiden());//lvl 54
				return;
			}
			else if (rand(2) == 0) {
				outputText("Traversing Mareth vast areas you stops near something looking like a soul cultivator cave.");
				outputText("\n\n<b>A wild Kitsune Elder Appears.</b>");
				startCombat(new KitsuneElder());//lvl 55
				return;
			}
			else {
                if (silly()) {
                    outputText("You're walking in the woods\n\n");
                    outputText("There's no one around\n\n");
                    outputText("And your phone is dead\n\n");
                    outputText("Out of the corner of your eye you spot her\n\n");
                }
				outputText("<b>A Wasp Assassin...</b>");
				startCombat(new WaspAssassin());//lvl 63
				return;
			}
		}
		//Temporaly place of finding enemies for lvl between 70 and 94
		public function tryDiscoverHL():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("Traversing Mareth vast areas you're suddenly found yourself underwater!!!");
				outputText("\n\n<b>Aaaand....A wild Scylla Appears.</b>");
				player.underwaterCombatBoost();
				if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
				startCombat(new Scylla());//lvl 70
				return;
			}
			else {
				outputText("Traversing Mareth vast areas you stops near something looking like a soul cultivator cave.");
				outputText("\n\n<b>A wild Kitsune Sage Appears.</b>");
				startCombat(new KitsuneAncestor());//lvl 80
				return;
			}
		}
		//Temporaly place of finding enemies for lvl between 95 and 124
		public function tryDiscoverXHL():void {
			clearOutput();
			//if (rand(2) == 0) {
				outputText("Traversing Mareth vast areas you're suddenly found yourself underwater!!!");
				outputText("\n\n<b>Aaaand....A wild Kraken Appears.</b>");
				player.underwaterCombatBoost();
				if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
				startCombat(new Kraken());//lvl 100 GIGANT BOSS
				return;/*
			}
			else {
				outputText("Traversing Mareth vast areas you're suddenly found yourself underwater tangled in some sort of vines!!!");
				outputText("\n\n<b>Aaaand....A wild Seabed Alraune Appears.</b>");
				player.createStatusEffect(StatusEffects.HeroBane, 10, 0, 0, 0);
				player.underwaterCombatBoost();
				if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
				startCombat(new SeabedAlrauneBoss());//lvl 135 GIGANT PLANT BOSS
				return;
			}*/
		}
		//Temporaly place of finding enemies for lvl 125+
		public function tryDiscoverXXHL():void {
			clearOutput();
			//else {
				outputText("Traversing Mareth vast areas you're suddenly found yourself underwater tangled in some sort of vines!!!");
				outputText("\n\n<b>Aaaand....A wild Seabed Alraune Appears.</b>");
				player.createStatusEffect(StatusEffects.HeroBane, 10, 0, 0, 0);
				player.underwaterCombatBoost();
				if (!player.canSwimUnderwater()) player.createStatusEffect(StatusEffects.UnderwaterOutOfAir,0,0,0,0);
				startCombat(new SeabedAlrauneBoss());//lvl 135 GIGANT PLANT BOSS
				return;
			//}
		}

		public function tryRNGod():void {
			clearOutput();
			outputText("Traversing Mareth vast areas you're suddenly found yourself... somewhere!!! And looks like your prayers have been heard!!! (Even if you didn't pray at all!!!)");
			outputText("\n\n<b>Aaaand....A RNGod Appears.</b>");
			startCombat(new RNGod());
		}

		public function pearldiscovery():void {
			flags[kFLAGS.SKY_POISON_PEARL] = 1;
			clearOutput();
			outputText("While exploring, you feel something is off.  Wary of meeting new things in this world after your previous experiences, you decide to cautiously locate the source of this feeling.  Soon the object comes into view and you can see that it is an ordinary looking pearl.  Knowing that it may be more then it looks to be you check the suroundings next to it for a while before deciding to touch it.  Nothing happens so since it somehow attracted your attention you pocket this pearl.\n\n");
			inventory.takeItem(consumables.SPPEARL, explorer.done);
		}

		public function hiddencavediscovery():void {
			flags[kFLAGS.HIDDEN_CAVE_FOUND] = 1;
			clearOutput();
			outputText("\nYou aproach what looks like a cave at first but the shattered bones on the ground hint to something else. Still where theres bones and dead explorer is bound to be treasure. The entrance is decorated with a pair of fiery torch");
			if (silly()) outputText(" and a sparkling arrow shaped sign post tell 'please come in adventurer, I'm in need of more bony decoration'");
			outputText(".\n\n");
			doNext(hiddencave.enterDungeon);
		}

		public function pocketwatchdiscovery():void {
			clearOutput();
			outputText("While exploring, you feel something is off.  Wary of finding new things in this world after your previous experiences, you decide to cautiously locate the source of this feeling.  Soon the object comes into view and you can see that it is an ordinary looking pocket watch.  Knowing that it may be more than it looks, you inspect the adjacent surroundings for a while before deciding to touch it. A faint voice echoes in your mind.\n\n \"<i>Only thou that shall sacrifice shall be rewarded.</i>\" \n\n");
			menu();
			addButtonIfTrue(6, "Sacrifice", pocketwatchdiscoveryYes, "Req. something 'super'.", player.superPerkPoints > 0);
			addButton(8, "Leave", pocketwatchdiscoveryNo);
		}
		private function pocketwatchdiscoveryYes():void {
			outputText("Determined you grab the watch. A feeling of pain pierces your soul making you momentarily black out. After returning to your senses, you see the watch is already hanging on your waist. A feeling of missing some piece of yourself nags at you but there doesn't appear to be anything missing at first glance. Well guess it won't kill you for now...	 you hope as you return to camp.\n\n");
			player.superPerkPoints--;
			player.createKeyItem("Pocket Watch", 0, 0, 0, 0);
			player.createStatusEffect(StatusEffects.MergedPerksCount, 0, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.PocketWatch)) player.removeStatusEffect(StatusEffects.PocketWatch);
			endEncounter();
		}
		private function pocketwatchdiscoveryNo():void {
			outputText("No you do not want to sacrifice anything. Leaving the watch behind, you return to the camp.\n\n");
			player.createStatusEffect(StatusEffects.PocketWatch, 0, 0, 0, 0);
			endEncounter();
		}

		public function ryubifirstenc():void {
			flags[kFLAGS.RYUBI_LVL_UP] = 1;
			clearOutput();
			outputText("While exploring (rest is placeholder atm).\n\n");
			startCombat(new RyuBiDragon());
		}
		public function ryubirepenc():void {
			clearOutput();
			outputText("While exploring (rest is placeholder atm).\n\n");
			startCombat(new RyuBiDragon());
		}

		public function goSearchForPearls():void {
			clearOutput();
			outputText("You grab your [weapon] and goes on serching solution to your waning physical constitution.");
			if (player.hasPerk(PerkLib.ElementalConjurerSacrifice) && player.perkv1(PerkLib.ElementalConjurerSacrifice) < 2 && player.hasStatusEffect(StatusEffects.ElementalPearlGolems) && player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 2) {
				if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 2) player.addStatusValue(StatusEffects.ElementalPearlGolems, 1, 1);
				if (player.perkv1(PerkLib.ElementalConjurerSacrifice) < 1) player.addPerkValue(PerkLib.ElementalConjurerSacrifice, 1, 1);
			}
			if (player.hasPerk(PerkLib.ElementalConjurerDedication) && player.perkv1(PerkLib.ElementalConjurerDedication) < 2 && player.hasStatusEffect(StatusEffects.ElementalPearlGolems)) {
				if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 1) player.addStatusValue(StatusEffects.ElementalPearlGolems, 1, 1);
				if (player.perkv1(PerkLib.ElementalConjurerDedication) < 1) player.addPerkValue(PerkLib.ElementalConjurerDedication, 1, 1);
			}
			if (player.hasPerk(PerkLib.ElementalConjurerResolve) && player.perkv1(PerkLib.ElementalConjurerResolve) < 2) {
				if (!player.hasStatusEffect(StatusEffects.ElementalPearlGolems)) player.createStatusEffect(StatusEffects.ElementalPearlGolems, 1, 0, 0, 0);
				if (player.perkv1(PerkLib.ElementalConjurerResolve) < 1) player.addPerkValue(PerkLib.ElementalConjurerResolve, 1, 1);
			}
			startCombat(new ElementalGolems());
		}
		public function elementalGolemBeaten1():void {
			clearOutput();
			outputText("You stops before beaten guardian quasi-gargoyle and reach toward it shoulder mounted shards yanking off each of them.\n\n");
			inventory.takeItem(useables.LELSHARD, elementalGolemBeaten1a);
		}
		private function elementalGolemBeaten1a():void {
			outputText("\n");
			inventory.takeItem(useables.LELSHARD, elementalGolemBeaten1b);
		}
		private function elementalGolemBeaten1b():void {
			outputText("\n");
			player.addPerkValue(PerkLib.ElementalConjurerResolve, 1, 1);
			inventory.takeItem(consumables.E3PEARL, cleanupAfterCombat);
		}
		public function elementalGolemBeaten2():void {
			clearOutput();
			outputText("You stops before beaten obsidian gargoyle and reach toward it shoulder mounted shards yanking off each of them.\n\n");
			inventory.takeItem(useables.LELSHARD, elementalGolemBeaten2a);
		}
		private function elementalGolemBeaten2a():void {
			outputText("\n");
			inventory.takeItem(useables.LELSHARD, elementalGolemBeaten2b);
		}
		private function elementalGolemBeaten2b():void {
			outputText("\n");
			player.addPerkValue(PerkLib.ElementalConjurerDedication, 1, 1);
			inventory.takeItem(consumables.E5PEARL, cleanupAfterCombat);
		}
		public function elementalGolemBeaten3():void {
			outputText("You stops before beaten living statue golem and reach toward it shoulder mounted crystals yanking off each of them.\n\n");
			inventory.takeItem(useables.ELCRYST, elementalGolemBeaten3a);
		}
		private function elementalGolemBeaten3a():void {
			outputText("\n");
			inventory.takeItem(useables.ELCRYST, elementalGolemBeaten3b);
		}
		private function elementalGolemBeaten3b():void {
			outputText("\n");
			player.addPerkValue(PerkLib.ElementalConjurerSacrifice, 1, 1);
			inventory.takeItem(consumables.E7PEARL, cleanupAfterCombat);
		}

		public function debugOptions():void
		{
			inventory.takeItem(consumables.W_FRUIT, playerMenu);
		}

		//Massive bodyparts scene
//[DESERT]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT,
//AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
		public function bigJunkDesertScene():void
		{
			clearOutput();
			var x:Number = player.longestCock();
			//PARAGRAPH 1
			outputText("Walking along the sandy dunes of the desert you find yourself increasingly impeded by the bulk of your " + cockDescript(x) + " dragging along the sandscape behind you.  The incredibly hot surface of the desert causes your loins to sweat heavily and fills them with relentless heat.");

			if (player.cocks.length == 1) outputText("  As it drags along the dunes, the sensation forces you to imagine the rough textured tongue of a monstrous animal sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ".");
			else if (player.cocks.length >= 2) outputText("  With all of your [cocks] dragging through the sands they begin feeling as if the rough textured tongues of " + num2Text(player.cockTotal()) + " different monstrous animals were slobbering over each one.");
			outputText("\n\n");

			//PARAGRAPH 2

			//FOR NON-CENTAURS]
			if (!player.isTaur()) {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [cocks], which forces your torso to the ground.  Normally your erection would merely raise itself skyward but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down on top of your obscene [cocks].");

				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35)  outputText("  Your " + Appearance.allBreastsDescript(player) + " hang lewdly off your torso to rest on the desert sands, seeming to bury the dunes on either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The burning heat of the desert teases your " + nippleDescript(0) + "s mercilessly as they grind in the sand.");
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.hasBalls()) outputText("  Your " + player.bodyColor + sackDescript() + " rests beneath your raised [butt].  The fiery warmth of the desert caresses it, causing your [balls] to pulse with the need to release their sperm through your [cocks].");
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the [butt] above.");
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("  Juices stream from your womanhood and begin pooling on the hot sand beneath you.  Wisps of steam rise up into the air only to tease your genitals further.  ");
				}
			}
			//FOR CENTAURS
			else {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [cocks], which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hindquarters until you rest atop your [cocks].");
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35)  outputText("  Your " + Appearance.allBreastsDescript(player) + " pull your human torso forward until it also is forced to rest facedown, just like your horse half.  Your tits rest, pinned on the desert sand to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The burning heat of the desert teases your " + nippleDescript(0) + "s incessantly.");
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.hasBalls()) outputText("  Your " + player.bodyColor + sackDescript() + " rests beneath your raised [butt].  The airy warmth of the desert teases it, causing your [balls] pulse with the need to release their sperm through your [cocks].");
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the [butt] above.");
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("  The desert sun beats down on your body, its fiery heat inflaming the senses of your vaginal lips.  Juices stream from your womanhood and begin pooling on the hot sand beneath you.");
				}
			}
			outputText("\n\n");
			//PARAGRAPH 3
			outputText("You realize you are effectively trapped here by your own body.");
			//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
			if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!");
			else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state you'd be completely defenseless.  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.");
			else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you're exhilarated at the prospect.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might die of thirst in the desert, you'd be incredibly tempted to remain right where you are.");

			//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
			if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last you manage to lighten the bulk of your body somewhat - enough to allow yourself to drag your genitals across the hot sands and back to camp.  The ordeal takes nearly an hour.");
			//SCENE END IF CHARACTER HAS CENTAUR BODY
			else if (player.isTaur()) outputText("  You struggle and work your equine legs against the surface of the dune you are trapped on.  Your [feet] have consistent trouble finding footing, the soft sand failing to provide enough leverage to lift your bulk.  You breath in deeply and lean from side to side, trying to find some easier vertical leverage.  Eventually, with a crude crawl, your legs manage to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals across the sandscape and back to camp.");
			//SCENE END = FOR ALL OTHER CHARACTERS
			else outputText("  You struggle and push with your [legs] as hard as you can, but it's no use.  You do the only thing you can and begin stroking your [cocks] with as much vigor as you can muster.  Eventually your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're simply too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later " + sMultiCockDesc() + " softens enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the warm sand.");
			dynStats("lus", 25 + rand(player.cor / 5), "scale", false);
			fatigue(5);
			endEncounter();
		}

	}
}
