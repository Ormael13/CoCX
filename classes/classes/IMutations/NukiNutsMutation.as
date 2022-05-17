/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class NukiNutsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.NukiNutsIM);
            if (pTier >= 1){
                descS += "Gain a natural armor bonus based on your ball size, prevent the loss of money strike";
            }
            if (pTier >= 2){
                descS += ", increases cum production, cumming has a chance of producing gems";
            }
            if (pTier >= 3){
                descS += ", and doubles Money Strike damage";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.NukiNutsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Nuki Nuts" + sufval;
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
                IMutationsLib.NukiNutsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.NukiNutsIM.requireBallsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.raccoonScore() >= 4 && player.balls > 0 && player.ballSize > 5;
                    }, "Tanuki race and large balls");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.NukiNutsIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            if (pTier == 3) pBuffs['lib.mult'] = 0.3;
            return pBuffs;
        }

        public function NukiNutsMutation() {
            super("Nuki Nuts IM", "Nuki Nuts", ".");
            maxLvl = 3;
        }

        
    }
}