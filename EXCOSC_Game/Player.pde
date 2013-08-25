class Player extends Sprite{
	float max_velocity;
	float x_direction, y_direction;
	PImage player_image;
	int current_color;
	float world_floor;
	float created_at, died_at;
	int trigger;
	boolean killed, dead;
	boolean jumping;
	boolean invincible;

	Player(float _x, float _y){
		super(_x, _y);
		player_image = loadImage("mrplayer.png");
		addAnimation(player_image, 416, 544);

		y_size = 68;
		x_size = 52;
		max_velocity = 5;
		radius = x_size/2;
		x_velocity = 15;
		y_velocity = 15;
		invincible = true;
		gravity = 5;
		flip = true;
		created_at = millis();
	}

	void update(){
		radius = x_size/1.61;
		min_x = 48+(radius);
		max_x = 1232-(radius);
		min_y = 96+radius;
		max_y = 672-(radius);

		trigger = 0;
		c = #000000; // reset color

		if(killed){
			if(millis() > died_at + 2000)
				dead = true;
		}

		if(keyPressed && millis() > created_at+500){
			invincible = false;
			trigger = 1;
		}

		// Reset speed
		setXVelocity(0);

		if(millis() > created_at+500 && !killed){
			// UP
			if(getKeyboardState(0)){
				if(!jumping){
					jumping = true;
					player_jumped.trigger();
				}
				setYVelocity(-15); 
			}
			// DOWN
			if(getKeyboardState(2)) 
				setYVelocity(15); 
			// LEFT
			if(getKeyboardState(1))
				setXVelocity(-15); 
			// RIGHT
			if(getKeyboardState(3))
				setXVelocity(15); 
		}

		// Color switching (pretty slow method)
		if(getKeyboardState(4))
			c = #ff0000;
		else if(getKeyboardState(5))
			c = #00ff00;
		else if(getKeyboardState(6))
			c = #0000ff;

		if(getKeyboardState(4) && getKeyboardState(5))
			c = #ffff00;
		else if(getKeyboardState(5) && getKeyboardState(6))
			c = #00ffff;
		else if(getKeyboardState(4) && getKeyboardState(6))
			c = #ff00ff;

		if(getKeyboardState(4) && getKeyboardState(5) && getKeyboardState(6))
			c = #ffffff;

		// Hang from ceiling		
		if(y < 200)
			seek(1);
		else
			seek(0);

		super.update();

		if(y > max_y){
			y = max_y;
			gravity = 0;
			jumping = false;
		}
		else if (y < min_y){
			y = min_y;
		}else{
			gravity = 5;
		}
		
		if(x > 1232 - radius)
			x = 1232-radius;
		if(x <  48+radius)
			x = 48+radius;

		y_velocity += gravity;
	}

	void grow(){
		x_size+=5;
		y_size+=6;
	}

	void draw(){
		if(!killed){
			tint(c);
			super.draw();
			noTint();
		}

	}

	void kill(float _died_at){
		killed = true;
		died_at = _died_at;
	}
}