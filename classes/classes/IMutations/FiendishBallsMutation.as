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

public class FiendishBallsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Fiendish Balls";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increases virility rating by "+((pTier*2)+2)+"0%";
            }
            if (pTier >= 2){
                descS += ". Increase cum production by "+((pTier+1)*25)+"%";
            }
            if (pTier >= 3){
                descS += ", gain a bonus to tease against females based on your cum production up to "+((pTier-2)*25)+"%";
            }
            if (pTier >= 4){
                descS += ". All attacks involving your penis are 300% stronger";
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
                    this.requireBallsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasCock();
                    }, "is Male")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity <= 5;
                    }, "5- feminity")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (player.racialScore(Races.DEMON) > 14 || player.racialScore(Races.IMP) > 8);
                    }, "Demon race (15+) or Imp Race (9+)");
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
            if (pTier == 2) pBuffs['lib.mult'] = 0.1;
			if (pTier == 3) pBuffs['lib.mult'] = 0.15;
			if (pTier == 4) pBuffs['lib.mult'] = 0.2;
            return pBuffs;
        }

        public function FiendishBallsMutation() 
		{
			super(mName + " IM", mName, SLOT_TESTICLES, 4);
        }

    }
}
