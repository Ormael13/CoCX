package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class HiddenScissorsLynette extends AbstractSummonMonster {
	public function HiddenScissorsLynette() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A single goblin forms in front of you. While she’s slightly bigger than most, what catches your eye is the oversized pair of scissors in each hand, and the wicked-looking shine on that steel. Your summoned goblin eyes [enemy] with a devilish grin.\n");
		}
		
	}
}
}