package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class FeatheredBroodMBimbo extends AbstractSummonMonster {
	public function FeatheredBroodMBimbo() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up, and from the sky descends a peach-colored harpy, with long, sharp talons…obscured by the massive E-cup breasts and ripe, puffy pussy lips. The feathered broodmother stares at "[themonster]" with lust in her eyes\n");
		}
		
	}
}
}