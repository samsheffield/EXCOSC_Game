class EndState extends State {
	PImage end_image;
	int start_frame, trigger_frame;

	EndState(){
		super();
		end_image = loadImage("end.png");
		switch_state = 0; // Back to menustate
		start_frame = frameCount;
		trigger_frame = 100;
	}

	void draw(){
		//super.draw();
		image(end_image, 0, 0);
		addScore(255);
		
		if(frameCount == start_frame + trigger_frame)
			finish = true;
	}
}