/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables {
import classes.*;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

//Checks if the perk is present before use. Algo gives a prompt because why not.
public class ElementalPearl extends Consumable {
    private var requiredPerk:PerkType;
    private var itemPerk:PerkType;

    /**
     * @param tier Tier of the pearl, or its number of colors. The pearl class generates its description based on the tier.
     */
    public function ElementalPearl(tier:int) {
        var descr:String;
        switch(tier) {
            case 3:
                descr = "A pearl formed after defeating a group of golems. It's surrounded by a faint aura of elements. Such pearls can restore the weakened bodies of people who have <i>resolved</i> to spend their lives practicing magic and conjuration."
                requiredPerk = PerkLib.ElementalConjurerResolve;
                itemPerk = PerkLib.ElementalConjurerMindAndBodyResolve;
                break;
            case 5:
                descr = "A pearl formed after defeating an obsidian gargoyle. It's surrounded by a weak aura of elements. Such pearls can restore the weakened bodies of people who have <i>dedicated</i> themselves to magic and conjuration."
                requiredPerk = PerkLib.ElementalConjurerDedication;
                itemPerk = PerkLib.ElementalConjurerMindAndBodyDedication;
                break;
            case 7:
                descr = "A pearl formed after defeating a living statue. It's surrounded by a strong aura of elements. Such pearls can restore the weakened bodies of people who have <i>sacrificed</i> their lifeforce to empower their magic and conjuration abilities."
                requiredPerk = PerkLib.ElementalConjurerSacrifice;
                itemPerk = PerkLib.ElementalConjurerMindAndBodySacrifice;
                break;
            default:
                descr = "";
        }
        descr += "\n\n<b>Effect: removes debuffs created by " + requiredPerk.name() + " perk.</b>";
        super(
            "E"+tier+"Pearl",
            "El."+tier+"C.Pearl",
            "an iridescent "+NUMBER_WORDS_NORMAL[tier]+"-colored pearl",
            tier == 3 ? 200 : tier == 5 ? 400 : 800,
            descr
        );
        if (itemPerk == null) throw new Error("Invalid tier: " + tier + "!");
    }

    override public function useItem():Boolean {
        clearOutput();
        if (!player.hasPerk(requiredPerk)) {
            outputText("You take the pearl in your hands, and it blinks, blinding you and burning your fingers slightly. Seems like you're still not ready to use it.");
            outputText("\n\n<b>Requires perk: " + requiredPerk.name() + "</b>");
            SceneLib.inventory.returnItemToInventory(this);
        }
            else if (player.hasPerk(itemPerk)) {
            outputText("You take the pearl in your hands, and its light quickly dims. Hm. Seems like you won't get anything from it - you're already infused with the same energy as the pearl.");
            outputText("\n\n<b>You already have the perk.</b>");
            SceneLib.inventory.returnItemToInventory(this);
        }
        else {
            outputText("You take the pearl in your hands, and it immediately starts to fill you with newfound strength. Will you eat it?");
            EngineCore.doYesNo(eatIt, putBack);
        }
        return true; //Wait for confirmation
    }

    public function eatIt():void {
        clearOutput();
        outputText("You cram the pearl in your mouth and swallow it like a giant pill with some difficulty.  Surprisingly there is no discomfort, only a calming sensation of three steams of mystical energies spreading in your body and restoring your lost strength, speed and toughness.\n\n");
        player.createPerk(itemPerk, 0, 0, 0, 0);
        outputText("<b>Gained perk: " + itemPerk.name() + "</b>")
        SceneLib.inventory.itemGoNext();
    }

    public function putBack():void {
        clearOutput();
        outputText("You put the pearl back in your pouch. Another time, perhaps.");
        SceneLib.inventory.returnItemToInventory(this);
    }
    
    /**
    Checks if the required perk is present and removes illegally-obtained perk otherwise.
    @return True if something was 'fixed', false if everything is good.
    */
    public function fixSave():Boolean {
        if (player.hasPerk(itemPerk) && !player.hasPerk(requiredPerk)) {
            outputText("<i>Oops. Seems like you have an impossible perk combination. Someone has probably forgotten write on a pearl that it's useless when you're not an elementalist. So... umm...</i>\n\n");
            outputText("You cough and vomit, expelling the pearl. Surprisingly, it's completely intact. Damn sphere even managed to burn your tongue on its way out.");
            player.removePerk(itemPerk);
            player.takePhysDamage(10);
            SceneLib.inventory.takeItem(this, EventParser.playerMenu);
            return true;
        }
        else return false;
    }
}
}
