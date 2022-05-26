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
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
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
            return "Gazer Eyes" + sufval;
        }

        //Mutation Requirements
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireEyesMutationSlot()
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

    }
}