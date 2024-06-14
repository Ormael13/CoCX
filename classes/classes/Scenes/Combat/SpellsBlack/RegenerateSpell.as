package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Races;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.StatusEffects;

public class RegenerateSpell extends AbstractBlackSpell {
	public function RegenerateSpell() {
		super(
			"Regenerate",
			"Regenerate will attempt to trigger health recovery over time, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  ",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF, TAG_HEALING]
		);
		baseManaCost           = 50;
		canBackfire            = true;
		isLastResortApplicable = false;
		isBloodMagicApplicable = false;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsRegenerate)
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.PlayerRegenerate);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return ""+calcHeal()+" HP for "+calcDuration()+" rounds"
	}
	
	public function calcHeal():Number {
		var hpChange2:Number = player.inte;
		if (player.hasPerk(PerkLib.WisenedHealer)) hpChange2 += player.wis;
		hpChange2 *= healModBlack();
		if (player.isRace(Races.UNICORN, 2)) hpChange2 *= 3;
		if (player.isRace(Races.ALICORN)) hpChange2 *= 4;
		if (player.armor == armors.NURSECL) hpChange2 *= 1.2;
		if (player.weapon == weapons.U_STAFF) hpChange2 *= 1.5;
		if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25)) {
			if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1)) hpChange2 *= 2.5;
			else hpChange2 *= 1.5;
		}
		return Math.round(hpChange2);
	}
	
	override public function calcDuration():int {
		return 7;
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv1(StatusEffects.PlayerRegenerate) <= 0) {
			player.removeStatusEffect(StatusEffects.PlayerRegenerate);
			if (display) {
				outputText("<b>Regenerate effect wore off!</b>\n\n");
			}
		} else {
			player.addStatusValue(StatusEffects.PlayerRegenerate, 1, -1);
			if (player.hasStatusEffect(StatusEffects.CombatWounds)) {
				if (player.statusEffectv1(StatusEffects.CombatWounds) > 0.01) player.addStatusValue(StatusEffects.CombatWounds, 1, -0.01);
				else player.removeStatusEffect(StatusEffects.CombatWounds);
			}
			var hpChange2:Number = calcHeal();
			if (display) {
				outputText("<b>Regenerate healing power spreading in your body. ([font-heal]+" + hpChange2 + "[/font])</b>\n\n");
			}
			HPChange(hpChange2, false);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.");
		}
		if (!backfired(display)) {
			if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) player.addStatusValue(StatusEffects.PlayerRegenerate, 1, calcDuration());
			else player.createStatusEffect(StatusEffects.PlayerRegenerate, 7, 0, 0, 0);
			outputText(" This should hold up for about seven rounds.");
		}
		
	}
}
}
