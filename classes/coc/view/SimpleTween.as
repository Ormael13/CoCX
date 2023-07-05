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
     * @param {Boolean} [options.color] The values are colors
     */
    public function SimpleTween(spr:DisplayObject, prop:String, endVal:*, ms:int=300, options:Object = null) {
        this._spr        = spr;
        this._prop       = prop;
        options          = Utils.extend({
            onEnd: null,
            easing: Exponential.easeInOut,
            color: false
        }, options);
        this._onEnd      = options.onEnd;
        this._color      = options.color;
        
        var startVal:* = _spr[_prop];
        _active          = true;
        _tween = new Tween(this, startVal, endVal, ms);
        if (_color) {
            _tween.easingFunction = easingColorFunction(startVal, endVal, options.easing);
        } else {
            _tween.easingFunction = options.easing;
        }
    }
    public static function easingColorFunction(
            startColor:*,
            endColor:*,
            easingFunction:Function
    ): Function {
        var startARGB:Object = Color.getFloatComponents(Color.convertColor32(startColor));
        var endARGB:Object = Color.getFloatComponents(Color.convertColor32(endColor));
        var deltaARGB:Object = {
            a: endARGB.a - startARGB.a,
            r: endARGB.r - startARGB.r,
            g: endARGB.g - startARGB.g,
            b: endARGB.b - startARGB.b
        };
        return function(time:Number,start:*,end:*,duration:Number):* {
            return Color.toHex(
                    Color.fromArgbFloat(
                            easingFunction(time, startARGB.a, deltaARGB.a, duration),
                            easingFunction(time, startARGB.r, deltaARGB.r, duration),
                            easingFunction(time, startARGB.g, deltaARGB.g, duration),
                            easingFunction(time, startARGB.b, deltaARGB.b, duration)
                    ), true
            )
        }
    }
    
    private var _spr:DisplayObject;
    private var _prop:String;
    private var _onEnd:Function;
    private var _tween:Tween;
    private var _active:Boolean;
    private var _color:Boolean;
    
    // This function is called by the tween every tick
    public function onTweenUpdate(val:*):void {
        this._spr[_prop] = val;
    }
    
    // This function is called by the tween after it ends
    public function onTweenEnd(val:*):void {
        try {
            onTweenUpdate(val);
            _active = false;
            
            if (_onEnd != null) {
                _onEnd();
            }
        } catch (e:Error) {
            trace(e.getStackTrace());
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
