package classes.Scenes.Combat.SpellsGrey {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.StatusEffects;

public class BalanceOfLifeSpell extends AbstractGreySpell {
	public function BalanceOfLifeSpell() {
		super(
			"Balance of Life",
			"Heals for 5% of your hp when dealing spell damage.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_HEALING,TAG_BUFF]
		);
		baseManaCost = 500;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return ""+numberOfThings(calcDuration(),"round");
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBalanceOfLife);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.BalanceOfLife);
	}
	
	override public function calcCooldown():int {
		var calcC:int = 5;
		calcC += spellGenericCooldown();
		if (player.weapon == weapons.U_STAFF) calcC -= 2;
		return calcC;
	}
	
	override public function calcDuration():int {
		var duration:Number = 4;
		if (player.hasPerk(PerkLib.DefensiveStaffChanneling) && (player.weapon.isStaffType() || player.weaponOff.isStaffType() || player.weapon.isWandType() || player.weaponOff.isWandType())) duration *= 1.2;
		return Math.round(duration);
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv1(StatusEffects.BalanceOfLife) <= 0) {
			player.removeStatusEffect(StatusEffects.BalanceOfLife);
		} else {
			player.addStatusValue(StatusEffects.BalanceOfLife, 1, -1);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (!backfired(display)) {
			if (display) {
				outputText("A red aura envelop you as you begin converting some of your destructive magic to healing.");
			}
			player.createStatusEffect(StatusEffects.BalanceOfLife,calcDuration(),0,0,0);
		}
	}
}
}
