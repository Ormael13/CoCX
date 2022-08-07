package classes.Items.Weapons
{
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class Occulus extends Weapon implements TimeAwareInterface
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
		public function Occulus()
		{
			super("Occulus", "Occulus", "Occulus", "an Occulus", "bonk", 5, 1600,
					"A wand rumored to have been the favorite catalyst of the now missing in action god of magic. The Occulus is rumored to have been seen and used as early as the genesis of Mareth. Occulus was made to create not to destroy and thus perform best when used to cast restorative magic",
					"Wand, greatly empowers healing spells, increases Spellpower based on purity", WT_WAND
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
                if (game.player.weapon == game.weapons.OCCULUS) {
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
                    game.player.cor > 75 ? "\n\nYour demonic aura almost breaks the flow of energy inside the wand, decreasing its power!\n" :
                    game.player.cor > 50 ? "\n\nYour corrupted aura interrupts your connection with the wand, decreasing its power.\n" :
                    game.player.cor > 25 ? "\n\nYour aura slightly distorts the wand's energy flow, not allowing you to use its full power.\n" :
                    "\n\nYour pure energy flows through the wand, empowering it!\n");
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
