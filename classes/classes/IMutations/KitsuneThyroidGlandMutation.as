/**
 * Original code by aimozg on 27.01.14.
 * Reworked for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
    import classes.PerkLib;
    import classes.Player;
    import classes.BodyParts.Tail;

    public class KitsuneThyroidGlandMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.KitsuneThyroidGlandIM)
            if (pTier >= 1){
                descS += "Illusion & Terror -3CD";
            }
            if (pTier >= 2){
                descS += ", FoxFire +50% damage (fire and lust)";
            }
            if (pTier >= 3){
                descS += ", +20% Evasion to Illusion, +50 speed debuff to Terror target, +SF/Mana regen (Star Sphere rank x3/2 respectively), increase Star Sphere Max to 20";
            }
            if (descS != "")descS += ".";
            return descS;
        }
        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.KitsuneThyroidGlandIM)) {
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Kitsune Thyroid Gland " + sufval;
        }
        //Mutation Requirements
        public static function mutationReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.KitsuneThyroidGlandIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.KitsuneThyroidGlandIM.requireThyroidGlandMutationSlot()
                            .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.tailType == Tail.FOX && player.tailCount >= 2;
                            }, "2+ fox tails");
                }
                else{
                    var pLvl:int = pTier * 30
                    IMutationsLib.KitsuneThyroidGlandIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        public function KitsuneThyroidGlandMutation() {
            super("Kitsune Thyroid Gland IM", "Kitsune Thyroid Gland", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}