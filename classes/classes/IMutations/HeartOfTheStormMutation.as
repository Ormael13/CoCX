/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class HeartOfTheStormMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.HeartOfTheStormIM);
            if (pTier >= 1){
                descS += "Increase the power of all Wind and Lightning racial abilities";
            }
            if (pTier >= 3){
                descS += ", you can fly continuously as long as you yourself can fly, if you have enery attacks they now include a chance to stun";
            }
            if (pTier >=2){
                descS += " and you increase wind and electricity resistance by ";
                if (pTier == 2) descS += "10%";
                if (pTier == 3) descS += "30%";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.HeartOfTheStormIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Heart Of The Storm" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.HeartOfTheStormIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.HeartOfTheStormIM.requireHeartMutationSlot()
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.raijuScore() >= 10 || player.thunderbirdScore() >= 12 || player.kamaitachiScore() >= 14 || player.couatlScore() >= 11;
                        }, "Stormborn race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.HeartOfTheStormIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['spe.mult'] += 0.05;
            if (pTier >= 2) pBuffs['spe.mult'] += 0.1;
            if (pTier >= 3) pBuffs['spe.mult'] += 0.2;
            return pBuffs;
        }

        public function HeartOfTheStormMutation() {
            super("Heart Of The Storm IM", "Heart Of The Storm", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}