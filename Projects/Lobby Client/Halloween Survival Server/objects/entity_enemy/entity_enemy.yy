{
  "spriteId": {
    "name": "spr_enemy",
    "path": "sprites/spr_enemy/spr_enemy.yy",
  },
  "solid": false,
  "visible": true,
  "managed": true,
  "spriteMaskId": {
    "name": "spr_enemy",
    "path": "sprites/spr_enemy/spr_enemy.yy",
  },
  "persistent": false,
  "parentObjectId": {
    "name": "ENTITY",
    "path": "objects/ENTITY/ENTITY.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":3,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":1,"collisionObjectId":null,"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":0,"value":"10","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"max_hp","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"max_hp","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"hp","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"1","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"move_speed","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"TARGET_TYPE.normal","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"targeting_type","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"128","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"target_range","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"24","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"attack_range","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":4,"value":"get_next_id()","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"enemy_id","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"10","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"can_attack_block","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"10","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"can_attack_player","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"1","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"block_damage","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"1","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"player_damage","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"enemy_index","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"0.9","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"bounce_factor","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"0.25","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"torque","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"x_speed","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"0","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"y_speed","tags":[],"resourceType":"GMObjectProperty",},
    {"varType":0,"value":"CANDY.yellow","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"held_treat","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [],
  "parent": {
    "name": "Objects",
    "path": "folders/Objects.yy",
  },
  "resourceVersion": "1.0",
  "name": "entity_enemy",
  "tags": [],
  "resourceType": "GMObject",
}