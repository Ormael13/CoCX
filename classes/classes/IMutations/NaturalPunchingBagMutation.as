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

public class NaturalPunchingBagMutation extends IMutationPerkType
    {
        private static const mName:String = "Natural Punching Bag";
        //v1 contains the mutation tier
        override public function mDesc(params:PerkClass, pTier:int = -1):String {
            var descS:String = "";
            pTier = (pTier == -1)? currentTier(this, player): pTier;
            if (pTier == 1){
                descS = "Increases the damage reduction from Bouncy body by 5% and increase your natural toughness";
            }
            else if (pTier == 2){
                descS = "Increases the damage reduction from Bouncy body by 15%, continue to increase your natural toughness and healing items are more effective";
            }
            else if (pTier == 3){
                descS = "Increases the damage reduction from Bouncy body by 35%, continue to increase your natural toughness, healing/wrath/stat boosting items are more effective and allows you to keep the effect of bouncy body as long as you are below 4 feet tall";
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
                    this.requireFatTissueMutationSlot()
                    .requirePerk(PerkLib.BouncyBody)
                    .requireCustomFunction(function (player:Player):Boolean {
                        return player.isGoblinoid();
                    }, "Goblin race");
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
            var buffVal:Number = 0;
            if (pTier == 1) buffVal = 0.05;
            if (pTier == 2) buffVal = 0.15;
            if (pTier == 3) buffVal = 0.35;
            pBuffs['tou.mult'] = buffVal;
            return pBuffs;
        }

        public function NaturalPunchingBagMutation() {
            super(mName + " IM", mName, SLOT_FAT, 3);
        }

    }
}
