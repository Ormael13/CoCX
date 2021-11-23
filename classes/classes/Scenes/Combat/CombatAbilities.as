package classes.Scenes.Combat {
import classes.Scenes.Combat.SpellsBlack.*;
import classes.Scenes.Combat.SpellsWhite.*;

public class CombatAbilities {
	
	public static const Whitefire:WhitefireSpell                = new WhitefireSpell();
	public static const WhitefireEx:WhitefireSpell              = new WhitefireSpell(true);
	public static const PyreBurst:PyreBurstSpell                = new PyreBurstSpell();
	public static const PyreBurstEx:PyreBurstSpell              = new PyreBurstSpell(true);
	public static const LightningBolt:LightningBoltSpell        = new LightningBoltSpell();
	public static const LightningBoltEx:LightningBoltSpell      = new LightningBoltSpell(true);
	public static const ChainLightning:ChainLightningSpell      = new ChainLightningSpell();
	public static const ChainLightningEx:ChainLightningSpell    = new ChainLightningSpell(true);
	public static const Blind:BlindSpell                        = new BlindSpell();
	public static const ChargeWeapon:ChargeWeaponSpell          = new ChargeWeaponSpell();
	public static const ChargeArmor:ChargeArmorSpell            = new ChargeArmorSpell();
	public static const Heal:HealSpell                          = new HealSpell();
	public static const Blizzard:BlizzardSpell                  = new BlizzardSpell();
	public static const MentalShield:MentalShieldSpell          = new MentalShieldSpell();
	public static const Cure:CureSpell                          = new CureSpell();
	public static const FireStorm:FireStormSpell                = new FireStormSpell();
	public static const MeteorShower:MeteorShowerSpell          = new MeteorShowerSpell();
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
		ChargeArmor,
		Heal,
		Blizzard,
		MentalShield,
		Cure,
		FireStorm,
		MeteorShower
	];
	
	public static const IceSpike:IceSpikeSpell                   = new IceSpikeSpell();
	public static const IceSpikeEx:IceSpikeSpell                 = new IceSpikeSpell(true);
	public static const ArcticGale:ArcticGaleSpell               = new ArcticGaleSpell();
	public static const ArcticGaleEx:ArcticGaleSpell             = new ArcticGaleSpell(true);
	public static const DarknessShard:DarknessShardSpell         = new DarknessShardSpell();
	public static const DarknessShardEx:DarknessShardSpell       = new DarknessShardSpell(true);
	public static const DuskWave:DuskWaveSpell                   = new DuskWaveSpell();
	public static const DuskWaveEx:DuskWaveSpell                 = new DuskWaveSpell(true);
	public static const Arouse:ArouseSpell                       = new ArouseSpell();
	public static const WaveOfEcstasy:WaveOfEcstasySpell         = new WaveOfEcstasySpell();
	public static const Might:MightSpell                         = new MightSpell();
	public static const Blink:BlinkSpell                         = new BlinkSpell();
	public static const Regenerate:RegenerateSpell               = new RegenerateSpell();
	public static const IceRain:IceRainSpell                     = new IceRainSpell();
	public static const Nosferatu:NosferatuSpell                 = new NosferatuSpell();
	public static const PolarMidnight:PolarMidnightSpell         = new PolarMidnightSpell();
	public static const ALL_BLACK_SPELLS:/*CombatAbility*/Array  = [
		IceSpike,
		IceSpikeEx,
		ArcticGale,
		ArcticGaleEx,
		DarknessShard,
		DarknessShardEx,
		DuskWave,
		DuskWaveEx,
		Arouse,
		WaveOfEcstasy,
		Might,
		Blink,
		Regenerate,
		IceRain,
		Nosferatu,
		PolarMidnight
	];
	public static const ALL_HEX_SPELLS:/*CombatAbility*/Array    = [];
	public static const ALL_DIVINE_SPELLS:/*CombatAbility*/Array = [];
	public static const ALL_NECRO_SPELLS:/*CombatAbility*/Array  = [];
	public static const ALL_GREY_SPELLS:/*CombatAbility*/Array   = [];
	public static const ALL_BLOOD_SPELLS:/*CombatAbility*/Array  = [];
	public static const ALL_SPELLS:/*CombatAbility*/Array        = []
			.concat(ALL_WHITE_SPELLS)
			.concat(ALL_BLACK_SPELLS)
			.concat(ALL_HEX_SPELLS)
			.concat(ALL_DIVINE_SPELLS)
			.concat(ALL_NECRO_SPELLS)
			.concat(ALL_GREY_SPELLS)
			.concat(ALL_BLOOD_SPELLS)
	;
	
	/*
	 * Difference from CombatAbility.Registry:
	 * These arrays are for player menu construction. They can skip or re-order abilities.
	 * CombatAbility.Registry is internal and must have *ALL* abilities.
	 */
	public static const ALL:/*CombatAbility*/Array = []
			.concat(ALL_SPELLS)
	;
	
	function CombatAbilities() {
	}
}
}
