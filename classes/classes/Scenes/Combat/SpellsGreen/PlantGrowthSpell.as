package classes.Scenes.Combat.SpellsGreen {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;
import classes.CoC;

public class PlantGrowthSpell extends AbstractGreenSpell {
	public function PlantGrowthSpell() {
		super("Plant Growth",
			"Grow plants around the caster.",
			TARGET_SELF,
			TIMING_INSTANT,
			[TAG_BUFF]);
		baseManaCost = 50;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsPlantGrowth) && (!CoC.instance.inCombat || !combat.isNearPlants());
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "Allows the use of Green Magic spells";
	}
	
	override public function calcCooldown():int {
		return (1+spellWhiteCooldown());
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) outputText("You focus your energy on the world around you, causing vegetation to surge out of the ground at an accelerated rate into a verdant patch of vines and other tentacle greenery.\n");
		player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
	}
}
}
