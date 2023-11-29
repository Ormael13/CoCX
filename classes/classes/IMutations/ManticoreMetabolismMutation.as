/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class ManticoreMetabolismMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Manticore Metabolism";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Speed is increased with cum intake for a few hours, and allows you to attack with multiple spikes at once";
            }
            if (pTier >= 2){
                descS += ", further increases speed by 100% per NG+ for 5 hours longer, venom recharge when using Manticore feed is twice as effective and increases max hunger by 50";
            }
            if (pTier >= 3){
                descS += ", spikes deal twice as much damage and lust, speed is increased by another 100%, and if you have manticore tail, straddle damage is greatly increased and direct tail feeding is twice as difficult to remove.";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireMetabolismMutationSlot()
                    .requireRace(Races.MANTICORE);
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
            return pBuffs;
        }

        public function ManticoreMetabolismMutation() {
            super(mName + " IM", mName, SLOT_METABOLISM, 3);
        }

    }
}
