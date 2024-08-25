/**
 * @author Svalkash
 */
package classes.Items.Weapons {
import classes.CoC;
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.Scenes.Combat.CombatAbilities;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;
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
        super("Tidarion", "Tidarion", "ethereal blade", "the blade of Tidarion", "slash", 20, 2000, "Forged by a powerful sorceress and strengthened by the white magic of the Covenant, this ethereal blade is designed to be used by a mage. The original spellblade's enchantment was studied and dissolved, so the only thing left is the sword's handle, encrusted with some glowing stone. When you take it in your hand, the glowing ethereal blade forms from it, enveloped by a fire aura. It's named after one mighty ancient white wizard, Tidarion. The blade gets stronger when you're free from the corruption; its attacks use your magic energy to deal extra damage to your enemy.", WT_SWORD, WSZ_MEDIUM);
        withTags(W_STAFFPART, W_PURE_TYPE, W_FIRE_TYPE);
        withBuff('spellpower', +1.0);
        EventParser.timeAwareClassAdd(this);
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
                var slot:int = game.player.slotOfEquippedItem(this);
                afterUnequip(false, slot);
                afterEquip(false, slot);
            }
            lastCor = game.player.cor;
        }
    }

    override public function get attack():Number {
        var base:Number = 20;
        var pureBonus:Number = 1.0 + (50 - game.player.cor) * 0.01; //from 50 to 150
        var balancedAttack:Number = Math.floor((base + manaUsed() / 100) * pureBonus); //lol still OP, right?
        //remove this shit because I'm sure it WILL break the game eventually.
        return CombatAbilities.Whitefire.adjustSpellDamage(balancedAttack, DamageType.FIRE, CombatAbility.CAT_SPELL_WHITE, CoC.instance.monster, false, false);
    }

    //without discounts!!!
    public function manaUsed():Number {
        var manaPlanned:Number = game.player.maxMana() / 20;
        var maxNum:Number = game.player.mana;
        if (game.player.hasPerk(PerkLib.BloodMage) || game.player.hasStatusEffect(StatusEffects.BloodMage)) {
            manaPlanned = game.player.maxHP() / 20;
            maxNum = game.player.HP - 1;
        } else if (game.player.hasPerk(PerkLib.LastResort)) {
            // manaPlanned += game.player.maxHP() / 20; //nope.
            maxNum += game.player.HP;
        }
        return Math.min(manaPlanned, maxNum);
    }

    public function afterStrike():void {
        var manaPlanned:Number = manaUsed();
        var canUse:Number = game.player.hasStatusEffect(StatusEffects.BloodMage) || game.player.hasPerk(PerkLib.BloodMage) ? 0 :
            Math.min(manaPlanned, game.player.mana);
        //mana first
        if (canUse > 0) {
            game.player.mana -= canUse;
            manaPlanned -= canUse;
        }
        if (manaPlanned > 0) {//shouldn't be reached without HP casting
            game.player.HP -= manaPlanned;
        }
        //Raging inferno. Damage is ALREADY increased, so just give +1 to the counter!
        CombatAbilities.Whitefire.calcInfernoMod(0, true);
    }
}
}
