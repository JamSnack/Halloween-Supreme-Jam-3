/// @description
p_id = 0; //which player owns this object; pass player_id into this object on instantiation.
p_n = ""; //The playername of this object
moved = false; //If the player's position has changed since the last heartbeat

death_timer_reset = room_speed*600;
death_timer = death_timer_reset;