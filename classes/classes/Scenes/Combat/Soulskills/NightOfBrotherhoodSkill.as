package classes.Scenes.Combat.Soulskills {
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.internals.SaveableState;
import classes.PerkLib;
import classes.Saves;

public class NightOfBrotherhoodSkill extends AbstractSoulSkill implements SaveableState {
	private var uses:int = 0;
	private var skillIcon:String = "I_NOBBMAN";
    public function NightOfBrotherhoodSkill() {
        super(
            "Night of Brotherhood",
            "Condense your wrath into a wreath of shadows, filled with the hate of your brotherhood.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_DARKNESS, TAG_RECOVERY, TAG_MAGICAL],
            StatusEffects.KnowsNightOfBrotherhood
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
    	return "NightOfBrotherhood";
    }

    public function resetState():void
    {
    	uses = 0;
    }

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;
        if (player.wrath < 250) {
			return "Your current wrath is too low.";
		}
        return "";
    }  

	override public function describeEffectVs(target:Monster):String {
		var wrathRestore: Number = calcWrathRestore();
		return "~" + numberFormat(calcDamage(target, wrathRestore)) + " darkness damage, restores ~" + numberFormat(wrathRestore) + " wrath";
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

	private function calcWrathRestore():Number {
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
		restoreAmount += Math.round(player.wrath * restoreMult);
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
		damage *= combat.darknessDamageBoostedByDao();
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		var wrathRestore:Number = calcWrathRestore();
		player.wrath -= wrathRestore;
		var damage:Number = calcDamage(monster, wrathRestore);
		if (display) {
			outputText("You start concentrate on the wrath flowing in your body, your veins while imaging a joy of sharing storm of sisterhood with enemy. Shortly after that wrath starts to gather around your hands till it envelop your hands in ligthing.\n\n");
    		outputText("With joy, you sends a mass of ligthing toward [themonster] while mumbling about 'sharing the storm of sisterhood'. ");
		}
		doDarknessDamage(damage, true, display);
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