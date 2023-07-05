package coc.view {
import classes.internals.Utils;

import flash.display.DisplayObject;

import mx.effects.Tween;
import mx.effects.easing.Exponential;

public class SimpleTween {
    /**
     * Animate a property `prop` of sprite `spr` from its current value to `endVal`.
     * @param spr
     * @param prop
     * @param endVal
     * @param ms Animation duration in milliseconds
     * @param {Object} [options] Extra options
     * @param {int} [options.ms] Animation time, milliseconds (default 300)
     * @param {Function} [options.onEnd] Function to call on animation end
     * @param {Function} [options.easing] Easing function, default mx.effects.easing.Expontential.easeInOut
     */
    public function SimpleTween(spr:DisplayObject, prop:String, endVal:*, ms:int=300, options:Object = null) {
        this._spr  = spr;
        this._prop = prop;
        options = Utils.extend({
            onEnd: null,
            easing: Exponential.easeInOut
        }, options);
        this._onEnd  = options.onEnd;
        _active    = true;
        _tween = new Tween(this, _spr[_prop], endVal, ms);
        _tween.easingFunction = options.easing;
    }
    
    private var _spr:DisplayObject;
    private var _prop:String;
    private var _onEnd:Function;
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
        
        if (_onEnd != null) {
            _onEnd();
        }
    }
    
    public function then(callback:Function):void {
        if (!_active) return;
        if (_onEnd != null) {
            var oldOnEnd:Function = _onEnd;
            _onEnd = function():void {
                oldOnEnd();
                callback();
            }
        } else {
            _onEnd = callback;
        }
    }
    
    public function dispose():void {
        if (_active && _tween) {
            _tween.stop();
        }
        _tween = null;
    }
}

}
