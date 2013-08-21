class Particle extends Sprite{
	float max_velocity;
	float x_direction, y_direction;
	float r_speed;
	PImage particle_image;
	int current_color;
	float world_floor;

	boolean justPressed;

	boolean invincible;
	boolean[] keyboard;
	int frame;

	Particle(float _x, float _y, color _c){
		super(_x, _y);
		particle_image = loadImage("candy.png");
		addAnimation(particle_image, 36, 36);
		pause();

		float random_size = random(20, 40);
		y_size = random_size;
		x_size = random_size;
		size = x_size;

		x_velocity = random(-25, 25);
		y_velocity = random(-25, -15);
		max_velocity = 25;

		invincible = true;
		keyboard = new boolean[8];
		world_floor = 672;
		gravity = 5;

		c = _c;
	}

	void update(){
		r_speed = x_velocity;
		rotation += r_speed*3;

		super.update();

		if(int(x_velocity) != 0)
			x_velocity += (0-x_velocity)*.05;
		else
			x_velocity = 0;


		if(y+size/1.61 > world_floor){
			y = world_floor-size/2;
			gravity = 0;
		}
		else if (y-size/2 < 96){
			y = 96+size/2;
		}else{
			gravity = 5;
		}
		
		y_velocity += gravity;

		if(x > 1232 - size/2)
			x = 1232-size/2;
		if(x <  48+size/2)
			x = 48+size/2;
	}

	void draw(){
		tint(c);
		super.draw();
		noTint();
	}

	void getInput(boolean[] _keyboard){
		arrayCopy(_keyboard, keyboard);
	}
}