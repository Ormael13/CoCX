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
        modSatiety(amount);
    }
    public function modSatiety(delta:Number):void {
        var oldBoost:Number = currentBoost;
        value1 = boundFloat(-10, value1 + delta, 30);
        var change:Number = currentBoost - oldBoost;
        
        host.dynStats("str", change,
                "spe", change,
                "int", change,
                "lib", change,
                "max", false,
                "scale", false);
    }
	
	public function get currentBoost():int {
        if (value1 <= 0) return 0;
        return value1*singleStackBoost;
    }
    public function get singleStackBoost():Number {
        return 2 + game.player.newGamePlusMod();
    }
    
    override public function onRemove():void {
        host.dynStats("str", -currentBoost,
                "spe", -currentBoost,
                "int", -currentBoost,
                "lib", -currentBoost,
                "max", false,
                "scale", false);
    }
}
}
