package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractHexSpell extends AbstractSpell {
	public function AbstractHexSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_BLACK, tags);
	}
	
	override public function get category():int {
		return CAT_SPELL_HEX;
	}
	
	override public function manaCost():Number {
		return spellCostBlack(baseManaCost);
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.cor < 80 && !player.hasPerk(PerkLib.Equilibrium)) {
			return "Your corruption is too low to cast this spell.";
		}
		if (player.lust < combat.magic.getBlackMagicMinLust()) {
			return "You aren't turned on enough to use any hex magics.";
		}
		if (player.statusEffectv2(StatusEffects.Sealed) == 10) {
			return "Your ability to use hex magic was sealed."
		}
		
		return "";
	}
	
}
}
