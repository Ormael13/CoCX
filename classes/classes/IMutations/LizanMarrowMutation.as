/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class LizanMarrowMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Regenerates 0.5% of HP per round in combat and 1% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.";
            }
            if (pTier == 2){
                descS = "Regenerates 1% of HP per round in combat and 2% of HP per hour. Additionaly your limit for innate self-regeneration rate increased.";
            }
            if (pTier == 3){
                descS = "Regenerates 1.5% of HP per round in combat and 3% of HP per hour. Additionaly your limit for innate self-regeneration rate increased. When below 25% of max HP regeneration provided by Lizan regeneration doubles. You can't lose by HP until your health drops into the negatives more than 5% of max HP.";
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
            return "Lizan Marrow" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireBonesAndMarrowMutationSlot()
                    .requirePerk(PerkLib.LizanRegeneration).requireRace(Races.LIZARD);
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
        override public function pBuffs(target:Creature = null):Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this, (target == null)? player : target);
            return pBuffs;
        }

        public function LizanMarrowMutation() {
            super("Lizan Marrow IM", "Lizan Marrow", SLOT_BONE, 3);
        }

    }
}
