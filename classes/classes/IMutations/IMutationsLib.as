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
import classes.Creature;

/**
 * The goal of Mutations 3.0 is to allow for everything related to the mutation itself to be hosted within its own file, and to reduce the number of perks being created for the player.
 *
 * Mutations 3.0 Handles perk creation slightly differently in a few ways.
 *
 * First, .withBuffs is not used here, instead, buffs are created in a pBuffs function within the mutation file itself, and must return an object.
 *
 * Requirements, as seen below compared to PerkLib/MutationsLib, are also not handled below, and are instead dynamically created, via pReqs function, also stored within the mutations file itself.
 * These can be checked seperately, or when sent to createDynamicPerks, will handle it as well.
 *
 * Mutations are themselves handling their iterations via v1 checks.
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
		public static const SlimeMetabolismIM:IMutationPerkType = new SlimeMetabolismMutation();
		public static const NekomataThyroidGlandIM:IMutationPerkType = new NekomataThyroidGlandMutation();
		public static const HellcatParathyroidGlandsIM:IMutationPerkType = new HellcatParathyroidGlandMutation();
		public static const CaveWyrmLungsIM:IMutationPerkType = new CaveWyrmLungsMutation();
		//Mutations start here.
		public static const ArachnidBookLungIM:IMutationPerkType = new ArachnidBookLungMutation();
		public static const BlackHeartIM:IMutationPerkType = new BlackHeartMutation();
		public static const CatLikeNimblenessIM:IMutationPerkType = new CatLikeNimblenessMutation();
		public static const DisplacerMetabolismIM:IMutationPerkType = new DisplacerMetabolismMutation();
		public static const DraconicBonesIM:IMutationPerkType = new DraconicBonesMutation();
		public static const DraconicHeartIM:IMutationPerkType = new DraconicHeartMutation();
		public static const DraconicLungIM:IMutationPerkType = new DraconicLungMutation();
		public static const DrakeLungsIM:IMutationPerkType = new DrakeLungMutation();
		public static const EasterBunnyEggBagIM:IMutationPerkType = new EasterBunnyEggBagMutation();
		public static const EclipticMindIM:IMutationPerkType = new EclipticMindMutation();
		public static const ElvishPeripheralNervSysIM:IMutationPerkType = new ElvishPeripheralNervSysMutation();
		public static const FeyArcaneBloodstreamIM:IMutationPerkType = new FeyArcaneBloodstreamMutation();
		public static const FloralOvariesIM:IMutationPerkType = new FloralOvariesMutation();
		public static const FrozenHeartIM:IMutationPerkType = new FrozenHeartMutation();
		public static const GazerEyesIM:IMutationPerkType = new GazerEyesMutation();
		public static const GorgonEyesIM:IMutationPerkType = new GorgonEyesMutation();
		public static const HarpyHollowBonesIM:IMutationPerkType = new HarpyHollowBonesMutation();
		public static const HeartOfTheStormIM:IMutationPerkType = new HeartOfTheStormMutation();
		public static const HinezumiBurningBloodIM:IMutationPerkType = new HinezumiBurningBloodMutation();
		public static const HollowFangsIM:IMutationPerkType = new HollowFangsMutation();
		public static const KitsuneParathyroidGlandsIM:IMutationPerkType = new KitsuneParathyroidGlandMutation();
		public static const KitsuneThyroidGlandIM:IMutationPerkType = new KitsuneThyroidGlandMutation();
		public static const LactaBovinaOvariesIM:IMutationPerkType = new LactaBovinaOvariesMutation();
		public static const LizanMarrowIM:IMutationPerkType = new LizanMarrowMutation();
		public static const ManticoreMetabolismIM:IMutationPerkType = new ManticoreMetabolismMutation();
		public static const MantislikeAgilityIM:IMutationPerkType = new MantislikeAgilityMutation();
		public static const MelkieLungIM:IMutationPerkType = new MelkieLungMutation();
		public static const MinotaurTesticlesIM:IMutationPerkType = new MinotaurTesticlesMutation();
		public static const NaturalPunchingBagIM:IMutationPerkType = new NaturalPunchingBagMutation();
		public static const NukiNutsIM:IMutationPerkType = new NukiNutsMutation();
		public static const ObsidianHeartIM:IMutationPerkType = new ObsidianHeartMutation();
		public static const OniMusculatureIM:IMutationPerkType = new OniMusculatureMutation();
		public static const OrcAdrenalGlandsIM:IMutationPerkType = new OrcAdrenalGlandsMutation();
		public static const PigBoarFatIM:IMutationPerkType = new PigBoarFatMutation();
		public static const RaijuCathodeIM:IMutationPerkType = new RaijuCathodeMutation();
		public static const RatatoskrSmartsIM:IMutationPerkType = new RatatoskrSmartsMutation();
		public static const SalamanderAdrenalGlandsIM:IMutationPerkType = new SalamanderAdrenalGlandsMutation();
		public static const ScyllaInkGlandsIM:IMutationPerkType = new ScyllaInkGlandsMutation();
		public static const SharkOlfactorySystemIM:IMutationPerkType = new SharkOlfactorySystemMutation();
		public static const TrachealSystemIM:IMutationPerkType = new TrachealSystemMutation();
		public static const TwinHeartIM:IMutationPerkType = new TwinHeartMutation();
		public static const VampiricBloodstreamIM:IMutationPerkType = new VampiricBloodstreamMutation();
		public static const VenomGlandsIM:IMutationPerkType = new VenomGlandsMutation();
		public static const WhaleFatIM:IMutationPerkType = new WhaleFatMutation();
		public static const YetiFatIM:IMutationPerkType = new YetiFatMutation();

		/**
		*Returns an array of arrays of mutation body parts in PerkType type.
		*Can be specified to specific parts with the first argument.
		*Must update here with an extra push to all mutations points.
		*This feeds the Perks/Mutations DB and Evangeline's Mutations information.
		*/
		public static function mutationsArray(spec:String = ""):Array {
			var IMutationsList:Array = []
			function IMutationsHeart():void{
				IMutationsList.push(BlackHeartIM, DraconicHeartIM, FrozenHeartIM, HeartOfTheStormIM, ObsidianHeartIM);
			}
			function IMutationsMuscle():void{
				IMutationsList.push(MantislikeAgilityIM, OniMusculatureIM);
			}
			function IMutationsMouth():void{
				IMutationsList.push(HollowFangsIM, VenomGlandsIM);
			}
			function IMutationsAdrGland():void{
				IMutationsList.push(OrcAdrenalGlandsIM, SalamanderAdrenalGlandsIM);
			}
			function IMutationsBloodStream():void{
				IMutationsList.push(FeyArcaneBloodstreamIM, HinezumiBurningBloodIM, VampiricBloodstreamIM);
			}
			function IMutationsFaT():void{
				IMutationsList.push(NaturalPunchingBagIM, PigBoarFatIM, WhaleFatIM, YetiFatIM);
			}
			function IMutationsLungs():void{
				IMutationsList.push(DraconicLungIM, DrakeLungsIM, MelkieLungIM);
			}
			function IMutationsMetabolism():void{
				IMutationsList.push(DisplacerMetabolismIM, ManticoreMetabolismIM);
				//IMutationsList.push(SlimeMetabolismIM);
			}
			function IMutationsOvaries():void{
				IMutationsList.push(FloralOvariesIM, LactaBovinaOvariesIM);
			}
			function IMutationsTesticles():void{
				IMutationsList.push(EasterBunnyEggBagIM, MinotaurTesticlesIM, NukiNutsIM);
			}
			function IMutationsEyes():void{
				IMutationsList.push(GazerEyesIM, GorgonEyesIM);
			}
			function IMutationsPeriNervSys():void{
				IMutationsList.push(EclipticMindIM, ElvishPeripheralNervSysIM, RatatoskrSmartsIM, RaijuCathodeIM, SharkOlfactorySystemIM);
			}
			function IMutationsBone():void{
				IMutationsList.push(DraconicBonesIM, HarpyHollowBonesIM, LizanMarrowIM);
			}
			function IMutationsThyroidGlands():void{
				IMutationsList.push(KitsuneThyroidGlandIM);
			}
			function IMutationsParaThyroidGlands():void{
				IMutationsList.push(KitsuneParathyroidGlandsIM)
			}
			function IMutationsAdaptations():void{
				IMutationsList.push(ArachnidBookLungIM, CatLikeNimblenessIM, ScyllaInkGlandsIM, TrachealSystemIM, TwinHeartIM);
			}
			function IMutationsDeprecated():void{
				IMutationsList.push(MutationsTemplateIM, SlimeMetabolismIM, HellcatParathyroidGlandsIM, NekomataThyroidGlandIM, CaveWyrmLungsIM);
			}
			switch(spec){
				case "Heart":
					IMutationsHeart();
					break;
				case "Muscle":
					IMutationsMuscle();
					break;
				case "Mouth":
					IMutationsMouth();
					break;
				case "Adrenals":
					IMutationsAdrGland();
					break;
				case "Bloodstream":
					IMutationsBloodStream();
					break;
				case "FaT":
					IMutationsFaT();
					break;
				case "Lungs":
					IMutationsLungs();
					break;
				case "Metabolism":
					IMutationsMetabolism();
					break;
				case "Ovaries":
					IMutationsOvaries();
					break;
				case "Testicles":
					IMutationsTesticles();
					break;
				case "Eyes":
					IMutationsEyes();
					break;
				case "Bone":
					IMutationsBone();
					break;
				case "Nerv/Sys":
					IMutationsPeriNervSys();
					break;
				case "Thyroid":
					IMutationsThyroidGlands();
					break;
				case "PThyroid":
					IMutationsParaThyroidGlands();
					break;
				case "Adaptations":
					IMutationsAdaptations();
					break;
				case "Deprecated":
					IMutationsDeprecated();
					break;
				default:
					IMutationsHeart();
					IMutationsMuscle();
					IMutationsMouth();
					IMutationsAdrGland();
					IMutationsBloodStream();
					IMutationsFaT();
					IMutationsLungs();
					IMutationsMetabolism();
					IMutationsOvaries();
					IMutationsTesticles();
					IMutationsEyes();
					IMutationsBone();
					IMutationsPeriNervSys();
					IMutationsThyroidGlands();
					IMutationsParaThyroidGlands();
					IMutationsAdaptations();
					IMutationsList.sort();
			}
			return IMutationsList;
		}

	}
}