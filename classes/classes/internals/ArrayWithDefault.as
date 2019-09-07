/**
 * Created by aimozg on 02.04.2017.
 */
package classes.internals {
import flash.utils.Proxy;
import flash.utils.flash_proxy;

use namespace flash_proxy;

public dynamic class ArrayWithDefault extends Proxy {
	protected const array:Array    = [];
	protected const _debug:Boolean = false;
	public function ArrayWithDefault(array:Array=null) {
		if (array!=null) this.array.push.apply(this.array,array);
	}
	override flash_proxy function hasProperty(name:*):Boolean {
		if (_debug) trace("hasProperty", name);
		return isFinite(+name);
	}
	override flash_proxy function getProperty(name:*):* {
		const s:Number = +name;
		const i:int = new int(s);
		if (_debug) trace("getProperty ",typeof(name), name);
		if (s >= 0) {
			stretch(i + 1);
			if (_debug) trace("Counter " + i + " being accessed. Value = " + array[i]);
			return array[i];
		} else return array[name];
	}
	public function get length():int {
		return array.length;
	}
	override flash_proxy function setProperty(name:*, value:*):void {
		if (name == "length"){
			if (_debug) trace("setProperty ", name, value);
			stretch(value);
		} else {
			const s:Number = +name;
			const i:int = new int(s);
			value = cast(value);
			if (_debug) trace("setProperty ", name, value);
			if (isFinite(s)) {
				stretch(i);
				array[i] = value;
			}
		}
	}
	protected function cast(o:*):* {
		return o;
	}
	protected function stretch(length:int):void {
		if (length > array.length){
			if (_debug) trace("stretch(" + length + ").");
			for (var j:int=array.length; j < length; j++) array[j] = defaultValue();
		}
	}
	protected function defaultValue():* {
		return undefined;
	}
	override flash_proxy function deleteProperty(name:*):Boolean {
		if (_debug) trace("deleteProperty", name);
		const s:Number = +name;
		const i:int = new int(s);
		if (isFinite(s) && i < array.length) {
			if (i == array.length -1) {
				array.length = i;
				return true;
			} else {
				array[i] = defaultValue();
			}
		}
		return false;
	}


	override flash_proxy function nextName(index:int):String {
		if (_debug) trace("nextName", index);
		return index.toString();
	}

	override flash_proxy function nextValue(index:int):* {
		if (_debug) trace("nextValue", index);
		return array[index];
	}

	override flash_proxy function nextNameIndex(index:int):int {
		if (_debug) trace("nextNameIndex ", index);
		if (index < array.length) return index+1;
		return 0;
	}

	override flash_proxy function callProperty(name:*, ...rest):* {
		if (name == "valueOf") return toString();
		const v:Function = this[name];
		return v.apply(this,rest);
	}

	public function toString():String {
		return "["+array.toString()+"]";
	}
}
}
