/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class WhaleFatMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.WhaleFatIM);
            var pHunger:int = 0;
            if (pTier >= 1) descS += "Increased damage reduction against physical damage and grants cold resistance permanently";
            if (pTier == 2){
                descS += ", juggle duration is increased by 1";
            }
            if (pTier == 3){
                descS += ", juggle duration is increased by 2";
            }
            while (pTier != 0){
                pHunger += 5*pTier;
                pTier--;
            }
            if (pTier >= 1) descS += ", Increase max hunger cap by " + pHunger + "";
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.WhaleFatIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Whale Fat" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.WhaleFatIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.WhaleFatIM.requireFatTissueMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.orcaScore() >= 14 || player.leviathanScore() >= 20;
                    }, "Orca race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.WhaleFatIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            else if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function WhaleFatMutation() {
            super("Whale Fat IM", "Whale Fat", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}