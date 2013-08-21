class Enemy extends Sprite{
	PImage enemy_image;

	float x_direction, y_direction, x_speed, y_speed;
	int current_color;
	int id;
	int type;
	float wanderer, max_wander;
	float floater;
	float p_x, p_y;
	float r_speed;
	boolean p_invincible;
	boolean stuck;

	Enemy(float _x, float _y, int _type){
		super(_x, _y);
		x_size = 64;
		y_size = 64;
		size = 64;
		type = _type;

		enemy_image = loadImage("enemies.png");
		addAnimation(enemy_image, 64,64);
		seek(type);
		pause();

		if(int(random(2)) == 0)
			x_direction = -1;
		else
			x_direction = 1;

		if(int(random(2)) == 0)
			y_direction = -1;
		else
			y_direction = 1;

		c = color(random(255), random(255), random(255));

		max_wander = 30;

		switch (type){
			case 0 : straightMovement(1, 10); break;
			case 1 : angularMovement(10, 20); break;
			case 2 : angularMovement(2, 10); break;
			case 3 : angularMovement(2, 5); break;
			case 4 : drop(); break;
			case 5 : break;
			case 6 : break;
			case 7 : angularMovement(2, 10); break;
		}

	}

	void update(){
		super.update();
		switch (type){
			case 0 : bounce(); break;
			case 1 : bounce(); rotate(10); break;
			case 2 : bounce(); rotate(5); break;
			case 3 : wrap(); faceMovement(); break;
			case 4 : stick(); break;
			case 5 : floaty(); rotate(3); break;
			case 6 : moveToward(); rotate(r_speed); stick(); break;
			case 7 : bounce(); rotate(3); break;
		}

		x += x_speed*x_direction;
		y += y_speed*y_direction;

		
	}

	void draw(){
		tint(c);
		super.draw();
		noTint();
	}

	void faceMovement(){
		x_flip = x_direction;
	}

	void respawn(Cloud _cloud){
		x = _cloud.x;
		y = _cloud.y;
		stuck = false;
		_cloud.activate();
	}

	void bounce(){
		if (x < 48+(size/2) || x > 1232-(size/2))
			x_direction *= -1;
			
		if (y < 96+(size/2) || y > 672-(size/2))
			y_direction *= -1;
	}

	void wrap(){
		if (x < -(size/2))
			x = (width+(size/2))-1;

		if (x > width+(size/2))
			x = -(size/2)+1;
			
		if (y < -(size/2))
			y = (height+(size/2))-1;

		if(y > height+(size/2))
			y = -(size/2)+1;
	}

	void stick(){
		if(y > 672-(size/2)){
			x_direction = 0;
			y_direction = 0;
			y = 672-(size/2);
			stuck = true;
		}
		else if(y < 96+size/2){
			x_direction = 0;
			y_direction = 0;
			y = 48+size/2;
			stuck = true;
		}

		if (x < 48+(size/2)){
			x = 48+(size/2);
			y_direction = 0;
			x_direction = 0;
			stuck = true;
		}
		else if (x > 1232-(size/2)){
			x = 1232 - (size/2);
			y_direction = 0;
			x_direction = 0;
			stuck = true;
		}
	}


	void rotate(float _r_speed){
		rotation += _r_speed;
	}

	void angularMovement(float _min_speed, float _max_speed){
		x_speed = random(_min_speed, _max_speed);
		y_speed = random(_min_speed, _max_speed);
	}

	void straightMovement(float _min_speed, float _max_speed){
		if(int(random(2)) == 0)
			x_speed = random(_min_speed, _max_speed);
		else
			y_speed = random(_min_speed, _max_speed);
	}

	void drop(){
		y_direction = 1;
		y_velocity = 40;
	}

	void floaty(){
		floater += .025;
		x_velocity = sin(floater);
	}

	void moveToward(){
		if(p_invincible){
			r_speed = 3;
		}
		else{
			if(!stuck){
				if(frameCount % 2 == 0){
					if (x != p_x)
						x_velocity += (p_x-x)/400;
					if (y != p_y)
						y_velocity += (p_y-y)/400;
				}

			}
			else{
				x_velocity = 0;
				y_velocity = 0;
			}
			r_speed = x_velocity*y_velocity;
		}
	}


}