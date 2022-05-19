/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Face;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class VenomGlandsMutation extends IMutationPerkType
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
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
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

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            else if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            return pBuffs;
        }

        public function VenomGlandsMutation() {
            super("Venom Glands IM", "Venom Glands", ".");
            maxLvl = 3;
        }

        
    }
}
