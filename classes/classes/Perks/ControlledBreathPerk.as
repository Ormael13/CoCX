package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;

	public class ControlledBreathPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			if (CoC.instance.player.cor >= (30 + CoC.instance.player.corruptionTolerance)) return "<b>DISABLED</b> - Corruption too high!";
			else return super.desc(params);
		}

		public function ControlledBreathPerk()
		{
			super("Controlled Breath", "Controlled Breath", "Jojo’s training allows you to recover more quickly. Increases rate of fatigue / mana / soulforce regeneration by 20%");
		}
	}
}
