package classes.Scenes.Areas.HighMountains 
{
import classes.BodyParts.Wings;

/**
	 * ...
	 * @author Stadler76
	 */
	public class WingedCockatrice extends Cockatrice 
	{
		public function WingedCockatrice() 
		{
			super();
			wings.type = Wings.FEATHERED_LARGE;
			this.dynStats("spe", 10);
			this.imageName = "cockatricewithwings";
		}
	}
}
