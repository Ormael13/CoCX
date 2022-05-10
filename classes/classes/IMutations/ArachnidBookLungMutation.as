/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
    import classes.Player;

    public class ArachnidBookLungMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.ArachnidBookLungIM);
            if (pTier >= 1){
                descS += "Increase web and poison capacity by " + 100 * pTier + "%";
            }
            if (pTier >= 2){
                descS += ", increases all Web abilities effectiveness by half ";
            }
            if (pTier >= 3){
                descS += ", and gives them a 50% chance to immobilize opponents for 2 rounds when opponent tries to struggle out";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.ArachnidBookLungIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Arachnid Book Lung" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.ArachnidBookLungIM.requirements = [];
                if (pTier == 0){

                    IMutationsLib.ArachnidBookLungIM.requireAdaptationsMutationSlot()
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.spiderScore() >= 5 || player.atlachNachaScore() >= 21;
                            }, "Arachnid race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.ArachnidBookLungIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['int.mult'] += 0.05;
            if (pTier >= 2) pBuffs['int.mult'] += 0.1;
            if (pTier >= 3) pBuffs['int.mult'] += 0.15;
            return pBuffs
        }

        public function ArachnidBookLungMutation() {
            super("Arachnid Book Lung IM", "Arachnid Book Lung", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}