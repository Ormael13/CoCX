package classes.BodyParts 
{
	/**
	 * Container class for the players underbody
	 * @since December 31, 2016
	 * @author Stadler76
	 */
	public class UnderBody 
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = UNDER_BODY_TYPE_NONE;
		public var skin:Skin = new Skin();

		public function UnderBody() {}

		public function skinDescription(...args):String { return skin.description.apply(null, args); }
		public function skinFurScales(...args):String { return skin.skinFurScales.apply(null, args); }

		public function restore(keepTone:Boolean = true):void
		{
			type  = UNDER_BODY_TYPE_NONE;
			skin.restore(keepTone);
		}

		public function setProps(p:Object):void
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('skin')) skin.setProps(p.skin);
		}

		public function setAllProps(p:Object, keepTone:Boolean = true):void
		{
			restore(keepTone);
			setProps(p);
		}
	}
}
