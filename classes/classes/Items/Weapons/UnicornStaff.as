package classes.Items.Weapons
{
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class UnicornStaff extends Weapon implements TimeAwareInterface
	{
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
		public function UnicornStaff()
		{
			super("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "bonk", 10, 1600,
					"This blessed staff is made in pearl-white sandalwood and decorated with a golden spiral pattern, reminiscent of a unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that it emulates. Furthermore, the staff allows the user to preserve mana when casting using a minimal ammount of energy on each spell.",
					"Large, Staff, Spell Cost -50% increases Spellpower based on purity", WT_STAFF
			);
			withBuff('spellpower', +0.6);
			EventParser.timeAwareClassAdd(this);
		}

		public function calcWizardsMult():Number {
			var multadd:Number = 0.6;
            if (game && game.player)
                multadd += (100 - game.player.cor) * 0.034;
			return multadd;
		}

        private static var lastCor:Number = 100;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == game.weapons.U_STAFF) {
                    //re-requip to update player's perk
                    afterUnequip(false);
                    afterEquip(false);
                }
            }
            lastCor = game.player.cor;
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor > 75 ? "\n\nYour demonic aura almost breaks the flow of energy inside the staff, decreasing its power!\n" :
                    game.player.cor > 50 ? "\n\nYour corrupted aura interrupts your connection with the staff, decreasing its power.\n" :
                    game.player.cor > 25 ? "\n\nYour aura slightly distorts the staff's energy flow, not allowing you to use its full power.\n" :
                    "\n\nYour pure energy flows throgh the staff, empowering it!\n");
            else
                return _description;
        }
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 40) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay put in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
