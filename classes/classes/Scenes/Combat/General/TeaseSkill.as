package classes.Scenes.Combat.General {
import classes.PerkLib;
import classes.Monster;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.AbstractGeneral;

public class TeaseSkill extends AbstractGeneral {

    public function TeaseSkill() {
        super(
            "Tease",
            "Attempt to make an enemy more aroused by striking a seductive pose and exposing parts of your body.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_LUSTDMG],
            null
        )
		lastAttackType = Combat.LAST_ATTACK_LUST;
    }

    override public function get isKnown():Boolean {
        return true;
    }

	override public function describeEffectVs(target:Monster):String {
		return "Deals ~" + numberFormat(calcLustDamage(target)) + " lust damage.";
	}

	public function calcLustDamage(monster:Monster):Number {
		var lustDmg:Number = 10;
        

		return Math.round(lustDmg);
	}

    override public function doEffect(display:Boolean = true):void {
    	var damage:Number = calcLustDamage(monster);

    }
}
}