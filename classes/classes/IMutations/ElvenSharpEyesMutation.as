/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations 
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.Player;
import classes.Races;

public class ElvenSharpEyesMutation extends IMutationPerkType
	{
		public static const MNAME:String = "Elven sharp eyes";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1) descS += "Increase Ranged Critical damage by "+(pTier*2)+"0%";
            if (pTier >= 2) descS += ". Improved attack damage by "+(pTier*25)+"% against opponents afflicted by a status";
            if (pTier >= 3) descS += ". Elven traditional ability are "+((pTier-2)*25)+"% more effective";
            if (pTier >= 4) descS += " and have their cooldowns lowered by one round";
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
                    this.requireEyesMutationSlot()
                    .requireAnyRace(Races.ELF, Races.DARK_ELF, Races.WOODELF, Races.ABYSSAL_ELF);
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

        public function ElvenSharpEyesMutation() 
		{
			super(MNAME, SLOT_EYES, 4);
        }

    }
}
