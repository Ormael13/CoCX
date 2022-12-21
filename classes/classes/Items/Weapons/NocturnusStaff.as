package classes.Items.Weapons
{
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class NocturnusStaff extends Weapon implements TimeAwareInterface
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
		public function NocturnusStaff()
		{
			super("N.Staff", "N. Staff", "nocturnus staff", "a nocturnus staff", "bonk", 10, 1600,
					"This corrupted staff is made in black ebonwood and decorated with a bat ornament in bronze. Malice seems to seep through the item, devouring the wielder’s mana to channel its unholy power.",
					"Large, Staff, +200% Spell cost, Spellpower bonus for corruption", WT_STAFF);
			withBuff('spellpower', +0.6);
			EventParser.timeAwareClassAdd(this);
		}
		
		public function calcWizardsMult():Number {
			var multadd:Number = 0.6;
            if (game && game.player)
                multadd += game.player.cor * 0.05;
			return multadd;
		}

        private static var lastCor:Number = 0;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == this) {
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
                    game.player.cor < 25 ? "\n\nYour pure aura almost breaks the flow of energy inside the staff, decreasing its power!\n" :
                    game.player.cor < 50 ? "\n\nYour pure aura sligtly interrupts your connection with the staff, decreasing its power.\n" :
                    game.player.cor < 75 ? "\n\nYour corrupted aura slightly increases the staff's power.\n" :
                    "\n\nYour corrupted energy flows throgh the staff, empowering it!\n");
            else
                return _description;
        }
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 40) return super.canEquip(doOutput);
			if(doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay put in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
