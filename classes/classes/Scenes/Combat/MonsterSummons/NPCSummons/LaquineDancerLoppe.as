package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LaquineDancerLoppe extends AbstractSummonMonster {
	public function LaquineDancerLoppe() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Sensual, slow music echoes through the air, and as if stepping from a stage, a rabbit-morph, clothed scantily in an exotic dancer’s attire, joins you on the battlefield.\n");
		}
		
	}
}
}