package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class HarpyMatriarchSophie extends AbstractSummonMonster {
	public function HarpyMatriarchSophie() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A nest appears in a flash of light, and an avian caw fills the air. A harpy with thick, womanly hips flies down, landing in the nest. She eyes up [enemy], before taking back to the skies, flying circles around you, waiting to strike.\n");
		}
		
	}
}
}