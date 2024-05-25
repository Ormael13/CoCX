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

public class FiendishMetabolismMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Manticore Metabolism";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "You may no longer gain nourishment from anything short of cum, milk and girl juice. If you have the demonic hunger perk, gain a stacking bonus of 10% to tease damage up to 50%.";
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
                    .requireRace(Races.DEMON);
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
			if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            return pBuffs;
        }

        public function FiendishMetabolismMutation() 
		{
			super(mName + " IM", mName, SLOT_METABOLISM, 1);
		}

    }
}
