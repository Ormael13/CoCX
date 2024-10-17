package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;
import classes.Scenes.SceneLib;

public class ScarredBlade extends Weapon
	{
		
		public function ScarredBlade()
		{
			super("ScarBld", "ScarBlade", "scarred blade", "a scarred blade", "slash", 10, 800, "This saber, made from lethicite-imbued metal, eagerly seeks flesh. It resonates with disdain, delivering deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with those who are corrupt.", WT_SWORD, WSZ_MEDIUM);
			withEffect(IELib.Require_Cor, 66);
			withEffect(IELib.AttackBonus_Cor, 1/3);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.cor >= (66 - game.player.corruptionTolerance)) return super.canEquip(doOutput, slot);
			if (doOutput) SceneLib.sheilaScene.rebellingScarredBlade(true);
			return false;
		}
		
	}
}
