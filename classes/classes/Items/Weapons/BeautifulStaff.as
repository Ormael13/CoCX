package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;
import classes.PerkLib;
	import classes.EventParser;
    import classes.TimeAwareInterface;

	public class BeautifulStaff extends Weapon implements TimeAwareInterface {
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
		public function BeautifulStaff()
		{
			super("B.Staff", "B.Staff", "beautiful staff", "a beautiful shining staff", "bonk", 2, 160, "This beautiful staff shines brilliantly in the light, showing the flawless craftsmanship.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this staff.", WT_STAFF, WSZ_LARGE);
			withBuff('spellpower', 0);
			withEffect(IELib.Require_CorBelow, 33);
            EventParser.timeAwareClassAdd(this);
		}
		
		public function calcWizardsMult():Number {
			var multadd:Number = 0.4;
            if (game && game.player) {
                multadd = (40 - game.player.cor) / 100;
                if (game.player.cor < 3)
                    multadd += 0.05;
            }
			if (multadd < 0.1)
                multadd = 0.1;
			return multadd;
		}

        private static var lastCor:Number = 40;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == this) {
                    //re-requip to update player's perk
					afterUnequip(false);
					afterEquip(false);
                }
                lastCor = game.player.cor;
            }
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor < 3 ? "\n\nYour perfectly pure aura increases the staff's power!\n" :
                    game.player.cor < 10 ? "\n\nYour almost pure aura <i>almost</i> doesn't interrupt your connection with the staff, but doesn't increase its power either.\n" :
                    game.player.cor < 20 ? "\n\nYour slightly unclean aura starts to mingle with flow of energy inside it.\n" :
                    game.player.cor < 30 ? "\n\nYour impure aura mingles with energy inside it, notably reducing its power.\n" :
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
