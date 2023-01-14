/**
 * ...
 * @author Stadler76
 */
package classes.Scenes.Areas.HighMountains 
{
import classes.StatusEffects;
import classes.BodyParts.Wings;

public class WingedCockatrice extends Cockatrice
	{
		public function WingedCockatrice() 
		{
			super();
			initStrTouSpeInte(235, 220, 255, 86);
			initWisLibSensCor(76, 85, 50, 20);
			this.weaponAttack = 80;
			this.armorDef = 120;
			this.armorMDef = 60;
			this.bonusHP = 2500;
			this.bonusLust = 219;
			this.level = 84;
			this.gems = rand(20) + 230;
			this.createStatusEffect(StatusEffects.Flying,50,0,0,0);
			wings.type = Wings.FEATHERED_LARGE;
			this.dynStats("spe", 10);
			this.short = "winged cockatrice";
			this.imageName = "cockatricewithwings";
		}
	}
}
