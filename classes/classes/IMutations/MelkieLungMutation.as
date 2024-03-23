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

public class MelkieLungMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Feyfolk Voice";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1) descS += "Increase damage reduction against spells by " + (5 * pTier) + "% and increase the power of Sing/Perform by " + (25 * pTier) + "%. Sing/Perform is kept at all time";
            if (pTier >= 2) descS += ". Sing/Perform now has an Intelligence scaling";
            if (pTier >= 3) descS += " and it's doubled";
            if (pTier >= 4) descS += ". Increase Intensify limit by 10 stages";
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
                    this.requireLungsMutationSlot()
                    .requireAnyRace(Races.MELKIE, Races.SATYR);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.30;
            if (pTier == 4) pBuffs['tou.mult'] = 0.50;
            return pBuffs;
        }

        public function MelkieLungMutation() {
            super(mName + " IM", mName, SLOT_LUNGS, 4);
        }
        
    }
}
