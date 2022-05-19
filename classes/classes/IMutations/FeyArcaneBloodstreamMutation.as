/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class FeyArcaneBloodstreamMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM);
            if (pTier >= 1){
                descS += "Your Fey Arcane Bloodstream grants you an eternal lifespan, increased mana recovery and increased magical power";
            }
            if (pTier >= 2){
                descS += ", as well as increasing the chance that chaotic magic you invoke will trigger additional effects";
            }
            if (pTier >= 3){
                descS += ", and increase said damage by 50%";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.FeyArcaneBloodstreamIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Fey Arcane Bloodstream" + sufval;
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
                IMutationsLib.FeyArcaneBloodstreamIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.FeyArcaneBloodstreamIM.requireBloodsteamMutationSlot()
                    .requireRace(Races.FAIRY);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.FeyArcaneBloodstreamIM.requireLevel(pLvl);
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
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            if (pTier == 1) pBuffs['int.mult'] = 0.05;
            if (pTier == 2) pBuffs['int.mult'] = 0.15;
            if (pTier == 3) pBuffs['int.mult'] = 0.35;            return pBuffs;
        }

        public function FeyArcaneBloodstreamMutation() {
            super("Fey Arcane Bloodstream IM", "Fey Arcane Bloodstream", ".");
            maxLvl = 3;
        }

        
    }
}
