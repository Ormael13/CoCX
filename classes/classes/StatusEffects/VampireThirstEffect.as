/**
 * Coded by aimozg on 28.10.2017.
 */
package classes.StatusEffects {
import classes.StatusEffectClass;
import classes.StatusEffectType;
import classes.PerkLib;

public class VampireThirstEffect extends StatusEffectClass {
	public static const TYPE:StatusEffectType = register("Vampire Thirst", VampireThirstEffect);
	public function VampireThirstEffect() {
		super(TYPE);
	}
	
	public function drink(amount:Number=1):void {
        modSatiety(amount);
    }
	public function maxThirst():Number {
		var maxThi:Number = 0;
		if (game.player.facePart.type == 34) maxThi += 30;
		if (game.player.hasPerk(PerkLib.VampiricBloodsteam)) maxThi += 15;
		if (game.player.hasPerk(PerkLib.VampiricBloodsteamEvolved) && game.player.vampireScore() >= 6) maxThi += 30;
		if (game.player.hasPerk(PerkLib.VampiricBloodsteamFinalForm) && game.player.vampireScore() >= 12) maxThi += 60;
		if (game.player.hasPerk(PerkLib.HollowFangs)) maxThi += 5;
		if (game.player.hasPerk(PerkLib.HollowFangsEvolved)) maxThi += 5;
		if (game.player.hasPerk(PerkLib.HollowFangsFinalForm)) maxThi += 5;
		return maxThi;
	}
    public function modSatiety(delta:Number):void {
        var oldBoost:Number = currentBoost;
        value1 = boundFloat(-10, value1 + delta, maxThirst());
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
        if (game.player.hasPerk(PerkLib.VampiricBloodsteamFinalForm)) return 3 + game.player.newGamePlusMod();
		else return 2 + game.player.newGamePlusMod();
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
