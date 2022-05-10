/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class MelkieLungMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MelkieLungIM);
            if (pTier == 1){
                descS = "Increase damage reduction against spells by 5% and increase the power of compelling aria by 20%, Compelling Aria is kept at all time";
            }
            if (pTier == 2){
                descS = "Increase damage reduction against spells by 15% and increase the power of compelling aria by 50%. Compelling Aria now has an Intelligence scaling";
            }
            if (pTier == 3){
                descS = "Increase damage reduction against spells by 30% and increase the power of compelling aria by 90%. Compelling Aria intelligence scaling is doubled";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.MelkieLungIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Melkie Lung" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.MelkieLungIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.MelkieLungIM.requireLungsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.melkieScore() >= 18;
                    }, "Melkie race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.MelkieLungIM.requireLevel(pLvl);
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

        public function MelkieLungMutation() {
            super("Melkie Lung IM", "Melkie Lung", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}