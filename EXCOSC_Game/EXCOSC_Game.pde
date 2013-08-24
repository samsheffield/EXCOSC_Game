import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress send_to_address;

/*
Array which holds incoming player OSC in the following order:
[0] /player/position/x
[1] /player/position/y
[2] /player/colour/r
[3] /player/colour/g
[4] /player/colour/b
[5] /player/trigger
*/
float[] player_osc = new float[6];

/*
2-dimensional array which holds incoming entity OSC in the following order (NOTE: First [0] is a number between 0 and 7 which represents each entity:
[0][0] /entity0/position/x
[0][1] /entity0/position/y
[0][2] /entity0/colour/r
[0][3] /entity0/colour/g
[0][4] /entity0/colour/b
*/
float[][] entity_osc = new float[8][5];

// Network details for OSC communication
int listen_port, send_port;
String send_address;

Game game;
boolean[] keyboard = new boolean[8];

void setup(){
	// Default ports for OSC
	listen_port  = 4444;
	send_port    = 5555;
	send_address = "127.0.0.1";

	for(int i=0; i<args.length; ++i){
		if(args[i].equals("-lp")){
			++i;
			listen_port = int(args[i]);
		}
		else if(args[i].equals("-sa")){
			++i;
			send_address = args[i];
		}
		else if(args[i].equals("-sp")){
			++i;
			send_port = int(args[i]);
		}
	}

	oscP5 = new OscP5(this, listen_port);
	send_to_address = new NetAddress(send_address, send_port);

	size(1280, 720);
	game = new Game();
	frameRate(30);
}

void draw(){
	game.play();
}

void keyPressed(){
	switch (key){
		case 'w': keyboard[0]=true; break;
		case 'a': keyboard[1]=true; break;
		case 's': keyboard[2]=true; break;
		case 'd': keyboard[3]=true; break;
		case 'j': keyboard[4]=true; break;
		case 'k': keyboard[5]=true; break;
		case 'l': keyboard[6]=true; break;
		case ' ': keyboard[7]=true; break;
	}
}

void keyReleased(){
	switch (key){
		case 'w': keyboard[0]=false; break;
		case 'a': keyboard[1]=false; break;
		case 's': keyboard[2]=false; break;
		case 'd': keyboard[3]=false; break;
		case 'j': keyboard[4]=false; break;
		case 'k': keyboard[5]=false; break;
		case 'l': keyboard[6]=false; break;
		case ' ': keyboard[7]=false; break;
	}	
}

// Share multiple keypresses with other classes
boolean getKeyboardState(int _id){
	return keyboard[_id];
}

// Simple OSC sender. _address_pattern is something like "/player/position/x". _osc_message is the floating point number between 0 and 1
void sendOsc(String _address_pattern, float _message){
    OscMessage _osc_message = new OscMessage(_address_pattern);
    _osc_message.add(_message);
    oscP5.send(_osc_message, send_to_address);
}

// Used to transport OSC to other classes
float getPlayerOsc(int _id){
	return player_osc[_id];
}

float getEntityOsc(int _type, int _id){
	return entity_osc[_type][_id];
}

// OSC Event handler
void oscEvent(OscMessage _osc_message){
	// Player OSC
	if (_osc_message.checkAddrPattern("/player/position/x")){
		player_osc[0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/position/y")){
		player_osc[1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/colour/r")){
		player_osc[2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/colour/g")){
		player_osc[3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/colour/b")){
		player_osc[4] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/player/trigger")){
		player_osc[5] = _osc_message.get(0).floatValue();
	}

	// Entity 0 OSC
	else if (_osc_message.checkAddrPattern("/entity0/position/x")){
		entity_osc[0][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/position/y")){
		entity_osc[0][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/colour/r")){
		entity_osc[0][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/colour/g")){
		entity_osc[0][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity0/colour/b")){
		entity_osc[0][4] = _osc_message.get(0).floatValue();
	}

	// Entity 1 OSC
	else if (_osc_message.checkAddrPattern("/entity1/position/x")){
		entity_osc[1][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/position/y")){
		entity_osc[1][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/colour/r")){
		entity_osc[1][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/colour/g")){
		entity_osc[1][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity1/colour/b")){
		entity_osc[1][4] = _osc_message.get(0).floatValue();
	}

	// Entity 2 OSC
	else if (_osc_message.checkAddrPattern("/entity2/position/x")){
		entity_osc[2][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/position/y")){
		entity_osc[2][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/colour/r")){
		entity_osc[2][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/colour/g")){
		entity_osc[2][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity2/colour/b")){
		entity_osc[2][4] = _osc_message.get(0).floatValue();
	}

	// Entity 3 OSC
	else if (_osc_message.checkAddrPattern("/entity3/position/x")){
		entity_osc[3][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/position/y")){
		entity_osc[3][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/colour/r")){
		entity_osc[3][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/colour/g")){
		entity_osc[3][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity3/colour/b")){
		entity_osc[3][4] = _osc_message.get(0).floatValue();
	}

	// Entity 4 OSC
	else if (_osc_message.checkAddrPattern("/entity4/position/x")){
		entity_osc[4][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/position/y")){
		entity_osc[4][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/colour/r")){
		entity_osc[4][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/colour/g")){
		entity_osc[4][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity4/colour/b")){
		entity_osc[4][4] = _osc_message.get(0).floatValue();
	}

	// Entity 5 OSC
	else if (_osc_message.checkAddrPattern("/entity5/position/x")){
		entity_osc[5][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/position/y")){
		entity_osc[5][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/colour/r")){
		entity_osc[5][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/colour/g")){
		entity_osc[5][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity5/colour/b")){
		entity_osc[5][4] = _osc_message.get(0).floatValue();
	}

	// Entity 6 OSC
	else if (_osc_message.checkAddrPattern("/entity6/position/x")){
		entity_osc[6][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/position/y")){
		entity_osc[6][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/colour/r")){
		entity_osc[6][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/colour/g")){
		entity_osc[6][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity6/colour/b")){
		entity_osc[6][4] = _osc_message.get(0).floatValue();
	}

	// Entity 7 OSC
	else if (_osc_message.checkAddrPattern("/entity7/position/x")){
		entity_osc[7][0] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/position/y")){
		entity_osc[7][1] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/colour/r")){
		entity_osc[7][2] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/colour/g")){
		entity_osc[7][3] = _osc_message.get(0).floatValue();
	}
	else if (_osc_message.checkAddrPattern("/entity7/colour/b")){
		entity_osc[7][4] = _osc_message.get(0).floatValue();
	}
}
