package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.StatusEffects;

public class MightSpell extends AbstractBlackSpell {
	public function MightSpell() {
		super(
			"Might",
			"The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 50;
		canBackfire  = true;
	}
	
	override public function manaCost():Number {
		return super.manaCost() * costMultiplier();
	}
	
	private function costMultiplier():Number {
		var spellMightMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellMightMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellMightMultiplier *= 2;
		if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) spellMightMultiplier *= 2;
		return spellMightMultiplier;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsMight)
	}
	
	override public function isActive():Boolean {
		return player.statStore.hasBuff("Might");
	}
	
	override public function describeEffectVs(target:Monster):String {
		var boost:Number  = Math.round(calcBoost());
		var effect:String = "+" + boost + "% tou";
		if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
			effect += ", +" + Math.round(boost * 1.25) + "% int"
		} else {
			effect += "&str"
		}
		effect += " for " + calcDuration() + " rounds"
		var backfire:int = calcBackfirePercent();
		if (backfire > 0) {
			effect += "; " + backfire + "% backfire"
		}
		return effect;
	}
	
	/**
	 * In %
	 */
	public function calcBoost():Number {
		var MightBoostCap:Number = 1.5;
		if (player.hasPerk(PerkLib.SelfbuffsProficiency)) {
			var capB:Number = 1.3;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx)) capB += 0.7;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) capB *= 5;
			MightBoostCap *= capB;
		}
		MightBoostCap *= player.intStat.core.max;
		MightBoostCap            = Math.round(MightBoostCap);
		var MightBoost:Number    = player.intStat.core.value;
		//MightBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus / warock / inny związany z spells (maybe only when they have a perk from the prestige job: magus/warlock/another related to spells)
		if (MightBoost < 10) MightBoost = 10;
		if (player.hasPerk(PerkLib.JobEnchanter)) MightBoost *= 1.2;
		MightBoost *= spellModBlack();
		if (MightBoost > MightBoostCap) MightBoost = MightBoostCap;
		return Math.round(MightBoost);
	}
	
	override public function calcDuration():int {
		var MightDuration:Number = 5;
		MightDuration += combat.magic.perkRelatedDurationBoosting();
		return MightDuration;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
		}
		if (!backfired(display)) {
			if (display) {
				outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			}
			var MightBoost:Number    = calcBoost();
			var MightDuration:Number = calcDuration();
			var tempTou:Number       = MightBoost;
			var tempInt:Number       = 0;
			var tempStr:Number       = 0;
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) tempInt = Math.round(MightBoost * 1.25);
			else tempStr = MightBoost;
			var oldHPratio:Number = player.hp100 / 100;
			var buffValues:Object = {"tou.mult": tempTou / 100};
			if (tempInt > 0) buffValues["int.mult"] = tempInt / 100;
			if (tempStr > 0) buffValues["str.mult"] = tempStr / 100;
			player.buff("Might").setStats(buffValues).combatTemporary(MightDuration);
			player.HP = oldHPratio * player.maxHP();
		}
		
	}
}
}
