package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.Items.ItemTags;
import classes.Player;

public class ChaosBlade extends Weapon
{

    public function ChaosBlade()
    {
        super(
                "ChaosBlade","Chaos Blade","Chaos Blade","a Chaos Blade","slash",135,10800,
                "This dark blade is as beautiful as it is deadly, made in black metal and decorated with a single crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process as this weapon is not meant to be wielded by mortals.", "Hybrid", "Dueling"
        );
		withTag(ItemTags.I_LEGENDARY);

    }
    override public function get attack():Number {
        var boost:int = 0;
        var scal:Number = 10;
		if (game.player.spe >= 100) {
			boost += 10;
			scal -= 3;
		}
		if (game.player.spe >= 50) {
			boost += 10;
			scal -= 2;
		}
		boost += Math.round(game.player.cor / scal);
        return (15 + (3 * boost));
    }
}
}
