/**
 * Original code by aimozg on 27.01.14.
 * Reworked for Mutations by Jtecx on 14.03.22.
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
            var pTier:int = player.perkv1(IMutationsLib.ArachnidBookLungIM)
            if (pTier >= 1){
                descS += "Increase web and poison capacity by " + 100 * pTier + "%";
            }
            if (pTier >= 2){
                descS += ", increases all Web abilities effectiveness by half ";
            }
            if (pTier >= 3){
                descS += ", and gives them a 50% chance to immobilize opponents for 2 rounds when opponent tries to struggle out.";
            }
            if (descS != "")descS += ".";
            return descS;
        }

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

        public static function mutationReqs():void{
            var pTier:int = player.perkv1(IMutationsLib.ArachnidBookLungIM);
            if (pTier == 0){
                IMutationsLib.ArachnidBookLungIM.requireAdaptationsMutationSlot()
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.spiderScore() >= 5 || player.atlachNachaScore() >= 21;
                        }, "Arachnid race");
            }
            else{
                IMutationsLib.ArachnidBookLungIM.requireLevel(30 * pTier)
            }
        }

        public function ArachnidBookLungMutation() {
            super("Arachnid Book Lung IM", "Arachnid Book Lung", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}