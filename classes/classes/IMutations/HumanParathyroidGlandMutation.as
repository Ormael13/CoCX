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
        private static const mName:String = "Human Parathyroid Gland";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS += "Increases self healing by 300 out of combat and by 150 in combat. (using defend option will double it)";
            }
            if (pTier == 2){
                descS += "Increases self healing by 600 out of combat and by 300 in combat. (using defend option will double it)";
            }
            if (pTier == 3){
                descS += ", further boost mana regen based on star sphere rank, speed debuff from Terror increased to 70, evasion boost from Illusion increased by 30%";
            }
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
			}
            return pBuffs;
        }

        public function HumanParathyroidGlandMutation() 
		{
			super(mName + " IM", mName, SLOT_PARATHYROID, 2);
        }
        
    }
}
