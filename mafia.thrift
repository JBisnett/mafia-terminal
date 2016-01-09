namespace rb RocHack.Mafia

service MafiaServer {
  // add player to game
  bool join_game(1:string name, 2:string host, 3:i32 port);
  
  // take action on a target
  bool take_action(1:i32 action, 2:string target);

  // message on public forum
  bool public_message(1:string message);

  // message to group (masons, mafia, etc.)
  bool group_message(1:i32 group_id, 2:string message);

  // message to player
  bool private_message(1:string player_name, 2:string message);
}

service MafiaPlayer {
  
  // informs player the game has begun
  void start_game(1:list<string> player_names, 2:set<string> modifiers)
  
  // informs player they have died
  void kill(1:string message);

  // informs player the next time frame has begun
  void time_forward();

  // send message to player
  void server_message(1:string message);

  // inform player of role
  void set_role(1:string role);
}
