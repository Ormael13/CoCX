package classes.Scenes.Combat.SpellsGrey {
import classes.EngineCore;
import classes.Monster;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.StatusEffects;

public class EnergyDrainSpell extends AbstractGreySpell {
	public function EnergyDrainSpell() {
		super(
			"Energy Drain",
			"Fatigue the target (-20% damage for 7 rounds) and recover mana by draining the target's mana (up to 4x of spell cost).",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DEBUFF,TAG_RECOVERY]
		);
		baseManaCost = 350;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsEnergyDrain);
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.EnergyDrain);
	}
	
	override public function calcCooldown():int {
		var calcC:int = 4;
		calcC += spellGenericCooldown();
		return calcC;
	}
	
	override public function calcDuration():int {
		return 7;
	}
	
	public function calcMagnitude(target:Monster):Number {
		var energydrain:Number = monster.mana;
		energydrain = Math.min(monster.mana, manaCost()*5);
		return Math.round(energydrain);
	}
	
	
	override public function advance(display:Boolean):void {
		if (monster.hasStatusEffect(StatusEffects.EnergyDrain)) {
			if (monster.statusEffectv1(StatusEffects.EnergyDrain) <= 0) monster.removeStatusEffect(StatusEffects.EnergyDrain);
			else monster.addStatusValue(StatusEffects.EnergyDrain,1,-1);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (!backfired(display)) {
			if (display) {
				outputText("You point at [themonster] and with a sharp pulling gesture you rip out some of their vigor for your own use. They won’t be hitting at full strength for a while.");
			}
			var magnitude:Number = calcMagnitude(monster);
            if (magnitude > 0)
			    monster.createStatusEffect(StatusEffects.EnergyDrain, calcDuration(), 0, 0, 0);
			player.mana += magnitude;
			monster.mana -= magnitude;
		}
	}
}
}
