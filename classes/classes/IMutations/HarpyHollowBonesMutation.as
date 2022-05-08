/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;

    public class HarpyHollowBonesMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.HarpyHollowBonesIM);
            if (pTier >= 1){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your speed and physical damage by 20%";
            }
            if (pTier >= 2){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your physical damage by 50% and speed by 45% and evasiveness by 10%";
            }
            if (pTier >= 3){
                descS = "Your bones are hollow like those of a harpy, decreasing your toughness, but increasing your physical damage by 80% and speed by 90%, evasiveness by 10%, \"Great Dive\" damage by 50%, and prevents it from ending flight";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.HarpyHollowBonesIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Harpy Hollow Bones" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.HarpyHollowBonesIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.HarpyHollowBonesIM.requireHeartMutationSlot();
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.HarpyHollowBonesIM.requireLevel(pLvl);
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
            pBuffs['tou.mult'] = -0.05 * pTier;
            pBuffs['spe.mult'] = pSpeVal();
            return pBuffs;

            function pSpeVal():Number{
                var temp:Number = 0;
                if (pTier >= 1) temp += 0.2;
                if (pTier >= 2) temp += 0.25;
                if (pTier >= 3) temp += 0.45;
                return temp;
            }
        }

        public function HarpyHollowBonesMutation() {
            super("Harpy Hollow Bones IM", "Harpy Hollow Bones", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}