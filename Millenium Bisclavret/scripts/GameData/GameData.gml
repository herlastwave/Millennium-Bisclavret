global.actionLibrary =
{
    taunt: {
        name: "Taunt",
        description: "{0} put himself in harm's way to momentarily become stronger.",
        subMenu: -1,
        targetRequired: false,
        targetEnemyByDefault: false,
        //effectSprite: undefined,
        effectOnTarget: MODE.ALWAYS,
        func: function(_user, _targets) {
            //taunt code 
            _user.isBlocking=false;
            oBattle.tauntCounter++;

            show_debug_message("taunted")
        }
    },
    block: {
        name: "Block",
        description: "{0} blocked.",
        subMenu: -1,
        targetRequired: false,
        targetEnemyByDefault: false,
        //effectSprite: undefined,
        effectOnTarget: MODE.ALWAYS,
        func: function(_user) {
            //block code
            
            _user.isBlocking=true;
            if (oBattle.tauntCounter>0) {
                oBattle.tauntCounter=0;
            }
        }
    },
    attack: {
        name: "Strike",
        description: "{0} struck!",
        subMenu: -1,
        targetRequired: true,
        targetEnemyByDefault: true,
        targetAll: MODE.NEVER,
        effectSprite: sAttack,
        effectOnTarget: MODE.ALWAYS,
        func: function(_user, _targets) {
            _user.isBlocking=false;
            var _damage=ceil(_user.strength);
            if (oBattle.tauntCounter>0) {
                _damage=2*_user.strength;
                oBattle.tauntCounter=0;
            }
            BattleChangeHP(_targets[0],-_damage,0);
            
        }
    },
    charge: {
        name: "Charge",
        description: "{0} charged and struck!",
        subMenu: "Special",
        targetRequired: true,
        targetEnemyByDefault: true, //0: party/self, 1: enemy
        targetAll: MODE.NEVER,
        effectSprite: sAttack,
        effectOnTarget:  MODE.ALWAYS,
        func: function(_user, _targets) {
            var _damage=ceil(_user.strength*2);
            BattleChangeHP(_targets[0], -_damage);
            //deplete user hp by 1
            BattleChangeHP(_user, -1);
        }
    },
    flee: {
        name: "Flee",
        description: "{0} fled...",
        subMenu: -1,
        targetRequired: false,
        targetEnemyByDefault: false, //0: party/self, 1: enemy
        targetAll: MODE.NEVER,
        //effectSprite: undefined,
        effectOnTarget:  MODE.ALWAYS,
        func: function(_user) {
            _user.isBlocking=false;
            oBattle.fleeing=true;
            show_debug_message("fled")
        }
    },
    
    enemyActive: {
        name: "Enemy Active",
        description: "{0} struck!",
        subMenu: -1,
        targetRequired: true,
        targetEnemyByDefault: false, //0: party/self, 1: enemy
        targetAll: MODE.NEVER,
        effectSprite: sAttack,
        effectOnTarget:  MODE.ALWAYS,
        func: function(_user, _targets) { 
            var _damage=ceil(_user.strength);
            BattleChangeHP(_targets[0],-_damage,0);
            //deplete user hp by 1
        }
    },
    enemyPassive: {
        name: "Enemy Passive",
        description: "{0} faltered and missed the chance to strike.",
        subMenu: -1,
        targetRequired: false,
        targetEnemyByDefault: false, //0: party/self, 1: enemy
        targetAll: MODE.NEVER,
        //effectSprite: undefined,
        effectOnTarget:  MODE.ALWAYS,
        func: function(_user) {
            show_debug_message("enemy Passive");
        }
    }
    
    
}

enum MODE {
    NEVER=0,
    ALWAYS=1,
    VARIES=2
}


global.player = [
    {
        name: "Bisclavret",
        hp: 3,
        hp_max: 3,
        strength: 1,
        isBlocking: false,
        isTaunting: true,
        sprites: {idle: battle_player},
        actions: [global.actionLibrary.block, global.actionLibrary.attack, global.actionLibrary.taunt, global.actionLibrary.flee]
        
    }
]

global.enemies = {
    renee: {
        name: "Renée",
        postBattleNode: "ReneePostBattle",
        hp: 5,
        hp_max: 5,
        isBlocking: false,
        strength: 1,
        sprites: {idle: battle_renee},
        activeLine: "Renée remembers. She narrows her eyes.",
        passiveLine: "Renée is thinking about updating her licked-in status. She seems distracted... Isn't this a fight?",
        actions: [/*global.actionLibrary.attack*/ global.actionLibrary.enemyActive, global.actionLibrary.enemyPassive],
        AIscript : function() {
            //attack random target (alaways bisclavret)
            /*var _action = actions[0];
            var _possibleTargets=array_filter(oBattle.playerUnits, function(_unit, _index) {
                return(_unit.hp>0);
            });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
            return [_action, _target];*/
            
            //0 = active, 1=passive
            if (oBattle.activeOrPassive==1) {
                var _action = actions[0];
                var _possibleTargets=array_filter(oBattle.playerUnits, function(_unit, _index) {
                    return(_unit.hp>0); 
                });
                //var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
                var _target = oBattle.playerUnits[0];
                return [_action, _target];
            }
            else {
                var _action=actions[1];
                var _target=oBattle.playerUnits[0];
                return [_action, _target];
            }
        }
    },
    letheque: {
        name: "LeThéque",
        postBattleNode: "LethequePostBattle",
        hp: 5,
        hp_max: 5,
        isBlocking: false,
        strength: 1,
        sprites: {idle: battle_lethqeue},
        activeLine: "Le Active line.",
        passiveLine: "Le passive line.",
        actions: [/*global.actionLibrary.attack*/ global.actionLibrary.enemyActive, global.actionLibrary.enemyPassive],
        AIscript : function() {
            //attack random target (alaways bisclavret)
            /*var _action = actions[0];
            var _possibleTargets=array_filter(oBattle.playerUnits, function(_unit, _index) {
                return(_unit.hp>0);
            });
            var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
            return [_action, _target];*/
            
            //0 = active, 1=passive
            if (oBattle.activeOrPassive==1) {
                var _action = actions[0];
                var _possibleTargets=array_filter(oBattle.playerUnits, function(_unit, _index) {
                    return(_unit.hp>0); 
                });
                //var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
                var _target = oBattle.playerUnits[0];
                return [_action, _target];
            }
            else {
                var _action=actions[1];
                var _target=oBattle.playerUnits[0];
                return [_action, _target];
            }
        }
    },
    guarin: {
        name: "Guarin",
        hp: 8,
        hp_max: 8,
        strength: 1,
        sprites: {idle: battle_enemy},
        actions: [global.actionLibrary.attack],
        AIscript : function() {
            
        }
    },
}