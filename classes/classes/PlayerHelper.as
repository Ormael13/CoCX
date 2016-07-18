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
	}
}
