/**
 * Created by aimozg on 25.04.2017.
 */
package classes.internals {
public class SimpleJsonable extends Utils implements Jsonable{
	protected const myPublicPrimitives: Array = [];
	protected const myPublicJsonables: Array = [];
	/**
	 * @see Utils.copyObject
	 * @param names names of !public! !primitive!-typed properties that should be saved/loaded
	 */
	protected function addPublicPrimitives(names:Array): void {
		myPublicPrimitives.push.apply(myPublicPrimitives,names);
	}
	/**
	 * @param names names of !public! !Jsonable!-typed properties that should be saved/loaded
	 */
	protected function addPublicJsonables(names:Array):void {
		myPublicJsonables.push.apply(myPublicJsonables,names);
	}
	public function saveToObject():Object {
		var o:* = {};
		if (myPublicPrimitives.length > 0) o = copyObjectEx(o, this, myPublicPrimitives, true);
		for each (var key:String in myPublicJsonables) {
			o[key] = (this[key] as Jsonable).saveToObject();
		}
		return o;
	}
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (!(o is Object) || o === null) o = {};
		if (myPublicPrimitives.length>0) copyObjectEx(this, o, myPublicPrimitives, false, ignoreErrors);
		for each (var key:String in myPublicJsonables) {
			var v:* = o[key];
			if (!(v is Object) || v === null) v = {};
			try {
				(this[key] as Jsonable).loadFromObject(v, ignoreErrors);
			} catch (e:*) {
				if (!ignoreErrors) throw e;
				trace(e);
			}
		}
	}
	public static function getPublicPrimitives(o:SimpleJsonable):Array {
		return o.myPublicPrimitives;
	}
	public static function getPublicJsonables(o:SimpleJsonable):Array {
		return o.myPublicJsonables;
	}
}
}
