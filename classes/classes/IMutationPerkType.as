/**
 * Created by aimozg on 26.01.14.
 * Adapted for use for Mutations by Jtecx on 15.05.22.
 */
package classes
{
import classes.Scenes.SceneLib;

public class IMutationPerkType extends PerkType
	{
		private var _maxLvl:int = 3;
		private var _pBuffs:Object;

		public function IMutationPerkType(id:String, name:String, desc:String, longDesc:String = null, keepOnAscension:Boolean = false) {
			super(id, name, desc, longDesc, keepOnAscension);
		}

		public function get maxLvl():int{
			return _maxLvl;
		}

		public function set maxLvl(Lvl:int):void{
			_maxLvl = Lvl;
		}

		public function pReqs():void{
		}

		public function pBuffs(target:Creature = null):Object{
			return _pBuffs;
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
				} else if (pTier > 1) {				//Perk exists, but pTier is > 1.
					target.setPerkValue(mutations, 1, pTier);
				} else {							//Perk is incremented by 1.
					target.setPerkValue(mutations,1,target.perkv1(mutations) + 1);
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
	}
}