package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractBloodSpell extends AbstractSpell {
	protected var inflictBleed:Boolean = true;
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
			return "You cannot use blood spells if you don't have blood at all.";
		}
		if (player.HP - player.minHP() - 1 < hpCost()) {
			return "Your hp is too low to cast this spell."
		}
		
		return "";
	}

	override protected function postSpellEffect(display:Boolean = true):void {
		super.postSpellEffect(display);
		endTurnByBloodSkillUse(display);
	}

	protected function endTurnByBloodSkillUse(display:Boolean = true):void {
		var chance:Number = 20;
		if (player.hasPerk(PerkLib.WayOfTheBlood)) chance += (5 * player.progressBloodDemon());
		if (rand(100) < chance && inflictBleed && !monster.isImmuneToBleed()) {
			var magn:Number = 0.05;
			if (player.hasPerk(PerkLib.WayOfTheBlood)) chance += (0.02 * player.progressBloodDemon());
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else monster.createStatusEffect(StatusEffects.Hemorrhage, 2, magn, 0, 0);
			if (display) outputText(" The attack leaves many bloody gashes.");
		}
		if (display) outputText("\n\n");
	}   
}
}
