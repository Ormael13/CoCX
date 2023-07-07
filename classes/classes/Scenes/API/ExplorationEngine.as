package classes.Scenes.API {
import classes.BaseContent;
import classes.Scenes.SceneLib;

import coc.view.ButtonData;
import coc.view.CoCButton;
import coc.view.Color;
import coc.view.UIUtils;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.text.TextField;

public class ExplorationEngine extends BaseContent {
	private static const MAXDEPTH:int      = 7;
	private static const NROADS:int        = 5;
	private static const N:int             = NROADS * MAXDEPTH;
	private static const LINE_WIDTH:Number = 4;
	private static const LINE_COLOR:String = "#444444";
	private static const LINE_NEXT:String  = "#0080ff";
	
	/** Encounter filter for first location on the road */
	private static function filterForStart(e:SimpleEncounter):Boolean {
		return !e.special;
	}
	/** Encounter filter for locations on the road except first and last */
	private static function filterForMid(e:SimpleEncounter):Boolean {
		return true;
	}
	/** Encounter filter for last location on the road */
	private static function filterForEnd(e:SimpleEncounter):Boolean {
		return e.special || ['npc', 'item', 'boss', 'treasure', 'special'].indexOf(e.kind) >= 0;
	}
	private static const filters:/*Function*/Array = [filterForStart, filterForMid, filterForEnd];
	
	public function ExplorationEngine() {
		for (var i:int = 0; i < NROADS; i++) {
			roads.push([]);
			for (var j:int = 0; j < MAXDEPTH; j++) {
				roads[i][j] = new ExplorationEntry();
				flatList.push(roads[i][j]);
			}
		}
		initialized = true; // for clear() to work
		clear();
	}
	
	/**
	 * This properties can be set after prepareArea() and before doExplore()
	 */
	public var prompt:String         = "";
	public var leave:ButtonData      = null;
	public var onEnd:ButtonData      = null;
	/**
	 * true - encounters can be fully revealed, displaying their name.
	 * false - only encounter kind can be revealed
	 */
	public var canRevealFull:Boolean = true;
	public var canMasturbate:Boolean = true;
	public var canInventory:Boolean = true;
	/**
	 * function(e:ExplorationEntry):Boolean, called BEFORE the encounter.
	 * If it returns true, do not continue with the exploration UI
	 */
	public var onEncounter:Function   = null;
	/**
	 * Called after UI is shown - can add custom buttons here
	 */
	public var onMenu:Function = null;
	/**
	 * A simple storage for current area tags.
	 * @example
	 *
	 * explorer.setTags("forest", "forestOutskirts");
	 *
	 * if (explorer.areaTags.forest) { ... }
	 */
	public var areaTags:Object        = {};
	
	private var source:GroupEncounter              = new GroupEncounter("UNUSED", []);
	private var playerEntry:ExplorationEntry       = null;
	private var currentEntry:ExplorationEntry      = null;
	private var flatList:/*ExplorationEntry*/Array = [];
	private var roads:/*ExplorationEntry[]*/Array  = [];
	private var road:/*ExplorationEntry*/Array     = null;
	/** Selected road */
	private var roadIndex:int                      = -1;
	/** Position on road - the next encounter to explore */
	private var roadPos:int                        = -1;
	private var initialized:Boolean                = false;
	private var finished:Boolean                   = false;
	
	/**
	 * Switch to clear, uninitialized state.
	 */
	public function clear():void {
		if (!initialized) return;
		trace("explorer.clear");
		initialized = false;
		finished    = false;
		areaTags    = {};
		leave       = new ButtonData("Leave", defaultReturn)
				.hint("Return to camp.")
				.icon("Back");
		prompt = "Explore the area.";
		onEnd  = new ButtonData("Return", defaultReturn)
				.hint("Return to camp.")
				.icon("Back");
		for (var i:int = 0; i < ExplorationEngine.N; i++) {
			flatList[i].setEmpty();
		}
		roadPos      = 0;
		roadIndex    = -1;
		road         = null;
		currentEntry  = null;
		onMenu = null;
		onEncounter   = null;
	}
	public function markEncounterDone():void {
		if (initialized && currentEntry != null) {
			trace("markEncounterDone",currentEntry.encounterName);
			currentEntry.markCleared();
			currentEntry = null;
			roadPos++;
			if (road[roadPos]) road[roadPos].isNext = true;
		}
	}
	/**
	 * Switch to "finished" state where data is still kept but exploration cannot proceed.
	 *
	 * This function can be called in encounters that finish exploration early (e.g. combat loss)
	 */
	public function stopExploring():void {
		trace("explorer.stopExploring")
		finished = true;
		areaTags = {};
		markEncounterDone();
	}
	/**
	 * End current encounter and display exploration UI.
	 * This function can be used as a callback when finishing the encounter.
	 *
	 * If there is no encounter, return to camp using 1 hour.
	 */
	public function done():void {
		trace("explorer.done");
		if (!initialized) {
			defaultReturn();
			return;
		}
		markEncounterDone();
		if (finished) onEnd.callback();
		else doExplore();
	}
	/**
	 * Start or continue the exploration.
	 *
	 * It is safe to call when exploration is finished (returns to camp after 1 hour).
	 * It throws an error if exploration is not initialized.
	 */
	public function doExplore():void {
		if (!initialized) throw new Error("ExplorationEngine was not initialized");
		if (finished) {
			trace("explorer.doExplore(finished)")
			onEnd.callback();
		} else if (roadIndex >= 0 && numUnexplored() == 0) {
			trace("explorer.doExplore(ended)")
			stopExploring();
			onEnd.callback();
		} else {
			trace("explorer.doExplore(normal)")
			validate();
			showUI();
		}
	}
	/**
	 * Do a full reset, then prepare the exploration of the area.
	 * @param area Group encounter to pick from
	 */
	public function prepareArea(area:GroupEncounter):void {
		trace("explorer.prepareArea");
		clear();
		this.source = area;
		generateAll();
	}

	private function defaultReturn():void {
		camp.returnToCampUseOneHour();
	}
	private function get maxRevealLevel():int {
		return canRevealFull ? ExplorationEntry.REVEAL_FULL : ExplorationEntry.REVEAL_KIND;
	}
	
	/**
	 * Current entry that is being executed - after player starts the encounter and before stopExploring()/markEncounterDone()/done()
	 */
	public function getCurrentEntry():ExplorationEntry {
		return currentEntry;
	}
	/**
	 * Next entry that player is about to step into. Is null at the end of the road, or when player didn't pick one yet.
	 * Inside the encounter, it is same as current entry.
	 */
	public function getNextEntry():ExplorationEntry {
		if (road && !finished) {
			var e:ExplorationEntry = road[roadPos];
			if (e && e.isNext && !e.isCleared && e.encounter) return e;
		}
		return null;
	}
	public function get inEncounter():Boolean {
		return !!currentEntry;
	}
	public function get isActive():Boolean {
		return initialized && !finished;
	}
	public function numUnexplored():int {
		if (!road || finished) return 0;
		var n:int = 0;
		for (var i:int = 0; i < road.length; i++) if (!road[i].isCleared) n++;
		return n;
	}
	public function numUnrevealed():int {
		var n:int   = 0;
		var max:int = maxRevealLevel;
		for (var i:int = 0; i < N; i++) {
			if (!flatList[i].isDisabled && flatList[i].revealLevel < max) n++;
		}
		return n;
	}

	public function findByName(name:String):ExplorationEntry {
		for (var i:int = 0; i < N; i++) {
			if (!flatList[i].isDisabled && flatList[i].encounterName == name) return flatList[i];
		}
		return null;
	}
	public function findAllByName(name:String):/*ExplorationEntry*/Array {
		var result:Array = [];
		for (var i:int = 0; i < N; i++) {
			if (!flatList[i].isDisabled && flatList[i].encounterName == name) result.push(flatList[i]);
		}
		return result;
	}
	public function revealRandom():ExplorationEntry {
		var n:int = numUnrevealed();
		if (n < 0) return null;
		var x:int   = rand(n);
		var max:int = maxRevealLevel;
		for (var i:int = 0; i < N; i++) {
			if (!flatList[i].isDisabled && flatList[i].revealLevel < max) {
				if (x == 0) {
					trace("Revaling entry " + ((i / MAXDEPTH) | 0) + ";" + (i % MAXDEPTH) + " " + flatList[i].encounterName);
					flatList[i].incReveal();
					return flatList[i];
				}
				x--;
			}
		}
		trace("No entry to reveal??");
		return null;
	}
	public function revealAllByName(name:String, level:int = ExplorationEntry.REVEAL_FULL):void {
		for (var i:int = 0; i < N; i++) {
			if (!flatList[i].isDisabled && flatList[i].encounterName == name) flatList[i].setRevealLevel(level);
		}
	}
	public function revealAll(level:int = ExplorationEntry.REVEAL_FULL):void {
		for (var i:int = 0; i < N; i++) {
			if (flatList[i].encounter) flatList[i].setRevealLevel(level);
		}
	}
	/**
	 * Reveal `n` locations.
	 * If `n` is float: `n = i + f` (`i` is int and `0<f<1`),
	 * then reveal either `i` or `i+1` locations, with `f` chance to reveal `i+1`
	 *
	 * @example
	 * revealMultiple(3.4) = 60% to reveal 3,
	 *                       40% to reveal 4
	 */
	public function revealMultiple(n:Number):void {
		var i:int = n | 0;
		if (Math.random() < n - i) i++;
		while (i-- > 0) {
			if (!revealRandom()) break;
		}
	}
	public function setTags(...tags:/*String*/Array):void {
		for each (var tag:String in tags) this.areaTags[tag] = true;
	}

	private function selectRoad(i:int):void {
		roadIndex = i;
		road      = roads[i];
		for (var j:int = 0; j < NROADS; j++) {
			if (i == j) continue;
			for (var k:int = 0; k < MAXDEPTH; k++) {
				if (roads[j][k]) roads[j][k].markDisabled();
			}
		}
		road[0].isNext = true;
		roadPos        = 0;
	}
	private function selectRoadAndExploreNext(i:int):void {
		selectRoad(i);
		exploreNext();
	}
	private function exploreNext():void {
		if (!road) throw new Error("No road selected");
		var next:ExplorationEntry = getNextEntry();
		if (next) {
			execEntry(next);
		} else {
			// End of road
			stopExploring();
			onEnd.callback();
		}
	}
	internal function entryClick(entry:ExplorationEntry):void {
		if (!entry.isNext) return;
		if (roadIndex < 0) {
			// Select road
			for (var i:int = 0; i < NROADS; i++) {
				if (roads[i][0] == entry) {
					selectRoadAndExploreNext(i);
					return;
				}
			}
		} else {
			if (getNextEntry() == entry) execEntry(entry);
		}
	}
	
	private function execEntry(entry:ExplorationEntry):void {
		trace("explorer.execEntry",entry.encounterName);
		clearOutput();
		if (currentEntry != null) {
			trace("WARNING: ExplorationEntry " + currentEntry.encounter.encounterName() + " was not resolved");
			currentEntry.isPlayerHere = false;
		}
		currentEntry = entry;
		if (playerEntry) playerEntry.isPlayerHere = false;
		entry.isPlayerHere = true;
		playerEntry        = entry;
		if (onEncounter != null) {
			if (onEncounter(entry)) return;
		}
		entry.encounter.execEncounter();
	}
	private function createMap():Sprite {
		var map:Sprite    = new Sprite();
		var g:Graphics    = map.graphics;
		const SIZE:Number = ExplorationEntry.RADIUS * 2;
		const XGAP:Number = (mainView.mainText.width) / (MAXDEPTH + 1) - SIZE;
		const YGAP:Number = SIZE * 1.5;
		
		var startPos:ExplorationEntry = new ExplorationEntry();
		startPos.label                = "Start";
		if (roadIndex < 0) {
			startPos.isPlayerHere = true;
			playerEntry           = startPos;
		}
		var startSprite:Sprite = startPos.render();
		startSprite.x          = XGAP / 2;
		startSprite.y          = YGAP + (NROADS - 1) * (SIZE + YGAP) / 2;
		map.addChild(startSprite);
		
		var y:Number = YGAP;
		for (var i:int = 0; i < NROADS; i++) {
			var x:Number              = startSprite.x + SIZE + XGAP;
			var prev:ExplorationEntry = startPos;
			var prevSprite:Sprite     = startSprite;
			for (var j:int = 0; j < MAXDEPTH; j++) {
				var next:ExplorationEntry = roads[i][j];
				if (next && next.encounter) {
					// draw the sprite
					var nextSprite:Sprite = next.render();
					nextSprite.x          = x;
					nextSprite.y          = y;
					map.addChild(nextSprite);
					// draw the line
					var lineColor:String = next.isNext ? LINE_NEXT : LINE_COLOR;
					g.lineStyle(LINE_WIDTH, Color.convertColor(lineColor));
					g.moveTo(prevSprite.x + SIZE / 2, prevSprite.y + SIZE / 2);
					if (prev == startPos) {
						var midx:Number = (prevSprite.x + nextSprite.x + SIZE) / 2;
						g.lineTo(midx, prevSprite.y + SIZE / 2);
						g.lineTo(midx, nextSprite.y + SIZE / 2);
						if (roadIndex < 0) {
							var tf:TextField = UIUtils.newTextField({
								text             : "" + (i + 1),
								x                : midx + 2,
								y                : nextSprite.y + SIZE / 2,
								defaultTextFormat: {
									font: mainView.mainText.defaultTextFormat.font,
									size: Number(mainView.mainText.defaultTextFormat.size)-2,
									color: mainView.mainText.defaultTextFormat.color
								}
							});
							map.addChild(tf);
							tf.y -= tf.height;
						}
					}
					g.lineTo(nextSprite.x + SIZE / 2, nextSprite.y + SIZE / 2);
					
					prev       = next;
					prevSprite = nextSprite;
				}
				x += SIZE + XGAP;
			}
			y += SIZE + YGAP;
		}
		
		return map;
	}
	private function showUI():void {
		clearOutput();
		spriteSelect();
		outputText(prompt);
		var overlust:int = camp.overLustCheck();
		mainView.setCustomElement(createMap());
		menu();
		var i:int;
		var next:ExplorationEntry = getNextEntry();
		if (road) {
			if (next) {
				// We're on the road
				button(0).show("Next", exploreNext).hint(next.tooltipText, next.tooltipHeader);
			} else {
				// End of the road
				onEnd.applyTo(button(0));
				button(0).call(function():void {
					stopExploring();
					onEnd.callback.call();
				});
			}
		} else {
			// Road not picked
			for (i = 0; i < NROADS; i++) {
				var b:CoCButton = (NROADS <= 3) ? button(i * 5) : button(i);
				b.show("Path " + (i + 1), curry(selectRoadAndExploreNext, i))
			}
		}
		button(10).show("Inventory", inventory.inventoryMenu)
				  .hint("Use an item or manage your equipment.")
				  .disableIf(!canInventory);
		SceneLib.masturbation.masturButton(11).disableIf(!canMasturbate);
		if (playerEntry && playerEntry.encounter && playerEntry.reenter) {
			button(12).show("Repeat", curry(execEntry,playerEntry))
					.hint("Repeat the '"+playerEntry.label+"' encounter.")
		}
		if (overlust == 2 && canMasturbate) {
			if (!(road && !next)) {
				// if not end of the road
				for (i = 0; i < NROADS; i++) button(i).disable("You're too aroused to explore!");
			}
		}
		
		if (debug) {
			button(14).show("Menu",cheatMenu);
		} else {
			if (leave && !finished) leave.applyTo(button(14));
		}
		if (onMenu != null) onMenu();
	}
	public function cheatMenu():void {
		function cheatReveal(level:int):void {
			revealAll(level);
			showUI();
		}
		function cheatReroll():void {
			for (var i:int = 0; i < N; i++) flatList[i].isPlayerHere = false;
			generateAll();
			showUI();
		}
		
		menu();
		button(0).show("Reveal(0)", curry(cheatReveal,0))
				 .hint("Hide all");
		button(1).show("Reveal(1)", curry(cheatReveal,1))
				 .hint("Partially reveal all");
		button(2).show("Reveal(2)", curry(cheatReveal,2))
				 .hint("Fully reveal all");
		if (!finished) button(3).show("Re-roll", cheatReroll)
				 .hint("Recreate the map")
		button(4).show("Camp", camp.returnToCampUseOneHour)
				 .hint("Return to camp");
		
		if (leave && !finished) leave.applyTo(button(13));
		button(14).show("Back",showUI).icon("Back");
	}
	
	/**
	 *
	 * @param entry
	 * @param special 0: first, 1: mid, 2: last
	 */
	private function generate(entry:ExplorationEntry, special:int):void {
		var nTries:int      = 10;
		var filter:Function = filters[special];
		while (nTries-- > 0) {
			var e:SimpleEncounter = source.pickEncounter(filter) as SimpleEncounter;
			if (!e) continue;
			if (e.unique) {
				var duplicate:Boolean = false;
				for (var i:int = 0; i < N; i++) {
					if (flatList[i] && !flatList[i].isCleared && flatList[i].encounter == e) {
						duplicate = true;
						break;
					}
				}
				if (duplicate) continue;
			}
			entry.setupForEncounter(e);
			return;
		}
		entry.setEmpty();
	}
	private function generateAll():void {
		for (var i:int = 0; i < NROADS; i++) {
			var length:int = randIntIn(2, MAXDEPTH);
			for (var j:int = length - 1; j >= 0; j--) {
				generate(roads[i][j],
						j == length - 1 ? 2
								: j == 0 ? 0 : 1);
			}
			for (j = length; j < MAXDEPTH; j++) roads[i][j].setEmpty();
			roads[i][0].isNext = true;
		}
		for (i = 0; i < NROADS; i++) {
			var s:String = "Road " + i + " is";
			for (j = 0; j < MAXDEPTH; j++) {
				s += " " + roads[i][j].encounterName
			}
			trace(s);
		}
		initialized = true;
		road = null;
		roadIndex = -1;
		roadPos = 0;
		currentEntry = null;
	}
	private function validate():void {
		for (var i:int = 0; i < NROADS; i++) {
			for (var j:int = 0; j < MAXDEPTH; j++) {
				var e:ExplorationEntry = roads[i][j];
				if (!e.isCleared && !e.isDisabled && e.encounter && e.encounter.originalChance() <= 0) {
					trace("Regenerating entry " + i + ";" + j + " " + e.encounterName);
					var special:int = 1;
					if (j == 0) special = 0;
					if (j + 1 == MAXDEPTH || roads[i][j + 1].isDisabled) special = 2;
					generate(e, special);
				}
			}
		}
	}
}
}
