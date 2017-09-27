package classes.Scenes.NPCs {
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
            timesReduced:timesReduced
        }
    }
    public override function load(loadfrom:*):void{
        if(loadfrom == undefined || loadfrom.diva == undefined){
            unload();
        } else {
            status = loadfrom.diva.status;
            firstLoss = loadfrom.diva.firstLoss;
            timesReduced = loadfrom.diva.timesReduced;
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
        if(time.hours > 20){
            display("camp/campInteraction/dusk");
        } else {
            display("camp/campInteraction/night");
        }
        function subTalk():void{talkMenu();submenu(_talkMenu,campInteraction);}
        function subSex():void{sexMenu();submenu(_sexMenu,campInteraction);}

        addButton(0,"Talk",subTalk);
        addButton(1,"Sex",subSex);
        addButton(14,"Back",camp.campLoversMenu);

        flushOutputTextToGUI();
    }
    private function talkMenu():void{
        _talkMenu.clear();
        _talkMenu.add("vampirism",vampirism);
        _talkMenu.add("sunlight",sunlight);
        _talkMenu.add("Her",her);

        function vampirism():void{scene("camp/talkMenu/vampirism",talkMenu);}
        function sunlight():void{scene("camp/talkMenu/sunlight",talkMenu);}
        function her():void{scene("camp/talkMenu/her",talkMenu);}
    }
    private function sexMenu():void{
        _sexMenu.clear();
        _sexMenu.add("Moonlight Sonata",moonlightSonata);
        _sexMenu.add("Share A Meal",shareAMeal).disableIf((player.vampireScore() < 6)|| (!player.faceType == FACE_VAMPIRE));
        _sexMenu.add("Bloody Rose",bloodyRose).disableIf((player.vampireScore() < 6) || (!player.faceType == FACE_VAMPIRE));

        function shareAMeal():void{scene("camp/sexMenu/shareAMeal");}
        function bloodyRose():void{scene("camp/sexMenu/bloodyRose");}
    }
    public function moonlightSonata(fromCombat:Boolean=false):void{
        if(status == 0){status = 1;}
        clearOutput();
        if(!fromCombat){
            doNext(camp.returnToCampUseOneHour);
        }
        display("camp/sexMenu/moonlightSonata/intro"+fromCombat?"combat":"regular");
        if( player.biggestCockLength() > 24) {
            display("camp/sexMenu/moonlightSonata/male/tooBig");
            player.cocks[player.biggestCockIndex()].cockLength = 18;
            if(timesReduced < 5){timesReduced++;}
        }
        if(player.batScore() >= 6 || player.vampireScore() >= 6){
            display("camp/sexMenu/moonlightSonata/"+player.isFemale()?"fe":""+"male/bat");
            if(player.isMaleOrHerm()){
                display("camp/sexMenu/moonlightSonata/male/regular",{$combat:fromCombat})
            }
        } else {
            display("camp/sexMenu/moonlightSonata/"+player.isFemale()?"fe":""+"male/regular",{$combat:fromCombat});
        }
        if(fromCombat){
            display("camp/sexMenu/moonlightSonata/outro/combat/"+firstLoss?"initial":"regular");
            firstLoss=false;
        } else{
            display("camp/sexMenu/moonlightSonata/outro/camp");
        }
        flushOutputTextToGUI();
    }
    public function encounter():void{
        if(status == 2){
            scene("combat/scenes/intro/final");
            startCombat(new Diva(true));
        } else {
            scene("combat/scenes/intro/"+(status==0)? "first":"second");
            startCombat(new Diva);
        }
    }
    internal function scene(ref:String,next:Function=null):void{
        clearOutput();
        doNext(next==null?camp.returnToCampUseOneHour:next);
        display(ref);
    }
}
}
