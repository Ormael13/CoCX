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
		return "Deals ~" + numberFormat(calcDamage(target)) + " magical damage.";
	}

	public function calcDamage(monster:Monster):Number {
		var willothewispDamage:Number = 10;
        willothewispDamage += (scalingBonusIntelligence() + scalingBonusWisdom()) * 0.4;
        willothewispDamage *= spellMod();
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) willothewispDamage *= combat.historyTacticianBonus();

        var willothewispamplification:Number = 1;
        if (player.weapon == weapons.SCECOMM) willothewispamplification += 0.5;
		if (player.hasPerk(PerkLib.CommandingTone)) willothewispamplification += 0.1;
		if (player.hasPerk(PerkLib.DiaphragmControl)) willothewispamplification += 0.1;
		if (player.hasPerk(PerkLib.VocalTactician)) willothewispamplification += 0.15;
        if (player.hasPerk(PerkLib.WispLieutenant)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispCaptain)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispMajor)) willothewispamplification += 1;
        if (player.hasPerk(PerkLib.WispColonel)) willothewispamplification += 1;
        willothewispDamage *= willothewispamplification;

		return Math.round(willothewispDamage);
	}

    override public function doEffect(display:Boolean = true):void {
    	var damage:Number = calcDamage(monster);

		//Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= 1.75;
        }

		damage = Math.round(damage);

		if (display) outputText("\n\nYour will-o'-the-wisp hits [themonster]! ");
		doMagicDamage(damage, true, display);
		if (display) {
			if (crit) outputText(" <b>Critical! </b>");
			outputText("\n\n");
		}
    }
}
}