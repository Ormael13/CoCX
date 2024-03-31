package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class MilkyShieldmaidenIsabella extends AbstractSummonMonster {
	public function MilkyShieldmaidenIsabella() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You hear the clang of steel, and from thin air drops a bovine woman in scaled armour which barely holds her large lactating breasts. She stands between you and" [themonster], "tower shield held in front. \n");
		}
		
	}
}
}