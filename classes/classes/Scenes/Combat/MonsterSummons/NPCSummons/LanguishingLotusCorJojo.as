package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LanguishingLotusCorJojo extends AbstractSummonMonster {
	public function LanguishingLotusCorJojo() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A diseased lotus flower shoots from the ground. It’s purple, and its stem is blackened, rotting at the roots. From inside the folded petals, a form stirs. The petals fall off, revealing a nude mouselike form. Clearly male, with an erect member, the corrupted mouse leers at your enemy, purple aura visible around him.\n");
		}
		
	}
}
}