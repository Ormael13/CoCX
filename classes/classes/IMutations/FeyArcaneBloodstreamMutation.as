/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class FeyArcaneBloodstreamMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.FeyArcaneBloodstreamIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.FeyArcaneBloodstreamIM.requireBloodsteamMutationSlot()
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.fairyScore() >= 23;
                    }, "Fairy race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.FeyArcaneBloodstreamIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier >= 1) pBuffs['int.mult'] += 0.05;
            if (pTier >= 2) pBuffs['int.mult'] += 0.1;
            if (pTier >= 3) pBuffs['int.mult'] += 0.2;            return pBuffs;
        }

        public function FeyArcaneBloodstreamMutation() {
            super("Fey Arcane Bloodstream IM", "Fey Arcane Bloodstream", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}