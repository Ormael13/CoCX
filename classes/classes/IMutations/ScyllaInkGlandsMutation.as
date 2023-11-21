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
        private static const mName:String = "Scylla Ink Glands";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier >= 1){
                descS += "Your Scylla Ink Glands increase rate at which your body produce ink";
            }
            if (pTier >= 2){
                descS += ", duration ink spray affect enemies and lust damage";
            }
            if (pTier >= 1){
                descS += " by 100%, boost to your natural strength";
            }
            if (pTier >= 2){
                descS += " and toughness, Scylla Squeeze damage during grapple as Kraken would be multiplied by "+pTier+"x";
            }
            if (pTier >= 3){
                descS += ", ";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (currentTier(this, player)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                case 4:
                    sufval = "(Final Form)";
                    break;
                default:
                    sufval = "";
            }
            return mName + sufval;
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
            //else if (pTier == 3) pBuffs['str.mult'] = 0;
            return pBuffs;
        }

        public function ScyllaInkGlandsMutation() {
            super(mName + " IM", mName, SLOT_ADAPTATIONS, 2);
        }
        
    }
}
