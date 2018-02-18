package classes.Scenes.NPCs {
import classes.CoC;
import classes.EventParser;
import classes.ItemType;
import classes.PregnancyStore;
import classes.Scenes.Camp;
import classes.TimeAwareInterface;
import classes.PerkLib;
import classes.BodyParts.Horns;
import classes.BodyParts.Wings;
import classes.StatusEffects;

import coc.view.ButtonDataList;

import flash.utils.getQualifiedClassName;

/**
 * ...
 * @author Oxdeception
 */
public class CelessScene extends XXCNPC implements TimeAwareInterface {
	private static const _ageIsAdult:int = -1;
	private static const _ageShouldDoBirth:int = -2;
	private static const _ageCanMeetNightmare:int = -3;
	private static const _ageDidPregnancy:int = -4;

	private static var _instance:CelessScene;

	public static function get instance():CelessScene {
		if (!_instance) {
			new CelessScene();
		}
		return _instance;
	}

	public static function canMeetUnicorn():Boolean {
		return (
				playerIsVirgin()
				&& CoC.instance.player.level >= 10
				&& !CoC.instance.player.isPregnant()
				&& !instance.armorFound
				&& instance._age == 0
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
		return _corruption > 30;
	}

	public function get isAdult():Boolean {
		return _age == _ageIsAdult;
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
			addButton(1, "Play Time", scene, "strings/playTime", {
				$name: _name,
				$dangerousPlants: (player.hasKeyItem("Dangerous Plants") >= 0)
			});
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
				incestScene("pureIncest")
			}
		}
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
		if (_age == _ageDidPregnancy) {
			_age = _ageShouldDoBirth;
		}
		else {
			mainView.nameBox.text = "";
			scene("strings/birth/intro", null, nameScene);
		}

		function nameScene():void {
			if (mainView.nameBox.text == "") {
				clearOutput();
				outputText("<b>You must name her.</b>");
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
			if (player.cor > ((100 + player.corruptionTolerance()) / 2)) {
				_corruption = 30;
			}

			mainView.nameBox.visible = false;
			scene("strings/birth/nameScene", myLocals, camp.returnToCampUseFourHours);
		}
	}

	public function itemImproveMenu():void {
		var improvableItems:Array = [
			[weapons.BFSWORD, weapons.NPHBLDE, weapons.EBNYBLD],
			[weapons.MASTGLO, weapons.KARMTOU, weapons.YAMARG],
			[weapons.KATANA, weapons.MASAMUN, weapons.BLETTER],
			[weapons.W_STAFF, weapons.U_STAFF, weapons.N_STAFF],
			//	[weapons.DEMSCYT,		weapons.LHSCYTH,		null],
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
		outputText("<b>Celess can empower items using materials gems and her innate magic to bless/corrupt gear. Would you like her to create a legendary item and in that case which?</b>");

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

	public function celessUnicornIntro(stage:int = 0, wasMale:Boolean = false):void {
		switch (stage) {
			case 0:
				if (player.hasPerk(PerkLib.BicornBlessing)) {
					outputText("No matter how much you try to you cannot find the grove where the holy shield rest. It seems that the barriers are keeping you at bay now.");
					doNext(camp.returnToCampUseOneHour);
				}
				if (canMeetNightmare()) {
					display("strings/forest-unicorn/intro/introAfterNightmare");
					menu();
					addButton(0, "Back", camp.returnToCampUseOneHour);
					if (player.hasKeyItem("Nightmare Horns")) addButton(1, "Show proof", celessUnicornIntro, 5);
				}
				scene("strings/forest-unicorn/intro/intro");
				if (playerIsVirgin()) {
					display("strings/forest-unicorn/intro/introVirgin");
					menu();
					addButton(0, "Okay", celessUnicornIntro, (player.isMale() || player.isGenderless()) ? 2 : 3);
					if (player.hasCock()) {
						addButton(1, "Fuck Her", celessUnicornIntro, 4);
					}
					addButton(5, "NoWay", celessUnicornIntro, 1);
				} else {
					display("strings/forest-unicorn/intro/introNoVirgin");
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
				while (player.hasCock()) {
					player.removeCock(0, 1);
				}
				player.createVagina();
				addButton(0, "Next", celessUnicornIntro, 3, true);
				break;
			case 3:
				scene("strings/forest-unicorn/okay-female", { $wasMale: wasMale, $isTaur: player.isTaur() } );
				if (player.hasKeyItem("Nightmare Horns")) player.removeKeyItem("Nightmare Horns");
				player.createPerk(PerkLib.UnicornBlessing, 0, 0, 0, 0);
				player.cor = 0;
				player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				_age = _ageDidPregnancy;
				break;
			case 4:
				scene("strings/forest-unicorn/fuck-her");
				findArmor();
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				break;
			case 5:
				display("strings/forest-unicorn/intro/introAfterNightmareShowProof");
				menu();
				addButton(0, "Okay", celessUnicornIntro, (player.isMale() || player.isGenderless()) ? 2 : 3);
				if (player.hasCock()) {
					addButton(1, "Fuck Her", celessUnicornIntro, 4);
				}
				addButton(5, "NoWay", celessUnicornIntro, 1);
				break;
		}
	}

	public function celessArmor():void {
		scene("strings/forest-unicorn/armorScene");
		findArmor();
		inventory.takeItem(armors.CTPALAD, camp.returnToCampUseOneHour);
	}
	
	public function nightmareDefeat():void {
		scene("strings/forest-nightmare/won");
		player.createKeyItem("Nightmare Horns", 0, 0, 0, 0);
		doNext(camp.returnToCampUseOneHour);
	}
	public function nightmareDefeated():void {
		scene("strings/forest-nightmare/lost");
		if (!player.hasVagina()) {
			outputText("You can’t help but weakly try and shove her away but the nightmare proves too strong. She kicks you on all fours and aligns her unholy cock with your [asshole]. You try to crawl away but she responds by jamming her entire length into your hole.\n\n");
			outputText("\"<i>Here we go for a ride! Ohhh yeaaaa!</i>\"\n\n");
			outputText("She neighs in pleasure as she violates your ass, thoroughly molding your hole after the shape of her cock. You scream at first from the stretching of your passage, her cock bulging in your belly, but pain slowly turns to pleasure as various things change about you.\n\n");
			outputText("Without knowing it, your ass shape begin to change, molding itself into a perfect heart to further accommodate the centauress desire.");
			if (player.biggestTitSize() < 7) {
				outputText("Your breasts follow suit, inflating up to an E cup and if you weren't forced down on all fours, you would be groping them yourself to savor their shape.");
				if (player.breastRows.length == 0) {
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 7;
				}
				else player.breastRows[0].breastRating = 7;
			}
			outputText("If your voice was any less than womanly before, it's no longer the case as your moans turn increasingly feminine. Each thrust of the nightmare messes you up a little more and as you are about to finally reach anal orgasm, the flesh of your crotch");
			if (player.balls > 0) outputText(" at the base of your balls");
			outputText(" begins to change revealing a pair of drooling lips that can only be your newly formed cunt englobing your male genitalia");
			outputText(". This final change is too much and you cum at once from");
			if (player.hasCock()) outputText(" your [cock] and");
			outputText(" newly formed vagina, drenching the grass with your fluids.");
			if (player.hasCock()) {
				outputText(" The more you cum the more your cock");
				if (player.balls > 0) outputText(" and balls");
				outputText(" shrink and before you know it you're left with a perfectly feminine set of assets, whatever is left of your cock vanishes entirely between your pussy lips with a final spurt of cum. Guess the nightmare was indeed calling you a girl on purpose before because now you fully look like one. You feel the nightmare slide her member out of your bitchy asshole and realign her monster for her true goal.");
			}
			outputText("\n\n\"<i>Here I go girl better be ready now! Because we going for part two!</i>\"\n\n");
			if (player.hasCock()) {
				player.removeCock(0, 1);
			}
			player.createVagina();
		}
		if (player.isTaur()) {
			outputText("The nightmare licks her lip in anticipation as she examines your prone form.\n\n");
			outputText("\"<i>Mmmm it has been so long since last I had a mare. Tell me girl... do you yearn for me? Do you desire my tool?</i>\"\n\n");
			outputText("The more she speaks the more you realise she’s right.");
			if (player.statusEffectv2(StatusEffects.Kelt) > 0) outputText(" You have felt this attraction before while around Kelt, however her aura is infinitely stronger than that of the misogynic macho centaur.");
			outputText(" Her cock is spreading for you a scent that hypnotises and lures you like a moth to a flame.");
			if (!player.inHeat) outputText(" The more you focus on her, the more your mind clouds as your vagina begins to abundantly drool. You realize her presence alone was enough to send you into deep heat.");
			outputText(" There is no denial to your instincts anymore. Every fiber of your body desire this stallion, breaking any form of resistance you had, and so you submissively fawn to her desperate for her attentions. She nod at your attitude and gently pulls your head up by the chin so your gazes can meet.\n\n");
			outputText("\"<i>Don’t worry... I will treat you like the top breed mare you are and mark you as my own.</i>\"\n\n");
			outputText("She moves in position behind you and gets to work climbing on your back. You weiny in pleasure as her cock seamlessly slides in your [pussy] filling you in just the perfect way. Gosh why had you been fighting against this? This cock, its like it was made for you to begin with! It's perfect flare and just about right size fills you like a key fits its specific keyhole.");
			outputText(" You fully sink into your breeding instincts and do your darndest best to respond to your lovers trust, milking her horsecock with your thirsty cunt.\n\n");
			outputText("\"<i>Wow girl you're taking charge now are you? At this rate I won’t be able to hold any much longer.</i>\"\n\n");
			outputText("You moan in delight as the fiend corruption spreads from her cock to you, staining your body and soul as black as her own.");
			if (player.hasFur() && player.coatColor != "black") {
				outputText(" Your pelt color swiftly change color to midnight black as every single trust pushes you forward down into your breeding frenzy.");
				player.coatColor == "black";
			}
			if (player.horns.type != Horns.BICORN) {
				outputText("(If no bicorn horn)Just as you are about to achieve orgasm a pair of small parallel nub begins forming on your forehead.");
				player.horns.type = Horns.BICORN;
			}
			outputText(" The nightmare herself seems to lose control as the two of you keep fucking like wild animals.\n\n");
			outputText("\"<i>Ahhhhh cummingggg!!!!</i>\"\n\n");
			outputText("You feel the bulge at the base of her cock travel all the way through her length before it explode right into your [pussy]. This is going to knock you up for sure.");
			if (player.horns.type != Horns.BICORN && player.horns.type != Horns.UNICORN) {
				outputText(" Reaching your own orgasm you scream in delight as the two nubs finally grow into a pair of sensible spiraling horns.");
				player.horns.type = Horns.BICORN;
			}
			if (player.horns.type != Horns.BICORN && player.horns.type == Horns.UNICORN) {
				outputText(" Reaching your own orgasm you scream in delight as your horn slit into a pair of sensible spiraling bicorn horns.");
				player.horns.type = Horns.BICORN;
			}
			outputText(" The pleasure of your transformation is so great your grab your twin horns with both hands and fiercely rub them like a pair of penis. Gosh you see white, the pleasure too great for you to handle as you cum again, and again your pussy exploding around the horsecock still flooding your hole.");
			if (player.hasCock()) outputText(" Your own [cock] hardening spontaneously and splattering black cum at your feets.");
			outputText(" The nightmare gently slide out of your cunt leaving you with a feeling of emptiness as she guide you to the ground where you lay down to catch your breath.\n\n");
			outputText("\"<i>Best mare I had in years. I’m definitely going to miss that one. That said, take care of our child, I won’t be there for her myself.</i>\"\n\n");
			outputText("You nod weakly with a confused lust addled expression. Yea, whatever she says... You don’t care, you're in nirvana, trying to reconnect with your body right now, and so your vision fades to black.\n\n");
			outputText("You wake up your alone in the clearing. Seems everyone left while you were sleeping. You feel horribly aroused by your newfound corruption and all the more by the powerful black magic your body is permeated with. Somehow the centauress permanently desecrated your body with her energy and you can feel this “blessing” resonating with your newfound corruption.\n\n");
		}
		else {
			switch (rand(10)){
				case 0:
					player.skinTone = "shiny black";
					break;
				case 1:
				case 2:
					player.skinTone = "indigo";
					break;
				case 3:
				case 4:
				case 5:
					player.skinTone = "purple";
					break;
				default:
					player.skinTone = "blue";
			}
			player.horns.type = Horns.BICORN;
			player.wings.type = Wings.NIGHTMARE;
			outputText(" You try to meekly crawl away but the centauress is too fast for you. She has you easily pinned to the ground by her hoof as she lowers herself on your prone body aligning her meat with your hole. You try to scream for help but she cuts the air out with a swift blow now squeezing you between her horse body and the grass. You can only beg her as you feel her flare prod for the entrance of your cunt, smearing pre on your slit, she's clearly going to break you. ");
			outputText("You ready a scream as her cock forces your lips apart but to your complete surprise her massive monster seamlessly slide in without further resistance. She begins to buck in and out filling you way past the cervix and, to your dismay, you actually realise you’re enjoying this.\n\n");
			outputText("\"<i>My horn can penetrate anything, from the tightest pussy to the loosest hole. Leave it to me and I will turn you into a mess of pleasure.</i>\"\n\n");
			outputText("Your mind indeed reels as corruption floods your body with each thrust. Your cunt pulses in tandem with the nightmare’s ramming as your body gives in to her. You moan in pleasure as your spine extends into a long sinuous tail, ending with a heart shaped tip. Your lust addled mind finds no better use for it other than wrapping the appendage around the nightmare's cock in an attempt to assist her thrusts. ");
			outputText("This is no longer rape you’re enjoying it too much. You arch your back to scream in pleasure as");
			if (player.wings.type == Wings.NONE) outputText(" a");
			outputText(" pair of demonic wings unfold from your back");
			if (player.wings.type > Wings.NONE) outputText(" replacing your old ones");
			outputText(". This is all too much pleasure for your mind to handle, you’re slowly turning into a demon and you don’t even care. Your partner however is at her limit.\n\n");
			outputText("\"<i>Here it comes girl... take it all!</i>\"\n\n");
			outputText("The nightmare’s cock begins to pulse violently as the both of you finally reach climax, her horsecock flooding your womb to the brim with hot, tainted cum. Your body’s reaction is swift, your head growing a pair of large demonic horns and your skin pigmentation slowly shifting to a " + player.skinTone + " hue ");
			outputText("as you reach the end of your transformation but strangely, despite how defiled you are, your soul does not seem to be coming out. The nightmare pulls out of your body leaving you stranded on the ground trying to regain your composure.\n\n");
			outputText("\"<i>You are a lucky girl... I feel generous and since you're such a cutie I actually stopped only short of making you cum out your soul. Demons can only give births to imps anyway and I need a strong body like yours to carry my offspring into the world. Do take care of her will you?</i>\"\n\n");
			outputText("You nod weakly with a confused lust addled expression. Yea, whatever she says... You don’t care, you're in nirvana, trying to reconnect with your body right now, and so your vision fades to black.\n\n");
			outputText("You wake up your alone in the clearing. Seems everyone left while you were sleeping. You feel horribly aroused by your newfound corruption and all the more by the powerful black magic your body is permeated with. Somehow the centauress permanently desecrated your body with her energy and you can feel this “blessing” resonating with your newfound corruption.\n\n");
		}
		player.createPerk(PerkLib.BicornBlessing, 0, 0, 0, 0);
		player.cor = 100;
		player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
		doNext(camp.returnToCampUseOneHour);
		_age = _ageDidPregnancy;
	}

	private function growUpScene():void {
		scene("strings/growUp", myLocals);
		if (isCorrupt) {
			addButton(0, "Masturbate Her", incestScene, "masturbateHer");
			if (player.isMaleOrHerm()) {
				addButton(1, "Fuck Her", incestScene, "fuckHer");
			} else {
				addButtonDisabled(1, "Fuck Her");
			}
			if (player.hasKeyItem("Fake Mare") + player.hasKeyItem("Centaur Pole") >= 0) {
				addButton(2, "Centuar Toys", incestScene, "centaurToys");
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
				display("strings/incest/addCorruption", myLocals);
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
	
	private function get myLocals():*{
		return {
			$name : _name,
			$isCorrupt : isCorrupt
		}
	}
}
}
