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
			outputText("Black string shoots from the ground, a bubbling ooze of ebony pooling in front of you. As it spreads, a spider leg, forged from steel, rises. With the screech of metal, a humanoid upper body shoots up, dark goo forming armour around a giant spider bottom half. The gargantuan metal Drider stands between you and your foe. \n");
		}
		
	}
}
}