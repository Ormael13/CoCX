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
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MutationsTemplateIM);
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
            switch (player.perkv1(IMutationsLib.MutationsTemplateIM)){
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
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.MutationsTemplateIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.MutationsTemplateIM.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.MutationsTemplateIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }


        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var pTier:int = target.perkv1(IMutationsLib.MutationsTemplateIM);
            if (pTier == 1) {
                pBuffs['spe.mult'] = 0;
            }
            if (pTier == 2){
                pBuffs['spe.mult'] = 0;
            }
            if (pTier == 3){
                pBuffs['spe.mult'] = 0;
            }
            return pBuffs;
        }

        public function MutationTemplate() {
            super("PerkName Here IM", "PerkName Here", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}