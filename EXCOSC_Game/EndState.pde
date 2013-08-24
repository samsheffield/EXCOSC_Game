class EndState extends State {
	PImage end_image;
	int start_frame, trigger_frame;

	EndState(){
		super();
		int _i = int(random(4));
		end_image = loadImage("end" +_i +".png");
		switch_state = 0; // Back to menustate
		start_frame = frameCount;
		trigger_frame = 100;
	}

	void draw(){
		image(end_image, 0, 0);
		addScore(255);
		
		if(frameCount == start_frame + trigger_frame)
			finish = true;
	}
}