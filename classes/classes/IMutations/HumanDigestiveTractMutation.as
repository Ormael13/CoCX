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

public class HumanDigestiveTractMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Digestive Tract";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var perChg1:int = 1;
			var perChg2:int = 10;
			if (pTier >= 2) {
				perChg1 += 2;
				perChg2 += 15;
			}
            if (pTier >= 3) {
				perChg1 += 3;
				perChg2 += 20;
			}
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Your digestive tract has improved, allowing better nourishment from all ingested substances (+"+perChg1+"0%). Increases the weight gain limit when overeating by "+perChg2+"";
            }
            if (pTier >= 3){
                descS += ". Can slowly remove harmful substances (-1% of lust per turn)";
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
                    this.requireMouthMutationSlot()
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            if (pTier == 4) pBuffs['tou.mult'] = 0.6;
            return pBuffs;
        }

        public function HumanDigestiveTractMutation() 
		{
			super(mName + " IM", mName, SLOT_MOUTH, 3);
		}
		
	}

}
