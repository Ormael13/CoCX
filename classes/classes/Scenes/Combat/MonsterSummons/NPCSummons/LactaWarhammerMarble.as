package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LactaWarhammerMarble extends AbstractSummonMonster {
	public function LactaWarhammerMarble() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("From your card springs a lacta bovine with nothing but a simple smock on. Her multiple rows of milk-dripping breasts are on display, and she wields a warhammer in one hand.\n");
		}
		
	}
}
}