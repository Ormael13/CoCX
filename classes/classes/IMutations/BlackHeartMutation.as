/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
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
            var pTier:int = player.perkv1(IMutationsLib.BlackHeartIM);
            if (pTier >= 1){
                descS += "Increased Lust strike power, Empower Fascinate";
            }
            if (pTier >= 2){
                descS += ", Adds extra Lust damage to Lust strike dependent on Wisdom (Wis/10) and lowers Fascinate CD by 1";
            }
            if (pTier >= 3){
                descS += ", Adds extra Lust damage to Lust strike dependent on Sensitivity (Sensitivity/10) and extends Facinate Stun to 2 turns";
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
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.BlackHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.BlackHeartIM.requireHeartMutationSlot().requirePerk(PerkLib.DarkCharm).requireCor(100).requireCustomFunction(function (player:Player):Boolean {
                        return player.demonScore() >= 11;
                    }, "Demon race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.BlackHeartIM.requireLevel(pLvl);
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
            if (pTier >= 1) pBuffs['lib.mult'] += 0.05;
            if (pTier >= 2) pBuffs['lib.mult'] += 0.1;
            if (pTier >= 3) pBuffs['lib.mult'] += 0.15;
            return pBuffs;
        }

        public function BlackHeartMutation() {
            super("Black Heart IM", "Black Heart", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}