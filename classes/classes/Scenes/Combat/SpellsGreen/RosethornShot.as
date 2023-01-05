package classes.Scenes.Combat.SpellsGreen {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;

public class RosethornShot extends AbstractGreenSpell {
	public function RosethornShot() {
		super("Rosethorn",
			"As a wood elf your racial mastery of green magic allows you to transmute the wood of your arrows, growing poisonous thorns on the shaft as it flies toward its target. You may lace your shots with aphrodisiacs as if you had a racial venom and your arrows inflict bleed damage.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG]);
		baseManaCost = 10;
	}
	
	override public function get isKnown():Boolean {
		return player.hasPerk(PerkLib.ELFThornShot);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " lust poison damage and bleeding DoT"
	}
	
	override public function calcCooldown():int {
		return spellWhiteCooldown();
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.Rosethorn);
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		return "";
	}
	
	override public function advance(display:Boolean):void {
		if (player.hasStatusEffect(StatusEffects.Rosethorn)) {
			if (player.statusEffectv1(StatusEffects.Rosethorn) <= 0) {
				player.removeStatusEffect(StatusEffects.Rosethorn);
				if (display) outputText("<b>Rosethorn effect wore off!</b>\n\n");
			} else {
				player.addStatusValue(StatusEffects.Rosethorn, 1, -1);
			}
		}
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = (combat.teases.teaseBaseLustDamage() * 3 * spellModWhite());
		if (player.hasPerk(PerkLib.VegetalAffinity)) baseDamage *= 1.5;
		if (player.hasPerk(PerkLib.GreenMagic)) baseDamage *= 2;
		if (player.hasStatusEffect(StatusEffects.GreenCovenant)) baseDamage *= 2;
		if (player.armor == armors.ELFDRES && player.isElf()) baseDamage *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) baseDamage *= 2;
		return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate on the arrow shaft causing it to grow vicious thorns that tear through your opponent's flesh, delivering poison.");
			if (monster.lustVuln == 0) {
				if (display) {
					outputText("\nIt has no effect!  Your foe clearly does not experience lust in the same way as you.\n");
				}
				return;
			}
			monster.createStatusEffect(StatusEffects.Rosethorn, 6, 0, 0, 0);
			doSpellEffect2();
			outputText("\n");
		}
	}
	
	private function doSpellEffect2():void {
		var lustDmg:Number = calcDamage(monster, true, true);
		//Determine if critical tease!
		var crit:Boolean   = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg, false);
		if (crit) outputText(" <b>Critical!</b>");
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.VerdantLeech)) {
			if (monster.lustVuln != 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.01;
			HPChange(Math.round(player.maxHP() * 0.05), false);
		}
	}
}
}
