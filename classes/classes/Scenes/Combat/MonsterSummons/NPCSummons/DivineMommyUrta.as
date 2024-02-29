package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class AlchemicalElderRalthazul extends AbstractSummonMonster {
	public function AlchemicalElderRalthazul() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A simple door appears in thin air, and from it steps a pregnant-looking Fox-morph, dressed in a simple hauberk and wielding a dangerous-looking Halberd. She emanates a radiance that is at once divine, maternal and fierce. Beside her is an emancipated fox-morph with a devilish grin on his face. \n");
		}
		
	}
}
}