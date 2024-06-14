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

public class HumanOvariesMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Ovaries";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS += "Increases fertility rating by 15, +5% to lust resistance";
            }
            if (pTier == 2){
                descS += "Increases fertility rating by 30, +10% to lust resistance";
            }
            if (pTier == 3){
                descS += "Increases fertility rating by 45, +15% to lust resistance, increase milk production by ~100%, +200 to max lust and allow to use Milk Blast once per fight";
            }
            if (pTier == 4){
                descS += "Increases fertility rating by 60, +20% to lust resistance, increase milk production by ~100%, +10% to max overlust, negative effects of libido are reduced by 5%, +200 to max lust and allow to use Milk Blast once per fight";
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
                    this.requireOvariesMutationSlot()
                    requireCustomFunction(function (player:Player):Boolean {
                        return player.hasVagina();
                    }, "is Female")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity >= 95;
                    }, "95+ feminity")
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.3;
            if (pTier == 2) {
				pBuffs['str.mult'] = 0.3;
                pBuffs['tou.mult'] = 0.2;
                pBuffs['lib.mult'] = 0.4;
			}
            if (pTier == 3){
                pBuffs['str.mult'] = 0.6;
                pBuffs['tou.mult'] = 0.4;
                pBuffs['lib.mult'] = 0.8;
            }
            if (pTier == 4){
                pBuffs['str.mult'] = 1.4;
                pBuffs['tou.mult'] = 1.0;
                pBuffs['lib.mult'] = 1.8;
            }
            return pBuffs;
        }

        public function HumanOvariesMutation() 
		{
			super(mName + " IM", mName, SLOT_OVARIES, 4);
        }

    }
}
