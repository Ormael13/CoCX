package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class MadnessHarbingerPatchtoulie extends AbstractSummonMonster {
	public function MadnessHarbingerPatchtoulie() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A garishly colored pink and purple cat-morph rises from the ground, yawning mightily. It climbs up a completely imaginary tree, then lazes around above your head, occasionally poking its head into your field of view, a giant grin on its face. You begin to feel slightly dizzy, the area around you blurring slightly. \n");
		}
		
	}
}
}