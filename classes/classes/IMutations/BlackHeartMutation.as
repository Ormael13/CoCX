/**
 * Original code by aimozg on 27.01.14.
 * Reworked for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkLib;
    import classes.PerkType;
    import classes.Player;

    public class BlackHeartMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.BlackHeartIM)
            if (pTier >= 1){
                descS += "";
            }
            if (pTier >= 2){
                descS += "";
            }
            if (pTier >= 3){
                descS += "";
            }
            if (descS != "")descS += ".";
            return descS;
        }
        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.BlackHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Black Heart" + sufval;
        }
        //Mutation Requirements
        public static function mutationReqs():void{
            var pTier:int = player.perkv1(IMutationsLib.BlackHeartIM);
            if (pTier == 0){
                IMutationsLib.BlackHeartIM.requireHeartMutationSlot().requirePerk(PerkLib.DarkCharm).requireCor(100).requireCustomFunction(function (player:Player):Boolean {
                    return player.demonScore() >= 11;
                }, "Demon race");
            }
            else{
                IMutationsLib.BlackHeartIM.requireLevel(30 * pTier)

            }
        }

        public function BlackHeartMutation() {
            super("Black Heart IM", "Black Heart", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}