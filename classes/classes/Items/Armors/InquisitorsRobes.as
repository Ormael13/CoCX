/**
 * Created by aimozg on 15.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.PerkLib;
	import classes.Player;

	public final class InquisitorsRobes extends ArmorWithPerk {
		
		public function InquisitorsRobes() {
			super("I.Robes", "I.Robes", "inquisitor's robes", "inquisitor's robes", 8, 2000, "These foreboding red and gold robes are embroidered with the symbols of a lost kingdom.  Wearing them will cause spells to tax your health instead of exhausting you.", "Light", PerkLib.BloodMage, 0, 0, 0, 0);
		}
		
		override public function useText():void {
			outputText("You unfold the robes you received from the secret chamber in the swamp and inspect them.  They have not changed since the last time you saw them - perhaps the transformative magic promised in the letter has been exhausted.  Looking at the two separate parts to the outfit, it becomes clear that the mantle is constructed of a thicker fabric and is intended to be the primary protection of the outfit - what protection a robe can provide, at least.  The undershirt is made of a much lighter material, and you dare say that it could prove quite a classy number on its own.  You strip naked and then slip into the robe.\n\n");
			
			outputText("The degree to which it fits you is moderately surprising.  For lack of a better word, it seems to be perfect.  The fabric does not cling to you, but gives you a full range of movement.  There is a clasp over the high collar, displaying a golden sword.  Though your arms are bare the holes through which your arms extend are comfortable, and have the same golden trim as the collar.  Along the middle of the robe the trim gathers around the waist, descending down the skirt in two lines.  As it reaches the bottom it explodes into elaborate embroidery circling around the back, patterning based on holy symbols and iconography that may have meant something long ago before the advent of demons.  Between the two lines of gold a sword is displayed, similar to the one on the collar's clasp.  You take a few dramatic movements to see how it responds, and find that you continue to enjoy free movement.\n\n");
			
			outputText("Taking the heavier coat, you slide your hands into the sleeves, and secure the belt firmly around your waist.  Your initial concern was that the sleeves would be too open, but in making a few quick motions with your hands you don't feel that the cloth gets in the way.  The weight of the gold-trimmed hood surprises you somewhat, but you quickly grow accustomed.  After attempting to move the hood down you realize that doing so is remarkably difficult; it's designed by clever stitching and wires to stay up, and straight.  You suppose that unless you're overheating there's no real need to adjust it.  The coat covers the undershirt's waist decorations, hiding them completely behind its belt.  Now-familiar sword imagery runs over your back, along your spine.  The loops of the belt meet twice - once behind your back, and once beneath the clasp.\n\n");
			
			outputText("To finish the look, you take the two fingerless alchemical gloves and slide them over your hands.  What seems to be a prayer is embroidered in gold on their back.\n\n");
			
			outputText("You feel pious.\n\n(<b>Perk Gained - Blood Mage</b>: Spells consume HP (minimum 5) instead of fatigue!)\n\n");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: "
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("plates") >= 0) {
				desc += "Armor ";
				if (perk == "Light" || perk == "Medium") {
					desc += "(Light)";
				}
				else if (perk == "Medium") desc += "(Medium)";
				else desc += "(Heavy)";
			}
			else desc += "Clothing ";
			//Defense
			desc += "\nDefense: " + String(def);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
	}
}
