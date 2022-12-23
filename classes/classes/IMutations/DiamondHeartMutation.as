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

public class DiamondHeartMutation extends IMutationPerkType
    {
        private static const mName:String = "Diamond Heart";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Azazel.M Specials are available even if you do not qualify as Azazel";
            }
            if (pTier == 2){
                descS += ", Perfect Clarity duration is increased by 5 turns and spellpower is boosted by 25%, Judgement Flare +~25%";
            }
            if (pTier == 3){
                descS += ", Perfect Clarity duration is increased by 5 turns and spellpower is boosted by 150% + lowers physical resistance reduction by 15%, Judgement Flare +~65% and 20% higher chance to crit";
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
                    this.requireHeartMutationSlot()
                    .requireCor(0).requireRace(Races.AZAZEL);
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
            if (pTier == 3) {
                pBuffs['str.mult'] = 0.05;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            return pBuffs;
        }

        public function DiamondHeartMutation() {
            super(mName + " IM", mName, SLOT_HEART, 3);
        }

    }
}
