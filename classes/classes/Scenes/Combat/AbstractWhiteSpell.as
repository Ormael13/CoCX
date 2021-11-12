package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractWhiteSpell extends AbstractSpell {
	
	function AbstractWhiteSpell(name:String, desc:String, targetType:int) {
		super(name, desc, targetType, Combat.USEMANA_WHITE);
	}
	
	override public function manaCost():Number {
		return spellCostWhite(baseManaCost);
	}
	
	override protected function usabilityCheck():String {
		var uc:String =  super.usabilityCheck();
		if (uc) return uc;
		if (player.lust >= combat.magic.getWhiteMagicLustCap()) {
			return "You are far too aroused to focus on white magic.";
		}
		if (player.hasPerk(PerkLib.HexKnowledge)) {
			return "Your chosen path of magic locked out this spell.";
		}
		if (player.statusEffectv2(StatusEffects.Sealed) == 10) {
			return "Your ability to use white magic was sealed."
		}
		return "";
	}
	
	
	override protected function useResources():void {
	
	}
	
}
}
