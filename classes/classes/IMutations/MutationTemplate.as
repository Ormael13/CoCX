/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;

    public class MutationTemplate extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.MutationsTemplateIM);
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += ", ";
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
            switch (player.perkv1(IMutationsLib.MutationsTemplateIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "PerkName Here" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.MutationsTemplateIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.MutationsTemplateIM.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.MutationsTemplateIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        public static var _perkLvl:int = 3;

        //Mutations Buffs
        public static function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier == 1) pBuffs['int.mult'] = 0;
            else if (pTier == 2) pBuffs['int.mult'] = 0;
            else if (pTier == 3) pBuffs['int.mult'] = 0;
            return pBuffs;
        }

        public function MutationTemplate() {
            super("PerkName Here IM", "PerkName Here", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}