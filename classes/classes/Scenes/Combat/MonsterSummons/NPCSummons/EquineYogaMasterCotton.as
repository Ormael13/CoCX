package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class EquineYogaMasterCotton extends AbstractSummonMonster {
	public function EquineYogaMasterCotton() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up. Stretching, a dark-skinned Horse-woman rises from the ground, standing beside you. She bends over backward, displaying remarkable flexibility, before cracking her neck, eyeing your foe with a guarded expression\n");
		}
		
	}
}
}