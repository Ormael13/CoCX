package coc.view.charview {

import coc.view.*;

import classes.ItemSlotClass;
import classes.ItemType;

import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

//Port from /hgg/ by Oxdeception
public class DragButton {
    internal static var dragButtons:Array = [];

    public static function cleanUp():void {
        for each (var dragButton:DragButton in dragButtons) {
            dragButton.dispose();
        }
        dragButtons = [];
    }

    private static var _toolTip:ToolTipView;
    private static var _container:DisplayObjectContainer;

    public static function setup(container:DisplayObjectContainer, toolTip:ToolTipView):void {
        _container = container;
        _toolTip = toolTip;
    }

    /**
     * A listener that allows inventory buttons to be dragged and dropped onto other buttons.
     * @param store [ItemSlotClass Array or Vector.<ItemSlotClass>] the inventory array that this button is representing
     * @param loc the position in store that this button represents
     * @param button the button that is made draggable and/or target-able for dropping
     * @param allowedItems [(ItemType) -> Boolean] function returning if an item type is allowed in the button's item slot
     */
    public function DragButton(store:*, loc:int, button:CoCButton, allowedItems:Function) {
        if (store is Vector.<ItemSlotClass>) {
            this._inventory = store;
        } else {
            this._storage = store;
        }
        this._location   = loc;
        this._acceptable = allowedItems;
        this._button     = button;
        this._button.addEventListener(MouseEvent.MOUSE_DOWN, dragHandler);
        dragButtons.push(this);
    }

    private var _button:CoCButton;
    private var _origin:Point;
    private var _parent:DisplayObjectContainer;
    private var _stage:Stage;
    private var _selected:Boolean = false;
    private var _dragging:Boolean = false;
    private var _tweening:Boolean = false;
    private var _xTween:TweenListener;
    private var _yTween:TweenListener;

    private var _storage:Array;
    private var _inventory:Vector.<ItemSlotClass>;
    private var _location:int;
    private var _acceptable:Function;

    // Used to add a short delay before starting to drag buttons. Allows for some mouse movement when clicking
    private var _timer:Timer = new Timer(50);

    private function get itemSlot():ItemSlotClass {
        if (_storage) {
            return _storage[_location];
        } else {
            return _inventory[_location];
        }
    }

    private function set itemSlot(value:ItemSlotClass):void {
        // Prevent locking inventory slots
        if (!value.unlocked) {
            // changing item slot unlocked state causes it to clear its contents
            var iType:ItemType = value.itype;
            var count:int      = value.quantity;
            value.unlocked     = true;
            value.setItemAndQty(iType, count);
        }
        if (_storage) {
            _storage[_location] = value;
            if (value.isEmpty()) {_button.labelText = "Empty";}
        } else {
            _inventory[_location] = value;
            if (value.isEmpty()) {_button.labelText = "Nothing";}
        }
    }

    public function dispose():void {
        _button.removeEventListener(MouseEvent.MOUSE_DOWN, dragHandler);
        _button.removeEventListener(MouseEvent.CLICK, clickHandler);
        if (_stage) {
            _stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
            _stage.removeEventListener(MouseEvent.MOUSE_UP, dropHandler);
        }
        if (_origin) {
            _parent = _parent || _button.parent;
            resetPosition();
        }
    }

    private function resetPosition():void {
        _tweening = false;
        _dragging = false;
        _selected = false;
        _parent.addChild(_button);
        _origin = _parent.globalToLocal(_origin);
        _button.stopDrag();
        _button.x = _origin.x;
        _button.y = _origin.y;
        _button.removeEventListener(MouseEvent.ROLL_OVER, hoverHandler);
        _button.removeEventListener(MouseEvent.ROLL_OUT, hoverHandler);
        if(_xTween) {_xTween.dispose();}
        if(_yTween) {_yTween.dispose();}
        _timer.reset();
        _container.addChild(_toolTip); // reset tool tip to top of display stack
    }

    private function swap():Boolean {
        var t:* = _button.dropTarget;
        while (true) {
            if (t is CoCButton) {break;}
            if (t == null) {return false;}
            t = t.parent;
        }
        var target:CoCButton = t as CoCButton;
        for each (var dButton:DragButton in dragButtons) {
            if (dButton._button == target) {
                return swapWith(dButton);
            }
        }
        return false;
    }

    private function swapWith(target:DragButton):Boolean {
        if (!target._acceptable(this.itemSlot.itype)) {return false;}
        if (!_acceptable(target.itemSlot.itype) && !target.itemSlot.isEmpty()) {return false;}
        var tLabel:String         = target._button.labelText;
        var tToolTipText:String   = target._button.toolTipText;
        var tToolTipHeader:String = target._button.toolTipHeader;
        var tEnabled:Boolean      = target._button.enabled;

        target._button.labelText     = _button.labelText;
        target._button.toolTipHeader = _button.toolTipHeader;
        target._button.enable(_button.toolTipText);

        _button.labelText     = tLabel;
        _button.toolTipHeader = tToolTipHeader;
        _button.toolTipText   = tToolTipText;
        _button.enable();
        _button.disableIf(!tEnabled);

        var hold:ItemSlotClass = target.itemSlot;
        target.itemSlot   = this.itemSlot;
        this.itemSlot     = hold;
        return true;
    }

    private function dragHandler(e:MouseEvent):void {
        if (!_button.enabled || _dragging || _selected) {return;}
        if (_tweening) {
            resetPosition();
        }
        e.stopImmediatePropagation();
        _selected = true;
        _parent = this._button.parent;
        _origin = _parent.localToGlobal(new Point(_button.x, _button.y));
        _stage  = _parent.stage;
        _container.addChild(_button);
        var mOrg:Point = _container.globalToLocal(_origin);
        _button.x      = mOrg.x;
        _button.y      = mOrg.y;
        this._button.startDrag(false, new Rectangle(0, 0, _container.width, _container.height));
        _stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
        _stage.addEventListener(MouseEvent.MOUSE_UP, dropHandler);
    }

    private function moveHandler(e:MouseEvent):void {
        e.stopImmediatePropagation();
        CONFIG::AIR {
            // Dead zone for mobile users so that tooltips can be viewed
            var pos:Point = _button.parent.localToGlobal(new Point(_button.x, _button.y));
            var dist:Number = Point.distance(_origin, pos);
            if (!_dragging && dist < 20) {
                return;
            }
        }
        switch (true) {
            case _dragging:
                if (!e.buttonDown) {dropHandler(e);}
                return;
            case !_timer.running:
                _timer.start();
                return;
            case _timer.currentCount < 1:
                return;
        }
        _timer.reset();
        _button.dim(e);
        _toolTip.hide();
        _dragging = true;
        _button.addEventListener(MouseEvent.CLICK, clickHandler, false, 999);
        _button.addEventListener(MouseEvent.ROLL_OVER, hoverHandler, false, 999);
        _button.addEventListener(MouseEvent.ROLL_OUT, hoverHandler, false, 999);
    }

    private function dropHandler(e:MouseEvent):void {
        _dragging = false;
        _tweening = true;
        _stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
        _stage.removeEventListener(MouseEvent.MOUSE_UP, dropHandler);
        _button.stopDrag();
        if (swap()) {
            resetPosition();
        } else {
            _xTween = new TweenListener(_button, "x", _origin.x, resetPosition);
            _yTween = new TweenListener(_button, 'y', _origin.y);
        }
        _container.addChild(_toolTip); // reset tool tip to top of display stack

    }

    private function hoverHandler(e:MouseEvent):void {
        e.stopImmediatePropagation();
    }

    private function clickHandler(e:MouseEvent):void {
        e.stopImmediatePropagation();
        _button.removeEventListener(MouseEvent.CLICK, clickHandler);
    }
}
}

import classes.EngineCore;

import flash.display.Sprite;

import mx.effects.Tween;
import mx.effects.easing.Elastic;

import mx.effects.easing.Exponential;

class TweenListener {
    public function TweenListener(spr:Sprite, prop:String, endVal:*, fun:Function = null) {
        this._spr  = spr;
        this._prop = prop;
        this._fun  = fun;
        _active    = true;

        var ms:int      = 300;
        var fn:Function = Exponential.easeOut;

        if (EngineCore.silly()) {
            ms = 750;
            fn = Elastic.easeOut;
        }

        _tween = new Tween(this, _spr[_prop], endVal, ms);
        _tween.easingFunction = fn;
    }

    private var _spr:Sprite;
    private var _prop:String;
    private var _fun:Function;
    private var _tween:Tween;
    private var _active:Boolean;

    // This function is called by the tween every tick
    public function onTweenUpdate(val:*):void {
        this._spr[_prop] = val;
    }

    // This function is called by the tween after it ends
    public function onTweenEnd(val:*):void {
        onTweenUpdate(val);
        _active    = false;
        this._prop = null;

        if (_fun != null) {
            _fun();
        }
    }

    public function dispose():void {
        if (_active && _tween) {
            _tween.stop();
        }
        _tween = null;
    }
}