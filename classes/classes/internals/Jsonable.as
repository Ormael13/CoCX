/**
 * Created by aimozg on 25.04.2017.
 */
package classes.internals {
/**
 * Interface for serialization to/deserialization from plain objects.
 * Built-in Flash serialization breaks inter-version compatibility.
 */
public interface Jsonable {
	function saveToObject():Object;
	function loadFromObject(o:Object, ignoreErrors:Boolean):void;
}
}
