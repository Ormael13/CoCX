package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class MilkDrownedBathGirl extends AbstractSummonMonster {
	public function MilkDrownedBathGirl() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText(":Suddenly, sand dunes appear like waves in the ocean, and before you a girl with skin darkened by the desert sun appears like a siren from the sands. Her eyes and hair are pure white, and her giant udders leak fluid. As she stretches her arms, pure white liquid flows from them, engulfing the area in a veritable sea of milk. \n");
		}
		
	}
}
}