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

public class MightyLegsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Mighty Legs";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Makes Kick permanent no matter your leg type. Increase unarmed strike damage by " + 5 * pTier + " and grapple effect by " + 2 * pTier + "0%";
            }
            if (pTier >= 2){
                descS += ". Kick is " + ((5 * pTier) - 5) + "0% stronger";
            }
            if (pTier >= 3){
                descS += ". Kick stun lasts 1 round longer";
            }
            if (pTier >= 4){
                descS += ". Straddle and grapples duration is extended by 1 additional round";
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
                    this.requireAdaptationsMutationSlot()
                    .requireAnyRace(Races.KANGAROO, Races.BUNNY, Races.EASTERBUNNY, Races.LAQUINE, Races.HORSE, Races.CENTAUR, Races.COW, Races.MINOTAUR, Races.JABBERWOCKY);
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
            if (pTier == 1) pBuffs['spe.mult'] = 0.05;
            if (pTier == 2) pBuffs['spe.mult'] = 0.1;
            if (pTier == 3) pBuffs['spe.mult'] = 0.15;
            if (pTier == 4) pBuffs['spe.mult'] = 0.2;
            return pBuffs;
        }

        public function MightyLegsMutation() 
		{
			super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
        }
    }
}
