/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	import classes.GlobalFlags.kFLAGS;
	
	public class AetherD extends Weapon {
		
		public function AetherD() 
		{
			super("AetherD", "AetherD", "Aether (Dex)", "an Aether (Dex)", "punch", 0, 0, "Aether - dexter part of mysterious sentient weapons pair rumored to be forged by the god of blacksmiths.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			//boost += 2;
			return boost; 
		}
		
		override public function useText():void {
			outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Dex) says excitedly, \"<i>Let's go!</i>\"\n\n");
		}
		override public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc.
			game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 2;
			return super.playerEquip();
		}
		
		override public function removeText():void { //Produces any text seen when removing the armor normally
			outputText("Aether (Dex) lays on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Dex) is now available in the followers tab!</b>)");
		}
		override public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc.
			game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
			return null; //Can't put Aether (Dex) in your inventory
		}
	}
}