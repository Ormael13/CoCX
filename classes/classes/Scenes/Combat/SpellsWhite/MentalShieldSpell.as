package classes.Scenes.Combat.SpellsWhite {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.StatusEffects;

public class MentalShieldSpell extends AbstractWhiteSpell{
	public function MentalShieldSpell() {
		super(
			"Mental Shield",
			"Protects against lust effects for 10 rounds, halving the damage.  ",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 300;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsMentalShield)
	}
	
	override public function get description():String {
		return "Protects against lust effects for "+calcDuration()+" rounds, halving the damage.  "
	}
	
	override public function calcCooldown():int {
		var calcC:int = 7;
		calcC += spellGenericCooldown();
		return calcC;
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.MentalShield);
	}
	
	override public function calcDuration():int {
		var mentalshieldduration:Number = 10;
		if (player.hasPerk(PerkLib.DefensiveStaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType())) mentalshieldduration *= 1.2;
		return Math.round(mentalshieldduration);
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv1(StatusEffects.MentalShield) <= 0) {
			player.removeStatusEffect(StatusEffects.MentalShield);
		} else {
			player.addStatusValue(StatusEffects.MentalShield, 1, -1);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You draw on your inner calm, forcing it out in the form of a powerful magical ward to weaken the effect of your opponent’s depraved attacks on you.");
		}
		player.createStatusEffect(StatusEffects.MentalShield,calcDuration(),0,0,0);
	}
}
}
