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

public class MinotaurTesticlesMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Minotaur Testicles";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var maxL:Number = 10;
			if (pTier >= 3) maxL += 90;
			var res:Number = 5;
			if (pTier >= 4) maxL += 10;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Allows you to keep Cum Cannon special even if minotaur score is lower than 9, max Lust increased by "+maxL+"";
            }
            if (pTier >= 2){
                descS += ", +"+res+"% to lust resistance, increase cum output by 200 mLs";
            }
            if (pTier == 3){
                descS += ", increase cum production by ~150% and Cum Cannon cost rise to 200 lust but can be used more than once per fight";
            }
            if (pTier == 4){
                descS += ", increase cum production by ~200%, +10% to max overlust, negative effects of libido are reduced by 5% and Cum Cannon cost rise to 200 lust but can be used more than once per fight";
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
                    this.requireBallsMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.hasCock();
                    }, "is Male")
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.femininity <= 5;
                    }, "5- feminity")
                    .requireRace(Races.MINOTAUR)
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
            if (pTier == 2) pBuffs['lib.mult'] = 0.1;
            if (pTier == 3){
                pBuffs['str.mult'] = 0.1;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['lib.mult'] = 0.2;
            }
            if (pTier == 4){
                pBuffs['str.mult'] = 0.2;
                pBuffs['tou.mult'] = 0.1;
                pBuffs['lib.mult'] = 0.4;
            }
            return pBuffs;
        }

        public function MinotaurTesticlesMutation() {
            super(mName + " IM", mName, SLOT_TESTICLES, 4);
        }

    }
}
