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

    public class SlimeMetabolismMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Slime Metabolism";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var pAcc:int = 50;
			var pAccc:int = 1;
			if (pTier >= 3) pAcc += 25;
			if (pTier >= 4) {
				pAcc += 25;
				pAccc += 1;
			}
            if (pTier >= 1){
                descS += "When taking an intake of fluid heal for "+(1+pTier)+"% of your hp, mana and fatigue";
            }
            if (pTier >= 2){
                descS += ". Increase all grappling tease damage by " + pAcc + "%";
            }
            if (pTier >= 3){
                descS += ". Gain temporary regeneration +" + pAccc + "% after a fluid intake for one hour";
            }
            if (pTier >= 3){
                descS += ". Fluid intake heals all status damage, drains and weakening by 5% per intake";
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
                    .requireAnyRace(Races.SLIME, Races.DARKSLIME, Races.MAGMASLIME);
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.1;
            else if (pTier == 2) pBuffs['lib.mult'] = 0.2;
            else if (pTier == 3) pBuffs['lib.mult'] = 0.4;
            else if (pTier == 4) pBuffs['lib.mult'] = 0.8;
            return pBuffs;
        }

        public function SlimeMetabolismMutation() {
            super(mName + " IM", mName, SLOT_METABOLISM, 4);
        }
        
    }
}
