/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters {
import classes.Monster;
import classes.PerkLib;

public class AbstractFleshGolem extends Monster {
	
	public function AbstractFleshGolem(plural:Boolean) 
	{
		// argument so superclass constructor always called
		this.plural = plural;
		createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		createPerk(PerkLib.EnemyFleshConstructType, 0, 0, 0, 0);
		createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
		createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
		createPerk(PerkLib.TankI, 0, 0, 0, 0);
	}	
}
}