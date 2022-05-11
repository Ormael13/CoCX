/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class GorgonEyesMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
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

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 2;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier >= 1) {
                pBuffs['spe.mult'] += 0.05;
                pBuffs['sens'] += 5
            }
            if (pTier >= 2) {
                pBuffs['spe.mult'] += 0.1;
                pBuffs['sens'] += 10;
            }
            return pBuffs;
        }

        public function GorgonEyesMutation() {
            super("Gorgon Eyes IM", "Gorgon Eyes", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}