/**
 * ...
 * @author ... Liadri
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class AlvinaTwinScythe extends Weapon
	{
		
		public function AlvinaTwinScythe()
		{	//Effect: Magic catalyst 180%, Count as a dual weapon this item also damage enemies mana on each successful swing. Also cause the burn status for 3 rounds.	//TODO
			super("DemScyt","D.Scythe","demonic scythe","a demonic scythe","slash",20,12000,"Alvina’s beloved weapons. These pair of scythes were used to slay rival mages. The black flame which blaze along this cursed item’s blade burns the victim’s magic like fuel. Alvina rarely ever used this item to its full extent, only pulling it out as a trump card against her deadliest opponents when magic alone proved insufficient.", "Dual Large, Whirlwind", "Scythe, StaffPart");
			withBuff('spellpower', +1.8);
		}
		
		override public function get attack():Number{
			return 20 + (game.player.cor / 20);
		}
	}
}
