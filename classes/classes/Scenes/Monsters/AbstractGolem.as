/**
 * Created by aimozg on 22.05.2017.
 */
package classes.Scenes.Monsters {
import classes.Monster;
import classes.PerkLib;

public class AbstractGolem extends Monster{
	public function AbstractGolem(plural:Boolean) {
		// argument so superclass constructor always called
		this.plural = plural;
		this.lustVuln = 0;
		this.createBreastRow(0, 1);
		initGenderless();
		createPerk(PerkLib.Resolute, 0, 0, 0, 0);
	}
}
}
