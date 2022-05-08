/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class FloralOvariesMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.FloralOvariesIM);
            if (pTier >= 1){
                descS += "Potency on Alraune pollen increases with rank";
            }
            if (pTier >= 2){
                descS += ", males take an extra 50% lust damage";
            }
            if (pTier >= 3){
                descS += ", Alraune pollen has a 25% chance every round to fascinate victims";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.FloralOvariesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Floral Ovaries" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.FloralOvariesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.FloralOvariesIM.requireOvariesMutationSlot()
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.alrauneScore() >= 13;
                    }, "Alraune race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.FloralOvariesIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['lib.mult'] += 0.05;
            if (pTier >= 2) pBuffs['lib.mult'] += 0.1;
            if (pTier >= 3) pBuffs['lib.mult'] += 0.2;            return pBuffs;
        }

        public function FloralOvariesMutation() {
            super("Floral Ovaries IM", "Floral Ovaries", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}