﻿package com.xmlphotoalbum.Mp3Buttons{	import flash.display.Sprite;	public class PlayerBackground extends Sprite {		public var Player:Sprite;		public var StageW:Number;		public var PosY  :Number;		public function PlayerBackground(_StageW:Number):void {						StageW = _StageW;						Player = new Sprite();			addChild(Player);			var rect:Sprite = new Sprite();			rect.graphics.beginFill(0x000000);			rect.graphics.drawRoundRect(0,-5, StageW, 40,0);			rect.graphics.endFill();						Player.addChild(rect);		}			}	}