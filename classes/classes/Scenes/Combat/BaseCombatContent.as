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
	protected function takeDamage(damage:Number, display:Boolean = false):Number {
		return combat.takeDamage(damage, display);
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
	protected function strenghtscalingbonus():Number {
		return combat.strenghtscalingbonus();
	}
	protected function toughnessscalingbonus():Number {
		return combat.toughnessscalingbonus();
	}
	protected function speedscalingbonus():Number {
		return combat.speedscalingbonus();
	}
	protected function inteligencescalingbonus():Number {
		return combat.inteligencescalingbonus();
	}
	protected function wisdomscalingbonus():Number {
		return combat.wisdomscalingbonus();
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
	protected function spellMod():Number {
		return combat.magic.spellModImpl();
	}
	protected function spellModBlack():Number {
		return combat.magic.spellModBlackImpl();
	}
	protected function spellModWhite():Number {
		return combat.magic.spellModWhiteImpl();
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
