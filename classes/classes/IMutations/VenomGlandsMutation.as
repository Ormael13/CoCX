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

public class VenomGlandsMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this): pTier;
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
            switch (currentTier(this)){
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
        override public function pReqs():void{
            try{
                var pTier:int = currentTier(this);
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireMouthMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.facePart.isAny(Face.SNAKE_FANGS, Face.SPIDER_FANGS);
                    }, "Spider or Snake fangs")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.spiderScore() >= 5 || player.apophisScore() >= 23 || player.nagaScore() >= 8 || player.gorgonScore() >= 11 || player.vouivreScore() >= 11 || player.couatlScore() >= 11 || player.hydraScore() >= 14 || player.atlachNachaScore() >= 21;
                    }, "Spider or any snake-like race");
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
        override public function pBuffs():Object{
            var pBuffs:Object = {};
            var pTier:int = currentTier(this);
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