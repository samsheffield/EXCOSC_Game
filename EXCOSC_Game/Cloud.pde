class Cloud extends Sprite{
	PImage cloud_image;
	float x_direction, y_direction, x_speed, y_speed;
	int opacity;

	Cloud(float _x, float _y){
		super(_x, _y);
		cloud_image = loadImage("cloud.png");
		addAnimation(cloud_image, 128, 80);
		pause();

		x_size = 128;
		y_size = 80;
		size = x_size;
		x_direction = 1;
		straightMovement(5, 10);
	}

	void update(){
		bounce();
		x += x_speed*x_direction;
		super.update();
		if(opacity > 0)
			opacity -= 5;
	}

	void draw(){
		tint(255, opacity);
		super.draw();
		noTint();
	}

	void bounce(){
		if (x < 48+(size/2) || x > 1232-(size/2))
			x_direction *= -1;
	}

	void straightMovement(float _min_speed, float _max_speed){
		x_speed = random(_min_speed, _max_speed);
	}

	void activate(){
		opacity = 255;
	}
}