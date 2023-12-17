package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.Monster;
import classes.PerkLib;

public class BeatOfWarSkill extends AbstractSoulSkill {
    public function BeatOfWarSkill() {
        super(
            "Beat of War",
            "Attack with low-moderate additional soul damage, gain strength equal to 15% your base strength until end of battle. This effect stacks.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_BUFF, TAG_PHYSICAL],
            PerkLib.StrifeWarden
        )
		baseSFCost = 50;
		processPostCallback = false;
    }

	override public function get buttonName():String {
		return "Beat of War";
	}

	override public function describeEffectVs(target:Monster):String {
		return "Deals physical damage and raises strength by 15% of base value"
	}

    override public function doEffect(display:Boolean = true):void {		
		if (!player.statStore.hasBuff("BeatOfWar"))
			mainView.statsView.showStatUp('str');
		player.buff("BeatOfWar").addStats({"str.mult":0.15}).withText("Beat of War").combatPermanent();
		if (display) 
			outputText("You momentarily attune yourself to the song of the mother tree, and prepare to add a note of your own to it’s rhythm. You feel the beat shift the song’s tempo slightly, taking a twist towards the ominous. This attunement augments your strength.\n\n");
		if (player.isInGoblinMech() || player.isInNonGoblinMech()) {
			combat.basemechmeleeattacks();
		}
		else {
			combat.basemeleeattacks();
		}
    }
}
}