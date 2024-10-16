/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.PerkLib;

	public class FrancescaBlackCloak extends Armor {
		
		public function FrancescaBlackCloak() 
		{
			super("F.Cloak","F.Cloak","black cloak","Francesca's Black Cloak",12,12,6000,"A cloak rumored to have been worn by the black cat adventurer Francesca, the heavenly black tiger. Not exactly a strong armor per se, its true ability lies in concealing its wearer's true location through a mix of glamor and illusion spell, improving the user's evasiveness by leaps and bound. Francesca was a famous sword mage and as thus the cloak greatly reinforces spells casted through the medium of a weapon.","Light");
				withBuffs({
					'spellcost': -0.40,
					'evade': 2
				});
				withTag(A_AGILE);
				withTag(A_REVEALING);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) game.player.createPerk(PerkLib.Misdirection, 0, 0, 1, 0);
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if (game.player.perkv4(PerkLib.Misdirection) == 0 && game.player.perkv3(PerkLib.Misdirection) > 0) game.player.removePerk(PerkLib.Misdirection);
			super.afterUnequip(doOutput, slot);
		}
	}
}
