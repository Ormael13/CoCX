/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations 
{
import classes.Creature;
import classes.IMutationPerkType;
import classes.PerkClass;
import classes.Player;
import classes.Races;

public class ElvenSharpEyesMutation extends IMutationPerkType
	{
		public static const MNAME:String = "Elven sharp eyes";
		override public function get mName():String {
			return MNAME;
		}
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
			var pAcc:int = 5;
            pTier = (pTier == -1)? currentTier(this, player): pTier;
			if (pTier >= 3) pAcc += 5;
			if (pTier >= 4) pAcc += 10;
			if (pTier >= 1){
				descS += "60 lvl's. Reduces accuracy penalty by 10% for each successive attack during a multiattack. You can now also see in darkness - Dark Vision.";
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
                    this.requireEyesMutationSlot()
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.racialScore(Races.HUMAN) > 16;
                    }, "Human race (17+)");
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
				pBuffs['spe.mult'] = 0.15;
                pBuffs['sens'] = 15;
			}
            if (pTier == 2) {
				pBuffs['spe.mult'] = 0.45;
                pBuffs['sens'] = 45;
			}
            if (pTier == 3) {
				pBuffs['spe.mult'] = 1.5;
                pBuffs['sens'] = 150;
			}
            if (pTier == 4) {
				pBuffs['spe.mult'] = 4.5;
                pBuffs['sens'] = 450;
			}
            return pBuffs;
        }

        public function ElvenSharpEyesMutation() 
		{
			super(MNAME, SLOT_NONE, 1);//SLOT_EYES
        }

    }
}
