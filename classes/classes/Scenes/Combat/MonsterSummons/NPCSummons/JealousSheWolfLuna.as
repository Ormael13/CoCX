package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class JealousSheWolfLuna extends AbstractSummonMonster {
	public function JealousSheWolfLuna() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("From the sky, a small moon appears, casting silvered light upon a human woman in a maid outfit brought forward from the earth. A wolf’s howl fills the air, and the maid looks back at you, giving you a saddened look before bursting through her outfit, muzzle growing, hair covering her body. The moon shatters, and the she-wolf growls at [enemy].\n");
		}
		
	}
}
}