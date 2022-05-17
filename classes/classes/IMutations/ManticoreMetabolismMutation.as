/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Tail;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class ManticoreMetabolismMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.ManticoreMetabolismIM);
            if (pTier >= 1){
                descS += "Speed is increased with cum intake for a few hours, and allows you to attack with multiple spikes at once";
            }
            if (pTier >= 2){
                descS += ", further increases speed by 100% per NG+ for 5 hours longer, venom recharge when using Manticore feed is twice as effective and increases max hunger by 50";
            }
            if (pTier >= 3){
                descS += ", spikes deal twice as much damage and lust, speed is increased by another 100%, and if you have manticore tail, straddle damage is greatly increased and direct tail feeding is twice as difficult to remove.";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.ManticoreMetabolismIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Manticore Metabolism" + sufval;
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
                IMutationsLib.ManticoreMetabolismIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.ManticoreMetabolismIM.requireMetabolismMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.manticoreScore() >= 15 && player.tailType == Tail.MANTICORE_PUSSYTAIL;
                    }, "Manticore race and tail");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.ManticoreMetabolismIM.requireLevel(pLvl);
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

        public function ManticoreMetabolismMutation() {
            super("Manticore Metabolism IM", "Manticore Metabolism", ".");
            maxLvl = 3;
        }

        
    }
}