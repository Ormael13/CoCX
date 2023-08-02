package coc.view {
import classes.internals.Utils;

import flash.display.DisplayObject;
import flash.sampler.stopSampling;

import mx.effects.Tween;
import mx.effects.easing.Exponential;

public class SimpleTween {
    public static const KnownEasings:Object = {
        "in": Exponential.easeIn,
        "easeIn": Exponential.easeIn,
        "out": Exponential.easeOut,
        "easeOut": Exponential.easeOut,
        "in-out": Exponential.easeInOut,
        "easeInOut": Exponential.easeInOut,
        "none": easingLinear,
        "linear": easingLinear
    }
    
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
        this._spr      = spr;
        this._prop     = prop;
        this._startVal = _spr[_prop];
        this._endVal   = endVal;
        this._duration = ms;
        this._onEnd    = Utils.valueOr(options && options.onEnd, null);
        this._color    = Utils.valueOr(options && options.color, false);
        var easingSpec:*    = options && options.easing;
        if (easingSpec && easingSpec is String) easingSpec = KnownEasings[easingSpec];
        this._easingFn = Utils.valueOr(easingSpec, Exponential.easeInOut);
//        trace("SimpleTween",spr.name,prop,'from',_startVal,"to",_endVal,"/",_duration)
        
        _active          = true;
        _tween = new Tween(this, _startVal, endVal, ms);
        if (_color) {
            _startVal = Color.getFloatComponents(Color.convertColor32(_startVal));
            _endVal = Color.getFloatComponents(Color.convertColor32(_endVal));
            _tween.easingFunction = colorEasingFn;
        } else {
            _tween.easingFunction = numberEasingFn;
        }
    }
    private function numberEasingFn(time:Number,start:Number,delta:Number,duration:Number):* {
        return _easingFn(time,_startVal,_endVal-_startVal,duration);
    }
    private function colorEasingFn(time:Number,start:*,delta:*,duration:Number):* {
        return Color.toHex(Color.interpolate(_startVal, _endVal, _easingFn(time,0,1,duration)));
    }
    public static function easingLinear(time:Number, start:Number, delta:Number, duration:Number):Number {
        return Utils.lerp(start,start+delta,time/duration);
    }
    
    private var _spr:DisplayObject;
    private var _prop:String;
    private var _startVal:*;
    private var _endVal:*;
    private var _duration:int;
    private var _easingFn:Function;
    private var _onEnd:Function;
    private var _tween:Tween;
    private var _active:Boolean;
    private var _color:Boolean;
    
    
    public function get startVal():* {
        return _startVal;
    }
    public function get endVal():* {
        return _endVal;
    }
    /**
     * Stop this tween and start a new one, to a new end value
     */
    public function retarget(newEndVal:*):SimpleTween {
        dispose();
        return new SimpleTween(_spr, _prop, newEndVal, _duration, {
            onEnd: _onEnd,
            color: _color,
            easing: _easingFn
        });
    }
    
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
        if (!_active) {
            callback();
            return;
        }
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
        _active = false;
        _tween = null;
    }
    public function fastForward():void {
        if (_active && _tween) {
            _tween.endTween();
        }
        _tween = null;
    }
}

}
