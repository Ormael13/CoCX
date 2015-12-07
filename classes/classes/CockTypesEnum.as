package classes
{
	import classes.Enum;
	
	public class CockTypesEnum extends Enum
	{
		{initEnum(CockTypesEnum);}
		
		/* Cock types
		 * 0 - human
		 * 1 - horse
		 * 2 - dog
		 * 3 - demon
		 * 4 - tentacle?
		 * 5 - CAT
		 * 6 - Lizard/Naga?
		 * 7 - ANEMONE!
		 * 8 - ugliest wang ever (kangaroo)
		 * 9 - dragon
		 * 10 - displacer
		 * 11 - Fox	
		
		 Group Types used for general description code (eventually)
		 * human  	- obvious
		 * mammal 	- obvious again
		 * super 	- supernatural types
		 * tentacle - only one tentacle!
		 * reptile	- make a guess
		 * seaworld - Anything in the water
		 * other	- doesn't fit anywhere else
		 */
		public static const HUMAN:CockTypesEnum = new CockTypesEnum("human");
		public static const HORSE:CockTypesEnum = new CockTypesEnum("mammal");
		public static const DOG:CockTypesEnum = new CockTypesEnum("mammal");
		public static const DEMON:CockTypesEnum = new CockTypesEnum("super");
		public static const TENTACLE:CockTypesEnum = new CockTypesEnum("tentacle");
		public static const CAT:CockTypesEnum = new CockTypesEnum("mammal");
		public static const LIZARD:CockTypesEnum = new CockTypesEnum("reptile");
		public static const ANEMONE:CockTypesEnum = new CockTypesEnum("seaworld");
		public static const KANGAROO:CockTypesEnum = new CockTypesEnum("mammal");
		public static const DRAGON:CockTypesEnum = new CockTypesEnum("reptile");
		public static const DISPLACER:CockTypesEnum = new CockTypesEnum("other");
		public static const FOX:CockTypesEnum = new CockTypesEnum("mammal");
		public static const BEE:CockTypesEnum = new CockTypesEnum("insect");
		public static const PIG:CockTypesEnum = new CockTypesEnum("mammal");
		public static const AVIAN:CockTypesEnum = new CockTypesEnum("avian");
		public static const RHINO:CockTypesEnum = new CockTypesEnum("mammal");
		public static const ECHIDNA:CockTypesEnum = new CockTypesEnum("mammal");
		public static const UNDEFINED:CockTypesEnum = new CockTypesEnum("");
		
		function CockTypesEnum(i_group:String = "") { _group = i_group; }
		private var _group:String;
		
		public function get Group():String 
		{
			return _group;
		}
		
		public static function ParseConstant(i_constantName:String, i_caseSensitive:Boolean = false):CockTypesEnum
		{
			return CockTypesEnum(Enum.ParseConstant(CockTypesEnum, i_constantName, i_caseSensitive));
		}
		
		public static function ParseConstantByIndex(i_constantIndex:int = 0):CockTypesEnum
		{
			return CockTypesEnum(Enum.ParseConstantByIndex(CockTypesEnum, i_constantIndex));
		}
		
	}
}