/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class NukiNutsMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
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

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            var buffVal:Number = 0;
            if (pTier >= 1) buffVal += 0.05;
            if (pTier >= 2) buffVal += 0.1;
            if (pTier >= 3) buffVal += 0.15;
            pBuffs['lib.mult'] = buffVal;
            return pBuffs;
        }

        public function NukiNutsMutation() {
            super("Nuki Nuts IM", "Nuki Nuts", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}