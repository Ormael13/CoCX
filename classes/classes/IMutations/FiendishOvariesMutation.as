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

public class FiendishOvariesMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Fiendish Ovaries";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Increases fertility rating by "+((pTier*2)+2)+"0%";
            }
            if (pTier >= 2){
                descS += ", all born children from your womb will either be born as imps or greatly corrupted";
            }
            if (pTier >= 3){
                descS += ", while pregnant with imps tease is "+((pTier-2)*25)+"% stronger";
            }
            if (pTier >= 4){
                descS += ". May benefit from pregomania when pregnant with imps";
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
                    this.requireOvariesMutationSlot()
                    requireCustomFunction(function (player:Player):Boolean {
                        return player.hasVagina();
                    }, "is Female")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity >= 95;
                    }, "95+ feminity")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.racialScore(Races.DEMON) > 14;
                    }, "Demon race (15+)");
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
            if (pTier == 1) pBuffs['lib.mult'] = 0.05;
            if (pTier == 2) pBuffs['lib.mult'] = 0.1;
			if (pTier == 3) pBuffs['lib.mult'] = 0.15;
			if (pTier == 4) pBuffs['lib.mult'] = 0.2;
            return pBuffs;
        }

        public function FiendishOvariesMutation() 
		{
			super(mName + " IM", mName, SLOT_OVARIES, 4);
        }

    }
}
