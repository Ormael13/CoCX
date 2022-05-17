/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class MantislikeAgilityMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MantislikeAgilityIM);
            if (pTier >= 1){
                descS += "Your agility is increased, and can be even further boosted if you have natural armour or thick skin.";
            }
            if (pTier >= 3){
                descS += ", (+30% max core spe as phantom spe)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.MantislikeAgilityIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Mantislike Agility" + sufval;
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
                IMutationsLib.MantislikeAgilityIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.MantislikeAgilityIM.requireMusclesMutationSlot()
                    .requirePerk(IMutationsLib.TrachealSystemIM).requireCustomFunction(function (player:Player):Boolean {
                        return player.mantisScore() >= 12;
                    }, "Mantis race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.MantislikeAgilityIM.requireLevel(pLvl);
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

        public function MantislikeAgilityMutation() {
            super("Mantislike Agility IM", "Mantislike Agility", ".");
            maxLvl = 3;
        }

        
    }
}