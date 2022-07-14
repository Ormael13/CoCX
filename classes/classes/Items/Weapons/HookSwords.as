/**
 * ...
 * @author Shamanknight
 */
package classes.Items.Weapons {
import classes.Items.Weapon;
import classes.PerkLib;

public class HookSwords extends Weapon {
	
	public function HookSwords() {
		super("HSwords", "HookSwords", "hook swords", "a pair of hook swords", "slashes", 20, 1600, "Dual swords with wrist guards and an outwards-facing \"hook\" on the sword tip, useful for parrying and disarming opponents.", "Dual", WT_SWORD);
		withPerk(PerkLib.DexterousSwordsmanship);
	}
	
	override public function canEquip(doOutput:Boolean):Boolean {
		if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput);
		if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
		return false;
	}
}
}
