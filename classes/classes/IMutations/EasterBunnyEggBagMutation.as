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

public class EasterBunnyEggBagMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.EasterBunnyEggBagIM);
            if (pTier >= 1){
                descS += "Keep oviposition, easter bunny balls and egg throw ability so long as you have balls. May now shoot more then one egg per round";
            }
            if (pTier >= 2){
                descS += ", Raise libido by a percentage based on current balls size";
            }
            if (pTier >= 3){
                descS += ", Further raise libido by a percentage based on current balls size. Double balls growth rates and";
            }
            if (pTier == 1) descS += " x2";
            if (pTier == 2) descS += " x3";
            if (pTier == 3) descS += " x6";
            if (pTier >= 1) descS += " cum production";
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.EasterBunnyEggBagIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Easter Bunny Egg Bag" + sufval;
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
                IMutationsLib.EasterBunnyEggBagIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.EasterBunnyEggBagIM.requireBallsMutationSlot()
                    .requirePerk(PerkLib.EasterBunnyBalls)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.easterbunnyScore() >= 12;
                    }, "Easter Bunny race and Easter bunny balls.");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.EasterBunnyEggBagIM.requireLevel(pLvl);
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

        public function EasterBunnyEggBagMutation() {
            super("Easter Bunny Egg Bag IM", "Easter Bunny Egg Bag", ".");
            maxLvl = 3;
        }

        
    }
}