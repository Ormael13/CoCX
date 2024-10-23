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

public class HumanVersatilityMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Versatility";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Mastery gains increased by 1 point, or in the case of multiplier +1 to multiplier. ";
            }
            if (pTier >= 2){
                descS += "Mastery gains increased by "+pTier+" points or in case of multiplier +"+pTier+" to multiplier. ";
            }
            if (pTier == 2){
                descS += ". Decrease a bit needed exp to lvl up weapon/lifeskill masteries";
            }
            if (pTier >= 3){
                descS += ". Decrease needed exp to lvl up weapon/lifeskill masteries and have "+((pTier*2)-4)+"0% chance to gain "+pTier+"x more XP for Mastery";
            }
            if (pTier == 4){
                descS += ". 50% chance to gain 2 levels instead of 1 when leveling weapon/lifeskill mastery";
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
                    this.requireAdaptationsMutationSlot()
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
				pBuffs['str.mult'] = 0.02;
				pBuffs['tou.mult'] = 0.02;
				pBuffs['spe.mult'] = 0.02;
				pBuffs['int.mult'] = 0.03;
				pBuffs['wis.mult'] = 0.03;
				pBuffs['lib.mult'] = 0.03;
			}
            if (pTier == 2) {
				pBuffs['str.mult'] = 0.05;
				pBuffs['tou.mult'] = 0.05;
				pBuffs['spe.mult'] = 0.05;
				pBuffs['int.mult'] = 0.10;
				pBuffs['wis.mult'] = 0.10;
				pBuffs['lib.mult'] = 0.10;
			}
            if (pTier == 3) {
				pBuffs['str.mult'] = 0.10;
				pBuffs['tou.mult'] = 0.10;
				pBuffs['spe.mult'] = 0.10;
				pBuffs['int.mult'] = 0.20;
				pBuffs['wis.mult'] = 0.20;
				pBuffs['lib.mult'] = 0.20;
			}
            if (pTier == 4) {
				pBuffs['str.mult'] = 0.20;
				pBuffs['tou.mult'] = 0.20;
				pBuffs['spe.mult'] = 0.20;
				pBuffs['int.mult'] = 0.40;
				pBuffs['wis.mult'] = 0.40;
				pBuffs['lib.mult'] = 0.40;
			}
            return pBuffs;
        }

        public function HumanVersatilityMutation() 
		{
			super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
        }

    }
}
