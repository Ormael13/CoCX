/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class FrozenHeartMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.FrozenHeartIM);
            if (pTier >= 1){
                descS += "Allow you to retain the ability Ice barrage and hungering cold at all times";
            }
            if (pTier >= 3){
                descS += ", hungering cold lasts for 3 additional turn(s) and recharge 3 turn(s) faster. Gain an extra modifier from your intelligence to health. (Increase original value by 50%).";
            }
            else if (pTier >= 2){
                descS += "hungering cold last for 1 additional turn and recharge 1 turn faster";
            }
            if (pTier >= 1) descS += "and increase their damage by" + 10 * pTier + "%";
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.FrozenHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Frozen Heart" + sufval;
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
                IMutationsLib.FrozenHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.FrozenHeartIM.requireHeartMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.yukiOnnaScore() >= 14;
                    }, "Yuki onna race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.FrozenHeartIM.requireLevel(pLvl);
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

        public function FrozenHeartMutation() {
            super("Frozen Heart IM", "Frozen Heart", ".");
            maxLvl = 3;
        }

        
    }
}