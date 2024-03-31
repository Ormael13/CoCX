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

public class HumanThyroidGlandMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Thyroid Gland";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS += "Regenerates 2% of max HP/hour and 1% of max HP/round";
            }
            if (pTier == 2){
                descS += "Regenerates 4% of max HP/hour and 2% of max HP/round";
            }
            if (pTier == 3){
                descS += "Regenerates 6% of max HP/hour and 3% of max HP/round. Gain soulforce recovery equal to 1% of your total soulforce and mana recovery increased by 0,5% of max mana";
            }
            if (descS != "")descS += ".";
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
                    this.requireThyroidGlandMutationSlot()
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

        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            if (player.racialScore(Races.HUMAN) > 17) {
				if (pTier == 1) {
					pBuffs['spe.mult'] = 0.15;
					pBuffs['wis.mult'] = 0.15;
				}
				if (pTier == 2){
					pBuffs['spe.mult'] = 0.35;
					pBuffs['wis.mult'] = 0.4;
				}
				if (pTier == 3){
					pBuffs['spe.mult'] = 0.5;
					pBuffs['wis.mult'] = 0.9;
					pBuffs['int.mult'] = 0.7;
				}
			}
            return pBuffs;
        }

        //Mutations Buffs
        public function HumanThyroidGlandMutation() 
		{
			super(mName + " IM", mName, SLOT_THYROID, 3);
		}
		
	}
}
