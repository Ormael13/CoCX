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
	protected function combatMiss():Boolean {
		return combat.combatMiss();
	}
	protected function combatParry():Boolean {
		return combat.combatParry();
	}
	protected function combatCritical():Boolean {
		return combat.combatCritical();
	}
	protected function combatBlock(doFatigue:Boolean = false):Boolean {
		return combat.combatBlock(doFatigue);
	}
	protected function unarmedAttack():Number {
		return combat.unarmedAttack();
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
	protected function isWieldingRangedWeapon():Boolean {
		return combat.isWieldingRangedWeapon();
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
	protected function scalingBonusStrength():Number {
		return combat.scalingBonusStrength();
	}
	protected function scalingBonusToughness():Number {
		return combat.scalingBonusToughness();
	}
	protected function scalingBonusSpeed():Number {
		return combat.scalingBonusSpeed();
	}
	protected function scalingBonusIntelligence():Number {
		return combat.scalingBonusIntelligence();
	}
	protected function scalingBonusWisdom():Number {
		return combat.scalingBonusWisdom();
	}
	protected function scalingBonusLibido():Number {
		return combat.scalingBonusLibido();
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
	protected function healCost(mod:Number):Number {
		return combat.magic.healCostImpl(mod);
	}
	protected function healCostWhite(mod:Number):Number {
		return combat.magic.healCostWhiteImpl(mod);
	}
	protected function healCostBlack(mod:Number):Number {
		return combat.magic.healCostBlackImpl(mod);
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
	protected function healMod():Number {
		return combat.magic.healModImpl();
	}
	protected function healModBlack():Number {
		return combat.magic.healModBlackImpl();
	}
	protected function healModWhite():Number {
		return combat.magic.healModWhiteImpl();
	}
	protected function calcInfernoMod(damage:Number):int {
		return combat.magic.calcInfernoModImpl(damage);
	}
	protected function calcGlacialMod(damage:Number):int {
		return combat.magic.calcGlacialModImpl(damage);
	}
	protected function calcVoltageMod(damage:Number):int {
		return combat.magic.calcVoltageModImpl(damage);
	}
	protected function calcEclypseMod(damage:Number):int {
		return combat.magic.calcEclypseModImpl(damage);
	}
}
}
