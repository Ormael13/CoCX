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

public class YetiFatMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Yeti Fat";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var pDR:int = 5;
			if (pTier >= 2) pDR += 10;
			if (pTier >= 3) pDR += 20;
            if (pTier >= 1){
                descS += "Gain (" + pDR + "%) damage reduction against attacks, increases the strength of yeti ice breath by 50%";
            }
            if (pTier >= 2){
                descS += ", the potency of Big Hand and Feet increases by 50%";
            }
            if (pTier >= 3){
                descS += ", increases the duration of yeti breath stun by 1 round and reduce its cooldown by 3 rounds.";
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
                    this.requireFatTissueMutationSlot()
                    .requireRace(Races.YETI);
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
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function YetiFatMutation() {
            super(mName + " IM", mName, SLOT_FAT, 3);
        }
    }
}
