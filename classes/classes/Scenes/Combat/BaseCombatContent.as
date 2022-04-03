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
	protected function doDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doDamage(damage, apply, display);
	}
	protected function doMagicDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doMagicDamage(damage, apply, display);
	}
	protected function doFireDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doFireDamage(damage, apply, display);
	}
	protected function doIceDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doIceDamage(damage, apply, display);
	}
	protected function doLightingDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doLightingDamage(damage, apply, display);
	}
	protected function doDarknessDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doDarknessDamage(damage, apply, display);
	}
	protected function doPoisonDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doPoisonDamage(damage, apply, display);
	}
	protected function doWindDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doWindDamage(damage, apply, display);
	}
	protected function doWaterDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doWaterDamage(damage, apply, display);
	}
	protected function doEarthDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doEarthDamage(damage, apply, display);
	}
	protected function doAcidDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doAcidDamage(damage, apply, display);
	}
	protected function doTrueDamage(damage:Number, apply:Boolean = true, display:Boolean = false):Number {
		return combat.doTrueDamage(damage, apply, display);
	}
	protected function combatMiss():Boolean {
		return combat.combatMiss();
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
	protected function spellCountWhiteBlack():Number {
		return player.spellCountWhiteBlack();
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
		return combat.soulskillCost();
	}
	protected function soulskillcostmulti():Number {
		return combat.soulskillcostmulti();
	}
	protected function soulskillMod():Number {
		return combat.soulskillMod();
	}
	protected function soulskillPhysicalMod():Number {
		return combat.soulskillPhysicalMod();
	}
	protected function soulskillMagicalMod():Number {
		return combat.soulskillMagicalMod();
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
	protected function scalingBonusIntelligence(randomize:Boolean = true):Number {
		return combat.scalingBonusIntelligence(randomize);
	}
	protected function scalingBonusIntelligenceCompanion(randomize:Boolean = true):Number {
		return combat.scalingBonusIntelligenceCompanion(randomize);
	}
	protected function scalingBonusWisdom(randomize:Boolean = true):Number {
		return combat.scalingBonusWisdom(randomize);
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
	protected function spellCost(mod:Number):Number {
		return combat.magic.spellCostImpl(mod);
	}
	protected function spellCostWhite(mod:Number):Number {
		return combat.magic.spellCostWhiteImpl(mod);
	}
	protected function spellCostBlack(mod:Number):Number {
		return combat.magic.spellCostBlackImpl(mod);
	}
	protected function spellCostGrey(mod:Number):Number {
		return combat.magic.spellCostGreyImpl(mod);
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
	protected function spellBlackCooldown():Number {
		return combat.magic.spellBlackCooldownImpl();
	}
	protected function spellBlackTier2Cooldown():Number {
		return combat.magic.spellBlackTier2CooldownImpl();
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
	protected function healMod():Number {
		return combat.magic.healModImpl();
	}
	protected function healModBlack():Number {
		return combat.magic.healModBlackImpl();
	}
	protected function healModWhite():Number {
		return combat.magic.healModWhiteImpl();
	}
	protected function calcInfernoMod(damage:Number, incCnt:Boolean):Number {
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
}
}
