/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.PerkLib;
	
	public class GoblinTechnomancerClothes extends Armor
	{
		
		public function GoblinTechnomancerClothes() 
		{
			super("GTechC", "GTechC", "Goblin Technomancer clothes", "a Goblin Technomancer clothes", 0, 0, 400, "These goblin technomancer clothes increase the effectiveness of all technology attacks. Too small for anyone but a goblin to wear. It features a pair of latex pants with a large opening at the right level in order to display whatever panties you may have on, if any at all. Along with the pants are two black latex shoes, black latex gloves, and a mechanist’s latex overcoat of matching color, generally kept open for a practical display of the user’s… assets. Oil, shock and stain proof. These garbs also improve your skill at using technology.", "Light");
		}
		
		override public function canUse():Boolean{
			if (game.player.tallness < 48){return true}
			outputText("There is no way this tiny set of clothing would fit your current size.");
			return false;
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: ";
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0) {
				desc += "Armor ";
				if (perk == "Light" || perk == "Medium") {
					desc += "(Light)";
				}
				else if (perk == "Medium") desc += "(Medium)";
				else desc += "(Heavy)";
			}
			else desc += "Clothing ";
			//Defense
			if (def > 0) desc += "\nDefense (P): " + String(def);
			if (mdef > 0) desc += "\nDefense (M): " + String(mdef);
			//Value
			if (value != 0) desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Slutty Seduction (Magnitude: 10)";
			return desc;
		}
		
		override public function playerEquip():Armor {
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,10,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor {
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}
		
	}

}