/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.PerkLib;
import classes.IMutationPerkType;
import classes.Creature;
import classes.Player;
import classes.Races;

public class HellHoundFireBallsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Hellhound Fire Balls";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS = "Increase Hellfire damage and Cum production by 25%. +"+(5*pTier)+" Lib. ";
            }
            if (pTier == 2){
                descS += "Increase fire damage by a percentage based on 1% of your current lust. ";
            }
            if (pTier >= 3){
                descS += "Increase fire damage by a percentage based on 2% of your current lust. ";
            }
            if (pTier >= 4){
                descS += "Double your cum production. ";
            }
            if (pTier >= 4){
                descS += "If you have the Alpha howl perk you may now forcibly recruit hellhounds into your pack equal to the number of werewolves you may control.";
            } else if (pTier >= 2){
                descS += "If you have the Alpha howl perk you may now forcibly recruit hellhounds into your pack equal to half the number of werewolves you may control.";
            }
            return descS;
        }

        override public function evolveText():String {
            var descS:String = "\nYour balls begin to suddenly feel heavier… warmer. You begin pumping your two penis absentmindedly thinking of all the bitches you recently broke on your twin shaft as the heat rushes all the way to your pair of erect members. You cum a humongous load of smoking warm cum, way to warm for normal seeds. It looks like your balls are progressively continuing their evolution to be more hellhound-like as your seed takes on burning hot property just like that of a hellhound.";
            return descS;
        }

        //Mutation Requirements
        override public function pReqs(pCheck:int = -1):void{
            try{
                var pTier:int = (pCheck != -1 ? pCheck : currentTier(this, player));
                //This helps keep the requirements output clean.
                this.requirements = [];
                if (pTier == 0){
                    this.requireBallsMutationSlot()
                    .requirePerk(PerkLib.Hellfire)
					.requireCustomFunction(function (player:Player):Boolean {
                        return player.isRace(Races.CERBERUS) || player.racialScore(Races.DOG) >= 8;
                    }, "Cerberus race or Dog-morph (8+) with Hellfire perk");
                }
                else{
                    var pLvl:int = pTier * 30;
                    this.requireLevel(pLvl)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.perkv2(IMutationsLib.HellhoundFireBallsIM) >= pLvl
                    }, "Rapes with dick: "+player.perkv2(this)+"/"+pLvl*2);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function buffsForTier(pTier:int, target:Creature):Object {
            var pBuffs:Object = {};
            pBuffs['lib.mult'] = 0.05 * currentTier(this, player);
            return pBuffs;
        }

        public function HellHoundFireBallsMutation() {
            super(mName + " IM", mName, SLOT_TESTICLES, 4);
        }

    }
}
