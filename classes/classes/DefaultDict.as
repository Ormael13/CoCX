package classes
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.Dictionary


	public dynamic class DefaultDict extends Proxy 
	{
		private var items:Dictionary;

		public function DefaultDict()
		{
			items = new Dictionary();
			trace("Instantiating default dict class");
		}

		override flash_proxy function hasProperty(name:*):Boolean
		{
			trace("hasProperty", name);
			return true;
			return name in items;
		}

		override flash_proxy function getProperty(name:*):*
		{
			if (name == "length")
			{
				trace("Querying array length. Faking out retVal");
				return 3000
			}
			if (name in items)
			{

			trace("Flag " + name + " being accessed. Value = " + items[name]);
				return items[name];
			}
			else
			{
				trace("Unset Flag " + name + " being accessed.");
				return 0;
			}
		}

		override flash_proxy function setProperty(name:*, value:*):void 
		{
			if (value != 0)
			{
				trace("setProperty", name, value);
				items[name] = value;
			}
			else
				trace("setProperty" + name + " to " + value + " Ignoring");
		}
	
		override flash_proxy function deleteProperty(name:*):Boolean 
		{
			trace("deleteProperty", name);
			return delete items[name];
		}


		override flash_proxy function nextNameIndex(index:int):int 
		{

			trace("nextNameIndex", index);
			if (index > items.length)
				return 0;
			return index + 1;
		}

		override flash_proxy function nextName(index:int):String 
		{
			trace("nextName", index);
			return String(index - 1);
		}

		override flash_proxy function nextValue(index:int):* 
		{
			trace("nextValue", index);
			return items[index - 1];
		}

		override flash_proxy function callProperty(methodName:*, ... args):* 
		{
			trace("call Property ", methodName);
			if (String(methodName) == "push")
				trace("Doing nothing (this ain't an array anymore!)");
			else
			{
				var res:*;
				res = items[methodName].apply(items, args);
				return res;
			}
		}


	}
}