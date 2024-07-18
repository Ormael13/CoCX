package classes.Scenes.Combat {
import classes.Scenes.Combat.SpellsBlack.*;
import classes.Scenes.Combat.SpellsGreen.*;
import classes.Scenes.Combat.SpellsWhite.*;
import classes.Scenes.Combat.SpellsHex.*;
import classes.Scenes.Combat.SpellsDivine.*;
import classes.Scenes.Combat.SpellsNecro.*;
import classes.Scenes.Combat.SpellsGrey.*;
import classes.Scenes.Combat.SpellsBlood.*;
import classes.Scenes.Combat.Soulskills.*;
import classes.Scenes.Combat.SpecialsMagic.*;
import classes.Scenes.Combat.General.*;

public class CombatAbilities {

	public static const FlyingSwordAttack:FlyingSwordSkill		= new FlyingSwordSkill();
	public static const WillOfTheWisp:WillOfTheWispSkill		= new WillOfTheWispSkill();
	public static const MummyAttack:MummyAttackSkill			= new MummyAttackSkill();
	public static const Tease:TeaseSkill						= new TeaseSkill();
	public static const GoblinLustBomb:GoblinLustBombSkill		= new GoblinLustBombSkill();
	public static const ALL_GENERAL_SKILLS:/*CombatAbility*/Array = [
		FlyingSwordAttack,
		WillOfTheWisp,
		MummyAttack,
		Tease,
		GoblinLustBomb
	];
	
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
	public static const ChargeRWeapon:ChargeRangeWeaponSpell    = new ChargeRangeWeaponSpell();
	public static const ChargeArmor:ChargeArmorSpell            = new ChargeArmorSpell();
	public static const Heal:HealSpell                          = new HealSpell();
	public static const Blizzard:BlizzardSpell                  = new BlizzardSpell();
	public static const MentalShield:MentalShieldSpell          = new MentalShieldSpell();
	public static const Cure:CureSpell                          = new CureSpell();
	public static const FireStorm:FireStormSpell                = new FireStormSpell();
	public static const MeteorShower:MeteorShowerSpell          = new MeteorShowerSpell();
	public static const WhitefireSwiftcast:WhitefireSwiftcastSpell			= new WhitefireSwiftcastSpell();
	public static const LightningBoltSwiftcast:LightningBoltSwiftcastSpell	= new LightningBoltSwiftcastSpell();
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
		ChargeRWeapon,
		ChargeArmor,
		Heal,
		Blizzard,
		MentalShield,
		Cure,
		FireStorm,
		MeteorShower,
		WhitefireSwiftcast,
		LightningBoltSwiftcast
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
	public static const IceSpikeSwiftcast:IceSpikeSwiftcastSpell			= new IceSpikeSwiftcastSpell();
	public static const DarknessShardSwiftcast:DarknessShardSwiftcastSpell	= new DarknessShardSwiftcastSpell();
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
		PolarMidnight,
		IceSpikeSwiftcast,
		DarknessShardSwiftcast
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
	public static const NecroticRot:NecroticRotSpell            = new NecroticRotSpell();
	public static const CorpseExplosion:CorpseExplosionSpell    = new CorpseExplosionSpell();
	public static const BloodShower:BloodShowerSpell            = new BloodShowerSpell();

	public static const ALL_NECRO_SPELLS:/*CombatAbility*/Array = [
		BoneSpirit,
		BoneArmor,
		Boneshatter,
		NecroticRot,
		CorpseExplosion,
		BloodShower
	];
	
	public static const ManaShield:ManaShieldSpell             = new ManaShieldSpell();
	public static const EnergyDrain:EnergyDrainSpell           = new EnergyDrainSpell();
	public static const Restore:RestoreSpell                   = new RestoreSpell();
	public static const BalanceOfLife:BalanceOfLifeSpell       = new BalanceOfLifeSpell();
	public static const ClearMind:ClearMindSpell               = new ClearMindSpell();
	public static const WaterSphere:WaterSphereSpell           = new WaterSphereSpell();
	public static const WaterSphereEx:WaterSphereSpell         = new WaterSphereSpell(true);
	public static const WaterBall:WaterBallSpell               = new WaterBallSpell();
	public static const WaterBallEx:WaterBallSpell             = new WaterBallSpell(true);
	public static const WindBullet:WindBulletSpell             = new WindBulletSpell();
	public static const WindBulletEx:WindBulletSpell           = new WindBulletSpell(true);
	public static const WindBlast:WindBlastSpell               = new WindBlastSpell();
	public static const WindBlastEx:WindBlastSpell             = new WindBlastSpell(true);
	public static const Stalagmite:StalagmiteSpell             = new StalagmiteSpell();
	public static const StalagmiteEx:StalagmiteSpell           = new StalagmiteSpell(true);
	public static const Shatterstone:ShatterstoneSpell         = new ShatterstoneSpell();
	public static const ShatterstoneEx:ShatterstoneSpell       = new ShatterstoneSpell(true);
	public static const AcidSpray:AcidSpraySpell               = new AcidSpraySpell();
	public static const AcidSprayEx:AcidSpraySpell             = new AcidSpraySpell(true);
	public static const CorrosiveWave:CorrosiveWaveSpell       = new CorrosiveWaveSpell();
	public static const CorrosiveWaveEx:CorrosiveWaveSpell     = new CorrosiveWaveSpell(true);
	public static const HydroAcid:HydroAcidSpell               = new HydroAcidSpell();
	public static const AcidRain:AcidRainSpell                 = new AcidRainSpell();
	public static const WaterBallSwiftcast:WaterBallSwiftcastSpell		= new WaterBallSwiftcastSpell();
	public static const WindBulletSwiftcast:WindBulletSwiftcastSpell	= new WindBulletSwiftcastSpell();
	public static const StalagmiteSwiftcast:StalagmiteSwiftcastSpell	= new StalagmiteSwiftcastSpell();
	public static const AcidSpraySwiftcast:AcidSpraySwiftcastSpell		= new AcidSpraySwiftcastSpell();
	//	if (player.hasStatusEffect(StatusEffects.KnowsWereBeast)) buttons.add("Were-beast",	were-beast spell goes here
	
	public static const ALL_GREY_SPELLS:/*CombatAbility*/Array = [
		ManaShield,
		EnergyDrain,
		Restore,
		BalanceOfLife,
		ClearMind,
		WaterSphere,
		WaterSphereEx,
		WaterBall,
		WaterBallEx,
		WindBullet,
		WindBulletEx,
		WindBlast,
		WindBlastEx,
		Stalagmite,
		StalagmiteEx,
		Shatterstone,
		ShatterstoneEx,
		AcidSpray,
		AcidSprayEx,
		CorrosiveWave,
		CorrosiveWaveEx,
		HydroAcid,
		AcidRain,
		WaterBallSwiftcast,
		WindBulletSwiftcast,
		StalagmiteSwiftcast,
		AcidSpraySwiftcast
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
	
	public static const PlantGrowth:PlantGrowthSpell     = new PlantGrowthSpell();
	public static const PlantBloom:PlantBloomSpell     	 = new PlantBloomSpell();
	public static const Entangle:EntangleSpell           = new EntangleSpell();
	public static const Briarthorn:BriarthornSpell       = new BriarthornSpell();
	public static const DeathBlossom:DeathBlossomSpell   = new DeathBlossomSpell();

	public static const ALL_GREEN_SPELLS:/*CombatAbility*/Array = [
		PlantGrowth,
		PlantBloom,
		Entangle,
		Briarthorn,
		DeathBlossom
	];
	
	public static const ALL_SPELLS:/*CombatAbility*/Array = []
			.concat(ALL_WHITE_SPELLS)
			.concat(ALL_BLACK_SPELLS)
			.concat(ALL_HEX_SPELLS)
			.concat(ALL_DIVINE_SPELLS)
			.concat(ALL_NECRO_SPELLS)
			.concat(ALL_GREY_SPELLS)
			.concat(ALL_BLOOD_SPELLS)
			.concat(ALL_GREEN_SPELLS)
	;

	public static const CleansingPalm:CleansingPalmSkill 							= new CleansingPalmSkill();
	public static const IceFist:IceFistSkill										= new IceFistSkill()
	public static const FirePunch:FirePunchSkill									= new FirePunchSkill();
	public static const HurricaneDance:HurricaneDanceSkill							= new HurricaneDanceSkill();
	public static const EarthStance:EarthStanceSkill								= new EarthStanceSkill();
	public static const PunishingKick:PunishingKickSkill							= new PunishingKickSkill();
	public static const SoulBlast:SoulBlastSkill									= new SoulBlastSkill();
	public static const Overlimit:OverlimitSkill									= new OverlimitSkill();
	public static const TripleThrust:MultiThrustSkill								= new MultiThrustSkill(1);
	public static const SextupleThrust:MultiThrustSkill								= new MultiThrustSkill(2);
	public static const NonupleThrust:MultiThrustSkill								= new MultiThrustSkill(3);
	public static const DracoSweep:DracoSweepSkill									= new DracoSweepSkill();
	public static const FlamesOfLove:FlamesOfLoveSkill								= new FlamesOfLoveSkill();
	public static const IciclesOfLove:IciclesOfLoveSkill							= new IciclesOfLoveSkill();
	public static const StormOfSisterhood:StormOfSisterhoodSkill					= new StormOfSisterhoodSkill();
	public static const NightOfBrotherhood:NightOfBrotherhoodSkill					= new NightOfBrotherhoodSkill();
	public static const Devourer:DevourerSkill										= new DevourerSkill();
	public static const ManyBirds:ManyBirdsSkill									= new ManyBirdsSkill();
	public static const ResonanceVolley:ResonanceVolleySkill						= new ResonanceVolleySkill();
	public static const AvatarOfTheSong:AvatarOfTheSongSkill						= new AvatarOfTheSongSkill();
	public static const BeatOfWar:BeatOfWarSkill									= new BeatOfWarSkill();
	public static const Comet:CometSkill											= new CometSkill();
	public static const BladeDance:BladeDanceSkill									= new BladeDanceSkill();
	public static const HailOfBlades:BladeHailSkill									= new BladeHailSkill(1);
	public static const GrandioseHailOfBlades:BladeHailSkill						= new BladeHailSkill(2);
	public static const GrandioseHailOfMoonBlades:BladeHailSkill					= new BladeHailSkill(3);
	public static const ElementAir:CreateElementSkill								= new CreateElementSkill("Air", 1);
	public static const ElementEarth:CreateElementSkill								= new CreateElementSkill("Earth", 1);
	public static const ElementFire:CreateElementSkill								= new CreateElementSkill("Fire", 1);
	public static const ElementWater:CreateElementSkill								= new CreateElementSkill("Water", 1);
	public static const ElementIce:CreateElementSkill								= new CreateElementSkill("Ice", 2);
	public static const ElementLightning:CreateElementSkill							= new CreateElementSkill("Lightning", 2);
	public static const ElementDarkness:CreateElementSkill							= new CreateElementSkill("Darkness", 2);
	public static const Sunrise:SunriseSkill										= new SunriseSkill();
	public static const SoulDrain:SoulDrainSkill									= new SoulDrainSkill();
	public static const Trance:TranceSkill											= new TranceSkill();
	public static const VioletPupilTransformation:VioletPupilTransformationSkill	= new VioletPupilTransformationSkill();
	public static const FingerOfDeath:FingerOfDeathSkill							= new FingerOfDeathSkill();
	public static const BloodSwipe:BloodSwipeSkill									= new BloodSwipeSkill();
	public static const BloodSwipeSF:BloodSwipeSkill								= new BloodSwipeSkill(true);
	public static const BloodDewdrops:BloodDewdropsSkill							= new BloodDewdropsSkill();
	public static const BloodDewdropsSF:BloodDewdropsSkill							= new BloodDewdropsSkill(true);
	public static const HeartSeeker:HeartSeekerSkill								= new HeartSeekerSkill();
	public static const HeartSeekerSF:HeartSeekerSkill								= new HeartSeekerSkill(true);
	public static const BloodRequiem:BloodReqiuemSkill								= new BloodReqiuemSkill();
	public static const BloodRequiemSF:BloodReqiuemSkill							= new BloodReqiuemSkill(true);
	public static const ScarletSpiritCharge:ScarletSpiritChargeSkill				= new ScarletSpiritChargeSkill();
	public static const KillingIntent:KillingIntentSkill							= new KillingIntentSkill();



	public static const ALL_SOULSKILLS:/*CombatAbility*/Array = [
		CleansingPalm,
		IceFist,
		FirePunch,
		HurricaneDance,
		EarthStance,
		PunishingKick,
		SoulBlast,
		Overlimit,
		TripleThrust,
		SextupleThrust,
		NonupleThrust,
		DracoSweep,
		FlamesOfLove,
		IciclesOfLove,
		StormOfSisterhood,
		NightOfBrotherhood,
		Devourer,
		ManyBirds,
		ResonanceVolley,
		AvatarOfTheSong,
		BeatOfWar,
		Comet,
		BladeDance,
		HailOfBlades,
		GrandioseHailOfBlades,
		GrandioseHailOfMoonBlades,
		ElementAir,
		ElementDarkness,
		ElementEarth,
		ElementFire,
		ElementIce,
		ElementLightning,
		ElementWater,
		Sunrise,
		SoulDrain,
		Trance,
		VioletPupilTransformation,
		FingerOfDeath,
		BloodSwipe,
		BloodSwipeSF,
		BloodDewdrops,
		BloodDewdropsSF,
		HeartSeeker,
		HeartSeekerSF,
		BloodRequiem,
		BloodRequiemSF,
		ScarletSpiritCharge,
		KillingIntent
	]

	public static const BPBloodSwipe:BloodSwipePuppiesSkill = new BloodSwipePuppiesSkill();
	public static const BPBloodDewdrops:BloodDewdropsPuppiesSkill = new BloodDewdropsPuppiesSkill();
	public static const BPHeartSeeker:HeartSeekerPuppiesSkill = new HeartSeekerPuppiesSkill();

	public static const ALL_BLOOD_PUPPY_SOULSKILLS:/*CombatAbility*/Array = [
		BPBloodSwipe,
		BPBloodDewdrops,
		BPHeartSeeker
	]

	public static const EAspectFire:EAspectFireSkill = new EAspectFireSkill();
	public static const EAspectAir:EAspectAirSkill = new EAspectAirSkill();
	public static const EAspectEarth:EAspectEarthSkill = new EAspectEarthSkill();
	public static const EAspectWater:EAspectWaterSkill = new EAspectWaterSkill();
	public static const EAspectEther:EAspectEtherSkill = new EAspectEtherSkill();
	public static const EAspectWood:EAspectWoodSkill = new EAspectWoodSkill();
	public static const EAspectMetal:EAspectMetalSkill = new EAspectMetalSkill();
	public static const EAspectIce:EAspectIceSkill = new EAspectIceSkill();
	public static const EAspectLightning:EAspectLightningSkill = new EAspectLightningSkill();
	public static const EAspectDarkness:EAspectDarknessSkill = new EAspectDarknessSkill();
	public static const EAspectPoison:EAspectPoisonSkill = new EAspectPoisonSkill();
	public static const EAspectPurity:EAspectPuritySkill = new EAspectPuritySkill();
	public static const EAspectCorruption:EAspectCorruptionSkill = new EAspectCorruptionSkill();

	public static const ALL_ELEMENTAL_ASPECTS:/*CombatAbility*/Array = [
		EAspectFire,
		EAspectAir,
		EAspectEarth,
		EAspectWater,
		EAspectEther,
		EAspectWood,
		EAspectMetal,
		EAspectIce,
		EAspectLightning,
		EAspectDarkness,
		EAspectPoison,
		EAspectPurity,
		EAspectCorruption
	]

	public static const FusionSpecial1st:FusionSpecial1stSkill = new FusionSpecial1stSkill();
	public static const FusionSpecial2nd:FusionSpecial2ndSkill = new FusionSpecial2ndSkill();
	public static const TrueEvasion:FusionSpecialTrueEvasionSkill = new FusionSpecialTrueEvasionSkill();
	public static const AdamantineShell:FusionSpecialAdamantineShellSkill = new FusionSpecialAdamantineShellSkill();
	public static const FieryRage:FusionSpecialFieryRageSkill = new FusionSpecialFieryRageSkill();
	public static const MomentofClarity:FusionSpecialMomentofClaritySkill = new FusionSpecialMomentofClaritySkill();
	public static const FusionSpecial4th:FusionSpecial4thSkill = new FusionSpecial4thSkill();
	public static const FusionSpecial5th:FusionSpecial5thSkill = new FusionSpecial5thSkill();


	public static const ALL_ELEMENTAL_FUSION_ATTACKS:/*CombatAbility*/Array = [
		FusionSpecial1st,
		FusionSpecial2nd,
		TrueEvasion,
		AdamantineShell,
		MomentofClarity,
		FusionSpecial4th,
		FusionSpecial5th
	];

	public static const ALL_MAGICAL_SPECIALS:/*CombatAbility*/Array = [
		
	]
	.concat(ALL_ELEMENTAL_FUSION_ATTACKS);
	
	
	/*
	 * Difference from CombatAbility.Registry:
	 * These arrays are for player menu construction. They can skip or re-order abilities.
	 * CombatAbility.Registry is internal and must have *ALL* abilities.
	 */
	public static const ALL:/*CombatAbility*/Array = []
			.concat(ALL_SPELLS)
			.concat(ALL_SOULSKILLS)
			.concat(ALL_MAGICAL_SPECIALS)
			.concat(ALL_ELEMENTAL_ASPECTS)
			.concat(ALL_BLOOD_PUPPY_SOULSKILLS)
			.concat(ALL_GENERAL_SKILLS);
	;
	
	function CombatAbilities() {
	}
}
}