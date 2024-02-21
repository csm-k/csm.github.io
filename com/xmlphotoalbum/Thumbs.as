﻿package com.xmlphotoalbum{	import caurina.transitions.*;	import flash.events.Event;	import flash.display.*;	import flash.geom.Rectangle;	import flash.events.MouseEvent;	import flash.net.*;	import com.xmlphotoalbum.*;	public class Thumbs extends Sprite {		private var stageW:Number;		private var stageH:Number;		private var nrColumns:Number;		private var nrRows:Number;		private var spacing:Number = 2;		private var thumbWidth:Number;		private var thumbHeight:Number;		private var scrollerWidth:Number = 12;		private var urlRequest:URLRequest = new URLRequest("data/slideshow.xml");		private var urlLoader:URLLoader = new URLLoader();		private var xml:XML;		private var xmlList:XMLList;		private var arrayThumb:Array = new Array();		public var photoContainer:Sprite =  new Sprite();		public var imageURL:String;		public var imageID:Number;		private var albumID:Number;		public var scrollerShape:Shape = new Shape();		private var uparrowShape:Shape = new Shape();		private var downarrowShape:Shape = new Shape();		public var tracker:Shape = new Shape();		public var scroller:MovieClip = new MovieClip();		public var scrollerOffset:Number;		private var folderName:String;				private var thumbColor:uint;		function Thumbs(_folderName:String,_albumID:Number,_stageW:Number,_stageH:Number):void {			folderName = _folderName;			albumID = _albumID;			stageW = _stageW;			stageH = _stageH;			var configXMLString:String = "data/config.xml";			var configURLRequest:URLRequest = new URLRequest(configXMLString);			var configLoader:URLLoader = new URLLoader();			configLoader.load(configURLRequest);			configLoader.addEventListener(Event.COMPLETE, initiate);		}		public function initiate(event:Event):void {			var thumbsConfig:XML = XML(event.target.data);			if (thumbsConfig.noofRowsThumbs == "") {				nrRows = 5;			} else {				nrRows = thumbsConfig.noofRowsThumbs;			}			if (thumbsConfig.noofColumnsThumbs == "") {				nrColumns = 5;			} else {				nrColumns = thumbsConfig.noofColumnsThumbs;			}			if (thumbsConfig.skinColor == "") {				thumbColor = 0xff0000;			} else {				thumbColor = thumbsConfig.skinColor;			}									this.drawBackground();			this.calculateSize(nrColumns,nrRows,stageW,stageH);			urlLoader.load(urlRequest);			urlLoader.addEventListener(Event.COMPLETE,urlLoaded);			this.addChild(photoContainer);		}		private function drawBackground():void {			var backRect = new Shape();			backRect.graphics.beginFill(thumbColor, 0.3);			backRect.graphics.drawRect(0, 0, stageW, stageH);			backRect.graphics.endFill();			this.addChild(backRect);		}		private function calculateSize(_nrColumns:Number,_nrRows:Number,_stageW:Number,_stageH:Number):void {			thumbWidth = ((_stageW - scrollerWidth)/ _nrColumns) - spacing;			thumbHeight = (_stageH / _nrRows) - spacing;		}		private function urlLoaded(event:Event):void {			xml = XML(event.target.data);			xmlList = xml.album[albumID].media;			for (var i:int=0; i<xmlList.length(); i++) {				var thumb:Thumbnail = new Thumbnail(folderName,xmlList[i],thumbWidth,thumbHeight,i,true,thumbColor);								thumb.addEventListener("clicked",showImage);				arrayThumb.push(thumb);				if (i<nrColumns) {					arrayThumb[i].y = spacing;					arrayThumb[i].x = i*(thumbWidth+spacing);				} else {					arrayThumb[i].y = arrayThumb[i-nrColumns].y+(thumbHeight+spacing);					arrayThumb[i].x = arrayThumb[i-nrColumns].x;				}				photoContainer.addChild(thumb);			}		/////////////////////////////////////////////Scroller Class//////////////////////////////////////////			var photoSlider:SliderR = new SliderR(stageW, stageH, photoContainer, thumbColor);			addChild(photoSlider);		}		/////////////////////////////////////////////////////////////////////////////////////////////////////		private function showImage(event:Event):void {			imageURL = event.target.url;			imageID = event.target.xmlID;			dispatchEvent(new Event("showSlide"));					}	}}