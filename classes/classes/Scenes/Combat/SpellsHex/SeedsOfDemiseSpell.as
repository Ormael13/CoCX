package classes.Scenes.Combat.SpellsHex {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractHexSpell;
import classes.Scenes.Combat.DamageType;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;

public class SeedsOfDemiseSpell extends AbstractHexSpell {
	public function SeedsOfDemiseSpell() {
		super(
			"Seeds of Demise",
			"Plant a latent curse in the victim after 3 rounds the curse flare causing half of all damage taken by the target since this hex was applied to be applied again.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DAMAGING, TAG_DARKNESS]
		);
		baseManaCost = 40;
		useManaType = Combat.USEMANA_BLACK;
		canBackfire  = true;
	}
	
	override public function get buttonName():String {
		return "Seeds of Demise";
	}
	
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" darkness damage after 3 rounds of planting the curse";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsSeedsOfDemise);
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.SeedsOfDemise);
	}
	
	override public function calcDuration():int {
		return 3;
	}
	
	override public function calcCooldown():int {
		return 12;
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.HP < hpCost()) {
			return "Your HP is too low to cast this spell. ";
		}
		
		return ""
	}
	
	override public function advance(display:Boolean):void {
		if (monster.statusEffectv1(StatusEffects.SeedsOfDemise) <= 0) {
			if (display) {
				outputText("Your latent curse flares up inflicting the cummulated suffering of all the past wounds it has taken since you sowed the seed of demise! ");
			}
			var seedsCurse:Number = 0;
			seedsCurse += monster.statusEffectv2(StatusEffects.SeedsOfDemise);
			combat.doPlayerDarknessDamage(seedsCurse, true, display);
			if (display) {
				outputText("\n\n");
			}
			monster.removeStatusEffect(StatusEffects.SeedsOfDemise);
		} else {
			monster.addStatusValue(StatusEffects.SeedsOfDemise, 1, -1);
		}
	}
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number {
		var baseDamage:Number = monster.statusEffectv2(StatusEffects.SeedsOfDemise);
		return adjustSpellDamage(baseDamage, DamageType.DARKNESS, CAT_SPELL_HEX, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You wave a latent curse into the air planting the seeds of demise into [themonster].\n");
		}
		monster.createStatusEffect(StatusEffects.SeedsOfDemise, calcDuration(), 0, 0, 0);
	}
}

}
