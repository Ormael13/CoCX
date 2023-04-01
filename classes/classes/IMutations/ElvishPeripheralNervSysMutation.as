/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class ElvishPeripheralNervSysMutation extends IMutationPerkType
    {
        private static const mName:String = "Elvish Peripheral NervSys";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            pTier = (pTier == -1)? currentTier(this, player): pTier;
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
            if (pTier >= 4){
                descS += ". Heal for an amount of hit points equal to the mana cost when spending mana. Spells have a 10% increased critical chance";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                case 4:
                    sufval = "(Final Form)";
                    break;
                default:
                    sufval = "";
            }
            return mName + sufval;
        }

        override public function evolveText():String {
            var descS:String = "\nYou feel way more attuned to your surroundings than before. Your ability to sense and control magic has improved just as much as your reflexes. You feel as if you are one with the world and your elven sisters.";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requirePeripheralNervSysMutationSlot()
                    .requirePerk(PerkLib.ElvenSense)
                    .requireAnyRace(Races.ELF, Races.WOODELF);
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            if (pTier == 2) pBuffs['spe.mult'] = 0.05;
            if (pTier == 3) pBuffs['spe.mult'] = 0.1;
            return pBuffs;
        }

        public function ElvishPeripheralNervSysMutation() {
            super(mName + " IM", mName, SLOT_NERVSYS, 4);
        }

    }
}
