/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables {
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

public class PurePearl extends Consumable {
    public function PurePearl() {
        super("P.Pearl", "P.Pearl", "a pure pearl", 1000, "Marae gave you this pure pearl as a reward for shutting down the demonic factory. You're sure you can find a <b>lot</b> of applications for its divine energy.");
    }

    override public function useItem():Boolean {
        clearOutput();
        outputText("Are you sure you want to just eat the pearl?\n\n");
        if (!player.hasStatusEffect(StatusEffects.SiegweirdTraining2) && flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 3
            && (!player.hasStatusEffect(StatusEffects.AlvinaTraining2) || player.statusEffectv1(StatusEffects.AlvinaTraining2) < 3)
            || flags[kFLAGS.TEMPLE_OF_THE_DIVINE_MARAE] < 1)
            outputText("<i>You have a feeling that you might find more important uses for it in the future.</i>");
        EngineCore.doYesNo(eatIt, putBack);
        return true; //Wait for confirmation
    }

    public function eatIt():void {
        clearOutput();
        outputText("You pop the pearl into your mouth and swallow it like a giant pill, though with some difficulty.  Surprisingly there is no discomfort—only a cool, calming sensation that springs up from your core.");
        dynStats("lus", -25, "cor", -10);
        player.addCurse("lib", 10, 1);
        if (!player.hasPerk(PerkLib.PurityBlessing)) player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
        SceneLib.inventory.itemGoNext();
    }

    public function putBack():void {
        clearOutput();
        outputText("You put the pearl back in your pouch. Another time, perhaps.");
        SceneLib.inventory.returnItemToInventory(this);
    }
}
}
