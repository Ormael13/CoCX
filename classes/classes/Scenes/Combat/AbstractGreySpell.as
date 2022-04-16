package classes.Scenes.Combat {
import classes.PerkLib;

public class AbstractGreySpell extends AbstractSpell {
	
	function AbstractGreySpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, Combat.USEMANA_GREY, tags);
	}
	
	override public function get category():int {
		return CAT_SPELL_GREY;
	}
	
	override public function manaCost():Number {
		return spellCostGrey(baseManaCost);
	}
	
	override protected function usabilityCheck():String {
		var uc:String =  super.usabilityCheck();
		if (uc) return uc;
		
		var threshold:Number = 50;
		if (!(
				player.hasPerk(PerkLib.GrandGreyArchmage) ||
				(threshold <= player.lust && player.lust <= player.maxLust() - threshold)
		)){
			return "You can't use any grey magics."
		}
		
		return "";
	}
	
	
}
}
