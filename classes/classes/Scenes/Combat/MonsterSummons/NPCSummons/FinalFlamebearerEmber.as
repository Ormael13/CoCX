package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class FinalFlamebearerEmber extends AbstractSummonMonster {
	public function FinalFlamebearerEmber() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up, and a scaled beast rises from the earth, talons and teeth bared. Smoke rises from its androgynous body, and it spreads majestic wings, taking off.  Your Flamebearer looks down upon "[themonster]" with haughty disdain. \n");
		}
		
	}
}
}