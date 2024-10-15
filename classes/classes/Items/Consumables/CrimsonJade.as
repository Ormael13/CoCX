/**
 * ...
 * @author Ormael
 */
package classes.Items.Consumables 
{
import classes.BaseContent;
import classes.CoC;
import classes.EngineCore;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

public class CrimsonJade extends Consumable {
	
	public function CrimsonJade() 
	{
		super("Crims.J", "Crimson Jade", "a Crimson Jade", 50, "This jade seems to contain knowledge about the usage of blood soulskills. There's a faint metallic scent that lingers around it, the unmistakable scent of blood from some creature.");
	}

    override public function useItem():Boolean {
        clearOutput();
        outputText("What do you want to do with this Crimson Jade?");
		crimsonJade();
        return true;
    }
	public function crimsonJade():void {
		EngineCore.menu();
        EngineCore.addButton(0, "Back", crimsonJade0);
		EngineCore.addButton(1, "Use", crimsonJade1, 0).hint("Only Wis gain with no soulskill learned.");
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) {
			if (player.wis >= 20 && !player.hasStatusEffect(StatusEffects.KnowsBloodSwipe)) EngineCore.addButton(2, "B.Swip", crimsonJade1, 1).hint("Learn Blood Swipe soulskill.");
			else EngineCore.addButtonDisabled(2, "B.Swip", "You not have have enough wis or already know this soulskill.");
			if (player.wis >= 30 && !player.hasStatusEffect(StatusEffects.KnowsHeartSeeker)) EngineCore.addButton(3, "H.Seek", crimsonJade1, 2).hint("Learn Heart Seeker soulskill.");
			else EngineCore.addButtonDisabled(3, "H.Seek", "You not have have enough wis or already know this soulskill.");
			if (player.wis >= 40 && !player.hasStatusEffect(StatusEffects.KnowsBloodDewdrops)) EngineCore.addButton(4, "B.Dewd", crimsonJade1, 3).hint("Learn Blood Dewdrops soulskill.");
			else EngineCore.addButtonDisabled(4, "B.Dewd", "You not have have enough wis or already know this soulskill.");
			if (player.wis >= 50 && !player.hasStatusEffect(StatusEffects.KnowsBloodRequiem)) EngineCore.addButton(5, "B.Requ", crimsonJade1, 4).hint("Learn Blood Requiem soulskill.");
			else EngineCore.addButtonDisabled(5, "B.Requ", "You not have have enough wis or already know this soulskill.");
			//(6, "C.Over", crimsonJade1, 5), "You not have have enough wis or already know this soulskill.", (player.wis >= 60 && !player.hasStatusEffect(StatusEffects.)), "Learn Crimson Overflow soulskill.");
			if (player.wis >= 70 && !player.hasStatusEffect(StatusEffects.KnowsScarletSpiritCharge)) EngineCore.addButton(7, "S.S.Ch", crimsonJade1, 6).hint("Learn Scarlet Spirit Charge soulskill.");
			else EngineCore.addButtonDisabled(7, "S.S.Ch", "You not have have enough wis or already know this soulskill.");
		}
		if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) {
			if (player.wis >= 30 && !player.hasStatusEffect(StatusEffects.KnowsBloodSwipeSF) && player.hasStatusEffect(StatusEffects.KnowsBloodSwipe)) EngineCore.addButton(8, "S.B.Swip", crimsonJade1, 7).hint("Learn (Soulforce infused) Blood Swipe soulskill.");
			else EngineCore.addButtonDisabled(8, "S.B.Swip", "You not have have enough wis or already know this soulskill.");
			if (player.wis >= 40 && !player.hasStatusEffect(StatusEffects.KnowsHeartSeekerSF) && player.hasStatusEffect(StatusEffects.KnowsHeartSeeker)) EngineCore.addButton(9, "S.H.Seek", crimsonJade1, 8).hint("Learn (Soulforce infused) Heart Seeker soulskill.");
			else EngineCore.addButtonDisabled(9, "S.H.Seek", "You not have have enough wis or already know this soulskill.");
			if (player.wis >= 50 && !player.hasStatusEffect(StatusEffects.KnowsBloodDewdropsSF) && player.hasStatusEffect(StatusEffects.KnowsBloodDewdrops)) EngineCore.addButton(10, "S.B.Dewd", crimsonJade1, 9).hint("Learn (Soulforce infused) Blood Dewdrops soulskill.");
			else EngineCore.addButtonDisabled(10, "S.B.Dewd", "You not have have enough wis or already know this soulskill.");
			if (player.wis >= 60 && !player.hasStatusEffect(StatusEffects.KnowsBloodRequiemSF) && player.hasStatusEffect(StatusEffects.KnowsBloodRequiem)) EngineCore.addButton(11, "S.B.Requ", crimsonJade1, 10).hint("Learn (Soulforce infused) Blood Requiem soulskill.");
			else EngineCore.addButtonDisabled(11, "S.B.Requ", "You not have have enough wis or already know this soulskill.");
		}
	}
	public function crimsonJade0():void {
		outputText("You put away the crimson jade. Now is not good time to use it.");
		SceneLib.inventory.returnItemToInventory(this);
	}
    public function crimsonJade1(soulskill:Number):void {
		clearOutput();
        outputText("You touch the crimson jade only to discover that it seems to be an instructional on the use of blood soulskills. The jade shares generic information about blood soulskills. The contents seem to go over the basics; how to draw power using your blood as well as the consequences of repeated use, beneficial or not.[pg]");
		outputText("It doesn't take long to absorb all knowledge stored in jade, but before you can stow it away for later, the crystal crumbles into crimson dust. The same metallic scent lingers on your [claws], the lingering smell of blood is stained on you... at least for the time being.");
        if (player.wis < 30) {
            outputText("[pg]You feel greatly enlightened by your time spent reading.");
            player.KnowledgeBonus("wis", 4);
        } else if (player.wis < 60) {
            outputText("[pg]Spending some time reading was probably good for you, and you definitely feel wiser for it.");
            player.KnowledgeBonus("wis", 2);
        } else if (player.wis < 90) {
            outputText("[pg]After reading the crimson jade your already quick mind feels invigorated.");
            player.KnowledgeBonus("wis", 1);
        } else {
            outputText("[pg]The contents of the jade did little for your already considerable wisdom.");
            player.KnowledgeBonus("wis", 0.6);
        } if (soulskill > 0) {
			switch (soulskill){
				case 1:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: Blood Swipe.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodSwipe, 0, 0, 0, 0);
					break;
				case 2:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: Heart Seeker.</b>");
					player.createStatusEffect(StatusEffects.KnowsHeartSeeker, 0, 0, 0, 0);
					break;
				case 3:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: Blood Dewdrops.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodDewdrops, 0, 0, 0, 0);
					break;
				case 4:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: Blood Requiem.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodRequiem, 0, 0, 0, 0);
					break;/*
				case 5:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: Crimson Overflow.</b>");
					player.createStatusEffect(StatusEffects., 0, 0, 0, 0);
					break;*/
				case 6:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: Scarlet Spirit Charge.</b>");//not yet have additional effect from Way of the Blood
					player.createStatusEffect(StatusEffects.KnowsScarletSpiritCharge, 0, 0, 0, 0);
					break;
				case 7:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: (Soulforce infused) Blood Swipe.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodSwipeSF, 0, 0, 0, 0);
					break;
				case 8:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: (Soulforce infused) Heart Seeker.</b>");
					player.createStatusEffect(StatusEffects.KnowsHeartSeekerSF, 0, 0, 0, 0);
					break;
				case 9:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: (Soulforce infused) Blood Dewdrops.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodDewdropsSF, 0, 0, 0, 0);
					break;
				case 10:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood soulskill: (Soulforce infused) Blood Requiem.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodRequiemSF, 0, 0, 0, 0);
					break;
			}
		}
        SceneLib.inventory.itemGoNext();
	}
}
}
