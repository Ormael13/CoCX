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

public class OrcAdrenalGlandsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Orc Adrenal Glands";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var fero:int = 1;
			var phan:int = 5;
			if (pTier >= 2) {
				fero += 2;
				phan += 10;
			}
			if (pTier >= 3) phan += 15;
			if (pTier >= 4) {
				fero += 5;
				phan += 20;
			}
			if (pTier >= 1) descS += "Your Orc adrenal glands are increasing Ferocity limit by " + fero + "%, +" + phan + "% of max core Str as phantom Str";
            if (pTier >= 2){
                descS += ", increases your natural strength and tone";
            }
            if (pTier >= 3){
                descS += ", boost natural wrath generation rate, allows you to use Ferocity even when you are no longer an orc";
            }
            if (pTier >= 4){
                descS += ", when out of combat and below 10% wrath, you will not lose wrath and instead gain +2% per hour, +0.5% wrath generated in combat";
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
                    this.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Ferocity).requireRace(Races.ORC);
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
			if (pTier == 2) pBuffs['str.mult'] = 0.5;
			if (pTier == 3) pBuffs['str.mult'] = 1;
			if (pTier == 4) pBuffs['str.mult'] = 3;
            return pBuffs;
        }

        public function OrcAdrenalGlandsMutation() {
            super(mName + " IM", mName, SLOT_ADRENALS, 4);
        }
        
    }
}
