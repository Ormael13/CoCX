package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Scenes.SceneLib;
import classes.PerkLib;

public class ScarredBlade extends Weapon
	{
		
		public function ScarredBlade()
		{
			super("ScarBld", "ScarBlade", "scarred blade", "a scarred blade", "slash", 10, 800, "This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with the corrupt.", "", "Sword");
		}
		
		override public function get attack():Number {
			var temp:int = 10 + int((game.player.cor - 70) / 3);
			if (temp < 10) temp = 10;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) temp = 20;
			return temp;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.cor >= (66 - game.player.corruptionTolerance)) return super.canEquip(doOutput);
			if (doOutput) SceneLib.sheilaScene.rebellingScarredBlade(true);
			return false;
		}
	}
}
