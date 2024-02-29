package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class FetishMerchantCeraph extends AbstractSummonMonster {
	public function FetishMerchantCeraph() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up, and from the ground in front of you rises a demonic figure, generous purple ass swaying enticingly. She wields a whip, licking her lips. She stands off to one side of you, filling the air with desire.\n");
		}
		
	}
}
}