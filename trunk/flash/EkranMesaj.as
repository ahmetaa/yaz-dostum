package {

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class EkranMesaj extends Sprite implements IEfekt {
		//Mesaji tasiyacak textfield.
		private var mesajField:TextField=new TextField  ;
		var mesaj:String="";
		var zamanlayici:Timer;
		var shp:Shape;

		var kaybolmaSayaci:uint=0;

		public function EkranMesaj(msj:String,x:uint,y:uint,zaman:int=-1) {
			if (zaman>-1) {
				zamanlayici=new Timer(zaman,30);
				zamanlayici.addEventListener(TimerEvent.TIMER, tick);
				zamanlayici.start();
			}
			mesaj=msj;
			mesajField.autoSize=TextFieldAutoSize.LEFT;
			mesajField.htmlText=formatliYaz();
			this.x=x-genislik()/2;
			this.y=y-boy()/2;
			belirginlestir();
			if (zaman==-1) {
				this.alpha=0.7;
			} else {
				this.alpha=0.0;
			}
			addChild(shp);
			addChild(mesajField);
		}

		public function tick(evet:TimerEvent) {

			if (kaybolmaSayaci>12) {
				this.alpha-=0.05;
			}
			if (kaybolmaSayaci<6) {
				this.alpha+=0.1;
			}
			kaybolmaSayaci++;
		}

		private function belirginlestir():void {
			shp=new Shape();
			shp.graphics.beginFill(0xffddcc);
			var e:int=genislik()+20;
			var b:int=boy()+20;
			shp.graphics.drawRoundRect(-10,-10,e,b,10);
		}

		private function boy():Number {
			return mesajField.height;
		}

		private function genislik():Number {
			return mesajField.width;
		}

		private function formatliYaz():String {
			return "<font face = 'Verdana' size = '30' color = '#112233'>"+mesaj+"</font>";
		}

		public function bittimi():Boolean {
			if (zamanlayici==null) {
				return false;
			}
			if (zamanlayici.running) {
				return false;
			} else {
				zamanlayici.removeEventListener(TimerEvent.TIMER, tick);				
				zamanlayici = null;
				return true;
			}
		}

	}
}