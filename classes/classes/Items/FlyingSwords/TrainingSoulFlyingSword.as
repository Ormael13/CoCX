/**
 * ...
 * @author Ormael
 */
package classes.Items.FlyingSwords 
{
	import classes.Items.FlyingSwords;
	import classes.PerkLib;
	import classes.Player;
	
	public class TrainingSoulFlyingSword extends FlyingSwords
	{
		
		public function TrainingSoulFlyingSword() 
		{
			super("TraSFlS","Train.S.Fl.Sword","training soul flying sword","a training flying sword","slash",1,80,"This small flying sword was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon or if user is not too heavy fly on it.", "Small");
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.FlyingSwordPath)) return true;
			outputText("You aren't skilled enough to control this flying sword!  ");
			return false;
		}
	}
}