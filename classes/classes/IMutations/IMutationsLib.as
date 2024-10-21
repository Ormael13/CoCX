/**
 * Based on PerkLib, created by Aimozg
 * Created by JTecx
 * V2 on 21.08.21
 * V3 on 31.03.22
 */
package classes.IMutations
{
import classes.CoC;
import classes.IMutationPerkType;

/**
 * The goal of Mutations 3.0 is to allow for everything related to the mutation itself to be hosted within its own file, and to reduce the number of perks being created for the player.
 *
 * Addendum: The fundamental reason for Mutations3.0 is to clearly define the "perks" that are limited by the organ slots, as well as being obtained by Evangeline only.
 * PermTF, or PermTF Adjacent races, with mutations such as Mindbreaker/HellhoundFireBalls/FeyArcaneBloodstream, have a "True" Variant, in which their buffs are significantly stronger,
 * to offset the penalty of not being able to obtain other mutations form other races.
 *
 * Mutations 3.0 Handles perk creation slightly differently in a few ways.
 *
 * First, .withBuffs is not used here, instead, buffs are created in a pBuffs function within the mutation file itself, and must return an object.
 *
 * Requirements, as seen below compared to PerkLib/MutationsLib, are also not handled below, and are instead dynamically created, via pReqs function, also stored within the mutations file itself.
 * These can be checked separately, or when sent to createDynamicPerks, will handle it as well.
 *
 * Mutations are themselves handling their iterations via v1 checks.
 * V2 is used for the Mutations to track any special conditions for upgrading, as in cases such as HellHoundFireBalls.
 * V3 is used to track if the user has the regular (0) or the True (1) variant of the Mutation.
 *
 * Refer to Basecontent's createDynamicPerk function to see how they are used.
 *
 * Refer to Basecontent's updateDynamicPerkBuff function to see how to update buffs associated with perks created by createDynamicBuffs.
 */
public class IMutationsLib
	{
		public function get game():CoC{
			return CoC.instance;
		}
		//Example -v
		//This one does nothing, and is simply to showcase and used as a dummy mutation to use for buffs..
		public static const MutationsTemplateIM:IMutationPerkType = new MutationTemplate();
		//Disabled mutations here. The contents are not filled. Please fill them in first.
		public static const NekomataThyroidGlandIM:IMutationPerkType = new NekomataThyroidGlandMutation();
		public static const HellcatParathyroidGlandsIM:IMutationPerkType = new HellcatParathyroidGlandMutation();
		public static const HengeyokaiBirthrightIM:IMutationPerkType = new HengeyokaiBirthrightMutation();
		public static const AnanasaBirthrightIM:IMutationPerkType = new AnanasaBirthrightMutation();
		public static const DraconicBonesIM:IMutationPerkType = new DraconicBonesMutation();
		public static const DraconicHeartIM:IMutationPerkType = new DraconicHeartMutation();
		public static const DraconicLungIM:IMutationPerkType = new DraconicLungMutation();
		//Mutations start here.
		public static const AlphaHowlIM:IMutationPerkType = new AlphaHowlMutation();
		public static const AnubiHeartIM:IMutationPerkType = new AnubiHeartMutation();
		public static const ArachnidBookLungIM:IMutationPerkType = new ArachnidBookLungMutation();
		public static const ArigeanAssociationCortexIM:IMutationPerkType = new ArigeanAssociationCortexMutation();
		public static const BlackHeartIM:IMutationPerkType = new BlackHeartMutation();
		public static const BlazingHeartIM:IMutationPerkType = new BlazingHeartMutation();
		public static const CatLikeNimblenessIM:IMutationPerkType = new CatLikeNimblenessMutation();
		public static const CaveWyrmLungsIM:IMutationPerkType = new CaveWyrmLungsMutation();
		public static const DiamondHeartIM:IMutationPerkType = new DiamondHeartMutation();
		public static const DisplacerMetabolismIM:IMutationPerkType = new DisplacerMetabolismMutation();
		public static const DrakeBloodIM:IMutationPerkType = new DrakeBloodMutation();
		public static const DrakeBonesIM:IMutationPerkType = new DrakeBonesMutation();
		public static const DrakeHeartIM:IMutationPerkType = new DrakeHeartMutation();
		public static const DrakeLungsIM:IMutationPerkType = new DrakeLungMutation();
		public static const EasterBunnyEggBagIM:IMutationPerkType = new EasterBunnyEggBagMutation();
		public static const EclipticMindIM:IMutationPerkType = new EclipticMindMutation();
		public static const ElvishPeripheralNervSysIM:IMutationPerkType = new ElvishPeripheralNervSysMutation();
		public static const EquineMuscleIM:IMutationPerkType = new EquineMuscleMutation();
		public static const EyeOfTheTigerIM:IMutationPerkType = new EyeOfTheTigerMutation();
		public static const FerasBirthrightIM:IMutationPerkType = new FerasBirthrightMutation();
		public static const FeyArcaneBloodstreamIM:IMutationPerkType = new FeyArcaneBloodstreamMutation();
		public static const FiendishBallsIM:IMutationPerkType = new FiendishBallsMutation();
		public static const FiendishMetabolismIM:IMutationPerkType = new FiendishMetabolismMutation();
		public static const FiendishOvariesIM:IMutationPerkType = new FiendishOvariesMutation();
		public static const FloralOvariesIM:IMutationPerkType = new FloralOvariesMutation();
		public static const FrozenHeartIM:IMutationPerkType = new FrozenHeartMutation();
		public static const GazerEyesIM:IMutationPerkType = new GazerEyesMutation();
		public static const GoblinOvariesIM:IMutationPerkType = new GoblinOvariesMutation();
		public static const GorgonEyesIM:IMutationPerkType = new GorgonEyesMutation();
		public static const HarpyHollowBonesIM:IMutationPerkType = new HarpyHollowBonesMutation();
		public static const HeartOfTheStormIM:IMutationPerkType = new HeartOfTheStormMutation();
		public static const HellhoundFireBallsIM:IMutationPerkType = new HellHoundFireBallsMutation();
		public static const HinezumiBurningBloodIM:IMutationPerkType = new HinezumiBurningBloodMutation();
		public static const HollowFangsIM:IMutationPerkType = new HollowFangsMutation();
		public static const HumanAdrenalGlandsIM:IMutationPerkType = new HumanAdrenalGlandsMutation();
		public static const HumanBloodstreamIM:IMutationPerkType = new HumanBloodstreamMutation();
		public static const HumanBonesIM:IMutationPerkType = new HumanBonesMutation();
		public static const HumanDigestiveTractIM:IMutationPerkType = new HumanDigestiveTractMutation();
		public static const HumanEyesIM:IMutationPerkType = new HumanEyesMutation();
		public static const HumanFatIM:IMutationPerkType = new HumanFatMutation();
		public static const HumanMetabolismIM:IMutationPerkType = new HumanMetabolismMutation();
		public static const HumanMusculatureIM:IMutationPerkType = new HumanMusculatureMutation();
		public static const HumanOvariesIM:IMutationPerkType = new HumanOvariesMutation();
		public static const HumanParathyroidGlandIM:IMutationPerkType = new HumanParathyroidGlandMutation();
		public static const HumanSmartsIM:IMutationPerkType = new HumanSmartsMutation();
		public static const HumanTesticlesIM:IMutationPerkType = new HumanTesticlesMutation();
		public static const HumanThyroidGlandIM:IMutationPerkType = new HumanThyroidGlandMutation();
		public static const HumanVersatilityIM:IMutationPerkType = new HumanVersatilityMutation();
		public static const HydraBloodIM:IMutationPerkType = new HydraBloodMutation();
		public static const KitsuneParathyroidGlandsIM:IMutationPerkType = new KitsuneParathyroidGlandMutation();
		public static const KitsuneThyroidGlandIM:IMutationPerkType = new KitsuneThyroidGlandMutation();
		public static const LactaBovinaOvariesIM:IMutationPerkType = new LactaBovinaOvariesMutation();
		public static const LizanMarrowIM:IMutationPerkType = new LizanMarrowMutation();
		public static const ManticoreMetabolismIM:IMutationPerkType = new ManticoreMetabolismMutation();
		public static const MantislikeAgilityIM:IMutationPerkType = new MantislikeAgilityMutation();
		public static const MelkieLungIM:IMutationPerkType = new MelkieLungMutation();
		public static const MightyLegsIM:IMutationPerkType = new MightyLegsMutation();
		public static const MightyLowerHalfIM:IMutationPerkType = new MightyLowerHalfMutation();
		public static const MinotaurTesticlesIM:IMutationPerkType = new MinotaurTesticlesMutation();
		public static const NaturalPunchingBagIM:IMutationPerkType = new NaturalPunchingBagMutation();
		public static const NukiNutsIM:IMutationPerkType = new NukiNutsMutation();
		public static const ObsidianHeartIM:IMutationPerkType = new ObsidianHeartMutation();
		public static const OniMusculatureIM:IMutationPerkType = new OniMusculatureMutation();
		public static const OrcAdrenalGlandsIM:IMutationPerkType = new OrcAdrenalGlandsMutation();
		public static const PigBoarFatIM:IMutationPerkType = new PigBoarFatMutation();
		public static const PoisonGlandIM:IMutationPerkType = new PoisonGlandMutation();
		public static const RaijuCathodeIM:IMutationPerkType = new RaijuCathodeMutation();
		public static const RatatoskrSmartsIM:IMutationPerkType = new RatatoskrSmartsMutation();
		public static const SalamanderAdrenalGlandsIM:IMutationPerkType = new SalamanderAdrenalGlandsMutation();
		public static const ScyllaInkGlandsIM:IMutationPerkType = new ScyllaInkGlandsMutation();
		public static const SharkOlfactorySystemIM:IMutationPerkType = new SharkOlfactorySystemMutation();
		public static const SlimeFluidIM:IMutationPerkType = new SlimeFluidMutation();
		public static const SlimeMetabolismIM:IMutationPerkType = new SlimeMetabolismMutation();
		public static const TrachealSystemIM:IMutationPerkType = new TrachealSystemMutation();
		public static const TwinHeartIM:IMutationPerkType = new TwinHeartMutation();
		public static const VampiricBloodstreamIM:IMutationPerkType = new VampiricBloodstreamMutation();
		public static const VenomGlandsIM:IMutationPerkType = new VenomGlandsMutation();
		public static const WhaleFatIM:IMutationPerkType = new WhaleFatMutation();
		public static const WhiteFacedOneBirthrightIM:IMutationPerkType = new WhiteFacedOneBirthrightMutation();
		public static const YetiFatIM:IMutationPerkType = new YetiFatMutation();

		/**
		 * Returns an array of arrays of mutation body parts in PerkType type.
		 * Can be specified to specific parts with the first argument.
		 * Must update here with an extra push to all mutations points.
		 * This feeds the Perks/Mutations DB and Evangeline's Mutations information.
		 * @param spec any of the IMutationPerkType.SLOT_XXX constants, "" for all obtainable mutations, "All" for all mutations including deprecated
		 * @return IMutationPerkType[]
		 */
		public static function mutationsArray(spec:String = ""):/*IMutationPerkType*/Array {
			var list:Array = [];
			if (spec && spec in IMutationPerkType.MutationsBySlot) {
				list = IMutationPerkType.MutationsBySlot[spec].slice();
			} else {
				for (var slot:String in IMutationPerkType.MutationsBySlot) {
					if (slot == "" && spec != "All") continue;
					list = list.concat(IMutationPerkType.MutationsBySlot[slot]);
				}
			}
			return list;
		}

	}
}