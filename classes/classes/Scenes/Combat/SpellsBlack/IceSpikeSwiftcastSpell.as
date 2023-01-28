package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class IceSpikeSwiftcastSpell extends AbstractBlackSpell {
	
	public function IceSpikeSwiftcastSpell() 
	{
		super(
			"Ice Spike (S)",
			"Drawing your own lust to concentrate it into chilling spike of ice that will attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_ICE, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsIceSpike) &&
				player.hasPerk(PerkLib.SwiftCasting);
	}
	
	override public function calcCooldown():int {
		return 0;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 0.4 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward [monster a] [monster name]!\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.ICE);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}