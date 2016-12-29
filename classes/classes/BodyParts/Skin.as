package classes.BodyParts 
{
	/**
	 * Container class for the players skin
	 * @since December 27, 2016
	 * @author Stadler76
	 */
	public class Skin 
	{
		include "../../../includes/appearanceDefs.as";

		public var type:Number = SKIN_TYPE_PLAIN;
		public var tone:String = "albino";
		public var desc:String = "skin";
		public var adj:String = "";

		public function Skin() {}

		public function restore(keepTone:Boolean = true):Skin
		{
			type = SKIN_TYPE_PLAIN;
			if (!keepTone) tone = "albino";
			desc = "skin";
			adj  = "";

			return this;
		}

		public function setProps(p:Object):Skin
		{
			if (p.hasOwnProperty('type')) type = p.type;
			if (p.hasOwnProperty('tone')) tone = p.tone;
			if (p.hasOwnProperty('desc')) desc = p.desc;
			if (p.hasOwnProperty('adj'))  adj  = p.adj;

			return this;
		}

		public function setAllProps(p:Object, keepTone:Boolean = true):Skin
		{
			restore(keepTone);
			setProps(p);
			return this;
		}
	}
}
