/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.RearBody;
import classes.PerkClass;
    import classes.PerkType;
import classes.Player;
import classes.StatusEffects;

public class GazerEyesMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
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

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
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
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}