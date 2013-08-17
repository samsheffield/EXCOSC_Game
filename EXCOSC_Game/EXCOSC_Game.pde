Game game;

void setup(){
	size(800, 800);
	game = new Game();
	frameRate(30);
}

void draw(){
	game.play();
}