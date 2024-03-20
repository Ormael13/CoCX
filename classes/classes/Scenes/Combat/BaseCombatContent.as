/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.BaseContent;

public class BaseCombatContent extends BaseContent {
	public function BaseCombatContent() {
	}
	// ====================
	// COMBAT FLOW
	// ====================
	protected function get inCombat():Boolean {
		return combat.inCombat;
	}
	protected function get combatRound():int {
		return combat.combatRound;
	}
	protected function combatMenu(newRound:Boolean = true):void {
		combat.combatMenu(newRound);
	}
	// Returns true if combat is over. Setups doNext to win/loss/combat menu
	protected function combatIsOver():Boolean {
		return combat.combatIsOver();
	}
	protected function combatRoundOver():void
	{
		combat.combatRoundOver();
	}
	protected function endHpVictory():void {
		combat.endHpVictory();
	}
	protected function endLustVictory():void {
		combat.endLustVictory();
	}
	protected function endHpLoss():void {
		combat.endHpLoss();
	}
	protected function endLustLoss():void {
		combat.endLustLoss();
	}
	// ==================
	// APPLY EFFECTS
	// ==================
	protected function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doDamage(damage, apply, display, ignoreDR);
	}
	protected function doPhysicalDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doPhysicalDamage(damage, apply, display, ignoreDR);
	}
	protected function doMinionPhysDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doMinionPhysDamage(damage, apply, display, ignoreDR);
	}
	protected function doMagicDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doMagicDamage(damage, apply, display, ignoreDR);
	}
	protected function doFireDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doFireDamage(damage, apply, display, ignoreDR);
	}
	protected function doIceDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doIceDamage(damage, apply, display, ignoreDR);
	}
	protected function doLightningDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doLightningDamage(damage, apply, display, ignoreDR);
	}
	protected function doDarknessDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doDarknessDamage(damage, apply, display, ignoreDR);
	}
	protected function doPoisonDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doPoisonDamage(damage, apply, display, ignoreDR);
	}
	protected function doWindDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doWindDamage(damage, apply, display, ignoreDR);
	}
	protected function doWaterDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doWaterDamage(damage, apply, display, ignoreDR);
	}
	protected function doEarthDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doEarthDamage(damage, apply, display, ignoreDR);
	}
	protected function doAcidDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doAcidDamage(damage, apply, display, ignoreDR);
	}
	protected function doPlasmaDamage(damage:Number, apply:Boolean = true, display:Boolean = false, ignoreDR:Boolean = false):Number {
		return combat.doPlasmaDamage(damage, apply, display, ignoreDR);
	}
	protected function doTrueDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doTrueDamage(damage, apply, display);
	}
	protected function combatParry():Boolean {
		return combat.combatParry();
	}
	protected function combatParry2():Number {
		return combat.combatParry2();
	}
	protected function combatPhysicalCritical():Number {
		return combat.combatPhysicalCritical();
	}
	protected function combatMagicalCritical():Number {
		return combat.combatMagicalCritical();
	}
	protected function combatBlock(doFatigue:Boolean = false):Boolean {
		return combat.combatBlock(doFatigue);
	}
	protected function combatBlock2():Number {
		return combat.combatBlock2();
	}
	protected function unarmedAttack():Number {
		return combat.unarmedAttack();
	}
	protected function ghostStrength():Number {
		return combat.ghostStrength();
	}
	protected function ghostSpeed():Number {
		return combat.ghostSpeed();
	}
	protected function ghostToughness():Number {
		return combat.ghostToughness();
	}
	// =================
	// CHECKS
	// =================
	protected function hasSpells():Boolean {
	return player.hasSpells();
	}
	protected function spellCount():Number {
		return player.spellCount();
	}
	protected function spellPerkUnlock():void {
		combat.spellPerkUnlock();
	}
	protected function bowPerkUnlock():void {
		combat.bowPerkUnlock();
	}
	protected function checkAchievementDamage(damage:Number):void {
		combat.checkAchievementDamage(damage);
	}
	protected function isPlayerBound():Boolean {
		return combat.isPlayerBound();
	}
	protected function isPlayerSilenced():Boolean {
		return combat.isPlayerSilenced();
	}
	protected function isPlayerStunned():Boolean {
		return combat.isPlayerStunned();
	}
	protected function isPlayerPowerStunned():Boolean {
		return combat.isPlayerPowerStunned();
	}
	protected function isPlayerFeared():Boolean {
		return combat.isPlayerFeared();
	}
	// =================
	// MODIFIERS
	// =================
	protected function physicalCost(mod:Number):Number {
		return combat.physicalCost(mod);
	}
	protected function bowCost(mod:Number):Number {
		return combat.bowCost(mod);
	}
	protected function soulskillCost():Number {
		return combat.soulskills.soulskillCostImpl();
	}
	protected function soulskillcostmulti():Number {
		return combat.soulskills.soulskillcostmultiImpl();
	}
	protected function soulskillMod():Number {
		return combat.soulskills.soulskillModImpl();
	}
	protected function soulskillPhysicalMod():Number {
		return combat.soulskills.soulskillPhysicalModImpl();
	}
	protected function soulskillMagicalMod():Number {
		return combat.soulskills.soulskillMagicalModImpl();
	}
	protected function soulskillCooldown(duration:int = 2, physical:Boolean = true):Number {
		return combat.soulskills.soulskillCooldownImpl(duration, physical);
	}
	protected function soulskillTier2Cooldown(duration:int = 4, physical:Boolean = true):Number {
		return combat.soulskills.soulskillTier2CooldownImpl(duration, physical);
	}
	protected function soulskillTier3Cooldown(duration:int = 10, physical:Boolean = true):Number {
		return combat.soulskills.soulskillTier3CooldownImpl(duration, physical);
	}
	protected function scalingBonusStrength(randomize:Boolean = true):Number {
		return combat.scalingBonusStrength(randomize);
	}
	protected function scalingBonusStrengthCompanion(randomize:Boolean = true):Number {
		return combat.scalingBonusStrengthCompanion(randomize);
	}
	protected function scalingBonusToughness(randomize:Boolean = true):Number {
		return combat.scalingBonusToughness(randomize);
	}
	protected function scalingBonusToughnessCompanion(randomize:Boolean = true):Number {
		return combat.scalingBonusToughnessCompanion(randomize);
	}
	protected function scalingBonusSpeed(randomize:Boolean = true):Number {
		return combat.scalingBonusSpeed(randomize);
	}
	public function scalingBonusIntelligence(randomize:Boolean = true):Number {
		return combat.scalingBonusIntelligence(randomize);
	}
	protected function scalingBonusIntelligenceCompanion(randomize:Boolean = true):Number {
		return combat.scalingBonusIntelligenceCompanion(randomize);
	}
	protected function scalingBonusWisdom(randomize:Boolean = true):Number {
		return combat.scalingBonusWisdom(randomize);
	}
	protected function scalingBonusWisdomCompanion(randomize:Boolean = true):Number {
		return combat.scalingBonusWisdomCompanion(randomize);
	}
	protected function scalingBonusLibido(randomize:Boolean = true):Number {
		return combat.scalingBonusLibido(randomize);
	}
	protected function meleePhysicalForce():Number {
		return combat.meleePhysicalForce();
	}
	protected function rangePhysicalForce():Number {
		return combat.rangePhysicalForce();
	}
	protected function firearmsForce():Number {
		return combat.firearmsForce();
	}
	protected function spellCost(mod:Number):Number {
		return combat.magic.spellCostImpl(mod);
	}
	public function spellCostWhite(mod:Number):Number {
		return combat.magic.spellCostWhiteImpl(mod);
	}
	protected function spellCostBlack(mod:Number):Number {
		return combat.magic.spellCostBlackImpl(mod);
	}
	protected function spellCostGrey(mod:Number):Number {
		return combat.magic.spellCostGreyImpl(mod);
	}
	public function spellCostGreen(mod:Number):Number {
		return combat.magic.spellCostGreenImpl(mod);
	}
	protected function healCost(mod:Number):Number {
		return combat.magic.healCostImpl(mod);
	}
	protected function healCostWhite(mod:Number):Number {
		return combat.magic.healCostWhiteImpl(mod);
	}
	protected function healCostBlack(mod:Number):Number {
		return combat.magic.healCostBlackImpl(mod);
	}
	protected function spellCostBlood(mod:Number):Number {
		return combat.magic.spellCostBloodImpl(mod);
	}
	protected function spellMod():Number {
		return combat.magic.spellModImpl();
	}
	protected function spellModBlack():Number {
		return combat.magic.spellModBlackImpl();
	}
	protected function spellModWhite():Number {
		return combat.magic.spellModWhiteImpl();
	}
	protected function spellModGrey():Number {
		return combat.magic.spellModGreyImpl();
	}
	protected function spellModBlood():Number {
		return combat.magic.spellModBloodImpl();
	}
	protected function spellModGreen():Number {
		return combat.magic.spellModGreenImpl();
	}
	protected function spellBlackCooldown():Number {
		return combat.magic.spellBlackCooldownImpl();
	}
	protected function spellBlackTier2Cooldown():Number {
		return combat.magic.spellBlackTier2CooldownImpl();
	}
	protected function spellBlackTier3Cooldown():Number {
		return combat.magic.spellBlackTier3CooldownImpl();
	}
	protected function spellGreyCooldown():Number {
		return combat.magic.spellGreyCooldownImpl();
	}
	protected function spellGreyTier2Cooldown():Number {
		return combat.magic.spellGreyTier2CooldownImpl();
	}
	protected function spellWhiteCooldown():Number {
		return combat.magic.spellWhiteCooldownImpl();
	}
	protected function spellWhiteTier2Cooldown():Number {
		return combat.magic.spellWhiteTier2CooldownImpl();
	}
	protected function spellWhiteTier3Cooldown():Number {
		return combat.magic.spellWhiteTier3CooldownImpl();
	}
	protected function spellGenericCooldown():Number {
		return combat.magic.spellGenericCooldownImpl();
	}
	protected function healMod():Number {
		return combat.magic.healModImpl();
	}
	protected function healModBlack():Number {
		return combat.magic.healModBlackImpl();
	}
	protected function healModWhite():Number {
		return combat.magic.healModWhiteImpl();
	}
	public function calcInfernoMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcInfernoModImpl(damage, incCnt);
	}
	protected function calcGlacialMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcGlacialModImpl(damage, incCnt);
	}
	protected function calcVoltageMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcVoltageModImpl(damage, incCnt);
	}
	protected function calcEclypseMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcEclypseModImpl(damage, incCnt);
	}
	protected function calcTideMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcTideModImpl(damage, incCnt);
	}
	protected function calcQuakeMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcQuakeModImpl(damage, incCnt);
	}
	protected function calcGaleMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcGaleModImpl(damage, incCnt);
	}
	protected function calcCorrosionMod(damage:Number, incCnt:Boolean):Number {
		return combat.magic.calcCorrosionModImpl(damage, incCnt);
	}

	protected function maintainInfernoMod():void {
        combat.magic.maintainInfernoModImpl();
	}

    protected function maintainGlacialMod():void {
        combat.magic.maintainGlacialModImpl();
	}

    protected function maintainVoltageMod():void {
        combat.magic.maintainVoltageModImpl();
	}

    protected function maintainEclypseMod():void {
        combat.magic.maintainEclypseModImpl();
    }

    protected function maintainTideMod():void {
        combat.magic.maintainTideModImpl();
    }

	protected function maintainQuakeMod():void {
        combat.magic.maintainQuakeModImpl();
    }

	protected function maintainGaleMod():void {
        combat.magic.maintainGaleModImpl();
    }

	protected function maintainCorrosionMod():void {
        combat.magic.maintainCorrosionModImpl();
    }
}
}
