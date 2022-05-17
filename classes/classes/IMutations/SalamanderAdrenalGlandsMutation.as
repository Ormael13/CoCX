/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Player;

public class SalamanderAdrenalGlandsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM);
            if (pTier >= 1) descS += "Your Salamander adrenal glands are giving you slight boost to your natural stamina";
            if (pTier == 1){
                descS += "and libido";
            }
            if (pTier == 2){
                descS += ", stamina, speed, libido and extend lustzerker and berserker duration by 2 turns";
            }
            if (pTier == 3){
                descS += ", stamina, speed and libido, extend lustzerker and berserker duration by 8 turns, allows for either or both to trigger on combat start, double bonus to attack, boost slight natural wrath generation rate";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Salamander Adrenal Glands" + sufval;
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
                IMutationsLib.SalamanderAdrenalGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.SalamanderAdrenalGlandsIM.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Lustzerker).requireCustomFunction(function (player:Player):Boolean {
                        return player.salamanderScore() >= 7 || player.phoenixScore() >= 11;
                    }, "Salamander race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.SalamanderAdrenalGlandsIM.requireLevel(pLvl);
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
                pBuffs['tou.mult'] = 0.05;
                pBuffs['lib.mult'] = 0.05;
            }
            else if (pTier == 2) {
                pBuffs['tou.mult'] = 0.1;
                pBuffs['lib.mult'] = 0.1;
                pBuffs['str.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            else if (pTier == 3) {
                pBuffs['tou.mult'] = 0.15;
                pBuffs['lib.mult'] = 0.15;
                pBuffs['str.mult'] = 0.2;
                pBuffs['spe.mult'] = 0.2;
            }
            return pBuffs;
        }

        public function SalamanderAdrenalGlandsMutation() {
            super("Salamander Adrenal Glands IM", "Salamander Adrenal Glands", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}