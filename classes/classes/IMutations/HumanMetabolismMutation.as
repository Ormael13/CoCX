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

public class HumanMetabolismMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Human Metabolism";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Your metabolism changes, allowing for the slow detoxification of poisons ";
            }
			if (pTier >= 3) descS += "or slight faster fatigue recovery ";
            if (pTier >= 1){
                descS += "("+pTier+"0% chance to instantly remove some toxic substances from your body, -"+pTier+"% of lust";
            }
			if (pTier >= 3) descS += " / -1% of fatigue";
            if (pTier >= 1){
                descS += " per turn";
            }
			if (pTier == 1) descS += ")";
            if (pTier >= 2){
                descS += ", 2x shorter elemental dot effects duration)";
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            if (pTier == 3) pBuffs['lib.mult'] = 0.3;
            if (pTier == 4) pBuffs['lib.mult'] = 0.6;
            return pBuffs;
        }

        public function HumanMetabolismMutation() 
		{
			super(mName + " IM", mName, SLOT_METABOLISM, 3);
		}
		
	}

}
