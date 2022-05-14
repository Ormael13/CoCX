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

public class RatatoskrSmartsMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.RatatoskrSmartsIM);
            if (pTier >= 1){
                descS += "Allows you to perm Weird words";
            }
            if (pTier >= 3){
                descS += ", knowledge is power is now three times as effective";
            }
            if (pTier >= 2){
                descS += ", increase the damage of Weird words by" + (pTier == 2)?"20%":((pTier == 3)?"50%":"") + ", lower cooldown of Knowledge overload by" +(pTier == 2)?"1":((pTier == 3)?"2":"") + "turns";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.RatatoskrSmartsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Ratatoskr Smarts" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.RatatoskrSmartsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.RatatoskrSmartsIM.requirePeripheralNervSysMutationSlot()
                    .requirePerk(PerkLib.KnowledgeIsPower).requireCustomFunction(function (player:Player):Boolean {
                        return player.ratatoskrScore() >= 12;
                    }, "Squirrel/Ratatoskr race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.RatatoskrSmartsIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['int.mult'] = 0.05;
            if (pTier == 2) pBuffs['int.mult'] = 0.15;
            if (pTier == 3) pBuffs['int.mult'] = 0.35;
            return pBuffs;
        }

        public function RatatoskrSmartsMutation() {
            super("Ratatoskr Smarts IM", "Ratatoskr Smarts", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}