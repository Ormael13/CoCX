package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class FlamingBreakerFistChiChi extends AbstractSummonMonster {
	public function FlamingBreakerFistChiChi() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Flames erupt in front of you, and from them spills a mouse-shaped woman, her body covered by a red gi. With hands gloved in fiery mitts, she glares at [enemy] with an almost literal fire in her eyes.\n");
		}
		
	}
}
}