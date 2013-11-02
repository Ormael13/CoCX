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
		   11 - Fox
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
					case 11:
						 return CockTypesEnum[FOX]
						 break;
					default:
						 return CockTypesEnum[HUMAN]
						 break;
				}

			}
			else if (cockType is String)
			{
				return ParseConstant(cockType);
					//return CockTypesEnum[cockType];
			}
			
			else
			{
				throw new Error("Invalid cock type!" + cockType);
				return CockTypesEnum[HUMAN];
			}
		}
		
		public static function legacySuportGetCockType(cockType:*):Number
		{
			if (cockType is CockTypesEnum)
			{
				switch (cockType)
				{
					case CockTypesEnum[HUMAN]:
						 return 0
						 break;
					case CockTypesEnum[HORSE]:
						 return 1
						 break;
					case CockTypesEnum[DOG]:
						 return 2
						 break;
					case CockTypesEnum[DEMON]:
						 return 3
						 break;
					case CockTypesEnum[TENTACLE]:
						 return 4
						 break;
					case CockTypesEnum[CAT]:
						 return 5
						 break;
					case CockTypesEnum[LIZARD]:
						 return 6
						 break;
					case CockTypesEnum[ANEMONE]:
						 return 7
						 break;
					case CockTypesEnum[KANGAROO]:
						 return 8
						 break;
					case CockTypesEnum[DRAGON]:
						 return 9
						 break;
					case CockTypesEnum[DISPLACER]:
						 return 10
						 break;
					case CockTypesEnum[FOX]:
						 return 11
						 break;
					default:
						 return 0
						 break;
				}
				
			}
			else if (cockType is String)
			{
				return legacySuportGetCockType(CockTypesEnum[cockType]);
			}
			
			else
			{
				throw new Error("Invalid cock type!" + cockType);
				return 0;
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
		public static const FOX:CockTypesEnum = new CockTypesEnum();
		
		public static function ParseConstant(i_constantName:String, i_caseSensitive:Boolean = false):CockTypesEnum
		{
			return CockTypesEnum(Enum.ParseConstant(CockTypesEnum, i_constantName, i_caseSensitive));
		}
	}
}