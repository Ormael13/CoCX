package classes.Scenes.NPCs {
import classes.Items.Consumables.VampireBlood;
import classes.Scenes.Camp;

import coc.view.ButtonDataList;

import flash.utils.getQualifiedClassName;

public class DivaScene extends XXCNPC{
    private static var _instance:DivaScene;

    public var status:int;
    private var firstLoss:Boolean=true;
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
            throw new Error("Singleton class. Use getInstance() to access");
        }
    }
    public static function getInstance():DivaScene{
        if(!_instance){
            new DivaScene();
        }
        return _instance;
    }
    public static function get instance():DivaScene{
        return getInstance();
    }
    public override function unload():void{
        Camp.removeFollower(_instance);
        removeSavedNPC(_instance);
        _instance = null;
    }
    public override function save(saveto:*):void{
        saveto.diva = {
            myClass:getQualifiedClassName(this),
            status:status,
            firstLoss:firstLoss,
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
            VampireBlood.first = loadfrom.diva.bloodUsed;
        }
    }
    public override function isCompanion(type:int = -1):Boolean{
        if(type == LOVER || type == COMPANION)return status == -1;
        return false;
    }
    override public function campDescription(menuType:int = -1, descOnly:Boolean = false):Boolean {
        if(isCompanion(menuType)){
            if(time.hours > 20){
                display("camp/campDescript/evening");
            } else if( time.hours <= 7){
                display("camp/campDescript/night");
            } else {
                display("camp/campDescript/day");
            }
            addButton(10,"Diva",campInteraction);
            return descOnly;
        }
        return false;
    }
    override public function campInteraction():void{
        clearOutput();
        menu();
        if(time.hours > 20){
            display("camp/campInteraction/dusk");
        } else {
            display("camp/campInteraction/night");
        }

        addButton(0,"Talk",talkMenu);
        addButton(1,"Sex",sexMenu);
        addButton(14,"Back",camp.campLoversMenu);

        flushOutputTextToGUI();
        function talkMenu():void
        {
            clearOutput();
            display("camp/talkMenu/menu");
            setupTalkMenu();
            submenu(_talkMenu,campInteraction);
            flushOutputTextToGUI();
        }
        function sexMenu():void
        {
            clearOutput();
            display("camp/sexMenu/menu");
            setupSexMenu();
            submenu(_sexMenu,campInteraction);
            flushOutputTextToGUI();
        }
        function setupTalkMenu():void{
            _talkMenu.clear();
            _talkMenu.add("Vampirism",vampirism);
            _talkMenu.add("Sunlight",sunlight);
            _talkMenu.add("Her",her);

            function vampirism():void{scene("camp/talkMenu/vampirism",talkMenu);}
            function sunlight():void{scene("camp/talkMenu/sunlight",talkMenu);}
            function her():void{scene("camp/talkMenu/her",talkMenu);}
        }
        function setupSexMenu():void{
            _sexMenu.clear();
            _sexMenu.add("Moonlight Sonata",moonlightSonata);
            _sexMenu.add("Share A Meal",shareAMeal).disableIf((player.vampireScore() < 6)|| !(player.faceType == FACE_VAMPIRE));
            _sexMenu.add("Bloody Rose",bloodyRose).disableIf((player.vampireScore() < 6) || !(player.faceType == FACE_VAMPIRE));

            function shareAMeal():void{scene("camp/sexMenu/shareAMeal");}
            function bloodyRose():void{scene("camp/sexMenu/bloodyRose");}
        }
    }

    public function moonlightSonata(fromCombat:Boolean=false):void{
        if(status == 0){status = 1;}
        clearOutput();
        if(fromCombat){
            display("camp/sexMenu/moonlightSonata/intro/combat");
        } else {
            display("camp/sexMenu/moonlightSonata/intro/camp");
        }

        if( player.biggestCockLength() > 24) {
            display("camp/sexMenu/moonlightSonata/male/tooBig");
            player.cocks[player.biggestCockIndex()].cockLength = 18;
            if(timesReduced < 5){timesReduced++;}
        }
        if(player.batScore() >= 6 || player.vampireScore() >= 6){
            if(player.isFemale()){display("camp/sexMenu/moonlightSonata/female/bat");}
            else if(player.isMaleOrHerm()){
                display("camp/sexMenu/moonlightSonata/female/bat");
                display("camp/sexMenu/moonlightSonata/male/regular",{$combat:fromCombat})
            }
        } else if(player.isMaleOrHerm()){
            display("camp/sexMenu/moonlightSonata/male/regular",{$combat:fromCombat});
        } else {
            display("camp/sexMenu/moonlightSonata/female/regular",{$combat:fromCombat});
        }
        if(fromCombat){
            if(firstLoss){
                display("camp/sexMenu/moonlightSonata/outro/combat/initial");
            } else {
                display("camp/sexMenu/moonlightSonata/outro/combat/regular");
            }
            firstLoss=false;
        } else{
            display("camp/sexMenu/moonlightSonata/outro/camp");
        }
        if(!fromCombat){
            doNext(camp.returnToCampUseOneHour);
            flushOutputTextToGUI();
        }
    }
    public function encounter():void{
        if(status == 2){
            scene("combat/scenes/intro/final");
            startCombat(new Diva(true));
        } else {
            if(status == 0){scene("combat/scenes/intro/first");}
            else{scene("combat/scenes/intro/second");}

            startCombat(new Diva);
        }
    }
    internal function scene(ref:String,next:Function=null):void{
        clearOutput();
        doNext(next==null?camp.returnToCampUseOneHour:next);
        display(ref);
        flushOutputTextToGUI();
    }
}
}
