Game game;
boolean[] keyboard = new boolean[255];

void setup(){
	size(800, 600);
	game = new Game();
	frameRate(30);
}

void draw(){
	game.play();
}

void keyPressed(){
	//game.utilities.setKey(key);
}

void keyReleased(){
	//game.utilities.releaseKey(key);
}