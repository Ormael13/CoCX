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

public class HumanAdrenalGlandsMutation extends IMutationPerkType
	{
        override public function get mName():String {
            return "Human Adrenal Glands";
        }
        //v1 contains the mutation tier
		override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1) descS += "Your human adrenal glands are giving you "+(pTier >= 4 ? "" : "slight ")+"boost to your natural stamina";
            if (pTier == 1){
                descS += " and increasing Diehard limit by 5%";
            }
            if (pTier == 2){
                descS += ", strength, speed and increasing Diehard limit by 10%";
            }
            if (pTier == 3){
                descS += ", strength, speed, wrath gained naturaly increased and rising Diehard limit by 25%";
            }
            if (pTier == 4){
                descS += ", strength, speed; wrath gained naturaly and from taking damage or dealing damage increased; rising Diehard limit by 50%";
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
                    this.requireAdrenalGlandsMutationSlot()
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
					pBuffs['tou.mult'] = 0.3;
				}
				else if (pTier == 2) {
					pBuffs['tou.mult'] = 0.3;
					pBuffs['str.mult'] = 0.3;
					pBuffs['spe.mult'] = 0.3;
				}
				else if (pTier == 3) {
					pBuffs['tou.mult'] = 0.7;
					pBuffs['str.mult'] = 0.7;
					pBuffs['spe.mult'] = 0.7;
				}
				else if (pTier == 4) {
					pBuffs['tou.mult'] = 1.8;
					pBuffs['str.mult'] = 1.8;
					pBuffs['spe.mult'] = 1.8;
				}
			}
            return pBuffs;
        }

        public function HumanAdrenalGlandsMutation() 
		{
			super(mName + " IM", mName, SLOT_ADRENALS, 4);
		}
		
	}
}
