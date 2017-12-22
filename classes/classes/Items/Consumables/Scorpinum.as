/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.Appearance;
import classes.AppearanceDefs;
import classes.Items.Consumable;
import classes.PerkLib;

public class Scorpinum extends Consumable {
	public function Scorpinum() {
		super("Scorico", "Scorpinum", "a vial of Scorpinum", 6, "This is a long flared vial with a small label that reads, \"<i>Scorpinum</i>\".  It is likely this potion is tied to scorpions in some way.");
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(3) == 0) changeLimit++;
		if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.EzekielBlessing) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
		player.slimeFeed();
		clearOutput();
		outputText("You down the potion, grimacing at the strong taste.");
		if (changes < changeLimit && rand(2) == 0 && player.tou < 80) {
			changes++;
			outputText("\n\nAfter drinking the potion, you feel a bit tougher.");
			dynStats("tou", 1);
		}
		if (player.hasPerk(PerkLib.TransformationImmunity)) changeLimit = 0;
		//gain scorpion tail
		if (changes < changeLimit && player.tailType != AppearanceDefs.TAIL_TYPE_SCORPION && player.tailType != AppearanceDefs.TAIL_TYPE_GARGOYLE && rand(2) == 0) {
			if (player.tailType != AppearanceDefs.TAIL_TYPE_NONE) outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a segmented scorpion-like tail grows in place of your old one.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.  <b>You have a scorpion tail.</b>");
			else outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and extending with a series of pops until you have a segmented tail hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a scorpion tail.</b>");
			mutations.setTailType(AppearanceDefs.TAIL_TYPE_SCORPION);
			player.tailVenom = 15;
			player.tailRecharge = 3;
			changes++;
		}
		//Venom Increase
		if (changes < changeLimit && player.tailType == AppearanceDefs.TAIL_TYPE_SCORPION && player.tailRecharge < 15 && rand(2) == 0) {
			if (player.tailRecharge < 5) player.tailRecharge += 2;
			if (player.tailRecharge < 10) player.tailRecharge += 2;
			if (player.tailRecharge < 15) player.tailRecharge += 2;
			player.tailVenom += 50;
			if (player.tailVenom > 150) player.tailVenom = 150;
			outputText("\n\nYour tail swells with vitality and a drop of venom escapes your stinger as it begins producing it in slightly larger quantities.");
			changes++;
		}
		//Gain chitin skin
		if (changes < changeLimit && !player.hasCoatOfType(AppearanceDefs.SKIN_COAT_CHITIN) && !player.isGargoyle() && player.tailType == AppearanceDefs.TAIL_TYPE_SCORPION && rand(2) == 0) {
			mutations.growChitin("green");
			changes++;
		}
		return false;
	}
}
}
