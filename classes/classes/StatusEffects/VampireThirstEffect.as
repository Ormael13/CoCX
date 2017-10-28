/**
 * Coded by aimozg on 28.10.2017.
 */
package classes.StatusEffects {
import classes.StatusEffectClass;
import classes.StatusEffectType;

public class VampireThirstEffect extends StatusEffectClass {
	public static const TYPE:StatusEffectType = register("Vampire Thirst", VampireThirstEffect);
	public function VampireThirstEffect() {
		super(TYPE);
	}
	
	public function drink(amount:Number=1):void {
		if (value1 < 30) {
			modSatiety(amount);
			if (value1 > 0) {
				modStacks(singleStackBoost * amount);
			}
		}
	}
	public function modSatiety(delta:Number):void {
		var oldValue1:Number = value1;
		value1 = boundFloat(-10, value1 + delta, 30);
		var change:Number = value1 - oldValue1;
	}
	public function modStacks(delta:Number):void {
		var oldValue2:Number = value2;
		value2 = boundFloat(0, value2 + delta, maxStacksBoost);
		var change:Number = value2 - oldValue2;
		host.dynStats("str", change*singleStackBoost,
				"spe", change*singleStackBoost,
				"int", change*singleStackBoost,
				"lib", change*singleStackBoost,
				"max", false,
				"scale", false);
	}
	
	public function get singleStackBoost():Number {
		return 2 + game.player.newGamePlusMod();
	}
	public function get maxStacksBoost():Number {
		return 60 + 30 * game.player.newGamePlusMod();
	}
	
	override public function onRemove():void {
		host.dynStats("str", -value2,
				"spe", -value2,
				"int", -value2,
				"lib", -value2,
				"max", false,
				"scale", false);
	}
}
}
