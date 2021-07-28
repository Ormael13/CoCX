/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.CoC_Settings;
import classes.Creature;
import classes.internals.SimpleJsonable;
import classes.Measurements;

public class BodyPart extends SimpleJsonable {

    protected var _type:int = 0;
	public function restore(keepColor:Boolean = true):void {
		type = 0;
	}
	private var _creature:Creature;
	public function get creature():Creature {
		return _creature;
	}
	public function BodyPart(creature:Creature,publicPrimitives:Array) {
		addPublicPrimitives(["type"]);
		addPublicPrimitives(publicPrimitives);
		this._creature       = creature;
	}
	public function get type():int {return _type;}
	public function set type(value:int):void {_type = value;}

	public function isAny(...args:Array):Boolean {
		while (args.length == 1 && args[0] is Array) args = args[0];
		for each (var i_type:int in args) if (type == i_type) return true;
		return false;
	}
	public function isNeither(...args:Array):Boolean {
		if (args.length == 1 && args[0] is Array) args = args[0];
		for each (var i_type:int in args) if (type == i_type) return false;
		return true;
	}
	/**
	 * Should be implemented in subclasses.
	 */
	public function descriptionFull():String {
		CoC_Settings.errorAMC("BodyPart","describe");
		return "something";
	}
	public function setProps(p:Object):void {
		copyObjectEx(this, p, myPublicPrimitives);
	}

	public function setAllProps(p:Object, keepTone:Boolean = true):void {
		restore(keepTone);
		setProps(p);
	}
	/**
	 * Tests each property in `p` against this object property with the same name.
	 * Keys should be equal to public this properties.
	 * Value can be either primitives, objects, or arrays.
	 * If value is a primitive, this property should be equal
	 * If value is an object and this property is a BodyPart, this sub-object is passed to its checkProps
	 * If value is an array, this property should pass any of the elements' checks
	 *
	 * Example:
	 *
	 * player.skin.checkProps({
	 *     coverage: [0, 1, 2], // either none, low, or mid coverage
	 *     base: {
	 *         type: PLAIN,
	 *         color: ["blue", "light blue"]
	 *     }
	 * });
	 *
	 * @return true if all tests are passed
	 */
	public function checkProps(p:Object):Boolean {
		for (var key:String in p) {
			var v:Array = p[key] is Array ? p[key] : [p[key]];
			var thiz:* = this[key];
			for each (var test:* in v) {
				if (thiz is BodyPart && test is Object) {
					if (!thiz.checkProps(test)) return false;
				} else if (thiz != test) return false;
			}
		}
		return true;
	}
}
}
