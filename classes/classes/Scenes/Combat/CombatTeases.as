package classes.Scenes.Combat 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.Areas.GlacialRift.FrostGiant;
	import classes.Scenes.Dungeons.D3.*;
	import classes.Scenes.Dungeons.HelDungeon.*;
	import classes.Scenes.NPCs.*;
	import classes.Scenes.Places.TelAdre.UmasShop;
	
	public class CombatTeases extends BaseContent
	{
		public function CombatTeases() {}
		
		public function teaseAttack():void {
			if (monster.lustVuln == 0) {
				clearOutput();
				outputText("You try to tease " + monster.a + monster.short + " with your body, but it doesn't have any effect on " + monster.pronoun2 + ".\n\n");
				monster.doAI();
			}
			//Worms are immune!
			else if (monster.short == "worms") {
				clearOutput();
				outputText("Thinking to take advantage of its humanoid form, you wave your cock and slap your ass in a rather lewd manner. However, the creature fails to react to your suggestive actions.\n\n");
				monster.doAI();
			}
			else {
				tease();
				if (!combat.combatRoundOver()) monster.doAI();
			}
		}
		
		// Just text should force the function to purely emit the test text to the output display, and not have any other side effects
		public function tease(justText:Boolean = false):void {
			if (!justText) clearOutput();
			//You cant tease a blind guy!
			if (monster.findStatusEffect(StatusEffects.Blind) >= 0) {
				outputText("You do your best to tease " + monster.a + monster.short + " with your body.  It doesn't work - you blinded " + monster.pronoun2 + ", remember?\n\n", true);
				return;
			}
			if (player.findStatusEffect(StatusEffects.Sealed) >= 0 && player.statusEffectv2(StatusEffects.Sealed) == 1) {
				outputText("You do your best to tease " + monster.a + monster.short + " with your body.  Your artless twirls have no effect, as <b>your ability to tease is sealed.</b>\n\n", true);
				return;
			}	
			if (monster.short == "Sirius, a naga hypnotist") {
				outputText("He is too focused on your eyes to pay any attention to your teasing moves, <b>looks like you'll have to beat him up.</b>\n\n");
				return;
			}
			combat.fatigueRecovery();
			var damage:Number;
			var chance:Number;
			var bimbo:Boolean = false;
			var bro:Boolean = false;
			var futa:Boolean = false;
			var choices:Array = [];
			var select:Number;
			//Tags used for bonus damage and chance later on
			var breasts:Boolean = false;
			var penis:Boolean = false;
			var balls:Boolean = false;
			var vagina:Boolean = false;
			var anus:Boolean = false;
			var ass:Boolean = false;
			//If auto = true, set up bonuses using above flags
			var auto:Boolean = true;
			//==============================
			//Determine basic success chance.
			//==============================
			chance = 60;
			//5% chance for each tease level.
			chance += player.teaseLevel * 5;
			//Extra chance for sexy undergarments.
			chance += player.upperGarment.sexiness;
			chance += player.lowerGarment.sexiness;
			//10% for seduction perk
			if (player.findPerk(PerkLib.Seduction) >= 0) chance += 10;
			//10% for sexy armor types
			if (player.findPerk(PerkLib.SluttySeduction) >= 0) chance += 10;
			//10% for bimbo shits
			if (player.findPerk(PerkLib.BimboBody) >= 0) {
				chance += 10;
				bimbo = true;
			}
			if (player.findPerk(PerkLib.BroBody) >= 0) {
				chance += 10;
				bro = true;
			}
			if (player.findPerk(PerkLib.FutaForm) >= 0) {
				chance += 10;
				futa = true;
			}
			//2 & 2 for seductive valentines!
			if (player.findPerk(PerkLib.SensualLover) >= 0) {
				chance += 2;
			}
			if (player.findPerk(PerkLib.ChiReflowLust) >= 0) chance += UmasShop.NEEDLEWORK_LUST_TEASE_MULTI;
			//==============================
			//Determine basic damage.
			//==============================
			damage = 6 + rand(3);
			if (player.findPerk(PerkLib.SensualLover) >= 0) {
				damage += 2;
			}
			if (player.findPerk(PerkLib.Seduction) >= 0) damage += 5;
			//+ slutty armor bonus
			if (player.findPerk(PerkLib.SluttySeduction) >= 0) damage += player.perkv1(PerkLib.SluttySeduction);
			//10% for bimbo shits
			if (bimbo || bro || futa) {
				damage += 5;
				bimbo = true;
			}
			if (player.level < 30) damage += player.level;
			else if (player.level < 60) damage += 30 + ((player.level - 30) / 2);
			else damage += 45 + ((player.level - 60) / 5);
			damage += player.teaseLevel*2;
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
			//==============================
			//BUILD UP LIST OF TEASE CHOICES!
			//==============================
			//Futas!
			if ((futa || bimbo) && player.gender == 3) {
				//Once chance of butt.
				choices[choices.length] = 4;
				//Big butts get more butt
				if (player.buttRating >= 7) choices[choices.length] = 4;
				if (player.buttRating >= 10) choices[choices.length] = 4;
				if (player.buttRating >= 14) choices[choices.length] = 4;
				if (player.buttRating >= 20) choices[choices.length] = 4;
				if (player.buttRating >= 25) choices[choices.length] = 4;
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
				if (player.hasVagina() && player.buttRating >= 8 && player.hipRating >= 6 && player.biggestTitSize() >= 4) {
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
					if (player.tone == 100) choices[choices.length] = 8;
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
				if (player.buttRating >= 7) choices[choices.length] = 0;
				if (player.buttRating >= 10) choices[choices.length] = 0;
				if (player.buttRating >= 14) choices[choices.length] = 0;
				if (player.buttRating >= 20) choices[choices.length] = 0;
				if (player.buttRating >= 25) choices[choices.length] = 0;
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
			if (player.findPerk(PerkLib.Flexibility) >= 0 && player.isBiped() && player.hasVagina()) {
				choices[choices.length] = 12;
				choices[choices.length] = 12;
				if (player.wetness() >= 3) choices[choices.length] = 12;
				if (player.wetness() >= 5) choices[choices.length] = 12;
				if (player.vaginalCapacity() >= 30) choices[choices.length] = 12;
			}
			//13 Pregnant
			if (player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 0) {
				choices[choices.length] = 13;
				if (player.biggestLactation() >= 1) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 180) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 120) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 100) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 50) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 24) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 24) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 24) choices[choices.length] = 13;
				if (player.pregnancyIncubation <= 24) choices[choices.length] = 13;
			}
			//14 Brood Mother
			if (monster.hasCock() && player.hasVagina() && player.findPerk(PerkLib.BroodMother) >= 0 && (player.pregnancyIncubation <= 0 || player.pregnancyIncubation > 216)) {
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
			if (player.tailType == TAIL_TYPE_BEE_ABDOMEN) {
				choices[choices.length] = 17;
				choices[choices.length] = 17;
			}
			//18 DOG TEASE
			if (player.dogScore() >= 4 && player.hasVagina() && player.isBiped()) {
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
			if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) {
				choices[choices.length] = 22;
				choices[choices.length] = 22;
				choices[choices.length] = 22;
				if (player.spiderScore() >= 4) {
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
			if (player.weaponName == "wizard's staff" && player.biggestTitSize() >= 1 && player.gender > 0) {
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
			if (player.inte >= 70 && player.findStatusEffect(StatusEffects.KnowsArouse) >= 0) {
				choices[choices.length] = 26;
				choices[choices.length] = 26;
				choices[choices.length] = 26;
			}
			//27 FEEDER
			if (player.findPerk(PerkLib.Feeder) >= 0 && player.biggestTitSize() >= 4) {
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
			if (player.kitsuneScore() >= 2 && player.tailType == TAIL_TYPE_FOX) {
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
			if (player.kitsuneScore() >= 2 && player.tailType == TAIL_TYPE_FOX) {
				choices[choices.length] = 41;
				choices[choices.length] = 41;
				choices[choices.length] = 41;
				choices[choices.length] = 41;
			}
			//42 Urta teases!
			if (getGame().urtaQuest.isUrta()) {
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
			if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.cowScore() >= 3 && player.tailType == TAIL_TYPE_COW) {
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
			if (player.armor == armors.LTHCARM && player.upperGarment == UndergarmentLib.NOTHING && player.lowerGarment == UndergarmentLib.NOTHING) {
				choices[choices.length] = 45;
				choices[choices.length] = 45;
				choices[choices.length] = 45;
				choices[choices.length] = 45;
				choices[choices.length] = 45;
				choices[choices.length] = 45;
			}
			//=======================================================
			//    CHOOSE YOUR TEASE AND DISPLAY IT!
			//=======================================================
			select = choices[rand(choices.length)];
			if (monster.short.indexOf("minotaur") != -1) 
			{
				if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.cowScore() >= 3 && player.tailType == TAIL_TYPE_COW)
					select = 43;
			}
			//Lets do zis!
			switch(select) {
				//0 butt shake
				case 0:
					//Display
					outputText("You slap your " + player.buttDescript(), false);
					if (player.buttRating >= 10 && player.tone < 60) outputText(", making it jiggle delightfully.", false);
					else outputText(".", false);
					//Mod success
					ass = true;
					break;
				//1 BREAST JIGGLIN'
				case 1:
					//Single breast row
					if (player.breastRows.length == 1) {
						//50+ breastsize% success rate
						outputText("Your lift your top, exposing your " + player.breastDescript(0) + " to " + monster.a + monster.short + ".  You shake them from side to side enticingly.", false);
						if (player.lust >= 50) outputText("  Your " + player.nippleDescript(0) + "s seem to demand " + monster.pronoun3 + " attention.", false);
					}
					//Multirow
					if (player.breastRows.length > 1) {
						//50 + 10% per breastRow + breastSize%
						outputText("You lift your top, freeing your rows of " + player.breastDescript(0) + " to jiggle freely.  You shake them from side to side enticingly", false);
						if (player.lust >= 50) outputText(", your " + player.nippleDescript(0) + "s painfully visible.", false);
						else outputText(".", false);
						chance++;
					}
					breasts = true;
					break;
				//2 PUSSAH FLASHIN'
				case 2:
					if (player.isTaur()) {
						outputText("You gallop toward your unsuspecting enemy, dodging their defenses and knocking them to the ground.  Before they can recover, you slam your massive centaur ass down upon them, stopping just short of using crushing force to pin them underneath you.  In this position, your opponent's face is buried right in your girthy horsecunt.  You grind your cunt into " + monster.pronoun3 + " face for a moment before standing.  When you do, you're gratified to see your enemy covered in your lubricant and smelling powerfully of horsecunt.", false);
						chance += 2;
						damage += 4;
					}
					else {	
						outputText("You open your " + player.armorName + ", revealing your ", false);
						if (player.cocks.length > 0) {
							chance++;
							damage++;
							if (player.cocks.length == 1) outputText(player.cockDescript(0), false);
							if (player.cocks.length > 1) outputText(player.multiCockDescriptLight(), false);
							outputText(" and ", false);
							if (player.findPerk(PerkLib.BulgeArmor) >= 0) {
								damage += 5;
							}
							penis = true;
						}
						outputText(player.vaginaDescript(0), false);
						outputText(".", false);
					}
					vagina = true;
					break;
				//3 cock flash
				case 3:
					if (player.isTaur() && player.countCocksOfType(CockTypesEnum.HORSE) > 0) {
						outputText("You let out a bestial whinny and stomp your hooves at your enemy.  They prepare for an attack, but instead you kick your front hooves off the ground, revealing the hefty horsecock hanging beneath your belly.  You let it flop around, quickly getting rigid and to its full erect length.  You buck your hips as if you were fucking a mare in heat, letting your opponent know just what's in store for them if they surrender to pleasure...", false);
						if (player.findPerk(PerkLib.BulgeArmor) >= 0) damage += 5;
					}
					else {
						outputText("You open your " + player.armorName + ", revealing your ", false);
						if (player.cocks.length == 1) outputText(player.cockDescript(0), false);
						if (player.cocks.length > 1) outputText(player.multiCockDescriptLight(), false);
						if (player.hasVagina()) outputText(" and ", false);
						//Bulgy bonus!
						if (player.findPerk(PerkLib.BulgeArmor) >= 0) {
							damage += 5;
							chance++;
						}
						if (player.vaginas.length > 0) {
							outputText(player.vaginaDescript(0), false);
							vagina = true;
						}
						outputText(".", false);
					}
					penis = true;
					break;
				//BIMBO
				//4 butt shake
				case 4:
					outputText("You turn away and bounce your " + player.buttDescript() + " up and down hypnotically", false);
					//Big butts = extra text + higher success
					if (player.buttRating >= 10) {
						outputText(", making it jiggle delightfully.  " + monster.capitalA + monster.short + " even gets a few glimpses of the " + player.assholeDescript() + " between your cheeks.", false);
						chance += 3;
					}
					//Small butts = less damage, still high success
					else {
						outputText(", letting " + monster.a + monster.short + " get a good look at your " + player.assholeDescript() + " and " + player.vaginaDescript(0) + ".", false);
						chance += 1;
						vagina = true;
					}
					ass = true;
					anus = true;
					break;
				//5 breast jiggle
				case 5:
					outputText("You lean forward, letting the well-rounded curves of your " + player.allBreastsDescript() + " show to " + monster.a + monster.short + ".", false);
					outputText("  You cup them in your palms and lewdly bounce them, putting on a show and giggling the entire time.  An inch at a time, your " + player.armorName + " starts to come down, dropping tantalizingly slowly until your " + player.nippleDescript(0) + "s pop free.", false);
					if (player.lust >= 50) {
						if (player.hasFuckableNipples()) {
							chance++;
							outputText("  Clear slime leaks from them, making it quite clear that they're more than just nipples.", false);
						}
						else outputText("  Your hard nipples seem to demand " + monster.pronoun3 + " attention.", false);
						chance += 1;
						damage += 2;
					}
					//Damage boosts!
					breasts = true;
					break;
				//6 pussy flash
				case 6:
					if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) {
						outputText("You coyly open your " + player.armorName + " and giggle, \"<i>Is this, like, what you wanted to see?</i>\"  ", false);
					}
					else {
						outputText("You coyly open your " + player.armorName + " and purr, \"<i>Does the thought of a hot, ", false);
						if (futa) outputText("futanari ", false);
						else if (player.findPerk(PerkLib.BimboBody) >= 0) outputText("bimbo ", false);
						else outputText("sexy ");
						outputText("body turn you on?</i>\"  ", false);
					}
					if (monster.plural) outputText(monster.capitalA + monster.short + "' gazes are riveted on your groin as you run your fingers up and down your folds seductively.", false);
					else outputText(monster.capitalA + monster.short + "'s gaze is riveted on your groin as you run your fingers up and down your folds seductively.", false);
					if (player.clitLength > 3) outputText("  You smile as your " + player.clitDescript() + " swells out from the folds and stands proudly, begging to be touched.", false);
					else outputText("  You smile and pull apart your lower-lips to expose your " + player.clitDescript() + ", giving the perfect view.", false);
					if (player.cockTotal() > 0) outputText("  Meanwhile, " + player.sMultiCockDesc() + " bobs back and forth with your gyrating hips, adding to the display.", false);
					//BONUSES!
					if (player.hasCock()) {
						if (player.findPerk(PerkLib.BulgeArmor) >= 0) damage += 5;
						penis = true;
					}
					vagina = true;
					break;
				//7 special Adjatha-crafted bend over bimbo times
				case 7:
					outputText("The glinting of light catches your eye and you whip around to inspect the glittering object, turning your back on " + monster.a + monster.short + ".  Locking your knees, you bend waaaaay over, " + player.chestDesc() + " swinging in the open air while your " + player.buttDescript() + " juts out at the " + monster.a + monster.short + ".  Your plump cheeks and " + player.hipDescript() + " form a jiggling heart-shape as you eagerly rub your thighs together.\n\n", false);
					outputText("The clear, warm fluid of your happy excitement trickles down from your loins, polishing your " + player.skin() + " to a glossy, inviting shine.  Retrieving the useless, though shiny, bauble, you hold your pose for just a moment longer, a sly little smile playing across your lips as you wiggle your cheeks one more time before straightening up and turning back around.", false);
					vagina = true;
					chance++;
					damage += 2;
					break;
				//==BRO STUFF=====
				//8 Pec Dance
				case 8:
					outputText("You place your hands on your hips and flex repeatedly, skillfully making your pecs alternatively bounce in a muscular dance.  ", false);
					if (player.findPerk(PerkLib.BroBrains) >= 0) outputText("Damn, " + monster.a + monster.short + " has got to love this!", false);
					else outputText(monster.capitalA + monster.short + " will probably enjoy the show, but you feel a bit silly doing this.", false);
					chance += (player.tone - 75)/5;
					damage += (player.tone - 70)/5;
					auto = false;
					break;
				//9 Heroic Pose
				case 9:
					outputText("You lift your arms and flex your incredibly muscular arms while flashing your most disarming smile.  ", false);
					if (player.findPerk(PerkLib.BroBrains) >= 0) outputText(monster.capitalA + monster.short + " can't resist such a heroic pose!", false);
					else outputText("At least the physical changes to your body are proving useful!", false);
					chance += (player.tone - 75)/5;
					damage += (player.tone - 70)/5;
					auto = false;
					break;
				//10 Bulgy groin thrust
				case 10:
					outputText("You lean back and pump your hips at " + monster.a + monster.short + " in an incredibly vulgar display.  The bulging, barely-contained outline of your " + player.cockDescript(0) + " presses hard into your gear.  ", false);
					if (player.findPerk(PerkLib.BroBrains) >= 0) outputText("No way could " + monster.pronoun1 + " resist your huge cock!", false);
					else outputText("This is so crude, but at the same time, you know it'll likely be effective.", false);
					outputText("  You go on like that, humping the air for your foe", false);
					outputText("'s", false);
					outputText(" benefit, trying to entice them with your man-meat.", false);
					if (player.findPerk(PerkLib.BulgeArmor) >= 0) damage += 5;
					penis = true;
					break;
				//11 Show off dick
				case 11:
					if (silly() && rand(2) == 0) outputText("You strike a herculean pose and flex, whispering, \"<i>Do you even lift?</i>\" to " + monster.a + monster.short + ".", false);
					else {
						outputText("You open your " + player.armorName + " just enough to let your " + player.cockDescript(0) + " and " + player.ballsDescriptLight() + " dangle free.  A shiny rope of pre-cum dangles from your cock, showing that your reproductive system is every bit as fit as the rest of you.  ", false);
						if (player.findPerk(PerkLib.BroBrains) >= 0) outputText("Bitches love a cum-leaking cock.", false);
						else outputText("You've got to admit, you look pretty good down there.", false);
					}
					if (player.findPerk(PerkLib.BulgeArmor) >= 0) damage += 5;
					penis = true;
					break;
				//==EXTRAS========
				//12 Cat flexibility.
				case 12:
					//CAT TEASE MOTHERFUCK (requires flexibility and legs [maybe can't do it with armor?])
					outputText("Reaching down, you grab an ankle and pull it backwards, looping it up and over to touch the foot to your " + player.hairDescript() + ".  You bring the leg out to the side, showing off your " + player.vaginaDescript(0) + " through your " + player.armorName + ".  The combination of the lack of discomfort on your face and the ease of which you're able to pose shows " + monster.a + monster.short + " how good of a time they're in for with you.", false);
					vagina = true;
					if (player.thickness < 33) chance++;
					else if (player.thickness >= 66) chance--;
					damage += (player.thickness - 50)/10;
					break;
				//13 Pregnant
				case 13:
					//PREG
					outputText("You lean back, feigning a swoon while pressing a hand on the small of your back.  The pose juts your huge, pregnant belly forward and makes the shiny spherical stomach look even bigger.  With a teasing groan, you rub the protruding tummy gently, biting your lip gently as you stare at " + monster.a + monster.short + " through heavily lidded eyes.  \"<i>All of this estrogen is making me frisky,</i>\" you moan, stroking hand gradually shifting to the southern hemisphere of your big baby-bump.", false);
					//if lactating] 
					if (player.biggestLactation() >= 1) {
						outputText("  Your other hand moves to expose your " + player.chestDesc() + ", cupping and squeezing a stream of milk to leak down the front of your " + player.armorName + ".  \"<i>Help a mommy out.</i>\"\n\n", false);
						chance += 2;
						damage += 4;
					}
					if (player.pregnancyIncubation < 100) {
						chance++;
						damage += 2;
					}
					if (player.pregnancyIncubation < 50) {
						chance++;
						damage += 2;
					}
					break;
				//14 Brood Mother
				case 14:
					if (rand(2) == 0) outputText("You tear open your " + player.armorName + " and slip a few fingers into your well-used birth canal, giving your opponent a good look at what they're missing.  \"<i>C'mon stud,</i>\" you say, voice dripping with lust and desire, \"<i>Come to mama " + player.short + " and fuck my pussy 'til your baby batter just POURS out.  I want your children inside of me, I want your spawn crawling out of this cunt and begging for my milk.  Come on, FUCK ME PREGNANT!</i>\"", false);
					else outputText("You wiggle your " + player.hipDescript() + " at your enemy, giving them a long, tantalizing look at the hips that have passed so very many offspring.  \"<i>Oh, like what you see, bad boy?  Well why don't you just come on over and stuff that cock inside me?  Give me your seed, and I'll give you suuuuch beautiful offspring.  Oh?  Does that turn you on?  It does!  Come on, just let loose and fuck me full of your babies!</i>\"", false);
					chance += 2;
					damage += 4;
					if (player.inHeat) {
						chance += 2;
						damage += 4;
					}
					vagina = true;
					break;
				//15 Nipplecunts
				case 15:
					//Req's tits & Pussy
					if (player.biggestTitSize() > 1 && player.hasVagina() && rand(2) == 0) {
						outputText("Closing your eyes, you lean forward and slip a hand under your " + player.armorName + ".  You let out the slightest of gasps as your fingers find your drooling honeypot, warm tips poking, one after another between your engorged lips.  When you withdraw your hand, your fingers have been soaked in the dripping passion of your cunny, translucent beads rolling down to wet your palm.  With your other hand, you pull down the top of your " + player.armorName + " and bare your " + player.chestDesc() + " to " + monster.a + monster.short + ".\n\n", false);
						outputText("Drawing your lust-slick hand to your " + player.nippleDescript(0) + "s, the yielding flesh of your cunt-like nipples parts before the teasing digits.  Using your own girl cum as added lubrication, you pump your fingers in and out of your nipples, moaning as you add progressively more digits until only your thumb remains to stroke the inflamed flesh of your over-stimulated chest.  Your throat releases the faintest squeak of your near-orgasmic delight and you pant, withdrawing your hands and readjusting your armor.\n\n", false);
						outputText("Despite how quiet you were, it's clear that every lewd, desperate noise you made was heard by " + monster.a + monster.short + ".", false);
						chance += 2;
						damage += 4;
					}
					else if (player.biggestTitSize() > 1 && rand(2) == 0) {
						outputText("You yank off the top of your " + player.armorName + ", revealing your " + player.chestDesc() + " and the gaping nipplecunts on each.  With a lusty smirk, you slip a pair of fingers into the nipples of your " + player.chestDesc() + ", pulling the nipplecunt lips wide, revealing the lengthy, tight passage within.  You fingerfuck your nipplecunts, giving your enemy a good show before pulling your armor back on, leaving the tantalizing image of your gaping titpussies to linger in your foe's mind.", false);
						chance += 1;
						damage += 2;
					}
					else outputText("You remove the front of your " + player.armorName + " exposing your " + player.chestDesc() + ".  Using both of your hands, you thrust two fingers into your nipple cunts, milky girl cum soaking your hands and fingers.  \"<i>Wouldn't you like to try out these holes too?</i>\"", false);
					breasts = true;
					break;
				//16 Anal gape
				case 16:
					outputText("You quickly strip out of your " + player.armorName + " and turn around, giving your " + player.buttDescript() + " a hard slap and showing your enemy the real prize: your " + player.assholeDescript() + ".  With a smirk, you easily plunge your hand inside, burying yourself up to the wrist inside your anus.  You give yourself a quick fisting, watching the enemy over your shoulder while you moan lustily, sure to give them a good show.  You withdraw your hand and give your ass another sexy spank before readying for combat again.", false);
					anus = true;
					ass = true;
					break;
				//17 Bee abdomen tease
				case 17:
					outputText("You swing around, shedding the " + player.armorName + " around your waist to expose your " + player.buttDescript() + " to " + monster.a + monster.short + ".  Taking up your oversized bee abdomen in both hands, you heft the thing and wave it about teasingly.  Drops of venom drip to and fro, a few coming dangerously close to " + monster.pronoun2 + ".  \"<i>Maybe if you behave well enough, I'll even drop a few eggs into your belly,</i>\" you say softly, dropping the abdomen back to dangle above your butt and redressing.", false);
					ass = true;
					chance += .5;
					damage += .5;
					break;			
				//18 DOG TEASE
				case 18:
					outputText("You sit down like a dog, your [legs] are spread apart, showing your ", false);
					if (player.hasVagina()) outputText("parted cunt-lips", false);
					else outputText("puckered asshole, hanging, erect maleness,", false);
					outputText(" and your hands on the ground in front of you.  You pant heavily with your tongue out and promise, \"<i>I'll be a good little bitch for you</i>.\"", false);
					vagina = true;
					chance += 1;
					damage += 2;
					break;
				//19 MAX FEM TEASE - SYMPHONIE
				case 19:
					outputText("You make sure to capture your foe's attention, then slowly and methodically allow your tongue to slide along your lush, full lips.  The glistening moisture that remains on their plump beauty speaks of deep lust and deeper throats.  Batting your long lashes a few times, you pucker them into a playful blown kiss, punctuating the act with a small moan. Your gorgeous feminine features hint at exciting, passionate moments together, able to excite others with just your face alone.", false);
					chance += 2;
					damage += 4;
					break;
				//20 MAX MASC TEASE
				case 20:
					outputText("As your foe regards you, you recognize their attention is fixated on your upper body.  Thrusting your strong jaw forward you show off your chiseled chin, handsome features marking you as a flawless specimen.  Rolling your broad shoulders, you nod your head at your enemy.  The strong, commanding presence you give off could melt the heart of an icy nun.  Your perfect masculinity speaks to your confidence, allowing you to excite others with just your face alone.", false);
					chance += 2;
					damage += 4;
					break;
				//21 MAX ADROGYN
				case 21:
					outputText("You reach up and run your hands down your delicate, androgynous features.  With the power of a man but the delicacy of a woman, looking into your eyes invites an air of enticing mystery.  You blow a brief kiss to your enemy while at the same time radiating a sexually exciting confidence.  No one could identify your gender by looking at your features, and the burning curiosity they encourage could excite others with just your face alone.", false);
					damage -= 3;
					break;
				//22 SPOIDAH SILK
				case 22:
					outputText("Reaching back, you milk some wet silk from your spider-y abdomen and present it to " + monster.a + monster.short + ", molding the sticky substance as " + monster.pronoun1 + " looks on curiously.  Within moments, you hold up a silken heart scuplture, and with a wink, you toss it at " + monster.pronoun2 + ". It sticks to " + monster.pronoun3 + " body, the sensation causing " + monster.pronoun2 + " to hastily slap the heart off.  " + monster.mf("He","She") + " returns " + monster.pronoun3 + " gaze to you to find you turned around, " + player.buttDescript() + " bared and abdomen bouncing lazily.  \"<i>I wonder what would happen if I webbed up your hole after I dropped some eggs inside?</i>\" you hiss mischievously.  " + monster.mf("He","She") + " gulps.", false);
					ass = true;
					break;
				//23 RUT TEASE
				case 23:
					if (player.countCocksOfType(CockTypesEnum.HORSE) > 0 && player.longestHorseCockLength() >= 12) {
						outputText("You whip out your massive horsecock, and are immediately surrounded by a massive, heady musk.  Your enemy swoons, nearly falling to her knees under your oderous assault.  Grinning, you grab her shoulders and force her to her knees.  Before she can defend herself, you slam your horsecock onto her head, running it up and down on her face, her nose acting like a sexy bump in an onahole.  You fuck her face -- literally -- for a moment before throwing her back and sheathing your cock.", false);
					}
					else {
						outputText("Panting with your unstoppable lust for the delicious, impregnable cunt before you, you yank off your " + player.armorName + " with strength born of your inhuman rut, and quickly wave your fully erect cock at your enemy.  She flashes with lust, quickly feeling the heady effect of your man-musk.  You rush up, taking advantage of her aroused state and grab her shoulders.  ", false);
						outputText("Before she can react, you push her down until she's level with your cock, and start to spin it in a circle, slapping her right in the face with your musky man-meat.  Her eyes swim, trying to follow your meatspin as you swat her in the face with your cock!  Satisfied, you release her and prepare to fight!", false);
					}
					penis = true;
					break;
				//24 STAFF POLEDANCE
				case 24:
					outputText("You run your tongue across your lips as you plant your staff into the ground.  Before your enemy can react, you spin onto the long, wooden shaft, using it like an impromptu pole.  You lean back against the planted staff, giving your enemy a good look at your body.  You stretch backwards like a cat, nearly touching your fingertips to the ground beneath you, now holding onto the staff with only one leg.  You pull yourself upright and give your " + player.buttDescript() + " a little slap and your " + player.chestDesc() + " a wiggle before pulling open your " + player.armorName + " and sliding the pole between your tits.  You drop down to a low crouch, only just covering your genitals with your hand as you shake your " + player.buttDescript() + " playfully.  You give the enemy a little smirk as you slip your " + player.armorName + " back on and pick up your staff.", false);
					ass = true;
					breasts = true;
					break;
				//TALL WOMAN TEASE
				case 25:
					outputText("You move close to your enemy, handily stepping over " + monster.pronoun3 + " defensive strike before leaning right down in " + monster.pronoun3 + " face, giving " + monster.pronoun2 + " a good long view at your cleavage.  \"<i>Hey, there, little " + monster.mf("guy","girl") + ",</i>\" you smile.  Before " + monster.pronoun1 + " can react, you grab " + monster.pronoun2 + " and smoosh " + monster.pronoun3 + " face into your " + player.allChestDesc() + ", nearly choking " + monster.pronoun2 + " in the canyon of your cleavage.  " + monster.mf("He","She") + " struggles for a moment.  You give " + monster.pronoun2 + " a little kiss on the head and step back, ready for combat.", false);
					breasts = true;
					chance += 2;
					damage += 4;
					break;
				//Magic Tease
				case 26:
					outputText("Seeing a lull in the battle, you plant your " + player.weaponName + " on the ground and let your magic flow through you.  You summon a trickle of magic into a thick, slowly growing black ball of lust.  You wave the ball in front of you, making a little dance and striptease out of the affair as you slowly saturate the area with latent sexual magics.", false);
					chance++;
					damage += 2;
					break;
				//Feeder
				case 27:
					outputText("You present your swollen breasts full of milk to " + monster.a + monster.short + " and say \"<i>Wouldn't you just love to lie back in my arms and enjoy what I have to offer you?</i>\"", false);
					breasts = true;
					chance ++;
					damage++;
					break;
				//28 FEMALE TEACHER COSTUME TEASE
				case 28:
					outputText("You turn to the side and give " + monster.a + monster.short + " a full view of your body.  You ask them if they're in need of a private lesson in lovemaking after class.", false);
					ass = true;
					break;
				//29 Male Teacher Outfit Tease
				case 29:
					outputText("You play with the strings on your outfit a bit and ask " + monster.a + monster.short + " just how much do they want to see their teacher pull them off?", false);
					chance++;
					damage += 3;
					break;
				//30 Naga Fetish Clothes
				case 30:
					outputText("You sway your body back and forth, and do an erotic dance for " + monster.a + monster.short + ".", false);
					chance += 2;
					damage += 4;
					break;
				//31 Centaur harness clothes
				case 31:
					outputText("You rear back, and declare that, \"<i>This horse is ready to ride, all night long!</i>\"", false);
					chance += 2;
					damage += 4;
					break;
				//32 Genderless servant clothes
				case 32:
					outputText("You turn your back to your foe, and flip up your butt flap for a moment.   Your " + player.buttDescript() + " really is all you have to offer downstairs.", false);
					ass = true;
					chance++;
					damage += 2;
					break;
				//33 Crotch Revealing Clothes (herm only?)
				case 33:
					outputText("You do a series of poses to accentuate what you've got on display with your crotch revealing clothes, while asking if your " + player.mf("master","mistress") + " is looking to sample what is on display.", false);
					chance += 2;
					damage += 4;
					break;
				//34 Maid Costume (female only)
				case 34:
					outputText("You give a rather explicit curtsey towards " + monster.a + monster.short + " and ask them if your " + player.mf("master","mistress") + " is interested in other services today.", false);
					chance ++;
					damage += 2;
					breasts = true;
					break;
				//35 Servant Boy Clothes (male only)
				case 35:
					outputText("You brush aside your crotch flap for a moment, then ask " + monster.a + monster.short + " if, " + player.mf("Master","Mistress") + " would like you to use your " + player.multiCockDescriptLight() + " on them?", false);
					penis = true;
					chance++;
					damage += 2;
					break;
				//36 Bondage Patient Clothes (done):
				case 36:
					outputText("You pull back one of the straps on your bondage cloths and let it snap back.  \"<i>I need some medical care, feeling up for it?</i>\" you tease.", false);
					damage+= 2;
					chance++;
					break;
				default:
					outputText("You shimmy and shake sensually. (An error occurred.)", false);
					break;
				case 37:
					outputText("You purse your lips coyly, narrowing your eyes mischievously and beckoning to " + monster.a + monster.short + " with a burning come-hither glare.  Sauntering forward, you pop your hip to the side and strike a coquettish pose, running " + ((player.tailVenom > 1) ? "one of your tails" : "your tail") + " up and down " + monster.pronoun3 + " body sensually.");
					chance+= 6;
					damage+= 3;
					break;
				case 38:
					outputText( "You wet your lips, narrowing your eyes into a smoldering, hungry gaze.  Licking the tip of your index finger, you trail it slowly and sensually down the front of your " + player.armorName + ", following the line of your " + player.chestDesc() + " teasingly.  You hook your thumbs into your top and shimmy it downward at an agonizingly slow pace.  The very instant that your [nipples] pop free, your tail crosses in front, obscuring " + monster.a + monster.short + "'s view.");
					breasts = true;
					chance++;
					damage++;
					break;
				case 39:
					outputText( "Leaning forward, you bow down low, raising a hand up to your lips and blowing " + monster.a + monster.short + " a kiss.  You stand straight, wiggling your " + player.hipDescript() + " back and forth seductively while trailing your fingers down your front slowly, pouting demurely.  The tip of ");
					if (player.tailVenom == 1) outputText("your");
					else outputText("a");
					outputText(" bushy tail curls up around your " + player.leg() + ", uncoiling with a whipping motion that makes an audible crack in the air.");
					ass = true;
					chance++;
					damage += 1;
					break;
				case 40:
					outputText("Turning around, you stare demurely over your shoulder at " + monster.a + monster.short + ", batting your eyelashes amorously.");
					if (player.tailVenom == 1) outputText("  Your tail twists and whips about, sliding around your " + player.hipDescript() + " in a slow arc and framing your rear nicely as you slowly lift your " + player.armorName + ".");
					else outputText("  Your tails fan out, twisting and whipping sensually, sliding up and down your " + player.legs() + " and framing your rear nicely as you slowly lift your " + player.armorName + ".");
					outputText("  As your [butt] comes into view, you brush your tail" + ((player.tailVenom > 1) ? "s" : "" ) + " across it, partially obscuring the view in a tantalizingly teasing display.");
					ass = true;
					anus = true;
					chance++;
					damage += 2;
					break;
				case 41:
					outputText( "Smirking coyly, you sway from side to side, running your tongue along your upper teeth seductively.  You hook your thumbs into your " + player.armorName + " and pull them away to partially reveal ");
					if (player.cockTotal() > 0) outputText(player.sMultiCockDesc());
					if (player.gender == 3) outputText(" and ");
					if (player.gender >= 2) outputText("your " + player.vaginaDescript(0));
					outputText(".  Your bushy tail" + ((player.tailVenom > 1) ? "s" : "" ) + " cross" + ((player.tailVenom > 1) ? "": "es") + " in front, wrapping around your genitals and obscuring the view teasingly.");
					vagina = true;
					penis = true;
					damage += 2;
					chance++;
					break;
				case 42:
					//Tease #1:
					if (rand(2) == 0) {
						outputText("You lift your skirt and flash your king-sized stallionhood, already unsheathing itself and drooling pre, at your opponent.  \"<i>Come on, then; I got plenty of girlcock for you if that's what you want!</i>\" you cry.");
						penis = true;
						damage += 3;
						chance--;
					}
					//Tease #2:
					else {
						outputText("You turn partially around and then bend over, swaying your tail from side to side in your most flirtatious manner and wiggling your hips seductively, your skirt fluttering with the motions.  \"<i>Come on then, what are you waiting for?  This is a fine piece of ass here,</i>\" you grin, spanking yourself with an audible slap.");
						ass = true;
						chance+= 2;
						damage += 3;
					}
					break;
				case 43:
					var cows:int = rand(7);
					if (cows == 0) {
						outputText("You tuck your hands under your chin and use your arms to squeeze your massive, heavy breasts together.  Milk squirts from your erect nipples, filling the air with a rich, sweet scent.");
						breasts = true;
						chance += 2;
						damage++;
					}
					else if (cows == 1) {
						outputText("Moaning, you bend forward, your full breasts nearly touching the ground as you sway your [hips] from side to side.  Looking up from under heavily-lidded eyes, you part your lips and lick them, letting out a low, lustful \"<i>Mooooo...</i>\"");
						breasts = true;
						chance += 2;
						damage += 2;
					}
					else if (cows == 2) {
						outputText("You tuck a finger to your lips, blinking innocently, then flick your tail, wafting the scent of your ");
						if (player.wetness() >= 3) outputText("dripping ");
						outputText("sex through the air.");
						vagina = true;
						chance++;
						damage++;
					}
					else if (cows == 3) {
						outputText("You heft your breasts, fingers splayed across your [nipples] as you SQUEEZE.  Milk runs in rivulets over your hands and down the massive curves of your breasts, soaking your front with sweet, sticky milk.");
						breasts = true;
						chance += 3;
						damage++;
					}
					else if (cows == 4) {
						outputText("You lift a massive breast to your mouth, suckling loudly at yourself, finally letting go of your nipple with a POP and a loud, satisfied gasp, milk running down your chin.");
						breasts = true;
						chance++;
						damage += 3;
					}
					else if (cows == 5) {
						outputText("You crouch low, letting your breasts dangle in front of you.  Each hand caresses one in turn as you slowly milk yourself onto your thighs, splashing white, creamy milk over your hips and sex.");
						vagina = true;
						breasts = true;
						chance++;
					}
					else {
						outputText("You lift a breast to your mouth, taking a deep draught of your own milk, then tilt your head back.  With a low moan, you let it run down your front, winding a path between your breasts until it drips sweetly from your crotch.");
						vagina = true;
						breasts = true;
						damage += 2;
					}
					if (monster.short.indexOf("minotaur") != -1) {
						damage += 6;
						chance += 3;
					}
					break;
				//lusty maiden's armor teases
				case 44:
					var maiden:int = rand(5);
					damage += 5;
					chance += 3;
					if (maiden == 0) {
						outputText("Confidently sauntering forward, you thrust your chest out with your back arched in order to enhance your [chest].  You slowly begin to shake your torso back and forth, slapping your chain-clad breasts against each other again and again.  One of your hands finds its way to one of the pillowy expanses and grabs hold, fingers sinking into the soft tit through the fine, mail covering.  You stop your shaking to trace a finger down through the exposed center of your cleavage, asking, \"<i>Don't you just want to snuggle inside?</i>\"");
						breasts = true;
					}
					else if (maiden == 1) {
						outputText("You skip up to " + monster.a + monster.short + " and spin around to rub your barely-covered butt up against " + monster.pronoun2 + ".  Before " + monster.pronoun1 + " can react, you're slowly bouncing your [butt] up and down against " + monster.pronoun3 + " groin.  When " + monster.pronoun1 + " reaches down, you grab " + monster.pronoun3 + " hand and press it up, under your skirt, right against the steamy seal on your sex.  The simmering heat of your overwhelming lust burns hot enough for " + monster.pronoun2 + " to feel even through the contoured leather, and you let " + monster.pronoun2 + " trace the inside of your [leg] for a moment before moving away, laughing playfully.");
						ass = true;
						vagina = true;
					}
					else if (maiden == 2) {
						outputText("You flip up the barely-modest chain you call a skirt and expose your g-string to " +  monster.a + monster.short + ".  Slowly swaying your [hips], you press a finger down on the creased crotch plate and exaggerate a lascivious moan into a throaty purr of enticing, sexual bliss.  Your eyes meet " + monster.pronoun3 + ", and you throatily whisper, \"<i>");
						if (player.hasVirginVagina()) outputText("Think you can handle a virgin's infinite lust?");
						else outputText("Think you have what it takes to satisfy this perfect pussy?");
						outputText("</i>\"");
						vagina = true;
						damage += 3;
					}
					else if (maiden == 3) {
						outputText("You seductively wiggle your way up to " + monster.a + monster.short + ", and before " + monster.pronoun1 + " can react to your salacious advance, you snap a [leg] up in what would be a vicious kick, if you weren't simply raising it to rest your [foot] on " + monster.pronoun3 + " shoulder.  With your thighs so perfectly spready, your skirt is lifted, and " + monster.a + monster.short + " is given a perfect view of your thong-enhanced cameltoe and the moisture that beads at the edges of your not-so-modest covering.");
						vagina = true;
					}
					else {
						outputText("Bending over, you lift your [butt] high in the air.  Most of your barely-covered tush is exposed, but the hem of your chainmail skirt still protects some of your anal modesty.  That doesn't last long.  You start shaking your [butt] up, down, back, and forth to an unheard rhythm, flipping the pointless covering out of the way so that " + monster.a + monster.short + " can gaze upon your curvy behind in it all its splendid detail.  A part of you hopes that " + monster.pronoun1 + " takes in the intricate filigree on the back of your thong, though to " + monster.pronoun2 + " it looks like a bunch of glittering arrows on an alabaster background, all pointing squarely at your [asshole].");
						ass = true;
						chance += 2;
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
					switch(partChooser[rand(partChooser.length)]) {
						case 0:
							outputText("You place your hand on your lethicite-covered belly, move your hand up across your belly and towards your [chest]. Taking advantage of the small openings in your breastplate, you pinch and tweak your exposed [nipples].");
							breasts = true;
							chance += 3;
							damage += 1;
							break;
						case 1:
							outputText("You move your hand towards your [cocks], unobstructed by the lethicite. You give your [cock] a good stroke and sway your hips back and forth, emphasizing your manhood.");
							penis = true;
							chance += 1;
							damage += 2;
							break;
						case 2:
							outputText("You move your hand towards your [pussy], unobstructed by the lethicite. You give your [clit] a good tease, finger your [pussy], and sway your hips back and forth, emphasizing your womanhood.");
							vagina = true;
							chance += 1;
							damage += 2;
							break;
						case 3:
							outputText("You move your hand towards your [cocks] and [pussy], unobstructed by the lethicite. You give your [cock] a good stroke, tease your [clit], and sway your hips back and forth, emphasizing your hermaphroditic gender.");
							penis = true;
							vagina = true;
							chance += 1;
							damage += 3;
							break;
						default:
							outputText("Whoops, something derped! Please let Kitteh6660 know! Anyways, you put on a tease show.");
					}
					
					break;
			}
			//===========================
			//BUILD BONUSES IF APPLICABLE
			//===========================	
			var bonusChance:Number = 0;
			var bonusDamage:Number = 0;
			if (auto) {
				//TIT BONUSES
				if (breasts) {
					if (player.bRows() > 1) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.bRows() > 2) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.bRows() > 4) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestLactation() >= 2) {
						bonusChance++;
						bonusDamage += 2;
					}
					if (player.biggestLactation() >= 3) {
						bonusChance++;
						bonusDamage += 2;
					}
					if (player.biggestTitSize() >= 4) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestTitSize() >= 7) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestTitSize() >= 12) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestTitSize() >= 25) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestTitSize() >= 50) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hasFuckableNipples()) {
						bonusChance++;
						bonusDamage += 2;
					}
					if (player.averageNipplesPerBreast() > 1) {
						bonusChance++;
						bonusDamage += 2;
					}
				}
				//PUSSY BONUSES
				if (vagina) {
					if (player.hasVagina() && player.wetness() >= 2) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hasVagina() && player.wetness() >= 3) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hasVagina() && player.wetness() >= 4) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hasVagina() && player.wetness() >= 5) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.clitLength > 1.5) {
						bonusChance += .5;
						bonusDamage++;
					}
					if (player.clitLength > 3.5) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.clitLength > 7) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.clitLength > 12) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.vaginalCapacity() >= 30) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.vaginalCapacity() >= 70) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.vaginalCapacity() >= 120) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.vaginalCapacity() >= 200) {
						bonusChance += .5;
						bonusDamage += 1;
					}
				}
				//Penis bonuses!
				if (penis) {
					if (player.cockTotal() > 1) {
						bonusChance += 1;
						bonusDamage += 2;
					}
					if (player.biggestCockArea() >= 15) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestCockArea() >= 30) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestCockArea() >= 60) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.biggestCockArea() >= 120) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.cumQ() >= 50) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.cumQ() >= 150) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.cumQ() >= 300) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.cumQ() >= 1000) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (balls > 0) {
						if (player.balls > 2) {
							bonusChance += 1;
							bonusDamage += 2;
						}
						if (player.ballSize > 3) {
							bonusChance += .5;
							bonusDamage += 1;
						}
						if (player.ballSize > 7) {
							bonusChance += .5;
							bonusDamage += 1;
						}
						if (player.ballSize > 12) {
							bonusChance += .5;
							bonusDamage += 1;
						}
					}
					if (player.biggestCockArea() < 8) {
						bonusChance--;
						bonusDamage-=2;
						if (player.biggestCockArea() < 5) {
							bonusChance--;
							bonusDamage-=2;
						}
					}
				}
				if (ass) {
					if (player.buttRating >= 6) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.buttRating >= 10) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.buttRating >= 13) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.buttRating >= 16) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.buttRating >= 20) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hipRating >= 6) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hipRating >= 10) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hipRating >= 13) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hipRating >= 16) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.hipRating >= 20) {
						bonusChance += .5;
						bonusDamage += 1;
					}
				}
				if (anus) {
					if (player.ass.analLooseness == 0) {
						bonusChance += 1.5;
						bonusDamage += 3;
					}
					if (player.ass.analWetness > 0) {
						bonusChance += 1;
						bonusDamage += 2;
					}
					if (player.analCapacity() >= 30) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.analCapacity() >= 70) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.analCapacity() >= 120) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.analCapacity() >= 200) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.ass.analLooseness == 4) {
						bonusChance += .5;
						bonusDamage += 1;
					}
					if (player.ass.analLooseness == 5) {
						bonusChance += 1.5;
						bonusDamage += 3;
					}
				}
				//Trim it down!
				if (bonusChance > 5) bonusChance = 5;
				if (bonusDamage > 10) bonusDamage = 10;
			}
			//Land the hit!
			if (rand(100) <= chance + rand(bonusChance)) {
				//NERF TEASE DAMAGE
				damage *= .7;
				bonusDamage *= .7;
				if (player.findPerk(PerkLib.HistoryWhore) >= 0) {
					damage *= 1.15;
					bonusDamage *= 1.15;
				}
				if (player.findPerk(PerkLib.ChiReflowLust) >= 0) damage *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
				if (monster.plural) damage *= 1.3;
				damage = (damage + rand(bonusDamage)) * monster.lustVuln;
				
				if (monster is JeanClaude) (monster as JeanClaude).handleTease(damage, true);
				else if (monster is Doppleganger && monster.findStatusEffect(StatusEffects.Stunned) < 0) (monster as Doppleganger).mirrorTease(damage, true);
				else if (!justText) monster.teased(damage);
				
				if (flags[kFLAGS.PC_FETISH] >= 1 && !getGame().urtaQuest.isUrta()) 
				{
					if (player.lust < 75) outputText("\nFlaunting your body in such a way gets you a little hot and bothered.", false);
					else outputText("\nIf you keep exposing yourself you're going to get too horny to fight back.  This exhibitionism fetish makes it hard to resist just stripping naked and giving up.", false);
					if (!justText) dynStats("lus", 2 + rand(3));
				}
				
				// Similar to fetish check, only add XP if the player IS the player...
				if (!justText && !getGame().urtaQuest.isUrta()) teaseXP(1);
			}
			//Nuttin honey
			else {
				if (!justText && !getGame().urtaQuest.isUrta()) teaseXP(5);
				
				if (monster is JeanClaude) (monster as JeanClaude).handleTease(0, false);
				else if (monster is Doppleganger) (monster as Doppleganger).mirrorTease(0, false);
				else if (!justText) outputText("\n" + monster.capitalA + monster.short + " seems unimpressed.", false);
			}
			outputText("\n\n", false);
			flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		}

		public function teaseXP(XP:Number = 0):void {
			while(XP > 0) {
				XP--;
				player.teaseXP++;
				//Level dat shit up!
				if (player.teaseLevel < 5 && player.teaseXP >= 10 + (player.teaseLevel + 1) * 5 * (player.teaseLevel + 1)) {
					outputText("\n<b>Tease skill leveled up to " + (player.teaseLevel + 1) + "!</b>", false);
					player.teaseLevel++;
					player.teaseXP = 0;
				}
			}
		}
		
	}

}