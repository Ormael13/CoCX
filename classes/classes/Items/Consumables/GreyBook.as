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

public class GreyBook extends Consumable {
	
	public function GreyBook() 
	{
		super("G. Book", "G. Book", "a small book with a ash-grey cover", 200, "This grey book is totally unmarked, and on the cover are a few words that seem to have no meaning, or perhaps you just aren't able to decipher them yet. A plain green clasp keeps the covers closed until you are ready to read it.");
	}

    override public function useItem():Boolean {
        clearOutput();
        outputText("What you want to do with this Grey Book?");
        greySpellbook();
        return true;
    }
	public function greySpellbook():void {
		EngineCore.menu();
		EngineCore.addButton(0, "Back", greySpellbook0);
		EngineCore.addButton(1, "Use", greySpellbook1, 0).hint("Only Int gain with no spell learned.");
		if (player.hasPerk(PerkLib.GreyMagic) || player.hasPerk(PerkLib.PrestigeJobGreySage)) {
			if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsManaShield)) EngineCore.addButton(2, "M.Shie", greySpellbook1, 1).hint("Learn Mana Shield spell.");
			else EngineCore.addButtonDisabled(2, "M.Shie", "You not have have enough int or already know this spell.");
			if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsWaterBall)) EngineCore.addButton(3, "W.Ball", greySpellbook1, 2).hint("Learn Water Ball spell.");
			else EngineCore.addButtonDisabled(3, "W.Ball", "You not have have enough int or already know this spell.");
			if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsWindBullet)) EngineCore.addButton(4, "W.Bull", greySpellbook1, 3).hint("Learn Wind Bullet spell.");
			else EngineCore.addButtonDisabled(4, "W.Bull", "You not have have enough int or already know this spell.");
			if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsStalagmite)) EngineCore.addButton(5, "Stalag", greySpellbook1, 4).hint("Learn Stalagmite spell.");
			else EngineCore.addButtonDisabled(5, "Stalag", "You not have have enough int or already know this spell.");
			if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsAcidSpray)) EngineCore.addButton(6, "A.Spra", greySpellbook1, 5).hint("Learn Acid Spray spell.");
			else EngineCore.addButtonDisabled(6, "A.Spra", "You not have have enough int or already know this spell.");
			if (player.inte >= 60 && !player.hasStatusEffect(StatusEffects.KnowsClearMind)) EngineCore.addButton(7, "C.Mind", greySpellbook1, 6).hint("Learn Clear Mind spell.");
			else EngineCore.addButtonDisabled(7, "C.Mind", "You not have have enough int or already know this spell.");
			if (player.inte >= 65 && !player.hasStatusEffect(StatusEffects.KnowsWaterSphere)) EngineCore.addButton(8, "W.Sphe", greySpellbook1, 7).hint("Learn Water Sphere spell.");
			else EngineCore.addButtonDisabled(8, "W.Sphe", "You not have have enough int or already know this spell.");
			if (player.inte >= 65 && !player.hasStatusEffect(StatusEffects.KnowsWindBlast)) EngineCore.addButton(9, "W.Blas", greySpellbook1, 8).hint("Learn Wind Blast spell.");
			else EngineCore.addButtonDisabled(9, "W.Blas", "You not have have enough int or already know this spell.");
			if (player.inte >= 65 && !player.hasStatusEffect(StatusEffects.KnowsShatterstone)) EngineCore.addButton(10, "Shatte", greySpellbook1, 9).hint("Learn Shatterstone spell.");
			else EngineCore.addButtonDisabled(10, "Shatte", "You not have have enough int or already know this spell.");
			if (player.inte >= 65 && !player.hasStatusEffect(StatusEffects.KnowsCorrosiveWave)) EngineCore.addButton(11, "C.Wave", greySpellbook1, 10).hint("Learn Corrosive Wave spell.");
			else EngineCore.addButtonDisabled(11, "C.Wave", "You not have have enough int or already know this spell.");
			EngineCore.addButton(14, "-2-", greySpellbookPage2);
		}
	}
	public function greySpellbookPage2():void {
		EngineCore.menu();
		EngineCore.addButton(0, "-1-", greySpellbook);
		if (player.inte >= 75 && !player.hasStatusEffect(StatusEffects.KnowsHydroAcid)) EngineCore.addButton(1, "H.Acid", greySpellbook1, 11).hint("Learn Hydro Acid spell.");
		else EngineCore.addButtonDisabled(1, "H.Acid", "You not have have enough int or already know this spell.");
		if (player.inte >= 80 && !player.hasStatusEffect(StatusEffects.KnowsEnergyDrain)) EngineCore.addButton(2, "E.Drai", greySpellbook1, 12).hint("Learn Energy Drain spell.");
		else EngineCore.addButtonDisabled(2, "E.Drai", "You not have have enough int or already know this spell.");
		if (player.inte >= 85 && !player.hasStatusEffect(StatusEffects.KnowsAcidRain)) EngineCore.addButton(3, "A.Rain", greySpellbook1, 13).hint("Learn Acid Rain spell.");
		else EngineCore.addButtonDisabled(3, "A.Rain", "You not have have enough int or already know this spell.");
		if (player.inte >= 90 && !player.hasStatusEffect(StatusEffects.KnowsRestore)) EngineCore.addButton(4, "Restor", greySpellbook1, 14).hint("Learn Restore spell.");
		else EngineCore.addButtonDisabled(4, "Restor", "You not have have enough int or already know this spell.");
		if (player.inte >= 100 && !player.hasStatusEffect(StatusEffects.KnowsBalanceOfLife)) EngineCore.addButton(5, "B.Life", greySpellbook1, 15).hint("Learn Balance of Life spell.");
		else EngineCore.addButtonDisabled(5, "B.Life", "You not have have enough int or already know this spell.");
	}
	public function greySpellbook0():void {
		outputText("You close the grey tome. Now is not a good time to use it.");
		SceneLib.inventory.returnItemToInventory(this);
	}
    public function greySpellbook1(spell:Number):void {
        clearOutput();
        outputText("You open the grey volume, and discover it to be an instructional book on the use of grey magic.  Most of it is filled with generic information about grey magic - how it is drawn from both mental focus and emotions (typically lust), is difficult to use when tired and too little or too much aroused, and is used to at the same time create or control energy and affect bodies or emotions to create final effect.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
        if (player.inte < 75) {
            outputText("[pg]You feel greatly enlightened by your time spent reading.");
            player.KnowledgeBonus("int", 4);
        } else if (player.inte < 100) {
            outputText("[pg]Spending some time reading was probably good for you, and you definitely feel smarter for it.");
            player.KnowledgeBonus("int", 2);
        } else if (player.inte < 125) {
            outputText("[pg]After reading the small tome your already quick mind feels invigorated.");
            player.KnowledgeBonus("int", 1);
        } else {
            outputText("[pg]The contents of the book did little for your already considerable intellect.");
            player.KnowledgeBonus("int", 0.5);
        } if (spell > 0) {
			switch (spell){
				case 1:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Mana Shield.</b>");
					player.createStatusEffect(StatusEffects.KnowsManaShield, 0, 0, 0, 0);
					break;
				case 2:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Water Ball.</b>");
					player.createStatusEffect(StatusEffects.KnowsWaterBall, 0, 0, 0, 0);
					break;
				case 3:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Wind Bullet.</b>");
					player.createStatusEffect(StatusEffects.KnowsWindBullet, 0, 0, 0, 0);
					break;
				case 4:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Stalagmite.</b>");
					player.createStatusEffect(StatusEffects.KnowsStalagmite, 0, 0, 0, 0);
					break;
				case 5:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Acid Spray.</b>");
					player.createStatusEffect(StatusEffects.KnowsAcidSpray, 0, 0, 0, 0);
					break;
				case 6:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Clear Mind.</b>");
					player.createStatusEffect(StatusEffects.KnowsClearMind, 0, 0, 0, 0);
					break;
				case 7:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Water Sphere.</b>");
					player.createStatusEffect(StatusEffects.KnowsWaterSphere, 0, 0, 0, 0);
					break;
				case 8:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Wind Blast.</b>");
					player.createStatusEffect(StatusEffects.KnowsWindBlast, 0, 0, 0, 0);
					break;
				case 9:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Shatterstone.</b>");
					player.createStatusEffect(StatusEffects.KnowsShatterstone, 0, 0, 0, 0);
					break;
				case 10:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Corrosive Wave.</b>");
					player.createStatusEffect(StatusEffects.KnowsCorrosiveWave, 0, 0, 0, 0);
					break;
				case 11:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Hydro Acid.</b>");
					player.createStatusEffect(StatusEffects.KnowsHydroAcid, 0, 0, 0, 0);
					break;
				case 12:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Energy Drain.</b>");
					player.createStatusEffect(StatusEffects.KnowsEnergyDrain, 0, 0, 0, 0);
					break;
				case 13:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Acid Rain.</b>");
					player.createStatusEffect(StatusEffects.KnowsAcidRain, 0, 0, 0, 0);
					break;
				case 14:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Restore.</b>");
					player.createStatusEffect(StatusEffects.KnowsRestore, 0, 0, 0, 0);
					break;
				case 15:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Balance of Life.</b>");
					player.createStatusEffect(StatusEffects.KnowsBalanceOfLife, 0, 0, 0, 0);
					break;
			}
		}
        SceneLib.inventory.itemGoNext();
    }
}
}
