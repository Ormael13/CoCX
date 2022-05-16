/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Arms;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class DraconicBonesMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DraconicBonesIM);
            if (pTier >= 1){
                descS = "Increases toughness, increases unarmed attack damage by 10";
            }
            if (pTier >= 2){
                descS = "Increases toughness further, increases unarmed attack damage by 20,  5% damage reduction from physical and magical attacks, +5% of core toughness added as phantom toughness";
            }
            if (pTier >= 3){
                descS = "Increases toughness even further, increases unarmed attack damage by 40 + an additional 50%,  10% damage reduction from physical and magical attacks, +15% of core toughness added as phantom toughness";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.DraconicBonesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Draconic Bones" + sufval;
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
                IMutationsLib.DraconicBonesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DraconicBonesIM.requireBonesAndMarrowMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (player.arms.type == Arms.DRACONIC || player.arms.type == Arms.FROSTWYRM || player.arms.type == Arms.SEA_DRAGON);
                    }, "Dragon race or its variants arms")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (LowerBody.hasDraconicLegs(player));
                    }, "Dragon race or its variants legs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (Tail.hasDraconicTail(player) || LowerBody.hasDraconicLegs(player) && LowerBody.hasTail(player));
                    }, "Dragon race or its variants tail")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return (player.dragonScore() >= 8 || player.jabberwockyScore() >= 10 || player.frostWyrmScore() >= 10 || player.leviathanScore() >= 20);
                    }, "Dragon race or its variants");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DraconicBonesIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.35;
            return pBuffs;
        }

        public function DraconicBonesMutation() {
            super("Draconic Bones IM", "Draconic Bones", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}