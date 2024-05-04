/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;

public class GoblinOvariesMutation extends IMutationPerkType
	{
		override public function get mName():String {
            return "Goblin Ovaries";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 1){
				descS += "Increase fertility rating by "+pTier+"0, While pregnant increase total libido by "+pTier+"0%. Double the number of kids you birth";
			}
            if (pTier >= 2){
                descS += ". Increase physical damage done while pregnant by "+(pTier+1)+"0%";
            }
            if (pTier == 3){
                descS += ". Lust damage against male opponents increased by 25%";
            }
            if (pTier == 4){
                descS += ". Lust damage against male opponents increased by 50%. Add your fertility score as a bonus to libido";
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
                    this.requireOvariesMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isGoblinoid();
                    }, "Goblin race");
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            if (pTier == 3) pBuffs['lib.mult'] = 0.35;
            if (pTier == 4) pBuffs['lib.mult'] = 0.75;
            return pBuffs;
        }

        public function GoblinOvariesMutation() 
		{
			super(mName + " IM", mName, SLOT_OVARIES, 4);
		}
		
	}

}