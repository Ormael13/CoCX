package classes.Scenes.Combat {
import classes.PerkLib;
import classes.StatusEffects;
import classes.lists.Gender;

public class AbstractBlackSpell extends AbstractSpell {
	public var canBackfire:Boolean = false;
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
		if (player.hasPerk(PerkLib.DivineKnowledge)) {
			return "Your chosen path of magic locked out this spell.";
		}
		
		return "";
	}
	
	// Hacky way to disable backfire. Don't forget to enable back!
	public var backfireEnabled:Boolean = true;
	override public function autocast():void {
		backfireEnabled = false;
		super.autocast();
		backfireEnabled = canBackfire;
	}
	
	public function calcBackfirePercent():int {
		if (!canBackfire) return 0;
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		return backfire
	}

	protected function backfireEffect(display:Boolean = true):void {
		if (display) {
			outputText("An errant sexual thought crosses your mind, and <b>you lose control of the spell!</b>  Your ");
			switch (player.gender) {
				case Gender.GENDER_NONE:
					outputText("[asshole] tingles with a desire to be filled as your libido spins out of control.");
					break;
				case Gender.GENDER_MALE:
					if (player.cockTotal() == 1) outputText("[cock] twitches obscenely and drips with pre-cum as your libido spins out of control.");
					else outputText("[cocks] twitch obscenely and drip with pre-cum as your libido spins out of control.");
					break;
				case Gender.GENDER_FEMALE:
					outputText("[vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it.");
					break;
				case Gender.GENDER_HERM:
					outputText("[vagina] and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
					break;
			}
		}
		dynStats("lib", .25, "lus", 15);
	}
	
	/**
	 * Do a backfire roll; if backfired, perform its effect
	 * @return true Spell backfired, do not proceed with effect
	 */
	protected function backfired(display:Boolean):Boolean {
		if (!backfireEnabled) return false;
		var backfire:int = calcBackfirePercent();
		if(rand(100) < backfire) {
			backfireEffect(display);
			return true;
		} else {
			return false;
		}
	}
}
}
