package classes.Perks
{
import classes.CoC;
import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.*;

	public class Regeneration4Perk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			if (CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0 && CoC.instance.player.hunger < 25) return "<b>DISABLED</b> - You are too hungry!";
			else return super.desc(params);
		}
		
		public function Regeneration4Perk()
		{
			super("Regeneration IV", "Regeneration IV",
				"Regenerates an additional 1% of max HP per hour and 0.5% of max HP per round.",
				"You choose the 'Regeneration IV' perk, giving you an additional 0.5% of max HP per round in combat and 1% of max HP per hour.");
		}
		
	}

}
