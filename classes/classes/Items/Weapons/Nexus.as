package classes.Items.Weapons
{
import classes.EventParser;
import classes.Items.Weapon;
import classes.PerkLib;
import classes.TimeAwareInterface;

public class Nexus extends Weapon implements TimeAwareInterface
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
		public function Nexus()
		{
			super("Nexus", "Nexus", "Nexus", "a Nexus", "bonk", 5, 1600,
					"Through the combination of the Occulus and Eclipse, you somehow obtained this anomaly of an item: a wand of unknown origin. Wizards often refer to it as the source of all magic. A point in space where all mana converges. Magic is neither good nor evil but is capable of both, shaped from raw chaos by those who wield it. Only a creature attuned to true balance could harness the raw power of the Nexus as is. While this wand indeed seems to manipulate the essence of raw chaos, its name was probably a whim of the deity who made it. There's no way you could actually be handling the origin point of magic itself, right? (Increases spell resistance by 20%, increases spellpower based on neutrality)",
					WT_WAND, WSZ_MEDIUM
			);
			withBuff('spellpower', +0.6);
			withTag(I_LEGENDARY);
			EventParser.timeAwareClassAdd(this);
		}

		public function calcWizardsMult():Number {
			var multadd:Number = 0.6;
			var checkedNeutralityBonus:Number = 4.4
			if (game.player.cor > 50) checkedNeutralityBonus = 4.4-((game.player.cor-50)*0.088);
			if (game.player.cor < 50) checkedNeutralityBonus = 4.4-((50-game.player.cor)*0.088);
			multadd += checkedNeutralityBonus;
			return multadd;
		}

        private static var lastCor:Number = 100;

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
				_buffs['spellpower'] = calcWizardsMult();
                if (game.player.weapon == game.weapons.OCCULUS) {
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
                    game.player.cor > 75 ? "\n\nYour demonic aura almost breaks the flow of energy inside the wand, decreasing its power!\n" :
                    game.player.cor > 50 ? "\n\nYour aura is in perfect equilibrium , empowering the wand!\n" :
							game.player.cor < 25 ? "\n\nYour pure aura almost breaks the flow of energy inside the wand, decreasing its power!\n" :
                    "\n\nYour pure energy flows through the wand, empowering it!\n");
            else
                return _description;
        }

		override public function get description():String {
			updateWizardsMult(); //To display *correct* values
			return super.description;
		}
	}
}
