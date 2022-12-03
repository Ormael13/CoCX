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
			[TAG_LUSTDMG]);
		baseManaCost = 100;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsEntangle);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" lust damage for "+numberOfThings(calcDuration(),"round");
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = (combat.teases.teaseBaseLustDamage() * spellModWhite());
		if (player.hasPerk(PerkLib.VegetalAffinity)) baseDamage *= 1.5;
		if (player.hasPerk(PerkLib.GreenMagic)) baseDamage *= 2;
		return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
	}
	
	override public function calcCooldown():int {
		return spellWhiteTier2Cooldown();
	}
	
	override public function isActive():Boolean {
		return player.statusEffectv1(StatusEffects.Entangled) > 0;
	}
	
	public function calcDuration():int {
		var dura:Number = 6;
		if (player.hasPerk(PerkLib.GreenMagic)) dura *= 2;
		return dura;
	}
	
	override public function advance(display:Boolean):void {
		if (monster.hasStatusEffect(StatusEffects.Entangled)) {
			if (monster.statusEffectv1(StatusEffects.Entangled) <= 0) {
				monster.removeStatusEffect(StatusEffects.Entangled);
				if (display) outputText("<b>Entangled effect wore off!</b>\n\n");
			} else {
				monster.addStatusValue(StatusEffects.Entangled, 1, -1);
			}
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus your lust on the flora around you, causing them to surge with your emotions. Black vines slowly rise from the ground before quickly darting around [themonster].\n");
			if (40 + rand(player.inte) + rand(player.lib) > monster.spe) {
				outputText("The vines successfully wrap around [themonster], clutching onto [monster him] tightly as they squeeze and grope [monster his] body.\n");
				monster.createStatusEffect(StatusEffects.Entangled, calcDuration(), 0, 0, 0);
			}
			else outputText("[Themonster] successfully escapes from the entanglements, but the vines are relentless as they constantly whip around [monster him].\n");
		}
	}
}
}
