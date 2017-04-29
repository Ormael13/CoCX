package classes.BodyParts 
{
import classes.Creature;
import classes.internals.SimpleJsonable;

/**
	 * Container class for the players underbody
	 * @since December 31, 2016
	 * @author Stadler76
	 */
	public class UnderBody extends BodyPart
	{
		include "../../../includes/appearanceDefs.as";

		public var skin:Skin;

		public function UnderBody(creature:Creature)
		{
			super(creature);
			this.skin = new Skin(creature);
			addPublicJsonable(skin);
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
