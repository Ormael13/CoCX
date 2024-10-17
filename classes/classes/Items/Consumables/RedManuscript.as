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

public class RedManuscript extends Consumable {
	
	public function RedManuscript() 
	{
		super("R.Manusc", "R. Manuscript", "a Red Manuscript", 50, "This manuscript contains knowledge about blood spells.  There's a faint metallic scent that lingers around it, the unmistakable scent of blood from some creature.");
	}

    override public function useItem():Boolean {
        clearOutput();
        outputText("What you want to do with this Red Manuscript?");
        redManuscript();
        return true;
    }
	public function redManuscript():void {
		EngineCore.menu();
		EngineCore.addButton(0, "Back", redManuscript0);
		EngineCore.addButton(1, "Use", redManuscript1, 0).hint("Only Int gain with no spell learned.");
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon) || player.hasPerk(PerkLib.PrestigeJobGreySage)) {
			if (player.inte >= 20 && !player.hasStatusEffect(StatusEffects.KnowsBloodMissiles)) EngineCore.addButton(2, "B.Miss", redManuscript1, 1).hint("Learn Blood Missiles spell.");
			else EngineCore.addButtonDisabled(2, "B.Miss", "You do not have enough intelligence or already know this spell.");
			if (player.inte >= 30 && !player.hasStatusEffect(StatusEffects.KnowsBloodShield)) EngineCore.addButton(3, "B.Shie", redManuscript1, 2).hint("Learn Blood Shield spell.");
			else EngineCore.addButtonDisabled(3, "B.Shie", "You do not have enough intelligence or already know this spell.");
			if (player.inte >= 40 && !player.hasStatusEffect(StatusEffects.KnowsBloodExplosion)) EngineCore.addButton(4, "B.Expl", redManuscript1, 3).hint("Learn Blood Explosion spell.");
			else EngineCore.addButtonDisabled(4, "B.Expl", "You do not have enough intelligence or already know this spell.");
			if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsBloodChains)) EngineCore.addButton(5, "B.Chai", redManuscript1, 4).hint("Learn Blood Chains spell.");
			else EngineCore.addButtonDisabled(5, "B.Chai", "You do not have enough intelligence or already know this spell.");
			if (player.inte >= 60 && !player.hasStatusEffect(StatusEffects.KnowsBloodWave)) EngineCore.addButton(6, "B.Wave", redManuscript1, 5).hint("Learn Blood Wave spell.");
			else EngineCore.addButtonDisabled(6, "B.Wave", "You do not have enough intelligence or already know this spell.");
			if (player.inte >= 70 && !player.hasStatusEffect(StatusEffects.KnowsLifestealEnchantment)) EngineCore.addButton(7, "L.Ench", redManuscript1, 6).hint("Learn Lifesteal Enchantment spell.");
			else EngineCore.addButtonDisabled(7, "L.Ench", "You do not have enough intelligence or already know this spell.");
			if (player.inte >= 80 && !player.hasStatusEffect(StatusEffects.KnowsBloodField)) EngineCore.addButton(8, "B.Fiel", redManuscript1, 7).hint("Learn Blood Field spell.");
			else EngineCore.addButtonDisabled(8, "B.Fiel", "You do not have enough intelligence or already know this spell.");
		}
	}
	public function redManuscript0():void {
		outputText("You close the red manuscript. Now is not a good time to use it.");
		SceneLib.inventory.returnItemToInventory(this);
	}
	public function redManuscript1(spell:Number):void {
		clearOutput();
        outputText("You open the red manuscript and discover it to be an instructional on the use of blood magic.  The book shares generic information about blood magic, generally what you'd expect anyway - how to draw it using your blood as well as the positive and negative effects of repeated use.  It doesn't take long to read a few pages, but before you can stow it away for later, the book vanishes within your hands. The same metallic scent lingers on your [claws], the lingering smell of blood is stained on you... at least for the time being.");
        if (player.inte < 30) {
            outputText("[pg]You feel greatly enlightened by your time spent reading.");
            player.KnowledgeBonus("int", 4);
        } else if (player.inte < 60) {
            outputText("[pg]Spending some time reading was probably good for you, and you definitely feel smarter for it.");
            player.KnowledgeBonus("int", 2);
        } else if (player.inte < 90) {
            outputText("[pg]After reading the small tome your already quick mind feels invigorated.");
            player.KnowledgeBonus("int", 1);
        } else {
            outputText("[pg]The contents of the manuscript did little for your already considerable intellect.");
            player.KnowledgeBonus("int", 0.6);
        } if (spell > 0) {
			switch (spell){
				case 1:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Blood Missiles.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodMissiles, 0, 0, 0, 0);
					break;
				case 2:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Blood Shield.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodShield, 0, 0, 0, 0);
					break;
				case 3:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Blood Explosion.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodExplosion, 0, 0, 0, 0);
					break;
				case 4:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Blood Chains.</b>");//not yet have additional effect from Way of the Blood
					player.createStatusEffect(StatusEffects.KnowsBloodChains, 0, 0, 0, 0);
					break;
				case 5:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Blood Wave.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodWave, 0, 0, 0, 0);
					break;
				case 6:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Lifesteal Enchantment.</b>");
					player.createStatusEffect(StatusEffects.KnowsLifestealEnchantment, 0, 0, 0, 0);
					break;
				case 7:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new blood spell: Blood Field.</b>");//not yet have additional effect from Way of the Blood
					player.createStatusEffect(StatusEffects.KnowsBloodField, 0, 0, 0, 0);
					break;
			}
		}
        SceneLib.inventory.itemGoNext();
	}
}
}
