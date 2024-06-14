package classes.Scenes.Combat.SpellsGrey {
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.CombatAbilities;
import classes.StatusEffects;

public class RestoreSpell extends AbstractGreySpell {
	public function RestoreSpell() {
		super(
			"Restore",
			"Heal for a decent amount of health and regenerate a little over time.  ",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_HEALING]
		);
		baseManaCost = 80;
		isLastResortApplicable = false;
		isBloodMagicApplicable = false;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsRestore);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.PlayerRegenerate);
	}
	
	override public function isStackable():Boolean {
		return true;
	}
	
	override public function calcCooldown():int {
		var calcC:int = 5;
		calcC += spellGenericCooldown();
		if (player.weapon == weapons.U_STAFF) calcC -= 2;
		return calcC;
	}
	
	override public function calcDuration():int {
		return 7;
	}
	
	override public function advance(display:Boolean):void {
		/* handled in Regenerate spell */
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (!backfired(display)) {
			if (display) {
				outputText("As you incant the spell, your wounds begin to close on their own. Your pain fades away, and as your bleeding stops, you're filled with a sense of relief...and energy. You're not out of this fight yet!");
			}
			CombatAbilities.Heal.doEffect(false);
			if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) player.addStatusValue(StatusEffects.PlayerRegenerate,1,calcDuration());
			else player.createStatusEffect(StatusEffects.PlayerRegenerate,calcDuration(),0,0,0);
		}
	}
}
}
