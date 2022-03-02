package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Player;

public class ChaosBlade extends Weapon
{

    public function ChaosBlade()
    {
        super(
                "ChaosBlade","Chaos Blade","Chaos Blade","a Chaos Blade","slash",45,3360,
                "This dark blade is as beautiful as it is deadly, made in black metal and decorated with a single crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process as this weapon is not meant to be wielded by mortals.", "Hybrid", "Dueling"
        );
    }
    override public function get attack():Number {
        var boost:int = 0;
        boost += Math.round(game.player.cor / 10);
        return (12 + (3 * boost));
    }
    override public function canUse():Boolean {
        if (game.player.level >= 40) return super.canUse();
        outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
        return false;
    }
}
}