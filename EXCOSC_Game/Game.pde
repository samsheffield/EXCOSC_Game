class Game {

	ArrayList<State> state;
	

	Game(){
		state = new ArrayList<State>();
		state.add(new MenuState());
	}

	void play(){
		for (int i = state.size()-1; i >= 0; i--){
			if(state.get(i).finish){
				switch (state.get(i).switch_state){
					case 0 : state.add(new MenuState()); break;
					case 1 : state.add(new PlayState()); break;
					case 2 : state.add(new EndState()); break;
				}
				state.remove(state.get(i));
			}
			else {
				state.get(i).draw();
			}
				
		}
	}
}