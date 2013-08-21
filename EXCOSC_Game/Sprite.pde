/*
Sprite class
*/

class Sprite {
	PImage[] sprites;
	int current_frame;				// CURRENT FRAME OF ANIMATION BEING DISPLAYED

	float x, y;		 	// POSITIONING
	float w, h;			// Sprite width and height
	float rotation;

	boolean paused;					// USED TO CONTROL ANIMATION PLAYBACK
	boolean play_during_pause;		// OVERRIDE DEFAULT PAUSING BEHAVIOR
	boolean flip;

	int start, end, loopRate;
	float x_velocity, y_velocity;
	float x_flip, y_flip;
	float x_size, y_size, size;
	float gravity;

	color c;

	Sprite(float _x, float _y){
		x = _x;
		y = _y;
		x_flip = 1;
		y_flip = 1;
		loopRate = 27;
	}

	// Create sprites from spritesheet and store them in sprites[].
	void addAnimation(PImage _img, int _cw, int _ch){
		w = _cw;
		h = _ch;

		sprites = new PImage[_img.width/_cw * _img.height/_ch];
		int _cell_divider = _img.width/_cw;

		for (int i=0; i < sprites.length; i++){
			sprites[i] = createImage(_cw, _ch, ARGB);
			sprites[i].copy(_img, (i%(_cell_divider))*_cw, (i/(_cell_divider))*_ch, _cw, _ch, 0, 0, _cw, _ch);
		}	
		end = sprites.length-1; // Set ending point for looping
	}

	// Set starting and ending points, and playback speed.
	void setLoop(int _start, int _end, int _loopRate){
		start = _start;
		end = _end;
		loopRate = _loopRate;
	}

	// Set playback speed
	void setRate(int _loopRate){
		loopRate = _loopRate;
	}

	// LOOP BETWEEN FIXED START AND END FRAMES (AT SPECIFIED FRAMERATE). USE WITH setLoop()
	void loop(){
		if(!paused || play_during_pause){
			if(frameCount % (31-loopRate) == 0){
				if (current_frame < start) 
					current_frame = start;

				if (current_frame < end)
					current_frame++;
				else
					current_frame = start;
			}
		}
		draw();
	}

	// PLAY ONCE FROM A SET OF DESIGNATED START AND END POINTS AT A FIXED FRAMERATE
	void play(){
		if(!paused){
			if(frameCount % (31-loopRate) == 0){
				if (current_frame < start) 
					current_frame = start;
				else if (current_frame < end)
					current_frame++;
			}
		}
		draw();
	}

	// STOP PLAYBACK
	void pause(){
		paused = true;
	}

	// RESUME/CONTINUE PLAYBACK
	void resume(){
		paused = false;
	}

	// GO TO A PARTICULAR FRAME
	void seek(int _frame){
		current_frame = _frame;
		pause();
	}

	void draw(){
		imageMode(CENTER);
		pushMatrix();
		translate(x, y);
		scale(x_flip, y_flip);
		rotate(radians(rotation));
		image(sprites[current_frame],0,0,x_size, y_size);
		popMatrix();
		imageMode(CORNER);
	}

	void update(){
		if(flip){
			if(x_velocity > 0)
				x_flip = 1;
			else if(x_velocity < 0)
				x_flip = -1;

			if(y_velocity > 0)
				y_flip = 1;
			else if(y_velocity < 0)
				y_flip = -1;
		}
		x += x_velocity;
		y += y_velocity;

	}

	void setXVelocity(float _x_velocity){
		x_velocity = _x_velocity;
	}

	void setYVelocity(float _y_velocity){
		y_velocity = _y_velocity;
	}

	void setFlip(boolean _flip){
		flip = _flip;
	}

}