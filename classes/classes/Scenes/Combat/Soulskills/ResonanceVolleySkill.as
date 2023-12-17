package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.PerkLib;

public class ResonanceVolleySkill extends AbstractSoulSkill {
    public function ResonanceVolleySkill() {
        super(
            "Resonance Volley",
            "Perform a ranged attack where each arrow after the first gets an additional 10% accuracy for every arrow before it.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL],
            PerkLib.WildWarden,
			false
        )
		baseSFCost = 150;
		processPostCallback = false;
    }

	override public function get buttonName():String {
		return "Resonance Volley";
	}

	override public function sfCost():int {
		return baseSFCost;
	}

    override public function doEffect(display:Boolean = true):void {		
		if (display) outputText("You ready your bow, infusing it with a figment of soulforce. The energy awakens the wood’s connection to the world tree, causing the bow to pulse beneath your fingers.\n\n");
		player.createStatusEffect(StatusEffects.ResonanceVolley,0,0,0,0);
		combat.fireBow();
    }
}
}