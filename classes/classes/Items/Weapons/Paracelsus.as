package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.EventParser;
import classes.TimeAwareInterface;

	public class Paracelsus extends Weapon implements TimeAwareInterface {
        //Implementation of TimeAwareInterface
        //Recalculate Wizard's multiplier every hour
		public function timeChange():Boolean
		{
			updateWizardsMult();
			return false;
		}
	
		public function timeChangeLarge():Boolean {
            updateWizardsMult();
			return false;
		}
		
        //Normal weapon stuff
		public function Paracelsus()
		{
			super("Paracel", "Paracelsus", "Paracelsus", "a Paracelsus", "bonk", 22, 600, "A legendary staff said to have been made by Marae for her champion. This weapon radiates divine power, purifying its wielder and protecting them from impurity.", WT_STAFF, WSZ_LARGE);
			withBuff('spellpower', +1.0);
			withTag(I_LEGENDARY);
			withEffect(IELib.ScaleAttack_Str, 50)
			withEffect(IELib.Require_CorBelow, 33)
			withEffect(IELib.AttackBonus_Cor, -1 / 10)
            EventParser.timeAwareClassAdd(this);
		}
		
		public function calcWizardsMult():Number {
			var multadd:Number = 1.0;
            if (game && game.player) multadd += (100 - game.player.cor) * 0.05;
			return multadd;
		}

        private static var lastCor:Number = 40;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == this) {
                    //re-requip to update player's perk
	                var slot:int = game.player.slotOfEquippedItem(this);
					afterUnequip(false, slot);
					afterEquip(false, slot);
                }
                lastCor = game.player.cor;
            }
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor < 3 ? "\n\nYour perfectly pure aura increases the staff's power!\n" :
                    game.player.cor < 10 ? "\n\nYour nearly pure aura <i>barely</i> doesn't interrupt your connection with the staff, but it doesn't increase its power either.\n" :
                    game.player.cor < 20 ? "\n\nYour slightly unclean aura starts to mingle with the flow of energy inside it.\n" :
                    game.player.cor < 30 ? "\n\nYour impure aura mingles with the energy inside it, noticeably reducing its power.\n" :
                    "\n\nYour slightly corrupted aura almost breaks the flow of energy inside the staff.\n");
            else
                return _description;
        }
		

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
