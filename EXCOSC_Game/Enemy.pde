class Enemy extends Sprite{
	PImage enemy_image;

	float x_direction, y_direction, x_speed, y_speed;
	color[] colors = {#ff0000, #00ff00, #0000ff};
	color c = #000000;
	int current_color;
	int id;
	float r_speed;

	Enemy(float _x, float _y){
		super(_x, _y);
		x_size = 64;
		y_size = 64;
		size = 64;
		enemy_image = loadImage("enemies.png");
		addAnimation(enemy_image, 64,64);
		seek(int(random(8)));
		pause();

		if(int(random(2)) == 0)
			x_direction = -1;
		else
			x_direction = 1;

		if(int(random(2)) == 0)
			y_direction = -1;
		else
			y_direction = 1;

		x_speed = random(1, 10);
		y_speed = random(1, 10);
		current_color = int(random(colors.length));
		r_speed = random(-15, 15);
		c = color(random(255), random(255), random(255));
	}

	void update(){
		if (x < 48+(size/2) || x > 1232-(size/2))
			x_direction *= -1;
			
		if (y < 96+(size/2) || y > 672-(size/2))
			y_direction *= -1;

		x += x_speed*x_direction;
		y += y_speed*y_direction;

		//c = colors[current_color];

		rotation+= r_speed;

		super.update();
	}

	void draw(){
		tint(c);
		super.draw();
		noTint();
	}

	void respawn(){
		x = random(81, 1199);
		y = random(129, 639);
		x_speed = random(1, 10);
		y_speed = random(1, 10);
	}
}