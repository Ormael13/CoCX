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

    public class SlimeFluidMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Slime Fluid";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var pAcc:int = 50;
			if (pTier >= 3) pAcc += 25;
			if (pTier >= 4) pAcc += 25;
            if (pTier >= 1){
                descS += "Your bodily fluids are self conscious and do not leave you easily. All bleed damage taken is negated";
            }
            if (pTier >= 2){
                descS += ". You take " + pAcc + "% less damage from Acid";
            }
            if (pTier >= 3){
                descS += ". Your blood takes on aphrodisiac property when taking melee physical damage your blood lash out teasing your opponent";
            }
            if (pTier >= 4){
                descS += ". Your melee unarmed and feral attack gains tease damage property when you are below 100% health";
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
                    this.requireBloodsteamMutationSlot()
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.1;
            else if (pTier == 2) pBuffs['tou.mult'] = 0.2;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.4;
            else if (pTier == 4) pBuffs['tou.mult'] = 0.8;
            return pBuffs;
        }

        public function SlimeFluidMutation() 
		{
			super(mName + " IM", mName, SLOT_BLOODSTREAM, 4);
        }
        
    }
}
