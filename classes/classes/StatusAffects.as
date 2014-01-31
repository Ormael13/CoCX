/**
 * Created by aimozg on 31.01.14.
 */
package classes
{
	import classes.StatusAffects.CombatStatusAffect;

	public class StatusAffects
	{
		// Non-combat
		public static const AnemoneArousal:StatusAffectType = mk("Anemone Arousal");
		public static const BimboChampagne:StatusAffectType = mk("Bimbo Champagne");
		public static const Black_Cat_Beer:StatusAffectType = mk("Black Cat Beer");
		public static const BlackNipples:StatusAffectType = mk("Black Nipples");
		public static const BonusACapacity:StatusAffectType = mk("Bonus aCapacity");
		public static const BonusVCapacity:StatusAffectType = mk("Bonus vCapacity");
		public static const BottledMilk:StatusAffectType = mk("Bottled Milk");
		public static const BreastsMilked:StatusAffectType = mk("Breasts Milked");
		public static const BSwordBroken:StatusAffectType = mk("BSwordBroken");
		public static const ButtStretched:StatusAffectType = mk("ButtStretched");
		public static const CampMarble:StatusAffectType = mk("Camp Marble");
		public static const CampRathazul:StatusAffectType = mk("Camp Rathazul");
		public static const CockPumped:StatusAffectType = mk("Cock Pumped");
		public static const CuntStretched:StatusAffectType = mk("CuntStretched");
		public static const dogwarning:StatusAffectType = mk("dog warning");
		public static const Dragon_Breath_Boost:StatusAffectType = mk("Dragon Breath Boost");
		public static const Dragon_Breath_Cooldown:StatusAffectType = mk("Dragon Breath Cooldown");
		public static const DungeonShutDown:StatusAffectType = mk("DungeonShutDown");
		public static const dysfunction:StatusAffectType = mk("dysfunction");
		public static const Edryn:StatusAffectType = mk("Edryn");
		public static const eggs:StatusAffectType = mk("eggs");
		public static const ember_fuck_cooldown:StatusAffectType = mk("ember fuck cooldown");
		public static const EmberNapping:StatusAffectType = mk("Ember Napping");
		public static const Exgartuan:StatusAffectType = mk("Exgartuan");
		public static const FactoryOverload:StatusAffectType = mk("FactoryOverload");
		public static const Feeder:StatusAffectType = mk("Feeder");
		public static const fetishON:StatusAffectType = mk("fetishON");
		public static const heat:StatusAffectType = mk("heat");
		public static const horsewarning:StatusAffectType = mk("horse warning");
		public static const Izumis_Pipe_Smoke:StatusAffectType = mk("Izumis Pipe Smoke");
		public static const JojoNightWatch:StatusAffectType = mk("JojoNightWatch");
		public static const Kelt:StatusAffectType = mk("Kelt");
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
		public static const Luststick:StatusAffectType = mk("Luststick");
		public static const Lust_Stick_Applied:StatusAffectType = mk("Lust Stick Applied");
		public static const LustyTongue:StatusAffectType = mk("LustyTongue");
		public static const Marble:StatusAffectType = mk("Marble");
		public static const Marble_Rape_Attempted:StatusAffectType = mk("Marble Rape Attempted");
		public static const MarbleWithdrawl:StatusAffectType = mk("MarbleWithdrawl");
		public static const MetWhitney:StatusAffectType = mk("Met Whitney");
		public static const Milked:StatusAffectType = mk("Milked");
		public static const No_More_Marble:StatusAffectType = mk("No_More_Marble");
		public static const PureCampJojo:StatusAffectType = mk("PureCampJojo");
		public static const repeatSuccubi:StatusAffectType = mk("repeatSuccubi");
		public static const Rut:StatusAffectType = mk("rut");
		public static const SlimeCraving:StatusAffectType = mk("Slime Craving");
		public static const Slime_Craving_Feed:StatusAffectType = mk("Slime Craving Feed");
		public static const succubiNight:StatusAffectType = mk("succubiNight");
		public static const Tamani:StatusAffectType = mk("Tamani");
		public static const Took_Blessed_Sword:StatusAffectType = mk("Took Blessed Sword");
		public static const Uniball:StatusAffectType = mk("Uniball");
		public static const wormsOff:StatusAffectType = mk("wormsOff");
		public static const wandererdemon:StatusAffectType = mk("wanderer demon");
		public static const wandererhuman:StatusAffectType = mk("wanderer human");

		// monster
		public static const attacks:StatusAffectType = mk("attacks");
		public static const Constricted:StatusAffectType = mk("Constricted");
		public static const CoonWhip:StatusAffectType = mk("Coon Whip");
		public static const Earthshield:StatusAffectType = mk("Earthshield");
		public static const Fear:StatusAffectType = mk("Fear");
		public static const ImpSkip:StatusAffectType = mk("ImpSkip");
		public static const ImpUber:StatusAffectType = mk("ImpUber");
		public static const KitsuneFight:StatusAffectType = mk("Kitsune Fight");
		public static const LustAura:StatusAffectType = mk("Lust Aura");
		public static const LustStick:StatusAffectType = mk("LustStick");
		public static const MilkyUrta:StatusAffectType = mk("Milky Urta");
		public static const MinotaurEntangled:StatusAffectType = mk("Minotaur Entangled");
		public static const PCTailTangle:StatusAffectType = mk("PCTailTangle");
		public static const QueenBind:StatusAffectType = mk("QueenBind");
		public static const Shell:StatusAffectType = mk("Shell");
		public static const TentacleCoolDown:StatusAffectType = mk("TentacleCoolDown");
		public static const Timer:StatusAffectType = mk("Timer");
		public static const Urta_Second_Winded:StatusAffectType = mk("Urta Second Winded");

		// combat
		public static const AcidSlap:CombatStatusAffect = mk2("Acid Slap");
		public static const AkbalSpeed:CombatStatusAffect = mk2("Akbal Speed");
		public static const AmilyVenom:CombatStatusAffect = mk2("Amily Venom");
		public static const AnemoneVenom:CombatStatusAffect = mk2("Anemone Venom");
		public static const BasiliskCompulsion:CombatStatusAffect = mk2("Basilisk Compulsion");
		public static const BasiliskSlow:CombatStatusAffect = mk2("BasiliskSlow");
		public static const Berzerking:CombatStatusAffect = mk2("Berzerking");
		public static const Blind:CombatStatusAffect = mk2("Blind");
		public static const Bound:CombatStatusAffect = mk2("Bound");
		public static const CalledShot:CombatStatusAffect = mk2("Called Shot");
		public static const ChargeWeapon:CombatStatusAffect = mk2("Charge Weapon");
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
		public static const infested:CombatStatusAffect = mk2("infested");
		public static const infestAttempted:CombatStatusAffect = mk2("infestAttempted");
		public static const IsabellaStunned:CombatStatusAffect = mk2("Isabella Stunned");
		public static const IzmaBleed:CombatStatusAffect = mk2("Izma Bleed");
		public static const Kiss_of_Death:CombatStatusAffect = mk2("Kiss of Death");
		public static const luststones:CombatStatusAffect = mk2("lust stones");
		public static const lustvenom:CombatStatusAffect = mk2("lust venom");
		public static const Might:CombatStatusAffect = mk2("Might");
		public static const NagaBind:CombatStatusAffect = mk2("Naga Bind");
		public static const NagaVenom:CombatStatusAffect = mk2("Naga Venom");
		public static const NoFlee:CombatStatusAffect = mk2("NoFlee");
		public static const paralyzevenom:CombatStatusAffect = mk2("paralyze venom");
		public static const Poison:CombatStatusAffect = mk2("Poison");
		public static const sandstorm:CombatStatusAffect = mk2("sandstorm");
		public static const Sealed:CombatStatusAffect = mk2("Sealed");
		public static const SheilaOil:CombatStatusAffect = mk2("Sheila Oil");
		public static const Shielding:CombatStatusAffect = mk2("Sheilding");
		public static const StoneLust:CombatStatusAffect = mk2("Stone Lust");
		public static const Stunned:CombatStatusAffect = mk2("Stunned");
		public static const TailWhip:CombatStatusAffect = mk2("Tail Whip");
		public static const TemporaryHeat:CombatStatusAffect = mk2("Temporary Heat");
		public static const TentacleBind:CombatStatusAffect = mk2("TentacleBind");
		public static const ThroatPunch:CombatStatusAffect = mk2("Throat Punch");
		public static const TwuWuv:CombatStatusAffect = mk2("Twu Wuv");
		public static const UBERWEB:CombatStatusAffect = mk2("UBERWEB");
		public static const Web:CombatStatusAffect = mk2("Web");
		public static const Web_dash_Silence:CombatStatusAffect = mk2("Web-Silence");
		public static const Whispered:CombatStatusAffect = mk2("Whispered");

		/**
		 * Creates non-combat status affect
		 */
		private static function mk(id:String):StatusAffectType{
			return new StatusAffectType(id);
		}

		/**
		 * Creates combat status affect
		 */
		private static function mk2(id:String):CombatStatusAffect{
			return new CombatStatusAffect(id);
		}
	}
}
