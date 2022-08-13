/**
 * @author Svalkash
 */
package classes.Items.Weapons {
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class Tidarion extends Weapon implements TimeAwareInterface {
    //Implementation of TimeAwareInterface
    //Recalculate Wizard's multiplier every hour
    public function timeChange():Boolean {
        updateWizardsMult();
        return false;
    }

    public function timeChangeLarge():Boolean {
        return false;
    }

    public function Tidarion() {
        super("Tidarion", "Tidarion", "ethereal blade", "the blade of Tidarion", "slash", 20, 2000, "Forged by a powerful sorceress and strengthened by the white magic of the Covenant, this ethereal blade is designed to be used by a mage. The original spellblade's enchantment was studied and dissolved, so the only thing left is the sword's handle, encrusted with some glowing stone. When you take it in your hand, the glowing ethereal blade forms from it, enveloped by a fire aura. It's named after one mighty ancient white wizard, Tidarion. The blade gets stronger when you're free from the corruption; its attacks use your magic energy to deal extra damage to your enemy.", "", "Sword, StaffPart");
        EventParser.timeAwareClassAdd(this);
        withBuff('spellpower', +1.0);
    }

    public function calcWizardsMult():Number {
        var multadd:Number = 0.5;
        if (game && game.player) {
            multadd += (50 - game.player.cor) * 0.006; //from 25 to 75
            if (game.player.cor < 3)
                multadd += 0.1; //small bonus for PERFECTLY pure people
        }
        return multadd;
    }

    private static var lastCor:Number = 50;

    public function updateWizardsMult():void {
        if (game.player.cor != lastCor) {
            _buffs['spellpower'] = calcWizardsMult();
            if (game.player.weapon == game.weapons.TIDAR) {
                //re-requip to update player's perk
                afterUnequip(false);
                afterEquip(false);
            }
            lastCor = game.player.cor;
        }
    }

    override public function get attack():Number {
        var base:Number = 20;
        var manaUsed:Number = Math.min(game.player.maxMana() / 10, game.player.mana);
        var pureBonus:Number = 1.0 + (50 - game.player.cor) * 0.01; //from 50 to 150
        return Math.floor((base + manaUsed / 100) * pureBonus);
    }
}
}
