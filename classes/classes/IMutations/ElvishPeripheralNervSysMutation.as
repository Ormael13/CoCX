/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class ElvishPeripheralNervSysMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var pTier:int = player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM);
            var perChg:int = 5 * pTier
            var descS:String = "";
            if (pTier >= 1) descS += "Your Elvish Peripheral NervSys is giving you +" + perChg +"% of max core Spe as phantom Spe and allows you to keep Elven Sense even without elf arms/legs";
            /*
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
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.ElvishPeripheralNervSysIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.ElvishPeripheralNervSysIM.requirePeripheralNervSysMutationSlot()
                    .requirePerk(PerkLib.ElvenSense)
                    .requireAnyRace(Races.ELF, Races.WOODELF);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.ElvishPeripheralNervSysIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            if (pTier == 2) pBuffs['spe.mult'] = 0.05;
            if (pTier == 3) pBuffs['spe.mult'] = 0.1;
            return pBuffs;
        }

        public function ElvishPeripheralNervSysMutation() {
            super("Elvish Peripheral NervSys IM", "Elvish Peripheral NervSys", ".");
            maxLvl = 3;
        }

        
    }
}
