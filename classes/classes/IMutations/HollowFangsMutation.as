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

public class HollowFangsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Hollow Fangs";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Your fangs and mouth have started to slowly change showing rudimental ability to suck out fluids like blood. (+5 max stack of Vampire Thirst)";
            }
            if (pTier == 2){
                descS = "Your ability to suck substances like blood have developed halfway. (+5 max stack of Vampire Thirst, +2% more healed from Vampire Bite)";
            }
			if (pTier >= 3){
				descS = "You can now freely feed on blood and other atypical fluids. (+10 max stack of Vampire Thirst, ";
			}
            if (pTier == 3){
                descS = "+8% more healed from Vampire Bite, each Vampire Bite giving 2 stacks and deal +50% lust dmg)";
            }
            if (pTier == 4){
                descS = "+20% more healed from Vampire Bite, each Vampire Bite giving 5 stacks and deal +100% lust dmg)";
            }
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
                    this.requireMouthMutationSlot()
                    .requireMutation(IMutationsLib.VampiricBloodstreamIM)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.facePart.type == 34;//player.facePart.isAny(Face.VAMPIRE, Face.)
                    }, "Vampire fangs")
                    .requireAnyRace(Races.VAMPIRE, Races.DRACULA);//, Races.WERESPIDER
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.05;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.3;
            if (pTier == 4) pBuffs['tou.mult'] = 0.6;
            return pBuffs;
        }

        public function HollowFangsMutation() {
            super(mName + " IM", mName, SLOT_MOUTH, 4);
        }
        
    }
}
