package classes
{
	/**
	 * Enum Class. http://scottbilas.com/blog/ultimate-as3-fake-enums/
	 * @author scottbilas
	 */
	import flash.utils.*;
	
	// This whole thing is a fucking abomination and it needs to die in a horrible fucking fire.
	public /*abstract*/class Enum implements IExternalizable
	{
		public function get Name():String
		{
			return _name;
		}
		
		public function get Index():int
		{
			return _index;
		}
		
		public /*override*/function toString():String
		{
			return Name;
		}
		
		public static function GetConstants(i_type:Class):Array
		{
			var constants:EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
			
			// return a copy to prevent caller modifications
			return constants.ByIndex.slice();
		}
		
		public static function ParseConstant(i_type:Class, i_constantName:String, i_caseSensitive:Boolean = false):Enum
		{
			var constants:EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
			
			var constant:Enum = constants.ByName[i_constantName.toLowerCase()];
			if (i_caseSensitive && (constant != null) && (i_constantName != constant.Name))
				return null;
			
			return constant;
		}
		
		public static function ParseConstantByIndex(i_type:Class, i_constantIndex:int):Enum
		{
			var constants:EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
				
			var constant:Enum = constants.ByIndex[i_constantIndex];
			if (constant != null && i_constantIndex != constant.Index)
				return null;
				
			return constant;			
		}
		
		/*-----------------------------------------------------------------*/
		
		/*protected*/
		function Enum()
		{
			var typeName:String = getQualifiedClassName(this);
			var db:* = _enumDb;
			
			// discourage people new'ing up constants on their own instead
			// of using the class constants
			if (_enumDb[typeName] != null)
			{
				//throw new Error("Enum constants can only be constructed as static consts " + "in their own enum class " + "(bad type='" + typeName + "')");
			}
			
			if (_enumDb[typeName] == null)
			{
				// if opening up a new type, alloc an array for its constants
				var constants:Array = _pendingDb[typeName];
				if (constants == null)
					_pendingDb[typeName] = constants = [];
				
				// record
				_index = constants.length;
				constants.push(this);
			}
		}
		
		protected static function initEnum(i_type:Class):void
		{
			var typeName:String = getQualifiedClassName(i_type);
			
			// can't call initEnum twice on same type (likely copy-paste bug)
			if (_enumDb[typeName] != null)
			{
				//throw new Error("Can't initialize enum twice (type='" + typeName + "')");
			}
			
			if (_enumDb[typeName] == null)
			{
				// no constant is technically ok, but it's probably a copy-paste bug
				var constants:Array = _pendingDb[typeName];
				if (constants == null)
				{
					throw new Error("Can't have an enum without any constants (type='" + typeName + "')");
				}
			
				// process constants
				var type:XML = flash.utils.describeType(i_type);
				for each (var constant:XML in type.constant)
				{
					// this will fail to coerce if the type isn't inherited from Enum
					var enumConstant:Enum = i_type[constant.@name];
					
					// if the types don't match then probably have a copy-paste error.
					// this is really common so it's good to catch it here.
					var enumConstantType:* = Object(enumConstant).constructor;
					if (enumConstantType != i_type)
					{
						throw new Error("Constant type '" + enumConstantType + "' " + "does not match its enum class '" + i_type + "'");
					}
					
					enumConstant._name = constant.@name;
				}
				
				// now seal it
				_pendingDb[typeName] = null;
				_enumDb[typeName] = new EnumConstants(constants);
			}
		}
		
		public function writeExternal(outData:IDataOutput):void
		{
			outData.writeInt(_index);
		}
 
		public function readExternal(inData:IDataInput):void
		{
			_index = inData.readInt();
		}
		
		private var _name:String = null;
		private var _index:int = -1;
		
		private static var _pendingDb:Object = {}; // typename -> [constants]
		private static var _enumDb:Object = {}; // typename -> EnumConstants
	}
}

// private support class
class EnumConstants
{
	//AS3 won't find Enum if it isn't in the default package
	import classes.Enum;
	
	public function EnumConstants(i_byIndex:Array)
	{
		ByIndex = i_byIndex;
		
		for (var i:int = 0; i < ByIndex.length; ++i)
		{
			var enumConstant:Enum = ByIndex[i];
			ByName[enumConstant.Name.toLowerCase()] = enumConstant;
		}
	}
	
	public var ByIndex:Array;
	public var ByName:Object = {};
}
