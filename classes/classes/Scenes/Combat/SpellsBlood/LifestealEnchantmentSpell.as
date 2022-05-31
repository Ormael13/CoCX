package classes.Scenes.Combat.SpellsBlood {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LifestealEnchantmentSpell extends AbstractBloodSpell {
	public function LifestealEnchantmentSpell() {
		super(
			"Lifesteal Enchantment",
			"Lifesteal Enchantment will add lifesteal effect to your weapons.  ",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseHpCost = 500;
	}
	
	override public function get buttonName():String {
		return "LifestealEnch";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "Duration: "+numberOfThings(calcDuration(),"round");
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLifestealEnchantment);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.LifestealEnchantment);
	}
	
	public function calcDuration():int {
		return 5;
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv1(StatusEffects.LifestealEnchantment) <= 0) player.removeStatusEffect(StatusEffects.LifestealEnchantment);
		else player.addStatusValue(StatusEffects.LifestealEnchantment, 1, -1);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather around weapons, adding a crimson glow.");
		}
		player.createStatusEffect(StatusEffects.LifestealEnchantment,calcDuration(),0,0,0);
	}
}
}
