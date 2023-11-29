/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class TwinHeartMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Twin Heart";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "+40% fatigue recovery, with tauric/drider body: +100% fatigue recovery, reduce Charge fatigue cost by ~10% as well as its cooldown by 1.";
            }
            if (pTier == 2){
                descS = "+80% fatigue recovery, with tauric/drider body: +200% fatigue recovery, reduce Charge fatigue cost by ~20% as well as its cooldown by 2, increase damage by 20%.";
            }
            if (pTier == 3){
                descS = "+120% fatigue recovery, with tauric/drider body: +300% fatigue recovery, reduce Charge fatigue cost by ~30% as well as its cooldown by 3, increase damage by 80%.";
            }
            if (pTier == 4){
                descS = "+160% fatigue recovery, with tauric/drider body: +400% fatigue recovery, reduce Charge fatigue cost by ~40% as well as its cooldown by 4, increase damage by 200%.";
            }
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireAdaptationsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isRace(Races.CENTAUR) || player.isRace(Races.UNICORN, 2) || player.isRace(Races.SPHINX) || player.isRace(Races.CANCER) || player.isRace(Races.SANDWORM) || player.isTaur() || player.isDrider();
                    }, "Taur/Drider or Unicorn/Bicorn race");
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
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            if (pTier == 1) {
                pBuffs['tou.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            else if (pTier == 2) {
                pBuffs['tou.mult'] = 0.15;
                pBuffs['spe.mult'] = 0.15;
            }
            else if (pTier == 3) {
                pBuffs['tou.mult'] = 0.35;
                pBuffs['spe.mult'] = 0.35;
            }
            else if (pTier == 4) {
                pBuffs['tou.mult'] = 0.75;
                pBuffs['spe.mult'] = 0.75;
            }
            return pBuffs;
        }

        public function TwinHeartMutation() {
            super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
        }

    }
}
