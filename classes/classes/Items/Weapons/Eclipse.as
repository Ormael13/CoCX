package classes.Items.Weapons
{
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class Eclipse extends Weapon implements TimeAwareInterface
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
		public function Eclipse()
		{
			super("Eclipse", "Eclipse", "Eclipse", "an Eclipse", "bonk", 10, 1600,
					"Created using the blood and bones of a titan, Eclipse, as it is now called, constantly craves oblivion. As a corrupted sentient weapon, it constantly craves death and suffering, but more than anything, it craves the life of its owner. Eclipse obeys no master and seeks to destroy everything indiscriminately. Due to its nature as an item infused with the essence of annihilation, Eclipse weakens the power of healing spells. (Weakens healing spells, grants a spellpower bonus for corruption)",
					WT_WAND, WSZ_MEDIUM);
			withBuff('spellpower', +1.0);
			withTag(I_LEGENDARY);
			EventParser.timeAwareClassAdd(this);
		}
		
		public function calcWizardsMult():Number {
			var multadd:Number = 1.0;
            if (game && game.player) multadd += game.player.cor * 0.07;
			return multadd;
		}

        private static var lastCor:Number = 0;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == this) {
                    //re-requip to update player's perk
	                var slot:int = game.player.slotOfEquippedItem(this);
                    afterUnequip(false, slot);
                    afterEquip(false, slot);
                }
            }
            lastCor = game.player.cor;
        }

        override public function get descBase():String {
            if (game && game.player)
                return _description + (
                    game.player.cor < 25 ? "\n\nYour pure aura almost breaks the flow of energy inside the wand, decreasing its power!\n" :
                    game.player.cor < 50 ? "\n\nYour pure aura slightly interrupts your connection with the wand, decreasing its power.\n" :
                    game.player.cor < 75 ? "\n\nYour corrupted aura slightly increases the wand's power.\n" :
                    "\n\nYour corrupted energy flows through the wand, empowering it!\n");
            else
                return _description;
        }
		
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 25;
			if (game.player.str >= 50) {
				boost += 4;
				scal -= 5;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (1 + boost);
		}

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
