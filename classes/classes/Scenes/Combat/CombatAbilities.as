package classes.Scenes.Combat {
import classes.Scenes.Combat.SpellsBlack.*;
import classes.Scenes.Combat.SpellsWhite.*;
import classes.Scenes.Combat.SpellsHex.*;
import classes.Scenes.Combat.SpellsDivine.*;
import classes.Scenes.Combat.SpellsNecro.*;
import classes.Scenes.Combat.SpellsGrey.*;
import classes.Scenes.Combat.SpellsBlood.*;

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
	
	public static const IceSpike:IceSpikeSpell                  = new IceSpikeSpell();
	public static const IceSpikeEx:IceSpikeSpell                = new IceSpikeSpell(true);
	public static const ArcticGale:ArcticGaleSpell              = new ArcticGaleSpell();
	public static const ArcticGaleEx:ArcticGaleSpell            = new ArcticGaleSpell(true);
	public static const DarknessShard:DarknessShardSpell        = new DarknessShardSpell();
	public static const DarknessShardEx:DarknessShardSpell      = new DarknessShardSpell(true);
	public static const DuskWave:DuskWaveSpell                  = new DuskWaveSpell();
	public static const DuskWaveEx:DuskWaveSpell                = new DuskWaveSpell(true);
	public static const Arouse:ArouseSpell                      = new ArouseSpell();
	public static const WaveOfEcstasy:WaveOfEcstasySpell        = new WaveOfEcstasySpell();
	public static const Might:MightSpell                        = new MightSpell();
	public static const Blink:BlinkSpell                        = new BlinkSpell();
	public static const Regenerate:RegenerateSpell              = new RegenerateSpell();
	public static const IceRain:IceRainSpell                    = new IceRainSpell();
	public static const Nosferatu:NosferatuSpell                = new NosferatuSpell();
	public static const PolarMidnight:PolarMidnightSpell        = new PolarMidnightSpell();
	public static const ALL_BLACK_SPELLS:/*CombatAbility*/Array = [
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
	
	public static const Lifetap:LifetapSpell                     = new LifetapSpell();
	public static const LifeSiphon:LifeSiphonSpell               = new LifeSiphonSpell();
	public static const ConsumingDarkness:ConsumingDarknessSpell = new ConsumingDarknessSpell();
	public static const CurseOfDesire:CurseOfDesireSpell         = new CurseOfDesireSpell();
	public static const CurseOfWeeping:CurseOfWeepingSpell       = new CurseOfWeepingSpell();
	
	public static const ALL_HEX_SPELLS:/*CombatAbility*/Array    = [
		Lifetap,
		LifeSiphon,
		ConsumingDarkness,
		CurseOfDesire,
		CurseOfWeeping
	];
	
	public static const Aegis:AegisSpell                         = new AegisSpell();
	public static const Exorcise:ExorciseSpell                   = new ExorciseSpell();
	public static const DivineShield:DivineShieldSpell           = new DivineShieldSpell();
	public static const Thunderstorm:ThunderstormSpell           = new ThunderstormSpell();
	public static const TearsOfDenial:TearsOfDenialSpell         = new TearsOfDenialSpell();
	
	public static const ALL_DIVINE_SPELLS:/*CombatAbility*/Array = [
		Aegis,
		Exorcise,
		DivineShield,
		Thunderstorm,
		TearsOfDenial,
	];
	
	public static const BoneSpirit:BoneSpiritSpell              = new BoneSpiritSpell();
	public static const BoneArmor:BoneArmorSpell                = new BoneArmorSpell();
	public static const Boneshatter:BoneshatterSpell            = new BoneshatterSpell();

	public static const ALL_NECRO_SPELLS:/*CombatAbility*/Array = [
		BoneSpirit,
		BoneArmor,
		Boneshatter
	];
	
	// leftover comments from CombatMagic on grey spells:
	//perki z grey mage line dajace spell mod * x% wiecej (nie wplywa na sam spell mod anu spell mod white/black)
	//	if (player.hasStatusEffect(StatusEffects.KnowsWereBeast)) buttons.add("Were-beast",	were-beast spell goes here
	//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	next spell (non-fire or non-ice based) goes here
	//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	fire single target spell goes here
	
	public static const ManaShield:ManaShieldSpell             = new ManaShieldSpell();
	public static const EnergyDrain:EnergyDrainSpell           = new EnergyDrainSpell();
	public static const Restore:RestoreSpell                   = new RestoreSpell();
	public static const BalanceOfLife:BalanceOfLifeSpell       = new BalanceOfLifeSpell();
	public static const ClearMind:ClearMindSpell               = new ClearMindSpell();
	
	public static const ALL_GREY_SPELLS:/*CombatAbility*/Array = [
		ManaShield,
		EnergyDrain,
		Restore,
		BalanceOfLife,
		ClearMind
	];
	
	public static const BloodMissiles:BloodMissilesSpell               = new BloodMissilesSpell();
	public static const BloodShield:BloodShieldSpell                   = new BloodShieldSpell();
	public static const BloodExplosion:BloodExplosionSpell             = new BloodExplosionSpell();
	public static const BloodChains:BloodChainsSpell                   = new BloodChainsSpell();
	public static const BloodWave:BloodWaveSpell                       = new BloodWaveSpell();
	public static const LifestealEnchantment:LifestealEnchantmentSpell = new LifestealEnchantmentSpell();
	public static const BloodField:BloodFieldSpell                     = new BloodFieldSpell();

	public static const ALL_BLOOD_SPELLS:/*CombatAbility*/Array        = [
		BloodMissiles,
		BloodShield,
		BloodExplosion,
		BloodChains,
		BloodWave,
		LifestealEnchantment,
		BloodField
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
