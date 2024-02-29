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
			"Alchemical Elder",
			"Summons your Alchemical Elder Monster to aid you in combat",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_ACID,]
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You hear bubbles popping around you, and a giant one forms in front of you. When it pops, however, an old rat-morph appears, a small workbench in front of him. He stares at" [themonster] "with squinted eyes, anger clear on his face.\n");
		}
		
	}
}
}