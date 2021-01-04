package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

public class DarkenedKitsunePerk extends PerkType
	{
		override public function desc(params:PerkClass = null):String
		{
			return "The corruption has taken over your star sphere, driving you "+((player.cor >=90)?"completely insane":(player.cor >=75)?"rather unhinged":(player.cor >= 50)?"mildly paranoid":"")+". The higher the corruption, the higher the chance you may do an extra, randomly decided attack. Foes are also terrified of you, and do less damage.";
		}

		public function DarkenedKitsunePerk()
		{
			super("Darkened Kitsune","Darkened Kitsune", "The corruption you gained from your travels has taken hold of your star sphere, turning you insane. During battle, you may have an extra chance to deal damage while taking less from scared enemies.");
		}

	}
}