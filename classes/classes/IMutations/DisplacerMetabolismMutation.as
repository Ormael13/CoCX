/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.GlobalFlags.kFLAGS;
    import classes.PerkClass;
    import classes.PerkType;
    import classes.Player;

public class DisplacerMetabolismMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DisplacerMetabolismIM);
            if (pTier >= 1){
                descS += "Increase strength and speed, reduces int after consuming milk";
            }
            if (pTier >= 2){
                descS += ", further increase max capacity of strength and speed by 100% * NG+, int reduction lasts 5 hours longer and adds 50% extra duration";
            }
            if (flags[kFLAGS.HUNGER_ENABLED] > 0) descS += ", increases max hunger cap by 50";
            if (descS != ""){
                descS += (", and increases displacer beast claws attack damage by x" + pTier + 1);
                descS += ".";
            }
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.DisplacerMetabolismIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Displacer Metabolism" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.DisplacerMetabolismIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DisplacerMetabolismIM.requireMetabolismMutationSlot()
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.displacerbeastScore() >= 14;
                    }, "Displacer beast");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DisplacerMetabolismIM.requireLevel(pLvl);
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
            return pBuffs;
        }

        public function DisplacerMetabolismMutation() {
            super("Displacer Metabolism IM", "Displacer Metabolism", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}