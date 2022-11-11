/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters {
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractFleshGolem extends Monster {
	
	public function AbstractFleshGolem(plural:Boolean) 
	{
		// argument so superclass constructor always called
		this.plural = plural;
		createStatusEffect(StatusEffects.LowtierMagicImmunity, 0, 0, 0, 0);
		createPerk(PerkLib.Resolute, 0, 0, 0, 0);
		createPerk(PerkLib.EnemyFleshConstructType, 0, 0, 0, 0);
		createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
		createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
		createPerk(PerkLib.TankI, 0, 0, 0, 0);
	}	
}
}