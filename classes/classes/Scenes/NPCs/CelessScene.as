package classes.Scenes.NPCs {
import classes.CoC;
import classes.EventParser;
import classes.ItemType;
import classes.PregnancyStore;
import classes.Scenes.Camp;
import classes.Scenes.Areas.Forest.Nightmare;
import classes.StatusEffects.HeatEffect;
import classes.TimeAwareInterface;
import classes.PerkLib;
import classes.BodyParts.Horns;
import classes.BodyParts.Wings;
import classes.StatusEffects;
import classes.display.SpriteDb;

import coc.view.ButtonDataList;

import flash.utils.getQualifiedClassName;

/**
 * ...
 * @author Oxdeception, aimozg, Ormael
 */
public class CelessScene extends XXCNPC implements TimeAwareInterface {
	private static const _ageIsAdult:int = -1;
	private static const _ageShouldDoBirth:int = -2;
	private static const _ageCanMeetNightmare:int = -3;
	private static const _ageDidPregnancy:int = -4;
	private static const _ageIsDeadOrRemoved:int = -5;

	private static var _instance:CelessScene;

	public static function get instance():CelessScene {
		if (!_instance) {
			new CelessScene();
		}
		return _instance;
	}

	public static function canMeetUnicorn():Boolean {
		return (
				CoC.instance.player.level >= 10
				&& !CoC.instance.player.isPregnant()
				&& !instance.armorFound
				&& (instance._age == 0 || instance._age < -1)
		);
	}

	public static function canGetArmour():Boolean {
		return instance.isCompanion() && !instance.armorFound;
	}

	private static function playerIsVirgin():Boolean {
		return CoC.instance.player.hasVirginVagina() ||
		       ((CoC.instance.player.isMale() || CoC.instance.player.isGenderless()) &&
		        CoC.instance.player.ass.analLooseness == 0);
	}

	public static function canMeetNightmare():Boolean {
		return instance._age == _ageCanMeetNightmare;
	}

	public function CelessScene() {
		if (!_instance) {
			super("celess");
			EventParser.timeAwareClassAdd(this);
			Camp.addFollower(this);
			_instance = this;
			addSavedNPC(this);
		}
		else {
			throw new Error("Singleton. Use instance to access");
		}
	}

	private var _age:int = 0;
	private var _corruption:int = 0;
	private var _name:String = "Celess";

	override public function get Name():String {
		return _name;
	}

	private var _armorFound:Boolean = false;

	public function get armorFound():Boolean {
		return _armorFound;
	}

	public function get isCorrupt():Boolean {
		return _corruption > 39;
	}

	public function get isAdult():Boolean {
		return _age == _ageIsAdult;
	}

	public function setDeadOrRemoved():void {
		_age = _ageIsDeadOrRemoved;
	}

	public override function unload():void {
		EventParser.timeAwareClassRemove(_instance);
		Camp.removeFollower(_instance);
		_instance = null;
	}

	public override function save(saveto:*):void {
		saveto.celess = {
			myClass: getQualifiedClassName(this),
			age: _age,
			corruption: _corruption,
			name: _name,
			armorFound: _armorFound
		}
	}

	//endregion

	public override function load(loadfrom:*):void {
		if (loadfrom == undefined || loadfrom.celess == undefined) {
			unload();
		}
		else {
			_age = loadfrom.celess.age;
			_corruption = loadfrom.celess.corruption;
			_name = loadfrom.celess.name;
			_armorFound = loadfrom.celess.armorFound;
		}
	}

	public override function checkCampEvent():Boolean {
		if (_age == _ageShouldDoBirth) {
			birthScene();
			hideMenus();
			return true;
		}
		return false;
	}

	override public function isCompanion(type:int = -1):Boolean {
		if (type == COMPANION || type == FOLLOWER) return _age > 0 || _age == _ageIsAdult;
		return false;
	}

	override public function campDescription(buttons:ButtonDataList, menuType:int = -1):void {
		if (isCompanion(menuType)) {
			outputText(Name + " is currently resting on all four in the nearby grassland area.\n\n");
			buttons.add(Name, campInteraction);
		}
	}

	public override function campInteraction():void {
		if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
		if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
		clearOutput();
		doNext(camp.returnToCampUseOneHour);
		display("strings/campInteraction", myLocals);
		addButton(0, "Appearance", scene, "strings/appearance", myLocals, campInteraction);
		if (isAdult) {
			if (isCorrupt || player.cor >= 20) {
				addButton(1, "Incest", incestMenu);
			}
			addButton(2, "Items", itemImproveMenu);
		}
		else {
			addButton(1, "Play Time", playTime);
		}
		addButton(14, "Back", camp.campFollowers);
		flushOutputTextToGUI();

		function incestMenu():void {
			if (isCorrupt) {
				clearOutput();
				var menu:ButtonDataList = new ButtonDataList();
				display("strings/incest/corruptMenu", myLocals);
				menu.add("Suck her off", curry(incestScene, "suckHerOff"));
				menu.add("Fuck Her", curry(incestScene, "fuckHer")).disableIf(!player.isMaleOrHerm());
				menu.add("Get Fucked", curry(incestScene, "getFucked")).disableIf(!player.isFemaleOrHerm());
				submenu(menu, campInteraction);
			}
			else {
				pureIncest();
			}
		}
	}

	private function playTime():void {
		var locals:* = myLocals;
		locals["$dangerousPlants"] = player.hasKeyItem("Dangerous Plants") >= 0;
		clearOutput();
		if (isCorrupt){
			outputText(""+_name+" seems somewhat bored, and it occurs to you that being a mother comes before being the Champion." +
					"You decide to bring your girl on an excursion, but the pair of you stumble upon a gang of imps." +
					"You defeat them all to keep your daughter safe, but as you prepare to leave, you’re suddenly hit by a splash on your back." +
					"You turn around and notice "+_name+" is making a naughty smile, holding one of the imps by the dick, the other hand on his torso.\n\n<i>“Tehehe. Got you, mom.”</i>\n\nOoooh reeeeally? Well then, it’s time you teach your daughter a lesson! " +
					"You pick one of the imps and grab him by the cock, pumping to make him shoot his cum at your daughter, who laughs as this turn into an all out impshot battle. " +
					"Imp cum is soon splashing everywhere in the forest, the both of you using trees and bushes as cover. Eventually, you and "+_name+" are covered in so much cum her black fur almost appears white. " +
					"After a few hours of this, the both of you head back to camp, still laughing.");
		}
		else
		{
			outputText("You spend some time with your beloved daughter in the forest. " +
					"The pair of you eventually stumble upon a grove filled with blooming white flowers which she happily gallops towards to in order to smell.\n\n"+
					"<i>“Mom, they smell <b>so</b> good! Are they blooming all the time like this?”</i>\n\n" +
					"You admit that you don’t know, as Mareth’s time and space is distorted and difficult to predict at the best of times. ");
			if(player.inte > 60){
				outputText("Although you could give a rough estimate if you brought the right tools, some books on Mareth’s local botany would also help");
				if(player.hasKeyItem("Dangerous Plants") >= 0){
					outputText(", the only thing you have is that one book from the traveling merchant, but it focuses more on the signs of the more dangerous ones and how to avoid them rather than their life cycle")
				}
			}
			outputText(".\n\n");
			outputText("She doesn't seem to mind, though. Apparently more interested in playing, the both of you play tag, hide and seek and other such innocent games in the grove. " +
					"However, an unwanted visitor shows up before the end of the last game. " +
					"The imp, because it’s clearly an imp, is masturbating, intent on spreading his filth on the flowers. " +
					"This happening in front of your daughter is <i>unacceptable</i>. " +
					"You tell her to go play on the other side for a while, so as to allow you to discreetly take care of the annoying little bugger before he has the chance to damage the grove and "+_name+"’s innocence. " +
					"You make sure to dispose of the body properly, not wanting to risk your daughter stumbling upon it and winding up traumatized. That taken care of, you go back to playing with your daughter.\n\n" +
					"The time passes and eventually both of you head back to camp, your daughter still sporting a wide smile from all the fun she had, none the wiser about your little altercation with that moron of an imp.\n\n" +
					"As innocent as a day can be in Mareth, even if you had to force the issue. But if it’s for the sake of your daughter having a happy childhood, you would gladly beat this whole crazy realm into submission.")
		}
		_age+=72;
		doNext(camp.returnToCampUseOneHour);
	}


	private function pureIncest():void {
		clearOutput();
		outputText("No matter how weird a parent you might be, you just can’t find the resolve to fuck your innocent daughter. ");
				if(player.cor > 20) outputText("Just as you're about to dismiss the idea completely, "+_name+" surprises you.</if>\n\n");
				outputText("<i>“MOM! HELP! ITS BACK!</i>\n\n" +
				"You watch, spellbound, as "+_name+"’s massive shaft rises to full mast, throbbing and leaking a steady stream of precum already. Clearly, "+_name+" has no idea about how to get it to calm down. " +
				"It seems the job falls to you.\n\n" +
				"<i>“I can’t hold this thing anymore. Please, mom, do something!”</i>\n\n" +
				"This is a… somewhat unusual situation, but as a ");
				if (player.gender == 1) outputText("male ");
				if (player.gender == 2) outputText("parent ");
				if (player.gender == 3) outputText("herm like her ");
				outputText("it’s something you can understand. You approach your girl’s massive tool and give it a few experimental strokes, making "+_name+" gasp in surprise. " +
				"You lick the flared tip to get a taste. Satisfied with it you then proceed to put the thing in your mouth proper. <output>$name</output> moans as her horse dong throbs in appreciation for the attention you’re giving it.\n\n" +
				"<i>“Eep!!! Mom, I’m scared. It feels all weird... S..something is comiiiiiiing!”</i>\n\n" +
				""+_name+" whines as she finally orgasms, her sweet cum flooding your throat. It tastes like cake icing, making it an exercise on willpower to keep from desperately trying to get more. " +
				"As her erection finally dies down, you feel something change in you as the cum reaches your stomach.");
		CelessGoIntoHeatRut();
		doNext(camp.returnToCampUseOneHour);
	}

	public function CelessGoIntoHeatRut():void{
		outputText("Lewd images of cocks ");
		if (player.hasCock()) outputText("and vaginas");
		outputText("of all sizes and shapes fill your mind, making you drool in anticipation. It seems your daughter’s condition is spreading over to you.");
		if (player.hasCock() || (player.gender == 3 && rand(2) == 0)) player.goIntoRut(true);
		else if (player.hasVagina()) player.goIntoHeat(true);
	}

		//region INTERFACE classes.TimeAwareInterface
	public function timeChange():Boolean {
		if (_age > 0) {
			_age++;
		}
		return false;
	}

	public function timeChangeLarge():Boolean {
		if (_age > 720) {
			growUpScene();
			_age = _ageIsAdult;
			EventParser.timeAwareClassRemove(instance);
			return true;
		}
		return false;
	}

	public function findArmor():void {
		instance._armorFound = true;
	}

    public function birthScene():void {
		if (_age != _ageShouldDoBirth) {
			_age = _ageShouldDoBirth;
		}
		else {
			if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
			if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
			mainView.nameBox.text = "";
			scene("strings/birth/intro", null, nameScene);
		}
		function nameScene():void {
			if (mainView.nameBox.text == "") {
				clearOutput();
				outputText("\n\n\n<b>You must name her.</b>");
				mainView.nameBox.text = "Celess";
				mainView.nameBox.visible = true;
				mainView.nameBox.width = 165;
				mainView.nameBox.x = mainView.mainText.x + 5;
				mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
				doNext(nameScene);
				return;
			}
			_age = 1;
			_name = mainView.nameBox.text;
			_corruption = 0;
			if (player.cor > ((80 + player.corruptionTolerance()) / 2)) {
				_corruption = 100;
			}
			mainView.nameBox.visible = false;
			scene("strings/birth/nameScene", myLocals, camp.returnToCampUseFourHours);
		}
	}

	public function itemImproveMenu():void {
		if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
		if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
		var improvableItems:Array = [
			[weapons.BFSWORD, weapons.NPHBLDE, weapons.EBNYBLD],
			[weapons.MASTGLO, weapons.KARMTOU, weapons.YAMARG],
			[weapons.KATANA, weapons.MASAMUN, weapons.BLETTER],
			[weapons.W_STAFF, weapons.U_STAFF, weapons.N_STAFF],
			//	[weapons.DEMSCYT,		weapons.LHSCYTH,		null],
			[weapons.UGATANA, weapons.MOONLIT, weapons.C_BLADE],
			[weapons.L__AXE, weapons.WG_GAXE, weapons.DE_GAXE],
			[weapons.SPEAR, weapons.SESPEAR, weapons.DSSPEAR],
			[weapons.JRAPIER, weapons.Q_GUARD, weapons.B_WIDOW],
			[weapons.OTETSU, weapons.POCDEST, weapons.DOCDEST],
			[weaponsrange.BOWLONG, weaponsrange.ARTEMIS, weaponsrange.WILDHUN],
			[weaponsrange.SHUNHAR, weaponsrange.KSLHARP, weaponsrange.LEVHARP],
			[shields.SANCTYN, shields.SANCTYL, shields.SANCTYD]//,
			//	[armors.CTPALAD,		null,					armors.CTBGUAR],
			//	[armors.LMARMOR,		armors.,			armors.]
		];
		clearOutput();
		outputText("<b>"+_name+" can empower items using materials gems and her innate magic to bless/corrupt gear. Would you like her to create an epic item and in that case which?</b>");// legendary
//Celess
		var selectfrom:int = isCorrupt ? 2 : 1;
		var selectMenu:ButtonDataList = new ButtonDataList();
		for (var i:int = 0; i < improvableItems.length; i++) {
			if (improvableItems[i][selectfrom] == null) {/*do nothing*/
			}
			else {
				var item:ItemType = improvableItems[i][selectfrom];
				var from:ItemType = improvableItems[i][0];
				selectMenu.add(item.id, curry(improveItem, item, from)).disableIf(!player.hasItem(from));
			}
		}
		submenu(selectMenu, campInteraction);

		function improveItem(item:ItemType, from:ItemType):void {
			scene("strings/itemImprove/improveThatItem", myLocals);
			player.destroyItems(from, 1);
			inventory.takeItem(item, camp.returnToCampUseOneHour);
		}
	}

	public function celessUnicornIntro():void {
		spriteSelect(SpriteDb.s_celessWhite);
		if (player.hasPerk(PerkLib.BicornBlessing)) {
			outputText("No matter how much you try to you cannot find the grove where the holy shield rest. It seems that the barriers are keeping you at bay now.");
			doNext(camp.returnToCampUseOneHour);	
			return;
		}
		if (player.hasStatusEffect(StatusEffects.CanMeetNightmare)) {
			display("strings/forest-unicorn/intro/introAfterNightmare");
			menu();
			addButton(0, "Back", camp.returnToCampUseOneHour);
			if (player.hasKeyItem("Nightmare Horns") >= 0) addButton(1, "Show proof", celessUnicornIntro2);
			else addButtonDisabled(1, "Show proof", "Req. to have Nightmare Horns.");
			return;
		}
		celessUnicornIntro1();
	}
	private function celessUnicornIntro1(stage1:int = 0, wasMale:Boolean = false):void {
		spriteSelect(SpriteDb.s_celessWhite);
		switch (stage1) {
			case 0:
				scene("strings/forest-unicorn/intro/intro");
				if (playerIsVirgin()) {
					display("strings/forest-unicorn/intro/virgin");
					menu();
					addButton(0, "Okay", celessUnicornIntro1, (player.isMale() || player.isGenderless()) ? 2 : 3);
					if (player.hasCock()) {
						addButton(1, "Fuck Her", celessUnicornIntro1, 4);
					}
					addButton(5, "NoWay", celessUnicornIntro1, 1);
				} else {
					display("strings/forest-unicorn/intro/noVirgin");
					player.createStatusEffect(StatusEffects.CanMeetNightmare,0,0,0,0);
					_age = _ageCanMeetNightmare;
					doNext(camp.returnToCampUseOneHour);
				}
				break;
			case 1:
				scene("strings/forest-unicorn/noway");
				doNext(camp.returnToCampUseOneHour);
				break;
			case 2:
				if (player.bRows() == 0) {
					player.createBreastRow();
				}
				player.growTits(3, 1, false, 1);
				scene("strings/forest-unicorn/okay-male");
				if (player.hasCock()) player.killCocks(1);
				if (player.balls > 0) {
					player.balls = 0;
                    player.ballSize = 0;
				}
				if (player.butt.type < 6) player.butt.type = 6;
				if (player.hips.type < 6) player.hips.type = 6;
				if (player.hairLength < 10) player.hairLength += 10;
				if (player.thickness < 70) player.thickness = 70;
				if (player.tone > 30) player.tone = 30;
				player.fertility += 10;
				player.createVagina();
                player.clitLength = .25;
				addButton(0, "Next", celessUnicornIntro1, 3, true);
				break;
			case 3:
				scene("strings/forest-unicorn/okay-female", { $wasMale: wasMale, $isTaur: player.isTaur() } );
				if (player.hasKeyItem("Nightmare Horns") >= 0) player.removeKeyItem("Nightmare Horns");
				player.createPerk(PerkLib.UnicornBlessing, 0, 0, 0, 0);
				player.cor = 0;
				player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				_age = _ageDidPregnancy;
				break;
			case 4:
				scene("strings/forest-unicorn/fuck-her");
				if (player.hasKeyItem("Nightmare Horns")) player.removeKeyItem("Nightmare Horns");
				findArmor();
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				break;
		}
	}
	private function celessUnicornIntro2(stage2:int = 0, wasMale:Boolean = false):void {
		spriteSelect(SpriteDb.s_celessWhite);
		switch (stage2) {
			case 0:
				scene("strings/forest-unicorn/intro/introAfterNightmareShowProof");
				menu();
				addButton(0, "Okay", celessUnicornIntro2, (player.isMale() || player.isGenderless()) ? 2 : 3);
				if (player.hasCock()) {
					addButton(1, "Fuck Her", celessUnicornIntro2, 4);
				}
				addButton(5, "NoWay", celessUnicornIntro2, 1);
				break;
			case 1:
				scene("strings/forest-unicorn/noway");
				doNext(camp.returnToCampUseOneHour);
				break;
			case 2:
				if (player.bRows() == 0) {
					player.createBreastRow();
				}
				player.growTits(3, 1, false, 1);
				scene("strings/forest-unicorn/okay-male");
				while (player.hasCock()) {
					player.removeCock(0, 1);
				}
				player.createVagina();
				addButton(0, "Next", celessUnicornIntro2, 3, true);
				break;
			case 3:
				scene("strings/forest-unicorn/okay-female", { $wasMale: wasMale, $isTaur: player.isTaur() } );
				if (player.hasKeyItem("Nightmare Horns") >= 0) player.removeKeyItem("Nightmare Horns");
				player.createPerk(PerkLib.UnicornBlessing, 0, 0, 0, 0);
				player.cor = 0;
				player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				_age = _ageDidPregnancy;
				break;
			case 4:
				scene("strings/forest-unicorn/fuck-her");
				if (player.hasKeyItem("Nightmare Horns")) player.removeKeyItem("Nightmare Horns");
				findArmor();
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				break;
		}
	}

	public function celessArmor():void {
		if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
		if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
		scene("strings/forest-unicorn/armorScene");
		findArmor();
		inventory.takeItem(armors.CTPALAD, camp.returnToCampUseOneHour);
	}
	
	public function nightmareDefeated():void {
		_age = _ageDidPregnancy;
		cleanupAfterCombat();
	}

	private function growUpScene():void {
		if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
		if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
		scene("strings/growUp", myLocals);

		outputText("As you wake up this morning, you check the space next to you where "+_name+" usually sleeps, and find it empty.\n\n" +
				"You almost panic for a moment, before calming down and deciding to go look for her. When you finally find her by the stream, she’s holding her forehead, visibly in pain.\n\n");
		if (isCorrupt) {
			outputText("\"<i>Ahhhh so good… this feels way too good!…Mom please look!</i>\"\n\n");
			outputText("Well, looks like it wasn’t pain, not at all. You watch spellbound as a duo of parallel horns, symbols of her corruption, push out of "+_name+"’s forehead. " +
					"She holds her horns like a pair of dicks, playing her hands along their length as if trying to masturbate them. " +
					"Speaking of which, her 25 inch long horse cock is now fully erect and throbbing, almost as if an invisible hand was toying with it, a thick flow of precum steadily seeping out already. " +
					"Her breasts, currently D-cups, are progressively inflating, finally stopping somewhere around E-cups. " +
					"And as her horns finish their growth, her horsecock explodes, splattering much of the ground, covering it in white. " +
					"Your little girl seems to have matured to adulthood.\n\n" +
					"\"<i>Mom… I feel so energised, and hot... please... help me get that throbbing thing to calm down.</i>\"\n\n");
		}
		else{
			outputText("\"<i>Oww! It hurts!...Mom… don’t look!</i>\"\n\n");
			outputText("You see your daughter is holding a large horns on her forehead. It seems she finally reached adulthood, her breasts inflating to E-cups only confirms your suspicion. She seems to be in pain");
			if (silly()) outputText(", kinda obvious, what with her outright telling you less than two seconds ago,");
			outputText(" and it’s your duty as her mother to do all you can to help her. You hug her, trying your best to comfort and distract her from the pain as the horns pushes forward, eventually growing to a length just shy of her sire’s own horns." +
					"\"<i>Mom… It’s terrible! I've grown this weird bony stump on my head, what do I do?</i>\"\n\n" +
					"You explain to your daughter that it's normal for unicorns to have a horns on their forehead and that you love her all the same, horns or not. " +
					"She calms down and hugs you warmly like she always does. This time, however, you can’t help but notice the large horsecock between her leg rising to full mast. " +
					"Noticing where you’re looking, she blushes and tries to hide it from you, failing miserably due to being unable to reach it with her hands. All she achieves is looking somewhat silly. " +
					"You tell her it’s alright , that you’re here for her and that, as you already said, you love her, horns or no horns, no matter what kind. This manages to get a chuckle out of her, easing some of her worry, but not all of it. " +
					"You sigh, she’s your daughter, and no matter the problems she might have, she can always come to you and you will gladly go to any length to help her with it. No exceptions...\n\n" +
					"\"<i>Mom, I’m a little scared…why did it get so big?! How do I get rid of this huge thing between my legs?</i>\"\n\n");
		}
		if (player.isFemaleOrHerm()) {
			outputText("This is a… somewhat unusual situation, but as a ");
			if (player.isFemale()) outputText("female ");
			if (player.isHerm()) outputText("herm like her");
			outputText(" it’s something you can understand. ");
		}
		else {
			outputText("You really would prefer not to do this but sadly you have no other way to solve this problem. ");
		}
		outputText("You approach your girl’s massive tool and give it a few experimental strokes, making "+_name+" gasp in surprise. " +
				"You lick the flared tip to get a taste, satisfied with it you then proceed to put the thing in your mouth proper. "+_name+" moans as her horse dong throbs in appreciation for the attention you’re giving it. " +
				"You suck on her cock until she finally orgasms, the sweet cum flooding your throat.");
		if (isCorrupt) {
			outputText("Weirdly enough, you feel something change in you as the corrupted cum reaches your stomach. ");
			CelessGoIntoHeatRut();
			outputText(" Aroused like you are its barely if you can hold yourself from");
			if(player.hasStatusEffect(StatusEffects.Heat)) outputText(" impaling yourself on her alluring cock.");
			else if(player.hasStatusEffect(StatusEffects.Rut)) outputText(" moving behind her and plowing her alluring pussy with your painfully erect "+player.cockDescript()+".");
			outputText(" how will you handle the situation?");
		}
		else {
			outputText("Her cum somehow makes your mind feel clearer and sharper, purifying some of the darker thoughts plaguing you. " +
					""+_name+"’s horsecock finally shrinks back to its sheath, but she’s still blushing like a tomato.\n\n" +
					"\"<i>Mom, is this really ok with you?</i>\"\n\n" +
					"You would rather it be you than some imp after her purity, stealing your daughter firsts. " +
					"She understands you’re doing this for her sake and does her best to stop blushing, being only moderately successful. " +
					"The morning pretty much continues as normal, aside from a lecture on sex you put some time aside to give her, mainly on what and who to avoid and why.");
		}
		if (isCorrupt) {
			addButton(0, "MasturbateHer", incestScene, "masturbateHer");
			if (player.isMaleOrHerm()) {
				addButton(1, "Fuck Her", incestScene, "fuckHer");
			} else {
				addButtonDisabled(1, "Fuck Her");
			}
			if (player.hasKeyItem("Fake Mare") + player.hasKeyItem("Centaur Pole") >= 0) {
				addButton(2, "Centaur Toys", incestScene, "centaurToys");
			} else {
				addButtonDisabled(2, "Centaur Toys");
			}
		}
	}

	private function incestScene(sceneName:String):void {
		var toDisplay:String = "strings/incest/" + sceneName;
		scene(toDisplay, myLocals);
		if (sceneName == "pureIncest" && player.cor > 80) {
			_corruption++;
			if (isCorrupt) {
				addButton(0, "Next", incestScene, "pureCorruption");
			}
			else {
				outputText("Just as you're about to go, however, you catch a glimpse of <output>$name</output>’s horse dong as it resumes acting up, just as you wanted. " +
						"You’ll need to keep her constantly aroused to educate her properly and set her on the path to depravity if she's to become a proper daughter of yours.");
				dynStats("cor", -1);
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
	
	private function get myLocals():*{
		return {
			$name : _name,
			$isCorrupt : isCorrupt,
			$isAdult : isAdult
		}
	}
}
}