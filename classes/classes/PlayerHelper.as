package classes
{
	import classes.GlobalFlags.kFLAGS;

	/**
	 * This contains some of the helper methods for the player-object I've written
	 * @since June 29, 2016
	 * @author Stadler76
	 */
	public class PlayerHelper extends Character 
	{
		public function PlayerHelper() {}
		
		public function hasScales():Boolean
		{
			return [SKIN_TYPE_SCALES, SKIN_TYPE_DRACONIC].indexOf(skinType) != -1;
		}

		public function hasFurOrScales():Boolean
		{
			return skinType == SKIN_TYPE_FUR || hasScales();
		}

		public function hasDragonHorns():Boolean
		{
			return (horns > 0 && hornType == HORNS_DRACONIC_X2) || hornType == HORNS_DRACONIC_X4_12_INCH_LONG;
		}

		public function hasReptileEyes():Boolean
		{
			return [EYES_LIZARD, EYES_DRAGON, EYES_BASILISK].indexOf(eyeType) != -1;
		}

		public function hasLizardEyes():Boolean
		{
			return [EYES_LIZARD, EYES_BASILISK].indexOf(eyeType) != -1;
		}

		public function hasReptileFace():Boolean
		{
			return [FACE_SNAKE_FANGS, FACE_LIZARD, FACE_DRAGON].indexOf(faceType) != -1;
		}

		public function hasDragonWings(large:Boolean = false):Boolean
		{
			if (large)
				return wingType == WING_TYPE_DRACONIC_LARGE;
			else
				return [WING_TYPE_DRACONIC_SMALL, WING_TYPE_DRACONIC_LARGE].indexOf(wingType) != -1;
		}

		public function hasBatLikeWings(large:Boolean = false):Boolean
		{
			if (large)
				return wingType == WING_TYPE_BAT_LIKE_LARGE;
			else
				return [WING_TYPE_BAT_LIKE_TINY, WING_TYPE_BAT_LIKE_LARGE].indexOf(wingType) != -1;
		}

		public function hasLeatheryWings(large:Boolean = false):Boolean
		{
			return hasDragonWings(large) || hasBatLikeWings(large);
		}

		// To be honest: I seriously considered naming it drDragonCox() :D
		public function dragonCocks():int
		{
			return countCocksOfType(CockTypesEnum.DRAGON);
		}

		public function lizardCocks():int
		{
			return countCocksOfType(CockTypesEnum.LIZARD);
		}

		public function hasDragonfire():Boolean
		{
			return findPerk(PerkLib.Dragonfire) >= 0;
		}

		public function hasDragonWingsAndFire(largeWings:Boolean = true):Boolean
		{
			return hasDragonWings(largeWings) && hasDragonfire();
		}

		public function isBasilisk():Boolean
		{
			return game.bazaar.benoit.benoitBigFamily() && eyeType == EYES_BASILISK;
		}

		public function featheryHairPinEquipped():Boolean
		{
			return hasKeyItem("Feathery hair-pin") >= 0 && keyItemv1("Feathery hair-pin") == 1;
		}
	}
}
