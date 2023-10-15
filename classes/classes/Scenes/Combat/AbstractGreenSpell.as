package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractGreenSpell extends AbstractSpell {
	
	function AbstractGreenSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_WHITE, tags);
	}
	
	override public function get category():int {
		return CAT_SPELL_GREEN;
	}
	
	override public function manaCost():Number {
		return spellCostGreen(baseManaCost);
	}
	
	override protected function usabilityCheck():String {
		var uc:String =  super.usabilityCheck();
		if (uc) return uc;
		
		if (player.hasStatusEffect(StatusEffects.NoPlantsArea)) {
			return "Your can't use green magic in place where not plants exists or could grow."
		}
		if (player.statusEffectv2(StatusEffects.Sealed) == 10) {
			return "Your ability to use green magic was sealed."
		}
		
		return "";
	}
	
	
}
}
