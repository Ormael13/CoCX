package
{
	import Enum;
	
	public class CockTypesEnum extends Enum
	{
		{initEnum(CocksEnum);}
		
		/*Cock types
		   0 - human
		   1 - horse
		   2 - dog
		   3 - demon
		   4 - tentacle?
		   5 - CAT
		   6 - Lizard/Naga?
		   7 - ANEMONE!
		   8 - ugliest wang ever (kangaroo)
		   9 - dragon
		   10 - displacer
		 */
		public static const HUMAN:CocksEnum = new CocksEnum();
		public static const HORSE:CocksEnum = new CocksEnum();
		public static const DOG:CocksEnum = new CocksEnum();
		public static const DEMON:CocksEnum = new CocksEnum();
		public static const TENTACLE:CocksEnum = new CocksEnum();
		public static const CAT:CocksEnum = new CocksEnum();
		public static const LIZARD:CocksEnum = new CocksEnum();
		public static const ANEMONE:CocksEnum = new CocksEnum();
		public static const KANGAROO:CocksEnum = new CocksEnum();
		public static const DRAGON:CocksEnum = new CocksEnum();
		public static const DISPLACER:CocksEnum = new CocksEnum();
	}
}