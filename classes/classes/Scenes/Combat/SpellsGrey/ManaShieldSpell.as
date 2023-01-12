package classes.Scenes.Combat.SpellsGrey {
import classes.Scenes.Combat.AbstractGreySpell;
import classes.StatusEffects;

public class ManaShieldSpell extends AbstractGreySpell {
	public function ManaShieldSpell() {
		super(
			"Mana Shield",
			"Drawing your own mana with help of lust and force of the willpower to form shield that can absorb attacks.  Despite been grey magic it still does carry the risk of backfiring and raising lust.",
			TARGET_SELF,
			TIMING_TOGGLE,
			[TAG_BUFF]
		);
	}
	
	override public function costDescription():Array {
		return super.costDescription().concat([
				"Mana Cost: 1 mana point per 1 point of damage blocked"
		]);
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsManaShield);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.ManaShield);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Deciding you need additional protection during current fight you spend a moment to concentrate and form a barrier made of mana around you.  It will block attacks as long as you have enough mana to sustain it.\n\n");
		}
		player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
	}
	
	override public function toggleOff(display:Boolean = true):void {
		if (display) {
			outputText("Deciding you no longer need to maintain your mana shield, you concentrate on deactivating it.\n\n");
		}
		player.removeStatusEffect(StatusEffects.ManaShield);
	}
}
}
