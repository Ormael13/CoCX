/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Races;

public class HeartOfTheStormMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Heart Of The Storm";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increase the power of all Wind and Lightning racial abilities";
            }
            if (pTier >= 3){
                descS += ", you can fly continuously as long as you yourself can fly, if you have energy attacks they now include a chance to stun";
            }
            if (pTier >=2){
                descS += " and you increase wind and electricity resistance by ";
                if (pTier == 2) descS += "10%";
                if (pTier == 3) descS += "30%";
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
                    this.requireHeartMutationSlot()
                        .requireAnyRace(Races.RAIJU, Races.THUNDERBIRD, Races.KAMAITACHI, Races.COUATL, Races.KIRIN);
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
            if (pTier == 1) pBuffs['spe.mult'] = 0.05;
            if (pTier == 2) pBuffs['spe.mult'] = 0.15;
            if (pTier == 3) pBuffs['spe.mult'] = 0.35;
            return pBuffs;
        }

        public function HeartOfTheStormMutation() {
            super(mName + " IM", mName, SLOT_HEART, 3);
        }
        
    }
}
