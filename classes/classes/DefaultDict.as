


package classes
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.Dictionary
	

	// This is a special class that immitates a array/dictionary, and 
	// yet has some special behaviour to make it look & act like any arbitrary aray value 
	// is pre-initialized to 0. 
	public dynamic class DefaultDict extends Proxy 
	{
		// Actual key<->value pairs are stored in _dict
		private var _dict:Object;

		// Set to true to print any access to defaultDict members
		private var debugPrintDict:Boolean = false;		

		public function DefaultDict()		// Constructor
		{
			_dict = new Object();
			if (debugPrintDict) trace("Instantiating default dict class");
		}

		// used to determine status of the query 'name in defaultDict'. 
		// Since we want to *look* like have any arbitrary key, we always return true.
		override flash_proxy function hasProperty(name:*):Boolean
		{
			if (debugPrintDict) trace("hasProperty", name);
			return true;
		}

		// called when someone requests defaultDict[name] or defaultDict.name
		// we have a special case to override the query for defaultDict.length, since
		// that is used for determining how many flags the save/load mechanism iterates over.
		// I'm going to update that to properly iterating over each item in the save eventually
		// but this makes it work as a stop-gap measure
		override flash_proxy function getProperty(name:*):*
		{
			if (debugPrintDict) trace("getProperty Called");
			if (name == "length")
			{
				if (debugPrintDict) trace("Querying array length. Faking out retVal");
				return 3000;
			}

			// If we have name as a key in _dict, return _dict[name]. Else, return 0
			if (name in _dict)
			{
				if (debugPrintDict) trace("Flag " + name + " being accessed. Value = " + _dict[name]);
				return _dict[name];
			}
			else
			{
				if (debugPrintDict) trace("Unset Flag " + name + " being accessed.");
				return 0;
			}
		}

		// Overrides any attempt to set a class member or indice (defaultDict[name] = x or defaultDict.name = x)
		// If x == 0, it removes {name} from _dict if it's present, otherwise does nothing. Else, it sets _dict[name] = x
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			if (value != 0)
			{
				if (debugPrintDict) trace("setProperty ", name, value);
				_dict[name] = value;
			}
			else
				if (name in _dict)
				{
					if (debugPrintDict) trace("setProperty " + name + " to " + value + " Deleting key");
					delete _dict[name];
				}
				else
					if (debugPrintDict) trace("setProperty " + name + " to " + value + " Ignoring");
		}
	
		// callProperly is called when functions are called on instances of defaultDict, 
		// e.g. defaultDict.push(), etc...
		// Since we don't have an array length, per se, we just swallow instances of push.
		// otherwise, we just apply the called function name to _dict.
		override flash_proxy function callProperty(methodName:*, ... args):* 
		{
			if (debugPrintDict) trace("call Property ", methodName);
			if (String(methodName) == "push")
			{
				if (debugPrintDict) trace("Doing nothing (this ain't an array anymore!)");
			}
			else
			{
				var res:*;
				res = _dict[methodName].apply(_dict, args);
				return res;
			}
		}


		// you have to implement object management bits yourself, since unfortunately the proxy
		// object doesn't have default stuff you can just override where you want special behaviour
		// As such, the following functions just make defaultDict iterable, and manage removing 
		// things, etc...

		//public function getIteratorObj():IIterator
		//{
		//	return IIterator(_dict);
		//
		//}

		override flash_proxy function deleteProperty(name:*):Boolean 
		{
			if (debugPrintDict) trace("deleteProperty", name);
			return delete _dict[name];
		}


		override flash_proxy function nextName(index:int):String 
		{
			if (debugPrintDict) trace("nextName", index);
			return String(index - 1);
		}

		override flash_proxy function nextValue(index:int):* 
		{
			if (debugPrintDict) trace("nextValue", index);
			return _dict[index - 1];
		}

		override flash_proxy function nextNameIndex(index:int):int 
		{

			if (debugPrintDict) trace("nextNameIndex ", index);
			if (!(index in _dict))
			{
				if (debugPrintDict) trace("Returning 0");
				return 0;
			}
			return index + 1;
		}


	}
}