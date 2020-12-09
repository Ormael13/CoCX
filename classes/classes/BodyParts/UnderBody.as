package classes.BodyParts 
{
import classes.Creature;

/**
	 * Container class for the players underbody
	 * @since December 31, 2016
	 * @author Stadler76
	 */
	public class UnderBody extends BodyPart
	{

        public var skin:Skin;

		public function UnderBody(creature:Creature)
		{
			super(creature,[]);
			this.skin = new Skin(creature);
			addPublicJsonables(["skin"]);
		}

		public function skinFurScales(...args):String { return skin.skinFurScales.apply(null, args); }

		public function copySkin(p:Object = null):void
		{
			skin.setProps(creature.skin);
			if (p != null) skin.setProps(p);
		}

		override public function restore(keepTone:Boolean = true):void
		{
			super.restore(keepTone);
			skin.restore(keepTone);
		}

	}
}