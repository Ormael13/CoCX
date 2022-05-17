/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.RearBody;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.StatusEffects;

public class GazerEyesMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.GazerEyesIM);
            if (pTier >= 1){
                descS += "Keep true sight at all times and empower gaze attacks";
            }
            if (pTier >= 2){
                descS += ", empower your ability to cast multiple spells as a Gazer if available";
            }
            if (pTier >= 3){
                descS += ", increase spell critical hit chance by 10%";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.GazerEyesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Gazer Eyes" + sufval;
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
                IMutationsLib.GazerEyesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.GazerEyesIM.requireEyesMutationSlot()
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.eyes.type == 36;
                        }, "Monoeye")
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.rearBody.type == RearBody.TENTACLE_EYESTALKS && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2;
                        }, "2+ eyestalks")
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.gazerScore() >= 7;
                        }, "Gazer race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.GazerEyesIM.requireLevel(pLvl);
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
            if (pTier == 1){
                pBuffs['int.mult'] = 0.05;
            }
            if (pTier == 2){
                pBuffs['int.mult'] = 0.15;
                pBuffs['lib.mult'] = 0.05;
            }
            if (pTier == 3){
                pBuffs['int.mult'] = 0.25;
                pBuffs['lib.mult'] = 0.10;
            }
            return pBuffs;
        }

        public function GazerEyesMutation() {
            super("Gazer Eyes IM", "Gazer Eyes", ".");
            maxLvl = 3;
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}