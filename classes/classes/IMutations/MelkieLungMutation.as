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

public class MelkieLungMutation extends IMutationPerkType
    {
        private static const mName:String = "Melkie Lung";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Increase damage reduction against spells by 5% and increase the power of compelling aria by 20%, Compelling Aria is kept at all time";
            }
            if (pTier == 2){
                descS = "Increase damage reduction against spells by 15% and increase the power of compelling aria by 50%. Compelling Aria now has an Intelligence scaling";
            }
            if (pTier == 3){
                descS = "Increase damage reduction against spells by 30% and increase the power of compelling aria by 90%. Compelling Aria intelligence scaling is doubled";
            }
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
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireLungsMutationSlot()
                    .requireRace(Races.MELKIE);
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
        override public function buffsForTier(pTier:int):Object {
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function MelkieLungMutation() {
            super(mName + " IM", mName, SLOT_LUNGS, 3);
        }
        
    }
}
