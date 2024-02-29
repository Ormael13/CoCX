package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class HorseplaySentinelEdryn extends AbstractSummonMonster {
	public function HorseplaySentinelEdryn() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("As you focus your magic, sands whirl into existence in front of you. They form into a centaur woman, covered in metal armour and wielding a large halberd. The smell of leather and hay fills the air, invigorating you. \n");
		}
		
	}
}
}