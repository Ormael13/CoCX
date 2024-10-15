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

public class PoisonGlandMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Poison Gland";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Double the efficiency of poison damage, applied poisons now has a "+(pTier*25)+"% chance of dealing its effect twice per turn";
            }
            if (pTier >= 2){
                descS += ". All poison becomes deadlier, inflicting "+(pTier-1)+"% toughness damage per round";
            }
            if (pTier >= 4){
                descS += ". All poison now becomes lewder, inflicting tease damage equal to your tease value per round on top of any other effect they would do";
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
                    this.requireAdrenalGlandsMutationSlot()
                    .requireAnyRace(Races.BEE, Races.MANTICORE, Races.SANDWORM);//, Races.HORNET, Races.WASP, Races.VOUIVRE, Races.COUATL, Races.HYDRA
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
            if (pTier == 1) pBuffs['tou.mult'] = 0.1;
            if (pTier == 2) pBuffs['tou.mult'] = 0.15;
            if (pTier == 3) pBuffs['tou.mult'] = 0.2;
            if (pTier == 4) pBuffs['tou.mult'] = 0.25;
            return pBuffs;
        }

        public function PoisonGlandMutation() 
		{
			super(mName + " IM", mName, SLOT_ADRENALS, 4);
        }

    }
}
