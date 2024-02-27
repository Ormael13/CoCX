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
import classes.Scenes.NPCs.LunaFollower;

public class AlphaHowlMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Alpha Howl";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "You may now form a pack. Unlock the pack attack Feral attack. ";
            }
            if (pTier >= 2){
                descS += "Each additional pack member assists in your defense increasing damage reduction by 2%. ";
            }
            if (pTier >= 3){
                descS += "Each additional pack member helps coordinate your offense, increasing your feral damage by 2% per member. ";
            }
            if (pTier >= 4){
                descS += "Raise the bonus from Evolved to 5% and while a canine grants an increase to all stat of 5% per pack member. ";
            }
            descS += "You may have up to " + 5 * pTier + " pack members";
            if (descS != "")descS += ".";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireLungsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isAnyRaceCached(Races.WEREWOLF, Races.WOLF, Races.CERBERUS, Races.ANUBIS);
                    }, "Werewolf/Wolf/Cerberus/Anubis race");
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
            var packMembers:Number = LunaFollower.WerewolfPackMember;
            if (target.hasMutation(IMutationsLib.HellhoundFireBallsIM)) packMembers += LunaFollower.HellhoundPackMember;
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.30;
            if (pTier == 4) pBuffs['str.mult'] = 0.45;
            if (pTier == 4 && (player.isRaceCached(Races.WEREWOLF) || player.isRaceCached(Races.DOG) || player.isRaceCached(Races.WOLF) || player.isRaceCached(Races.CERBERUS))){
                pBuffs['str.mult'] += 0.05*packMembers;
                pBuffs['spe.mult'] = 0.05*packMembers;
                pBuffs['tou.mult'] = 0.05*packMembers;
                pBuffs['int.mult'] = 0.05*packMembers;
                pBuffs['wis.mult'] = 0.05*packMembers;
                pBuffs['lib.mult'] = 0.05*packMembers;
            }
            return pBuffs
        }

        public function AlphaHowlMutation() {
            super(mName + " IM", mName, SLOT_LUNGS, 4, false);
        }
    }
}
