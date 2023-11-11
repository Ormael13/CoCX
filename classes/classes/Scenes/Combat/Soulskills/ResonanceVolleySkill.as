package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;

public class ResonanceVolleySkill extends AbstractSoulSkill {
    public function ResonanceVolleySkill() {
        super(
            "Resonance Volley",
            "Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING],
            null,
			false
        )
		baseSFCost = 150;
    }

	override public function get buttonName():String {
		return "Resonance Volley";
	}

	override public function get isKnown():Boolean {
		return player.weaponRangeName == "Warden’s bow";
	}

	override public function sfCost():int {
		return baseSFCost;
	}

    override public function doEffect(display:Boolean = true):void {		
		if (display) outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
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