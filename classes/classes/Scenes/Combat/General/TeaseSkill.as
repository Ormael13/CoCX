package classes.Scenes.Combat.General {
import classes.PerkLib;
import classes.Monster;
import classes.IMutations.IMutationsLib;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.AbstractGeneral;
import classes.StatusEffects;
import classes.BodyParts.Tail;
import classes.Races;
import classes.Scenes.SceneLib;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Combat.TeaseOptions;

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
		icon = "A_Tease";
    }

    override public function get isKnown():Boolean {
        return true;
    }

	override public function describeEffectVs(target:Monster):String {
		return "Deals ~" + numberFormat(calcLustDamage(target)) + " lust damage.";
	}

	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;

		if (monster.hasStatusEffect(StatusEffects.Dig)) {
			return "The enemy cannot see your tease when they're underground.";
		}
		if (combat.isEnemyInvisible) {
			return "You cannot tease an opponent you cannot see or target, heck is it even looking at you right now?"
		}

		return "";
	}

    public function calcBaseHitChance():Number {
        var chance:Number = 90;
		chance += player.teaseLevel;
        chance += player.upperGarment.sexiness;
		chance += player.lowerGarment.sexiness;
		chance += player.miscJewelry1.sexiness;
		chance += player.miscJewelry2.sexiness;
        
        if (player.teaseDmgStat.value > 0) chance += 10;
		if (player.hasPerk(PerkLib.Seduction)) chance += 10;
        if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) chance += 10;
        if (player.hasPerk(PerkLib.SensualLover)) chance += 2;
        if (player.hasPerk(PerkLib.FlawlessBody)) chance += 10;
        if (player.hasPerk(PerkLib.ChiReflowLust)) chance += UmasShop.NEEDLEWORK_LUST_TEASE_MULTI;

        //bonus for Urta
		if (SceneLib.urtaQuest.isUrta()) chance += 10;

        return chance;
    }

	public function calcLustDamage(monster:Monster):Number {
		var lustDmg:Number = combat.teases.teaseBaseLustDamage();
        if (player.hasPerk(PerkLib.BroadSelection) && player.differentTypesOfCocks() > 1) lustDmg *= (1 + (0.25 * player.differentTypesOfCocks()));
		lustDmg = combat.teases.fueledByDesireDamageBonus(lustDmg);
		if (SceneLib.urtaQuest.isUrta()) lustDmg *= 2;
		if (monster) lustDmg *= monster.lustVuln;

		return Math.round(lustDmg);
	}

	override public function revenge(display:Boolean = true):void{
		outputText("\n\nAs you narrowly avoid the attack you use this lull in the battle to strike back with a lecherous trick!\n\n");
		if (monster.lustVuln == 0) {
			if (display) outputText("You do your best to tease [themonster] with your body but it has no effect!  Your foe clearly does not experience lust the same way as you.\n\n");
			return;
		}
		else if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
			clearOutput();
			if (display) outputText("You do your best to tease [themonster] with your body.  It doesn't work - you blinded [monster him], remember?\n\n");
			return;
		}
		else if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 1) {
			clearOutput();
			if (display) outputText("You do your best to tease [themonster] with your body.  Your artless twirls have no effect, as <b>your ability to tease has been sealed.</b>\n\n");
			return;
		}

		var baseChance:Number = calcBaseHitChance();

		var teaseChoiceArray:Array = combat.teases.genTeaseChoiceArray();

		var selectedTease:int = teaseChoiceArray[rand(teaseChoiceArray.length)];
		//Override selected tease conditions
		if (monster.short.indexOf("minotaur") != -1) {
			//Cowgirl Tease
			if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.racialScore(Races.COW) >= 3 && player.tailType == Tail.COW)
				selectedTease = 43;
		}
		//Alraune and Liliraune Tease
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			selectedTease = 46;
		}

		var teaseOpt:TeaseOptions = combat.teases.applySelectedTease(selectedTease, display);

		if (rand(100) <= baseChance + rand(teaseOpt.bonusChance)) {
			var lustDmg:Number = calcLustDamage(monster);
			var damageMod:Number = teaseOpt.damage + rand(teaseOpt.bonusDamage);
			if (player.perkv1(IMutationsLib.FiendishBallsIM) >= 4 && (selectedTease == 3 || selectedTease == 10 || selectedTease == 11 || selectedTease == 23 || selectedTease == 33 || selectedTease == 35)) lustDmg *= 4;
			lustDmg *= 1 + (1 * damageMod/20);

			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.teases.combatTeaseCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				lustDmg *= 1.75;
				if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !player.enemiesImmuneToLustResistanceDebuff()) monster.lustVuln += 0.05;
				if (monster.lustVuln > monster.lustVulnCap()) monster.lustVuln = monster.lustVulnCap();
			}

			if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 20 && !monster.hasPerk(PerkLib.Resolute)) {
				if (display) outputText("\n[themonster] is so mesmerised by your show that it stands there gawking.");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}

			//Handle any possible enemy interruptions
			if (monster.handleTease(lustDmg, true, display)) {
				monster.teased(lustDmg, false, display);
				if (crit && display) outputText(" <b>Critical!</b>");
				combat.teases.fueledByDesireHeal(display);
			}

			if (flags[kFLAGS.PC_FETISH] >= 1 && !SceneLib.urtaQuest.isUrta()) {
				if (display) {
					if (player.lust < (player.maxLust() * 0.75)) outputText("\nFlaunting your body in such a way gets you a little hot and bothered.");
					else outputText("\nIf you keep exposing yourself you're going to get too horny to fight back.  This exhibitionism fetish makes it hard to resist just stripping naked and giving up.");
				}
				player.takeLustDamage(7 + rand(6), true);
			}
			// Similar to fetish check, only add XP if the player IS the player...
			if (!SceneLib.urtaQuest.isUrta()) player.SexXP(1 + combat.teases.bonusExpAfterSuccesfullTease());

		} else {
			if (!SceneLib.urtaQuest.isUrta()) player.SexXP(1);
			//Handle any possible enemy interruptions
			if (monster.handleTease(0, false, display) && display) {
				outputText("\n[Themonster] seems unimpressed.");
			}
		}
		if (display) outputText("\n\n");
	}

    override public function doEffect(display:Boolean = true):void {
        clearOutput();
        if (monster.lustVuln == 0) {
			if (display) outputText("You do your best to tease [themonster] with your body but it has no effect!  Your foe clearly does not experience lust the same way as you.\n\n");
			return;
		}
        else if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
			clearOutput();
			if (display) outputText("You do your best to tease [themonster] with your body.  It doesn't work - you blinded [monster him], remember?\n\n");
			return;
		}
		else if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 1) {
			clearOutput();
			if (display) outputText("You do your best to tease [themonster] with your body.  Your artless twirls have no effect, as <b>your ability to tease has been sealed.</b>\n\n");
			return;
		}

        var baseChance:Number = calcBaseHitChance();

        var teaseChoiceArray:Array = combat.teases.genTeaseChoiceArray();

        var selectedTease:int = teaseChoiceArray[rand(teaseChoiceArray.length)];
		//Override selected tease conditions
		if (monster.short.indexOf("minotaur") != -1) {
			//Cowgirl Tease
			if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.racialScore(Races.COW) >= 3 && player.tailType == Tail.COW)
				selectedTease = 43;
		}
		//Alraune and Liliraune Tease
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			selectedTease = 46;
		}

        var teaseOpt:TeaseOptions = combat.teases.applySelectedTease(selectedTease, display);

        if (rand(100) <= baseChance + rand(teaseOpt.bonusChance)) {
            var lustDmg:Number = calcLustDamage(monster);
            var damageMod:Number = teaseOpt.damage + rand(teaseOpt.bonusDamage)
            lustDmg *= 1 + (1 * damageMod / 20);
			if (player.perkv1(IMutationsLib.FiendishBallsIM) >= 4) 

            //Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combat.teases.combatTeaseCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				lustDmg *= 1.75;
				if (monster.lustVuln != 0 && player.hasPerk(PerkLib.SweepDefenses) && !player.enemiesImmuneToLustResistanceDebuff()) monster.lustVuln += 0.05;
				if (monster.lustVuln > monster.lustVulnCap()) monster.lustVuln = monster.lustVulnCap();
			}

            if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 20 && !monster.hasPerk(PerkLib.Resolute)) {
				if (display) outputText("\n[themonster] is so mesmerised by your show that it stands there gawking.");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}

			//Handle any possible enemy interruptions
			if (monster.handleTease(lustDmg, true, display)) {
				monster.teased(lustDmg, false, display);
				if (crit && display) outputText(" <b>Critical!</b>");
				combat.teases.fueledByDesireHeal(display);
			}

            if (flags[kFLAGS.PC_FETISH] >= 1 && !SceneLib.urtaQuest.isUrta()) {
				if (display) {
                    if (player.lust < (player.maxLust() * 0.75)) outputText("\nFlaunting your body in such a way gets you a little hot and bothered.");
                    else outputText("\nIf you keep exposing yourself you're going to get too horny to fight back.  This exhibitionism fetish makes it hard to resist just stripping naked and giving up.");
                }
                player.takeLustDamage(7 + rand(6), true);
			}
			// Similar to fetish check, only add XP if the player IS the player...
			if (!SceneLib.urtaQuest.isUrta()) player.SexXP(1 + combat.teases.bonusExpAfterSuccesfullTease());
		
        } else {
            if (!SceneLib.urtaQuest.isUrta()) player.SexXP(1);
			//Handle any possible enemy interruptions
			if (monster.handleTease(0, false, display) && display) {
				outputText("\n[Themonster] seems unimpressed.");
			}
        }
		if (display) outputText("\n\n");
    }    
}
}
