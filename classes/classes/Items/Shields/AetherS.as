/**
 * ...
 * @author Ormael
 */
package classes.Items.Shields
{
import classes.ItemType;
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Scenes.NPCs.AetherTwinsFollowers;

	public class AetherS extends Shield {
		
		public function AetherS()
		{
			super("AetherS", "AetherS", "Aether (Sin)", "an Aether (Sin)", 0, 0, "Aether - sinister part of a mysterious sentient weapon pair rumored to be forged by the god of blacksmiths.");
		}
		
		override public function get block():Number {
			var boost:int = 0;
			boost += game.player.statusEffectv2(StatusEffects.AetherTwins1);
			return (0 + boost);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (";
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers") desc += "Dagger";
			else if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") desc += "Small Shield";
			else desc += "Gauntlet";
			desc += ")";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: 0";
			return desc;
		}
		
		override public function equipText():void {
			outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Sin) says excitedly, \"<i>Let's go!</i>\"\n\n");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				game.flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 2;
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function unequipText(slot:int):void {
			outputText("Aether (Sin) lays on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Sin) is now available in the followers tab!</b>)");
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			game.flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] = 1;
			super.afterUnequip(doOutput, slot);
		}
		
		override public function beforeUnequip(doOutput:Boolean, slot:int):ItemType {
			return ShieldLib.NOTHING;
		}
	}
}
