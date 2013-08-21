Game game;
boolean[] keyboard = new boolean[255];

void setup(){
	size(1280, 720);
	game = new Game();
	frameRate(30);
}

void draw(){
	game.play();
}

void keyPressed(){
	//if(key == ' ')
		//saveFrame(); 
	game.utilities.setKey(key);
}

void keyReleased(){
	game.utilities.releaseKey(key);
}