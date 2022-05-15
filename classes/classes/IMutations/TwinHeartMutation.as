/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class TwinHeartMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.TwinHeartIM);
            if (pTier == 1){
                descS = "+40% fatigue recovery and +5 to max tou/spe (scalable). +100% fatigue recovery, reduce Charge fatigue cost by 10% as well as its cooldown by 1 round so long as your body is tauric/drider. (Also raise all Taur race score by 1, by 2 as long pc is tauric/drider)";
            }
            if (pTier == 2){
                descS = "+80% fatigue recovery and +15 to max tou/spe (scalable). +200% fatigue recovery, reduce Charge fatigue cost by 20%, increase damage by 20%, its cooldown by 2 rounds so long as your body is tauric/drider. (Also raise all Taur race score by 2, by 4 as long pc is tauric/drider)";
            }
            if (pTier == 3){
                descS = "+120% fatigue recovery and +45 to max tou/spe (scalable). +300% fatigue recovery, reduce Charge fatigue cost by 30%, increase damage by 80%, its cooldown by 3 rounds so long as your body is tauric/drider. (Also raise all Taur race score by 3, by 6 as long pc is tauric/drider)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.TwinHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Twin Heart" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.TwinHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.TwinHeartIM.requireAdaptationsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.centaurScore() >= 8 || player.unicornScore() >= 12 || player.sphinxScore() >= 14 || player.cancerScore() >= 13 || player.isTaur() || player.isDrider();
                    }, "Taur/Drider or Unicorn/Bicorn race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.TwinHeartIM.requireLevel(pLvl);
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
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier == 1) {
                pBuffs['tou.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            else if (pTier == 2) {
                pBuffs['tou.mult'] = 0.15;
                pBuffs['spe.mult'] = 0.15;
            }
            else if (pTier == 3) {
                pBuffs['tou.mult'] = 0.45;
                pBuffs['spe.mult'] = 0.45;
            }
            return pBuffs;
        }

        public function TwinHeartMutation() {
            super("Twin Heart IM", "Twin Heart", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}