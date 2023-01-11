package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LightningBoltSwiftcastSpell extends AbstractWhiteSpell {
	
	public function LightningBoltSwiftcastSpell() 
	{
		super(
			"Lightning Bolt (S)",
			"Lightning Bolt is a basic lightning attack that will electrocute your foe with a single bolt of lightning.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_LIGHTNING, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLightningBolt) &&
				player.hasPerk(PerkLib.SwiftCasting);
	}
	
	override public function calcCooldown():int {
		return 0;
	}
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 0.4*scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.LIGHTNING, CAT_SPELL_WHITE, monster, true, casting);
	}
	
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus your mana into your hand, and sparks form, sending pins and needles through your arm. The sharp tang of ozone fills the air, and you point your palm at [themonster] . Tendrils of electricity arc from your hand, striking [themonster] with lethal force.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}