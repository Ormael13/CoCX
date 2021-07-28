/**
 * ...
 * @author Zevos
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class InquisitorsTome extends WeaponRange
	{
		
		public function InquisitorsTome() 
		{
			super("I. Tome", "I. Tome", "Inquisitor’s Tome", "an Inquisitor's Tome", "nothing", 0, 2000, "This red tome is filled with forbidden knowledge, concealed within a detailed treatise on the demon war. The magic within this tome allows you to cast spells using your health after you become too low on mana to cast spells normally.", "Tome");
		}
		
		override public function useText():void {
			outputText("You unclasp the lock and begin to leaf through the tome you found in the swamp cave. This tome tells the story of the rise of the demons, from a surprisingly prudish standpoint.  The author took painstaking care to relay the strategic capabilities and tactics of the demons yet dismisses the sexual aspects of their conquest with the occasional brief nod. Concealed within the pages are the ciphers you’ve noticed earlier, guarding forbidden knowledge. ");
			if (game.player.hasPerk(PerkLib.JobSorcerer)) outputText("Beyond the words... you feel power in the pages, the ink and the binding. ");
			outputText("You reclasp the tome, and hang it ");
			if (game.player.armorName == "nothing") outputText("from your shoulder");
			else outputText("from your belt");
			outputText(". You feel holy.\n\n(<b>Perk Gained - Last Resort</b>: When mana is too low to cast a spell, automatically cast from hp instead.)\n\n");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Tome";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Last Resort (enable to using hp for spellcasting when mana is too low)";
			return desc;
		}
		
		override public function playerEquip():WeaponRange {
			while (game.player.hasPerk(PerkLib.LastResort)) game.player.removePerk(PerkLib.LastResort);
			game.player.createPerk(PerkLib.LastResort,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():WeaponRange {
			while (game.player.hasPerk(PerkLib.LastResort)) game.player.removePerk(PerkLib.LastResort);
			return super.playerRemove();
		}
	}
}