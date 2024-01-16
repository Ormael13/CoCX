/**
 * Created by Demojay on 16/01/2024
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;
	import classes.EventParser;
    import classes.TimeAwareInterface;

	public class BeautifulFlyWhisk extends Weapon implements TimeAwareInterface {
        //Implementation of TimeAwareInterface
        //Recalculate Wizard's multiplier every hour
		public function timeChange():Boolean
		{
			updateCultivatorMult();
			return false;
		}
	
		public function timeChangeLarge():Boolean {
            updateCultivatorMult();
			return false;
		}
		
        //Normal weapon stuff
		public function BeautifulFlyWhisk()
		{
			super(
				"B.FlyWhisk", 
				"B.FlyWhisk", 
				"beautiful fly-whisk", 
				"a beautiful shining fly-whisk", 
				"slash", 
				0, 
				400, 
				"This beautiful fly-whisk shines brilliantly in the light, showing its flawless craftsmanship." + 
				"  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this tool.", 
				"", 
				WT_EXOTIC);
			withBuff('psoulskillpower', 0)
			withBuff('msoulskillpower', 0);
            EventParser.timeAwareClassAdd(this);
		}
		
		public function calcCultivatorMult():Number {
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

        public function updateCultivatorMult():void {
            if (game.player.cor != lastCor) {
				var newMult:Number = calcCultivatorMult()
				_buffs['psoulskillpower'] = newMult;
				_buffs['msoulskillpower'] = newMult;
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
                    game.player.cor < 3 ? "\n\nYour perfectly pure aura increases the fly-whisk's power!\n" :
                    game.player.cor < 10 ? "\n\nYour almost pure aura <i>almost</i> doesn't interrupt your connection with the fly-whisk, but doesn't increase its power either.\n" :
                    game.player.cor < 20 ? "\n\nYour slightly unclean aura starts to mingle with flow of energy inside it.\n" :
                    game.player.cor < 30 ? "\n\nYour impure aura mingles with energy inside it, notably reducing its power.\n" :
                    "\n\nYour slightly corrupted aura almost breaks the flow of energy inside the staff.\n");
            else
                return _description;
        }
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance)) return super.canEquip(doOutput);
			if(doOutput) outputText("You grab hold of the handle of the fly-whisk only to have it grow burning hot. You're forced to let it go lest you burn yourself. Something within the tool must be displeased.");
			return false;
		}

		override public function get description():String {
			updateCultivatorMult(); //To display *correct* values
			return super.description;
		}
	}
}
