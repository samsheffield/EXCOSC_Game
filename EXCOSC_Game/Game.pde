class Game {
	ArrayList<State> state;
	int score, hiscore;
	PFont font;

	Game(){
		state = new ArrayList<State>();
		state.add(new MenuState());
		font = loadFont("score_text_30.vlw");
		textFont(font, 30);
	}

	void play(){
		println(getPlayerOsc(0));
		for (int i = state.size()-1; i >= 0; i--){
			if(state.get(i).finish){
				switch (state.get(i).switch_state){
					case 0 : state.add(new MenuState()); state.get(i+1).hiscore = hiscore; break;
					case 1 : state.add(new PlayState()); state.get(i+1).score = score; state.get(i+1).hiscore = hiscore; break;
					case 2 : state.add(new EndState()); state.get(i+1).score = score; state.get(i+1).hiscore = hiscore; break;
				}
				state.remove(state.get(i));
			}
			else {
				score = state.get(i).score;
				if(score > hiscore)
					hiscore = score;
				state.get(i).draw();
			}
		}
	}
}