package {

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class OyunDegerleri extends MovieClip {

		var puan:uint=0;
		var hata:uint=0;
		var hayat:uint=3;
		var joker:uint=0;
		var jokerSayaci:uint=0;
		var hayatKazanmaSayaci:uint=0;

		var jokerler:Array = new Array();
		var hayatlar:Array = new Array();

		const JOKER_DEGERI:uint=11;
		const HAYAT_KAZANMA_DEGERI:uint=19;

		public function OyunDegerleri() {
			for (var i:uint = 0; i<3; i++) {
				var h:Hayat = new Hayat();
				hayatlar.push(h);
				h.x=i*30+10;
				h.y=480;
				addChild(h);
			}
		}

		public function puanArttir(artim:uint):uint {
			puan=puan+artim;
			puanTxt.text=puan.toString();
			return puan;
		}

		public function hataArttir(artim:uint):uint {
			jokerSayaci=0;
			hayatKazanmaSayaci=0;
			hata=hata+artim;
			hataTxt.text=hata.toString();
			return hata;
		}

		public function hatasizlikArttir():void {
			jokerSayaci++;
			hayatKazanmaSayaci++;
		}

		public function jokerKazandimi():Boolean {
			if (jokerSayaci==JOKER_DEGERI) {
				return true;
			} else {
				return false;
			}
		}

		public function jokerArttir():void {
			joker++;
			// joker resmi olustur, onu jokerler dizisine ekle, yeni pozisyonunu belirle ve ekrana ciz.
			var j:Joker = new Joker();
			jokerler.push(j);
			j.x=((jokerler.length-1)*30 % 180)+200;
			j.y=480;
			addChild(j);
			jokerSayaci=0;
		}

		public function jokerKullan():Boolean {
			if (joker==0) {
				return false;
			} else {
				var j:Joker=jokerler.pop();
				removeChild(j);
				joker--;
				return true;
			}
		}

		public function hayatKazandimi():Boolean {
			if (hayatKazanmaSayaci==HAYAT_KAZANMA_DEGERI) {
				return true;
			} else {
				return false;
			}
		}

		public function hayatArttir() {
			var h:Hayat = new Hayat();
			hayatlar.push(h);
			h.x=((hayatlar.length-1)*30 % 180)+10;
			h.y=480;
			addChild(h);
			hayat++;
			hayatKazanmaSayaci=0;
		}

		public function hayatSayisi():int {
			return hayat;
		}

		public function hayatAzalt():uint {
			if (hayat>0) {
				var h:Hayat=hayatlar.pop();
				removeChild(h);
			}
			hayat--;
			hayatKazanmaSayaci=0;
			return hayat;
		}

	}
}