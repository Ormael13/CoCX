package classes.Scenes.Combat {
public class AbstractBloodSpell extends AbstractSpell {
	public function AbstractBloodSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_BLACK, tags);
	}
	
	public var baseHpCost:Number = 0;
	
	override public function get category():int {
		return CAT_SPELL_BLOOD;
	}
	
	override public function hpCost():Number {
		return spellCostBlood(baseHpCost);
	}
	
	override public function useResources():void {
		super.useResources();
		HPChange(-hpCost(), false);
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.isGargoyle()) {
			return "You cannot use blood spells if you not have blood at all.";
		}
		if (player.HP - player.minHP() - 1 < hpCost()) {
			return "Your hp is too low to cast this spell."
		}
		
		return "";
	}
}
}
