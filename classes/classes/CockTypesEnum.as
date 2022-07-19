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
		public static const HUMAN:CockTypesEnum = new CockTypesEnum("human","human");
		public static const HORSE:CockTypesEnum = new CockTypesEnum("horse","mammal");
		public static const KIRIN:CockTypesEnum = new CockTypesEnum("kirin","mammal");
		public static const DOG:CockTypesEnum = new CockTypesEnum("dog","mammal");
		public static const DEMON:CockTypesEnum = new CockTypesEnum("demon","super");
		public static const TENTACLE:CockTypesEnum = new CockTypesEnum("tentacle","tentacle");
		public static const SCYLLATENTACLE:CockTypesEnum = new CockTypesEnum("scylla tentacle","tentacle");
		public static const CAT:CockTypesEnum = new CockTypesEnum("cat","mammal");
		public static const CANCER:CockTypesEnum = new CockTypesEnum("cancer","foaming human");
		public static const LIZARD:CockTypesEnum = new CockTypesEnum("lizard","reptile");
		public static const CAVE_WYRM:CockTypesEnum = new CockTypesEnum("cave wyrm","reptile");
		public static const ANEMONE:CockTypesEnum = new CockTypesEnum("anemone","seaworld");
		public static const KANGAROO:CockTypesEnum = new CockTypesEnum("kangaroo","mammal");
		public static const DRAGON:CockTypesEnum = new CockTypesEnum("dragon","reptile");
		public static const DISPLACER:CockTypesEnum = new CockTypesEnum("displacer","other");
		public static const FOX:CockTypesEnum = new CockTypesEnum("fox","mammal");
		public static const BEE:CockTypesEnum = new CockTypesEnum("bee","insect");
		public static const PIG:CockTypesEnum = new CockTypesEnum("pig","mammal");
		public static const AVIAN:CockTypesEnum = new CockTypesEnum("avian","avian");
		public static const RHINO:CockTypesEnum = new CockTypesEnum("rhino","mammal");
		public static const ECHIDNA:CockTypesEnum = new CockTypesEnum("echidna","mammal");
		public static const WOLF:CockTypesEnum = new CockTypesEnum("wolf","mammal");
		public static const STAMEN:CockTypesEnum = new CockTypesEnum("stamen","plant");
		public static const RED_PANDA:CockTypesEnum = new CockTypesEnum("red panda","mammal");
		public static const GRYPHON:CockTypesEnum = new CockTypesEnum("gryphon","avian");
		public static const OOMUKADE:CockTypesEnum = new CockTypesEnum("oomukade","venomous");
		public static const MINDBREAKER:CockTypesEnum = new CockTypesEnum("mindbreaker","eldritch");
		public static const RAIJU:CockTypesEnum = new CockTypesEnum("raiju","mammal");
		public static const USHI_ONI:CockTypesEnum = new CockTypesEnum("ushi-oni","other");
		public static const INSECT:CockTypesEnum = new CockTypesEnum("insect","insect");
		public static const UNDEFINED:CockTypesEnum = new CockTypesEnum("undefined","");
		
		function CockTypesEnum(
				i_displayName:String="",
				i_group:String=""
		) {
			_displayName = i_displayName;
			_group = i_group;
		}
		private var _group:String;
		private var _displayName:String;
		
		public function get Group():String
		{
			return _group;
		}
		public function get DisplayName():String
		{
			return _displayName;
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
