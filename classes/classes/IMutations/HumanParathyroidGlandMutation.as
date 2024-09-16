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

public class HumanParathyroidGlandMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Parathyroid Gland";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var perkCent:int = 0;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 2) perkCent += 1;
			if (pTier >= 4) perkCent += 1;
            if (pTier >= 1){
                descS += "Fatigue recovery increased and reduces the fatigue cost of physical specials by "+pTier+"0%";
            }
            if (pTier >= 2){
                descS += " and +" + perkCent + " to fatigue/soulforce/mana recovery multiplier when under " + (pTier + 2) + "0% max HP";
            }
            if (pTier >= 4){
                descS += ". Reduce spells mana cost by 10%";
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
                    this.requireParathyroidGlandMutationSlot()
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
			if (player.racialScore(Races.HUMAN) > 17) {
				if (pTier == 1) {
					pBuffs['spe.mult'] = 0.15;
					pBuffs['int.mult'] = 0.15;
				}
				if (pTier == 2) {
					pBuffs['spe.mult'] = 0.35;
					pBuffs['int.mult'] = 0.4;
				}
				if (pTier == 3) {
					pBuffs['spe.mult'] = 0.6;
					pBuffs['int.mult'] = 0.9;
				}
				if (pTier == 4) {
					pBuffs['spe.mult'] = 1.2;
					pBuffs['int.mult'] = 1.8;
				}
			}
            return pBuffs;
        }

        public function HumanParathyroidGlandMutation() 
		{
			super(mName + " IM", mName, SLOT_PARATHYROID, 4);
        }
        
    }
}
