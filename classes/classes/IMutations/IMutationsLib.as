/**
 * Based on PerkLib, created by Aimozg
 * Created by JTecx
 * V2 on 21.08.21
 * V3 on 31.03.22
 */
package classes.IMutations
{
import classes.CoC;
import classes.PerkType;

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
		//This one does nothing, and is simply to showcase.
		public static const MutationsTemplateIM:PerkType = new MutationTemplate();
		//Disabled mutations here.
		public static const SlimeMetabolismIM:PerkType = new SlimeMetabolismMutation();
		//public static const NekomataThyroidGlandIM:PerkType = new NekomataThyroidGlandMutation();
		//public static const HellcatParathyroidGlandsIM:PerkType = new HellcatParathyroidGlandMutation();
		//public static const CaveWyrmLungsIM:PerkType = new CaveWyrmLungsMutation();
		//Mutations start here.
		public static const ArachnidBookLungIM:PerkType = new ArachnidBookLungMutation();
		public static const BlackHeartIM:PerkType = new BlackHeartMutation();
		public static const CatLikeNimblenessIM:PerkType = new CatLikeNimblenessMutation();
		public static const DisplacerMetabolismIM:PerkType = new DisplacerMetabolismMutation();
		public static const DraconicBonesIM:PerkType = new DraconicBonesMutation();
		public static const DraconicHeartIM:PerkType = new DraconicHeartMutation();
		public static const DraconicLungIM:PerkType = new DraconicLungMutation();
		public static const DrakeLungIM:PerkType = new DrakeLungMutation();
		public static const EasterBunnyEggBagIM:PerkType = new EasterBunnyEggBagMutation();
		public static const EclipticMindIM:PerkType = new EclipticMindMutation();
		public static const ElvishPeripheralNervSysIM:PerkType = new ElvishPeripheralNervSysMutation();
		public static const FeyArcaneBloodstreamIM:PerkType = new FeyArcaneBloodstreamMutation();
		public static const FloralOvariesIM:PerkType = new FloralOvariesMutation();
		public static const FrozenHeartIM:PerkType = new FrozenHeartMutation();
		public static const GazerEyesIM:PerkType = new GazerEyesMutation();
		public static const GorgonEyesIM:PerkType = new GorgonEyesMutation();
		public static const HarpyHollowBonesIM:PerkType = new HarpyHollowBonesMutation();
		public static const HeartOfTheStormIM:PerkType = new HeartOfTheStormMutation();
		public static const HinezumiBurningBloodIM:PerkType = new HinezumiBurningBloodMutation();
		public static const HollowFangsIM:PerkType = new HollowFangsMutation();
		public static const KitsuneParathyroidGlandIM:PerkType = new KitsuneParathyroidGlandMutation();
		public static const KitsuneThyroidGlandIM:PerkType = new KitsuneThyroidGlandMutation();
		public static const LactaBovinaOvariesIM:PerkType = new LactaBovinaOvariesMutation();
		public static const LizanMarrowIM:PerkType = new LizanMarrowMutation();
		public static const ManticoreMetabolismIM:PerkType = new ManticoreMetabolismMutation();
		public static const MantislikeAgilityIM:PerkType = new MantislikeAgilityMutation();
		public static const MelkieLungIM:PerkType = new MelkieLungMutation();
		public static const MinotaurTesticlesIM:PerkType = new MinotaurTesticlesMutation();
		public static const NaturalPunchingBagIM:PerkType = new NaturalPunchingBagMutation();
		public static const NukiNutsIM:PerkType = new NukiNutsMutation();
		public static const TrachealSystemIM:PerkType = new TrachealSystemMutation();
		public static const VampiricBloodstreamIM:PerkType = new VampiricBloodstreamMutation();


		/**
		*Returns an array of arrays of mutation body parts in PerkType type.
		*Can be specified to specific parts with the first argument.
		*Must update here with an extra push to all mutations points.
		*This feeds the Perks/Mutations DB and Evangeline's Mutations information.
		*/
		public static function mutationsArray(spec:String = "", merge:Boolean = false):Array {
			var IMutationsList:Array = []
			function IMutationsHeart():void{
				IMutationsList.push([BlackHeartIM,BlackHeartMutation]);
				IMutationsList.push([DraconicHeartIM,DraconicHeartMutation]);
				IMutationsList.push([FrozenHeartIM,FrozenHeartMutation]);
				IMutationsList.push([HeartOfTheStormIM,HeartOfTheStormMutation]);
			}
			function IMutationsMuscle():void{
				IMutationsList.push([MantislikeAgilityIM,MantislikeAgilityMutation]);
			}
			function IMutationsMouth():void{
				IMutationsList.push([HollowFangsIM,HollowFangsMutation]);
			}
			function IMutationsAdrGland():void{

			}
			function IMutationsBloodStream():void{
				IMutationsList.push([FeyArcaneBloodstreamIM,FeyArcaneBloodstreamMutation]);
				IMutationsList.push([HinezumiBurningBloodIM,HinezumiBurningBloodMutation]);
				IMutationsList.push([VampiricBloodstreamIM,VampiricBloodstreamMutation]);
			}
			function IMutationsFaT():void{
				IMutationsList.push([NaturalPunchingBagIM,NaturalPunchingBagMutation]);
			}
			function IMutationsLungs():void{
				IMutationsList.push([DraconicLungIM,DraconicLungMutation]);
				IMutationsList.push([DrakeLungIM,DrakeLungMutation]);
				IMutationsList.push([MelkieLungIM,MelkieLungMutation]);
			}
			function IMutationsMetabolism():void{
				IMutationsList.push([DisplacerMetabolismIM,DisplacerMetabolismMutation]);
				IMutationsList.push([ManticoreMetabolismIM,ManticoreMetabolismMutation]);
				//IMutationsList.push([SlimeMetabolismIM,SlimeMetabolismMutation]);
			}
			function IMutationsOvaries():void{
				IMutationsList.push([FloralOvariesIM,FloralOvariesMutation]);
				IMutationsList.push([LactaBovinaOvariesIM,LactaBovinaOvariesMutation]);
			}
			function IMutationsTesticles():void{
				IMutationsList.push([EasterBunnyEggBagIM,EasterBunnyEggBagMutation]);
				IMutationsList.push([MinotaurTesticlesIM,MinotaurTesticlesMutation]);
				IMutationsList.push([NukiNutsIM,NukiNutsMutation]);
			}
			function IMutationsEyes():void{
				IMutationsList.push([GazerEyesIM,GazerEyesMutation]);
				IMutationsList.push([GorgonEyesIM,GorgonEyesMutation]);
			}
			function IMutationsPeriNervSys():void{
				IMutationsList.push([EclipticMindIM,EclipticMindMutation]);
				IMutationsList.push([ElvishPeripheralNervSysIM,ElvishPeripheralNervSysMutation]);
			}
			function IMutationsBone():void{
				IMutationsList.push([DraconicBonesIM,DraconicBonesMutation]);
				IMutationsList.push([HarpyHollowBonesIM,HarpyHollowBonesMutation]);
				IMutationsList.push([LizanMarrowIM,LizanMarrowMutation]);
			}
			function IMutationsThyroidGlands():void{
				IMutationsList.push([KitsuneThyroidGlandIM,KitsuneThyroidGlandMutation]);
			}
			function IMutationsParaThyroidGlands():void{
				IMutationsList.push([KitsuneParathyroidGlandIM,KitsuneParathyroidGlandMutation])
			}
			function IMutationsAdaptations():void{
				IMutationsList.push([ArachnidBookLungIM,ArachnidBookLungMutation]);
				IMutationsList.push([CatLikeNimblenessIM,CatLikeNimblenessMutation]);
				IMutationsList.push([TrachealSystemIM,TrachealSystemMutation]);
			}
			function IMutationsDeprecated():void{
				IMutationsList.push([MutationsTemplateIM,MutationTemplate]);
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
			}

			if (merge){
				var finalrez:Array = [];
				for each(var mutatetype:Array in IMutationsList){
					finalrez.push(mutatetype[0]);
				}
				IMutationsList = finalrez;
			}
			return IMutationsList;
		}
	}
}