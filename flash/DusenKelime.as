package {

	import flash.geom.Point;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.text.TextField;

	public class DusenKelime extends Sprite {

		// kelimeyi tasiyacak label.
		private var kelimeField:TextField=new TextField  ;

		// henuz yazilmamis harflerden olusan kelimeyi gosterir. 
		var yazilmamis:String="";
		// o ana kadar dogru yazilan harfleri gosterir.
		var yazilan:String="";

		var icerik:String="";
		
		var shp:Shape;

		// kelimelerin toplam dusme mesafesi. silinmeden bu kadar ilerleyen bir kelime oyuncunun
		// bir hakkini kaybetmesine neden olur.
		const DUSME_MESAFESI:uint=450;

		// Initialization:
		public function DusenKelime(ic:String) {
			yazilmamis=ic;
			icerik=ic;

			kelimeField.autoSize=TextFieldAutoSize.LEFT;

			kelimeField.htmlText=formatliYaz();

			//kelimeField.embedFonts=true;
			addChild(kelimeField);

		}
		
		public function dustuMu():Boolean {
			if(this.y+boy()>DUSME_MESAFESI)
			   return true;
			else 
			   return false;
		}

		public function beklenenKaraktermi(basilanHarf:String):Boolean {

			if (basilanHarf==yazilmamis.charAt(0)&&yazilmamis.length>0) {
				return true;
			} else {
				return false;
			}
		}
		
		public function beklenenHarf():String {
			if(yazilmamis.length>0)
				return yazilmamis.charAt(0);
			else 
				return null;	
		}

		private function formatliYaz():String {
			return "<font face = 'Verdana' size = '24' color = '#993333'>"+yazilan+"</font><font face = 'Verdana' size = '24' color = '#339933'>"+yazilmamis+"</font>";
		}

		/*
		Bir harfe basildiginda eger bu kelime icin beklenen bir harf ise yazilmamis ve yazilmis 
		degiskenlerini gunceller ve true doner. Aksi halde false doner.
		*/
		public function harfBasildi(basilanHarf:String):Boolean {						
			// eger basilan harf beklenen harf ile ayni ise, kalan ve yazilan stringleri hesapla.			
			if (beklenenKaraktermi(basilanHarf)) {
				yazilan=yazilan+basilanHarf;
				yazilmamis=yazilmamis.substr(1);
				kelimeField.htmlText=formatliYaz();
				return true;
			} else {
				return false;
			}
		}

		public function genislik():Number {
			return kelimeField.width;
		}

		public function boy():Number {
			return kelimeField.height;
		}

		/*
		bu kelimenin yazilmasi tamamlanmis ise true, yoksa false doner.
		*/
		public function kelimeBittimi():Boolean {
			if (yazilmamis.length==0) {
				return true;
			} else {
				return false;
			}
		}
		public function merkez():Point {
			var p:Point=new Point(this.x+genislik()/2,this.y+boy()/2);
			return p;
		}

		public function belirginlestir():void {
			shp = new Shape();
			shp.graphics.beginFill(0xddff22);
			var e:int=genislik()+16;
			var b:int=boy()+16;
			shp.graphics.drawRoundRect(-8,-8,e,b,8);
			shp.alpha=0.25;
			this.addChild(shp);
		}
		
		public function dus():void {
			this.y=this.y+1;
		}

	}
}