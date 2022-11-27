package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractBlackSpell extends AbstractSpell {
	public function AbstractBlackSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_BLACK, tags);
	}
	
	override public function get category():int {
		return CAT_SPELL_BLACK;
	}
	
	override public function manaCost():Number {
		return spellCostBlack(baseManaCost);
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.lust < combat.magic.getBlackMagicMinLust()) {
			return "You aren't turned on enough to use any black magics.";
		}
		if (player.hasPerk(PerkLib.DivineKnowledge) && !player.hasPerk(PerkLib.Equilibrium)) {
			return "Your chosen path of magic locked out this spell.";
		}
		if (player.statusEffectv2(StatusEffects.Sealed) == 10) {
			return "Your ability to use black magic was sealed."
		}
		
		return "";
	}
}
}
