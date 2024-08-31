package classes.Scenes.Dungeons.DemonLab {
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.Items.DynamicItems;
import classes.Items.WeaponLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.WeightedDrop;

/**
 * ...
 * @author Canadian Snas
 */
public class MutantIncubus extends Monster {

    public function MutantIncubus() {
        this.a = "the ";
        this.short = "Mutant Incubus";
        this.imageName = "demonmob";
        this.long = "You're fighting a mutant Incubus. The right side of his face is noticeably larger than the left, and his eye glows with a sickening purple light, not unlike the eyes of the Driders you’ve met in the swamp. He wears two blades, one at each hip, with an oddly pink, circular guard. He also has a tail, but instead of the usual spadelike tip, his tail ends in a vicious looking stinger, dripping with venom. ";
        this.plural = false;
        this.pronoun1 = "he";
        this.pronoun2 = "him";
        this.pronoun3 = "his";
        this.createCock(18, 2);
        this.createCock(18, 2, CockTypesEnum.DEMON);
        this.balls = 2;
        this.ballSize = 1;
        this.cumMultiplier = 3;
        // this.hoursSinceCum = 0;
        this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
        createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
        this.tallness = rand(8) + 70;
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "red";
        this.hairColor = "black";
        this.hairLength = 15;
        initStrTouSpeInte(290, 170, 220, 140);
        initWisLibSensCor(140, 350, 80, 100);
        this.weaponName = "claws";
        this.weaponVerb = "stab";
        this.weaponAttack = 40;
        this.armorName = "demonic skin";
        this.armorDef = 185;
        this.armorMDef = 160;
        this.bonusHP = 400;
        this.bonusLust = 485;
        this.lust = 20;
        this.level = 55;
        this.gems = rand(60) + 220;
        this.randomDropChance = 0.1;
        this.randomDropParams = {
            rarity: DynamicItems.RARITY_CHANCES_LESSER
        };
        this.drop = new WeightedDrop().addMany(1,
            consumables.SUCMILK,
            consumables.INCUBID,
            consumables.OVIELIX,
            consumables.B__BOOK);

        this.tailType = Tail.DEMONIC;
        this.horns.type = Horns.DEMON;
        this.horns.count = 2;
        this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
        this.createPerk(PerkLib.OverMaxHP, 55, 0, 0, 0);
        checkMonster();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.AfterFirstFight();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment(); //TODO
    }

    private function BladeFlurry():void {
        if (hasStatusEffect(StatusEffects.Blacken)) {
			outputText("From the darkness, you feel the air moving…too late to dodge. The Incubus seems to be everywhere, slashing at you from multiple angles at once! ");
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
				else player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
			}
			for (var i1:int = 0; i1 < 8; ++i1) {
				player.buff("Blackened Blade Furry").addStats({"str":-5}).withText("Blackened Blade Furry!").combatPermanent();
				eOneAttack(true);
			}
		}
		else {
			outputText("The mutant incubus grits his teeth, slashing at you with his thin swords. They flick in behind your guard, leaving thin, bleeding wounds. Your muscles feel weaker where the swords hit. ");
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.IzmaBleed)) player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
				else player.createStatusEffect(StatusEffects.IzmaBleed, 3, 0, 0, 0);
			}
			for (var i2:int = 0; i2 < 4; ++i2) {
				player.buff("Blade Furry").addStats({"str":-2}).withText("Blade Furry!").combatPermanent();
				eOneAttack(true);
			}
		}
        outputText("\n");
    }

    private function StingerTail():void {
        outputText("The mutant incubus lunges forward, stabbing at you. You dodge that, then a sweeping slash from his other blade…only to realise, too late, that they were feints! The Incubus drives his tail into your stomach, dumping a load of venom into your system! ");
		player.createStatusEffect(StatusEffects.MutantIncubusVenom, 5, 0, 0, 0);
		player.buff("Mutant Incubus Venom").addStats({"int":-5}).withText("Poisoned!").combatTemporary(5);
    }

    private function Blacken():void {
        outputText("The incubus groans, and the room shudders around you. From the incubus’s body spews a gaseous substance. It quickly fills the room, concealing the demon from view. All you can see of your foe is a single glowing purple eye…Wait. Your vision blurs for a moment, and the glowing eye seems to multiply, spreading through the room. Hitting the Mutant Incubus will be MUCH harder now! ");
		player.buff("Black Gas").addStats({"spe":-5}).withText("Black Gas!").combatPermanent();
		player.createStatusEffect(StatusEffects.Blind, 3, 0, 0, 0);
		createStatusEffect(StatusEffects.Blacken, 3, 0, 0, 0);
	}

    override protected function performCombatAction():void {
        if (hasStatusEffect(StatusEffects.Blacken)) BladeFlurry();
		else {
			var choice:Number = rand(5);
			switch (choice) {
				case 0:
				case 1:
					BladeFlurry();
					break;
				case 2:
				case 3:
					StingerTail();
					break;
				case 4:
					Blacken();
					break;
			}
		}
    }
}

}