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

public class CatLikeNimblenessMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Cat-like Nimbleness";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increases Evasion and allows you to keep Flexibility even without cat arms/legs/tail";
            }
            if (pTier >= 2){
                descS += "";
            }
            if (pTier >= 3){
                descS += "";
            }
            if (pTier >= 4){
                descS += ", giving you 10% of max core Spe as phantom Spe";
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
                    .requirePerk(PerkLib.Flexibility)
                    .requireRacialGroup(Races.CatlikeRaces, "Any cat race");
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
            if (pTier == 2) pBuffs['spe.mult'] = 0.1;
            if (pTier == 3) pBuffs['spe.mult'] = 0.3;
            if (pTier == 4) pBuffs['spe.mult'] = 0.5;
            return pBuffs;
        }

        public function CatLikeNimblenessMutation() {
            super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
        }
    }
}
