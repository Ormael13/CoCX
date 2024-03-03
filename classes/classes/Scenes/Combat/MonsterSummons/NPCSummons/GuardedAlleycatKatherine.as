package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class GuardedAlleycatKatherine extends AbstractSummonMonster {
	public function GuardedAlleycatKatherine() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A thin-looking cat-morph, with rags on her feet and a leather jerkin covering her top half. With a bottle of milk in one hand, and a spear in the other, you’re unsure whether this alleycat is a guard, or one that needs protecting.\n");
		}
		
	}
}
}