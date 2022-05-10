/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
import classes.PerkLib;
import classes.PerkType;
import classes.Player;

public class EasterBunnyEggBagMutation extends PerkType
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
            descS += " cum production";
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
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.EasterBunnyEggBagIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.EasterBunnyEggBagIM.requireBallsMutationSlot()
                            .requirePerk(PerkLib.EasterBunnyBalls).requireCustomFunction(function (player:Player):Boolean {
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

        public function EasterBunnyEggBagMutation() {
            super("Easter Bunny Egg Bag IM", "Easter Bunny Egg Bag", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}