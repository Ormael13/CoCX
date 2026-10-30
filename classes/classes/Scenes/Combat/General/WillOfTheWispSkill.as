package classes.Scenes.Combat.General {
import classes.PerkLib;
import classes.Monster;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.AbstractGeneral;

public class WillOfTheWispSkill extends AbstractGeneral {

    public function WillOfTheWispSkill() {
        super(
            "Will Of The Wisp",
            "Attack the oppenent with your will-o'-the-wisp",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL],
            PerkLib.JobLeader
        )
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function describeEffectVs(target:Monster):String {
		return "Deals ~" + numberFormat(calcDamage(target)) + " magical damage" + (player.hasPerk(PerkLib.BurningSpirits)?" and X fire damage":"") + ".";
	}

	public function calcDamage(monster:Monster):Number {
		var willothewispDamage:Number = 10;
        willothewispDamage += (scalingBonusIntelligence() + scalingBonusWisdom()) * 0.4;
        willothewispDamage *= spellMod();
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) willothewispDamage *= combat.historyTacticianBonus();

        var willothewispamplification:Number = 1;
        if (player.weapon == weapons.SCECOMM) willothewispamplification += 0.5;
        if (player.armor == armors.ARCHNECC) willothewispamplification += 0.25;
        if (player.upperGarment == undergarments.ARCHNECB) willothewispamplification += 0.2;
        if (player.lowerGarment == undergarments.ARCHNECP) willothewispamplification += 0.2;
		if (player.hasPerk(PerkLib.CommandingTone)) willothewispamplification += 0.1;
		if (player.hasPerk(PerkLib.DiaphragmControl)) willothewispamplification += 0.1;
		if (player.hasPerk(PerkLib.VocalTactician)) willothewispamplification += 0.15;
		if (player.hasPerk(PerkLib.AbsorbNutrient) && player.perkv1(PerkLib.AbsorbNutrient) > 4) willothewispamplification += 0.5;
		if (player.hasPerk(PerkLib.AbsorbNutrient) && player.perkv1(PerkLib.AbsorbNutrient) > 5) willothewispamplification += 0.5;
		if (player.hasPerk(PerkLib.AbsorbNutrient) && player.perkv1(PerkLib.AbsorbNutrient) > 6) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispLieutenant)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispCaptain)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispMajor)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispColonel)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispBrigadierGeneral)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispMajorGeneral)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispLieutenantGeneral)) willothewispamplification += 1;
		if (player.hasPerk(PerkLib.BinaryFission)) willothewispamplification *= 2;
		if (player.hasPerk(PerkLib.OneWispArmyMinor)) willothewispamplification *= 4;
		if (player.hasPerk(PerkLib.OneWispArmyMajor)) willothewispamplification *= 4;
		if (player.hasPerk(PerkLib.OneWispArmyEpic)) willothewispamplification *= 4;
		if (player.hasPerk(PerkLib.IDontHaveMinionsIGotFamily)) willothewispamplification *= 0.5;
		if (player.hasPerk(PerkLib.IDontHave2FastMinionsIGot2FuriousFamily)) willothewispamplification *= 0.5;
		if (player.hasPerk(PerkLib.IDontHaveMinionsIGotFamilyMarethDrift)) willothewispamplification *= 0.5;
        willothewispDamage *= willothewispamplification;

		return Math.round(willothewispDamage);
	}

    override public function doEffect(display:Boolean = true):void {
    	var damage:Number = calcDamage(monster);

		//Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance *= combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
        }

		damage = Math.round(damage);

		if (display) outputText("\n\nYour will-o'-the-wisp hits [themonster]! ");
		doMinionMagDamage(damage, true, display);
		if (display) {
			if (crit) outputText(" <b>Critical! </b>");
			outputText("\n\n");
		}
		if (player.hasPerk(PerkLib.BurningSpirits)) {
			doMinionFireDamage(damage, true, display);
			if (display) {
				if (crit) outputText(" <b>Critical! </b>");
				outputText("\n\n");
			}
		}
    }
}
}