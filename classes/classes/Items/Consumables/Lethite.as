/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables {
import classes.*;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

//Checks if the perk is present before use. Algo gives a prompt because why not.
public class Lethite extends Consumable {

    public function Lethite() {
        var descr:String;
        descr = "A chunk of lesser lethicite. It's rare as lethicite is only produced when a mortal becomes a demon and cums their souls out. A demon's favourite treat."
        super("Lethite", "Lesser Lethicite", "a chunk of lesser lethicite", 1000, descr );
    }

    override public function useItem():Boolean {
        clearOutput();
        if (!player.hasPerk(PerkLib.SoulEater) && !player.hasPerk(PerkLib.Soulless)) {
            outputText("You examine the pinkish-purple crystal. It must be lethicite. You know that the demons like to consume them but you're sure there might be a use for it.");
            SceneLib.inventory.returnItemToInventory(this);
        }
        else {
            eatIt();
        }
        return true; //Wait for confirmation
    }

    public function eatIt():void {
        clearOutput();
        outputText("You grab the crystal and gulp it down, smiling contently as you feel it dissolve into your core and suffuse your body with raw power.");
		if (player.hasPerk(PerkLib.Soulless)) {
			var gains:Number = 50;
			if (player.demonicenergy + gains > player.maxDemonicEnergy()) gains = player.maxDemonicEnergy() - player.demonicenergy;
			player.demonicenergy += gains;
			outputText(" (+"+gains+" DE)");
		}
		else {
			player.buff("Soul Eater").addStat("int.mult",0.01);
			player.buff("Soul Eater").addStat("lib.mult",0.01);
		}
        SceneLib.inventory.itemGoNext();
    }
}
}
