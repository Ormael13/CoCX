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

public class HollowFangsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Your fangs and mouth started to slowly change showing rudimental ability to suck out fluids like blood. (+5 max stack of Vampire Thirst)";
            }
            if (pTier == 2){
                descS = "Your ability to suck substances like blood have developed halfway. (+5 max stack of Vampire Thirst, +3% more healed from Vampire Bite)";
            }
            if (pTier == 3){
                descS = "You can now freely feed on blood and other atypical fluids. (+5 max stack of Vampire Thirst, +7% more healed from Vampire Bite, each Vampire Bite giving 2 stacks and deal +50% lust dmg)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Hollow Fangs" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this, player);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireMouthMutationSlot()
                    .requireMutation(IMutationsLib.VampiricBloodstreamIM)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.facePart.type == 34;//player.facePart.isAny(Face.VAMPIRE, Face.)
                    }, "Vampire fangs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.vampireScore() >= 10;//potem dodać mosquito race i ew. inne co mogą wypijać krew
                    }, "Vampire race");
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
        override public function pBuffs(target:Creature = null):Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this, (target == null)? player : target);
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function HollowFangsMutation() {
            super("Hollow Fangs IM", "Hollow Fangs", ".");
            maxLvl = 3;
        }
        
    }
}