package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class HornyHordeTamaniDaughters extends AbstractSummonMonster {
	public function HornyHordeTamaniDaughters() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("The ground around you trembles, and from within the earth, goblins spew out. Even smaller than normal, barely a foot and a half tall, these creatures eye both you and [enemy] with lust, sharp teeth glinting.\n");
		}
		
	}
}
}