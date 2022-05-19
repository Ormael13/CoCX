/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Face;
import classes.PerkClass;
    import classes.PerkType;
import classes.Player;
import classes.Races;

public class VenomGlandsMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.VenomGlandsIM);
            if (pTier == 1){
                descS = "You now possess venom glands, and your teeth now can inject the venom when you bite";
            }
            if (pTier == 2){
                descS = "You now possess venom glands with increased venom capacity, and your teeth now can inject the venom when you bite (+5% poison resist)";
            }
            if (pTier == 3){
                descS = "You now possess venom glands with increased venom capacity, and your teeth now can inject the venom when you bite (+15% poison resistance)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.VenomGlandsIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Venom Glands" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.VenomGlandsIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.VenomGlandsIM.requireMouthMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
                    }, "Spider or Snake fangs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.spiderScore() >= 5 || player.isRace(Races.APOPHIS) || player.isRace(Races.NAGA) || player.isRace(Races.GORGON) || player.isRace(Races.VOUIVRE) || player.isRace(Races.COUATL) || player.isRace(Races.HYDRA) || player.isRace(Races.ATLACH_NACHA);
                    }, "Spider or any snake-like race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.VenomGlandsIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            else if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function VenomGlandsMutation() {
            super("Venom Glands IM", "Venom Glands", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}
