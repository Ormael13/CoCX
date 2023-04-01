/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class WhaleFatMutation extends IMutationPerkType
    {
        private static const mName:String = "Whale Fat";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            var pHunger:int = 0;
            if (pTier >= 1) descS += "Increased damage reduction against physical damage and grants cold resistance permanently";
            if (pTier == 2){
                descS += ", juggle duration is increased by 1";
            }
            if (pTier == 3){
                descS += ", juggle duration is increased by 2";
            }
            while (pTier != 0){
                pHunger += 5*pTier;
                pTier--;
            }
            if (pTier >= 1) descS += ", Increase max hunger cap by " + pHunger + "";
            if (descS != "")descS += ".";
            return descS;
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
                default:
                    sufval = "";
            }
            return mName + sufval;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireFatTissueMutationSlot()
                    .requireAnyRace(Races.ORCA, Races.SEA_DRAGON);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function WhaleFatMutation() {
            super(mName + " IM", mName, SLOT_FAT, 3);
        }
        
    }
}
