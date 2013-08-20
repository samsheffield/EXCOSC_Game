class Particle {
	PImage particle_image, particle_bg_image;

	float x, y, size, x_speed, y_speed, max_speed, gravity, r_speed, rotation;
	color c;
	float world_floor;

	Particle(float _x, float _y, color _c){
		c = _c;
		size = random(10, 20);
		x_speed = random(-25, 25);
		y_speed = random(-20, -10);
		max_speed = 25;
		x = _x;
		y = _y;
		gravity = 5;
		world_floor = 672;
		particle_image = loadImage("candy.png");
		particle_bg_image = loadImage("candy_bg.png");
	}

	void update(){
		x += x_speed;
		y += y_speed;

		if(int(x_speed) != 0)
			x_speed += (0-x_speed)*.05;
		else
			x_speed = 0;

		println("var: "+x_speed);

		if(y_speed < max_speed)
			y_speed += gravity;
		else
			y_speed = max_speed;

		if(y+size/1.61 > world_floor){
			y = world_floor-size/2;
			gravity = 0;
		}
		else if (y-size/2 < 96){
			y = 96+size/2;
		}else{
			gravity = 5;
		}
		
		r_speed = x_speed;
		rotation += r_speed*3;
		//y_velocity += gravity;

		if(x > 1232 - size/2)
			x = 1232-size/2;
		if(x <  48+size/2)
			x = 48+size/2;
	}

	void draw(){
		noStroke();
		pushMatrix();
		imageMode(CENTER);
		translate(x,y);
		rotate(radians(rotation));
		image(particle_bg_image, 0, 0, size+6, size+6);
		tint(c);
		image(particle_image, 0, 0, size+6, size+6);
		noTint();
		imageMode(CORNER);
		popMatrix();
		
	}
}