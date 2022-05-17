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

public class OrcAdrenalGlandsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.OrcAdrenalGlandsIM);
            if (pTier == 1){
                descS = "Your Orc adrenal glands are increasing Ferocity limit by 1%, +5% of max core Str as phantom Str";
            }
            if (pTier == 2){
                descS = "Your Orc adrenal glands are increasing Ferocity limit by 3%, +15% of max core Str as phantom Str, increase your natural strength and tone";
            }
            if (pTier == 3){
                descS = "Your Orc adrenal glands are increasing Ferocity limit by 3%, +30% of max core Str as phantom Str, increase your natural strength and tone, boost natural wrath generation rate, allow to use Ferocity even when been no longer an orc";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.OrcAdrenalGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Orc Adrenal Glands" + sufval;
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
                IMutationsLib.OrcAdrenalGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.OrcAdrenalGlandsIM.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Ferocity).requireCustomFunction(function (player:Player):Boolean {
                        return player.orcScore() >= 11;
                    }, "Orc race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.OrcAdrenalGlandsIM.requireLevel(pLvl);
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
            if (pTier == 2) pBuffs['str.mult'] = 0.5;
            else if (pTier == 3) pBuffs['str.mult'] = 1;
            return pBuffs;
        }

        public function OrcAdrenalGlandsMutation() {
            super("Orc Adrenal Glands IM", "Orc Adrenal Glands", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}