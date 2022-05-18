/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
import classes.PerkLib;
import classes.PerkType;
import classes.Player;
import classes.Races;

public class SalamanderAdrenalGlandsMutation extends PerkType
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
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.SalamanderAdrenalGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.SalamanderAdrenalGlandsIM.requireAdrenalGlandsMutationSlot()
                    .requirePerk(PerkLib.Lustzerker).requireCustomFunction(function (player:Player):Boolean {
                        return player.salamanderScore() >= 7 || player.isRace(Races.PHOENIX);
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

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
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
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}
