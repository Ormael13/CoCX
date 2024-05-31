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

public class HumanBonesMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Bones";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1) descS += "Increases maximum base/core Str/Tou by ";
            if (pTier == 1){
                descS += "5.";
            }
            if (pTier == 2){
                descS += "10. Increase effects of body cultivation by 50%.";
            }
            if (pTier == 3){
                descS += "10, maximum trainable Str/Tou by 20%. Increase effects of body cultivation by 100%.";
            }
            if (pTier == 4){
                descS += "20, maximum trainable Str/Tou by 30%. Increase effects of body cultivation by 150%. Increase p.soulskill power by 100% and +10% to max overhp.";
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
                    this.requireBonesAndMarrowMutationSlot()
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
				pBuffs['str.mult'] = 0.1;
				pBuffs['tou.mult'] = 0.1;
			}
            if (pTier == 2) {
				pBuffs['str.mult'] = 0.2;
				pBuffs['tou.mult'] = 0.2;
			}
            if (pTier == 3) {
				pBuffs['str.mult'] = 0.4;
				pBuffs['tou.mult'] = 0.4;
			}
            if (pTier == 4) {
				pBuffs['str.mult'] = 0.8;
				pBuffs['tou.mult'] = 0.8;
			}
            return pBuffs;
        }

        public function HumanBonesMutation() 
		{
			super(mName + " IM", mName, SLOT_BONE, 4);
		}
		
	}

}
