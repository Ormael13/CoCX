package classes
{
	import classes.StatusEffects.CombatStatusEffect;

	/**
	 * IMPORTANT NOTE:
	 * You can rename the constants BUT NOT the string ids (they are stored in saves).
	 */
	public class StatusEffects
	{
		// Non-combat player perks
		public static const AllNaturalOnaholeUsed:StatusEffectType = mk("all-natural onahole used");
		public static const AndysSmoke:StatusEffectType = mk("Andy's Smoke"); //v1: Hours; v2: Speed; v3: Intelligence
		public static const AteEgg:StatusEffectType = mk("ateEgg");
		public static const AnemoneArousal:StatusEffectType = mk("Anemone Arousal");
		public static const BimboChampagne:StatusEffectType = mk("Bimbo Champagne");
		public static const Birthed:StatusEffectType = mk("Birthed");
		public static const BirthedImps:StatusEffectType = mk("Birthed Imps");
		public static const BlackCatBeer:StatusEffectType = mk("Black Cat Beer");
		public static const BlackNipples:StatusEffectType = mk("Black Nipples");
		public static const BlowjobOn:StatusEffectType = mk("BlowjobOn");
		public static const BoatDiscovery:StatusEffectType = mk("Boat Discovery");
		public static const BonusACapacity:StatusEffectType = mk("Bonus aCapacity");
		public static const BonusVCapacity:StatusEffectType = mk("Bonus vCapacity");
		public static const BottledMilk:StatusEffectType = mk("Bottled Milk");
		public static const BreastsMilked:StatusEffectType = mk("Breasts Milked");
		public static const BSwordBroken:StatusEffectType = mk("BSwordBroken");
		public static const BuiltMilker:StatusEffectType = mk("BUILT: Milker");
		public static const BurpChanged:StatusEffectType = mk("Burp Changed");
		public static const ButtStretched:StatusEffectType = mk("ButtStretched");
		public static const CampAnemoneTrigger:StatusEffectType = mk("Camp Anemone Trigger");
		public static const CampMarble:StatusEffectType = mk("Camp Marble");
		public static const CampRathazul:StatusEffectType = mk("Camp Rathazul");
		public static const ClaraCombatRounds:StatusEffectType = mk("Clara Combat Rounds");
		public static const ClaraFoughtInCamp:StatusEffectType = mk("Clara Fought In Camp");
		public static const CockPumped:StatusEffectType = mk("Cock Pumped");
		public static const Contraceptives:StatusEffectType = mk("Contraceptives");
		public static const CuntStretched:StatusEffectType = mk("CuntStretched");
		public static const DefenseCanopy:StatusEffectType = mk("Defense: Canopy");
		public static const DeluxeOnaholeUsed:StatusEffectType = mk("deluxe onahole used");
		public static const DogWarning:StatusEffectType = mk("dog warning");
		public static const DragonBreathBoost:StatusEffectType = mk("Dragon Breath Boost");
		public static const DragonBreathCooldown:StatusEffectType = mk("Dragon Breath Cooldown");
		public static const Dysfunction:StatusEffectType = mk("dysfunction");
		public static const Edryn:StatusEffectType = mk("Edryn");
		public static const Eggchest:StatusEffectType = mk("eggchest");
		public static const Eggs:StatusEffectType = mk("eggs");
		public static const EmberFuckCooldown:StatusEffectType = mk("ember fuck cooldown");
		public static const EmberMilk:StatusEffectType = mk("Ember's Milk");
		public static const EmberNapping:StatusEffectType = mk("Ember Napping");
		public static const EverRapedJojo:StatusEffectType = mk("Ever Raped Jojo");
		public static const Exgartuan:StatusEffectType = mk("Exgartuan");
		public static const ExploredDeepwoods:StatusEffectType = mk("exploredDeepwoods");
		public static const FaerieFemFuck:StatusEffectType = mk("Faerie Fem Fuck");
		public static const FaerieFucked:StatusEffectType = mk("Faerie Fucked");
		public static const FappedGenderless:StatusEffectType = mk("fapped genderless");
		public static const Feeder:StatusEffectType = mk("Feeder");
		public static const Fertilized:StatusEffectType = mk("Fertilized");
		public static const FetishOn:StatusEffectType = mk("fetishON");
		public static const FuckedMarble:StatusEffectType = mk("FuckedMarble");
		public static const Fullness:StatusEffectType = mk("Fullness"); //Alternative to hunger
		public static const Goojob:StatusEffectType = mk("GOOJOB");
		public static const GooStuffed:StatusEffectType = mk("gooStuffed");
		public static const Groundpound:StatusEffectType = mk("Groundpound");
		public static const HairdresserMeeting:StatusEffectType = mk("hairdresser meeting");
		public static const Hangover:StatusEffectType = mk("Hangover");
		public static const Heat:StatusEffectType = mk("heat");
		public static const HorseWarning:StatusEffectType = mk("horse warning");
		public static const ImmolationSpell:StatusEffectType = mk("Immolation Spell");
		public static const ImpGangBang:StatusEffectType = mk("Imp GangBang");
		public static const Infested:StatusEffectType = mk("infested");
		public static const IzmaBlowing:StatusEffectType = mk("IzmaBlowing");
		public static const IzumisPipeSmoke:StatusEffectType = mk("Izumis Pipe Smoke");
		public static const JerkingIzma:StatusEffectType = mk("JerkingIzma");
		public static const Jizzpants:StatusEffectType = mk("Jizzpants");
		public static const JojoMeditationCount:StatusEffectType = mk("Jojo Meditation Count");
		public static const JojoNightWatch:StatusEffectType = mk("JojoNightWatch");
		public static const JojoTFOffer:StatusEffectType = mk("JojoTFOffer");
		public static const Kelt:StatusEffectType = mk("Kelt");
		public static const KeltBJ:StatusEffectType = mk("KeltBJ");
		public static const KeltBadEndWarning:StatusEffectType = mk("Kelt Bad End Warning");
		public static const KeltOff:StatusEffectType = mk("KeltOff");
		public static const KnowsArouse:StatusEffectType = mk("Knows Arouse");
		public static const KnowsBlind:StatusEffectType = mk("Knows Blind");
		public static const KnowsCharge:StatusEffectType = mk("Knows Charge");
		public static const KnowsHeal:StatusEffectType = mk("Knows Heal");
		public static const KnowsMight:StatusEffectType = mk("Knows Might");
		public static const KnowsWhitefire:StatusEffectType = mk("Knows Whitefire");
		public static const LactationEndurance:StatusEffectType = mk("Lactation Endurance");
		public static const LactationReduction:StatusEffectType = mk("Lactation Reduction");
		public static const LactationReduc0:StatusEffectType = mk("Lactation Reduc0");
		public static const LactationReduc1:StatusEffectType = mk("Lactation Reduc1");
		public static const LactationReduc2:StatusEffectType = mk("Lactation Reduc2");
		public static const LactationReduc3:StatusEffectType = mk("Lactation Reduc3");
		public static const LootEgg:StatusEffectType = mk("lootEgg");
		public static const LostVillagerSpecial:StatusEffectType = mk("lostVillagerSpecial");
		public static const Luststick:StatusEffectType = mk("Luststick");
		public static const LustStickApplied:StatusEffectType = mk("Lust Stick Applied");
		public static const LustyTongue:StatusEffectType = mk("LustyTongue");
		public static const MalonVisitedPostAddiction:StatusEffectType = mk("Malon Visited Post Addiction");
		public static const Marble:StatusEffectType = mk("Marble");
		public static const MarbleHasItem:StatusEffectType = mk("MarbleHasItem");
		public static const MarbleItemCooldown:StatusEffectType = mk("MarbleItemCooldown");
		public static const MarbleRapeAttempted:StatusEffectType = mk("Marble Rape Attempted");
		public static const MarblesMilk:StatusEffectType = mk("Marbles Milk");
		public static const MarbleSpecials:StatusEffectType = mk("MarbleSpecials");
		public static const MarbleWithdrawl:StatusEffectType = mk("MarbleWithdrawl");
		public static const Meditated:StatusEffectType = mk("Meditated"); // DEPRECATED
		public static const MeanToNaga:StatusEffectType = mk("MeanToNaga");
		public static const MeetWanderer:StatusEffectType = mk("meet wanderer");
		public static const MetRathazul:StatusEffectType = mk("metRathazul");
		public static const MetWorms:StatusEffectType = mk("metWorms");
		public static const MetWhitney:StatusEffectType = mk("Met Whitney");
		public static const Milked:StatusEffectType = mk("Milked");
		public static const MinoPlusCowgirl:StatusEffectType = mk("Mino + Cowgirl");
		public static const Naga:StatusEffectType = mk("Naga");
		public static const NakedOn:StatusEffectType = mk("NakedOn");
		public static const NoJojo:StatusEffectType = mk("noJojo");
		public static const NoMoreMarble:StatusEffectType = mk("No More Marble");
		public static const Oswald:StatusEffectType = mk("Oswald");
		public static const PlainOnaholeUsed:StatusEffectType = mk("plain onahole used");
		public static const PhoukaWhiskeyAffect:StatusEffectType = mk("PhoukaWhiskeyAffect");
		public static const PostAkbalSubmission:StatusEffectType = mk("Post Akbal Submission");
		public static const PostAnemoneBeatdown:StatusEffectType = mk("Post Anemone Beatdown");
		public static const PureCampJojo:StatusEffectType = mk("PureCampJojo");
		public static const RathazulArmor:StatusEffectType = mk("RathazulArmor");
		public static const RepeatSuccubi:StatusEffectType = mk("repeatSuccubi");
		public static const Rut:StatusEffectType = mk("rut");
		public static const SharkGirl:StatusEffectType = mk("Shark-Girl");
		public static const ShieldingSpell:StatusEffectType = mk("Shielding Spell");
		public static const SlimeCraving:StatusEffectType = mk("Slime Craving");
		public static const SlimeCravingFeed:StatusEffectType = mk("Slime Craving Feed");
		public static const SlimeCravingOutput:StatusEffectType = mk("Slime Craving Output");
		public static const SuccubiFirst:StatusEffectType = mk("SuccubiFirst");
		public static const SuccubiNight:StatusEffectType = mk("succubiNight");
		public static const TakenGroPlus:StatusEffectType = mk("TakenGro+");
		public static const TakenLactaid:StatusEffectType = mk("TakenLactaid");
		public static const Tamani:StatusEffectType = mk("Tamani");									//Used only for compatibility with old save files, otherwise no longer in use
		public static const TamaniFemaleEncounter:StatusEffectType = mk("Tamani Female Encounter");	//Used only for compatibility with old save files, otherwise no longer in use
		public static const TelAdre:StatusEffectType = mk("Tel'Adre");
		public static const TentacleBadEndCounter:StatusEffectType = mk("TentacleBadEndCounter");
		public static const TentacleJojo:StatusEffectType = mk("Tentacle Jojo");
		public static const TensionReleased:StatusEffectType = mk("TensionReleased");
		public static const TF2:StatusEffectType = mk("TF2");
		public static const TookBlessedSword:StatusEffectType = mk("Took Blessed Sword");
		
		//Old status plots. DEPRECATED, DO NOT USE. Currently cannot be removed without breaking existing saves.
		public static const DungeonShutDown:StatusEffectType = mk("DungeonShutDown");
		public static const FactoryOmnibusDefeated:StatusEffectType = mk("FactoryOmnibusDefeated");
		public static const FactoryOverload:StatusEffectType = mk("FactoryOverload");
		public static const FactoryIncubusDefeated:StatusEffectType = mk("FactoryIncubusDefeated");
		public static const FoundFactory:StatusEffectType = mk("Found Factory");
		public static const IncubusBribed:StatusEffectType = mk("IncubusBribed");
		public static const FactorySuccubusDefeated:StatusEffectType = mk("FactorySuccubusDefeated");		
		public static const MaraeComplete:StatusEffectType = mk("Marae Complete");
		public static const MaraesLethicite:StatusEffectType = mk("Marae's Lethicite");
		public static const MaraesQuestStart:StatusEffectType = mk("Marae's Quest Start");
		public static const MetCorruptMarae:StatusEffectType = mk("Met Corrupt Marae");
		public static const MetMarae:StatusEffectType = mk("Met Marae");
		
		//Prisoner status effects.
		public static const PrisonCaptorEllyStatus:StatusEffectType = mk("prisonCaptorEllyStatus");
		public static const PrisonCaptorEllyQuest:StatusEffectType = mk("prisonCaptorEllyQuest");
		public static const PrisonCaptorEllyPet:StatusEffectType = mk("prisonCaptorEllyPet");
		public static const PrisonCaptorEllyBillie:StatusEffectType = mk("prisonCaptorEllyBillie");
		public static const PrisonCaptorEllyScruffy:StatusEffectType = mk("prisonCaptorEllyScruffy");
		public static const PrisonRestraints:StatusEffectType = mk("prisonRestraint");
		public static const PrisonCaptorEllyScratch:StatusEffectType = mk("prisonCaptorEllyScatch");
		
		public static const UmasMassage:StatusEffectType = mk("Uma's Massage"); //v1 = bonus index; v2 = bonus value; v3 = remaining time
		public static const Uniball:StatusEffectType = mk("Uniball");
		public static const UsedNaturalSelfStim:StatusEffectType = mk("used natural self-stim");
		public static const used_self_dash_stim:StatusEffectType = mk("used self-stim");
		public static const Victoria:StatusEffectType = mk("Victoria");
		public static const VoluntaryDemonpack:StatusEffectType = mk("Voluntary Demonpack");
		public static const WormOffer:StatusEffectType = mk("WormOffer");
		public static const WormPlugged:StatusEffectType = mk("worm plugged");
		public static const WormsHalf:StatusEffectType = mk("wormsHalf");
		public static const WormsOff:StatusEffectType = mk("wormsOff");
		public static const WormsOn:StatusEffectType = mk("wormsOn");
		public static const WandererDemon:StatusEffectType = mk("wanderer demon");
		public static const WandererHuman:StatusEffectType = mk("wanderer human");
		public static const Yara:StatusEffectType = mk("Yara");

		// monster
		public static const Attacks:StatusEffectType = mk("attacks");
		public static const BimboBrawl:StatusEffectType = mk("bimboBrawl");
		public static const BowCooldown:StatusEffectType = mk("Bow Cooldown");
		public static const BowDisabled:StatusEffectType = mk("Bow Disabled");
		public static const Charged:StatusEffectType = mk("Charged");
		public static const Climbed:StatusEffectType = mk("Climbed");
		public static const Concentration:StatusEffectType = mk("Concentration");
		public static const Constricted:StatusEffectType = mk("Constricted");
		public static const CoonWhip:StatusEffectType = mk("Coon Whip");
		public static const Counter:StatusEffectType = mk("Counter");
		public static const DomFight:StatusEffectType = mk("domfight");
		public static const DrankMinoCum:StatusEffectType = mk("drank mino cum");
		public static const DrankMinoCum2:StatusEffectType = mk("drank mino cum2")
		public static const Drunk:StatusEffectType = mk("Drunk");
		public static const Earthshield:StatusEffectType = mk("Earthshield");
		public static const Fear:StatusEffectType = mk("Fear");
		//public static const FearCounter:StatusEffectType = mk("FearCounter");
		public static const GenericRunDisabled:StatusEffectType = mk("Generic Run Disabled");
		public static const Gigafire:StatusEffectType = mk("Gigafire");
		public static const GottaOpenGift:StatusEffectType = mk("Gotta Open Gift");
		public static const HolliBurning:StatusEffectType = mk("Holli Burning");
		public static const Illusion:StatusEffectType = mk("Illusion");
		public static const ImpSkip:StatusEffectType = mk("ImpSkip");
		public static const ImpUber:StatusEffectType = mk("ImpUber");
		public static const JojoIsAssisting:StatusEffectType = mk("Jojo Is Assisting");
		public static const JojoPyre:StatusEffectType = mk("Jojo Pyre");
		public static const Keen:StatusEffectType = mk("keen");
		public static const Level:StatusEffectType = mk("level");
		public static const KitsuneFight:StatusEffectType = mk("Kitsune Fight");
		public static const LethicesRapeTentacles:StatusEffectType = mk("Lethices Rape Tentacles");
		public static const LustAura:StatusEffectType = mk("Lust Aura");
		public static const LustStick:StatusEffectType = mk("LustStick");
		public static const Milk:StatusEffectType = mk("milk");
		public static const MilkyUrta:StatusEffectType = mk("Milky Urta");
		public static const MinoMilk:StatusEffectType = mk("Mino Milk");
		public static const MinotaurEntangled:StatusEffectType = mk("Minotaur Entangled");

		public static const MissFirstRound:StatusEffectType = mk("miss first round");
		public static const NoLoot:StatusEffectType = mk("No Loot");
		public static const OnFire:StatusEffectType = mk("On Fire");
		public static const PCTailTangle:StatusEffectType = mk("PCTailTangle");
		public static const PeachLootLoss:StatusEffectType = mk("Peach Loot Loss");

		// @aimozg i don't know and do not fucking care if these two should be merged
		public static const PhyllaFight:StatusEffectType = mk("PhyllaFight");
		public static const phyllafight:StatusEffectType = mk("phyllafight");
		public static const Platoon:StatusEffectType = mk("platoon");
		public static const QueenBind:StatusEffectType = mk("QueenBind");
		// @aimozg HA HA HA
		public static const GiantBoulder:StatusEffectType = mk("Giant Boulder");
		public static const Round:StatusEffectType = mk("Round");
		public static const round:StatusEffectType = mk("round");
		public static const RunDisabled:StatusEffectType = mk("Run Disabled");
		public static const Shell:StatusEffectType = mk("Shell");
		public static const SirenSong:StatusEffectType = mk("Siren Song");
		public static const Spar:StatusEffectType = mk("spar");
		public static const Sparring:StatusEffectType = mk("sparring");
		public static const spiderfight:StatusEffectType = mk("spiderfight");
		public static const StunCooldown:StatusEffectType = mk("Stun Cooldown");
		public static const TentacleCoolDown:StatusEffectType = mk("TentacleCoolDown");
		public static const Timer:StatusEffectType = mk("Timer");
		public static const TimesBashed:StatusEffectType = mk("TimesBashed");
		public static const Uber:StatusEffectType = mk("Uber");
		public static const UrtaSecondWinded:StatusEffectType = mk("Urta Second Winded");
		public static const UsedTitsmother:StatusEffectType = mk("UsedTitsmother");
		public static const Vala:StatusEffectType = mk("vala");
		public static const Vapula:StatusEffectType = mk("Vapula");
		public static const WhipReady:StatusEffectType = mk("Whip Ready");

		//Plantgirl
		public static const happy:StatusEffectType = mk("happy");
		public static const horny:StatusEffectType = mk("horny");
		public static const grouchy:StatusEffectType = mk("grouchy");
		
		// combat
		public static const AcidSlap:CombatStatusEffect = mk2("Acid Slap");
		public static const AkbalSpeed:CombatStatusEffect = mk2("Akbal Speed");
		public static const AmilyVenom:CombatStatusEffect = mk2("Amily Venom");
		public static const AnemoneVenom:CombatStatusEffect = mk2("Anemone Venom");
		public static const AttackDisabled:CombatStatusEffect = mk2("Attack Disabled");
		public static const BasiliskCompulsion:CombatStatusEffect = mk2("Basilisk Compulsion");
		public static const BasiliskSlow:CombatStatusEffect = mk2("BasiliskSlow");
		public static const Berzerking:CombatStatusEffect = mk2("Berzerking");
		public static const Blind:CombatStatusEffect = mk2("Blind");
		public static const Bound:CombatStatusEffect = mk2("Bound");
		public static const CalledShot:CombatStatusEffect = mk2("Called Shot");
		public static const ChargeWeapon:CombatStatusEffect = mk2("Charge Weapon");
		public static const Chokeslam:CombatStatusEffect = mk2("Chokeslam");
		public static const Confusion:CombatStatusEffect = mk2("Confusion");
		public static const DemonSeed:CombatStatusEffect = mk2("DemonSeed");
		public static const Disarmed:CombatStatusEffect = mk2("Disarmed");
		public static const DriderKiss:CombatStatusEffect = mk2("Drider Kiss");

		public static const FirstAttack:CombatStatusEffect = mk2("FirstAttack");
		public static const GiantGrabbed:CombatStatusEffect = mk2("Giant Grabbed");
		public static const GiantStrLoss:CombatStatusEffect = mk2("GiantStrLoss");
		public static const GnollSpear:CombatStatusEffect = mk2("Gnoll Spear");
		public static const GooArmorBind:CombatStatusEffect = mk2("GooArmorBind");
		public static const GooArmorSilence:CombatStatusEffect = mk2("GooArmorSilence");
		public static const GooBind:CombatStatusEffect = mk2("GooBind");
		public static const HarpyBind:CombatStatusEffect = mk2("HarpyBind");
		public static const HolliConstrict:CombatStatusEffect = mk2("Holli Constrict");
		public static const InfestAttempted:CombatStatusEffect = mk2("infestAttempted");
		public static const IsabellaStunned:CombatStatusEffect = mk2("Isabella Stunned");
		public static const IzmaBleed:CombatStatusEffect = mk2("Izma Bleed");
		public static const KissOfDeath:CombatStatusEffect = mk2("Kiss of Death");
		public static const LizanBlowpipe:CombatStatusEffect = mk2("Lizan Blowpipe");
		public static const LustStones:CombatStatusEffect = mk2("lust stones");
		public static const lustvenom:CombatStatusEffect = mk2("lust venom");
		public static const Lustzerking:CombatStatusEffect = mk2("Lustzerking");
		public static const Might:CombatStatusEffect = mk2("Might");
		public static const NagaBind:CombatStatusEffect = mk2("Naga Bind");
		public static const NagaVenom:CombatStatusEffect = mk2("Naga Venom");
		public static const NoFlee:CombatStatusEffect = mk2("NoFlee");
		public static const ParalyzeVenom:CombatStatusEffect = mk2("paralyze venom");
		public static const PhysicalDisabled:CombatStatusEffect = mk2("Physical Disabled");
		public static const Poison:CombatStatusEffect = mk2("Poison");
		public static const Sandstorm:CombatStatusEffect = mk2("sandstorm");
		public static const Sealed:CombatStatusEffect = mk2("Sealed");
		public static const SheilaOil:CombatStatusEffect = mk2("Sheila Oil");
		public static const Shielding:CombatStatusEffect = mk2("Sheilding");
		public static const StoneLust:CombatStatusEffect = mk2("Stone Lust");
		public static const Stunned:CombatStatusEffect = mk2("Stunned");
		public static const TailWhip:CombatStatusEffect = mk2("Tail Whip");
		public static const TemporaryHeat:CombatStatusEffect = mk2("Temporary Heat");
		public static const TentacleBind:CombatStatusEffect = mk2("TentacleBind");
		public static const ThroatPunch:CombatStatusEffect = mk2("Throat Punch");
		public static const Titsmother:CombatStatusEffect = mk2("Titsmother");
		public static const TwuWuv:CombatStatusEffect = mk2("Twu Wuv");
		public static const UBERWEB:CombatStatusEffect = mk2("UBERWEB");
		public static const Web:CombatStatusEffect = mk2("Web");
		public static const WebSilence:CombatStatusEffect = mk2("Web-Silence");
		public static const Whispered:CombatStatusEffect = mk2("Whispered");
		
		public static const RemovedArmor:CombatStatusEffect = mk2("Removed Armor");
		public static const JCLustLevel:CombatStatusEffect = mk2("JC Lust Level");
		public static const MirroredAttack:CombatStatusEffect = mk2("Mirrored Attack");
		public static const KnockedBack:CombatStatusEffect = mk2("Knocked Back");
		public static const Tentagrappled:CombatStatusEffect = mk2("Tentagrappled");
		public static const TentagrappleCooldown:CombatStatusEffect = mk2("Tentagrapple Cooldown");
		public static const ShowerDotEffect:CombatStatusEffect = mk2("Shower Dot Effect");
		public static const GardenerSapSpeed:CombatStatusEffect = mk2("Sap Speed");
		public static const VineHealUsed:CombatStatusEffect = mk2("Vine Heal Used");
		
		public static const DriderIncubusVenom:CombatStatusEffect = mk2("Drider Incubus Venom");
		public static const PurpleHaze:StatusEffectType = mk("PurpleHaze");
		public static const TaintedMind:StatusEffectType = mk("Tainted Mind");
		public static const MinotaurKingMusk:StatusEffectType = mk("Minotaur King Musk");
		public static const MinotaurKingsTouch:StatusEffectType = mk("Minotaur Kings Touch");
		public static const PigbysHands:StatusEffectType = mk("Pigbys Hands");
		public static const WhipSilence:CombatStatusEffect = mk2("Whip-Silence");

		/**
		 * Creates non-combat status affect
		 */
		private static function mk(id:String):StatusEffectType
		{
			return new StatusEffectType(id);
		}

		/**
		 * Creates combat status affect
		 */
		private static function mk2(id:String):CombatStatusEffect
		{
			return new CombatStatusEffect(id);
		}
	}
}
