#include "ofApp.h"

void ofApp::setup(){
    /*
	ofSetFrameRate(60);
	quality = OF_IMAGE_QUALITY_WORST;
	//カメラを初期化
	myVideo.initGrabber(320, 240, true);
	//スクリーンをキャプチャしてofImageに格納
	img.grabScreen(0, 0, ofGetWidth(), ofGetHeight());
    */
    
    ofSetFrameRate(60); //フレームレート(60/s)
    ofSetVerticalSync(true);  //垂直同期信号のon/off(よくわからん)
    ofSetCircleResolution(32); //ofCircleの精密度を指定
    ofEnableBlendMode(OF_BLENDMODE_ADD); //加算のブレンド
    ofBackground(0, 0, 0);
    
    nBandsToGet = 1024;
    
    mySound.loadSound("sample.mp3");
    mySound.setLoop(true);
    mySound.play();
}

void ofApp::reset(){
    //ビデオをアップデート
	//myVideo.update();
	//ビデオのフレームを1コマ読込み
	//myVideo.draw(0, 0, ofGetWidth(), ofGetHeight());
	//スクリーンをキャプチャしてofImageに格納
	//img.grabScreen(0, 0, ofGetWidth(), ofGetHeight());
}

void ofApp::update(){
/*
	//Jpeg圧縮したデータの保存ファイル名
	string compressedFilename = "compressed.jpg";
	//Jpeg形式でファイルを保存
	img.saveImage(compressedFilename, quality);
	ofBuffer file = ofBufferFromFile(compressedFilename);
	int fileSize = file.size();
	//Jepgファイルをバッファーに読込み
	char * buffer = file.getBinaryBuffer();
	//データを破壊する場所をランダムに決定
	int whichByte = (int) ofRandom(fileSize);
	//ONにするbitをランダムに決定
	int whichBit = ofRandom(8);
	//ビットシフト(データを破壊?)
	char bitMask = 1 << whichBit;
	buffer[whichByte] |= bitMask;
	//glitchしたファイルを保存
	ofBufferToFile(compressedFilename, file);
	//再度読込み
	img.loadImage(compressedFilename);
	//ランダムなタイミングで自動的にリセット
	float coin = ofRandom(100);
	if (coin > 95) {
		reset();
	}
*/
    ofSoundUpdate(); //サウンドプレイヤーを更新
    fft = ofSoundGetSpectrum(nBandsToGet); //FFT解析
}

void ofApp::draw(){
	//glitchしたイメージを描画
	//ofSetColor(255);
	//img.draw(0, 0, ofGetWidth(), ofGetHeight());
    float width = float(ofGetWidth())/float(nBandsToGet)/2.0f;
    
    for(int i=0;i<nBandsToGet;i++){
        int b=float(255)/float(nBandsToGet)*i;
        int g=31;
        int r=255-b;
        ofSetColor(r,g,b);
        ofCircle(ofGetWidth()/2+width*i,ofGetHeight()/2,fft[i]*800);
        ofCircle(ofGetWidth()/2-width*i,ofGetHeight()/2,fft[i]*800);
    }
}

void ofApp::keyPressed  (int key){
    reset();
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){
    
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
    
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    reset();
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
    
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){
    
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){
    
}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){
    
}


void ofApp::glitch(){
    
}
