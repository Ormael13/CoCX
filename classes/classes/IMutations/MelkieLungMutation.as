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

public class MelkieLungMutation extends IMutationPerkType
    {
        private static const mName:String = "Melkie Lung";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var perkCent1:int = 5;
			var perkCent2:int = 20;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 2) {
				perkCent1 += 10;
				perkCent2 += 30;
			}
			if (pTier >= 3) {
				perkCent1 += 15;
				perkCent2 += 40;
			}
            if (pTier >= 1) descS += "Increase damage reduction against spells by " + perkCent1 + "% and increase the power of compelling aria by " + perkCent2 + "%. Compelling Aria is kept at all time";
            if (pTier >= 2) descS += ". Compelling Aria now has an Intelligence scaling";
            if (pTier >= 3) descS += " and it's doubled";
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
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
                    this.requireLungsMutationSlot()
                    .requireRace(Races.MELKIE);
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

        public function MelkieLungMutation() {
            super(mName + " IM", mName, SLOT_LUNGS, 3);
        }
        
    }
}
