/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations 
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class HumanEyesMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Eyes";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			var pAcc:int = 5;
			if (pTier >= 3) pAcc += 5;
			if (pTier >= 4) pAcc += 10;
			if (pTier >= 1){
                descS = "Increase precision of all attacks by " + pAcc + "%. Same bonus as Eyes of the Hunter (Ex) perk but with limit to ";
            }
			if (pTier == 1){
                descS += "5 lvl's.";
            }
			if (pTier == 2){
                descS += "10 lvl's.";
            }
            if (pTier == 3){
				descS += "30 lvl's. 5% less penalty to acc per each next attack during multiattack.";
            }
            if (pTier == 4){
				descS += "60 lvl's. Reduces accuracy penalty by 10% for each successive attack during a multiattack. You can now also see in darkness - Dark Vision.";
            }
            if (pTier >= 1) descS += " (req. 18+ human score to have all effects active)";
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
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.racialScore(Races.HUMAN) > 16;
                    }, "Human race (17+)");
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
				pBuffs['spe.mult'] = 0.15;
                pBuffs['sens'] = 15;
			}
            if (pTier == 2) {
				pBuffs['spe.mult'] = 0.45;
                pBuffs['sens'] = 45;
			}
            if (pTier == 3) {
				pBuffs['spe.mult'] = 1.5;
                pBuffs['sens'] = 150;
			}
            if (pTier == 4) {
				pBuffs['spe.mult'] = 4.5;
                pBuffs['sens'] = 450;
			}
            return pBuffs;
        }

        public function HumanEyesMutation() 
		{
			super(mName + " IM", mName, SLOT_EYES, 4);
        }

    }
}
