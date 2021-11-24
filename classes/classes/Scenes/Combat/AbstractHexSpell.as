package classes.Scenes.Combat {
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
		
		if (player.lust < combat.magic.getBlackMagicMinLust()) {
			return "You aren't turned on enough to use any hex magics.";
		}
		if (player.cor < 80) {
			return "Your corruption is too low to cast this spell.";
		}
		
		return "";
	}
	
}
}
