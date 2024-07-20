package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.internals.SaveableState;
import classes.PerkLib;
import classes.Saves;

public class IciclesOfLoveSkill extends AbstractSoulSkill implements SaveableState {
	private var uses:int = 0;
	private var skillIcon:String = "I_IOLBMAN";
    public function IciclesOfLoveSkill() {
        super(
            "Icicles of Love",
            "Weaponize your lust, crystalizing it into cold, sharp icicles.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_ICE, TAG_RECOVERY, TAG_MAGICAL],
            StatusEffects.KnowsIciclesOfLove
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
		Saves.registerSaveableState(this);
    }

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void
    {
    	if (o) {
			uses = o["uses"];
		} else {
			resetState();
		}
    }

	public function saveToObject():Object
    {
    	return {
			"uses": uses 
		}
    }

    public function stateObjectName():String
    {
    	return "IciclesOfLove";
    }

    public function resetState():void
    {
    	uses = 0;
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

	override public function get description():String {
		var desc:String = super.description;
		var currentLevel:int = player.statusEffectv1(knownCondition);
		switch (currentLevel) {
			case 1: desc += "\nRank: Rankless";
					break;
			case 2: desc += "Effective against groups.\nRank: Low Rank";
					break;
			case 3: desc += "Highly effective against groups.\nRank: Mid Rank";
					break;
			case 4: desc += "Highly effective against groups.\nRank: High Rank";
					break;
		}
		return desc;
	}

	override public function presentTags():Array {
        var result:Array = super.presentTags();
        var currentLevel:int = player.statusEffectv1(knownCondition);
        if (currentLevel > 1) result.push(TAG_AOE);
        return result;
    }

    override public function hasTag(tag:int):Boolean {
		var currentLevel:int = player.statusEffectv1(knownCondition);
        return super.hasTag(tag) || (currentLevel > 1 && (tag == TAG_AOE));
    }

	override public function calcCooldown():int {
		return  Math.max(0, player.statusEffectv1(knownCondition) - 1);
	}

	private function calcLustRestore():Number {
		var restoreAmount:Number = 0;
		var restoreMult:Number = 0;
		switch (player.statusEffectv1(knownCondition)) {
			case 1: restoreMult = 0.1;
					break;
			case 2: restoreMult = 0.2;
					break;
			case 3: restoreMult = 0.25;
					break;
			case 4: restoreMult = 0.3;
					break;
		}
		restoreAmount += Math.round(player.lust * restoreMult);
		return restoreAmount;
	}

	public function calcDamage(monster:Monster, baseDamage: Number):Number {
		var currentLevel:int = player.statusEffectv1(knownCondition);
		var damage:Number = baseDamage * (5 * currentLevel);
		if (currentLevel > 1) {
			damage += scalingBonusWisdom() * (currentLevel - 1);
			damage *= soulskillMagicalMod() * (currentLevel - 1);
		}
		//group enemies bonus
		if (monster && monster.plural) {
			if (currentLevel > 2) {
				damage *= 5;
			} else if (currentLevel > 1) {
				damage *= 2;
			}
		}
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
		levelUpCheck(true, display);
    }

	private function levelUpCheck(increment:Boolean = true, display:Boolean = true):void {
		var currentLevel:int = player.statusEffectv1(knownCondition);
		var nextLevelUp:int = (currentLevel > 1)? 10: 5;
		var maxLevel:int = 4;
		if (currentLevel <= 0 || currentLevel >= maxLevel) return;
		if (increment && uses < nextLevelUp) uses++;
		if (isFinite(nextLevelUp)) {
            notificationView.popupProgressBar2(skillIcon,skillIcon,
                    name + " Mastery", (uses-1)/nextLevelUp, uses/nextLevelUp);
        }
		if (currentLevel == 1 && uses >= nextLevelUp && player.hasPerk(PerkLib.SoulApprentice)) {
			if (display) {
				outputText("Your skill at using the \"" + name + "\" soulskill has progressed!\n");
				outputText("<b>\"" + name + "\" rank has increased from (Rankless) to (Low Rank)!</b>\n\n");
			}
			player.changeStatusValue(knownCondition, 1, 2);
			uses = 0;
		}
		if (currentLevel == 2 && uses >= nextLevelUp && player.hasPerk(PerkLib.SoulWarrior)) {
			if (display) {
				outputText("Your skill at using the \"" + name + "\" soulskill has progressed!\n");
				outputText("<b>\"" + name + "\" rank has increased from (Low Rank) to (Mid Rank)!</b>\n\n");
			}
			player.changeStatusValue(knownCondition, 1, 3);
			uses = 0;
		}
		if (currentLevel == 3 && uses >= nextLevelUp && player.hasPerk(PerkLib.SoulScholar)) {
			if (display) {
				outputText("Your skill at using the \"" + name + "\" soulskill has progressed!\n");
				outputText("<b>\"" + name + "\" rank has increased from (Mid Rank) to (High Rank)!</b>\n\n");
			}
			player.changeStatusValue(knownCondition, 1, 4);
			uses = 0;
		}
	}
}
}