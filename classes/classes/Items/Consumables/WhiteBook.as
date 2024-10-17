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

public class WhiteBook extends Consumable {
	
	public function WhiteBook() 
	{
		super("W. Book", "W. Book", "a small book with a pristine white cover", 40, "This white book is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass clasp keeps the covers closed until you are ready to read it.");
	}

	override public function useItem():Boolean {
        clearOutput();
        outputText("What you want to do with this White Book?");
        whiteSpellbook();
        return true;
    }
	public function whiteSpellbook():void {
		EngineCore.menu();
		EngineCore.addButton(0, "Back", whiteSpellbook0);
		EngineCore.addButton(1, "Use", whiteSpellbook1, 0).hint("Only Int gain with no spell learned.");
		if (player.inte >= 20 && !player.hasStatusEffect(StatusEffects.KnowsWhitefire)) EngineCore.addButton(2, "Whitef", whiteSpellbook1, 1).hint("Learn Whitefire spell.");
		else EngineCore.addButtonDisabled(2, "Whitef", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 25 && !player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) EngineCore.addButton(3, "L.Bolt", whiteSpellbook1, 2).hint("Learn Lightning Bolt spell.");
		else EngineCore.addButtonDisabled(3, "L.Bolt", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 30 && !player.hasStatusEffect(StatusEffects.KnowsCharge)) EngineCore.addButton(4, "C.Weap", whiteSpellbook1, 3).hint("Learn Charge Weapon spell.");
		else EngineCore.addButtonDisabled(4, "C.Weap", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 35 && !player.hasStatusEffect(StatusEffects.KnowsChargeR)) EngineCore.addButton(5, "C.R.We", whiteSpellbook1, 4).hint("Learn Charge Range Weapon spell.");
		else EngineCore.addButtonDisabled(5, "C.R.We", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 40 && !player.hasStatusEffect(StatusEffects.KnowsChargeA)) EngineCore.addButton(6, "C.Armo", whiteSpellbook1, 5).hint("Learn Charge Armor spell.");
		else EngineCore.addButtonDisabled(6, "C.Armo", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 45 && !player.hasStatusEffect(StatusEffects.KnowsHeal)) EngineCore.addButton(7, "Heal", whiteSpellbook1, 6).hint("Learn Heal spell.");
		else EngineCore.addButtonDisabled(7, "Heal", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsBlind)) EngineCore.addButton(8, "Blind", whiteSpellbook1, 7).hint("Learn Blind spell.");
		else EngineCore.addButtonDisabled(8, "Blind", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsPyreBurst)) EngineCore.addButton(9, "P.Burs", whiteSpellbook1, 8).hint("Learn Pyre Burst spell.");
		else EngineCore.addButtonDisabled(9, "P.Burs", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 60 && !player.hasStatusEffect(StatusEffects.KnowsChainLighting)) EngineCore.addButton(10, "C.Ligh", whiteSpellbook1, 9).hint("Learn Chain Lightning spell.");
		else EngineCore.addButtonDisabled(10, "C.Ligh", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 65 && !player.hasStatusEffect(StatusEffects.KnowsBlizzard)) EngineCore.addButton(11, "Blizza", whiteSpellbook1, 10).hint("Learn Blizzard spell.");
		else EngineCore.addButtonDisabled(11, "Blizza", "You don’t have enough intelligence or you already know this spell.");
		EngineCore.addButton(14, "-2-", whiteSpellbookPage2);
	}
	public function whiteSpellbookPage2():void {
		EngineCore.menu();
		EngineCore.addButton(0, "-1-", whiteSpellbook);
		if (player.inte >= 70 && !player.hasStatusEffect(StatusEffects.KnowsMentalShield)) EngineCore.addButton(1, "M.Shie", whiteSpellbook1, 11).hint("Learn Mental Shield spell.");
		else EngineCore.addButtonDisabled(1, "M.Shie", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 75 && !player.hasStatusEffect(StatusEffects.KnowsCure)) EngineCore.addButton(2, "Cure", whiteSpellbook1, 12).hint("Learn Cure spell.");
		else EngineCore.addButtonDisabled(2, "Cure", "You don’t have enough intelligence or you already know this spell.");
		if (player.inte >= 100 && !player.hasStatusEffect(StatusEffects.KnowsFireStorm)) EngineCore.addButton(3, "F.Stor", whiteSpellbook1, 13).hint("Learn Fire Storm spell.");
		else EngineCore.addButtonDisabled(3, "F.Stor", "You don’t have enough intelligence or you already know this spell.");
		if (player.hasPerk(PerkLib.DivineKnowledge) || player.hasPerk(PerkLib.PrestigeJobGreySage)) {
			if (player.inte >= 150 && !player.hasStatusEffect(StatusEffects.KnowsAegis)) EngineCore.addButton(4, "Aegis", whiteSpellbook1, 14).hint("Learn Aegis spell.");
			else EngineCore.addButtonDisabled(4, "Aegis", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 160 && !player.hasStatusEffect(StatusEffects.KnowsExorcise)) EngineCore.addButton(5, "Exorci", whiteSpellbook1, 15).hint("Learn Exorcise spell.");
			else EngineCore.addButtonDisabled(5, "Exorci", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 170 && !player.hasStatusEffect(StatusEffects.KnowsDivineShield)) EngineCore.addButton(6, "D.Shie", whiteSpellbook1, 16).hint("Learn Divine Shield spell.");
			else EngineCore.addButtonDisabled(6, "D.Shie", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 180 && !player.hasStatusEffect(StatusEffects.KnowsThunderstorm)) EngineCore.addButton(7, "Thunde", whiteSpellbook1, 17).hint("Learn Thunderstorm spell.");
			else EngineCore.addButtonDisabled(7, "Thunde", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 190 && !player.hasStatusEffect(StatusEffects.KnowsTearsOfDenial)) EngineCore.addButton(8, "T.Deni", whiteSpellbook1, 18).hint("Learn Tears of Denial spell.");
			else EngineCore.addButtonDisabled(8, "T.Deni", "You don’t have enough intelligence or you already know this spell.");
		}
		if (player.hasPerk(PerkLib.PrestigeJobGreySage)) {
			if (player.inte >= 100 && !player.hasStatusEffect(StatusEffects.KnowsPlantGrowth)) EngineCore.addButton(9, "P.Grow", whiteSpellbook1, 19).hint("Learn Plant growth spell.");
			else EngineCore.addButtonDisabled(9, "P.Grow", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 110 && !player.hasStatusEffect(StatusEffects.KnowsEntangle)) EngineCore.addButton(10, "Entang", whiteSpellbook1, 20).hint("Learn Entangle spell.");
			else EngineCore.addButtonDisabled(10, "Entang", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 120 && !player.hasStatusEffect(StatusEffects.KnowsBriarthorn)) EngineCore.addButton(11, "Briart", whiteSpellbook1, 21).hint("Learn Briarthorn spell.");
			else EngineCore.addButtonDisabled(11, "Briart", "You don’t have enough intelligence or you already know this spell.");
			if (player.inte >= 130 && !player.hasStatusEffect(StatusEffects.KnowsDeathBlossom)) EngineCore.addButton(12, "D.Blos", whiteSpellbook1, 22).hint("Learn Death Blossom spell.");
			else EngineCore.addButtonDisabled(12, "D.Blos", "You don’t have enough intelligence or you already know this spell.");
		}
	}
	public function whiteSpellbook0():void {
		outputText("You close the white tome. Now is not a good time to use it.");
		SceneLib.inventory.returnItemToInventory(this);
	}
    public function whiteSpellbook1(spell:Number):void {
        clearOutput();
        outputText("You open the white tome, and discover it to be an instructional book on the use of white magic.  Most of it is filled with generic information about white magic - how it is drawn for mental focus, is difficult to use when tired or aroused, and can be used to create and control energy.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
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
            outputText("[pg]The contents of the book did little for your already considerable intellect.");
            player.KnowledgeBonus("int", 0.6);
        } if (spell > 0) {
			switch (spell){
				case 1:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Whitefire.</b>");
					player.createStatusEffect(StatusEffects.KnowsWhitefire, 0, 0, 0, 0);
					break;
				case 2:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Lightning Bolt.</b>");
					player.createStatusEffect(StatusEffects.KnowsLightningBolt, 0, 0, 0, 0);
					break;
				case 3:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Weapon.</b>");
					player.createStatusEffect(StatusEffects.KnowsCharge, 0, 0, 0, 0);
					break;
				case 4:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Range Weapon.</b>");
					player.createStatusEffect(StatusEffects.KnowsChargeR, 0, 0, 0, 0);
					break;
				case 5:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Charge Armor.</b>");
					player.createStatusEffect(StatusEffects.KnowsChargeA, 0, 0, 0, 0);
					break;
				case 6:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Heal.</b>");
					player.createStatusEffect(StatusEffects.KnowsHeal, 0, 0, 0, 0);
					break;
				case 7:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Blind.</b>");
					player.createStatusEffect(StatusEffects.KnowsBlind, 0, 0, 0, 0);
					break;
				case 8:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Pyre Burst.</b>");
					player.createStatusEffect(StatusEffects.KnowsPyreBurst, 0, 0, 0, 0);
					break;
				case 9:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Chain Lighting.</b>");
					player.createStatusEffect(StatusEffects.KnowsChainLighting, 0, 0, 0, 0);
					break;
				case 10:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Blizzard.</b>");
					player.createStatusEffect(StatusEffects.KnowsBlizzard, 0, 0, 0, 0);
					break;
				case 11:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Mental Shield.</b>");
					player.createStatusEffect(StatusEffects.KnowsMentalShield, 0, 0, 0, 0);
					break;
				case 12:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Cure.</b>");
					player.createStatusEffect(StatusEffects.KnowsCure, 0, 0, 0, 0);
					break;
				case 13:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Fire Storm.</b>");
					player.createStatusEffect(StatusEffects.KnowsFireStorm, 0, 0, 0, 0);
					break;
				case 14:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Aegis.</b>");
					player.createStatusEffect(StatusEffects.KnowsAegis, 0, 0, 0, 0);
					break;
				case 15:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Exorcise.</b>");
					player.createStatusEffect(StatusEffects.KnowsExorcise, 0, 0, 0, 0);
					break;
				case 16:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Divine Shield.</b>");
					player.createStatusEffect(StatusEffects.KnowsDivineShield, 0, 0, 0, 0);
					break;
				case 17:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Thunderstorm.</b>");
					player.createStatusEffect(StatusEffects.KnowsThunderstorm, 0, 0, 0, 0);
					break;
				case 18:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Tears of Denial.</b>");
					player.createStatusEffect(StatusEffects.KnowsTearsOfDenial, 0, 0, 0, 0);
					break;
				case 19:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new green spell: Plant growth.</b>");
					player.createStatusEffect(StatusEffects.KnowsPlantGrowth, 0, 0, 0, 0);
					break;
				case 20:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new green spell: Entangle.</b>");
					player.createStatusEffect(StatusEffects.KnowsEntangle, 0, 0, 0, 0);
					break;
				case 21:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new green spell: Briarthorn.</b>");
					player.createStatusEffect(StatusEffects.KnowsBriarthorn, 0, 0, 0, 0);
					break;
				case 22:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new green spell: Death Blossom.</b>");
					player.createStatusEffect(StatusEffects.KnowsDeathBlossom, 0, 0, 0, 0);
					break;
			}
		}
        SceneLib.inventory.itemGoNext();
    }
}
}
