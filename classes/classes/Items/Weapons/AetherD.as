/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.CoC;
import classes.ItemType;
import classes.StatusEffects;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Scenes.NPCs.AetherTwinsFollowers;
	
	public class AetherD extends Weapon {
		
		public function AetherD()
		{
			super("AetherD", "AetherD", "Aether (Dex)", "an Aether (Dex)", "punch", 0, 0, "Aether - dexter part of mysterious sentient weapons pair rumored to be forged by the god of blacksmiths.", WT_GAUNTLET, WSZ_MEDIUM);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (";
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") desc += "Dagger";
			else desc += "Gauntlet";
			desc += ")";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: 0";
			return desc;
		}
		
		override public function get verb():String {
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") return "stab";
			else return "punch";
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			boost += game.player.statusEffectv1(StatusEffects.AetherTwins1);
			return (0 + boost);
		}
		
		override public function get type():String {
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") return WT_DAGGER;
			else return WT_GAUNTLET;
		}
		
		override public function get size():int {
			if (AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dual Daggers" || AetherTwinsFollowers.AetherTwinsShape == "Human-tier Dagger and Shield") return WSZ_SMALL;
			else if (AetherTwinsFollowers.AetherTwinsShape == "Sky-tier Gaunlets") return WSZ_LARGE;
			else return WSZ_MEDIUM;
		}
		
		override public function useText():void {
			outputText("\n\n\"<i>Well alright then, [name]!</i>\" Aether (Dex) says excitedly, \"<i>Let's go!</i>\"\n\n");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 2;
			super.afterEquip(doOutput, slot);
		}
		
		override public function unequipText(slot:int):void {
			outputText("Aether (Dex) lies on the ground for a moment, \"<i>I will be waiting in the camp</i>\" she says before teleporting back to your camp.\n\n(<b>Aether (Dex) is now available in the followers tab!</b>)");
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			game.flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] = 1;
			super.afterUnequip(doOutput, slot);
		}
		
		override public function beforeUnequip(doOutput:Boolean, slot:int):ItemType {
			super.beforeUnequip(doOutput, slot);
			return WeaponLib.FISTS;
		}
	}
}
