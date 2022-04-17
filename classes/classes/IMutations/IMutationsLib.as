/**
 * Based on PerkLib, created by Aimozg
 * Created by JTecx
 * V2 on 21.08.21
 * V3 on 31.03.22
 */
package classes.IMutations
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.IMutations.*;
import classes.Scenes.Areas.Caves.DarkSlime;

/**
 * Mutations 3.0 Handles perk creation slightly differently in a few ways.
 * .withBuffs is not used here, instead, buffs are created in a pBuffs function within the mutation file itself, and must return an object.
 * Requirements, as seen below compared to PerkLib/MutationsLib, are also not handled below, and are instead dynamically loaded in, via pReqs function, also stored within the mutations file itself.
 * Mutations are themselves handling their iterations via v1 checks.
 * The goal of this is to allow for everything related to the mutation itself to be hosted within its own file, and to reduce the number of perks being created for the player.
 * Refer to Basecontent's createDynamicPerk function to see how they are used.
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
		//public static const HellcatParathyroidGlandsIM:PerkType = new HellcatParathyroudGlandMutation();
		//public static const CaveWyrmLungsIM:PerkType = new CaveWyrmLungsMutation();
		//public static const KitsuneParathyroidGlandIM:PerkType = new KitsuneParathyroidGlandMutation();
		//Mutations start here.
		public static const ArachnidBookLungIM:PerkType = new ArachnidBookLungMutation();
		public static const BlackHeartIM:PerkType = new BlackHeartMutation();
		public static const CatLikeNimblenessIM:PerkType = new CatLikeNimblenessMutation();
		public static const DisplacerMetabolismIM:PerkType = new DisplacerMetabolismMutation();
		public static const KitsuneThyroidGlandIM:PerkType = new KitsuneThyroidGlandMutation();


		/**
		*Returns an array of arrays of mutation body parts in PerkType type.
		*Can be specified to specific parts with the first argument.
		*Must update here with an extra push to all mutations points.
		*This feeds the Perks/Mutations DB and Evangeline's Mutations information.
		*/
		public static function mutationsArray(spec:String = "", merge:Boolean = false):Array {
			var IMutationsList:Array = []
			function mutationsHeart():void{
				IMutationsList.push([BlackHeartIM, BlackHeartMutation]);
			}
			function mutationsMuscle():void{

			}
			function mutationsMouth():void{

			}
			function mutationsAdrGland():void{

			}
			function mutationsBloodStream():void{

			}
			function mutationsFaT():void{

			}
			function mutationsLungs():void{

			}
			function mutationsMetabolism():void{
				IMutationsList.push([DisplacerMetabolismIM,DisplacerMetabolismMutation]);
				//IMutationsList.push([SlimeMetabolismIM,SlimeMetabolismMutation]);
			}
			function mutationsOvaries():void{

			}
			function mutationsTesticles():void{

			}
			function mutationsEyes():void{

			}
			function mutationsPeriNervSys():void{

			}
			function mutationsBone():void{

			}
			function mutationsThyroidGlands():void{
				IMutationsList.push([KitsuneThyroidGlandIM, KitsuneThyroidGlandMutation]);
			}
			function mutationsParaThyroidGlands():void{

			}
			function mutationsAdaptations():void{
				IMutationsList.push([ArachnidBookLungIM, ArachnidBookLungMutation]);
				IMutationsList.push([CatLikeNimblenessIM, CatLikeNimblenessMutation]);
			}
			function mutationsDeprecated():void{
				IMutationsList.push([MutationsTemplateIM,MutationTemplate]);
			}

			switch(spec){
				case "Heart":
					mutationsHeart();
					break;
				case "Muscle":
					mutationsMuscle();
					break;
				case "Mouth":
					mutationsMouth();
					break;
				case "Adrenals":
					mutationsAdrGland();
					break;
				case "Bloodstream":
					mutationsBloodStream();
					break;
				case "FaT":
					mutationsFaT();
					break;
				case "Lungs":
					mutationsLungs();
					break;
				case "Metabolism":
					mutationsMetabolism();
					break;
				case "Ovaries":
					mutationsOvaries();
					break;
				case "Testicles":
					mutationsTesticles();
					break;
				case "Eyes":
					mutationsEyes();
					break;
				case "Bone":
					mutationsBone();
					break;
				case "Nerv/Sys":
					mutationsPeriNervSys();
					break;
				case "Thyroid":
					mutationsThyroidGlands();
					break;
				case "PThyroid":
					mutationsParaThyroidGlands();
					break;
				case "Adaptations":
					mutationsAdaptations();
					break;
				case "Deprecated":
					mutationsDeprecated();
					break;
				default:
					mutationsHeart();
					mutationsMuscle();
					mutationsMouth();
					mutationsAdrGland();
					mutationsBloodStream();
					mutationsFaT();
					mutationsLungs();
					mutationsMetabolism();
					mutationsOvaries();
					mutationsTesticles();
					mutationsEyes();
					mutationsBone();
					mutationsPeriNervSys();
					mutationsThyroidGlands();
					mutationsParaThyroidGlands();
					mutationsAdaptations();
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

		/*
		private static function initMutations():void{
			try {
				//Example. Doesn't actually do anything.v
				MutationTemplate.mutationReqs();
				ArachnidBookLungMutation.mutationReqs();
				BlackHeartMutation.mutationReqs();
				KitsuneThyroidGlandMutation.mutationReqs();
				} catch (e:Error) {
					trace(e.getStackTrace());
				}
			}
		initMutations();*/
	}
}