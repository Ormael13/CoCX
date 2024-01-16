package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.NPCs.Diva;
import classes.StatusEffects;

public class WhitefireSwiftcastSpell extends AbstractWhiteSpell {
	
	public function WhitefireSwiftcastSpell() 
	{
		super(
			"Whitefire (S)",
			"Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_FIRE, TAG_TIER1]
		);
		baseManaCost = 8;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsWhitefire) &&
				player.hasPerk(PerkLib.SwiftCasting);
	}
	
	override public function calcCooldown():int {
		return 0;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number {
		var baseDamage:Number = 0.4 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (player.armorName == "FrancescaCloak") baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.FIRE, CAT_SPELL_WHITE, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
			if (display) {
				outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			}
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
		} else {
			if (display) {
				outputText("You narrow your eyes, focusing your mana into your thumb and middle finger.  You let the heat build, flowing from your mind and down your arm, until you raise your hand. You snap your fingers, releasing your power and the heat in an instant. [themonster] is enveloped in a flash of white flames.\n");
			}
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.FIRE);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

}
}