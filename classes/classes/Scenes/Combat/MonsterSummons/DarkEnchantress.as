package classes.Scenes.Combat.MonsterSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class DarkEnchantress extends AbstractSummonMonster {
	public function DarkEnchantress() {
		super(
			"D.Enchantress",
			"Summons the Dark Enchantress to aid you in combat",
			TARGET_SELF,
			TAG_DARKNESS,
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your Conduit. The device lights up, and from the ground in front of you rises a buxom young human woman in rich violet robes. They cannot conceal her figure, but they cover her body entirely. She floats in midair, a little smile on her face.\n");
		}
		
	}
}
}