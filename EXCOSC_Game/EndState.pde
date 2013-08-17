/*
EndState

Make a GAME OVER screen and put it here.
EndState can be switched to from any other state with switch_state = 2;
*/

class EndState extends State {

	EndState(){
		super();
		switch_state = 0;
	}

	void draw(){
		super.draw();

		// Press any key or click mouse to return to 
		if(keyPressed || mousePressed)
			finish = true;
	}
}