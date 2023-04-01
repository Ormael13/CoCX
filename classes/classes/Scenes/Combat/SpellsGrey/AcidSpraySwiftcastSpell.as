package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class AcidSpraySwiftcastSpell extends AbstractGreySpell {
	
	public function AcidSpraySwiftcastSpell() 
	{
		super(
			"Acid Spray (S)",
			"Condense part of the ambient moisture into acid droplets to attack your enemy.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_ACID, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsAcidSpray) &&
				player.hasPerk(PerkLib.SwiftCasting);
	}
	
	override public function calcCooldown():int {
		return 0;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 0.4 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.ACID, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Your magic spreads out into the air, your mana focusing into a swirling, burning fluid. Beads of this sickly green liquid spill from your fingertips into the air, and you swipe your hands in front of you, leaving a line of fluid in the air. You push your palms forward, sending the acid droplets towards your foe in a sickly spray.\n");
			outputText("[Themonster] is covered in the burning fluids, and they flail, the acidic liquid clinging to them.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.ACID);
		if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
			monster.addStatusValue(StatusEffects.AcidDoT,1,1);
			monster.addStatusValue(StatusEffects.AcidDoT,3,0.1);
		}
		else monster.createStatusEffect(StatusEffects.AcidDoT,2,0.01,0.1,0);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}