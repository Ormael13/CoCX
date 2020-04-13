package classes.Scenes.NPCs {
import classes.BodyParts.Face;
import classes.Items.Consumables.VampireBlood;
import classes.Scenes.Camp;
import classes.StatusEffects;
import classes.display.SpriteDb;

import coc.view.ButtonDataList;

import flash.utils.getQualifiedClassName;

public class DivaScene extends XXCNPC{
    private static var _instance:DivaScene;

    public var status:int;
    private var firstLoss:Boolean=true;
    public var tookVialToday:Boolean=false; // true if took her vial today
    private var timesReduced:int = 0;
    private var _talkMenu:ButtonDataList = new ButtonDataList();
    private var _sexMenu:ButtonDataList = new ButtonDataList();
    public function DivaScene() {
        if (!_instance) {
            super("diva");
            _instance = this;
            Camp.addFollower(this);
            addSavedNPC(this);
        } else {
            throw new Error("Singleton class. Use instance to access");
        }
    }
    public static function get instance():DivaScene{
	    if(!_instance){
		    new DivaScene();
	    }
	    return _instance;
    }
    public override function unload():void{
        Camp.removeFollower(_instance);
        _instance = null;
    }
    public override function save(saveto:*):void{
        saveto.diva = {
            myClass:getQualifiedClassName(this),
            status:status,
            firstLoss:firstLoss,
            tookVialToday:tookVialToday,
            timesReduced:timesReduced,
            bloodUsed:VampireBlood.first
        }
    }
    public override function load(loadfrom:*):void{
        if(loadfrom == undefined || loadfrom.diva == undefined){
            VampireBlood.first=true;
            unload();
        } else {
            status = loadfrom.diva.status;
            firstLoss = loadfrom.diva.firstLoss;
            timesReduced = loadfrom.diva.timesReduced;
            tookVialToday = loadfrom.diva.tookVialToday;
            VampireBlood.first = loadfrom.diva.bloodUsed;
        }
    }
    public override function isCompanion(type:int = -1):Boolean{
        if((type == LOVER || type == COMPANION) && !player.hasStatusEffect(StatusEffects.DivaOff)) return status == -1;
        return false;
    }
    override public function campDescription(buttons:ButtonDataList, menuType:int = -1):void {
        if(isCompanion(menuType)){
            if(time.hours > 20){
                display("camp/campDescript/evening");
            } else if( time.hours <= 7){
                display("camp/campDescript/night");
            } else {
                display("camp/campDescript/day");
            }
            buttons.add("Diva",campInteraction);
        }
    }
    override public function campInteraction():void{
        spriteSelect(SpriteDb.s_diva);
        if(time.hours > 20){
            scene("camp/campInteraction/dusk");
        } else {
            scene("camp/campInteraction/night");
        }
        addButton(0,"Talk",talkMenu);
        addButton(1,"Sex",sexMenu);
        addButton(14,"Back",camp.campLoversMenu);
        function talkMenu():void
        {
            clearOutput();
            display("camp/talkMenu/menu");
            setupTalkMenu();
            submenu(_talkMenu,campInteraction);
        }
        function sexMenu():void
        {
            clearOutput();
            display("camp/sexMenu/menu");
            setupSexMenu();
            submenu(_sexMenu,campInteraction);
        }
        function setupTalkMenu():void{
            _talkMenu.clear();
            _talkMenu.add("Vampirism",vampirism);
            _talkMenu.add("Sunlight",sunlight);
            _talkMenu.add("Her",her);
            _talkMenu.add("Vial",vialofliquid).disableIf(tookVialToday,"You asked for blood already, wait for tomorrow.");

            function vampirism():void{scene("camp/talkMenu/vampirism",talkMenu);}
            function sunlight():void{scene("camp/talkMenu/sunlight",talkMenu);}
            function her():void{scene("camp/talkMenu/her",talkMenu);}
            function vialofliquid():void {
				scene("camp/talkMenu/vialofliquid");
				tookVialToday = true;
				inventory.takeItem(consumables.REDVIAL, talkMenu);
			}
        }
        function setupSexMenu():void{
            _sexMenu.clear();
            _sexMenu.add("Moonlight Sonata",moonlightSonata);
            _sexMenu.add("Share A Meal",shareAMeal).disableIf((player.vampireScore() < 6)|| !(player.faceType == Face.VAMPIRE));
            _sexMenu.add("Bloody Rose",bloodyRose).disableIf((player.vampireScore() < 6) || !(player.faceType == Face.VAMPIRE));

            function shareAMeal():void{scene("camp/sexMenu/shareAMeal");}
            function bloodyRose():void{scene("camp/sexMenu/bloodyRose");}
        }
    }

    public function moonlightSonata(fromCombat:Boolean=false):void{
        var baseRef:String = "camp/sexMenu/moonlightSonata/";
        if(status == 0){status = 1;}
        clearOutput();
        if(fromCombat){
            display(baseRef + "intro/combat");
        } else {
            display(baseRef + "intro/camp");
        }

        if( player.biggestCockLength() > 24) {
            display(baseRef + "male/tooBig");
            player.cocks[player.biggestCockIndex()].cockLength = 18;
            if(timesReduced < 5){timesReduced++;}
        }
        if(player.batScore() >= 6 || player.vampireScore() >= 6){
            if(player.isFemale()){display(baseRef + "female/bat");}
            else if(player.isMaleOrHerm()){
                display(baseRef + "female/bat");
                display(baseRef + "male/regular",{$combat:fromCombat})
            }
        } else if(player.isMaleOrHerm()){
            display(baseRef + "male/regular",{$combat:fromCombat});
        } else {
            display(baseRef + "female/regular",{$combat:fromCombat});
        }
        if(fromCombat){
            if(firstLoss){
                display(baseRef + "outro/combat/initial");
            } else {
                display(baseRef + "outro/combat/regular");
            }
            firstLoss=false;
        } else{
            display(baseRef + "outro/camp");
        }
        if(!fromCombat){
            doNext(camp.returnToCampUseOneHour);
        }
    }
    public static function encounter():void{
        instance.spriteSelect(SpriteDb.s_diva);
        if(instance.status == 2){
            instance.scene("combat/scenes/intro/final");
            instance.startCombat(new Diva(true));
        } else {
            if(instance.status == 0){instance.scene("combat/scenes/intro/first");}
            else{instance.scene("combat/scenes/intro/second");}
            instance.startCombat(new Diva);
        }
    }
}
}
