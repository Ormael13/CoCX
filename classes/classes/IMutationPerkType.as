/**
 * Created by aimozg on 26.01.14.
 * Adapted for use for Mutations by Jtecx on 15.05.22.
 */
package classes
{
import classes.Scenes.SceneLib;
import classes.Stats.StatUtils;
import classes.internals.Utils;

public class IMutationPerkType extends PerkType
	{
		/**
		 * For deprecated/not implemented mutations
		 */
		public static const SLOT_NONE:String        = "";
		public static const SLOT_HEART:String       = "Heart";
		public static const SLOT_MUSCLE:String      = "Muscle";
		public static const SLOT_MOUTH:String       = "Mouth";
		public static const SLOT_ADRENALS:String    = "Adrenals";
		public static const SLOT_BLOODSTREAM:String = "Bloodstream";
		public static const SLOT_FAT:String         = "FaT";
		public static const SLOT_LUNGS:String       = "Lungs";
		public static const SLOT_METABOLISM:String  = "Metabolism";
		public static const SLOT_OVARIES:String     = "Ovaries";
		public static const SLOT_TESTICLES:String   = "Testicles";
		public static const SLOT_EYES:String        = "Eyes";
		public static const SLOT_BONE:String        = "Bone";
		public static const SLOT_NERVSYS:String     = "Nerv/Sys";
		public static const SLOT_THYROID:String     = "Thyroid";
		public static const SLOT_PARATHYROID:String = "PThyroid";
		public static const SLOT_ADAPTATIONS:String = "Adaptations";
		// when adding more slots, add an entry in the list below!
		
		/**
		 * key: SLOT_XXX
		 * value: {
		 * 	name: readable name
		 * }
		 */
		public static const Slots:Object = Utils.createMapFromPairs([
			[SLOT_HEART, {name: "Heart"}],
			[SLOT_MUSCLE, {name: "Muscles"}],
			[SLOT_MOUTH, {name: "Mouth"}],
			[SLOT_ADRENALS, {name: "Adrenal glands"}],
			[SLOT_BLOODSTREAM, {name: "Bloodstream"}],
			[SLOT_FAT, {name: "Fat Tissue"}],
			[SLOT_LUNGS, {name: "Lungs"}],
			[SLOT_METABOLISM, {name: "Metabolism"}],
			[SLOT_OVARIES, {name: "Ovaries"}],
			[SLOT_TESTICLES, {name: "Balls"}],
			[SLOT_EYES, {name: "Eyes"}],
			[SLOT_BONE, {name: "Bones and Marrow"}],
			[SLOT_NERVSYS, {name: "NervSys"}],
			[SLOT_THYROID, {name: "Thyroid Gland"}],
			[SLOT_PARATHYROID, {name: "Parathyroid Gland"}],
			[SLOT_ADAPTATIONS, {name: "Adaptations"}]
		]);
		public static const SlotList:/*String*/Array = [
			SLOT_HEART,
			SLOT_MUSCLE,
			SLOT_MOUTH,
			SLOT_ADRENALS,
			SLOT_BLOODSTREAM,
			SLOT_FAT,
			SLOT_LUNGS,
			SLOT_METABOLISM,
			SLOT_OVARIES,
			SLOT_TESTICLES,
			SLOT_EYES,
			SLOT_BONE,
			SLOT_NERVSYS,
			SLOT_THYROID,
			SLOT_PARATHYROID,
			SLOT_ADAPTATIONS
		];
		
		/**
		 * key: SLOT_XXXX
		 * value: IMutationPerkType[]
		 */
		public static const MutationsBySlot:Object = {};
		
		private var _maxLvl:int;
		private var _slot:String;
		private var _pBuffs:Object;
		private var _trueVariant:Boolean;
		private static var _IMvalid:Object = {};
		private static var _IMNotvalid:Object = {};


		public function IMutationPerkType(id:String, name:String, slot:String, maxLvl:int, trueVariant:Boolean = false) {
			//GDI probably pre-initialization issue again
			if (_IMvalid.hasOwnProperty(id)) {
				name += "_errorIM"
				_IMNotvalid[id] = name;
			} else {
				_IMvalid[id] = name;
			}
			super(id, name, name, name, false);
			this._maxLvl = maxLvl;
			this._slot = slot;
			this._trueVariant = trueVariant;
			(MutationsBySlot[slot] ||= []).push(this);
		}

		public function get maxLvl():int{
			return _maxLvl;
		}

		public function get slot():String{
			return _slot;
		}

		public function pReqs(pCheck:int = -1):void{
		}

		public function buffsForTier(pTier:int, target:Creature):Object {
			return _pBuffs;
		}

		public function get trueMutation():Boolean{
			return _trueVariant;
		}
		public function set trueMutation(isTrue:Boolean):void{
			_trueVariant = isTrue;
		}
		public function evolveText():String {
			var descS:String = "";
			return descS;
		}

		public function explainBuffs(pTier:int):String {
			var tempObj:Object = buffsForTier(pTier, player);
			var res:String = "";
			for (var key:String in tempObj)
				if(res != "") res += ", ";
				res += StatUtils.explainBuff(key, tempObj[key]);
			if(res != "") res = "\nBuffs: " + res;
			return res;
		}

		public function pBuffs(target:Creature = null):Object{
			var target2:Creature =(target == null) ? player : target;
			return buffsForTier(currentTier(this, target2), target2);
		}

		public function trueMutationBuffs(statStr:String, pTier:int, racePoint:int):Object{ //Probably wanna pass "xxx.bonus"
			var pBuffs:Object = {};
			pBuffs[statStr] = ((30 + pTier*15)*racePoint)
			return pBuffs
		}

		/**
		 * Returns current target's mutation level. Also prevents circular dependency when checking for tier when mutation has not been initialized yet.
		 *
		 * @param mutate	Type:IMutationPerkType. Takes the mutation in question as arg.
		 * @param target	Type:Creature. 			Takes the target(NPC or player) as arg.
		 * @return			If Mutation exists, then the (int)tier of the mutation. Else, 0.
		 */
		public function currentTier(mutate:IMutationPerkType, target:Creature):int{
			try{
				return target.getPerk(mutate).value1;
			}
			catch (e:Error) {	//If param returns a missing result, is likely because player doesn't have it so cannot query.
				//trace(e);
			}
			return 0;
		}

		//handles Mutations assignment.
		/**
		 * acquireMutation is used to handle adding Mutations to players/NPCs.
		 *
		 * @param target	Type: Creature. 					Takes Player/enemy class as arg. Indicates if the mutation goes to Player or to an NPC.
		 * @param nextFunc	Type: *(String/function). 			Takes "none"/ function as arg. If NPC, put "none", else put in next function it should go to.
		 * @param pTier		Type:Int. Takes perkTier as arg. 	If target is NPC, you can also directly assign a tier to them, to skip having to add the perk in x times.
		 * Note: V1 is used to track Mutation Level, V2 has been taken for mutation self-evolution tracking, V3 is used for verifying if player has the true variant of the Mutation.
		 */
		public function acquireMutation(target:Creature, nextFunc:*, pTier:int = 1):void{
			var mutations:IMutationPerkType = this;
			//trace(mutations.name() + "<--------ACQUIREMUTATIONS RESULT");

			try{
				if (nextFunc == null){
					trace("Missing nextFunc, replacing with playerMenu.");
					EngineCore.outputText("Someone forgot to add a nextFunc to their acquireMutation. Please report this. Perk: " + this.name());
					nextFunc = playerMenu;
				}
				if (target == null){
					trace("Missing target, defaulting to player.");
					EngineCore.outputText("Someone forgot to put a target for this perk in acquireMutation. Please report this. Perk: " + this.name());
					target = player;
				}
				if (!target.hasPerk(mutations)) {	//No Perk, set to 1 or pTier.
					target.createPerk(mutations, pTier,0,0,0);
					if (target == player) {
						if (mutations.trueMutation) EngineCore.outputText(mutations.evolveText());
						EngineCore.outputText(" <b>Acquired " + mutations.name() + "!</b>");
					}
				} else if (pTier > 1) {				//Perk exists, but pTier is > 1.
					target.setPerkValue(mutations, 1, pTier);
				} else {							//Perk is incremented by 1.
					target.setPerkValue(mutations,1,target.perkv1(mutations) + 1);
					if (target == player) {
						if (mutations.trueMutation) EngineCore.outputText(mutations.evolveText());
						EngineCore.outputText(" <b>Acquired " + mutations.name() + "!</b>");
					}
				}
				setBuffs();
				//trace("Perk applied.");

			} catch(e:Error){
				trace(e.getStackTrace());
				EngineCore.outputText("Something has gone wrong with acquireMutation. Please report this to JTecx along with which mutation was selected, along with the bonk stick.");
				EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
			}
			if (nextFunc != "none") nextFunc();	//"none" is a much more explicit statement... though I suppose it can be replaced to a `false` instead....

			//Sets up the buff for the perk.
			function setBuffs():void{
				var stname:String = "perk_" + mutations.id;
				var pBuff:Object = mutations.pBuffs(target)
				if (target.statStore.hasBuff(stname)){
					target.statStore.removeBuffs(stname);
				}
				target.statStore.addBuffObject(
						pBuff,
						stname,
						{text:mutations.name(), save:false}
				);
				//trace("Perk Buffs Applied.");
			}
		}

		/**
		 * updateDynamicPerkBuffs is used in case mutation buffs need to be reapplied/refreshed.
		 *
		 * @param target	Type: Creature. Takes Player/enemy class as arg. Indicates if the mutation goes to Player or to an NPC.
		 */

		//Updates existing mutations with new buff values.
		public function updateDynamicPerkBuffs(target:Creature):void{
			if(target == null){
				trace("Missing target, defaulting to player.");
				EngineCore.outputText("Someone forgot to put a target for this perk in updateDynamicPerkBuffs. Please report this. Perk: " + this.name());
				target = player;
			}
			var stname:String = "perk_" + this.id;
			var pBuff:Object = this.pBuffs(target);
			if (target.statStore.hasBuff(stname)){
				target.statStore.removeBuffs(stname);
			}
			target.statStore.addBuffObject(
					pBuff,
					stname,
					{text:this.name(), save:false}
			);
			//trace("Perk Buffs Updated.");
		}
		//Name. Need it say more?
		override public function name(params:PerkClass=null):String {
			var sufval:String;
			switch (currentTier(this, player)){
				case 2:
					sufval = "(Primitive)";
					break;
				case 3:
					sufval = "(Evolved)";
					break;
				case 4:
					sufval = "(Final Form)";
					break;
				default:
					sufval = "";
			}
			return this.mName + sufval;
		}

		public function get mName():String {
			return "";
		}


		public static function get runValidIMutates():String {
			if (_IMNotvalid != {}) {
				for (var badIM:String in _IMNotvalid) {
					outputText("[font-red]<b><i>ERROR: IMutation " + badIM + " is invalid. Please report this to the devs, and ask them to check the latest IMutation released. \nMeanwhile, DO NOT PURCHASE/UPGRADE THE NEW, OR AFFECTED PERK.</i></b> \n\n[/font]");
				}
			}
			return ""
		}
	}
}
