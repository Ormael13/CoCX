/**
 * Created by aimozg on 26.01.14.
 * Adapted for use for Mutations by Jtecx on 15.05.22.
 */
package classes
{
import classes.GlobalFlags.kFLAGS;
import classes.IMutationPerkType;
import classes.Scenes.SceneLib;
import classes.Stats.StatUtils;

import flash.utils.Dictionary;

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

		public function pReqs(target:* = null):void{
		}

		public function pBuffs(target:* = null):Object{
			return _pBuffs;
		}

		public function acquireMutation(target:* = null, nextFunc:* = null, pTier:int = 1):void{
			var mutations:IMutationPerkType = this;
			//trace(mutations.name() + "<--------ACQUIREMUTATIONS RESULT");

			try{
				if (nextFunc == null){
					trace("Missing nextFunc, replacing with playerMenu.");
					EngineCore.outputText("Someone forgot to add a nextFunc to their acquireMutation. Please report this. Perk: " + this.name());
					nextFunc = playerMenu;
				}
				if(target == null){
					trace("Missing target, defaulting to player.");
					EngineCore.outputText("Someone forgot to put a target for this perk in acquireMutation. Please report this. Perk: " + this.name());
					target = player;
				}
				if (!target.hasPerk(mutations)){
					target.createPerk(mutations, 1,0,0,0);
				}
				else if(pTier > 1){
					target.createPerk(mutations, pTier,0,0,0);
				}
				else{
					target.setPerkValue(mutations,1,target.perkv1(mutations) + 1);
				}
				setBuffs();
				//trace("Perk applied.");

			} catch(e:Error){
				trace(e.getStackTrace());
				EngineCore.outputText("Something has gone wrong with Dynamic Perks. Please report this to JTecx along with which perk/mutation was selected, along with the bonk stick.");
				EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
			}
			if (nextFunc != "none") nextFunc();

			//Sets up the buff for the perk.
			function setBuffs():void{
				var stname:String = "mutation_" + mutations.id;
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

		public function updateDynamicPerkBuffs(target:*):*{
			if(target == null){
				trace("Missing target, defaulting to player.");
				EngineCore.outputText("Someone forgot to put a target for this perk in updateDynamicPerkBuffs. Please report this. Perk: " + this.name());
				target = player;
			}
			var stname:String = "mutation_" + this.id;
			var pBuff:Object = this.pBuffs;
			if (target.statStore.hasBuff(stname)){
				target.statStore.removeBuffs(stname);
			}
			else{
				trace("Warning: Perk Buff update failed either due to perk not existing, or buff was never applied in the first place.");
			}
			trace(this.name() + ": ");
			for(var id:String in pBuff) {
				var value:Object = pBuff[id];

				trace(id + " = " + value);
			}
			trace("^^^^^^^^^^^^^^^^^^^^^^^^^^^^PERK")
			target.statStore.addBuffObject(
					pBuff,
					stname,
					{text:this.name(), save:false}
			);
			trace("Perk Buffs Updated.");
		}
	}
}