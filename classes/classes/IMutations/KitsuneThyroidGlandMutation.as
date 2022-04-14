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

        public static function perkTier():int{
            return 3;
        }

        public static function mutationReqs():void{
            var pTier:int = player.perkv1(IMutationsLib.KitsuneThyroidGlandIM);
            if (pTier == 0){
                IMutationsLib.KitsuneThyroidGlandIM.requireThyroidGlandMutationSlot()
                        .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.tailType == Tail.FOX && player.tailCount >= 2;
                        }, "2+ fox tails");
            }
            else{
                IMutationsLib.KitsuneThyroidGlandIM.requireLevel(30 * pTier)
                        .requireCustomFunction(function (player:Player):Boolean {
                            return player.perkv1(IMutationsLib.KitsuneThyroidGlandIM) == pTier;
                        }, "Previous perk tier required.");
            }
        }

        public static function perkBuffs():Object {
            var pBuffs:Object = {};
            var pTier:int = player.perkv1(IMutationsLib.KitsuneThyroidGlandIM)
            pBuffs['spe.mult'] = 0.05 * pTier;
            if (pTier - 1 >= 0) pBuffs['wis.mult'] = 0.05 * (pTier - 1);
            if (pTier - 2 >= 0) pBuffs['int.mult'] = 0.05 * (pTier - 1);
            return pBuffs
        }

        public function KitsuneThyroidGlandMutation() {
            super("Kitsune Thyroid Gland", "Kitsune Thyroid Gland", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}