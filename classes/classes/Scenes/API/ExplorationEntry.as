package classes.Scenes.API {
import classes.CoC;
import classes.Scenes.SceneLib;

import coc.view.Color;
import coc.view.UIUtils;

import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class ExplorationEntry {
	public static const REVEAL_NOT:int  = 0;
	public static const REVEAL_KIND:int = 1;
	public static const REVEAL_FULL:int = 2;
	public static const RADIUS:Number   = 16;
//	public static const LABEL_TEXT_FORMAT:Object = {
//		color: "#000000",
//		align: "center"
//	};
//	public static const LABEL_OUTLINE:String     = "#888800";
	private static const BORDER_WIDTH:Number   = 3;
	private static const BORDER_CLEARED:String = "#222222";
	private static const BORDER_UNKNOWN:String = "#222222";
	private static const BORDER_NEXT:String    = "#0080ff";
	private static const BORDER_PLAYER:String  = "#ffaa00";
	private static const COLOR_DISABLED:String = "#666666";
	private static const COLOR_DEFAULT:String  = "#aaaaaa";
	public static const EncounterKinds:Object = {
		"walk"    : {label: "Walk", color: "#eeeeee", time: 30},
		"item"    : {label: "Item", color: "#00ff00", time: 10},
		"treasure": {label: "Treasure", color: "#80ff00", time: 15},
		"npc"     : {label: "NPC", color: "#ff80ff", time: 30},
		"place"   : {label: "Place", color: "#88aaff", time: 30},
		"special" : {label: "Special", color: "#ff00ff", time: 30},
		"event"   : {label: "Event", color: "#eeee00", time: 15},
		"monster" : {label: "Monster", color: "#aa0000", time: 15},
		"boss"    : {label: "Boss", color: "#ff0000", time: 30},
		"trap"    : {label: "Trap", color: "#ff8000", time: 15}
	}

	public var encounter:SimpleEncounter;
	public var kind:String;
	public var color:String;
	public var label:String;
	public var tooltipHeader:String;
	public var tooltipText:String;
	public var isNext:Boolean;
	public var isCleared:Boolean;
	public var isDisabled:Boolean; // no encounter, cleared, or off-road
	public var isPlayerHere:Boolean;
	public var revealLevel:int; // 0: not revealed, 1: kind, 2: full
	public var reenter:Boolean;
	public var x:Number;
	public var y:Number;
	public function get centerX():Number { return x + RADIUS; }
	public function get centerY():Number { return y + RADIUS; }
	public var sprite:Sprite;
	public var tfLabel:TextField;
	public var roadIndex:int;
	public var roadPos:int;
	public var nextNodes:/*ExplorationEntry*/Array = [];

	public function get isFullyRevealed():Boolean { return revealLevel == REVEAL_FULL }
	public function get encounterName():String { return encounter ? encounter.encounterName() : "(null)"}
	public function ExplorationEntry(
			roadIndex: int,
			roadPos: int,
			x: Number,
			y: Number
	) {
		this.roadIndex = roadIndex;
		this.roadPos = roadPos;
		this.x = x;
		this.y = y;
		createUI();
		setEmpty();
	}

	private function createUI():void {
		sprite = new Sprite();
		tfLabel         = UIUtils.newTextField({
			x                : 0,
			y                : 2 * RADIUS,
			width            : 2 * RADIUS,
			autoSize         : TextFieldAutoSize.CENTER
		});
//		tfLabel.filters       = [UIUtils.outlineFilter(LABEL_OUTLINE)];
		sprite.addChild(tfLabel);

		sprite.mouseChildren = false;
		sprite.addEventListener(MouseEvent.CLICK, onClick);
		sprite.addEventListener(MouseEvent.ROLL_OVER, onHover);
		sprite.addEventListener(MouseEvent.ROLL_OUT, onDim);
		sprite.x = x;
		sprite.y = y;
	}
	public function redraw():void {
		var g:Graphics = sprite.graphics;

		var borderColor:uint = Color.convertColor32(
				isPlayerHere ? BORDER_PLAYER
						: isDisabled ? BORDER_CLEARED
								: isNext ? BORDER_NEXT
										: isCleared ? BORDER_CLEARED : BORDER_UNKNOWN
		);

		g.clear();
		g.lineStyle(BORDER_WIDTH, borderColor);
		g.beginFill(Color.convertColor32(isPlayerHere ? COLOR_DISABLED : color));
		g.drawCircle(RADIUS, RADIUS, RADIUS);
		g.endFill();

		var mainTextFormat:TextFormat = CoC.instance.mainView.mainText.defaultTextFormat;
		tfLabel.defaultTextFormat = UIUtils.convertTextFormat({
			font : mainTextFormat.font,
			size : Number(mainTextFormat.size || 12) - 4,
			color: mainTextFormat.color,
			align: 'center'
		});
		tfLabel.text = label;

		sprite.buttonMode = isNext;
	}

	private function onClick(event:MouseEvent):void {
		if (encounter && !isDisabled) SceneLib.explorationEngine.entryClick(this);
	}
	private function onHover(event:MouseEvent):void {
		if (!tooltipText && !tooltipHeader) return;
		CoC.instance.mainView.toolTipView.showForElement(event.target as DisplayObject, tooltipHeader, tooltipText)
	}
	private function onDim(event:MouseEvent):void {
		CoC.instance.mainView.toolTipView.hide();
	}

	public function setEmpty():void {
		encounter     = null;
		kind          = null;
		label         = "";
		color         = COLOR_DISABLED;
		tooltipHeader = "";
		tooltipText   = "";
		isNext        = false;
		isDisabled    = true;
		isCleared     = false;
		isPlayerHere  = false;
		revealLevel   = REVEAL_NOT;
		reenter       = false;
		unlink();
	}
	public function unlink():void {
		nextNodes = [];
	}
	public function unlinkOne(e:ExplorationEntry):void {
		var i:int = nextNodes.indexOf(e);
		if (i >= 0) nextNodes.splice(i, 1);
	}
	public function link(e:ExplorationEntry):void {
		nextNodes.push(e);
	}

	public function setupForEncounter(e:SimpleEncounter):void {
		encounter  = e;
		kind       = e.getKind();
		isCleared  = false;
		isDisabled = false;
		reenter    = !!e.reenter;
		setRevealLevel(REVEAL_NOT);
	}
	public function incReveal():void {
		if (revealLevel == REVEAL_NOT) revealKind();
		else revealFull();
	}
	public function revealKind():void {
		revealLevel     = REVEAL_KIND;
		var kind:String = encounter.getKind();
		if (kind) {
			if (kind in EncounterKinds) {
				var entry:*   = EncounterKinds[kind];
				label         = entry.label;
				tooltipHeader = label;
				tooltipText   = ('hint' in entry) ? entry.hint : "Trigger this encounter";
				color         = ('color' in entry) ? entry.color : COLOR_DEFAULT;
			} else {
				label         = kind;
				tooltipHeader = label;
			}
		} else {
			label         = "ERROR";
			tooltipHeader = label;
			tooltipText   = "This encounter doesn't kave 'kind' property configured. This is a bug. You can still safely trigger it";
		}
	}
	public function setRevealLevel(level:int):void {
		revealLevel = level;
		if (level == REVEAL_NOT) {
			label         = "???";
			color         = COLOR_DEFAULT;
			tooltipHeader = "Unknown Encounter";
			tooltipText   = "Trigger this encounter";
			redraw();
		} else if (level == REVEAL_KIND) {
			revealKind();
		} else if (level == REVEAL_FULL) {
			revealFull();
		}
	}

	public function revealFull():void {
		revealKind();
		revealLevel   = REVEAL_FULL;
		label         = encounter.getLabel();
		tooltipHeader = encounter.getTooltipHeader();
		tooltipText   = encounter.getTooltipHint();
	}

	public function markCleared():void {
		revealFull();
		color         = COLOR_DISABLED;
		isNext        = false;
		isCleared     = true;
		tooltipHeader = "";
		tooltipText   = "";
	}
	public function markDisabled():void {
		if (!encounter) return;
		color         = COLOR_DISABLED;
		isDisabled    = true;
		isNext        = false;
		tooltipHeader = "";
		tooltipText   = "";
	}
	public function toString():String {
		if (roadIndex < 0) return "[Start]";
		return "["+roadIndex+";"+roadPos+";"+encounterName+"]";
	}
}
}
