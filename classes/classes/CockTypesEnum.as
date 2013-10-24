package classes
{
	import classes.Enum;
	
	public class CockTypesEnum extends Enum
	{
		{initEnum(CockTypesEnum);}
		
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
		public static function legacySuportLoadCockType(cockType:*):CockTypesEnum
		{
			if (cockType is int)
			{
				switch (cockType)
				{
					case 0:
						 return CockTypesEnum[HUMAN]
						 break;
					case 1:
						 return CockTypesEnum[HORSE]
						 break;
					case 2:
						 return CockTypesEnum[DOG]
						 break;
					case 3:
						 return CockTypesEnum[DEMON]
						 break;
					case 4:
						 return CockTypesEnum[TENTACLE]
						 break;
					case 5:
						 return CockTypesEnum[CAT]
						 break;
					case 6:
						 return CockTypesEnum[LIZARD]
						 break;
					case 7:
						 return CockTypesEnum[ANEMONE]
						 break;
					case 8:
						 return CockTypesEnum[KANGAROO]
						 break;
					case 9:
						 return CockTypesEnum[DRAGON]
						 break;
					case 10:
						 return CockTypesEnum[DISPLACER]
						 break;
					default:
						 return CockTypesEnum[HUMAN]
						 break;
				}

			}
			else if (cockType is String)
			{
				return CockTypesEnum[cockType];
			}

			else
			{
				throw new Error("Invalid cock type!" + cockType); 
				return CockTypesEnum[HUMAN];
			}
		}

		public static const HUMAN:CockTypesEnum = new CockTypesEnum();
		public static const HORSE:CockTypesEnum = new CockTypesEnum();
		public static const DOG:CockTypesEnum = new CockTypesEnum();
		public static const DEMON:CockTypesEnum = new CockTypesEnum();
		public static const TENTACLE:CockTypesEnum = new CockTypesEnum();
		public static const CAT:CockTypesEnum = new CockTypesEnum();
		public static const LIZARD:CockTypesEnum = new CockTypesEnum();
		public static const ANEMONE:CockTypesEnum = new CockTypesEnum();
		public static const KANGAROO:CockTypesEnum = new CockTypesEnum();
		public static const DRAGON:CockTypesEnum = new CockTypesEnum();
		public static const DISPLACER:CockTypesEnum = new CockTypesEnum();
	}
}