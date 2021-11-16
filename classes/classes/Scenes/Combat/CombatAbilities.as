package classes.Scenes.Combat {
import classes.Scenes.Combat.SpellsWhite.BlindSpell;
import classes.Scenes.Combat.SpellsWhite.BlizzardSpell;
import classes.Scenes.Combat.SpellsWhite.ChainLightningSpell;
import classes.Scenes.Combat.SpellsWhite.ChargeWeaponSpell;
import classes.Scenes.Combat.SpellsWhite.LightningBoltSpell;
import classes.Scenes.Combat.SpellsWhite.PyreBurstSpell;
import classes.Scenes.Combat.SpellsWhite.WhitefireSpell;

public class CombatAbilities {
	
	public static const Whitefire:WhitefireSpell = new WhitefireSpell();
	public static const WhitefireEx:WhitefireSpell = new WhitefireSpell(true);
	public static const PyreBurst:PyreBurstSpell = new PyreBurstSpell();
	public static const PyreBurstEx:PyreBurstSpell = new PyreBurstSpell(true);
	public static const LightningBolt:LightningBoltSpell = new LightningBoltSpell();
	public static const LightningBoltEx:LightningBoltSpell = new LightningBoltSpell(true);
	public static const ChainLightning:ChainLightningSpell = new ChainLightningSpell();
	public static const ChainLightningEx:ChainLightningSpell = new ChainLightningSpell(true);
	public static const Blind:BlindSpell = new BlindSpell();
	public static const ChargeWeapon:ChargeWeaponSpell = new ChargeWeaponSpell();
	// public static const ChargeArmor:ChargeArmorSpell = new ChargeArmorSpell();
	// public static const Heal:HealSpell = new HealSpell();
	public static const Blizzard:BlizzardSpell = new BlizzardSpell();
	// public static const MentalShield:MentalShieldSpell = new MentalShieldSpell();
	// public static const Cure:CureSpell = new CureSpell();
	// public static const FireStorm:FireStormSpell = new FireStormSpell();
	// public static const MeteorShower:MeteorShowerSpell = new MeteorShowerSpell();
	public static const ALL_WHITE_SPELLS:/*CombatAbility*/Array = [
		Whitefire,
		WhitefireEx,
		PyreBurst,
		PyreBurstEx,
		LightningBolt,
		LightningBoltEx,
		ChainLightning,
		ChainLightningEx,
		Blind,
		ChargeWeapon,
		// ChargeArmor,
		// Heal,
		Blizzard
		// MentalShield,
		// Cure,
		// FireStorm,
		// MeteorShower
	];
	
	public static const ALL_BLACK_SPELLS:/*CombatAbility*/Array = [
	];
	public static const ALL_HEX_SPELLS:/*CombatAbility*/Array = [
	];
	public static const ALL_DIVINE_SPELLS:/*CombatAbility*/Array = [
	];
	public static const ALL_NECRO_SPELLS:/*CombatAbility*/Array = [
	];
	public static const ALL_GREY_SPELLS:/*CombatAbility*/Array = [
	];
	public static const ALL_BLOOD_SPELLS:/*CombatAbility*/Array = [
	];
	public static const ALL_SPELLS:/*CombatAbility*/Array = []
			.concat(ALL_WHITE_SPELLS)
			.concat(ALL_BLACK_SPELLS)
			.concat(ALL_HEX_SPELLS)
			.concat(ALL_DIVINE_SPELLS)
			.concat(ALL_NECRO_SPELLS)
			.concat(ALL_GREY_SPELLS)
			.concat(ALL_BLOOD_SPELLS)
	;
	
	public static const ALL:/*CombatAbility*/Array = []
			.concat(ALL_SPELLS)
	;
	
	function CombatAbilities() {
	}
}
}
