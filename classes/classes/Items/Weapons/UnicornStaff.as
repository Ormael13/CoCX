package classes.Items.Weapons 
{
	import classes.PerkLib;
	import classes.EventParser;
    import classes.TimeAwareInterface;

	public class UnicornStaff extends WeaponWithPerk
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
			super("U.Staff", "U. Staff", "unicorn staff", "a unicorn staff", "smack", 6, 960,
					"This blessed staff is made in pearl-white sandalwood and decorated with a golden spiral pattern, reminiscent of a unicorn’s horn. The magic within seems to greatly enhance the user’s healing spells, not unlike those of the fabled creature that it emulates.",
					"Staff, increases Spellpower based on purity", PerkLib.WizardsFocus, 0.9, 0, 0, 0, "", "Staff"
			);
		}
		
		public function calcWizardsMult():Number {
			var desc:String = "";
			var multadd:Number = 0.9;
            if (game && game.player)
                multadd += (100 - game.player.cor) * 0.01;
			return multadd;
		}

        private static var lastCor:Number = 100; //optimization

        public function updateWizardsMult():void {
            if (game.player.cor != lastCor) {
                weapPerk.value1 = calcWizardsMult();
                if (game.player.weapon == game.weapons.U_STAFF) {
                    //re-requip to update player's perk
                    playerRemove();
                    playerEquip();
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

		override public function get verb():String { 
				return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
	}
}