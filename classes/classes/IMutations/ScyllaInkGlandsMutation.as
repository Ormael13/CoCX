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
import classes.Races;

public class ScyllaInkGlandsMutation extends IMutationPerkType
    {
        override public function get mName():String {
            return "Scylla Ink Glands";
        }
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Your Scylla Ink Glands increases the rate at which your body produce ink";
            }
            if (pTier >= 2){
                descS += ", the duration ink spray affects enemies and your lust damage increases by "+(pTier-1)+"00%";
            }
            if (pTier >= 1){
                descS += ", boost to your natural strength";
            }
            if (pTier >= 3){
                descS += ", speed";
            }
            if (pTier >= 2){
                descS += " and toughness, Scylla Squeeze damage during grapple as Kraken is multiplied by "+pTier+"x";
            }
            if (pTier >= 3){
                descS += ", scylla grapple will always succeed, when in an aquatic battle boost from Aquatic Affinity is "+(pTier-1)+"x larger";
            }
            if (pTier >= 4){
                descS += ", final boost from aquatic battle boost is 2x higher, enemy can't escape from scylla grapple using only its own strength and using Scylla Squeeze as Kraken will give the enemy a 4% combat wounds debuff each time (up to 80%)";
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
                    this.requireAdaptationsMutationSlot()
                    .requirePerk(PerkLib.InkSpray)
                    .requireRace(Races.SCYLLA);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.1;
            else if (pTier == 2) {
				pBuffs['str.mult'] = 0.3;
				pBuffs['tou.mult'] = 0.05;
			}
            else if (pTier == 3) {
				pBuffs['str.mult'] = 0.6;
				pBuffs['tou.mult'] = 0.2;
				pBuffs['spe.mult'] = 0.1;
			}
            else if (pTier == 4) {
				pBuffs['str.mult'] = 1.8;
				pBuffs['tou.mult'] = 0.6;
				pBuffs['spe.mult'] = 0.3;
			}
            return pBuffs;
        }

        public function ScyllaInkGlandsMutation() {
            super(mName + " IM", mName, SLOT_ADAPTATIONS, 4);
        }
        
    }
}
