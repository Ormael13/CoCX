package classes.Scenes.NPCs {
import classes.CoC;
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
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
 * --Leftover code migrated by Jtex (Sorry if something is broken... I'm putting my name here for accountability.)
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
		//display("strings/campInteraction", myLocals);
		outputText(_name + " sees you coming over from afar and cheers up right away.\n\n"+
		"<i>\"Mom, did you come over to see me?!\"</i>");
		menu();
		//addButton(0, "Appearance", scene, "strings/appearance", myLocals, campInteraction);
		addButton(0,"Appearance",celessChildAppearance)
		if (isAdult) {
			if (isCorrupt || player.cor >= 20) {
				addButton(1, "Incest", incestMenu);
			}
			addButton(2, "Items", itemImproveMenu);
			//addButton(3, "Armour", armourImproveMenu);
		}
		else {
			addButton(1, "Play Time", playTime);
		}
		addButton(14, "Back", camp.campFollowers);
		flushOutputTextToGUI();

		function incestMenu():void {
			if (isCorrupt) {
				clearOutput();
				outputText("How do you want to play with your daughter?");
				var menu:ButtonDataList = new ButtonDataList();
				//display("strings/incest/corruptMenu", myLocals);
				menu.add("Suck her off", incestSuckHerOff);
				menu.add("Fuck Her", incestFuckCorrupt).disableIf(!player.isMaleOrHerm());
				menu.add("Get Fucked", incestGetFucked).disableIf(!player.isFemaleOrHerm());
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
				"You lick the flared tip to get a taste. Satisfied with it you then proceed to put the thing in your mouth proper."+_name+" moans as her horse dong throbs in appreciation for the attention you’re giving it.\n\n" +
				"<i>“Eep!!! Mom, I’m scared. It feels all weird... S..something is comiiiiiiing!”</i>\n\n" +
				""+_name+" whines as she finally orgasms, her sweet cum flooding your throat. It tastes like cake icing, making it an exercise on willpower to keep from desperately trying to get more. " +
				"As her erection finally dies down, you feel something change in you as the cum reaches your stomach.");
		CelessGoIntoHeatRut();
		pureChildCorruption();
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
			if (isCorrupt){
				spriteSelect(SpriteDb.s_celessBlack);
			}
			else {
				spriteSelect(SpriteDb.s_celessWhite);
			}
			mainView.nameBox.text = "";
			//scene("strings/birth/intro", null, nameScene);
			clearOutput();
			outputText("You suddenly lose all strength from the waist down, forcing you to lay down on the moss as you go into labor. Unlike what you know of pregnancy, you don’t feel any pain from this, your daughter leaves your womb without trouble and, somehow, you even get an orgasm out of the deal. \n"+
			" It starts with the head, then the torso. So far one would think you are giving birth to a human baby, but you know it’s otherwise. A horse body indeed follows suit right after, causing you to orgasm again as white fluids gush out of your happy love canal in a steady flow. She is finally out and starts her life as any and all babies do… with a lengthy and healthy cry!\n"+
			"You cradle your newborn daughter and bring her to your [breasts], feeling like taking a nap next to your child. First, however, comes an important question.. what will you name her?");
			doNext(nameScene);
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
			//scene("strings/birth/nameScene", myLocals, camp.returnToCampUseFourHours);
			clearOutput();
			outputText("\n\n<i>\"" + _name + "... this is a good name, right my child?\"\n</i>"+
			_name + " stops crying and looks at you with her big eyes, letting out a cute laugh in response.\n"+
			"You think she likes it. Having solved this important matter, you drift asleep with " + _name + " still hugging your chest.\n\n"+
			"When you wake up, you're no longer holding a baby, but what looks like a centaur girl in her tender years.\n" +
			"You are hardly surprised, already knowing how short most pregnancies are in Mareth.");
			if (player.inte > 50) outputText("Maybe it’s due to how time and space distort here?");
			outputText("Still, you had hoped this phase would have lasted at least a little bit longer.");
			if(isCorrupt) {
				outputText("Your daughter wakes up as well, opening her beautiful crimson eyes to the world.\n" +
				"She has silver hair and twilight black fur.");
			}
			else	{
				outputText("Your daughter wakes up as well, opening her beautiful azure eyes to the world.\n" +
				"She has platinum blonde hair and white fur as befits an unicorn.");
			}
			outputText("You expected her to have grown her horns by now, but strangely enough, her forehead is still clear, perhaps unicorns grow their horns when they grow older?");
			if (player.inte > 50) outputText("Does make sense, otherwise they would cause some nasty internal damage during birth.");
			outputText("<i>\"Mom, is something wrong?\"</i>\n" +
			"You reply that no… Although you wistfully hope she will stay cute like this forever, despite knowing perfectly well that she will not.\n" +
			"While you would like to spend more time enjoying your role as a parent you still have a lot of things to do, so you simply tell her to stay at camp for now whenever you're not here for her safety.");
			doNext(camp.returnToCampUseFourHours);
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
			[shields.SANCTYN, shields.SANCTYL, shields.SANCTYD]
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
			//scene("strings/itemImprove/improveThatItem", myLocals);
			outputText("You ask" + _name + " if she could imbue an item with her power.\n\n"+
			"<i>\"Certainly mother! Just leave the item on the ground and let me get to work.\"</i>\n\n"+
			_name + " trots over to the item and starts channeling power.");
			if (isCorrupt){
				outputText("You see her twin horns blazing with a dark purple aura of corruption as her horse cock goes erect. "+
				"She start to massage her breasts then moans, her eyes rolling out as she spontaneously orgasms, a river of black cum flooding out of her flare right unto the item. "+
				"You see the armament transforming as fluid corruption seeps into the material, infusing it with unholy power.\n\n"+
				"She sighs in relief, shakes out the few last drops of corrupt cum, then steps away, leaving you to examine the fruit of her work.");
			}
			else{
				outputText("Her horns starts to glow with a white halo of purity. "+
				"She cradles the item within her hands like a newborn baby, then finally touches it with her horns, transferring the light into it. "+
				"A miracle happens, as the item changes shape and starts to glow with holy power.\n\n" +
				"Finally done, she comes back to you and solemnly deposits the blessed armament in your hand.");
			}
			player.destroyItems(from, 1);
			inventory.takeItem(item, camp.returnToCampUseOneHour);
		}
	}

	/*
	public function armourImproveMenu():void {
		if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
		if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
		var improvableArmours:Array = [
			[armors., armors., armors.],
			//	[armors.CTPALAD,		null,					armors.CTBGUAR], 	//This was already here from above.
			//	[armors.LMARMOR,		armors.,			armors.]
		];
		clearOutput();
		outputText("<b>"+_name+" can empower items using materials gems and her innate magic to bless/corrupt gear. Would you like her to create an epic item and in that case which?</b>");// legendary
//Celess
		var selectfrom:int = isCorrupt ? 2 : 1;										// Everything below should actually be fine, funny enough.
		var selectMenu:ButtonDataList = new ButtonDataList();
		for (var i:int = 0; i < improvableArmours.length; i++) {
			if (improvableArmours[i][selectfrom] == null) {//do nothing
			}
			else {
				var item:ItemType = improvableArmours[i][selectfrom];
				var from:ItemType = improvableArmours[i][0];
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
	*/

	public function celessUnicornIntro():void {
		spriteSelect(SpriteDb.s_celessWhite);
		if (player.hasPerk(PerkLib.BicornBlessing)) {
			outputText("No matter how much you try to you cannot find the grove where the holy shield rest. It seems that the barriers are keeping you at bay now.");
			doNext(camp.returnToCampUseOneHour);	
			return;
		}
		if (player.hasStatusEffect(StatusEffects.CanMeetNightmare)) {
			//display("strings/forest-unicorn/intro/introAfterNightmare");
			outputText("You manage to find your way back to the sacred grove. As expected the guardian is swift to show, blocking your path to the shield her tall frame acting like a wall.\n\n"+
			"<i>\"Sorry, but until you have proven yourself I cannot allow you any further.\"</i>")
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
				//scene("strings/forest-unicorn/intro/intro");
				outputText("As you wander the woods, you stumble upon a large clearing. "+
				"The place is pure - so pure that the rest of Mareth looks like a corrupted wasteland in comparison, which given the current state of things, isn’t that far from the truth.\n"+
				"In the center of this natural masterpiece sits a large stone altar, upon which rests a magnificent white shield ornamented with gold filigree. "+
				"As you approach the shield, a powerful wall of force stops you a few feet away from the item.\n\n"+
				"<i>\"None shall take this sacred relic from this place without my consent!\"</i>\n\n"+
				"You turn over just in time to see a massive horse-like figure charging at you, barely managing to move out of the way in time to avoid being trampled.\n"+
				"Your assailant is now standing between you and the altar, letting you get a good view at the grove’s ostensible guardian:\n\n"+
				"The woman has silvery white hair flowing around her perfect visage; and her sizable E cup would make most women back in Ingnam green with envy, then again, most things even somewhat female here in Mareth would cause the same reaction. "+
				"The comparison to a human, however, ends there. "+
				"Below her waist is the large lower-body of an immaculate white horse. "+
				"Her ears are covered with silvery white fur and while at first you mistook her for just a centaur warrior, the spear-like spiraling horns on her forehead warns you that there might be more to her.\n\n"+
				"<i>\"Just leave and I won’t have to attack you. I swear on my honor that I won’t give chase should you leave peacefully. This is for your own good.\"</i>");
				if (playerIsVirgin()) {
					//display("strings/forest-unicorn/intro/virgin");
					outputText("She suddenly sniffs something in the air and her expression changes to one of baffled disbelief.\n\n"+
					"<i>\"How is this even still possible in this lost corrupted land? A chaste person on Mareth?!\"</i>\n\n"+
					"She approaches to examine you thoroughly now. Once satisfied, she declares, <i>\"Well I have no idea how you managed it, but you stayed a virgin and pure despite the mess around here.\"</i>"+
					"You understand the reason for her surprise, chastity in Mareth is as rare as rain nowadays. "+
					"Your virginity is a testament to your strength, you have fought tooth and nail to protect it, partly due to the values you were taught, mostly due to knowing what most inhabitants of Mareth would do to you once you were defenseless. "+
					"You tell her as much, causing her surprise to turn into respect.\n"+
					"Having answered her question, you ask one in turn, namely, what is she doing here, exactly? "+
					"You can already see she is some sort of guardian, probably of that shield over there, but you would like to know the specifics.\n\n"+
					"<i>\"I was tasked with guarding the divine shield, Sanctuary, from dark influence. "+
					"Demons cannot enter this grove and the impure reels at the mere thought of setting a single foot into this area.\n"+
					"This armament needs a champion to wield it and take the fight to the fiends; "+
					"however, due to Mareth’s purity being compromised, people who match this description have almost all been destroyed by transformations or defiled by the many demonic inhabitants of the land.\n"+
					"Only a pure maiden such as you can hope to get past the ward.\"</i>\n\n"+
					"Interested in the magnificent shield on the altar, you ask what you would need to do to get access to this shield, since you already fulfill the requirements for entering here.\n\n"+
					"<i>\"Simple, since only one carrying my essence can pass the ward, I just need to share my essence with you.\"</i>\n\n"+
					"You raise an eyebrow at that, you’ve been in Mareth long enough to know an innuendo when you hear one, but surely such a pure individual must have meant something far more innocent. "+
					"Still, you do glance at her lower half to make sure.\n\n"+
					"Aaaand of course she has a horsecock, already at half-mast, too. "+
					"You bite down a sigh, you’re in fucking Mareth, of <i>course</i> she has one.\n"+
					"Your first guess was right, at least. "+
					"That meager consolation does little to numb the disappointment.");
					menu();
					addButton(0, "Okay", celessUnicornIntro1, (player.isMale() || player.isGenderless()) ? 2 : 3);
					if (player.hasCock()) {
						addButton(1, "Fuck Her", celessUnicornIntro1, 4);
					}
					addButton(5, "NoWay", celessUnicornIntro1, 1);
				} else {
					//display("strings/forest-unicorn/intro/noVirgin");
					outputText("You ask her why she is defending this relic and what it would take for you to gain access to it. "+
					"She eyes you as if trying to figure out your intentions then sigh.\n\n"+
					"<i>\"Only the pure of heart and body may be allowed to pick up this shield, Marae herself tasked me with guarding it. "+
					"If you truly wish to prove your worthiness then I will ask of you that you perform a task for me.\"</i>\n\n"+
					"What task?\n\n"+
					"<i>\"In the darkest reaches of the forest lurks a terrifying creature of great corruption known as a nightmare. "+
					"It is anathema to purity and must be disposed of. Slay the nightmare and I will grant you access to the shield.\"</i>\n\n"+
					"On those word you leave, better seek out this creature as fast as possible.");
					player.createStatusEffect(StatusEffects.CanMeetNightmare,0,0,0,0);
					_age = _ageCanMeetNightmare;
					doNext(camp.returnToCampUseOneHour);
				}
				break;
			case 1:
				//scene("strings/forest-unicorn/noway");
				celessGuardNoWay();
				doNext(camp.returnToCampUseOneHour);
				break;
			case 2:
				if (player.bRows() == 0) {
					player.createBreastRow();
				}
				player.growTits(3, 1, false, 1);
				//scene("strings/forest-unicorn/okay-male");
				celessGuardOkayMale();
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
				menu();
				addButton(0, "Next", celessUnicornIntro1, 3, true);
				//doNext(celessGuardOkayFemale);
				break;
			case 3:
				//scene("strings/forest-unicorn/okay-female", { $wasMale: wasMale, $isTaur: player.isTaur() } );
				celessGuardOkayFemale(wasMale);
				if (player.hasKeyItem("Nightmare Horns") >= 0) player.removeKeyItem("Nightmare Horns");
				player.createPerk(PerkLib.UnicornBlessing, 0, 0, 0, 0);
				player.cor = 0;
				player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				_age = _ageDidPregnancy;
				break;
			case 4:
				//scene("strings/forest-unicorn/fuck-her");
				celessGuardFuckHer();
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
				//scene("strings/forest-unicorn/intro/introAfterNightmareShowProof");
				celessGuardNightmareShowProof();
				menu();
				addButton(0, "Okay", celessUnicornIntro2, (player.isMale() || player.isGenderless()) ? 2 : 3);
				if (player.hasCock()) {
					addButton(1, "Fuck Her", celessUnicornIntro2, 4);
				}
				addButton(5, "NoWay", celessUnicornIntro2, 1);
				break;
			case 1:
				//scene("strings/forest-unicorn/noway");
				outputText("You give her the same answer you gave all others, a flat \"No\" that leaves no room for negotiation");
				if (silly()) outputText(", followed by singing <i>\"nope, nope, nope, fuck this shit, I’m out!\" </i>, ");
				outputText(" as you turn around and leave. You fought hard to keep your virginity, no amount of loot is going to tempt you.");
				doNext(camp.returnToCampUseOneHour);
				break;
			case 2:
				if (!player.blockingBodyTransformations()) {
					if (player.bRows() == 0) {
						player.createBreastRow();
					}
					player.growTits(3, 1, false, 1);
				}
				//scene("strings/forest-unicorn/okay-male");
				celessGuardOkayMale();
				if (!player.blockingBodyTransformations()){
					while (player.hasCock()) {
						player.removeCock(0, 1);
					}
					player.createVagina();
					menu();
					addButton(0, "Next", celessUnicornIntro2, 3, true);
					//doNext(celessGuardOkayFemale);
					break;
				} else {
					if (player.hasKeyItem("Nightmare Horns")) player.removeKeyItem("Nightmare Horns");
					findArmor();
					inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
					break;
				}
			case 3:
				//scene("strings/forest-unicorn/okay-female", { $wasMale: wasMale, $isTaur: player.isTaur() } );
				celessGuardOkayFemale(wasMale);
				if (player.hasKeyItem("Nightmare Horns") >= 0) player.removeKeyItem("Nightmare Horns");
				player.createPerk(PerkLib.UnicornBlessing, 0, 0, 0, 0);
				player.cor = 0;
				player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				_age = _ageDidPregnancy;
				break;
			case 4:
				//scene("strings/forest-unicorn/fuck-her");
				celessGuardFuckHer();
				if (player.hasKeyItem("Nightmare Horns")) player.removeKeyItem("Nightmare Horns");
				findArmor();
				inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
				break;
		}
	}

	private function celessGuardNoWay():void{
		clearOutput();
		outputText("You give her the same answer you gave all others, a flat \"No\" that leaves no room for negotiation");
		if (silly()) outputText(", followed by singing <i>\"nope, nope, nope, fuck this shit, I’m out!\" </i>, ");
		outputText(" as you turn around and leave. You fought hard to keep your virginity, no amount of loot is going to tempt you.");
	}

	private function celessGuardOkayMale():void{
		clearOutput();
		outputText("You look at her cock, then your rear, then back to her cock.");
		if (player.inte > 70) {
			outputText("You don’t need to be a genius, which you are, to tell that that won’t fit without either injury or magic." +
					"And since the only ones you know of that have any kind of magic that fits the bill are the Demons, you have your doubts about the later option.");
		}
		else{
			outputText("You might not be a genius, but even you know that that won’t fit without injury on your end.");
		}
		outputText("You tell her as much.\n\n"+
				"<i>\"You forget I’m no ordinary centaur. First and foremost please bend over…\"</i>\n\n" +
				"Well, if that’s what it takes to obtain that unique and likely very powerful shield you guess you will have to. You get on all fours as the looming shadow of the centauress moves right above you. You feel her huge horse cock right up your ass cheek.\n");
		if (!player.isNaked()){
			outputText("Wait, didn’t you have your clothes still on? How is she already at your pucker entrance without removing anything? ");
			if (player.inte > 70) outputText("Is she seriously using spatial magic of all things just to avoid the bother of undressing you?");
		}
		outputText("<i>\"A unicorn ‘horns’ can pierce through anything, just relax, it will be easier for you.\"</i> ");
		if (silly() && player.inte > 70) outputText("Part of you is mildly surprised, and grateful, no Demon has realized this potential application of spatial magic, otherwise they would have pushed to develop it until they learnt how to open portals to other realms by ramming a dick against space-time until they fucked it into submission.")
		outputText("Without warning she suddenly shoves her huge horsecock inside, stretching your ass wide! "+
				"As expected it hurts a fair bit, but eventually pain recedes as you acclimate to it. ");
		if (!player.blockingBodyTransformations())		{
				outputText("Or are you truly? The pain is slowly turning to pleasure as you start moaning, your "+ (player.isMale()?"cock":"crotch") + " becoming extremely sensitive." +
				(player.isMale()?"You cum once then twice as it starts to shrink, ":"Your body starts to change, ") +
				"your moans becoming progressively less and less masculine until they sound just like those of a girl. Wait a girl?\n\n"+
				"<i>\"Ahhhn I can’t hold myself! Take it all!\"</i>\n\n"+
				"As she cums into your ass you feel "+
				(player.isMale()?"what’s left of your cock and balls continue shrinking inside of you until all that’s left is a slit.":"yourself becoming increasingly feminine up to the point a slit appear where there used to be nothing up your crotch")+
				"While you were concerned about your" + (player.isMale()?" cock":"new feminine assets")+ " you didn’t notice your chest had changed too, now you're sporting a pair of [breasts]!\n"+
				"Wait... what the hell!? Did she just change you into a girl?! This wasn’t part of the agreement!\n\n"+
				"<i>\"We ain’t done yet… here comes part two!\"</i>\n\n"+
				"You see her looming shadow above your crouched female form, her horse length already hard again and casting a shadow across your face. Well, shit.");
		}
		else {
			outputText("Well after a few minutes of this the unicorn finaly look like she's reaching her peak."+
					"\n\n\"<i>Ahhhn I can’t hold myself! Take it all!</i>\"\n\n"+
					"As she cums into your ass filling you full of horse splonge. The centauress sigh in disapointment for reasons unknown to you." +
					"\n\n\"<i>It's a shame realy had you been more maleable I could have perhaps granted you a final gift but a deal is a deal, here is your shield. I wish you safe travel hero.</i>\"\n\n"+
					"She picks up sanctuary from its pedestal and hand it over to you. waving you off. Guess your back on your quest now.");
		}
	}

	private function celessGuardOkayFemale(wasMale:Boolean = false):void{
		clearOutput();
		if (player.isTaur() && wasMale){
			outputText("Well now that she mention it you must admit you indeed have been eyeing her fat horsemeat for a fair while now. "+
			"Being a centaur makes it difficult for you to find relief especially since you decided not to relinquish your virginity. "+
			"You smirk seductively giving her a fair view of your virgin equine pussy as you tell the unicorn that for your first time, you might as well take a stallion." +
			"Your pussy lips are already wet in anticipation of her maleness.");
		}
		outputText("<i>\"Well, since you agreed, I will let you in on a little secret. I won’t need to take your virginity. Rather, my \'horn\' will pierce right through it.\"\n\n</i>");
		if (player.isTaur() && wasMale){
			outputText("She trots to you, her massive horsemeat hardening as she prepares to mount your [pussy]. She take a whiff of your [pussy] going so far as to give it a lick or two just so she can taste it. Satisfied, she gets on you and you can feel the tip of her flare making contact with your vaginal lips.\n\n"+
			"<i>\"Mmmmmm, what a nice mare pussy! I can only imagine how it will feel to fuck that. Well, here I go!\" </i>\n\n"+
			"You neigh in surprise as she suddenly slides her entire length inside your pussy. "+
			"Weirdly, it doesn’t hurt… you’d expect her massive cock to pierce your hymen yet you don't feel any pain, only the pressure of her large member working your pussy with masterful effectiveness.\n"+
			"You moan and neigh in delight as she fucks you for several minutes, her horsecock filling your equine pussy like no other. "+
			"Your eyes roll back as her cock drives your [pussy] completely crazy hitting every single sensitive spot in your massive horsecunt." +
			"The unicorn is not faring any better, drooling as she fucks your [pussy] silly. "+
			"You can only guess that she doesn't get to fuck a mare this often, much less a virgin one.");
		}
		else{
			outputText("It’s too late to say no now and you decide to bend over "+(wasMale?"again":"")+" for the centauress. Soon you feel her huge horse meat making contact with your walls entrance ");
			outputText((!player.isNaked() && !wasMale?"which is weird because you were quite sure you still had your clothes on":"")+ ".\n\n" +
			"<i>\"Here I go!\"</i>\n\n"+
			"She’s suddenly inside your pussy before you even had the time to shout a silent scream.");
			outputText((wasMale?"As with your ass just a moment ago, she doesn’t cause you any pain due to her size, nor does she break your hymen. You do feel the pressure of her large member working your pussy with masterful effectiveness though.":"Weirdly, it doesn’t hurt… you’d expect her massive cock to pierce your hymen yet you don't feel any pain, only the pressure of her large member working your pussy with masterful effectiveness.") +
			"You moan in delight as she fucks you up to the cervix for several minutes, your belly bulging due to the sheer size of her cock. Your eyes roll back as her cock drives your pussy completely crazy");
		}
		outputText("\n\n<i>\"Ahhhh! I can’t hold it anymore!\"</i>\n\n"+
		"A huge volume of cum shoots into you, filling your womb until it’s full enough to make" + (player.isTaur()?"your lower body":"you")+"look pregnant already. "+
		"You feel her removing her cock from your pussy as you "+ (player.isTaur()?"lie down on the ground to rest exhausted by the experience.":"pass out on the grass exhausted by the experience."));
		outputText("When you wake up you are no longer in the grove. "+
		"It would seem that the unicorn moved you to the forest’s edge. "+
		"She did keep her word, however, since the fabled shield is resting on your lap… seemingly protecting your inflated "+ (player.isTaur()?"horse":"")+ "belly.");
		if (player.isTaur()){
			outputText("You feel that all of her cum is still inside of you, somehow kept from leaking out and sloshing as you move.");
		}
		else{
			outputText("Checking on your privates, you’re surprised to discover that your virginity is indeed intact despite the crazy ride the centauress gave you. "+
			"Heck, all of her cum is still inside of you, somehow kept from leaking out and sloshing as you move.");
		}
	}

	private function celessGuardFuckHer():void{
		clearOutput();
		outputText("It’s not everyday you get to see a centauress with such a fine pussy");
		if(player.hasStatusEffect(StatusEffects.TelAdre))outputText(" beside Edryn's of course");
		outputText(". You ask the unicorn about it.\n\n"+
		"<i>\"Umph... I guess that can work too, but I'm only doing it because you are a virgin, unicorns don’t mate with anything else.\"</i>\n\n"+
		"That being all the encouragement you need, you position yourself behind her to insert your [cock] into her warm, gaping cunt. "+
		"She moans in delight as you push as much of your cock as you can inside, still looking for the perfect angle. The unicorn taunts you all the while.\n\n"+
		"<i>\"Pah! You should be grateful I’m even allowing you! With the demonic plague, the unicorn population has been decreasing dramatically. As such, it’s my responsibility to increase it, so you better not waste my virginity, you sinner.\"</i>\n\n"+
		"Sinner, eh? We'll see about sins later. Her pussy is quite large, so you have to work double time to make her feel anything at all. "+
		"You proceed to wildly fuck the unicorn’s hole with aggressive thrusts in order to, at the very least, make her moan. "+
		"You eventually reach your limit and flood her cunt with your cum, making her whine. " +
		(player.cumQ() >= 1000?"You pump in liters of cum, enough for her to start looking concerned as you seal her twat between your bodies, and her own belly start to swell visibly outside. When you finally finish and pull out of her, her hole continues to ripple and gape,"+(silly()?" almost like a fish's mouth, ":"")+" allowing you to glance at her still intact hymen, though it does seem to slightly struggle to keep your output contained.":"You check the results, but to your surprise not only nothing spills out of her cunt, but her hymen is actually still intact!")+
		"<i>\"I guess that will have to do… you can have the shield. Now get out of here, I have a pregnancy to manage.\"</i>");
	}

	private function celessGuardNightmareShowProof():void{
		clearOutput();
		outputText("You pull the nightmare twin horns out of your bag for the unicorn maiden to see, she nods in approval.\n\n"+
		"<i>\"What you did today perhaps will help to save what's left of this beautiful forest. Please allow me to perform this small service for you as a reward. I will restore that which you lost to the ravage of this fallen land.\"</i>\n\n"+
		"Her horn begins to glow a warm soothing light and, as she touches your cheek with her right hand you feel something change in your body as you recover your " + (player.hasPerk(PerkLib.HistoryWhore)?"long":"")+" lost virginity. That said, what happens now that you are pure again?\n\n"+
		"<i>\"I was tasked with guarding the divine shield, Sanctuary, from dark influence. Demons cannot enter this grove and the impure reels at the mere thought of setting a single foot into this area. This armament needs a champion to wield it and take the fight to the fiends; however, due to Mareth’s purity being compromised, people who match this description have almost all been destroyed by transformations or defiled by the many demonic inhabitants of the land. Only a pure virgin person such as you can hope to get past the ward.\"</i>\n\n"+
		"Interested in the magnificent shield on the altar, you ask what you would need to do to get access to this shield, since you already fulfill the requirements for entering here.\n\n"+
		"<i>\"Simple, since only one carrying my essence can pass the ward, I just need to share my essence with you.\"</i>\n\n"+
		"You raise an eyebrow at that, you’ve been in Mareth long enough to know an innuendo when you hear one, but surely such a pure individual must have meant something far more innocent. Still, you do glance at her lower half to make sure...\n\n"+ "Aaaand of course she has a horsecock, already at half-mast, too. "+
		"You bite down a sigh, you’re in fucking Mareth, of <i>course</i> she has one. Your first guess was right, at least. That meager consolation does little to numb the disappointment.\n\n"+
		"<i>\"So… you want this shield or not?\"</i>");
	}

	public function celessArmor():void {
		if (isCorrupt)spriteSelect(SpriteDb.s_celessBlack);
		if (!isCorrupt)spriteSelect(SpriteDb.s_celessWhite);
		//scene("strings/forest-unicorn/armorScene");
		clearOutput();
		outputText("You stumble upon the forest grove where the shield used to be. "+
		"The unicorn has long left but you spot a shine on the ground deeper in. "+
		"It looks like a set of untarnished silvery armor, likely an ancient treasure she left."+
		"Upon unearthing the piece, you discover this full plate armor was clearly not made for a human but a centaur.\n\n"+
		"The breastplate is ornamented with what you assume is a holy symbol, namely a blossoming oak tree" + (flags[kFLAGS.MET_MARAE] > 0?", obviously Marae's":"") + ". "+
		"It has plated barding and a skirt fit for a horse's body, it even comes with matching horseshoes."+
		"While clearly made like a full plate, it is surprisingly flexible, allowing for maneuverability similar to that of light armor, which is rather unusual.");
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

		//scene("strings/growUp", myLocals);
		clearOutput();
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
			//addButton(0, "MasturbateHer", incestScene, "masturbateHer");
			menu();
			addButton(0,"Masturbate Her", incestMasturbate);
			if (player.isMaleOrHerm()) {
				//addButton(1, "Fuck Her", incestScene, "fuckHer");
				addButton(1,"Fuck Her", incestFuckCorrupt);
			} else {
				addButtonDisabled(1, "Fuck Her");
			}
			if (player.hasKeyItem("Fake Mare") + player.hasKeyItem("Centaur Pole") >= 0) {
				//addButton(2, "Centaur Toys", incestScene, "centaurToys");
				addButton(2,"Centaur Toys", incestCentaurToys);
			} else {
				addButtonDisabled(2, "Centaur Toys");
			}
		}
	}

	private function incestSuckHerOff():void{
		clearOutput();
		outputText("It's been a while since you last had a taste of her, thus you decide to give your daughter a sweet, loving blowjob! " + _name + " coos, delighted at the proposal.\n"+
		"<i>\"Oh… so mommy wants a taste of my delicious lower horns? Please, mom, feel free to indulge yourself.\"</i>\n"+
		"You approach your girl’s massive tool and give it a few experimental strokes, making " + _name + " gasp in surprise."+
		"You lick the flared tip to get a taste.\n"+
		"Satisfied with it you then proceed to put the thing in your mouth proper. " + _name + " moans as her horse dong throbs in appreciation for the attention you’re giving it. "+
		"You suck on her cock until she finally orgasms, the sweet cum flooding your throat.\n\n"+
		"Weirdly enough, you feel something change in you as the corrupted cum reaches your stomach.");
		doHeatOrRut();
	}

	private function incestGetFucked():void{
		clearOutput();
		outputText("You could really use some of that horse meat down there and if " + _name + "’s raging erection is anything to go by, she’s in line with your thinking.\n" +
		"You get rid of any clothing, giving a good show of your [ass] to " + _name + " who blushes in desire while trotting up to you. Soon, you feel the tip of her huge cock at the entrance of your vagina.\n\n" +
		"<i>\"Here I go, mom!\" </i>\n\n"+
		"She’s suddenly inside your pussy before you even had the time to shout a silent scream. "+
		"Unsurprisingly your bicorn daughter's devilish cock seems to be made to pleasure partners, you feel no pain from the penetration only the pressure of her large member working your pussy with masterful effectiveness."+
		"You moan in delight as she fucks you up to the cervix for several minutes, your belly bulging due to the sheer size of her cock." +
		"Your eyes roll back as her cock drives your pussy completely crazy.. Hell, she has even more stamina than her sire! After a while, you feel her massive shaft twitch inside you as she readies to unload.\n\n"+
		"<i>\"Ahhhh mom.. I can’t hold it anymore!\"</i>\n\n"+
		"A huge volume of cum shoots into you, filling your womb until it’s full enough to make you look pregnant already."+
		"You feel her removing her cock from your pussy as you pass out on the grass exhausted by the experience.\n\n"+
		"When you wake up you find " + _name + " sleeping with her head on your lap… seemingly protecting your inflated belly.");
		if (player.hasVirginVagina()) outputText("Checking on your privates, you’re not surprised to discover you did, indeed, keep your virginity in spite of the crazy ride the young centauress gave you. "+
		"By now you already figured this is a common thing among unicorns.");
		outputText("You feel something change in you as the corrupted cum reaches your womb.");
		doHeatOrRut();
	}


	private function incestPureCorruption():void{
		clearOutput();
		outputText(_name + "suddenly starts moaning as she holds her horns with both hands.\n\n"+
		"<i>\"Ahhhh so good… this feels way too good!…Mom, please look!\"</i>\n\n"+
		"You watch spellbound as her horns suddenly fissures by the center, dividing into a duo of parallel horns, a symbol of her newfound corruption.\n"+
		"Her formerly pure white fur starts to darken to pitch black as her eyes’ irises lose their azure blue, changing shade towards a fiendish red. Even her hairs changes silks of silver replacing her former platinum blonde strands.\n" +
		"She holds her horns like a pair of dicks, playing her hands along their length as if trying to masturbate them.\n"+
		"Speaking of which, her 25 inch long horse cock is now fully erect and throbbing, almost as if an invisible hand was toying with it, a thick flow of precum steadily seeping out already.\n"+
		"And as her horns finish repositioning on each side of her forehead, her horsecock explodes, splattering much of the ground, covering it in white. " + _name + " seems to have embraced her inner corruption.\n\n"+
		"<i>\"Mom… I feel so energised, and hot... please... help me get that throbbing thing to calm down.\"</i>\n\n"+
		"This is a… somewhat unusual situation, but it’s something you can understand.\n"+
		"You approach your girl’s massive tool and give it a few experimental strokes, making " + _name + " gasp in surprise.\n"+
		"You lick the flared tip to get a taste. Satisfied with it you then proceed to put the thing in your mouth proper. " + _name + " moans as her horse dong throbs in appreciation for the attention you’re giving it.\n"+
		"You suck on her cock until she finally orgasms, the sweet cum flooding your throat.");
		outputText("\t\t\t\tWeirdly enough, you feel something change in you as the corrupted cum reaches your stomach. ");
		doNext(camp.returnToCampUseOneHour);
	}

	private function incestMasturbate():void{
		clearOutput();
		outputText("You simply help her by masturbating her horse dong to satisfaction." + _name + " thanks you afterward and goes to sit in a corner to rest.");
		doNext(camp.returnToCampUseOneHour);
	}

	private function incestFuckCorrupt():void{
		clearOutput();
		outputText("It’s not everyday you get to see a centauress with such a fine pussy");
		if(player.hasStatusEffect(StatusEffects.TelAdre))outputText(" beside Edryn's of course");
		outputText(".\n"+
		"You ponder for a split second the implications of what you’re about to do, it’s about how long it takes you to dismiss them.\n"+
		"Amongst all of the people you know, the only one even remotely likely of still being a virgin is your daughter and with the way she debauches herself on a daily basis using the natural fauna");
		if(player.hasKeyItem('Fake Mare') >= 0 || player.hasKeyItem('Centaur Pole') >= 0) outputText(" or the toys you brought back from Whitney’s farm");
		outputText(", you’re pretty sure her innocence died out a long time ago. " + _name + " is a big girl with… equally big assets, but today what you’re interested in is her gaping horsecunt.\n");
		if(silly())outputText("\nYou monster.\n\n");
		outputText("When you mention it to her, she doesn't even seem surprised, aside from asking what took you so long.\n"+
		"Merely smiling while teasingly flaunting her moistening cunt toward you, taunting you to take her already.\n\n" +
		"<i>\"Mommy wanna play daddy today? Sure, I can get in front of that ride.\"</i>"+
		"That being all the encouragement you need, you position yourself behind her and ram your [cock] into her warm gaping cunt without hesitation.\n"+
		"She moans in delight as you force in as much of your cock as you can while looking for the perfect angle. "+ _name + " taunts you with dirty talk all the while.\n\n" +
		"<i>\"Mom, please defile me as much as you want, punish my sinful pussy!\"</i>\n\n" +
		"Sinful, eh? Like mother like daughter. Her pussy, despite its size, acts as if it had a mind of its own, squeezing your cock as if trying to smother it."+
		"You would suspect her of having some succubus blood were you not aware of her actual heritage.\n\n" +
		"<i>\"Tired already, mom? C’mon, you can screw me better than that! Or, perhaps, you'd rather be the one to be screwed?\" </i>\n\n" +
		"Oh, is that a little brat mocking you that you hear? Can’t have that, right? Let’s educate her!\n" +
		"You proceed to wildly fuck your nymphomaniac daughter’s hole, responding to her earlier assault with a flurry of aggressive thrusts.\n\n"+
		"<i>\"Aaaaah Yes! Defile me! Use me to your heart's content!\"</i>\n\n" +
		"In the end, you manage to outlast her. With a scream, you orgasm, a handful of seconds after she does. You flood her thirsty cunt with your cum, making her moan in delight.\n"+
		"As expected, nothing spills out of her pussy, even after the both of you lay down in the grass to rest.\n\n" +
		"You snuggle for a time with "+ _name +" then head back to your daily routine. ");
		doHeatOrRut();
	}

	private function incestCentaurToys():void{
		outputText("\n\nYou point at the centaur toys and she swiftly gallops to them with a clear idea of how to use them.\n"+
		"Well that's one problem solved.");
		doNext(camp.returnToCampUseOneHour);
	}

	private function doHeatOrRut():void{
		outputText("\n\nLewd images of cocks " +(player.isMaleOrHerm()?"and vaginas":"")+"of all sizes and shapes fill your mind, making you drool in anticipation.\n"+
		"It seems your daughter’s condition is spreading over to you.");
		if (player.goIntoHeat(true,10)){
			//outputText("You are now in Heat!");
		}
		else if (player.goIntoRut(true, 10)) {
			//outputText("You are now in Rut!");
		}
		doNext(camp.returnToCampUseOneHour);
	}

	private function celessChildAppearance():void{
		clearOutput();
		outputText("Your daughter "+ _name +" is a ");
		if (isCorrupt){
			outputText("bicorn with abyssal black fur. " +
			"Her red eyes shine with a glimmer of sinister mischief and depravity, you sometimes ponder whether or not she is the spawn of a demon rather than you. \n\n"+
			"Her hairs are silver. She wanders around in a black dress. By the look of it, you'd think she stole it from a nun of the church of the fetish as it emphasises her generous "+
			(isAdult?"E":"D") + " cup breasts and put the focus on her assets.\n\n");
		}
		else{
			outputText("unicorn with immaculate white fur. "+
			"Her blue eyes are the most innocent you've seen on Mareth, if angels did exist, she would be one. Her hairs are platinum blonde.\n\n" +
			"She wanders around in a white dress that covers her more than decent" +
			(isAdult?"E":"D") + " cup breasts, though where she found it is a mystery even to you. Maybe it was a gift from her father, though she never returned "+ (silly()?"from her cigarrette run ":"") +"to reclaim her.\n\n");
		}
		outputText(_name + " inherited a massive horsecock from her father. Easily "+
		(isAdult?"25":"15") + " inches long, this beast can apparently, if the tales are true, pierce through anything. ");
		if (isCorrupt){
			outputText("She regularly uses it to fuck any imps and goblins alike unfortunate enough to be near when she is horny.\n\n");
		}
		else{
			outputText("She tends to be afraid of it, still too young and pure to understand how to properly use it.\n\n");
		}
		outputText("Just like all centauresses, " + _name + " has a horse vagina behind her hindquarter. ");
		if (isCorrupt){
			outputText("Knowing her well, she likely already has taken enough cock down that way to beat a succubus at the art of fucking. Your lascivious daughter is far from virgin.\n\n");
		}
		else{
			outputText("You pray that she will not lose her virginity to some corrupt creature. It will be your duty as a parent to preserve her innocence for as long as possible in this messed up world.\n\n");
		}
		doNext(campInteraction);
	}

	public function pureChildCorruption():void{
		if (player.cor > 80){
			_corruption++;
			if (isCorrupt) {
				menu();
				//addButton(0, "Next", incestScene, "pureCorruption");
				addButton(0, "Next", incestPureCorruption);
			}
			else {
				outputText("Just as you're about to go, however, you catch a glimpse of" + _name +"’s horse dong as it resumes acting up, just as you wanted. " +
						"You’ll need to keep her constantly aroused to educate her properly and set her on the path to depravity if she's to become a proper daughter of yours.");
				dynStats("cor", -1);
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}

	/*
	private function incestScene(sceneName:String):void {
		var toDisplay:String = "strings/incest/" + sceneName;
		scene(toDisplay, myLocals);
		if (sceneName == "pureIncest" && player.cor > 80) {
			_corruption++;
			if (isCorrupt) {
				menu();
				addButton(0, "Next", incestScene, "pureCorruption");
				addButton(0, "Next", incestPureCorruption);
			}
			else {
				outputText("Just as you're about to go, however, you catch a glimpse of" + _name +"’s horse dong as it resumes acting up, just as you wanted. " +
						"You’ll need to keep her constantly aroused to educate her properly and set her on the path to depravity if she's to become a proper daughter of yours.");
				dynStats("cor", -1);
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
	*/
	
	private function get myLocals():*{
		return {
			$name : _name,
			$isCorrupt : isCorrupt,
			$isAdult : isAdult
		}
	}
}
}