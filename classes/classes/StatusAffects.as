package classes
{
	import classes.StatusAffects.CombatStatusAffect;

	/**
	 * IMPORTANT NOTE:
	 * You can rename the constants BUT NOT the string ids (they are stored in saves).
	 */
	public class StatusAffects
	{
		// Non-combat player perks
		public static const AllNaturalOnaholeUsed:StatusAffectType = mk("all-natural onahole used");
		public static const AteEgg:StatusAffectType = mk("ateEgg");
		public static const AnemoneArousal:StatusAffectType = mk("Anemone Arousal");
		public static const BimboChampagne:StatusAffectType = mk("Bimbo Champagne");
		public static const Birthed:StatusAffectType = mk("Birthed");
		public static const BirthedImps:StatusAffectType = mk("Birthed Imps");
		public static const BlackCatBeer:StatusAffectType = mk("Black Cat Beer");
		public static const BlackNipples:StatusAffectType = mk("Black Nipples");
		public static const BlowjobOn:StatusAffectType = mk("BlowjobOn");
		public static const BoatDiscovery:StatusAffectType = mk("Boat Discovery");
		public static const BonusACapacity:StatusAffectType = mk("Bonus aCapacity");
		public static const BonusVCapacity:StatusAffectType = mk("Bonus vCapacity");
		public static const BottledMilk:StatusAffectType = mk("Bottled Milk");
		public static const BreastsMilked:StatusAffectType = mk("Breasts Milked");
		public static const BSwordBroken:StatusAffectType = mk("BSwordBroken");
		public static const BuiltMilker:StatusAffectType = mk("BUILT: Milker");
		public static const BurpChanged:StatusAffectType = mk("Burp Changed");
		public static const ButtStretched:StatusAffectType = mk("ButtStretched");
		public static const CampAnemoneTrigger:StatusAffectType = mk("Camp Anemone Trigger");
		public static const CampMarble:StatusAffectType = mk("Camp Marble");
		public static const CampRathazul:StatusAffectType = mk("Camp Rathazul");
		public static const ClaraCombatRounds:StatusAffectType = mk("Clara Combat Rounds");
		public static const ClaraFoughtInCamp:StatusAffectType = mk("Clara Fought In Camp");
		public static const CockPumped:StatusAffectType = mk("Cock Pumped");
		public static const Contraceptives:StatusAffectType = mk("Contraceptives");
		public static const CuntStretched:StatusAffectType = mk("CuntStretched");
		public static const DefenseCanopy:StatusAffectType = mk("Defense: Canopy");
		public static const DeluxeOnaholeUsed:StatusAffectType = mk("deluxe onahole used");
		public static const DogWarning:StatusAffectType = mk("dog warning");
		public static const DragonBreathBoost:StatusAffectType = mk("Dragon Breath Boost");
		public static const DragonBreathCooldown:StatusAffectType = mk("Dragon Breath Cooldown");
		public static const DungeonShutDown:StatusAffectType = mk("DungeonShutDown");
		public static const Dysfunction:StatusAffectType = mk("dysfunction");
		public static const Edryn:StatusAffectType = mk("Edryn");
		public static const Eggchest:StatusAffectType = mk("eggchest");
		public static const Eggs:StatusAffectType = mk("eggs");
		public static const EmberFuckCooldown:StatusAffectType = mk("ember fuck cooldown");
		public static const EmberNapping:StatusAffectType = mk("Ember Napping");
		public static const EverRapedJojo:StatusAffectType = mk("Ever Raped Jojo");
		public static const Exgartuan:StatusAffectType = mk("Exgartuan");
		public static const ExploredDeepwoods:StatusAffectType = mk("exploredDeepwoods");
		public static const FactoryOmnibusDefeated:StatusAffectType = mk("FactoryOmnibusDefeated");
		public static const FactoryOverload:StatusAffectType = mk("FactoryOverload");
		public static const FactoryIncubusDefeated:StatusAffectType = mk("FactoryIncubusDefeated");
		public static const FactorySuccubusDefeated:StatusAffectType = mk("FactorySuccubusDefeated");
		public static const FaerieFemFuck:StatusAffectType = mk("Faerie Fem Fuck");
		public static const FaerieFucked:StatusAffectType = mk("Faerie Fucked");
		public static const FappedGenderless:StatusAffectType = mk("fapped genderless");
		public static const Feeder:StatusAffectType = mk("Feeder");
		public static const Fertilized:StatusAffectType = mk("Fertilized");
		public static const FetishOn:StatusAffectType = mk("fetishON");
		public static const FoundFactory:StatusAffectType = mk("Found Factory");
		public static const FuckedMarble:StatusAffectType = mk("FuckedMarble");
		public static const Goojob:StatusAffectType = mk("GOOJOB");
		public static const GooStuffed:StatusAffectType = mk("gooStuffed");
		public static const Groundpound:StatusAffectType = mk("Groundpound");
		public static const HairdresserMeeting:StatusAffectType = mk("hairdresser meeting");
		public static const Hangover:StatusAffectType = mk("Hangover");
		public static const Heat:StatusAffectType = mk("heat");
		public static const HorseWarning:StatusAffectType = mk("horse warning");
		public static const ImmolationSpell:StatusAffectType = mk("Immolation Spell");
		public static const ImpGangBang:StatusAffectType = mk("Imp GangBang");
		public static const IncubusBribed:StatusAffectType = mk("IncubusBribed");
		public static const Infested:StatusAffectType = mk("infested");
		public static const IzmaBlowing:StatusAffectType = mk("IzmaBlowing");
		public static const IzumisPipeSmoke:StatusAffectType = mk("Izumis Pipe Smoke");
		public static const JerkingIzma:StatusAffectType = mk("JerkingIzma");
		public static const Jizzpants:StatusAffectType = mk("Jizzpants");
		public static const JojoMeditationCount:StatusAffectType = mk("Jojo Meditation Count");
		public static const JojoNightWatch:StatusAffectType = mk("JojoNightWatch");
		public static const JojoTFOffer:StatusAffectType = mk("JojoTFOffer");
		public static const Kelt:StatusAffectType = mk("Kelt");
		public static const KeltBJ:StatusAffectType = mk("KeltBJ");
		public static const KeltBadEndWarning:StatusAffectType = mk("Kelt Bad End Warning");
		public static const KeltOff:StatusAffectType = mk("KeltOff");
		public static const KnowsArouse:StatusAffectType = mk("Knows Arouse");
		public static const KnowsBlind:StatusAffectType = mk("Knows Blind");
		public static const KnowsCharge:StatusAffectType = mk("Knows Charge");
		public static const KnowsHeal:StatusAffectType = mk("Knows Heal");
		public static const KnowsMight:StatusAffectType = mk("Knows Might");
		public static const KnowsWhitefire:StatusAffectType = mk("Knows Whitefire");
		public static const LactationEndurance:StatusAffectType = mk("Lactation Endurance");
		public static const LactationReduction:StatusAffectType = mk("Lactation Reduction");
		public static const LactationReduc0:StatusAffectType = mk("Lactation Reduc0");
		public static const LactationReduc1:StatusAffectType = mk("Lactation Reduc1");
		public static const LactationReduc2:StatusAffectType = mk("Lactation Reduc2");
		public static const LactationReduc3:StatusAffectType = mk("Lactation Reduc3");
		public static const LootEgg:StatusAffectType = mk("lootEgg");
		public static const LostVillagerSpecial:StatusAffectType = mk("lostVillagerSpecial");
		public static const Luststick:StatusAffectType = mk("Luststick");
		public static const LustStickApplied:StatusAffectType = mk("Lust Stick Applied");
		public static const LustyTongue:StatusAffectType = mk("LustyTongue");
		public static const MalonVisitedPostAddiction:StatusAffectType = mk("Malon Visited Post Addiction");
		public static const MaraeComplete:StatusAffectType = mk("Marae Complete");
		public static const MaraesLethicite:StatusAffectType = mk("Marae's Lethicite");
		public static const MaraesQuestStart:StatusAffectType = mk("Marae's Quest Start");
		public static const Marble:StatusAffectType = mk("Marble");
		public static const MarbleHasItem:StatusAffectType = mk("MarbleHasItem");
		public static const MarbleItemCooldown:StatusAffectType = mk("MarbleItemCooldown");
		public static const MarbleRapeAttempted:StatusAffectType = mk("Marble Rape Attempted");
		public static const MarblesMilk:StatusAffectType = mk("Marbles Milk");
		public static const MarbleSpecials:StatusAffectType = mk("MarbleSpecials");
		public static const MarbleWithdrawl:StatusAffectType = mk("MarbleWithdrawl");
		public static const Meditated:StatusAffectType = mk("Meditated");
		public static const MeanToNaga:StatusAffectType = mk("MeanToNaga");
		public static const MeetWanderer:StatusAffectType = mk("meet wanderer");
		public static const MetCorruptMarae:StatusAffectType = mk("Met Corrupt Marae");
		public static const MetMarae:StatusAffectType = mk("Met Marae");
		public static const MetRathazul:StatusAffectType = mk("metRathazul");
		public static const MetWorms:StatusAffectType = mk("metWorms");
		public static const MetWhitney:StatusAffectType = mk("Met Whitney");
		public static const Milked:StatusAffectType = mk("Milked");
		public static const MinoPlusCowgirl:StatusAffectType = mk("Mino + Cowgirl");
		public static const Naga:StatusAffectType = mk("Naga");
		public static const NakedOn:StatusAffectType = mk("NakedOn");
		public static const NoJojo:StatusAffectType = mk("noJojo");
		public static const NoMoreMarble:StatusAffectType = mk("No More Marble");
		public static const Oswald:StatusAffectType = mk("Oswald");
		public static const PlainOnaholeUsed:StatusAffectType = mk("plain onahole used");
		public static const PhoukaWhiskeyAffect:StatusAffectType = mk("PhoukaWhiskeyAffect");
		public static const PostAkbalSubmission:StatusAffectType = mk("Post Akbal Submission");
		public static const PostAnemoneBeatdown:StatusAffectType = mk("Post Anemone Beatdown");
		public static const PureCampJojo:StatusAffectType = mk("PureCampJojo");
		public static const RathazulArmor:StatusAffectType = mk("RathazulArmor");
		public static const RepeatSuccubi:StatusAffectType = mk("repeatSuccubi");
		public static const Rut:StatusAffectType = mk("rut");
		public static const SharkGirl:StatusAffectType = mk("Shark-Girl");
		public static const ShieldingSpell:StatusAffectType = mk("Shielding Spell");
		public static const SlimeCraving:StatusAffectType = mk("Slime Craving");
		public static const SlimeCravingFeed:StatusAffectType = mk("Slime Craving Feed");
		public static const SlimeCravingOutput:StatusAffectType = mk("Slime Craving Output");
		public static const SuccubiFirst:StatusAffectType = mk("SuccubiFirst");
		public static const SuccubiNight:StatusAffectType = mk("succubiNight");
		public static const TakenGroPlus:StatusAffectType = mk("TakenGro+");
		public static const TakenLactaid:StatusAffectType = mk("TakenLactaid");
		public static const Tamani:StatusAffectType = mk("Tamani");									//Used only for compatibility with old save files, otherwise no longer in use
		public static const TamaniFemaleEncounter:StatusAffectType = mk("Tamani Female Encounter");	//Used only for compatibility with old save files, otherwise no longer in use
		public static const TelAdre:StatusAffectType = mk("Tel'Adre");
		public static const TentacleBadEndCounter:StatusAffectType = mk("TentacleBadEndCounter");
		public static const TentacleJojo:StatusAffectType = mk("Tentacle Jojo");
		public static const TensionReleased:StatusAffectType = mk("TensionReleased");
		public static const TF2:StatusAffectType = mk("TF2");
		public static const TookBlessedSword:StatusAffectType = mk("Took Blessed Sword");
		/**
		 * v1 = bonus index
		 * v2 = bonus value
		 * v3 = remaining time
		 */
		public static const UmasMassage:StatusAffectType = mk("Uma's Massage");
		public static const Uniball:StatusAffectType = mk("Uniball");
		public static const UsedNaturalSelfStim:StatusAffectType = mk("used natural self-stim");
		public static const used_self_dash_stim:StatusAffectType = mk("used self-stim");
		public static const Victoria:StatusAffectType = mk("Victoria");
		public static const VoluntaryDemonpack:StatusAffectType = mk("Voluntary Demonpack");
		public static const WormOffer:StatusAffectType = mk("WormOffer");
		public static const WormPlugged:StatusAffectType = mk("worm plugged");
		public static const WormsHalf:StatusAffectType = mk("wormsHalf");
		public static const WormsOff:StatusAffectType = mk("wormsOff");
		public static const WormsOn:StatusAffectType = mk("wormsOn");
		public static const WandererDemon:StatusAffectType = mk("wanderer demon");
		public static const WandererHuman:StatusAffectType = mk("wanderer human");
		public static const Yara:StatusAffectType = mk("Yara");

		// monster
		public static const Attacks:StatusAffectType = mk("attacks");
		public static const BimboBrawl:StatusAffectType = mk("bimboBrawl");
		public static const BowCooldown:StatusAffectType = mk("Bow Cooldown");
		public static const BowDisabled:StatusAffectType = mk("Bow Disabled");
		public static const Charged:StatusAffectType = mk("Charged");
		public static const Climbed:StatusAffectType = mk("Climbed");
		public static const Concentration:StatusAffectType = mk("Concentration");
		public static const Constricted:StatusAffectType = mk("Constricted");
		public static const CoonWhip:StatusAffectType = mk("Coon Whip");
		public static const Counter:StatusAffectType = mk("Counter");
		public static const DomFight:StatusAffectType = mk("domfight");
		public static const DrankMinoCum:StatusAffectType = mk("drank mino cum");
		public static const DrankMinoCum2:StatusAffectType = mk("drank mino cum2")
		public static const Earthshield:StatusAffectType = mk("Earthshield");
		public static const Fear:StatusAffectType = mk("Fear");
		public static const GenericRunDisabled:StatusAffectType = mk("Generic Run Disabled");
		public static const Gigafire:StatusAffectType = mk("Gigafire");
		public static const GottaOpenGift:StatusAffectType = mk("Gotta Open Gift");
		public static const HolliBurning:StatusAffectType = mk("Holli Burning");
		public static const Illusion:StatusAffectType = mk("Illusion");
		public static const ImpSkip:StatusAffectType = mk("ImpSkip");
		public static const ImpUber:StatusAffectType = mk("ImpUber");
		public static const JojoIsAssisting:StatusAffectType = mk("Jojo Is Assisting");
		public static const JojoPyre:StatusAffectType = mk("Jojo Pyre");
		public static const Keen:StatusAffectType = mk("keen");
		public static const Level:StatusAffectType = mk("level");
		public static const KitsuneFight:StatusAffectType = mk("Kitsune Fight");
		public static const LustAura:StatusAffectType = mk("Lust Aura");
		public static const LustStick:StatusAffectType = mk("LustStick");
		public static const Milk:StatusAffectType = mk("milk");
		public static const MilkyUrta:StatusAffectType = mk("Milky Urta");
		public static const MinoMilk:StatusAffectType = mk("Mino Milk");
		public static const MinotaurEntangled:StatusAffectType = mk("Minotaur Entangled");
		public static const MissFirstRound:StatusAffectType = mk("miss first round");
		public static const NoLoot:StatusAffectType = mk("No Loot");
		public static const PCTailTangle:StatusAffectType = mk("PCTailTangle");
		public static const PeachLootLoss:StatusAffectType = mk("Peach Loot Loss");
		// @aimozg i don't know and do not fucking care if these two should be merged
		public static const PhyllaFight:StatusAffectType = mk("PhyllaFight");
		public static const phyllafight:StatusAffectType = mk("phyllafight");
		public static const Platoon:StatusAffectType = mk("platoon");
		public static const QueenBind:StatusAffectType = mk("QueenBind");
		// @aimozg HA HA HA
		public static const Round:StatusAffectType = mk("Round");
		public static const round:StatusAffectType = mk("round");
		public static const RunDisabled:StatusAffectType = mk("Run Disabled");
		public static const Shell:StatusAffectType = mk("Shell");
		public static const SirenSong:StatusAffectType = mk("Siren Song");
		public static const Spar:StatusAffectType = mk("spar");
		public static const Sparring:StatusAffectType = mk("sparring");
		public static const spiderfight:StatusAffectType = mk("spiderfight");
		public static const StunCooldown:StatusAffectType = mk("Stun Cooldown");
		public static const TentacleCoolDown:StatusAffectType = mk("TentacleCoolDown");
		public static const Timer:StatusAffectType = mk("Timer");
		public static const Uber:StatusAffectType = mk("Uber");
		public static const UrtaSecondWinded:StatusAffectType = mk("Urta Second Winded");
		public static const UsedTitsmother:StatusAffectType = mk("UsedTitsmother");
		public static const Vala:StatusAffectType = mk("vala");
		public static const Vapula:StatusAffectType = mk("Vapula");
		public static const WhipReady:StatusAffectType = mk("Whip Ready");

		// combat
		public static const AcidSlap:CombatStatusAffect = mk2("Acid Slap");
		public static const AkbalSpeed:CombatStatusAffect = mk2("Akbal Speed");
		public static const AmilyVenom:CombatStatusAffect = mk2("Amily Venom");
		public static const AnemoneVenom:CombatStatusAffect = mk2("Anemone Venom");
		public static const AttackDisabled:CombatStatusAffect = mk2("Attack Disabled");
		public static const BasiliskCompulsion:CombatStatusAffect = mk2("Basilisk Compulsion");
		public static const BasiliskSlow:CombatStatusAffect = mk2("BasiliskSlow");
		public static const Berzerking:CombatStatusAffect = mk2("Berzerking");
		public static const Blind:CombatStatusAffect = mk2("Blind");
		public static const Bound:CombatStatusAffect = mk2("Bound");
		public static const CalledShot:CombatStatusAffect = mk2("Called Shot");
		public static const ChargeWeapon:CombatStatusAffect = mk2("Charge Weapon");
		public static const Chokeslam:CombatStatusAffect = mk2("Chokeslam");
		public static const Confusion:CombatStatusAffect = mk2("Confusion");
		public static const DemonSeed:CombatStatusAffect = mk2("DemonSeed");
		public static const Disarmed:CombatStatusAffect = mk2("Disarmed");
		public static const DriderKiss:CombatStatusAffect = mk2("Drider Kiss");
		public static const FirstAttack:CombatStatusAffect = mk2("FirstAttack");
		public static const GnollSpear:CombatStatusAffect = mk2("Gnoll Spear");
		public static const GooArmorBind:CombatStatusAffect = mk2("GooArmorBind");
		public static const GooArmorSilence:CombatStatusAffect = mk2("GooArmorSilence");
		public static const GooBind:CombatStatusAffect = mk2("GooBind");
		public static const HarpyBind:CombatStatusAffect = mk2("HarpyBind");
		public static const HolliConstrict:CombatStatusAffect = mk2("Holli Constrict");
		public static const InfestAttempted:CombatStatusAffect = mk2("infestAttempted");
		public static const IsabellaStunned:CombatStatusAffect = mk2("Isabella Stunned");
		public static const IzmaBleed:CombatStatusAffect = mk2("Izma Bleed");
		public static const KissOfDeath:CombatStatusAffect = mk2("Kiss of Death");
		public static const LustStones:CombatStatusAffect = mk2("lust stones");
		public static const lustvenom:CombatStatusAffect = mk2("lust venom");
		public static const Might:CombatStatusAffect = mk2("Might");
		public static const NagaBind:CombatStatusAffect = mk2("Naga Bind");
		public static const NagaVenom:CombatStatusAffect = mk2("Naga Venom");
		public static const NoFlee:CombatStatusAffect = mk2("NoFlee");
		public static const ParalyzeVenom:CombatStatusAffect = mk2("paralyze venom");
		public static const PhysicalDisabled:CombatStatusAffect = mk2("Physical Disabled");
		public static const Poison:CombatStatusAffect = mk2("Poison");
		public static const Sandstorm:CombatStatusAffect = mk2("sandstorm");
		public static const Sealed:CombatStatusAffect = mk2("Sealed");
		public static const SheilaOil:CombatStatusAffect = mk2("Sheila Oil");
		public static const Shielding:CombatStatusAffect = mk2("Sheilding");
		public static const StoneLust:CombatStatusAffect = mk2("Stone Lust");
		public static const Stunned:CombatStatusAffect = mk2("Stunned");
		public static const TailWhip:CombatStatusAffect = mk2("Tail Whip");
		public static const TemporaryHeat:CombatStatusAffect = mk2("Temporary Heat");
		public static const TentacleBind:CombatStatusAffect = mk2("TentacleBind");
		public static const ThroatPunch:CombatStatusAffect = mk2("Throat Punch");
		public static const Titsmother:CombatStatusAffect = mk2("Titsmother");
		public static const TwuWuv:CombatStatusAffect = mk2("Twu Wuv");
		public static const UBERWEB:CombatStatusAffect = mk2("UBERWEB");
		public static const Web:CombatStatusAffect = mk2("Web");
		public static const WebSilence:CombatStatusAffect = mk2("Web-Silence");
		public static const Whispered:CombatStatusAffect = mk2("Whispered");

		/**
		 * Creates non-combat status affect
		 */
		private static function mk(id:String):StatusAffectType
		{
			return new StatusAffectType(id);
		}

		/**
		 * Creates combat status affect
		 */
		private static function mk2(id:String):CombatStatusAffect
		{
			return new CombatStatusAffect(id);
		}
	}
}
