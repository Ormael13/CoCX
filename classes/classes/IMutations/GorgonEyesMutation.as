/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;

public class GorgonEyesMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.GorgonEyesIM);
            if (pTier >= 1){
                descS += "Allows you to use Petrify with any type of eyes and improves your resistance to attacks that are related to sight";
            }
            if (pTier >= 2){
                descS += ", increases your reactions, increases Petrify's duration, and inverts the negative effects of resistances against basilisk and similars";
            }
            if (pTier >= 3){
                descS += ", ";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.GorgonEyesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Gorgon Eyes" + sufval;
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
                IMutationsLib.GorgonEyesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.GorgonEyesIM.requireEyesMutationSlot()
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.eyes.type == 4;
                        }, "Gorgon eyes")
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.gorgonScore() >= 11;
                        }, "Gorgon race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.GorgonEyesIM.requireLevel(pLvl);
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
            if (pTier == 1) {
                pBuffs['spe.mult'] = 0.05;
                pBuffs['sens'] = 5
            }
            if (pTier == 2) {
                pBuffs['spe.mult'] += 0.15;
                pBuffs['sens'] = 15;
            }
            return pBuffs;
        }

        public function GorgonEyesMutation() {
            super("Gorgon Eyes IM", "Gorgon Eyes", ".");
            maxLvl = 2;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}