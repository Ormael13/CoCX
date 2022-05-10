/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Tail;
import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class ManticoreMetabolismMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
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

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            return pBuffs;
        }

        public function ManticoreMetabolismMutation() {
            super("Manticore Metabolism IM", "Manticore Metabolism", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}