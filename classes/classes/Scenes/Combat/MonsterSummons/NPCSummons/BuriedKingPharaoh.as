package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BuriedKingPharaoh extends AbstractSummonMonster {
	public function BuriedKingPharaoh() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up, and from the ground in front of you, sands swirl, forming the body of the buried king. “Good to be out of the Pyramid”, he declares, a golden disk forming on his wrist. He draws a few cards, and looks at" [themonster] +"with calculating eyes\n");
		}
		
	}
}
}