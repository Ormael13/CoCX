package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LakeLibrarianIzma extends AbstractSummonMonster {
	public function LakeLibrarianIzma() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A patch of lakewater forms in front of you, and from it, a womanly figure rises, her shark teeth gleaming white. She gives you a simpering look before glaring daggers at your foe, ready to beat them into submission. \n");
		}
		
	}
}
}