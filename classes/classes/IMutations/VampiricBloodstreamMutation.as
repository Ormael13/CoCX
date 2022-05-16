/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.StatusEffects;

public class VampiricBloodstreamMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.VampiricBloodstreamIM);
            if (pTier >= 1) descS += "Your bloodstream has started to adapt to the presence of vampiric blood";
            if (pTier >= 2){
                descS += " Vampire Thirst stack now decays every 2 days.";
            }
            descS += " Increases the maximum numbers of stacks of Vampire Thirst by " + vampStackC();
            if (pTier >= 3){
                descS += ", and increase their potency by 50%";
            }
            if (descS != "")descS += ".";
            return descS;

            function vampStackC():int{
                if (pTier == 1) return 15;
                if (pTier == 2) return 30;
                if (pTier == 3) return 60;
                return 0;
            }
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.VampiricBloodstreamIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Vampiric Bloodstream" + sufval;
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
                IMutationsLib.VampiricBloodstreamIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.VampiricBloodstreamIM.requireBloodsteamMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasStatusEffect(StatusEffects.VampireThirst);
                    }, "Vampire Thirst")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.vampireScore() >= 10;//potem dodać mosquito race i ew. inne co mogą wypijać krew
                    }, "Vampire race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.VampiricBloodstreamIM.requireLevel(pLvl);
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
            if (pTier == 3) pBuffs['lib.mult'] = 0.3;
            return pBuffs;
        }

        public function VampiricBloodstreamMutation() {
            super("Vampiric Bloodstream IM", "Vampiric Bloodstream", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}