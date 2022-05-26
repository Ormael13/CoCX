/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.IMutationPerkType;
import classes.PerkClass;

    public class MutationTemplate extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += ", ";
            }
            if (pTier >= 3){
                descS += ", ";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "PerkName Here" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                //This can return a null, thus why all mutations are provided to the player with v1 value of 0 on initial loading.
                var pTier:int = currentTier(this);

                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireHeartMutationSlot();
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
        override public function pBuffs():Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this);
            /*
            if (pTier == 1) {
                pBuffs['spe.mult'] = 0;
            }
            if (pTier == 2){
                pBuffs['spe.mult'] = 0;
            }
            if (pTier == 3){
                pBuffs['spe.mult'] = 0;
            }*/
            return pBuffs;
        }

        public function MutationTemplate() {
            super("PerkName Here IM", "PerkName Here", ".");
            maxLvl = 3;
        }

    }
}