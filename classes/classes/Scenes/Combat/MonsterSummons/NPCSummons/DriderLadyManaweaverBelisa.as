package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class DriderLadyManaweaver extends AbstractSummonMonster {
	public function DriderLadyManaweaver() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up, and pure White strands of silk form beside you, making a cocoon nearly six feet tall. From within, six violet eyes peek out. The cocoon cracks, and a small Drider stands, her back legs tapping nervously. \n");
		}
		
	}
}
}