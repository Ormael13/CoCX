/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.BodyParts.Face;
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class VenomGlandsMutation extends IMutationPerkType
    {
        private static const mName:String = "Venom Glands";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "You now possess venom glands, and your teeth now can inject the venom when you bite";
            }
            if (pTier == 2){
                descS = "You now possess venom glands with increased venom capacity, and your teeth now can inject the venom when you bite (+5% poison resist)";
            }
            if (pTier == 3){
                descS = "You now possess venom glands with increased venom capacity, and your teeth now can inject the venom when you bite (+15% poison resistance)";
            }
            if (pTier == 4){
                descS = "You now possess venom glands with greatly increased venom capacity, and your teeth now can inject the venom when you bite (+30% poison resistance)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                case 4:
                    sufval = "(Final Form)";
                    break;
                default:
                    sufval = "";
            }
            return mName + sufval;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireMouthMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
                    }, "Spider or Snake fangs")
                    .requireAnyRace(Races.SPIDER, Races.APOPHIS, Races.NAGA, Races.GORGON, Races.VOUIVRE, Races.COUATL, Races.HYDRA, Races.ATLACH_NACHA);
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function buffsForTier(pTier:int):Object {
            var pBuffs:Object = {};
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            else if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            else if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            else if (pTier == 4) pBuffs['tou.mult'] = 0.6;
            return pBuffs;
        }

        public function VenomGlandsMutation() {
            super(mName + " IM", mName, SLOT_MOUTH, 4);
        }

    }
}
