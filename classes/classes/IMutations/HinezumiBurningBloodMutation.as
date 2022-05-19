/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Arms;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class HinezumiBurningBloodMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.HinezumiBurningBloodIM);
            if (pTier >= 1) descS += "Increase the healing from the cauterize ability by 0.5%";
            if (pTier >= 3){
                descS += ", allows you to use Cauterize even if you're no longer a Hinezumi";
            }
            if (pTier >= 1) descS += "and raise Blazing battle spirit duration by "
            if (pTier == 1){ //Could have used tier....
                descS += "1";
            }
            if (pTier == 2){///but...
                descS += "2";
            }
            if (pTier == 3){///WHAM, 7. CAUSE WHY NOT.
                descS += "7";
            }
            if (descS != "")descS += " round(s).";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.HinezumiBurningBloodIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Hinezumi Burning Blood" + sufval;
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
                IMutationsLib.HinezumiBurningBloodIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.HinezumiBurningBloodIM.requireBloodsteamMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.arms.type == Arms.HINEZUMI;
                    }, "Hinezumi arms")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.lowerBody == LowerBody.HINEZUMI;
                    }, "Hinezumi legs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.tailType == Tail.HINEZUMI;
                    }, "Hinezumi tail")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.mouseScore() >= 12;
                    }, "Hinezumi race (Mouse 12+)");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.HinezumiBurningBloodIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function HinezumiBurningBloodMutation() {
            super("Hinezumi Burning Blood IM", "Hinezumi Burning Blood IM", ".");
            maxLvl = 3;
        }

        
    }
}