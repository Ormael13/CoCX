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
			initStrTouSpeInte(635, 720, 755, 306);
			initWisLibSensCor(276, 415, 380, -40);
			this.weaponAttack = 480;
			this.armorDef = 1200;
			this.armorMDef = 600;
			this.bonusHP = 10000;
			this.bonusLust = 889;
			this.level = 94;
			this.gems = rand(20) + 230;
			this.createStatusEffect(StatusEffects.Flying,50,0,0,0);
			wings.type = Wings.FEATHERED_LARGE;
			this.dynStats("spe", 10);
			this.short = "winged cockatrice";
			this.imageName = "cockatricewithwings";
		}
	}
}
