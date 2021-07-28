/**
 * ...
 * @author Zevos
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class SagesSketchbook extends WeaponRange
	{
		
		public function SagesSketchbook() 
		{
			super("SSketch", "S.Sketchbook", "Sage’s Sketchbook", "a Sage’s Sketchbook", "nothing", 0, 500, "Strangely, this ornate blue book is completely blank.  Yet, as you flip through it, you occasionally see magical glyphs and complicated diagrams out of the corner of your eye, only to disappear as you focus.  Still, the arcane energies within the book could augment your spellcraft.", "Tome");
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
			desc += "\nSpecial: Sage's Knowledge (+60% Spell Power)";
			return desc;
		}
		
		override public function playerEquip():WeaponRange {
			while (game.player.hasPerk(PerkLib.SagesKnowledge)) game.player.removePerk(PerkLib.SagesKnowledge);
			game.player.createPerk(PerkLib.SagesKnowledge,0.6,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():WeaponRange {
			while (game.player.hasPerk(PerkLib.SagesKnowledge)) game.player.removePerk(PerkLib.SagesKnowledge);
			return super.playerRemove();
		}
	}
}