/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;
import classes.Races;

public class TrachealSystemMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
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

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 4;
        }

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
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
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}
