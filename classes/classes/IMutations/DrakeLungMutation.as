/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;

    public class DrakeLungMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DrakeLungIM);
            if (pTier >= 1){
                descS = "Increases the power of dragon breath attack. (+300% to dragon breath damage that race is using)";
            }
            if (pTier >= 2){
                descS = "Further increases increases dragon breath attack power. (+600% to dragon breath damage that race is using)";
            }
            if (pTier >= 3){
                descS = "Allows to use breath attack more often with increase to its power. (+900% to dragon breath damage that race is using AND breath usable once per combat)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.DrakeLungIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Drake Lung" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.DrakeLungIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DrakeLungIM.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DrakeLungIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['spe.mult'] += 0.05;
            if (pTier >= 2) pBuffs['spe.mult'] += 0.1;
            if (pTier >= 3) pBuffs['spe.mult'] += 0.2;
            return pBuffs;
        }

        public function DrakeLungMutation() {
            super("Drake Lung IM", "Drake Lung", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}