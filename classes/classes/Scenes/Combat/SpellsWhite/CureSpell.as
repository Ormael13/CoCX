package classes.Scenes.Combat.SpellsWhite {
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.StatusEffectType;
import classes.StatusEffects;

public class CureSpell extends AbstractWhiteSpell{
	
	/**
	 * Spell completely removes these buffs
	 */
	public const CurableBuffs:/*String*/Array = [
		"LightningArrowStr",
		"LightningArrowSpe",
		"FireArrow",
		"IceArrow",
		"Illusion",
		"Fear",
		"CombatDebuffStr",
		"CombatDebuffSpe",
		"BasiliskGaze",
		"LightningArrow",
		"AkbalDebuff",
		"FrostGiantDebuff",
		"GnollSpearThrowerDebuff",
		"YoungFrostGiantDebuff",
		"PoisonedArrow",
		"MalikoreVenom",
		"ManticoreVenom",
		"Nightmare",
		"Entwine",
		"Poison"
	];
	
	/**
	 * Spell removes these status effects
	 */
	public const CurableEffects:/*StatusEffectType*/Array = [
		StatusEffects.BurnDoT,
		StatusEffects.AcidSlap,
		StatusEffects.DriderKiss,
		StatusEffects.AikoLightningArrow,
		StatusEffects.NagaVenom,
		StatusEffects.MedusaVenom,
		StatusEffects.DriderIncubusVenom,
		StatusEffects.Poison,
		StatusEffects.AcidDoT,
		StatusEffects.FrostburnDoT,
		StatusEffects.FrozenLung,
		StatusEffects.Blind,
	];
	
	public function CureSpell() {
		super(
			"Cure",
			"Negate all status ailments. Restore stat damaged by poison.",
			TARGET_SELF,
			TIMING_INSTANT,
			[TAG_RECOVERY]
		)
		baseManaCost = 500;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsCure);
	}
	
	override public function calcCooldown():int {
		var calcC:int = 4;
		calcC += spellGenericCooldown();
		return calcC;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You channel white magic to rid yourself of all negative effect affecting you.");
		}
		for each (var buff:String in CurableBuffs) {
			player.buff(buff).remove();
		}
		for each (var type:StatusEffectType in CurableEffects) {
			player.removeStatusEffect(type);
		}
		if (player.statStore.hasBuff("Weakened") || player.statStore.hasBuff("Drained")) {
			for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]) {
				player.removeCurse(stat, 6,1);
				player.removeCurse(stat, 3,2);
				if (stat != "sens") {
					player.removeCurse(stat+".mult", 0.06,1);
					player.removeCurse(stat+".mult", 0.03,2);
				}
			}
		}
	}
}
}
