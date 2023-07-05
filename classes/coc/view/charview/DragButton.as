package coc.view.charview {

import classes.EngineCore;
import classes.ItemSlotClass;
import classes.ItemType;

import coc.view.*;

import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

import mx.effects.easing.Elastic;

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
     * @param itemSlot the item slot that this button is representing
     * @param button the button that is made draggable and/or target-able for dropping
     * @param allowedItems [(ItemType) -> Boolean] function returning if an item type is allowed in the button's item slot
     */
    public function DragButton(itemSlot:ItemSlotClass, button:CoCButton, allowedItems:Function) {
        this._itemSlot = itemSlot;
        this._acceptable = allowedItems || function(type:ItemType):Boolean { return true };
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
    private var _xTween:SimpleTween;
    private var _yTween:SimpleTween;

    private var _itemSlot:ItemSlotClass;
    private var _acceptable:Function;

    // Used to add a short delay before starting to drag buttons. Allows for some mouse movement when clicking
    private var _timer:Timer = new Timer(50);

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
        if (target._itemSlot.isEmpty() || target._itemSlot.itype == this._itemSlot.itype && target._itemSlot.hasRoom()) {
            // can move items one by one (to anempty cell or to a stack of similar items)
            var movingQty:int = Math.min(this._itemSlot.quantity, target._itemSlot.roomLeft()); // how much we move
            target._itemSlot.setItemAndQty(this._itemSlot.itype, target._itemSlot.quantity + movingQty); //even if not empty, item type won't change
            // if out of items, set this to empty
            this._itemSlot.quantity = this._itemSlot.quantity - movingQty; // auto-empty if spent

        } else { // attempt to swap items
            // can't place item type - abort
            if (!target._acceptable(this._itemSlot.itype) ||
                !this._acceptable(target._itemSlot.itype) && !target._itemSlot.isEmpty()) return false;
            // can't fit quantity - abort
            if (this._itemSlot.quantity > target._itemSlot.defaultStackSize() ||
                target._itemSlot.quantity > this._itemSlot.defaultStackSize()) return false; // if can't fit - abort
            var holdItype:ItemType = target._itemSlot.itype;
            var holdQty:int = target._itemSlot.quantity;
            target._itemSlot.setItemAndQty(this._itemSlot.itype, this._itemSlot.quantity);
            this._itemSlot.setItemAndQty(holdItype, holdQty);
        }
        // now fixing the buttons. Create new ButtonData based on the existing buttons & items and apply it.
        new ButtonData("")
            .fromButton(this._button)
            .forItemSlot(this._itemSlot)
            .drag(this._itemSlot, this._acceptable) // _acceptable is the same for player and storage inventories
            .enable() // in case it was empty and disabled
            .disableIf(this._itemSlot.isEmpty())
            .applyTo(this._button);
        new ButtonData("")
            .fromButton(target._button)
            .forItemSlot(target._itemSlot)
            .drag(target._itemSlot, target._acceptable) // _acceptable is the same for player and storage inventories
            .enable() // in case it was empty and disabled
            .disableIf(target._itemSlot.isEmpty())
            .applyTo(target._button);
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
            var ms:int = 300;
            var easing:Function = Elastic.easeOut;
            if (EngineCore.silly()) {
                ms = 750;
                easing = Elastic.easeOut;
            }
            _xTween = new SimpleTween(_button, "x", _origin.x, ms,{
                easing: easing,
                fun: resetPosition
            });
            _yTween = new SimpleTween(_button, 'y', _origin.y, ms,{
                ms    : ms,
                easing: easing
            });
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

