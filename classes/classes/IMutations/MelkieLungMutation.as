/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class MelkieLungMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MelkieLungIM);
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
            switch (player.perkv1(IMutationsLib.MelkieLungIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Melkie Lung" + sufval;
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
                IMutationsLib.MelkieLungIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.MelkieLungIM.requireLungsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.melkieScore() >= 18;
                    }, "Melkie race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.MelkieLungIM.requireLevel(pLvl);
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

        public function MelkieLungMutation() {
            super("Melkie Lung IM", "Melkie Lung", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}