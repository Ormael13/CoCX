package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Areas.Mountain.WormMass;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.StatusEffects;
import classes.VaginaClass;

public class ArouseSpell extends AbstractBlackSpell {
	public function ArouseSpell() {
		super("Arouse",
			"The arouse spell draws on your own inner lust in order to enflame the enemy's passions.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG, TAG_TIER1]);
		baseManaCost = 20;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsArouse);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target, false, false)) + " lust damage"
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		return adjustLustDamage((scalingBonusIntelligence() * 0.75 + scalingBonusLibido() * 0.75), monster, CAT_SPELL_BLACK, randomize);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!\n");
			if (player.perkv1(PerkLib.ImpNobility) > 0) {
				outputText("  Your imp cohorts assist your spellcasting, adding their diagrams to your own.\n");
			}
		}
		if (monster is WormMass) {
			if (display) {
				outputText("The worms appear to be unaffected by your magic!\n\n");
			}
			return;
		} else if (monster.lustVuln == 0) {
			if (display) {
				outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			}
			return;
		}
		var lustDmg:Number = calcDamage(monster, true, true);
		if (display) {
			if (monster.lust100 < 30) outputText("[Themonster] squirms as the magic affects [monster him].  ");
			if (monster.lust100 >= 30 && monster.lust100 < 60) {
				if (monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
				else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
			}
			if (monster.lust100 >= 60) {
				outputText("[Themonster]'");
				if (!monster.plural) outputText("s");
				outputText(" eyes glaze over with desire for a moment.  ");
			}
			if (monster.cocks.length > 0) {
				if (monster.lust100 >= 60) outputText("You see [monster his] [monster cocks] dribble pre-cum.  ");
				if (monster.lust100 >= 30 && monster.lust100 < 60) {
					if (monster.cocks.length == 1) {
						outputText("[Themonster]'s [monster cockshort] hardens, distracting [monster him] further.");
					} else {
						outputText("You see [monster his] [monster cocks] harden uncomfortably.  ");
					}
				}
			}
			if (monster.vaginas.length > 0 && monster.lust100 >= 60) {
				if (monster.plural) {
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("[Themonster]'s [monster vagina]s dampen perceptibly.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("[Themonster]'s crotches become sticky with girl-lust.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("[Themonster]'s [monster vagina]s become sloppy and wet.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of [themonster]'s thighs.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText("[Themonster]'s [monster vagina]s instantly soak [monster him] groin.");
				} else {
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText("[Themonster]'s [monster vagina] dampens perceptibly.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText("[Themonster]'s crotch becomes sticky with girl-lust.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText("[Themonster]'s [monster vagina] becomes sloppy and wet.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of [themonster]'s thighs.");
					if (monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText("[Themonster]'s [monster vagina] instantly soaks her groin.");
				}
			}
		}
		
		var resultArray:Array = critAndRepeatLust(display, lustDmg, CAT_SPELL_BLACK);
		postLustSpellEffect(resultArray[1]);
	}
}
}
