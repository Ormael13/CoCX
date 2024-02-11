package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.StatusEffects;

public class BlinkSpell extends AbstractBlackSpell {
	public function BlinkSpell() {
		super(
			"Blink",
			"The Blink spell draws upon your lust and uses it to fuel a temporary increase in moving speed. Some naturally quick mages seem like they can teleport, moving faster than the eye can track. It does carry the risk of backfiring and raising lust, like all black magic used on oneself. ",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 40;
		canBackfire  = true;
	}
	
	override public function manaCost():Number {
		return super.manaCost() * costMultiplier();
	}
	
	private function costMultiplier():Number {
		var spellBlinkMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellBlinkMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellBlinkMultiplier *= 2;
		if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) spellBlinkMultiplier *= 2;
		return spellBlinkMultiplier;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBlink)
	}
	
	override public function isActive():Boolean {
		return player.statStore.hasBuff("Blink");
	}
	
	override public function describeEffectVs(target:Monster):String {
		var boost:Number  = Math.round(calcBoost());
		var effect:String = "+" + boost + "% spe";
		effect += " for " + calcDuration() + " rounds"
		var backfire:int  = calcBackfirePercent();
		if (backfire > 0) {
			effect += "; " + backfire + "% backfire"
		}
		return effect;
	}
	
	/**
	 * In %
	 */
	public function calcBoost():Number {
		var BlinkBoostCap:Number = 2;
		if (player.hasPerk(PerkLib.SelfbuffsProficiency)) {
			var capB:Number = 1.3;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx)) capB += 0.7;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) capB *= 5;
			BlinkBoostCap *= capB;
		}
		BlinkBoostCap *= player.intStat.core.max;
		var BlinkBoost:Number    = player.intStat.core.value;
		//BlinkBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus / warock / inny związany z spells (maybe only when they have a perk from the prestige job: magus/warlock/another related to spells)
		if (BlinkBoost < 10) BlinkBoost = 10;
		BlinkBoost *= 1.2;
		if (player.hasPerk(PerkLib.JobEnchanter)) BlinkBoost *= 1.25;
		BlinkBoost *= spellModBlack();
		if (BlinkBoost > BlinkBoostCap) BlinkBoost = BlinkBoostCap;
		return Math.round(BlinkBoost);
	}
	
	override public function calcDuration():int {
		var BlinkDuration:Number = 5;
		BlinkDuration += combat.magic.perkRelatedDurationBoosting();
		return BlinkDuration;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Your blood rushes through you, heat spreading to every muscle in your body. You feel lighter, your muscles springing back faster than before.\n\n");
		}
		if (!backfired(display)) {
			var tempSpe:Number       = calcBoost();
			var BlinkDuration:Number = calcDuration();
			var oldHPratio:Number    = player.hp100 / 100;
			mainView.statsView.showStatUp('spe');
			player.buff("Blink").setStats({"spe.mult": tempSpe / 100}).combatTemporary(BlinkDuration);
			player.HP = oldHPratio * player.maxHP();
		}
	}
}
}
