/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class BlizzardClaws extends Weapon
	{
		
		public function BlizzardClaws() 
		{
			super("BClaws", "BlizzardClaws", "blizzard claws", "a pair of blizzard claws", "clawing punch", 0, 4000, "This pair of claws are made of pure ice. Instead of keeping warm the they cools and chills the body of whoever wears it, which might even prove lethal to someone not resilient to its insidious power. Yuki Onna being creatures of the cold they actually regenerate instead thanks to this effect.", WP_BLEED10, WT_GAUNTLET);
		}
		
		override public function equipText():void {
			if (!game.player.hasPerk(PerkLib.ColdAffinity)) outputText("Is it just you or your hands are freezing? Without proper resistance to cold, the blizzard claws begins to sap your body warmth.\n\n");
			else outputText("You equip " + longName + ".  ");
		}
		
	}

}