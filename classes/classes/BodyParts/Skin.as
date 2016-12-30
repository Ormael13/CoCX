package classes.BodyParts 
{
	import classes.Creature;

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

		private var _creature:Creature;

		private var _furColor:String = "no";
		public function get furColor():String { return _creature.hasFur() ? _furColor : _creature.hairColor; }
		public function get newFurColor():String { return _furColor; } // alternative getter for the furColor. Ignores the skinType (Stadler76)
		public function set furColor(value:String):void { _furColor = value; }

		public function Skin(i_creature:Creature)
		{
			_creature = i_creature;
		}

		public function skinFurScales():String
		{
			var skinzilla:String = "";
			//Adjectives first!
			if (adj != "")
				skinzilla += adj + ", ";

			//Fur handled a little differently since it uses haircolor
			skinzilla += _creature.hasFur() ? furColor : tone;

			return skinzilla + " " + desc;
		}

		public function skinDescript(noAdj:Boolean = false, noTone:Boolean = false):String
		{
			var skinzilla:String = "";

			//Adjectives first!
			if (!noAdj && adj != "" && !noTone && tone != "rough gray")
				skinzilla += adj + ", ";
			if (!noTone)
				skinzilla += tone + " ";

			//Fur handled a little differently since it uses haircolor
			skinzilla += _creature.hasFur() ? "skin" : desc;

			return skinzilla;
		}

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
