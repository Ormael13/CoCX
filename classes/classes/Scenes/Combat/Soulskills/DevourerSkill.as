package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class DevourerSkill extends AbstractSoulSkill {
    public function DevourerSkill() {
        super(
            "Devourer",
            "Form a small sphere inscribed by symbols to drain from enemy a bit of lust and/or wrath.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DEBUFF, TAG_TIER2],
            StatusEffects.KnowsHeavensDevourer
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function get buttonName():String {
		return "Devourer";
	}

	override public function describeEffectVs(target:Monster):String {
		return "Drains ~" + numberFormat(calcLustDrain(target, false)) + "lust and ~" + numberFormat(calcWrathDrain(target, false)) + " wrath";
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(4, false);
	}

	private function calcLustDrain(monster:Monster, apply:Boolean):Number {
		var drainAmount:Number = 0;
		if (!monster) return drainAmount;
		if (monster.lust > 400) {
        	if (apply) monster.lust -= 400;
        	drainAmount += 200;
    	} else {
			var devouredLust:Number = monster.lust;
			if (apply) monster.lust = 0;
			drainAmount += Math.round(devouredLust / 2);
    	}
		return drainAmount;
	}

	private function calcWrathDrain(monster:Monster, apply:Boolean):Number {
		var drainAmount:Number = 0;
		if (!monster) return drainAmount;
		if (monster.wrath > 400) {
        	if (apply) monster.wrath -= 400;
        	drainAmount += 200;
    	} else {
			var devouredWrath:Number = monster.wrath;
			if (apply) monster.wrath = 0;
			drainAmount += Math.round(devouredWrath / 2);
    	}
		return drainAmount;
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) {
			outputText("You start to concentrate and between your hands forms small black sphere inscribed with many tiny symbols. With a simple flick of hand you send it toward [themonster], which preparing to defend. But sphere stops a round twenty centimiters before [monster his]. ");
    		outputText("And then it starts greedy sucking our any bit of lust or wrath it can find in [themonster] trasmiting part of it back to you.");
		}
		var transferedWrath:Number = calcLustDrain(monster, true);
		var transferedLust:Number = calcWrathDrain(monster, true);
		if (transferedLust > 0) {
			if (display) outputText("(+" + transferedLust + " lust)");
			player.lust += transferedLust;
		}
		if (transferedWrath > 0) {
			if (display) outputText("(+" + transferedWrath + " wrath)");
			player.wrath += transferedWrath;
		}
		if (display) outputText("\n\n");
    }
}
}