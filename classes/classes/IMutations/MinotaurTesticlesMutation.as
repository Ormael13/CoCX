/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class MinotaurTesticlesMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MinotaurTesticlesIM);
            if (pTier >= 1){
                descS += "Allows you to keep Cum Cannon special even if minotaur score is lower than 9, max Lust increased by 10.";
            }
            if (pTier >= 2){
                descS += ", +5% to lust resistance, increase cum output by 200 mLs";
            }
            if (pTier >= 3){
                descS += ", +5 to max tou an +10 to max str/lib, increase cum production by ~100%, +90 to max lust and Cum Cannon cost rise to 200 lust but can be used more than once per fight";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.MinotaurTesticlesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Minotaur Testicles" + sufval;
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
                IMutationsLib.MinotaurTesticlesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.MinotaurTesticlesIM.requireBallsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasCock();
                    }, "is Male")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity <= 5;
                    }, "5- feminity")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.minotaurScore() >= 10;
                    }, "Minotaur race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.MinotaurTesticlesIM.requireLevel(pLvl);
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
            if (pTier == 2) pBuffs['lib.mult'] = 0.1;
            if (pTier == 3){
                pBuffs['str.mult'] = 0.1;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['lib.mult'] = 0.2;
            }
            return pBuffs;
        }

        public function MinotaurTesticlesMutation() {
            super("Minotaur Testicles IM", "Minotaur Testicles", ".");
            maxLvl = 3;
        }

        
    }
}