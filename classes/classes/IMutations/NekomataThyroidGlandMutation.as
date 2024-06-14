/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;

    public class NekomataThyroidGlandMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Nekomata Thyroid Gland";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "";//lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed
            }
            if (pTier >= 2){
                descS += ", ";//lower cooldowns for Illusion and Terror by three turns, increase speed of the recovery after using magic and slightly boost PC speed
            }
            if (pTier >= 3){
                descS += ", ";//grant bonus soulforce/mana regen depending on Star Sphere rank, increase max Star Sphere rank to 20. Increase speed debuff of Terror to 50, increase evasion boost from Illusion to 20%. Boost PC speed, wisdom and intelligence
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
                    this.requireHeartMutationSlot();
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

        public function NekomataThyroidGlandMutation() {
            super(mName + " IM", mName, SLOT_NONE, 3);
        }
        
    }
}
