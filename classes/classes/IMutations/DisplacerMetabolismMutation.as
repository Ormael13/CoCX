/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.GlobalFlags.kFLAGS;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class DisplacerMetabolismMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DisplacerMetabolismIM);
            if (pTier >= 1){
                descS += "Increase strength and speed, reduces int after consuming milk";
            }
            if (pTier >= 2){
                descS += ", increase the milk STR and SPD boost by 100% * NG+, int reduction lasts 5 hours longer and adds 50% extra duration";
            }
            if (flags[kFLAGS.HUNGER_ENABLED] > 0) descS += ", increases max hunger cap by 50";
            if (descS != ""){
                descS += (", and increases displacer beast claws attack damage by x" + pTier + 1);
                descS += ".";
            }
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.DisplacerMetabolismIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Displacer Metabolism" + sufval;
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
                IMutationsLib.DisplacerMetabolismIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DisplacerMetabolismIM.requireMetabolismMutationSlot()
                    .requireRace(Races.DISPLACERBEAST);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DisplacerMetabolismIM.requireLevel(pLvl);
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
            return pBuffs;
        }

        public function DisplacerMetabolismMutation() {
            super("Displacer Metabolism IM", "Displacer Metabolism", ".");
            maxLvl = 3;
        }

        
    }
}
