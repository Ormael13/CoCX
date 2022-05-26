/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class HeartOfTheStormMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
            if (pTier >= 1){
                descS += "Increase the power of all Wind and Lightning racial abilities";
            }
            if (pTier >= 3){
                descS += ", you can fly continuously as long as you yourself can fly, if you have enery attacks they now include a chance to stun";
            }
            if (pTier >=2){
                descS += " and you increase wind and electricity resistance by ";
                if (pTier == 2) descS += "10%";
                if (pTier == 3) descS += "30%";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Heart Of The Storm" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireHeartMutationSlot()
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.raijuScore() >= 10 || player.thunderbirdScore() >= 12 || player.kamaitachiScore() >= 14 || player.couatlScore() >= 11;
                        }, "Stormborn race");
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
        override public function pBuffs():Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this);
            if (pTier == 1) pBuffs['spe.mult'] = 0.05;
            if (pTier == 2) pBuffs['spe.mult'] = 0.15;
            if (pTier == 3) pBuffs['spe.mult'] = 0.35;
            return pBuffs;
        }

        public function HeartOfTheStormMutation() {
            super("Heart Of The Storm IM", "Heart Of The Storm", ".");
            maxLvl = 3;
        }
        
    }
}