/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

public class ArmageddonBlade extends Weapon	{
		
		public function ArmageddonBlade()
		{
			super("Armaged", "ArmageddonBlade", "Armageddon Blade", "an Armageddon Blade", "slash", 410, 65600, "Re-forged with Divine Power, the Armageddon Blade is the only weapon powerful enough to slay Lethice. Requires 500 strength to fully unleash its power.", WT_SWORD, WSZ_MASSIVE);
			withTags(W_MGWRATH, I_LEGENDARY, W_PURE_TYPE);
			withEffect(IELib.AttackBonus_Cor, -1/2)
			withEffect(IELib.ScaleAttack_StrXL, 500)
		}
	}
}
