package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class FlameDragonKiha extends AbstractSummonMonster {
	public function FlameDragonKiha() {
		super(
			"",
			"Summons your  to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("A bright-eyed biped, covered in blood-red scales, claws her way from the ground. Flames boil from her maw, and red wings spread, each wing shining, edges curved like the blades of an axe. She looks at the [enemy] with undisguised disdain, heat radiating off her in waves. 
\n");
		}
		
	}
}
}