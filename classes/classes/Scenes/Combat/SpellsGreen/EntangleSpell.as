package classes.Scenes.Combat.SpellsGreen {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;

public class EntangleSpell extends AbstractGreenSpell {
	public function EntangleSpell() {
		super("Entangle",
			"Entangle your opponent with vines. Does not hinder other elven spellcasting.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DEBUFF, TAG_TIER2]);
		baseManaCost = 100;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsEntangle);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "Constricts the enemy with vines";
	}
	
	override public function calcCooldown():int {
		return spellWhiteTier2Cooldown();
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (!combat.isNearPlants()) {
			return "Entangle require to have plants nearby.";
		}
		
		return "";
	}
	
	override public function isActive():Boolean {
		return monster.statusEffectv1(StatusEffects.EntangledBySpell) > 0;
	}
	
	override public function calcDuration():int {
		var dura:Number = 6;
		if (player.hasPerk(PerkLib.GreenMagic)) dura *= 2;
		return dura;
	}
	
	override public function advance(display:Boolean):void {
		if (monster.hasStatusEffect(StatusEffects.EntangledBySpell)) {
			if (monster.statusEffectv1(StatusEffects.EntangledBySpell) <= 0) {
				monster.removeStatusEffect(StatusEffects.EntangledBySpell);
				if (monster.hasStatusEffect(StatusEffects.Entangled)) monster.removeStatusEffect(StatusEffects.Entangled);
				if (display) outputText("<b>Entangled effect wore off!</b>\n\n");
			} else {
				monster.addStatusValue(StatusEffects.EntangledBySpell, 1, -1);
				if (rand(2) == 0 && !monster.hasStatusEffect(StatusEffects.Entangled)) monster.createStatusEffect(StatusEffects.Entangled, 0, 0, 0, 0);
			}
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus your lust on the flora around you, causing them to surge with your emotions. Black vines slowly rise from the ground before quickly darting around [themonster].\n");
			if (40 + rand(player.inte) + rand(player.lib) > monster.spe) {
				outputText("The vines successfully wrap around [themonster], clutching onto [monster him] tightly as they squeeze and grope [monster his] body.\n");
				monster.createStatusEffect(StatusEffects.EntangledBySpell, calcDuration(), 0, 0, 0);
			}
			else outputText("[Themonster] successfully escapes from the entanglements, but the vines are relentless as they constantly whip around [monster him].\n");
		}
	}
}
}
