package classes.Scenes.Combat.SpellsHex {
import classes.EngineCore;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractHexSpell;
import classes.StatusEffects;

public class LifetapSpell extends AbstractHexSpell {
	public function LifetapSpell() {
		super(
			"Lifetap",
			"Sacrifice a quarter of your hp to recover a quarter of your mana.",
			TARGET_SELF,
			TIMING_INSTANT,
			[TAG_RECOVERY]
		);
		isBloodMagicApplicable = false;
		isLastResortApplicable = false;
		canBackfire            = true;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "" + numberFormat(hpCost()) + " HP to mana; " + calcBackfirePercent() + "% backfire"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLifetap);
	}
	
	public override function hpCost():Number {
		return Math.round(player.maxHP() * .25);
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.HP < hpCost()) {
			return "Your HP is too low to cast this spell. ";
		}
		
		return ""
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (!backfired(display)) {
			if (display) {
				outputText("You proceed to cut your hand and draw a small pattern. You feel your magical reservoirs fill back up by a significant amount.");
			}
			var recmana:Number = 0.25;
			if (player.hasPerk(PerkLib.Necromancy)) recmana += 0.125;
			HPChange(-Math.round(player.maxHP() * 0.25), false);
			EngineCore.ManaChange(Math.round(player.maxMana() * recmana));
		}
	}
}
}