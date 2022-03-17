/**
 * Original code by aimozg on 27.01.14.
 * Reworked for Mutations by Jtecx on 14.03.22.
 */
package classes.Mutations
{
    import classes.MutationsLib;
    import classes.PerkClass;
    import classes.PerkType;
    import classes.PerkLib;
    import classes.Player;

    public class KitsuneThyroidGlandMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = ""
            var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland)
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

        /*
        public function llongDesc(params:PerkClass = null):String{
            var descS:String = ""
            var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland)
            if (pTier >= 1){
                descS = "Cooldowns for Illusion and Terror are lowered by three turns. ";
            }
            if (pTier >= 2){
                descS += "Foxfire gains an additional 50% damage. ";
            }
            if (pTier >= 3){
                descS += "Evasion from Illusion is increased by 20%, incur a further 50 speed debuff to terror target, increase SF/Mana regen based on Star Sphere Rank, and increases Star Sphere max rank to 20.";
            }
            return descS;
        }*/

        override public function name(params:PerkClass=null):String {
            var sufval:String = "";
            switch (player.perkv1(MutationsLib.KitsuneThyroidGland)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
            }
            return "Kitsune Thyroid Gland " + sufval;
        }

        public function KitsuneThyroidGlandMutation() {
            super("Kitsune Thyroid Gland", "Kitsune Thyroid Gland", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }

        public static function mutationReqs():void{
            var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland);
            switch (pTier){
                case 0:
                    MutationsLib.KitsuneThyroidGland.requireThyroidGlandMutationSlot()
                            .requireAnyPerk(PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune)
                            .requireCustomFunction(function (player:Player):Boolean {
                        return player.kitsuneScore() >= 5;
                    }, "Kitsune Score >= 5");
                    break;
                case 1:
                    MutationsLib.KitsuneThyroidGland.requireLevel(30)
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.kitsuneScore() >= 8;
                            }, "Kitsune Score >= 8");
                    break;
                case 2:
                    MutationsLib.KitsuneThyroidGland.requireLevel(60)
                            .requireCustomFunction(function (player:Player):Boolean {
                                return player.kitsuneScore() >= 12;
                            }, "Kitsune race");
                    break;
            }
        }

        public static function perkBuffs():Object {
            var pBuffs:Object = {};
            var pTier:int = player.perkv1(MutationsLib.KitsuneThyroidGland)
            pBuffs['spe.mult'] = 0.05 * pTier;
            if (pTier - 1 != 0) pBuffs['wis.mult'] = 0.05 * (pTier - 1);
            if (pTier - 2 != 0) pBuffs['int.mult'] = 0.05 * (pTier - 1);
            return pBuffs
        }
    }
}