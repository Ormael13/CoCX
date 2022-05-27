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

public class DraconicHeartMutation extends IMutationPerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.DraconicHeartIM);
            if (pTier >= 1){
                descS = "Your heart was strengthened to better handle your changing body. (+1 Fatigue / +4 SF / +5 Mana / +1 Wrath regen)";
            }
            if (pTier >= 2){
                descS = "Each heartbeat fills your body with great power. (+2 Fatigue / +8 SF / +10 Mana / +2 Wrath regen, +5% of max core Str as phantom Str)";
            }
            if (pTier >= 3){
                descS = "Your heart metamorphosis reached pseudo-dragon level. (+3 Fatigue / +12 SF / +15 Mana / +3 Wrath regen, +1% HP regen, +15% of max core Str as phantom Str)";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.DraconicHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Draconic Heart" + sufval;
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
                IMutationsLib.DraconicHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.DraconicHeartIM.requireHeartMutationSlot()
                    .requireMutation(IMutationsLib.DraconicBonesIM)
                    .requireAnyRace(Races.DRAGON,Races.FROSTWYRM,Races.SEA_DRAGON);
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.DraconicHeartIM.requireLevel(pLvl);
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
            if (pTier == 1) pBuffs['str.mult'] = 0.05;
            if (pTier == 2) pBuffs['str.mult'] = 0.15;
            if (pTier == 3) pBuffs['str.mult'] = 0.35;
            return pBuffs;
        }

        public function DraconicHeartMutation() {
            super("Draconic Heart IM", "Draconic Heart", ".");
            maxLvl = 3;
        }

        
    }
}
