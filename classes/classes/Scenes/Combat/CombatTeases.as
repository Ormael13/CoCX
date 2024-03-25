package classes.Scenes.Combat {
import classes.*;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.GlobalFlags.*;
import classes.Items.*;
import classes.Items.Dynamic.Effects.SimpleRaceEnchantment;
import classes.Scenes.Dungeons.D3.*;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.Scenes.Combat.TeaseOptions;

public class CombatTeases extends BaseCombatContent {
	public function CombatTeases() {}
	
	public function teaseBaseLustDamage(tBLD:Number = 0):Number {
		tBLD += player.lib;
		tBLD += scalingBonusLibido() * 0.2;
		tBLD += (2 * player.teaseDmgStat.value);


		if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) tBLD *= 1.75;
		if (player.hasPerk(PerkLib.SensualLover)) tBLD *= 1.3;
		if (player.hasPerk(PerkLib.Seduction)) tBLD *= 1.75;
		
		//partial skins bonuses
		switch (player.coatType()) {
			case Skin.FUR:
				tBLD *= 1 + (0.01 * (1 + player.newGamePlusMod()));
				break;
			case Skin.SCALES:
				tBLD *= 1 + (0.02 * (1 + player.newGamePlusMod()));
				break;
			case Skin.CHITIN:
				tBLD *= 1 + (0.03 * (1 + player.newGamePlusMod()));
				break;
			case Skin.BARK:
				tBLD *= 1 + (0.04 * (1 + player.newGamePlusMod()));
				break;
		}
		if (player.hasPerk(PerkLib.FlawlessBody)) tBLD *= 2;
		if (player.hasPerk(PerkLib.GracefulBeauty)) tBLD += scalingBonusSpeed() * 0.1;
		if (player.isElf() && player.hasPerk(PerkLib.ELFElvenSpearDancingTechnique) && player.isSpearTypeWeapon()) tBLD += scalingBonusSpeed() * 0.1;
		tBLD *= masteryBonusDamageTease();
		if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) tBLD *= 1.2;

		var damagemultiplier:Number = 1;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damagemultiplier += player.lust100 * 0.01;
		if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) damagemultiplier += combat.historyWhoreBonus();
		if (player.hasPerk(PerkLib.DazzlingDisplay)) damagemultiplier += 0.2;
		if (player.hasPerk(PerkLib.SuperSensual)) damagemultiplier += 0.50;
		if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemConstants.A_REVEALING)) tBLD *= (1 + ((10 + rand(11)) / 100));
		if (player.armorName == "desert naga pink and black silk dress") damagemultiplier += 0.1;
		if (player.headjewelryName == "pair of Golden Naga Hairpins") damagemultiplier += 0.1;
		if (player.armor == armors.ELFDRES && player.isElf()) damagemultiplier += 1;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) damagemultiplier += 1;
		if (player.hasStatusEffect(StatusEffects.TeasePotion)) damagemultiplier += 0.05;
		if (player.weapon == weapons.HELLCAL) damagemultiplier *= (1 + (0.01 * player.cor));
		if (player.weapon == weapons.ELYSIUM) damagemultiplier *= (1 + (0.01 * (100 - player.cor)));
		tBLD *= damagemultiplier;

		if (player.hasPerk(PerkLib.ChiReflowLust)) tBLD *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
		if (player.hasPerk(PerkLib.ArouseTheAudience) && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) tBLD *= 1.5;
		if (player.perkv1(PerkLib.ImpNobility) > 0) {
			tBLD *= (100 + player.perkv1(PerkLib.ImpNobility))/100;
		}
		for each (var f:ItemEffect in player.allItemEffects(IELib.Tease_RaceX2)) {
			tBLD *= 1 + f.power * (player.isRaceCached(f.value1 as Race)? 2:1) / 100;
		}
		if (SceneLib.urtaQuest.isUrta()) tBLD *= 2;
		return tBLD;
	}

	public function fueledByDesireDamageBonus(damage:Number): Number {
		if (player.hasPerk(PerkLib.FueledByDesire) && player.lust100 >= 50 && flags[kFLAGS.COMBAT_TEASE_HEALING] == 0) {
			damage *= 1.2;
		}
		return damage;
	}

	public function fueledByDesireHeal(display:Boolean = true):Boolean {
		if (player.hasPerk(PerkLib.FueledByDesire) && player.lust100 >= 50 && flags[kFLAGS.COMBAT_TEASE_HEALING] == 0) {
			if (display) outputText("\nYou use your own lust against the enemy, cooling off a bit in the process.");
			player.takeLustDamage(-Math.round(player.maxLust() * 0.1), display, false);
			if (display) outputText("\n");
			return true;
		}
		return false;
	}

	public function masteryBonusDamageTease():Number {
		var lustMult:Number = 1;
		var multiplier:Number = 0.02;
		if (player.hasPerk(PerkLib.JobSeducer)) multiplier += 0.01;

		lustMult += (multiplier * player.teaseLevel);

		return lustMult;
	}

	public function combatTeaseCritical():Number {
		var critTChance:Number = 0;
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critTChance += 5;
		if (player.armor == armors.R_CHANG || player.armor == armors.R_QIPAO || player.armor == armors.G_CHANG || player.armor == armors.G_QIPAO
			 || player.armor == armors.B_CHANG || player.armor == armors.B_QIPAO || player.armor == armors.P_CHANG || player.armor == armors.P_QIPAO) critTChance += 5;

		if (player.headJewelry == headjewelries.SCANGOG) critTChance += 5;
        if (player.headJewelry == headjewelries.SATGOG) critTChance += 10;

		if (player.hasPerk(PerkLib.CriticalPerformance)) {
				if (player.lib <= 100) critTChance += player.lib / 4;
				if (player.lib > 100) critTChance += 25;
			}

		if (player.eyesOfTheHunterAdeptBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterAdept) && player.sens >= 50) critTChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critTChance += 95;
				else critTChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterExpertBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterExpert) && player.sens >= 75) critTChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critTChance += 95;
				else critTChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterMaster) && player.sens >= 100) critTChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critTChance += 95;
				else critTChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}
		if (player.eyesOfTheHunterGrandMasterBoost()) {
			if (player.hasPerk(PerkLib.EyesOfTheHunterGrandMaster) && player.sens >= 125) critTChance += 5;
			if (player.hasPerk(PerkLib.EyesOfTheHunterSu) && player.sens >= 30) {
				if (player.sens >= 500) critTChance += 95;
				else critTChance += 2 * Math.round((player.sens - 25) / 5);
			}
		}

		return critTChance;
	}

	public function teaseAuraLustDamageBonus(monster:Monster, lustDmg:Number):Number {
		if (player.hasPerk(PerkLib.SensualLover)) lustDmg *= 1.1;
		if (player.hasPerk(PerkLib.Seduction)) lustDmg *= 1.25;
        lustDmg += player.teaseDmgStat.value;
		if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) lustDmg *= 1.25;
		if (player.hasPerk(PerkLib.FlawlessBody)) lustDmg *= 1.5;
		lustDmg *= masteryBonusDamageTease();
		if (player.hasPerk(PerkLib.EromancyExpert)) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.ArcaneLash) && player.isWhipTypeWeapon()) lustDmg *= 1.5;
		if (player.hasPerk(PerkLib.JobCourtesan) && monster && monster.hasPerk(PerkLib.EnemyBossType)) lustDmg *= 1.2;
		if (player.hasPerk(PerkLib.SluttySimplicity) && player.armor.hasTag(ItemConstants.A_REVEALING)) lustDmg *= (1 + ((10 + rand(11)) / 100));
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) lustDmg *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.HistoryWhore) || player.hasPerk(PerkLib.PastLifeWhore)) lustDmg *= (1 + combat.historyWhoreBonus());
		if (player.hasPerk(PerkLib.ArouseTheAudience) && monster && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType))) lustDmg *= 1.2;
        if (player.hasPerk(PerkLib.ChiReflowLust)) lustDmg *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;

		return lustDmg;
	}

	/**
	 * For use in touchThatFluffyHorn function to only generate the text of a tease while not applying any effects
	 */
	public function generateTeaseText():void {
		var teaseChoiceArray:Array = genTeaseChoiceArray();

		var selectedTease:int = teaseChoiceArray[rand(teaseChoiceArray.length)];
		//Override selected tease conditions
		if (monster.short.indexOf("minotaur") != -1) {
			//Cowgirl Tease
			if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.racialScore(Races.COW) >= 3 && player.tailType == Tail.COW)
				selectedTease = 43;
		}
		//Alraune and Liliraune Tease
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			selectedTease = 46;
		}

		applySelectedTease(selectedTease, true);
	}


	//==============================
		//TEASE SELECT CHOICES
		//==BASICS========
		//0 butt shake
		//1 breast jiggle
		//2 pussy flash
		//3 cock flash
		//==BIMBO STUFF===
		//4 butt shake
		//5 breast jiggle
		//6 pussy flash
		//7 special Adjatha-crafted bend over bimbo times
		//==BRO STUFF=====
		//8 Pec Dance
		//9 Heroic Pose
		//10 Bulgy groin thrust
		//11 Show off dick
		//==EXTRAS========
		//12 Cat flexibility.
		//13 Pregnant
		//14 Brood Mother
		//15 Nipplecunts
		//16 Anal gape
		//17 Bee abdomen tease
		//18 DOG TEASE
		//19 Maximum Femininity:
		//20 Maximum MAN:
		//21 Perfect Androgyny:
		//22 SPOIDAH SILK
		//23 RUT
		//24 Poledance - req's staff! - Req's gender!  Req's TITS!
		//25 Tall Tease! - Reqs 2+ feet & PC Cunt!
		//26 SMART PEEPS! 70+ int, arouse spell!
		//27 - FEEDER
		//28 FEMALE TEACHER COSTUME TEASE
		//29 Male Teacher Outfit Tease
		//30 Naga Fetish Clothes
		//31 Centaur harness clothes
		//32 Genderless servant clothes
		//33 Crotch Revealing Clothes (herm only?)
		//34 Maid Costume (female only):
		//35 Servant Boy Clothes (male only)
		//36 Bondage Patient Clothes
		//37 Kitsune Tease
		//38 Kitsune Tease
		//39 Kitsune Tease
		//40 Kitsune Tease
		//41 Kitsune Gendered Tease
		//42 Urta teases
		//43 Cowgirl teases
		//44 Bikini Mail Tease
		//45 Lethicite Armor Tease
		//46 Alraune and Liliraune Tease
		//47 Manticore Tailpussy Tease
		//48 Belly Dance (Naga races)
		//==============================
		//BUILD UP LIST OF TEASE CHOICES!
		//==============================
	public function genTeaseChoiceArray():Array {
		var choices:Array   = [];
		var futa:Boolean = player.hasPerk(PerkLib.FutaForm);
		var bimbo:Boolean = player.hasPerk(PerkLib.BimboBody);
		var bro:Boolean = player.hasPerk(PerkLib.BroBody);

		//Futas!
		if ((futa || bimbo) && player.gender == 3) {
			//Once chance of butt.
			choices[choices.length] = 4;
			//Big butts get more butt
			if (player.butt.type >= 7) choices[choices.length] = 4;
			if (player.butt.type >= 10) choices[choices.length] = 4;
			if (player.butt.type >= 14) choices[choices.length] = 4;
			if (player.butt.type >= 20) choices[choices.length] = 4;
			if (player.butt.type >= 25) choices[choices.length] = 4;
			//Breast jiggle!
			if (player.biggestTitSize() >= 2) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 4) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 8) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 15) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 30) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 50) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 75) choices[choices.length] = 5;
			if (player.biggestTitSize() >= 100) choices[choices.length] = 5;
			//Pussy Flash!
			if (player.hasVagina()) {
				choices[choices.length] = 2;
				if (player.wetness() >= 3) choices[choices.length] = 6;
				if (player.wetness() >= 5) choices[choices.length] = 6;
				if (player.vaginalCapacity() >= 30) choices[choices.length] = 6;
				if (player.vaginalCapacity() >= 60) choices[choices.length] = 6;
				if (player.vaginalCapacity() >= 75) choices[choices.length] = 6;
			}
			//Adj special!
			if (player.hasVagina() && player.butt.type >= 8 && player.hips.type >= 6 && player.biggestTitSize() >= 4) {
				choices[choices.length] = 7;
				choices[choices.length] = 7;
				choices[choices.length] = 7;
				choices[choices.length] = 7;
			}
			//Cock flash!
			if (futa && player.hasCock()) {
				choices[choices.length] = 10;
				choices[choices.length] = 11;
				if (player.cockTotal() > 1) choices[choices.length] = 10;
				if (player.cockTotal() >= 2) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 10) choices[choices.length] = 10;
				if (player.biggestCockArea() >= 25) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 50) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 75) choices[choices.length] = 10;
				if (player.biggestCockArea() >= 100) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 300) choices[choices.length] = 10;
			}
		}
		else if (bro) {
			//8 Pec Dance
			if (player.biggestTitSize() < 1 && player.tone >= 60) {
				choices[choices.length] = 8;
				if (player.tone >= 70) choices[choices.length] = 8;
				if (player.tone >= 80) choices[choices.length] = 8;
				if (player.tone >= 90) choices[choices.length] = 8;
				if (player.tone >= 100) choices[choices.length] = 8;
			}
			//9 Heroic Pose
			if (player.tone >= 60 && player.str >= 50) {
				choices[choices.length] = 9;
				if (player.tone >= 80) choices[choices.length] = 9;
				if (player.str >= 70) choices[choices.length] = 9;
				if (player.tone >= 90) choices[choices.length] = 9;
				if (player.str >= 80) choices[choices.length] = 9;
			}
			//Cock flash!
			if (player.hasCock()) {
				choices[choices.length] = 10;
				choices[choices.length] = 11;
				if (player.cockTotal() > 1) choices[choices.length] = 10;
				if (player.cockTotal() >= 2) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 10) choices[choices.length] = 10;
				if (player.biggestCockArea() >= 25) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 50) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 75) choices[choices.length] = 10;
				if (player.biggestCockArea() >= 100) choices[choices.length] = 11;
				if (player.biggestCockArea() >= 300) choices[choices.length] = 10;
			}
		}
		//VANILLA FOLKS
		else {
			//Once chance of butt.
			choices[choices.length] = 0;
			//Big butts get more butt
			if (player.butt.type >= 7) choices[choices.length] = 0;
			if (player.butt.type >= 10) choices[choices.length] = 0;
			if (player.butt.type >= 14) choices[choices.length] = 0;
			if (player.butt.type >= 20) choices[choices.length] = 0;
			if (player.butt.type >= 25) choices[choices.length] = 0;
			//Breast jiggle!
			if (player.biggestTitSize() >= 2) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 4) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 8) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 15) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 30) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 50) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 75) choices[choices.length] = 1;
			if (player.biggestTitSize() >= 100) choices[choices.length] = 1;
			//Pussy Flash!
			if (player.hasVagina()) {
				choices[choices.length] = 2;
				if (player.wetness() >= 3) choices[choices.length] = 2;
				if (player.wetness() >= 5) choices[choices.length] = 2;
				if (player.vaginalCapacity() >= 30) choices[choices.length] = 2;
				if (player.vaginalCapacity() >= 60) choices[choices.length] = 2;
				if (player.vaginalCapacity() >= 75) choices[choices.length] = 2;
			}
			//Cock flash!
			if (player.hasCock()) {
				choices[choices.length] = 3;
				if (player.cockTotal() > 1) choices[choices.length] = 3;
				if (player.cockTotal() >= 2) choices[choices.length] = 3;
				if (player.biggestCockArea() >= 10) choices[choices.length] = 3;
				if (player.biggestCockArea() >= 25) choices[choices.length] = 3;
				if (player.biggestCockArea() >= 50) choices[choices.length] = 3;
				if (player.biggestCockArea() >= 75) choices[choices.length] = 3;
				if (player.biggestCockArea() >= 100) choices[choices.length] = 3;
				if (player.biggestCockArea() >= 300) choices[choices.length] = 3;
			}
		}
		//==EXTRAS========
		//12 Cat flexibility.
		if (player.hasPerk(PerkLib.Flexibility) && player.isBiped() && player.hasVagina()) {
			choices[choices.length] = 12;
			choices[choices.length] = 12;
			if (player.wetness() >= 3) choices[choices.length] = 12;
			if (player.wetness() >= 5) choices[choices.length] = 12;
			if (player.vaginalCapacity() >= 30) choices[choices.length] = 12;
		}
		//13 Pregnant
		if (player.hasVisiblePregnancy()) {
			choices[choices.length] = 13;
			if (player.biggestLactation() >= 1) choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 180) || (player.pregnancy2Incubation <= 180)) choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 120) || (player.pregnancy2Incubation <= 120)) choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 100) || (player.pregnancy2Incubation <= 100)) choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 50)  || (player.pregnancy2Incubation <= 50))  choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 24)  || (player.pregnancy2Incubation <= 24))  choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 24)  || (player.pregnancy2Incubation <= 24))  choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 24)  || (player.pregnancy2Incubation <= 24))  choices[choices.length] = 13;
			if ((player.pregnancyIncubation <= 24)  || (player.pregnancy2Incubation <= 24))  choices[choices.length] = 13;
		}
		//14 Brood Mother
		if (monster.hasCock() && player.hasVagina() && player.hasPerk(PerkLib.BroodMother) && (!player.isPregnant() || player.hasNonVisiblePregnancy())) {
			choices[choices.length] = 14;
			choices[choices.length] = 14;
			choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
			if (player.inHeat) choices[choices.length] = 14;
		}
		//15 Nipplecunts
		if (player.hasFuckableNipples()) {
			choices[choices.length] = 15;
			choices[choices.length] = 15;
			if (player.hasVagina()) choices[choices.length] = 15;
			if (player.hasVagina()) choices[choices.length] = 15;
			if (player.hasVagina()) choices[choices.length] = 15;
			if (player.wetness() >= 3) choices[choices.length] = 15;
			if (player.wetness() >= 5) choices[choices.length] = 15;
			if (player.biggestTitSize() >= 3) choices[choices.length] = 15;
			if (player.nippleLength >= 3) choices[choices.length] = 15;
		}
		//16 Anal gape
		if (player.ass.analLooseness >= 4) {
			choices[choices.length] = 16;
			if (player.ass.analLooseness >= 5) choices[choices.length] = 16;
		}
		//17 Bee abdomen tease
		if (player.tailType == Tail.BEE_ABDOMEN) {
			choices[choices.length] = 17;
			choices[choices.length] = 17;
		}
		//18 DOG TEASE
		if (player.isAnyRaceCached(Races.DOG, Races.CERBERUS) && player.hasVagina() && player.isBiped()) {
			choices[choices.length] = 18;
			choices[choices.length] = 18;
		}
		//19 Maximum Femininity:
		if (player.femininity >= 100) {
			choices[choices.length] = 19;
			choices[choices.length] = 19;
			choices[choices.length] = 19;
		}
		//20 Maximum MAN:
		if (player.femininity <= 0) {
			choices[choices.length] = 20;
			choices[choices.length] = 20;
			choices[choices.length] = 20;
		}
		//21 Perfect Androgyny:
		if (player.femininity == 50) {
			choices[choices.length] = 21;
			choices[choices.length] = 21;
			choices[choices.length] = 21;
		}
		//22 SPOIDAH SILK
		if (player.tailType == Tail.SPIDER_ADBOMEN) {
			choices[choices.length] = 22;
			choices[choices.length] = 22;
			choices[choices.length] = 22;
			if (player.isRace(Races.SPIDER)) {
				choices[choices.length] = 22;
				choices[choices.length] = 22;
				choices[choices.length] = 22;
			}
		}
		//23 RUT
		if (player.inRut && monster.hasVagina() && player.hasCock()) {
			choices[choices.length] = 23;
			choices[choices.length] = 23;
			choices[choices.length] = 23;
			choices[choices.length] = 23;
			choices[choices.length] = 23;
		}
		//24 Poledance - req's staff! - Req's gender!  Req's TITS!
		if (player.weapon == weapons.W_STAFF && player.biggestTitSize() >= 1 && player.gender > 0) {
			choices[choices.length] = 24;
			choices[choices.length] = 24;
			choices[choices.length] = 24;
			choices[choices.length] = 24;
			choices[choices.length] = 24;
		}
		//25 Tall Tease! - Reqs 2+ feet & PC Cunt!
		if (player.tallness - monster.tallness >= 24 && player.biggestTitSize() >= 4) {
			choices[choices.length] = 25;
			choices[choices.length] = 25;
			choices[choices.length] = 25;
			choices[choices.length] = 25;
			choices[choices.length] = 25;
		}
		//26 SMART PEEPS! 70+ int, arouse spell!
		if (player.inte >= 70 && player.hasStatusEffect(StatusEffects.KnowsArouse)) {
			choices[choices.length] = 26;
			choices[choices.length] = 26;
			choices[choices.length] = 26;
		}
		//27 FEEDER
		if (player.hasPerk(PerkLib.Feeder) && player.biggestTitSize() >= 4) {
			choices[choices.length] = 27;
			choices[choices.length] = 27;
			choices[choices.length] = 27;
			if (player.biggestTitSize() >= 10) choices[choices.length] = 27;
			if (player.biggestTitSize() >= 15) choices[choices.length] = 27;
			if (player.biggestTitSize() >= 25) choices[choices.length] = 27;
			if (player.biggestTitSize() >= 40) choices[choices.length] = 27;
			if (player.biggestTitSize() >= 60) choices[choices.length] = 27;
			if (player.biggestTitSize() >= 80) choices[choices.length] = 27;
		}
		//28 FEMALE TEACHER COSTUME TEASE
		if (player.armorName == "backless female teacher's clothes" && player.gender == 2) {
			choices[choices.length] = 28;
			choices[choices.length] = 28;
			choices[choices.length] = 28;
			choices[choices.length] = 28;
		}
		//29 Male Teacher Outfit Tease
		if (player.armorName == "formal vest, tie, and crotchless pants" && player.gender == 1) {
			choices[choices.length] = 29;
			choices[choices.length] = 29;
			choices[choices.length] = 29;
			choices[choices.length] = 29;
		}
		//30 Naga Fetish Clothes
		if (player.armorName == "headdress, necklaces, and many body-chains") {
			choices[choices.length] = 30;
			choices[choices.length] = 30;
			choices[choices.length] = 30;
			choices[choices.length] = 30;
		}
		//31 Centaur harness clothes
		if (player.armorName == "bridle bit and saddle set") {
			choices[choices.length] = 31;
			choices[choices.length] = 31;
			choices[choices.length] = 31;
			choices[choices.length] = 31;
		}
		//32 Genderless servant clothes
		if (player.armorName == "servant's clothes" && player.gender == 0) {
			choices[choices.length] = 32;
			choices[choices.length] = 32;
			choices[choices.length] = 32;
			choices[choices.length] = 32;
		}
		//33 Crotch Revealing Clothes (herm only?)
		if (player.armorName == "crotch-revealing clothes" && player.gender == 3) {
			choices[choices.length] = 33;
			choices[choices.length] = 33;
			choices[choices.length] = 33;
			choices[choices.length] = 33;
		}
		//34 Maid Costume (female only):
		if (player.armorName == "maid's clothes" && player.hasVagina()) {
			choices[choices.length] = 34;
			choices[choices.length] = 34;
			choices[choices.length] = 34;
			choices[choices.length] = 34;
		}
		//35 Servant Boy Clothes (male only)
		if (player.armorName == "cute servant's clothes" && player.hasCock()) {
			choices[choices.length] = 35;
			choices[choices.length] = 35;
			choices[choices.length] = 35;
			choices[choices.length] = 35;
		}
		//36 Bondage Patient Clothes
		if (player.armorName == "bondage patient clothes") {
			choices[choices.length] = 36;
			choices[choices.length] = 36;
			choices[choices.length] = 36;
			choices[choices.length] = 36;
		}
		//37 Kitsune Tease
		//38 Kitsune Tease
		//39 Kitsune Tease
		//40 Kitsune Tease
		if (player.racialScore(Races.KITSUNE) >= 2 && player.tailType == Tail.FOX) {
			choices[choices.length] = 37;
			choices[choices.length] = 37;
			choices[choices.length] = 37;
			choices[choices.length] = 37;
			choices[choices.length] = 38;
			choices[choices.length] = 38;
			choices[choices.length] = 38;
			choices[choices.length] = 38;
			choices[choices.length] = 39;
			choices[choices.length] = 39;
			choices[choices.length] = 39;
			choices[choices.length] = 39;
			choices[choices.length] = 40;
			choices[choices.length] = 40;
			choices[choices.length] = 40;
			choices[choices.length] = 40;
		}
		//41 Kitsune Gendered Tease
		if (player.racialScore(Races.KITSUNE) >= 2 && player.tailType == Tail.FOX) {
			choices[choices.length] = 41;
			choices[choices.length] = 41;
			choices[choices.length] = 41;
			choices[choices.length] = 41;
		}
		//42 Urta teases!
		if (SceneLib.urtaQuest.isUrta()) {
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
			choices[choices.length] = 42;
		}
		//43 - special mino + cowgirls
		if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.racialScore(Races.COW) >= 3 && player.tailType == Tail.COW) {
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
			choices[choices.length] = 43;
		}
		//44 - Bikini Mail Teases!
		if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") {
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
			choices[choices.length] = 44;
		}
		//45 - Lethicite armor
		if (player.armor == armors.LTHCARM && player.upperGarment.isNothing && player.lowerGarment.isNothing) {
			choices[choices.length] = 45;
			choices[choices.length] = 45;
			choices[choices.length] = 45;
			choices[choices.length] = 45;
			choices[choices.length] = 45;
			choices[choices.length] = 45;
		}
		//46 - Alraune Tease
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			choices[choices.length] = 46;
			choices[choices.length] = 46;
			choices[choices.length] = 46;
			choices[choices.length] = 46;
		}
		//47 - Manticore Tailpussy Tease
		if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
			choices[choices.length] = 47;
			choices[choices.length] = 47;
			choices[choices.length] = 47;
			choices[choices.length] = 47;
		}
		//48 - Belly Dance (Naga races)
		if (player.isNaga() && flags[kFLAGS.SAMIRAH_HYPNOSIS] == 6) {
			choices[choices.length] = 48;
			choices[choices.length] = 48;
			choices[choices.length] = 48;
			choices[choices.length] = 48;
		}

		return choices;
	}

	public function applySelectedTease(select:int, display:Boolean = true):TeaseOptions {
		var options:TeaseOptions = new TeaseOptions();

		switch (select) {
				//0 butt shake
			case 0:
				if (display) {
					//Display
					outputText("You slap your " + buttDescript());
					if (player.butt.type >= 10 && player.tone < 60) outputText(", making it jiggle delightfully.");
					else outputText(".");
				}
				//Mod success
				options.ass = true;
				break;
				//1 BREAST JIGGLIN'
			case 1:
				//Single breast row
				if (player.breastRows.length == 1) {
					if (display) {
						//50+ breastsize% success rate
						outputText("Your lift your top, exposing your " + breastDescript(0) + " to [themonster].  You shake them from side to side enticingly.");
						if (player.lust >= (player.maxLust() * 0.5)) outputText("  Your " + nippleDescript(0) + "s seem to demand [monster his] attention.");
					}
				}
				//Multirow
				if (player.breastRows.length > 1) {
					if (display) {
						//50 + 10% per breastRow + breastSize%
						outputText("You lift your top, freeing your rows of " + breastDescript(0) + " to jiggle freely.  You shake them from side to side enticingly");
						if (player.lust >= (player.maxLust() * 0.5)) outputText(", your " + nippleDescript(0) + "s painfully visible.");
						else outputText(".");
					}
					options.chance++;
				}
				
				options.breasts = true;
				break;
				//2 PUSSAH FLASHIN'
			case 2:
				if (player.isTaur()) {
					if (display) outputText("You gallop toward your unsuspecting enemy, dodging their defenses and knocking them to the ground.  Before they can recover, you slam your massive centaur ass down upon them, stopping just short of using crushing force to pin them underneath you.  In this position, your opponent's face is buried right in your girthy horsecunt.  You grind your cunt into [monster his] face for a moment before standing.  When you do, you're gratified to see your enemy covered in your lubricant and smelling powerfully of horsecunt.");
					options.chance += 6;
					options.damage += 12;
				}
				else {
					if (display) outputText("You open your [armor], revealing your ");
					if (player.cocks.length > 0) {
						options.chance += 3;
						options.damage += 3;
						if (display && player.cocks.length == 1) outputText(player.cockDescript(0));
						if (display && player.cocks.length > 1) outputText(player.multiCockDescriptLight());
						if (display) outputText(" and ");
						if (player.hasPerk(PerkLib.BulgeArmor)) {
							options.damage += 15;
						}
						options.penis = true;
					}
					if (display) {
						outputText(vaginaDescript(0));
						outputText(".");
					}
				}
				
				options.vagina = true;
				break;
				//3 cock flash
			case 3:
				if (player.isTaur() && player.horseCocks() > 0) {
					if (display) outputText("You let out a bestial whinny and stomp your hooves at your enemy.  They prepare for an attack, but instead you kick your front hooves off the ground, revealing the hefty horsecock hanging beneath your belly.  You let it flop around, quickly getting rigid and to its full erect length.  You buck your hips as if you were fucking a mare in heat, letting your opponent know just what's in store for them if they surrender to pleasure...");
					if (player.hasPerk(PerkLib.BulgeArmor)) options.damage += 5;
				}
				else {
					if (display) {
						outputText("You open your [armor], revealing your ");
						if (player.cocks.length == 1) outputText(player.cockDescript(0));
						if (player.cocks.length > 1) outputText(player.multiCockDescriptLight());
						if (player.hasVagina()) outputText(" and ");
					}
					//Bulgy bonus!
					if (player.hasPerk(PerkLib.BulgeArmor)) {
						options.damage += 15;
						options.chance += 3;
					}
					if (player.vaginas.length > 0) {
						if (display) outputText(vaginaDescript(0));
						options.vagina = true;
					}
					if (display) outputText(".");
				}
				options.penis = true;
				break;
				//BIMBO
				//4 butt shake
			case 4:
				if (display) outputText("You turn away and bounce your [butt] up and down hypnotically");
				//Big butts = extra text + higher success
				if (player.butt.type >= 10) {
					if (display) outputText(", making it jiggle delightfully.  [Themonster] even gets a few glimpses of the " + assholeDescript() + " between your cheeks.");
					options.chance += 9;
				}
				//Small butts = less damage, still high success
				else {
					if (display) outputText(", letting [themonster] get a good look at your " + assholeDescript() + " and " + vaginaDescript(0) + ".");
					options.chance += 3;
					options.vagina = true;
				}
				options.ass  = true;
				options.anus = true;
				break;
				//5 breast jiggle
			case 5:
				if (display) {
					outputText("You lean forward, letting the well-rounded curves of your [allbreasts] show to [themonster].");
					outputText("  You cup them in your palms and lewdly bounce them, putting on a show and giggling the entire time.  An inch at a time, your [armor] starts to come down, dropping tantalizingly slowly until your " + nippleDescript(0) + "s pop free.");
				}
				if (player.lust >= (player.maxLust() * 0.5)) {
					if (player.hasFuckableNipples()) {
						options.chance++;
						if (display) outputText("  Clear slime leaks from them, making it quite clear that they're more than just nipples.");
					}
					else if (display) outputText("  Your hard nipples seem to demand [monster his] attention.");
					options.chance += 3;
					options.damage += 6;
				}
				//Damage boosts!
				options.breasts = true;
				break;
				//6 pussy flash
			case 6:
				if (player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties)) {
					if (display) outputText("You coyly open your [armor] and giggle, \"<i>Is this, like, what you wanted to see?</i>\"  ");
				}
				else {
					if (display) outputText("You coyly open your [armor] and purr, \"<i>Does the thought of a hot, ");
					if (display && player.hasPerk(PerkLib.FutaForm)) outputText("futanari ");
					else if (player.hasPerk(PerkLib.BimboBody) && display) outputText("bimbo ");
					else if (display) outputText("sexy ");
					if (display) outputText("body turn you on?</i>\"  ");
				}
				if (display) {
					if (monster.plural) outputText(monster.capitalA + monster.short + "' gazes are riveted on your groin as you run your fingers up and down your folds.");
					else outputText(monster.capitalA + monster.short + "'s gaze is riveted on your groin as you run your fingers up and down your folds.");
					if (player.clitLength > 3) outputText("  You smile as your " + clitDescript() + " swells out from the folds and stands proudly, begging to be touched.");
					else outputText("  You smile and pull apart your lower-lips to expose your " + clitDescript() + ", giving the perfect view.");
					if (player.cockTotal() > 0) outputText("  Meanwhile, [eachcock] bobs back and forth with your gyrating hips, adding to the display.");
				}
				//BONUSES!
				if (player.hasCock()) {
					if (player.hasPerk(PerkLib.BulgeArmor)) options.damage += 15;
					options.penis = true;
				}
				options.vagina = true;
				break;
				//7 special Adjatha-crafted bend over bimbo times
			case 7:
				if (display) {
					outputText("The glinting of light catches your eye and you whip around to inspect the glittering object, turning your back on [themonster].  Locking your knees, you bend waaaaay over, " + chestDesc() + " swinging in the open air while your [butt] juts out at the [themonster].  Your plump cheeks and " + hipDescript() + " form a jiggling heart-shape as you eagerly rub your thighs together.\n\n");
					outputText("The clear, warm fluid of your happy excitement trickles down from your loins, polishing your [skin] to a glossy, inviting shine.  Retrieving the useless, though shiny, bauble, you hold your pose for just a moment longer, a sly little smile playing across your lips as you wiggle your cheeks one more time before straightening up and turning back around.");
				}
				options.vagina = true;
				options.chance += 3;
				options.damage += 6;
				break;
				//==BRO STUFF=====
				//8 Pec Dance
			case 8:
				if (display) outputText("You place your hands on your hips and flex repeatedly, skillfully making your pecs alternatively bounce in a muscular dance.  ");
				if (player.hasPerk(PerkLib.BroBrains) && display) outputText("Damn, [themonster] has got to love this!");
				else if (display) outputText(monster.capitalA + monster.short + " will probably enjoy the show, but you feel a bit silly doing this.");
				options.chance += (player.tone - 75) / 2;
				options.damage += (player.tone - 70) / 2;
				options.auto = false;
				break;
				//9 Heroic Pose
			case 9:
				if (display) outputText("You lift your arms and flex your incredibly muscular arms while flashing your most disarming smile.  ");
				if (player.hasPerk(PerkLib.BroBrains) && display) outputText(monster.capitalA + monster.short + " can't resist such a heroic pose!");
				else if (display) outputText("At least the physical changes to your body are proving useful!");
				options.chance += (player.tone - 75) / 2;
				options.damage += (player.tone - 70) / 2;
				options.auto = false;
				break;
				//10 Bulgy groin thrust
			case 10:
				if (display) {
					outputText("You lean back and pump your hips at [themonster] in an incredibly vulgar display.  The bulging, barely-contained outline of your [cock] presses hard into your gear.  ");
					if (player.hasPerk(PerkLib.BroBrains)) outputText("No way could [monster he] resist your huge cock!");
					else outputText("This is so crude, but at the same time, you know it'll likely be effective.");
					outputText("  You go on like that, humping the air for your foe");
					outputText("'s");
					outputText(" benefit, trying to entice them with your man-meat.");
				}
				if (player.hasPerk(PerkLib.BulgeArmor)) options.damage += 15;
				options.penis = true;
				break;
				//11 Show off dick
			case 11:
				if (display) {
					if (silly() && rand(2) == 0) outputText("You strike a herculean pose and flex, whispering, \"<i>Do you even lift?</i>\" to [themonster].");
					else {
						outputText("You open your [armor] just enough to let your [cock] and [balls] dangle free.  A shiny rope of pre-cum dangles from your cock, showing that your reproductive system is every bit as fit as the rest of you.  ");
						if (player.hasPerk(PerkLib.BroBrains)) outputText("Bitches love a cum-leaking cock.");
						else outputText("You've got to admit, you look pretty good down there.");
					}
				}
				if (player.hasPerk(PerkLib.BulgeArmor)) options.damage += 15;
				options.penis = true;
				break;
				//==EXTRAS========
				//12 Cat flexibility.
			case 12:
				//CAT TEASE MOTHERFUCK (requires flexibility and legs [maybe can't do it with armor?])
				if (display) outputText("Reaching down, you grab an ankle and pull it backwards, looping it up and over to touch the foot to your " + hairDescript() + ".  You bring the leg out to the side, showing off your " + vaginaDescript(0) + " through your [armor].  The combination of the lack of discomfort on your face and the ease of which you're able to pose shows [themonster] how good of a time they're in for with you.");
				options.vagina = true;
				if (player.thickness < 33) options.chance += 3;
				else if (player.thickness >= 66) options.chance -= 3;
				options.damage += (player.thickness - 50) / 3;
				break;
				//13 Pregnant
			case 13:
				//PREG
				if (display) outputText("You lean back, feigning a swoon while pressing a hand on the small of your back.  The pose juts your huge, pregnant belly forward and makes the shiny spherical stomach look even bigger.  With a teasing groan, you rub the protruding tummy gently, biting your lip gently as you stare at [themonster] through heavily lidded eyes.  \"<i>All of this estrogen is making me frisky,</i>\" you moan, stroking hand gradually shifting to the southern hemisphere of your big baby-bump.");
				//if lactating]
				if (player.biggestLactation() >= 1) {
					if (display) outputText("  Your other hand moves to expose your " + chestDesc() + ", cupping and squeezing a stream of milk to leak down the front of your [armor].  \"<i>Help a mommy out.</i>\"\n\n");
					options.chance += 6;
					options.damage += 12;
				}
				if ((player.pregnancyIncubation < 100) || (player.pregnancy2Incubation < 100)) {
					options.chance += 3;
					options.damage += 6;
				}
				if ((player.pregnancyIncubation < 50) || (player.pregnancy2Incubation < 50)) {
					options.chance += 3;
					options.damage += 6;
				}
				break;
				//14 Brood Mother
			case 14:
				if (display) {
					if (rand(2) == 0) outputText("You tear open your [armor] and slip a few fingers into your well-used birth canal, giving your opponent a good look at what they're missing.  \"<i>C'mon stud,</i>\" you say, voice dripping with lust and desire, \"<i>Come to mama [name] and fuck my pussy 'til your baby batter just POURS out.  I want your children inside of me, I want your spawn crawling out of this cunt and begging for my milk.  Come on, FUCK ME PREGNANT!</i>\"");
					else outputText("You wiggle your " + hipDescript() + " at your enemy, giving them a long, tantalizing look at the hips that have passed so very many offspring.  \"<i>Oh, like what you see, bad boy?  Well why don't you just come on over and stuff that cock inside me?  Give me your seed, and I'll give you suuuuch beautiful offspring.  Oh?  Does that turn you on?  It does!  Come on, just let loose and fuck me full of your babies!</i>\"");
				}
				options.chance += 6;
				options.damage += 12;
				if (player.inHeat) {
					options.chance += 6;
					options.damage += 12;
				}
				options.vagina = true;
				break;
				//15 Nipplecunts
			case 15:
				//Req's tits & Pussy
				if (player.biggestTitSize() > 1 && player.hasVagina() && rand(2) == 0) {
					if (display) {
						outputText("Closing your eyes, you lean forward and slip a hand under your [armor].  You let out the slightest of gasps as your fingers find your drooling honeypot, warm tips poking, one after another between your engorged lips.  When you withdraw your hand, your fingers have been soaked in the dripping passion of your cunny, translucent beads rolling down to wet your palm.  With your other hand, you pull down the top of your [armor] and bare your " + chestDesc() + " to [themonster].\n\n");
						outputText("Drawing your lust-slick hand to your " + nippleDescript(0) + "s, the yielding flesh of your cunt-like nipples parts before the teasing digits.  Using your own girl cum as added lubrication, you pump your fingers in and out of your nipples, moaning as you add progressively more digits until only your thumb remains to stroke the inflamed flesh of your over-stimulated chest.  Your throat releases the faintest squeak of your near-orgasmic delight and you pant, withdrawing your hands and readjusting your armor.\n\n");
						outputText("Despite how quiet you were, it's clear that every lewd, desperate noise you made was heard by [themonster].");
					}
					options.chance += 6;
					options.damage += 12;
				}
				else if (player.biggestTitSize() > 1 && rand(2) == 0) {
					if (display) outputText("You yank off the top of your [armor], revealing your " + chestDesc() + " and the gaping nipplecunts on each.  With a lusty smirk, you slip a pair of fingers into the nipples of your " + chestDesc() + ", pulling the nipplecunt lips wide, revealing the lengthy, tight passage within.  You fingerfuck your nipplecunts, giving your enemy a good show before pulling your armor back on, leaving the tantalizing image of your gaping titpussies to linger in your foe's mind.");
					options.chance += 3;
					options.damage += 6;
				}
				else if (display) outputText("You remove the front of your [armor] exposing your " + chestDesc() + ".  Using both of your hands, you thrust two fingers into your nipple cunts, milky girl cum soaking your hands and fingers.  \"<i>Wouldn't you like to try out these holes too?</i>\"");
				options.breasts = true;
				break;
				//16 Anal gape
			case 16:
				if (display) outputText("You quickly strip out of your [armor] and turn around, giving your [butt] a hard slap and showing your enemy the real prize: your " + assholeDescript() + ".  With a smirk, you easily plunge your hand inside, burying yourself up to the wrist inside your anus.  You give yourself a quick fisting, watching the enemy over your shoulder while you moan lustily, sure to give them a good show.  You withdraw your hand and give your ass another sexy spank before readying for combat again.");
				options.anus = true;
				options.ass  = true;
				break;
				//17 Bee abdomen tease
			case 17:
				if (display) outputText("You swing around, shedding the [armor] around your waist to expose your [butt] to [themonster].  Taking up your oversized bee abdomen in both hands, you heft the thing and wave it about teasingly.  Drops of venom drip to and fro, a few coming dangerously close to [monster him].  \"<i>Maybe if you behave well enough, I'll even drop a few eggs into your belly,</i>\" you say softly, dropping the abdomen back to dangle above your butt and redressing.");
				options.ass = true;
				options.chance += 2;
				options.damage += 2;
				break;
				//18 DOG TEASE
			case 18:
				if (display) {
					outputText("You sit down like a dog, your [legs] are spread apart, showing your ");
					if (player.hasVagina()) outputText("parted cunt-lips");
					else outputText("puckered asshole, hanging, erect maleness,");
					outputText(" and your hands on the ground in front of you.  You pant heavily with your tongue out and promise, \"<i>I'll be a good little bitch for you</i>.\"");
				}
				options.vagina = true;
				options.chance += 3;
				options.damage += 6;
				break;
				//19 MAX FEM TEASE - SYMPHONIE
			case 19:
				if (display) outputText("You make sure to capture your foe's attention, then slowly and methodically allow your tongue to slide along your lush, full lips.  The glistening moisture that remains on their plump beauty speaks of deep lust and deeper throats.  Batting your long lashes a few times, you pucker them into a playful blown kiss, punctuating the act with a small moan. Your gorgeous feminine features hint at exciting, passionate moments together, able to excite others with just your face alone.");
				options.chance += 6;
				options.damage += 12;
				break;
				//20 MAX MASC TEASE
			case 20:
				if (display) outputText("As your foe regards you, you recognize their attention is fixated on your upper body.  Thrusting your strong jaw forward you show off your chiseled chin, handsome features marking you as a flawless specimen.  Rolling your broad shoulders, you nod your head at your enemy.  The strong, commanding presence you give off could melt the heart of an icy nun.  Your perfect masculinity speaks to your confidence, allowing you to excite others with just your face alone.");
				options.chance += 6;
				options.damage += 12;
				break;
				//21 MAX ADROGYN
			case 21:
				if (display) outputText("You reach up and run your hands down your delicate, androgynous features.  With the power of a man but the delicacy of a woman, looking into your eyes invites an air of enticing mystery.  You blow a brief kiss to your enemy while at the same time radiating a sexually exciting confidence.  No one could identify your gender by looking at your features, and the burning curiosity they encourage could excite others with just your face alone.");
				options.damage += 9;
				break;
				//22 SPOIDAH SILK
			case 22:
				if (display) outputText("Reaching back, you milk some wet silk from your spider-y abdomen and present it to [themonster], molding the sticky substance as [monster he] looks on curiously.  Within moments, you hold up a silken heart scuplture, and with a wink, you toss it at [monster him]. It sticks to [monster his] body, the sensation causing [monster him] to hastily slap the heart off.  [monster He] returns [monster his] gaze to you to find you turned around, [butt] bared and abdomen bouncing lazily.  \"<i>I wonder what would happen if I webbed up your hole after I dropped some eggs inside?</i>\" you hiss mischievously.  [monster He] gulps.");
				options.ass = true;
				break;
				//23 RUT TEASE
			case 23:
				if (display) {
					if (player.horseCocks() > 0 && player.longestHorseCockLength() >= 12) {
						outputText("You whip out your massive horsecock, and are immediately surrounded by a massive, heady musk.  Your enemy swoons, nearly falling to her knees under your oderous assault.  Grinning, you grab her shoulders and force her to her knees.  Before she can defend herself, you slam your horsecock onto her head, running it up and down on her face, her nose acting like a sexy bump in an onahole.  You fuck her face -- literally -- for a moment before throwing her back and sheathing your cock.");
					}
					else {
						outputText("Panting with your unstoppable lust for the delicious cunt before you, you yank off your [armor] with strength born of your inhuman rut, and quickly wave your fully erect cock at your enemy.  She flashes with lust, quickly feeling the heady effect of your man-musk.  You rush up, taking advantage of her aroused state, and grab her shoulders.  ");
						outputText("Before she can react, you push her down until she's level with your cock, and start to spin it in a circle, slapping her right in the face with your musky man-meat.  Her eyes swim, trying to follow your tool as you swat her in the face with your cock!  Satisfied, you release her and prepare to fight!");
					}
				}
				options.penis = true;
				break;
				//24 STAFF POLEDANCE
			case 24:
				if (display) outputText("You run your tongue across your lips as you plant your staff into the ground.  Before your enemy can react, you spin onto the long, wooden shaft, using it like an impromptu pole.  You lean back against the planted staff, giving your enemy a good look at your body.  You stretch backwards like a cat, nearly touching your fingertips to the ground beneath you, now holding onto the staff with only one leg.  You pull yourself upright and give your [butt] a little slap and your " + chestDesc() + " a wiggle before pulling open your [armor] and sliding the pole between your tits.  You drop down to a low crouch, only just covering your genitals with your hand as you shake your [butt] playfully.  You give the enemy a little smirk as you slip your [armor] back on and pick up your staff.");
				options.ass     = true;
				options.breasts = true;
				break;
				//TALL WOMAN TEASE
			case 25:
				if (display) outputText("You move close to your enemy, handily stepping over [monster his] defensive strike before leaning right down in [monster his] face, giving [monster him] a good long view at your cleavage.  \"<i>Hey, there, little " + monster.mf("guy", "girl") + ",</i>\" you smile.  Before [monster he] can react, you grab [monster him] and smoosh [monster his] face into your [fullchest], nearly choking [monster him] in the canyon of your cleavage.  [monster He] struggles for a moment.  You give [monster him] a little kiss on the head and step back, ready for combat.");
				options.breasts = true;
				options.chance += 6;
				options.damage += 12;
				break;
				//Magic Tease
			case 26:
				if (display) outputText("Seeing a lull in the battle, you plant your [weapon] on the ground and let your magic flow through you.  You summon a trickle of magic into a thick, slowly growing black ball of lust.  You wave the ball in front of you, making a little dance and striptease out of the affair as you slowly saturate the area with latent sexual magics.");
				options.chance += 3;
				options.damage += 6;
				break;
				//Feeder
			case 27:
				if (display) outputText("You present your swollen breasts full of milk to [themonster] and say \"<i>Wouldn't you just love to lie back in my arms and enjoy what I have to offer you?</i>\"");
				options.breasts = true;
				options.chance += 3;
				options.damage += 3;
				break;
				//28 FEMALE TEACHER COSTUME TEASE
			case 28:
				if (display) outputText("You turn to the side and give [themonster] a full view of your body.  You ask them if they're in need of a private lesson in lovemaking after class.");
				options.ass = true;
				break;
				//29 Male Teacher Outfit Tease
			case 29:
				if (display) outputText("You play with the strings on your outfit a bit and ask [themonster] just how much do they want to see their teacher pull them off?");
				options.chance += 3;
				options.damage += 9;
				break;
				//30 Naga Fetish Clothes
			case 30:
				if (display) outputText("You sway your body back and forth, and do an erotic dance for [themonster].");
				options.chance += 6;
				options.damage += 12;
				break;
				//31 Centaur harness clothes
			case 31:
				if (display) outputText("You rear back, and declare that, \"<i>This horse is ready to ride, all night long!</i>\"");
				options.chance += 6;
				options.damage += 12;
				break;
				//32 Genderless servant clothes
			case 32:
				if (display) outputText("You turn your back to your foe, and flip up your butt flap for a moment.   Your [butt] really is all you have to offer downstairs.");
				options.ass = true;
				options.chance += 3;
				options.damage += 6;
				break;
				//33 Crotch Revealing Clothes (herm only?)
			case 33:
				if (display) outputText("You do a series of poses to accentuate what you've got on display with your crotch revealing clothes, while asking if your [master] is looking to sample what is on display.");
				options.chance += 6;
				options.damage += 12;
				break;
				//34 Maid Costume (female only)
			case 34:
				if (display) outputText("You give a rather explicit curtsey towards [themonster] and ask them if your [master] is interested in other services today.");
				options.chance += 3;
				options.damage += 6;
				options.breasts = true;
				break;
				//35 Servant Boy Clothes (male only)
			case 35:
				if (display) outputText("You brush aside your crotch flap for a moment, then ask [themonster] if, [Master] would like you to use your [cocks] on them?");
				options.penis = true;
				options.chance += 3;
				options.damage += 6;
				break;
				//36 Bondage Patient Clothes (done):
			case 36:
				if (display) outputText("You pull back one of the straps on your bondage cloths and let it snap back.  \"<i>I need some medical care, feeling up for it?</i>\" you tease.");
				options.damage += 6;
				options.chance += 3;
				break;
			default:
				outputText("You shimmy and shake sensually. (An error occurred.)");
				break;
			case 37:
				if (display) outputText("You purse your lips coyly, narrowing your eyes mischievously and beckoning to [themonster] with a burning come-hither glare.  Sauntering forward, you pop your hip to the side and strike a coquettish pose, running " + ((player.tailCount > 1) ? "one of your tails" : "your tail") + " up and down [monster his] body sensually.");
				options.chance += 18;
				options.damage += 9;
				break;
			case 38:
				if (display) outputText("You wet your lips, narrowing your eyes into a smoldering, hungry gaze.  Licking the tip of your index finger, you trail it slowly and sensually down the front of your [armor], following the line of your " + chestDesc() + " teasingly.  You hook your thumbs into your top and shimmy it downward at an agonizingly slow pace.  The very instant that your [nipples] pop free, your tail crosses in front, obscuring [themonster]'s view.");
				options.breasts = true;
				options.chance += 3;
				options.damage += 3;
				break;
			case 39:
				if (display) {
					outputText("Leaning forward, you bow down low, raising a hand up to your lips and blowing [themonster] a kiss.  You stand straight, wiggling your " + hipDescript() + " back and forth seductively while trailing your fingers down your front slowly, pouting demurely.  The tip of ");
					if (player.tailCount == 1) outputText("your");
					else outputText("a");
					outputText(" bushy tail curls up around your [leg], uncoiling with a whipping motion that makes an audible crack in the air.");
				}
				options.ass = true;
				options.chance += 3;
				options.damage += 3;
				break;
			case 40:
				if (display) {
					outputText("Turning around, you stare demurely over your shoulder at [themonster], batting your eyelashes amorously.");
					if (player.tailCount == 1) outputText("  Your tail twists and whips about, sliding around your " + hipDescript() + " in a slow arc and framing your rear nicely as you slowly lift your [armor].");
					else outputText("  Your tails fan out, twisting and whipping sensually, sliding up and down your [legs] and framing your rear nicely as you slowly lift your [armor].");
					outputText("  As your [butt] comes into view, you brush your tail" + ((player.tailCount > 1) ? "s" : "" ) + " across it, partially obscuring the view in a tantalizingly teasing display.");
				}
				options.ass  = true;
				options.anus = true;
				options.chance += 3;
				options.damage += 6;
				break;
			case 41:
				if (display) {
					outputText("Smirking coyly, you sway from side to side, running your tongue along your upper teeth seductively.  You hook your thumbs into your [armor] and pull them away to partially reveal ");
					if (player.cockTotal() > 0) outputText(player.sMultiCockDesc());
					if (player.gender == 3) outputText(" and ");
					if (player.gender >= 2) outputText("your " + vaginaDescript(0));
					outputText(".  Your bushy tail" + ((player.tailCount > 1) ? "s" : "" ) + " cross" + ((player.tailCount > 1) ? "" : "es") + " in front, wrapping around your genitals and obscuring the view teasingly.");
				}
				options.vagina = true;
				options.penis  = true;
				options.damage += 6;
				options.chance += 3;
				break;
			case 42:
				//Tease #1:
				if (rand(2) == 0) {
					if (display) outputText("You lift your skirt and flash your king-sized stallionhood, already unsheathing itself and drooling pre, at your opponent.  \"<i>Come on, then; I got plenty of girlcock for you if that's what you want!</i>\" you cry.");
					options.penis = true;
					options.damage += 9;
					options.chance += 3;
				}
				//Tease #2:
				else {
					if (display) outputText("You turn around and bend over, swaying your tail from side to side in your most flirtatious manner and wiggling your hips seductively, your skirt fluttering with the motions.  \"<i>Come on then, what are you waiting for?  This is a fine piece of ass here,</i>\" you grin, spanking yourself with an audible slap.");
					options.ass = true;
					options.chance += 6;
					options.damage += 9;
				}
				break;
			case 43:
				var cows:int = rand(7);
				if (cows == 0) {
					if (display) outputText("You tuck your hands under your chin and use your arms to squeeze your massive, heavy breasts together.  Milk squirts from your erect nipples, filling the air with a rich, sweet scent.");
					options.breasts = true;
					options.chance += 6;
					options.damage += 3;
				}
				else if (cows == 1) {
					if (display) outputText("Moaning, you bend forward, your full breasts nearly touching the ground as you sway your [hips] from side to side.  Looking up from under heavily-lidded eyes, you part your lips and lick them, letting out a low, lustful \"<i>Mooooo...</i>\"");
					options.breasts = true;
					options.chance += 6;
					options.damage += 6;
				}
				else if (cows == 2) {
					if (display) {
						outputText("You tuck a finger to your lips, blinking innocently, then flick your tail, wafting the scent of your ");
						if (player.wetness() >= 3) outputText("dripping ");
						outputText("sex through the air.");
					}
					options.vagina = true;
					options.chance += 3;
					options.damage += 3;
				}
				else if (cows == 3) {
					if (display) outputText("You heft your breasts, fingers splayed across your [nipples] as you SQUEEZE.  Milk runs in rivulets over your hands and down the massive curves of your breasts, soaking your front with sweet, sticky milk.");
					options.breasts = true;
					options.chance += 9;
					options.damage += 3;
				}
				else if (cows == 4) {
					if (display) outputText("You lift a massive breast to your mouth, suckling loudly at yourself, finally letting go of your nipple with a POP and a loud, satisfied gasp, milk running down your chin.");
					options.breasts = true;
					options.chance += 3;
					options.damage += 9;
				}
				else if (cows == 5) {
					if (display) outputText("You crouch low, letting your breasts dangle in front of you.  Each hand caresses one in turn as you slowly milk yourself onto your thighs, splashing white, creamy milk over your hips and sex.");
					options.vagina  = true;
					options.breasts = true;
					options.chance += 3;
				}
				else {
					if (display) outputText("You lift a breast to your mouth, taking a deep draught of your own milk, then tilt your head back.  With a low moan, you let it run down your front, winding a path between your breasts until it drips sweetly from your crotch.");
					options.vagina  = true;
					options.breasts = true;
					options.damage += 6;
				}
				if (monster.short.indexOf("minotaur") != -1) {
					options.damage += 18;
					options.chance += 9;
				}
				break;
				//lusty maiden's armor teases
			case 44:
				var maiden:int = rand(5);
				options.damage += 15;
				options.chance += 9;
				if (maiden == 0) {
					if (display) outputText("Confidently sauntering forward, you thrust your chest out, arching your back in order to enhance your [chest].  You slowly begin to shake your torso back and forth, slapping your chain-clad breasts against each other again and again.  One of your hands finds its way to one of the pillowy expanses and grabs hold, fingers sinking into the soft tit through the fine, mail covering.  You stop your shaking to trace a finger down through the exposed center of your cleavage, asking, \"<i>Don't you just want to snuggle inside?</i>\"");
					options.breasts = true;
				}
				else if (maiden == 1) {
					if (display) outputText("You skip up to [themonster] and spin around to rub your barely-covered butt up against [monster him].  Before [monster he] can react, you're slowly bouncing your [butt] up and down against [monster his] groin.  When [monster he] reaches down, you grab [monster his] hand and press it up, under your skirt, right against the steamy seal on your sex.  The simmering heat of your overwhelming lust burns hot enough for [monster him] to feel even through the contoured leather, and you let [monster him] trace the inside of your [leg] for a moment before moving away, laughing playfully.");
					options.ass    = true;
					options.vagina = true;
				}
				else if (maiden == 2) {
					if (display) {
						outputText("You flip up the barely-modest chain you call a skirt and expose your g-string to [themonster].  Slowly swaying your [hips], you press a finger down on the creased crotch plate and exaggerate a lascivious moan into a throaty purr of enticing, sexual bliss.  Your eyes meet [monster his], and you throatily whisper, \"<i>");
						if (player.hasVirginVagina()) outputText("Think you can handle a virgin's infinite lust?");
						else outputText("Think you have what it takes to satisfy this perfect pussy?");
						outputText("</i>\"");
					}
					options.vagina = true;
					options.damage += 9;
				}
				else if (maiden == 3) {
					if (display) outputText("You seductively wiggle your way up to [themonster], and before [monster he] can react to your salacious advance, you snap a [leg] up in what would be a vicious kick, if you weren't simply raising it to rest your [foot] on [monster his] shoulder.  With your thighs so perfectly spready, your skirt is lifted, and [themonster] is given a perfect view of your thong-enhanced cameltoe and the moisture that beads at the edges of your not-so-modest covering.");
					options.vagina = true;
				}
				else {
					if (display) outputText("Bending over, you lift your [butt] high in the air.  Most of your barely-covered tush is exposed, but the hem of your chainmail skirt still protects some of your anal modesty.  That doesn't last long.  You start shaking your [butt] up, down, back, and forth to an unheard rhythm, flipping the pointless covering out of the way so that [themonster] can gaze upon your curvy behind in it all its splendid detail.  A part of you hopes that [monster he] takes in the intricate filigree on the back of your thong, though to [monster him] it looks like a bunch of glittering arrows on an alabaster background, all pointing squarely at your [asshole].");
					options.ass = true;
					options.chance += 6;
				}
				break;
				//lethicite armor teases
			case 45:
				var partChooser:Array = []; //Array for choosing.
				//Choose part. Must not be a centaur for cock and vagina teases!
				partChooser[partChooser.length] = 0;
				if (player.gender == 1 && !player.isTaur()) partChooser[partChooser.length] = 1;
				if (player.gender == 2 && !player.isTaur()) partChooser[partChooser.length] = 2;
				if (player.gender == 3 && player.hasVagina() && !player.isTaur()) partChooser[partChooser.length] = 3;
				//Let's do this!
				switch (partChooser[rand(partChooser.length)]) {
					case 0:
						if (display) outputText("You place your hand on your lethicite-covered belly, move your hand up across your belly and towards your [chest]. Taking advantage of the small openings in your breastplate, you pinch and tweak your exposed [nipples].");
						options.breasts = true;
						options.chance += 9;
						options.damage += 3;
						break;
					case 1:
						if (display) outputText("You move your hand towards your [cocks], unobstructed by the lethicite. You give your [cock] a good stroke and sway your hips back and forth, emphasizing your manhood.");
						options.penis = true;
						options.chance += 3;
						options.damage += 6;
						break;
					case 2:
						if (display) outputText("You move your hand towards your [pussy], unobstructed by the lethicite. You give your [clit] a good tease, finger your [pussy], and sway your hips back and forth, emphasizing your womanhood.");
						options.vagina = true;
						options.chance += 3;
						options.damage += 6;
						break;
					case 3:
						if (display) outputText("You move your hand towards your [cocks] and [pussy], unobstructed by the lethicite. You give your [cock] a good stroke, tease your [clit], and sway your hips back and forth, emphasizing your hermaphroditic gender.");
						options.penis  = true;
						options.vagina = true;
						options.chance += 3;
						options.damage += 9;
						break;
					default:
						if (display) outputText("Whoops, something derped! Please let Ormael/Aimozg know! Anyways, you put on a tease show.");
				}
				break;
				//alraune teases
			case 46:
				if (display) outputText("You let your vines crawl around your opponent, teasing all of [themonster]'s erogenous zones.  [Themonster] gasps in involuntary arousal at your ministrations, relishing the way your vines seek out all [themonster] pleasurable spots and relentlessly assaults them.");
				if (player.isLiliraune()) {
					if (display) {
						outputText(" Meanwhile you and your twin smile in understanding. You begin to make out, slathering your respective bodies with sweet syrupy nectar and mashing your breasts against each other in order to give a lewd show to [themonster] as both of you pull a nectar dripping hand out in invitation to your entangled opponent.\n\n");
						outputText("\"<i>Can't you see what delights you're missing out on?</i>\"\n\n");
						outputText("\"<i>Just give up and we'll give you a good time.</i>\"\n\n");
						outputText("\"<i>If you think you have the stamina to take both of us, that is.</i>\"\n\n");
					}
					options.breasts = true;
					options.chance += 9;
				 	options.damage += 30;
				} else
					options.damage += 15;
				break;
				//manticore tailpussy teases
			case 47:
				if (display) {
					outputText("You suddenly open your tail pussy presenting your drooling hole to [themonster] and smirk.\n\n");
					outputText("\"<i>Bet you want a shot at this, look how much this bad girl is ready for you.</i>\"");
				}
				options.chance += 9;
				options.damage += 9;
				break;
				//naga races belly dance teases
			case 48:
				if (display) outputText("You give [themonster] a belly dance, moving your hip from a side to another and displaying your assets.  [Themonster] is so distracted by your dancing it doesn’t realise the two of you are still in battle for a few seconds before snapping out. [monster he] did absolutely nothing for the last six seconds.");
				if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
				options.chance += 9;
				options.damage += 9;
				break;
		}

		return options;
	}

	public function calcBonusTeaseMod(options:TeaseOptions, display:Boolean = true):TeaseOptions {
		if (display && player.perkv1(PerkLib.ImpNobility) > 0) {
			outputText("  Your imp cohorts assist in your assault, jerking their dicks off to spray your opponent with their corrupt cum.");
		}

		var bonusChance:Number = options.bonusChance;
		var bonusDamage:Number = options.bonusDamage;

		if (options.auto) {
			//TIT BONUSES
			if (options.breasts) {
				if (player.bRows() > 1) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.bRows() > 2) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.bRows() > 4) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestLactation() >= 2) {
					bonusChance += 3;
					bonusDamage += 6;
				}
				if (player.biggestLactation() >= 3) {
					bonusChance += 3;
					bonusDamage += 6;
				}
				if (player.biggestTitSize() >= 4) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestTitSize() >= 7) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestTitSize() >= 12) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestTitSize() >= 25) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestTitSize() >= 50) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasFuckableNipples()) {
					bonusChance += 3;
					bonusDamage += 6;
				}
				if (player.averageNipplesPerBreast() > 1) {
					bonusChance += 3;
					bonusDamage += 6;
				}
			}
			//PUSSY BONUSES
			if (options.vagina) {
				if (player.hasVagina() && player.wetness() >= 2) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.wetness() >= 3) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.wetness() >= 4) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.wetness() >= 5) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.clitLength > 1.5) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.clitLength > 3.5) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.clitLength > 7) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hasVagina() && player.clitLength > 12) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.vaginalCapacity() >= 30) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.vaginalCapacity() >= 70) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.vaginalCapacity() >= 120) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.vaginalCapacity() >= 200) {
					bonusChance += 2;
					bonusDamage += 3;
				}
			}
			//Penis bonuses!
			if (options.penis) {
				if (player.cockTotal() > 1) {
					bonusChance += 3;
					bonusDamage += 6;
				}
				if (player.biggestCockArea() >= 15) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestCockArea() >= 30) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestCockArea() >= 60) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.biggestCockArea() >= 120) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.cumQ() >= 50) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.cumQ() >= 150) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.cumQ() >= 300) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.cumQ() >= 1000) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (options.balls > 0) {
					if (player.balls > 2) {
						bonusChance += 3;
						bonusDamage += 6;
					}
					if (player.ballSize > 3) {
						bonusChance += 2;
						bonusDamage += 3;
					}
					if (player.ballSize > 7) {
						bonusChance += 2;
						bonusDamage += 3;
					}
					if (player.ballSize > 12) {
						bonusChance += 2;
						bonusDamage += 3;
					}
				}
				if (player.biggestCockArea() < 8) {
					bonusChance -= 3;
					bonusDamage -= 6;
					if (player.biggestCockArea() < 5) {
						bonusChance -= 3;
						bonusDamage -= 6;
					}
				}
			}
			if (options.ass) {
				if (player.butt.type >= 6) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.butt.type >= 10) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.butt.type >= 13) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.butt.type >= 16) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.butt.type >= 20) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hips.type >= 6) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hips.type >= 10) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hips.type >= 13) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hips.type >= 16) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.hips.type >= 20) {
					bonusChance += 2;
					bonusDamage += 3;
				}
			}
			if (options.anus) {
				if (player.ass.analLooseness == 0) {
					bonusChance += 5;
					bonusDamage += 9;
				}
				if (player.ass.analWetness > 0) {
					bonusChance += 3;
					bonusDamage += 6;
				}
				if (player.analCapacity() >= 30) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.analCapacity() >= 70) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.analCapacity() >= 120) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.analCapacity() >= 200) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.ass.analLooseness == 4) {
					bonusChance += 2;
					bonusDamage += 3;
				}
				if (player.ass.analLooseness == 5) {
					bonusChance += 5;
					bonusDamage += 9;
				}
			}
			//Trim it down!
			if (bonusChance > 15) bonusChance = 15;
			if (bonusDamage > 30) bonusDamage = 30;
		}

		options.bonusDamage = bonusDamage;
		options.bonusChance = bonusChance;

		return options;
	}

	public function bonusExpAfterSuccesfullTease():Number {
		var sucessBonusTeaseExp:Number = 1;
		if (player.hasPerk(PerkLib.SuperSensual)) sucessBonusTeaseExp += 2;
		if (player.hasPerk(PerkLib.Sensual)) sucessBonusTeaseExp += 1;
		return sucessBonusTeaseExp;
	}


}

}
