/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations 
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class HumanBloodstreamMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Bloodstream";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1) descS += "Increases maximum base/core Spe/Lib by ";
            if (pTier == 1){
                descS += "5.";
            }
            if (pTier == 2){
                descS += "10. Increases fatigue recovery by (+5) and wrath generation (+2).";
            }
            if (pTier == 3){
                descS += "10, maximum trainable Spe/Lib by 20%. Increases fatigue recovery by (+10) and wrath generation (+4).";
            }
            if (pTier == 4){
                descS += "20, maximum trainable Spe/Lib by 30%. Increase fatigue recovery (+15), wrath generation (+6) and +2 to fatigue recovery/wrath gains multiplier. +5% to max overfatigue/overwrath.";
            }
            if (pTier >= 1) descS += " (req. 18+ human score to have all effects active)";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireBloodsteamMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.racialScore(Races.HUMAN) > 16;
                    }, "Human race (17+)");
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            if (pTier == 1) {
				pBuffs['spe.mult'] = 0.1;
				pBuffs['lib.mult'] = 0.1;
			}
            if (pTier == 2) {
				pBuffs['spe.mult'] = 0.2;
				pBuffs['lib.mult'] = 0.2;
			}
            if (pTier == 3) {
				pBuffs['spe.mult'] = 0.4;
				pBuffs['lib.mult'] = 0.4;
			}
            if (pTier == 4) {
				pBuffs['spe.mult'] = 0.8;
				pBuffs['lib.mult'] = 0.8;
			}
            return pBuffs;
        }

        public function HumanBloodstreamMutation() 
		{
			super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
		}
		
	}

}
