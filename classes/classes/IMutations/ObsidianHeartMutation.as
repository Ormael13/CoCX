/**
 * Original code by aimozg on 27.01.14.
 * Extended for Mutations by Jtecx on 14.03.22.
 */
package classes.IMutations
{
    import classes.PerkClass;
    import classes.PerkType;
import classes.Player;

public class ObsidianHeartMutation extends PerkType
    {
        //v1 contains the mutation tier
        override public function desc(params:PerkClass = null):String {
            var descS:String = "";
            var pTier:int = player.perkv1(IMutationsLib.ObsidianHeartIM);
            if (pTier >= 1){
                descS += "Devil.M Specials are available even if you do not qualify as devilkin, but will increase your corruption each use until it reaches 60";
            }
            if (pTier == 2){
                descS += ", Maleficium's duration is increased by 5 turns and spellpower is boosted by 25%, Infernal Flare +~25%";
            }
            if (pTier == 3){
                descS += ", Maleficium's duration is increased by 5 turns and spellpower is boosted by 150% + lowers lust resistance to 30%, Infernal Flare +~65% and 20% higher chance to crit";
            }
            if (descS != "")descS += ".";
            return descS;
        }

        //Name. Need it say more?
        override public function name(params:PerkClass=null):String {
            var sufval:String;
            switch (player.perkv1(IMutationsLib.ObsidianHeartIM)){
                case 2:
                    sufval = "(Primitive)";
                    break;
                case 3:
                    sufval = "(Evolved)";
                    break;
                default:
                    sufval = "";
            }
            return "Obsidian Heart" + sufval;
        }

        //Mutation Requirements
        public static function pReqs(pTier:int = 0):void{
            try{
                //This helps keep the requirements output clean.
                IMutationsLib.ObsidianHeartIM.requirements = [];
                if (pTier == 0){
                    IMutationsLib.ObsidianHeartIM.requireHeartMutationSlot()
                    .requireCor(100).requireCustomFunction(function (player:Player):Boolean {
                        return player.devilkinScore() >= 11;
                    }, "Devil race");
                }
                else{
                    var pLvl:int = pTier * 30;
                    IMutationsLib.ObsidianHeartIM.requireLevel(pLvl);
                }
            }catch(e:Error){
                trace(e.getStackTrace());
            }
        }

        //Perk Max Level
        //Ignore the variable. Reusing the function that triggers this elsewhere and they need the int.
        public static function perkLvl(useless:int = 0):int{
            return 3;
        }

        //Mutations Buffs
        public function pBuffs(pTier:int = 1):Object{
            var pBuffs:Object = {};
            if (pTier == 3) {
                pBuffs['str.mult'] = 0.05;
                pBuffs['tou.mult'] = 0.05;
                pBuffs['spe.mult'] = 0.05;
            }
            return pBuffs;
        }

        public function ObsidianHeartMutation() {
            super("Obsidian Heart IM", "Obsidian Heart", ".");
        }

        override public function keepOnAscension(respec:Boolean = false):Boolean {
            return true;
        }
    }
}