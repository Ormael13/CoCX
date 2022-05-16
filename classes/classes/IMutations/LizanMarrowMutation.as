/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Player;

public class LizanMarrowMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.LizanMarrowIM);
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
            switch (player.perkv1(IMutationsLib.LizanMarrowIM)){
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
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.LizanMarrowIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.LizanMarrowIM.requireBonesAndMarrowMutationSlot()
                    .requirePerk(PerkLib.LizanRegeneration).requireCustomFunction(function (player:Player):Boolean {
                        return player.lizardScore() >= 8;
                    }, "Lizan race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.LizanMarrowIM.requireLevel(pLvl);
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
            return pBuffs;
        }

        public function LizanMarrowMutation() {
            super("Lizan Marrow IM", "Lizan Marrow", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}