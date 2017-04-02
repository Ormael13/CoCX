/**
 * Created by aimozg on 15.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.PerkLib;
	import classes.Player;

	public final class InquisitorsCorset extends Armor {
		
		public function InquisitorsCorset() {
			super("I.Corst", "I.Corst", "inquisitor's corset", "an inquisitor's corset", 4, 2000, "This sexualized and feminine red and gold ensemble carries with it the hopes of a shamed sorcerer.  Wearing it will cause spells to tax your health instead of exhausting you.", "Light", false, false);
		}
		
		override public function useText():void {
			outputText("You remove the clothing you received from the underground chamber in the swamp.  The sexual nature of the clothing excites you a bit, as does the knowledge that it will be functional in combat.  You quickly disrobe, eager to try it on.\n\n");

			outputText("Checking to see whether the posture collar can be detached from the sleeves, you find a complete lack of any way to do so.  Shrugging, you slide your arms into the sleeves, sticking your middle fingers through the extended ends.  Golden embroidery down their length contains some of the most ornate and stylized pictures of dicks you have ever seen, culminating in an excessive amount of gold thread splayed in your palm, symbolizing the ejaculate.  You lift your chin to fit the posture collar in place, completely hiding your neck from view as you lace it from behind.  The dark red works nicely with your " + game.player.skinTone + " " + game.player.skinDesc + ".   A small amount of delight fills you as you realize the collar is not as unforgiving as a true posture collar, allowing you a comfortable amount of movement - though you do briefly wonder what a fight would be like if it didn't.\n\n");

			outputText("You fit the corset on next, wrapping it around your waist and chest, hiding your " + game.player.nippleDescript(0) + "s beneath more red and gold trim.  As you lace the corset up you realize that what you had taken for a stylized sword rising up between the cups bears a much greater resemblance to a prick.  Fair enough.  The belt practically attaches to the corset as though it were made to be a single article of clothing, clasping beneath a set of heavily stylized golden lines that you suspect are meant to be a face in the middle of either prayer or oral sex, or possibly both.\n\n");

			outputText("Earlier suspicions about the skirt prove correct - it does not conceal in the slightest.  It covers some skin to the right side, mostly in the back, but your front is on full display to the world.  The skirt feels as though it should go on a dancing showgirl rather than an inquisitor, but you made the choice you did and the results <i>are</i> arousing.  Golden trim takes on the form of waving and twisting tentacles as the bottom of the skirt gets closer, looking as though it wants to burst from the fabric and molest its wearer.\n\n");

			//[(if PC has human, demon, or bee feet)
			if (game.player.isBiped()) outputText("Finally you slide your legs into the boots.  The heel itself is hollow, to accommodate any natural spurs on the wearer's foot, and the rest of the boot seems surprisingly fitted to your dimensions.  To a certain extent it feels as though it is reshaping itself as you enter - parts that initially feel tight loosen up in minutes, as if the boots were breaking themselves in.  If what the note said is true, and the armor adapts to he who finds it, perhaps even hooves and paws could have fit, given enough magical power used in the creation.  Laces run up the side of each boot all the way to your thighs, resembling the corset they were paired with.  The front of them bear golden symbology, akin to the symbols  that sat on the front of the secret chamber.  Based on your previous decoding, they're halfway between a prayer and a exaltation of cock.  Standing up in them, you smile as your " + game.player.buttDescript() + " rises with their influence.");
			///(else if PC has funny feet)
			else outputText("The final bit of the outfit is a pair of long-heeled lace-up boots, which, though decorated with gorgeous golden symbols spelling out what appears to be a hymn to sex, seem... relatively unusable in your current state.  You tuck them away someplace safe in case you ever become a biped again, then stand to your full height and assess yourself.");
			outputText("\n\n");

			outputText("You feel sexy... and pious.\n\n(<b>Perk Gained - Blood Mage</b>: Spells consume HP (minimum 5) instead of fatigue!)\n\n");
			//+lust
			game.dynStats("lus", 5);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: "
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
			if (def > 0) desc += "\nDefense: " + String(def);
			//Value
			if (value != 0) desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Blood Mage and Slutty Seduction (Magnitude: 10)";
			return desc;
		}
		
		override public function playerEquip():Armor {
			while (game.player.findPerk(PerkLib.BloodMage) >= 0) game.player.removePerk(PerkLib.BloodMage);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.BloodMage,0,0,0,0);
			game.player.createPerk(PerkLib.SluttySeduction,10,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor {
			while (game.player.findPerk(PerkLib.BloodMage) >= 0) game.player.removePerk(PerkLib.BloodMage);
			while (game.player.findPerk(PerkLib.SluttySeduction) >= 0) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}
	}
}
