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

    public class CaveWyrmLungsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Cave Wyrm Lungs";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1){
				descS += "Your lung has became accustomed to the presence of acid and fire in your biology improving the corrosiveness and volatility of your biochemical weapons. "
			}
            if (pTier == 1){
                descS += "(+200% to azureflame breath / acid spit damage)";
            }
            if (pTier == 2){
                descS += "(+400% to azureflame breath / acid spit damage, increase str/tou scaling by 100%) ";
            }
            if (pTier == 3){
                descS += "(+600% to azureflame breath / acid spit damage, increase str/tou scaling by 100%, azureflame breath can cause stun like fire dragon breath, acid spit DoT increase phys dmg dealt to enemy by 90%, , allows to keep both specials even without been cave wyrm)";
            }
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
                    .requirePerks(PerkLib.AzureflameBreath, PerkLib.AcidSpit)
                    .requireRace(Races.CAVEWYRM);
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
            if (pTier == 2) pBuffs['spe.mult'] = 0.15;
            if (pTier == 3) pBuffs['spe.mult'] = 0.35;
            return pBuffs;
        }

        public function CaveWyrmLungsMutation() {
            super(mName + " IM", mName, SLOT_LUNGS, 3);
        }
        
    }
}
