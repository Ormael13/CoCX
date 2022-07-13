/**
 * ...
 * @author Ormael
 */
package classes.Items.Shields
{
import classes.ItemType;
import classes.Items.Shield;
	import classes.GlobalFlags.kFLAGS;
import classes.Items.ShieldLib;
import classes.StatusEffects;

	public class AetherS extends Shield {
		
		public function AetherS()
		{
			super("AetherS", "AetherS", "Aether (Sin)", "an Aether (Sin)", 0, 0, "Aether - sinister part of mysterious sentient weapons pair rumored to be forged by the god of blacksmiths.");
		}
		
		override public function get block():Number {
			var boost:int = 0;
			boost += game.player.statusEffectv2(StatusEffects.AetherTwins1);
			return (0 + boost);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (Gauntlet)";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: 0";
			return desc;
		}
		
		override public function equipText():void {
			outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Sin) says excitedly, \"<i>Let's go!</i>\"\n\n");
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 2;
			}
			super.afterEquip(doOutput);
		}
		
		override public function unequipText():void {
			outputText("Aether (Sin) lays on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Sin) is now available in the followers tab!</b>)");
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
			super.afterUnequip(doOutput);
		}
		
		override public function beforeUnequip(doOutput:Boolean):ItemType {
			return ShieldLib.NOTHING;
		}
	}
}
