/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
    import classes.Player;

public class LactaBovinaOvariesMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.LactaBovinaOvariesIM);
            if (pTier >= 1){
                descS += "Allows you to keep the Milk Blast special even if cow score is lower than 9, max lust increased by 10";
            }
            if (pTier >= 2){
                descS += ", +5% to lust resistance, increase lactation output by 200 mLs";
            }
            if (pTier >= 3){
                descS += ", +5 to max tou an +10 to max str/lib, increase milk production by ~100%, +90 to max lust and Milk Blast cost is increaed to 200 lust but can be used more than once per fight";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.LactaBovinaOvariesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Lacta Bovina Ovaries" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.LactaBovinaOvariesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.LactaBovinaOvariesIM.requireOvariesMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasVagina();
                    }, "is Female")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity >= 95;
                    }, "95+ feminity")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.cowScore() >= 10;
                    }, "Lacta Bovine race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.LactaBovinaOvariesIM.requireLevel(pLvl);
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
            if (pTier == 2) pBuffs['lib.mult'] = 0.1;
            if (pTier == 3){
                pBuffs['str.mult'] = 0.1;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['lib.mult'] = 0.2;
            }
            return pBuffs;
        }

        public function LactaBovinaOvariesMutation() {
            super("Lacta Bovina Ovaries IM", "Lacta Bovina Ovaries", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}