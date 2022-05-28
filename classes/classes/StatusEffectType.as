/**
 * Created by aimozg on 31.01.14.
 */
package classes
{
import flash.utils.Dictionary;

public class StatusEffectType
{
	/**
	 * Do not report an error if one of these was found in save file
	 */
	public static const RemovedIds:/*String*/Array = [
		"Str Tou Spe Counter 1",
		"Str Tou Spe Counter 2",
		"Int Wis Counter 1",
		"Int Wis Counter 2",
		"Lib Sens Counter 1",
		"Lib Sens Counter 2",
	];
	
	private static var STATUSAFFECT_LIBRARY:Dictionary = new Dictionary();
	private var arity:int;
	
	public static function lookupStatusEffect(id:String):StatusEffectType{
		return STATUSAFFECT_LIBRARY[id];
	}
	
	public static function getStatusEffectLibrary():Dictionary
	{
		return STATUSAFFECT_LIBRARY;
	}
	
	private var _id:String;
	
	/**
	 * Unique perk id, should be kept in future game versions
	 */
	public function get id():String
	{
		return _id;
	}
	
	private var _secClazz:Class;
	
	/**
	 * @param id Unique status effect id; should persist between game version
	 * @param clazz Class to create instances of
	 * @param arity Class constructor arity: 0: new clazz(), 1: new clazz(thiz:StatusEffectType)
	 */
	public function StatusEffectType(id:String,clazz:Class,arity:int)
	{
		this._id = id;
		this.arity = arity;
		this._secClazz = clazz;
		if (STATUSAFFECT_LIBRARY[id] != null) {
			CoC_Settings.error("Duplicate status affect "+id);
		}
		STATUSAFFECT_LIBRARY[id] = this;
		if (!(arity >=0 && arity <= 1)) throw new Error("Unsupported status effect '"+id+"' constructor arity "+arity);
	}
	
	public function create(value1:Number, value2:Number, value3:Number, value4:Number):StatusEffectClass {
		var sec:StatusEffectClass;
		if (arity == 0) sec = new _secClazz();
		else if (arity == 1) sec = new _secClazz(this);
		sec.value1 = value1;
		sec.value2 = value2;
		sec.value3 = value3;
		sec.value4 = value4;
		return sec;
	}
	
	
	public function toString():String
	{
		return "\""+_id+"\"";
	}
}
}
