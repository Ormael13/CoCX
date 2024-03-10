package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class MartyrMageArian extends AbstractSummonMonster {
	public function MartyrMageArian() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A bolt of lightning strikes the ground in front of you. From within the electricity, An androgynous lizard-morph steps out, clad in robes fitting for a magician. Sparks fly on their fingertips, and they take a stance beside you. You can feel your own magic strengthening. \n");
		}
		
	}
}
}