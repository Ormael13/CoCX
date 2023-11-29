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

public class MantislikeAgilityMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Mantislike Agility";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Your agility is increased, and can be even further boosted if you have natural armour or thick skin";
            }
            if (pTier >= 3){
                descS += ", +30% max core spe as phantom spe";
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
                    this.requireMusclesMutationSlot()
                    .requireMutation(IMutationsLib.TrachealSystemIM)
                    .requireRace(Races.MANTIS);
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

        public function MantislikeAgilityMutation() {
            super(mName + " IM", mName, SLOT_MUSCLE, 3);
        }

    }
}
