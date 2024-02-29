package classes.Scenes.Combat.MonsterSummons.NPCSummons {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSummonMonster;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BlackLotusTentJojo extends AbstractSummonMonster {
	public function BlackLotusTentJojo() {
		super(
			"Black Lotus",
			"Summons your Black Lotus to aid you in combat",
		);
		baseSFCost = 100;
	}

    override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You place a stone card on your Conduit. As you play the Black Lotus card, fragments of petals rise from the ground, jet-black pieces of rotten flower that herald a disturbing entity. A mouselike figure, covered only by a few scraps of rags that had once been a robe, appears within the petals. The petals vanish, and four tendrils rise from the creature’s shoulders, ending with drooling tentacle cocks. His eyes have no trace of soul or sanity.\n");
		}
		
	}
}
}