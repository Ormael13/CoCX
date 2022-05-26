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
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
            if (pTier >= 1){
                descS = "Increases toughness, increases unarmed attack damage by 10";
            }
            if (pTier >= 2){
                descS = "Increases toughness further, increases unarmed attack damage by 20,  5% damage reduction from physical and magical attacks, +5% phantom toughness";
            }
            if (pTier >= 3){
                descS = "Increases toughness even further, increases unarmed attack damage by 40 + an additional 50%,  10% physical and magical damage reduction, +15% phantom toughness";
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
            return "Draconic Bones" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireBonesAndMarrowMutationSlot()
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.35;
            return pBuffs;
        }

        public function DraconicBonesMutation() {
            super("Draconic Bones IM", "Draconic Bones", ".");
            maxLvl = 3;
        }

    }
}
