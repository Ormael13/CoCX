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

public class BlackBook extends Consumable {
	
	public function BlackBook() 
	{
		super("B. Book", "B. Book", "a small book with a midnight-black cover", 40, "This solid black book is totally unmarked, saved for a blood red clasp that holds the covers closed until you are ready to read it.  The pages are edged with gold, like some of the fancy books in the monastary back home.");
	}

    override public function useItem():Boolean {
        clearOutput();
        outputText("What do you want to do with this Black Book?");
        blackSpellbook();
        return true;
    }
	public function blackSpellbook():void {
		EngineCore.menu();
		EngineCore.addButton(0, "Back", blackSpellbook0);
		EngineCore.addButton(1, "Use", blackSpellbook1, 0).hint("Only Int gain with no spell learned.");
		if (player.inte >= 20 && !player.hasStatusEffect(StatusEffects.KnowsIceSpike)) EngineCore.addButton(2, "I.Spik", blackSpellbook1, 1).hint("Learn Ice Spike spell.");
		else EngineCore.addButtonDisabled(2, "I.Spik", "You not have have enough int or already know this spell.");
		if (player.inte >= 25 && !player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) EngineCore.addButton(3, "D.Shar", blackSpellbook1, 2).hint("Learn Darkness Shard spell.");
		else EngineCore.addButtonDisabled(3, "D.Shar", "You not have have enough int or already know this spell.");
		if (player.inte >= 30 && !player.hasStatusEffect(StatusEffects.KnowsArouse)) EngineCore.addButton(4, "Arouse", blackSpellbook1, 3).hint("Learn Arouse spell.");
		else EngineCore.addButtonDisabled(4, "Arouse", "You not have have enough int or already know this spell.");
		if (player.inte >= 35 && !player.hasStatusEffect(StatusEffects.KnowsRegenerate)) EngineCore.addButton(5, "Regene", blackSpellbook1, 4).hint("Learn Regenerate spell.");
		else EngineCore.addButtonDisabled(5, "Regene", "You not have have enough int or already know this spell.");
		if (player.inte >= 40 && !player.hasStatusEffect(StatusEffects.KnowsMight)) EngineCore.addButton(6, "Might", blackSpellbook1, 5).hint("Learn Might spell.");
		else EngineCore.addButtonDisabled(6, "Might", "You not have have enough int or already know this spell.");
		if (player.inte >= 45 && !player.hasStatusEffect(StatusEffects.KnowsBlink)) EngineCore.addButton(7, "Blink", blackSpellbook1, 6).hint("Learn Blink spell.");
		else EngineCore.addButtonDisabled(7, "Blink", "You not have have enough int or already know this spell.");
		if (player.inte >= 50 && !player.hasStatusEffect(StatusEffects.KnowsArcticGale)) EngineCore.addButton(8, "A.Gale", blackSpellbook1, 7).hint("Learn Arctic Gale spell.");
		else EngineCore.addButtonDisabled(8, "A.Gale", "You not have have enough int or already know this spell.");
		if (player.inte >= 55 && !player.hasStatusEffect(StatusEffects.KnowsDuskWave)) EngineCore.addButton(9, "D.Wave", blackSpellbook1, 8).hint("Learn Dusk Wave spell.");
		else EngineCore.addButtonDisabled(9, "D.Wave", "You not have have enough int or already know this spell.");
		if (player.inte >= 60 && !player.hasStatusEffect(StatusEffects.KnowsWaveOfEcstasy)) EngineCore.addButton(10, "W.Ecst", blackSpellbook1, 9).hint("Learn Wave of Ecstasy spell.");
		else EngineCore.addButtonDisabled(10, "W.Ecst", "You not have have enough int or already know this spell.");
		if (player.inte >= 100 && !player.hasStatusEffect(StatusEffects.KnowsIceRain)) EngineCore.addButton(11, "I.Rain", blackSpellbook1, 10).hint("Learn Ice Rain spell.");
		else EngineCore.addButtonDisabled(11, "I.Rain", "You not have have enough int or already know this spell.");
		if (player.inte >= 110 && !player.hasStatusEffect(StatusEffects.KnowsNosferatu)) EngineCore.addButton(12, "Nosfer", blackSpellbook1, 11).hint("Learn Nosferatu spell.");
		else EngineCore.addButtonDisabled(12, "Nosfer", "You not have have enough int or already know this spell.");
		EngineCore.addButton(14, "-2-", blackSpellbook2);
	}
	public function blackSpellbook2():void {
		EngineCore.menu();
		EngineCore.addButton(0, "-1-", blackSpellbook);
		if (player.hasPerk(PerkLib.PrestigeJobNecromancer) || player.hasPerk(PerkLib.PrestigeJobGreySage)) {
			if (player.inte >= 100 && !player.hasStatusEffect(StatusEffects.KnowsBoneSpirit)) EngineCore.addButton(1, "B.Spir", blackSpellbook1, 12).hint("Learn Bone spirit spell.");
			else EngineCore.addButtonDisabled(1, "B.Spir", "You not have have enough int or already know this spell.");
			if (player.inte >= 105 && !player.hasStatusEffect(StatusEffects.KnowsBoneArmor)) EngineCore.addButton(2, "B.Armo", blackSpellbook1, 13).hint("Learn Bone armor spell.");
			else EngineCore.addButtonDisabled(2, "B.Armo", "You not have have enough int or already know this spell.");
			if (player.inte >= 110 && !player.hasStatusEffect(StatusEffects.KnowsCorpseExplosion)) EngineCore.addButton(3, "C.Expl", blackSpellbook1, 14).hint("Learn Corpse Explosion spell.");
			else EngineCore.addButtonDisabled(3, "C.Expl", "You not have have enough int or already know this spell.");
			if (player.inte >= 115 && !player.hasStatusEffect(StatusEffects.KnowsBloodShower)) EngineCore.addButton(4, "B.Show", blackSpellbook1, 15).hint("Learn Blood Shower spell.");
			else EngineCore.addButtonDisabled(4, "B.Show", "You not have have enough int or already know this spell.");
			if (player.inte >= 120 && !player.hasStatusEffect(StatusEffects.KnowsBoneshatter)) EngineCore.addButton(5, "Bonesh", blackSpellbook1, 16).hint("Learn Boneshatter spell.");
			else EngineCore.addButtonDisabled(5, "Bonesh", "You not have have enough int or already know this spell.");
			if (player.inte >= 125 && !player.hasStatusEffect(StatusEffects.KnowsNecroticRot)) EngineCore.addButton(6, "N.Rot", blackSpellbook1, 17).hint("Learn Necrotic Rot spell.");
			else EngineCore.addButtonDisabled(6, "N.Rot", "You not have have enough int or already know this spell.");
		}
		if (player.hasPerk(PerkLib.HexKnowledge) || player.hasPerk(PerkLib.PrestigeJobGreySage)) {
			if (player.inte >= 150 && !player.hasStatusEffect(StatusEffects.KnowsLifetap)) EngineCore.addButton(7, "Lifeta", blackSpellbook1, 18).hint("Learn Lifetap spell.");
			else EngineCore.addButtonDisabled(7, "Lifeta", "You not have have enough int or already know this spell.");
			if (player.inte >= 160 && !player.hasStatusEffect(StatusEffects.KnowsLifeSiphon)) EngineCore.addButton(8, "L.Siph", blackSpellbook1, 19).hint("Learn Life siphon spell.");
			else EngineCore.addButtonDisabled(8, "L.Siph", "You not have have enough int or already know this spell.");
			if (player.inte >= 170 && !player.hasStatusEffect(StatusEffects.KnowsConsumingDarkness)) EngineCore.addButton(9, "C.Dark", blackSpellbook1, 20).hint("Learn Consuming darkness spell.");
			else EngineCore.addButtonDisabled(9, "C.Dark", "You not have have enough int or already know this spell.");
			if (player.inte >= 180 && !player.hasStatusEffect(StatusEffects.KnowsCurseOfDesire)) EngineCore.addButton(10, "C.Desi", blackSpellbook1, 21).hint("Learn Curse of Desire spell.");
			else EngineCore.addButtonDisabled(10, "C.Desi", "You not have have enough int or already know this spell.");
			if (player.inte >= 190 && !player.hasStatusEffect(StatusEffects.KnowsCurseOfWeeping)) EngineCore.addButton(11, "C.Weep", blackSpellbook1, 22).hint("Learn Curse of Weeping spell.");
			else EngineCore.addButtonDisabled(11, "C.Weep", "You not have have enough int or already know this spell.");
		}
	}
	public function blackSpellbook0():void {
		outputText("You close the black tome. Now is not good time to use it.");
		SceneLib.inventory.returnItemToInventory(this);
	}
    public function blackSpellbook1(spell:Number):void {
        clearOutput();
        outputText("You open the small black book, and discover it to be an instructional book on the use of black magic.  Most of it is filled with generic information about black magic - how it is drawn from emotions (typically lust), and how it has the power to affect bodies and emotions.  It also warns against using it on oneself, as it is difficult to draw on your emotions while meddling with your own body.  In no time at all you've read the whole thing, but it disappears into thin air before you can put it away.");
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
            player.KnowledgeBonus("int", 0.5);
        } if (spell > 0) {
			switch (spell){
				case 1:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Ice Spike.</b>");
					player.createStatusEffect(StatusEffects.KnowsIceSpike, 0, 0, 0, 0);
					break;
				case 2:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Darkness Shard.</b>");
					player.createStatusEffect(StatusEffects.KnowsDarknessShard, 0, 0, 0, 0);
					break;
				case 3:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Arouse.</b>");
					player.createStatusEffect(StatusEffects.KnowsArouse, 0, 0, 0, 0);
					break;
				case 4:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Regenerate.</b>");
					player.createStatusEffect(StatusEffects.KnowsRegenerate, 0, 0, 0, 0);
					break;
				case 5:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Might.</b>");
					player.createStatusEffect(StatusEffects.KnowsMight, 0, 0, 0, 0);
					break;
				case 6:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Blink.</b>");
					player.createStatusEffect(StatusEffects.KnowsBlink, 0, 0, 0, 0);
					break;
				case 7:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Arctic Gale.</b>");
					player.createStatusEffect(StatusEffects.KnowsArcticGale, 0, 0, 0, 0);
					break;
				case 8:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Dusk Wave.</b>");
					player.createStatusEffect(StatusEffects.KnowsDuskWave, 0, 0, 0, 0);
					break;
				case 9:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Wave of Ecstasy.</b>");
					player.createStatusEffect(StatusEffects.KnowsWaveOfEcstasy, 0, 0, 0, 0);
					break;
				case 10:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Ice Rain.</b>");
					player.createStatusEffect(StatusEffects.KnowsIceRain, 0, 0, 0, 0);
					break;
				case 11:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new spell: Nosferatu.</b>");
					player.createStatusEffect(StatusEffects.KnowsNosferatu, 0, 0, 0, 0);
					break;
				case 12:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new necromancer spell: Bone spirit.</b>");
					player.createStatusEffect(StatusEffects.KnowsBoneSpirit, 0, 0, 0, 0);
					break;
				case 13:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new necromancer spell: Bone armor.</b>");
					player.createStatusEffect(StatusEffects.KnowsBoneArmor, 0, 0, 0, 0);
					break;
				case 14:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new necromancer spell: Corpse Explosion.</b>");
					player.createStatusEffect(StatusEffects.KnowsCorpseExplosion, 0, 0, 0, 0);
					break;
				case 15:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new necromancer spell: Blood Shower.</b>");
					player.createStatusEffect(StatusEffects.KnowsBloodShower, 0, 0, 0, 0);
					break;
				case 16:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new necromancer spell: Boneshatter.</b>");
					player.createStatusEffect(StatusEffects.KnowsBoneshatter, 0, 0, 0, 0);
					break;
				case 17:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new necromancer spell: Necrotic Rot.</b>");
					player.createStatusEffect(StatusEffects.KnowsNecroticRot, 0, 0, 0, 0);
					break;
				case 18:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new warlock spell: Lifetap.</b>");
					player.createStatusEffect(StatusEffects.KnowsLifetap, 0, 0, 0, 0);
					break;
				case 19:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new warlock spell: Life siphon.</b>");
					player.createStatusEffect(StatusEffects.KnowsLifeSiphon, 0, 0, 0, 0);
					break;
				case 20:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new warlock spell: Consuming darkness.</b>");
					player.createStatusEffect(StatusEffects.KnowsConsumingDarkness, 0, 0, 0, 0);
					break;
				case 21:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new warlock spell: Curse of Desire.</b>");
					player.createStatusEffect(StatusEffects.KnowsCurseOfDesire, 0, 0, 0, 0);
					break;
				case 22:
					outputText("[pg]You blink in surprise, assaulted by the knowledge of a <b>new warlock spell: Curse of Weeping.</b>");
					player.createStatusEffect(StatusEffects.KnowsCurseOfWeeping, 0, 0, 0, 0);
					break;
			}
		}
        SceneLib.inventory.itemGoNext();
    }
}
}
