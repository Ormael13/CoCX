package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class IciclesOfLoveSkill extends AbstractSoulSkill {
    public function IciclesOfLoveSkill() {
        super(
            "Icicles of Love",
            "Weaponize your lust, crystalizing it into cold, sharp icicles.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_ICE, TAG_RECOVERY, TAG_MAGICAL, TAG_AOE],
            StatusEffects.KnowsIciclesOfLove
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function get buttonName():String {
		return "Icicles of Love";
	}

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if (player.lust < 50) {
			return "Your current lust is too low.";
		}

        return "";
    }  

	override public function describeEffectVs(target:Monster):String {
		var lustRestore: Number = calcLustRestore();
		return "~" + numberFormat(calcDamage(target, lustRestore)) + " ice damage, restores ~" + numberFormat(lustRestore) + " lust";
	}

	override public function calcCooldown():int {
		return  Math.round(player.statusEffectv1(StatusEffects.KnowsIciclesOfLove));
	}

	public function iciclesOfLoveLC():Number {
    	return 10 * player.statusEffectv1(StatusEffects.KnowsIciclesOfLove);
	}

	private function calcLustRestore():Number {
		var restoreAmount:Number = 0;
		restoreAmount += Math.round(player.lust * (iciclesOfLoveLC() * 0.01));
		return restoreAmount;
	}

	public function calcDamage(monster:Monster, baseDamage: Number):Number {
		var damage:Number = baseDamage * (5 * player.statusEffectv1(StatusEffects.KnowsIciclesOfLove));

		//group enemies bonus
		if (monster && monster.plural) damage *= 5;

		damage *= combat.iceDamageBoostedByDao();
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		var lustRestore:Number = calcLustRestore();
		player.lust -= lustRestore;

		var damage:Number = calcDamage(monster, lustRestore);

		if (display) {
			outputText("You start concentrate on the lust flowing in your body, your veins while imaging a joy of sharing icicles of love with enemy. Shortly after that lust starts to gather around your hands getting colder and colder till it envelop your hands in icicles.\n\n");
    		outputText("And with almost orgasmic joy, you sends a wave of ice shards toward [themonster] while mumbling about 'sharing the icicles of love'. ");
		}
		doIceDamage(damage, true, display);
		if (display) outputText("\n\n");
    }
}
}