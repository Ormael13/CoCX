/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class FloralOvariesMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.FloralOvariesIM);
            if (pTier >= 1){
                descS += "Potency on Alraune pollen increases with rank";
            }
            if (pTier >= 2){
                descS += ", males take an extra 50% lust damage";
            }
            if (pTier >= 3){
                descS += ", Alraune pollen has a 25% chance every round to fascinate victims";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.FloralOvariesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Floral Ovaries" + sufval;
        }

        //Mutation Requirements
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.FloralOvariesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.FloralOvariesIM.requireOvariesMutationSlot()
                    .requireRace(Races.ALRAUNE);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.FloralOvariesIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.15;
            if (pTier == 3) pBuffs['lib.mult'] = 0.35;            
            return pBuffs;
        }

        public function FloralOvariesMutation() {
            super("Floral Ovaries IM", "Floral Ovaries", ".");
            maxLvl = 3;
        }

        
    }
}
