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

public class ElvishPeripheralNervSysMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var pTier:int = player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM);
            var perChg:int = 5 * pTier
            var descS:String = "Your Elvish Peripheral NervSys is giving you +" + perChg +"% of max core Spe as phantom Spe and allows you to keep Elven Sense even without elf arms/legs";
            /*
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += ", ";
            }*/
            if (pTier >= 3){
                descS += ", increases your natural evasion, and decrease melee/range accuracy penalty when using multiattack options. Elven signature abilities will keep working regardless if you are a full blooded elf or not";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Elvish Peripheral NervSys" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.ElvishPeripheralNervSysIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.ElvishPeripheralNervSysIM.requirePeripheralNervSysMutationSlot()
                            .requirePerk(PerkLib.ElvenSense)
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.elfScore() >= 11 || player.woodElfScore() >= 22;
                    }, "Elf race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.ElvishPeripheralNervSysIM.requireLevel(pLvl);
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
            if (pTier >= 2) pBuffs['int.mult'] += 0.05;
            if (pTier >= 3) pBuffs['int.mult'] += 0.05;            return pBuffs;
        }

        public function ElvishPeripheralNervSysMutation() {
            super("Elvish Peripheral NervSys IM", "Elvish Peripheral NervSys", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}