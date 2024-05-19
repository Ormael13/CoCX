package classes.Scenes.Combat.General {
import classes.PerkLib;
import classes.Monster;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.AbstractGeneral;
import classes.GlobalFlags.kFLAGS;

public class MummyAttackSkill extends AbstractGeneral {

    public function MummyAttackSkill() {
        super(
            "Mummy Attack",
            "Attack the oppenent with your mummies",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL],
            PerkLib.MummyLord
        )
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

    override public function get isKnown():Boolean {
        return super.isKnown && player.perkv1(PerkLib.MummyLord) > 0;
    }

	override public function describeEffectVs(target:Monster):String {
		return "Deals ~" + numberFormat(calcDamage(target)) + " physical damage.";
	}

	public function calcDamage(monster:Monster):Number {
		var mummyDamage:Number = 10;
        mummyDamage += (scalingBonusIntelligence() + scalingBonusWisdom()) * 0.4;
        mummyDamage *= player.perkv1(PerkLib.MummyLord);
		mummyDamage *= soulskillMod();
        if (player.hasPerk(PerkLib.HistoryTactician) || player.hasPerk(PerkLib.PastLifeTactician)) mummyamplification *= combat.historyTacticianBonus();
        var mummyamplification:Number = 1;
        if (player.weapon == weapons.SCECOMM) mummyamplification += 0.5;
		if (player.hasPerk(PerkLib.CommandingTone)) mummyamplification += 0.1;
		if (player.hasPerk(PerkLib.DiaphragmControl)) mummyamplification += 0.1;
		if (player.hasPerk(PerkLib.VocalTactician)) mummyamplification += 0.15;
		if (flags[kFLAGS.WILL_O_THE_WISP] == 2) {
            mummyamplification += 0.1;
            if (player.hasPerk(PerkLib.WispLieutenant)) mummyamplification += 0.2;
            if (player.hasPerk(PerkLib.WispCaptain)) mummyamplification += 0.3;
            if (player.hasPerk(PerkLib.WispMajor)) mummyamplification += 0.4;
            if (player.hasPerk(PerkLib.WispColonel)) mummyamplification += 0.5;
        }
		if (player.perkv2(PerkLib.MummyLord) > 0) mummyamplification *= 2;
        mummyDamage *= mummyamplification;

		return Math.round(mummyDamage);
	}

    override public function doEffect(display:Boolean = true):void {
    	var damage:Number = calcDamage(monster);

		//Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        var critChanceMulti:int = 1.75;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
            damage *= critChanceMulti;
        }

		damage = Math.round(damage);

		if (display) outputText("\n\nYour mummy servants swarm, punch and bite at [themonster] trying to immobilize it so they can feast on [monster his] energy. ");
		doPhysicalDamage(damage, true, display);
		if (display) {
			if (crit) outputText(" <b>Critical! </b>");
			outputText("\n\n");
		}
    }
}
}