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
			TARGET_SELF,
			TIMING_INSTANT,
			[TAG_BUFF, ]
		);
		baseSFCost = 100;
	}
	public function isStackable():Boolean {
		return false;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your conduit. The device lights up, and from the ground in front of you rises a giant bubble, seemingly transparent, with deep ripples. When it pops, however, an old rat-morph appears, a small workbench in front of him. He stares at" [themonster] "with squinted eyes, anger clear on his face.\n");
		}
		
	}
}
}