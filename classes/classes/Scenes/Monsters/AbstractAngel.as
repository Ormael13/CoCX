/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractAngel extends Monster {

	public function AbstractAngel(plural:Boolean) 
	{
		// argument so superclass constructor always called
		this.plural = plural;
		this.lustVuln = 0.01;
		this.createBreastRow(0, 1);
		initGenderless();
		createStatusEffect(StatusEffects.LowtierMagicImmunity, 0, 0, 0, 0);
		createPerk(PerkLib.EnemyTrueAngel, 0, 0, 0, 0);
	}

}
}