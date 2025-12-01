instance_deactivate_all(true);

units = [];
turn=0;
unitTurnOrder=[];
unitRenderOrder=[];

turnCount =0;
roundCount=0;
battleWaitTimeFrames=60;
battleWaitTimeRemaining=0;
battleText="Battle state startup placeholder text.";
current_text_index=0;
currentUser=noone;
currentAction=-1;
currentTargets=noone;

tauntCounter=0;

cursor = {
    activeUser: noone,
    activeTarget: noone,
    activeAction: -1,
    targetSide:-1,
    targetIndex:0,
    targetAll:false,
    confirmDelay:0,
    active:false
};

menu_hover=0;

var enemy_pos_x=display_get_width()-600;
var enemy_pos_y=360;

var player_pos_x=545;
var player_pos_y=345;

//make enemies
for (var i=0; i< array_length(enemies); i++) {
    enemyUnits[i]=instance_create_depth(x+enemy_pos_x+(i*10), y+enemy_pos_y+(i*20), depth-10, oBattleUnitEnemy, enemies[i]);
    array_push(units, enemyUnits[i]);
}

//make player
for (var i=0; i< array_length(global.player); i++) {
    playerUnits[i]=instance_create_depth(x+player_pos_x+(i*10), y+player_pos_y+(i*20), depth-10, oBattleUnitPlayer, global.player[i]);
    array_push(units, playerUnits[i]);
}

//shuffle turn order
unitTurnOrder=array_concat(playerUnits,enemyUnits);

//get render order
RefreshRenderOrder = function() {
    unitRenderOrder=[];
    array_copy(unitRenderOrder,0,units,0,array_length(units));
    array_sort(unitRenderOrder,function(_1,_2) {
        return _1.y-_2.y;
    });
}
RefreshRenderOrder();

function BattleStateSelectAction() {
    
    if (!instance_exists(oMenu)) {
        
       //get current unit
       var _unit = unitTurnOrder[turn];
       
       //is this unit dead or unable to act?
       if ((!instance_exists(_unit)) || (_unit.hp <= 0)) {
           battleState = BattleStateVictoryCheck;
           exit;
       }
       //select action to perform
       //BeginAction(_unit.id, global.actionLibrary.attack, _unit.id)
       
       //if unit is player controlled:
       if (_unit.object_index==oBattleUnitPlayer) {
          //compile the action menu
            show_debug_message(tauntCounter);
            
            
            var _menuOptions=[];
            var _subMenus = {};
            
            var _actionList=_unit.actions;
        
            for (var i =0; i<array_length(_actionList); i++) {
                var _action=_actionList[i];
                var _available=true; //later will check conditions
                var _nameAndCount = _action.name; //later will modify name to include item count if item.
                if (_action.subMenu == -1) {
                    array_push(_menuOptions, [_nameAndCount, MenuSelectAction,[_unit, _action], _available]);
                }
                else {
                    //create submenu or add to submenu
                    if (is_undefined(_subMenus[$ _action.subMenu])) {
                        variable_struct_set(_subMenus, _action.subMenu, [[_nameAndCount, MenuSelectAction, [_unit, _action], _available]]);
                    }
                    else {
                        array_push(_subMenus[$ _action.subMenu],[_nameAndCount,MenuSelectAction,[_unit,_action],_available]);
                    }
                }
            }
                
            //turn submenu into array
            var _subMenusArray = variable_struct_get_names(_subMenus);
            for (var i =0; i<array_length(_subMenusArray); i++) {
                //sort submenu if needed here
                
                //add back option at end of each submenu
                array_push(_subMenus[$ _subMenusArray[i]], ["Back", MenuGoBack, -1, true]);
                //add submenu back to main menu
                array_push(_menuOptions, [_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true]);
            }
            
            Menu(x+300, y+450, _menuOptions);
            
       }
       else {
           var _enemyAction=_unit.AIscript();
           if (_enemyAction != -1) {
               BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
           }
       }
    }
}

function BeginAction(_user, _action, _targets) {
    currentUser = _user;
    currentAction = _action;
    currentTargets= _targets;
    battleText=string_ext(_action.description, [_user.name]);
    if (!is_array(currentTargets)) {
        currentTargets=[currentTargets];
    }
    battleWaitTimeRemaining=battleWaitTimeFrames;
    with (_user) {
        acting=true;
        //play animation if it is defined for that action/user
        if ((!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))) {
            sprite_index=sprites[$ _action.userAnimation];
            image_index=0;
        }
    }
    battleState=BattleStatePerformAction;
}

function BattleStatePerformAction() {
    //if animation etc is still playing
    if (currentUser.acting) {
        //when it ends, perform action effect if it exists
        if (currentUser.image_index >= currentUser.image_number -1) {
            with (currentUser) {
                sprite_index=sprites.idle;
                image_index=0;
                acting=false;
            }
        
    
           if (variable_struct_exists(currentAction, "effectSprite")) {
               if (currentAction.effectOnTarget==MODE.ALWAYS) || ((currentAction.effectOnTarget==MODE.VARIES) && (array_length(currentTargets)<=1)) {
                   for (var i =0; i<array_length(currentTargets); i++) {
                       instance_create_depth(currentTargets[i].x,currentTargets[i].y,currentTargets[i].depth-1,oBattleEffect,{sprite_index:currentAction.effectSprite});
                   }
               }
               else { // play at 0,0
                   var _effectSprite = currentAction.effectSprite;
                   if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) {
                       _effectSprite=currentAction.effectSpriteNoTarget;
                   }
                   instance_create_depth(x,y,depth-100,oBattleEffect,{sprite_index: _effectSprite})
               }
           }
           currentAction.func(currentUser, currentTargets);

        }
    }
    else {//wait for delay and then end turn
        if (!instance_exists(oBattleEffect)) {
            battleWaitTimeRemaining--

            if (battleWaitTimeRemaining==0) {
                battleState=BattleStateVictoryCheck;
            }
        }
    }
}

function BattleStateVictoryCheck() {
    RefreshPlayerHealthOrder=function(){
        PlayerUnitsByHP=[];
        array_copy(PlayerUnitsByHP,0,playerUnits,0,array_length(playerUnits));
        array_sort(PlayerUnitsByHP, function(_1,_2) {
            return _2.hp - _1.hp;
        });
    }
    RefreshPlayerHealthOrder();
    
    RefreshEnemyHealthOrder = function() {
        EnemyUnitsByHP=[];
        array_copy(EnemyUnitsByHP,0,enemyUnits,0,array_length(enemyUnits));
        array_sort(EnemyUnitsByHP, function(_1,_2) {
            return _2.hp - _1.hp;
        });
    }
    RefreshEnemyHealthOrder();
    
    if (PlayerUnitsByHP[0].hp <= 0) {
        room_goto(game_over);
    }
    
    if (EnemyUnitsByHP[0].hp<=0) {
        for (var i=0; i<array_length(global.player); i++) {
            //global.player[i].hp = playerUnits[i].hp;
        }
        
        instance_activate_all();
        //somehow tell chatterbox to switch to node
        
        //this obviously needs to change when more battles are implemented
        if (global.reneeFought==true) {
            objRene.node_name="ReneePostBattle";
            objRene.is_fightable="false";
        }
        

        instance_destroy();

        
    }
    
    
    battleState=BattleStateTurnProgression;
}

function BattleStateTurnProgression() {
    battleText="Battle state primary placeholder text."; //reset battle text
    current_text_index=0;
    
    //reset blocking to false for all players
    
    
    turnCount++;
    turn++;
    //loop turns
    if (turn>array_length(unitTurnOrder)-1) {
        turn=0;
        roundCount++;
    }
    battleState=BattleStateSelectAction;
}

battleState=BattleStateSelectAction;
