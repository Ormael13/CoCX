/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class TrachealSystemMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.TrachealSystemIM);
            if (pTier >= 1) descS += "Your body possesses a ";
            if (pTier == 1){
                descS += "rudimentary";
            }
            if (pTier == 2){
                descS += "basic";
            }
            if (pTier == 3){
                descS += "half developed";
            }
            if (pTier == 4){
                descS += "fully developed";
            }
            if (descS != "")descS += " respiratory system modeled after insects.";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.TrachealSystemIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                case 4:
                    sufval = "(Final Form)";
                    break;
                default:
                    sufval = "";
            }
            return "Tracheal System" + sufval;
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
                IMutationsLib.TrachealSystemIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.TrachealSystemIM.requireCustomFunction(function (player:Player):Boolean {
                        return player.beeScore() >= 14 || player.mantisScore() >= 12 || player.scorpionScore() >= 4 || player.spiderScore() >= 5 || player.isRace(Races.CANCER) || player.isRace(Races.ATLACH_NACHA);
                    }, "Any insect race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.TrachealSystemIM.requireLevel(pLvl);
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
            if (pTier == 1){
                pBuffs['str.mult'] = 0.01;
                pBuffs['spe.mult'] = 0.02;
            }
            else if (pTier == 2){
                pBuffs['str.mult'] = 0.03;
                pBuffs['spe.mult'] = 0.05;
                pBuffs['tou.mult'] = 0.01;
            }
            else if (pTier == 3){
                pBuffs['str.mult'] = 0.07;
                pBuffs['spe.mult'] = 0.1;
                pBuffs['tou.mult'] = 0.04;
            }
            else if (pTier == 4){
                pBuffs['str.mult'] = 0.15;
                pBuffs['spe.mult'] = 0.2;
                pBuffs['tou.mult'] = 0.1;
            }
            return pBuffs;
        }

        public function TrachealSystemMutation() {
            super("Tracheal System IM", "Tracheal System", ".");
            maxLvl = 4;
        }

        
    }
}
