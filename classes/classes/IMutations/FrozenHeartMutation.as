/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;

    public class FrozenHeartMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.FrozenHeartIM);
            if (pTier >= 1){
                descS += "Allow you to retain the ability Ice barrage and hungering cold at all times";
            }
            if (pTier >= 3){
                descS += ", hungering cold lasts for 3 additional turn(s) and recharge 3 turn(s) faster. Gain an extra modifier from your intelligence to health. (Increase original value by 50%).";
            }
            else if (pTier >= 2){
                descS += "hungering cold last for 1 additional turn and recharge 1 turn faster";
            }
            descS += "and increase their damage by" + 10 * pTier + "%";
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.FrozenHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Frozen Heart" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.FrozenHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.FrozenHeartIM.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.FrozenHeartIM.requireLevel(pLvl);
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
            return pBuffs;
        }

        public function FrozenHeartMutation() {
            super("Frozen Heart IM", "Frozen Heart", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}