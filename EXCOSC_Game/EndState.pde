class EndState extends State {
	PImage end_image;

	EndState(){
		super();
		end_image = loadImage("end.png");
		switch_state = 0; // Back to menustate
	}

	void draw(){
		//super.draw();
		image(end_image, 0, 0);
		addScore(255);
		
		if(keyPressed || mousePressed)
			finish = true;
	}
}