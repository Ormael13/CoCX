package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.Monster;

public class BeatOfWarSkill extends AbstractSoulSkill {
    public function BeatOfWarSkill() {
        super(
            "Beat of War",
            "Form a small sphere inscribed by symbols to drain from enemy a bit of lust and/or wrath.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_BUFF],
            null
        )
		baseSFCost = 50;
    }

	override public function get buttonName():String {
		return "Beat of War";
	}

	override public function get isKnown():Boolean {
		return player.weapon == weapons.WGSWORD;
	}

	override public function describeEffectVs(target:Monster):String {
		return "Deals physical damage and raises strength by 15% of base value"
	}

    override public function doEffect(display:Boolean = true):void {		
		if (!player.statStore.hasBuff("BeatOfWar"))
		mainView.statsView.showStatUp('str');
		player.buff("BeatOfWar").addStats({"str.mult":0.15}).withText("Beat of War").combatPermanent();
		if (display) outputText("You momentarily attune yourself to the song of the mother tree, and prepare to add a note of your own to it’s rhythm. You feel the beat shift the song’s tempo slightly, taking a twist towards the ominous. This attunement augments your strength.\n\n");
		combat.basemeleeattacks();
    }

	//Prevent default enemyAI function call, since post ability cleanup will be handled by combat.basemeleeattacks()
	override public function buttonCallback():void {
		combat.callbackBeforeAbility(this);
		if (timingType == TIMING_TOGGLE && isActive()) {
			toggleOff();
		} else {
			perform();
		}
	}
}
}