class State {
	boolean finish;		// When this is set to true, it signals parent class to switch to another state.
	int switch_state;	// Switch to this state when finished (0: Menu, 1: PlayState, 2: EndState)
	
	int score, hiscore;

	State(){
		finish = false;
		score = 0;
		hiscore = 0;
	}

	void draw(){
		background(0);
	}

	void addScore(int _color){
		fill(_color);
		textAlign(LEFT, BOTTOM);
		text("SCORE: " + score, 16, 48);
		textAlign(RIGHT, BOTTOM);
		text("HI SCORE: " + hiscore, 1264, 48);
	}

}