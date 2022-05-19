/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
import classes.PerkClass;
import classes.IMutationPerkType;
import classes.Player;
import classes.Races;

public class YetiFatMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.YetiFatIM);
            if (pTier >= 1){
                descS += "Gain damage reduction against attacks, increase strength of yeti ice breath by 50%";
            }
            if (pTier >= 2){
                descS += ", potency of Big Hand and Feet by 50%";
            }
            if (pTier >= 3){
                descS += ", duration of yeti breath stun by 1 round and reduce cooldown by 3 rounds.";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.YetiFatIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Yeti Fat" + sufval;
        }

        //Mutation Requirements
        override public function pReqs(target:* = null):void{
            try{
                if (target == null){
                    trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                    target = player;
                }
                var params:PerkClass = target.getPerk(this);
                var pTier:int = params.value1;
                //This helps keep the requirements output clean.
                IMutationsLib.YetiFatIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.YetiFatIM.requireFatTissueMutationSlot()
                    .requireRace(Races.YETI);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.YetiFatIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Mutations Buffs
        override public function pBuffs(target:* = null):Object{
            var pBuffs:Object = {};
            if (target == null){
                trace("Notice: pBuffs target was not set for perk " + this.name() + ". Defaulting to player.");
                target = player;
            }
            var params:PerkClass = target.getPerk(this);
            var pTier:int = params.value1;
            return pBuffs;
        }

        public function YetiFatMutation() {
            super("Yeti Fat IM", "Yeti Fat", ".");
            maxLvl = 3;
        }
    }
}
