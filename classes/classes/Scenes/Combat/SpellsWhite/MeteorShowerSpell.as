package classes.Scenes.Combat.SpellsWhite {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class MeteorShowerSpell extends AbstractWhiteSpell{
	public function MeteorShowerSpell() {
		super(
			"Meteor Shower",
			"Call down a rain of meteors on your opponents, stunning them for 1 round and dealing area damage. Hits 12 times.\n<b>Req. 1 turn channeling. Cooldown: 12 turns.</b>",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING,TAG_FIRE,TAG_AOE, TAG_TIER3]
		);
		baseManaCost = 1250;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsMeteorShower);
	}
	
	override public function calcCooldown():int {
		return spellWhiteTier3Cooldown();
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (inDungeon || player.hasStatusEffect(StatusEffects.InsideSmallSpace)) {
			return "You can't use this spell inside small spaces. Unless you want get killed along with your enemies.";
		}
		if (player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
			return "You can't use this spell underwater.";
		}
		
		return "";
	}
	
	override public function setCooldown():void {
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			super.setCooldown();
		} else {
			/* we're channeling, don't renew cooldown */
		}
	}
	
	override public function useResources():void {
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			super.useResources();
		} else {
			/* we're channeling, don't use mana */
		}
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target,false, false)+ "(x12) fire damage."
	}
	
	public function calcDamage(target:Monster, randomize:Boolean=true, casting:Boolean = true):Number {
		var baseDamage:Number = scalingBonusIntelligence(randomize)*2;
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		return adjustSpellDamage(
				baseDamage,
				DamageType.FIRE,
				CAT_SPELL_WHITE,
				target,
                true,
                casting
		);
	}
	
	public function meteorShowerHit(display: Boolean = true):void {
		player.removeStatusEffect(StatusEffects.ChanneledAttack);
		player.removeStatusEffect(StatusEffects.ChanneledAttackType);
		if ((player.hasPerk(PerkLib.RagingInfernoSu) || player.hasPerk(PerkLib.RagingInfernoMastered)) && player.hasStatusEffect(StatusEffects.CounterRagingInferno)) player.addStatusValue(StatusEffects.CounterRagingInferno, 3, -1);
		calcDamage(monster, true, true);
		if (display) {
			outputText("You call out to the celestial vault, knocking some rocks out of orbit and into a crash course towards your opponents.\n\n");
			outputText("[monster A] [monster name] takes ")
		}
		var meteor:Number = 12;
		var totalDamage:Number = 0;
		while (meteor-->0){
			var damage:Number = calcDamage(monster, true, false);
			totalDamage += critAndRepeatDamage(false, damage, DamageType.FIRE, true);
		}
		if (display) {
			outputText(" damage!");
			outputText(" [Themonster] reels from the impact, trying to recover from this devastating assault as a meteor crash in the area.");
		}
		monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		checkAchievementDamage(totalDamage);
		combat.heroBaneProc(totalDamage);
	}
	
	public function meteorShowerChannel(display: Boolean = true):void {
		if (display) {
			outputText("You begin to channel magic, the sky reddening above you.");
		}
		player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
		player.createStatusEffect(StatusEffects.ChanneledAttackType, 6, 0, 0, 0);
		if (player.hasPerk(PerkLib.RagingInfernoSu) || player.hasPerk(PerkLib.RagingInfernoMastered)) player.addStatusValue(StatusEffects.CounterRagingInferno, 3, 1);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			meteorShowerHit(display);
		} else {
			meteorShowerChannel(display);
		}
	}
}
}
