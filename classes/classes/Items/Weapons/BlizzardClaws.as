/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class BlizzardClaws extends Weapon
	{
		
		public function BlizzardClaws()
		{
			super("BClaws", "BlizzardClaws", "blizzard claws", "a pair of blizzard claws", "clawing punch", 0, 4000, "This pair of claws are made of pure ice. Instead of keeping warm the they cools and chills the body of whoever wears it, which might even prove lethal to someone not resilient to its insidious power. Yuki Onna being creatures of the cold they actually regenerate instead thanks to this effect.", WT_GAUNTLET, WSZ_MEDIUM);
			withTags(W_ICE_TYPE);
			withEffect(IELib.Bleed, 10);
		}
		
		override public function getItemText(textid:String):String {
			if (textid == "onequip" && !game.player.hasPerk(PerkLib.ColdMastery) && !game.player.hasPerk(PerkLib.ColdAffinity)) {
				return "Is it just you or your hands are freezing? Without proper resistance to cold, the blizzard claws begins to sap your body warmth.\n\n";
			}
			return super.getItemText(textid);
		}
	}

}
