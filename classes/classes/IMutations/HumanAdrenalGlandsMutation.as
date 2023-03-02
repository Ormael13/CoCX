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

public class HumanAdrenalGlandsMutation extends IMutationPerkType
	{
		private static const mName:String = "Human Adrenal Glands";
        //v1 contains the mutation tier
		override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Your human adrenal glands are giving you slight boost to your natural stamina";
            if (pTier == 1){
                descS += " and increasing Diehard limit by 2%";
            }
            if (pTier == 2){
                descS += ", strength, speed and increasing Diehard limit by 5%";
            }/*
            if (pTier == 3){
                descS += ", stamina, speed and libido, extend lustzerker and berserker duration by 8 turns, allows for either or both to trigger on combat start, double bonus to attack, boost slight natural wrath generation rate";
            }*/
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;/*
                case 3:
                    sufval = "(Evolved)";
                    break;*/
                default:
                    sufval = "";
            }
            return mName + sufval;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireAdrenalGlandsMutationSlot()
                    .requireRace(Races.HUMAN);
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
            if (pTier == 1) {
                pBuffs['tou.mult'] = 0.1;
            }
            else if (pTier == 2) {
                pBuffs['tou.mult'] = 0.1;
                pBuffs['str.mult'] = 0.1;
                pBuffs['spe.mult'] = 0.1;
            }/*
            else if (pTier == 3) {
                pBuffs['tou.mult'] = 0.15;
                pBuffs['lib.mult'] = 0.15;
                pBuffs['str.mult'] = 0.2;
                pBuffs['spe.mult'] = 0.2;
            }*/
            return pBuffs;
        }

        public function HumanAdrenalGlandsMutation() 
		{
			super(mName + " IM", mName, SLOT_ADRENALS, 2);
		}
		
	}
}
