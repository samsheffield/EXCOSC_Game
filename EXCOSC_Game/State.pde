class State {
	boolean finish;		// When this is set to true, it signals parent class to switch to another state.
	int switch_state;	// Switch to this state when finished (0: Menu, 1: PlayState, 2: EndState)
	Utilities utilities;
	int score, hiscore;

	State(){
		finish = false;
		utilities = new Utilities();
	}

	void draw(){
		background(0);
	}

}