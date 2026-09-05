package classes.Scenes.Combat.SpellsWhite {
import classes.PerkLib;
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
		StatusEffects.ElectrocutionDoT,
		StatusEffects.NecrosisDoT,
	];
	
	public function curableDebuffs():Boolean {
		return (player.statStore.hasBuff("LightningArrowStr") || player.statStore.hasBuff("LightningArrowSpe") || player.statStore.hasBuff("FireArrow") || player.statStore.hasBuff("IceArrow") || player.statStore.hasBuff("Illusion") || player.statStore.hasBuff("Fear") || player.statStore.hasBuff("CombatDebuffStr") || 
				player.statStore.hasBuff("CombatDebuffSpe") || player.statStore.hasBuff("BasiliskGaze") || player.statStore.hasBuff("LightningArrow") || player.statStore.hasBuff("AkbalDebuff") || player.statStore.hasBuff("FrostGiantDebuff") || player.statStore.hasBuff("GnollSpearThrowerDebuff") || 
				player.statStore.hasBuff("YoungFrostGiantDebuff") || player.statStore.hasBuff("PoisonedArrow") || player.statStore.hasBuff("MalikoreVenom") || player.statStore.hasBuff("ManticoreVenom") || player.statStore.hasBuff("Nightmare") || player.statStore.hasBuff("Entwine") || player.statStore.hasBuff("Poison") || 
				player.hasStatusEffect(StatusEffects.BurnDoT) || player.hasStatusEffect(StatusEffects.AcidSlap) || player.hasStatusEffect(StatusEffects.DriderKiss) || player.hasStatusEffect(StatusEffects.AikoLightningArrow) || player.hasStatusEffect(StatusEffects.NagaVenom) || 
				player.hasStatusEffect(StatusEffects.MedusaVenom) || player.hasStatusEffect(StatusEffects.DriderIncubusVenom) || player.hasStatusEffect(StatusEffects.Poison) || player.hasStatusEffect(StatusEffects.AcidDoT) || player.hasStatusEffect(StatusEffects.FrostburnDoT) || 
				player.hasStatusEffect(StatusEffects.FrozenLung) || player.hasStatusEffect(StatusEffects.Blind) || player.hasStatusEffect(StatusEffects.ElectrocutionDoT) || player.hasStatusEffect(StatusEffects.NecrosisDoT));
	}
	
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
		var calcC:int = 0;
		if (!player.hasPerk(PerkLib.JobHealer)) calcC += spellGenericCooldown();
		if (player.weaponRange == weaponsrange.RW_TOME && player.level < 24) {
			if (player.level < 6) calcC -= 1;
			if (player.level < 12) calcC -= 1;
			if (player.level < 18) calcC -= 1;
			calcC -= 1;
		}
		if (player.weapon == weapons.U_STAFF) calcC -= 2;
		if (calcC < 0) calcC = 0;
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
