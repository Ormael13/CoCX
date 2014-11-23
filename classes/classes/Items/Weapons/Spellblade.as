/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Spellblade extends Weapon {
		
		public function Spellblade() {
			super("S.Blade", "S.Blade", "inscribed spellblade", "a spellblade", "slash", 8, 500, "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.", "Wizard's Focus");
		}
		
		override public function playerEquip():Weapon {
			while (game.player.findPerk(PerkLib.WizardsFocus) >= 0) game.player.removePerk(PerkLib.WizardsFocus);
			game.player.createPerk(PerkLib.WizardsFocus, 0.5, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.findPerk(PerkLib.WizardsFocus) >= 0) game.player.removePerk(PerkLib.WizardsFocus);
			return super.playerRemove();
		}
		
/*
		override public function equipEffect(player:Player, output:Boolean):void
		{
			player.createPerk(PerkLib.WizardsFocus,.5,0,0,0);
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			player.removePerk(PerkLib.WizardsFocus);
		}
<<<<<<< HEAD

		public function Spellblade()
		{
			super("S.Blade","S.Blade","inscribed spellblade","a spellblade","slash",8,500,"Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle. \n\nType: Weapon (Magical) \nAttack: 8 \nBase value: 500 \nSpecial: Wizard's Focus (+50 spell effect multiplier)","Wizard's Focus")
		}
=======
*/
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
	}
}
