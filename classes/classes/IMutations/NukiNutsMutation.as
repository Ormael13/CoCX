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

public class NukiNutsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Nuki Nuts";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Gain a natural armor bonus based on your ball size, prevent the loss of money strike";
            }
            if (pTier >= 2){
                descS += ", increases cum production, cumming has a chance of producing gems";
            }
            if (pTier >= 3){
                descS += ", and doubles Money Strike damage";
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
                        return player.isRace(Races.RACCOON) && player.hasBalls() && player.ballSize > 5;
                    }, "Tanuki race and large balls");
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            if (pTier == 3) pBuffs['lib.mult'] = 0.3;
            return pBuffs;
        }

        public function NukiNutsMutation() {
            super(mName + " IM", mName, SLOT_TESTICLES, 3);
        }

    }
}
