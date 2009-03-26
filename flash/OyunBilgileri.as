package {

	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.display.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class OyunBilgileri {

		var seviyeler:Array = new Array();

		private var oyun:Oyun;

		private var yukleyici:URLLoader;
		private var sesYukleyici:URLLoader;
		var baloncuk:Sound = new BaloncukSesi();
		var fonMuzigi:SoundChannel = new SoundChannel();
		var muzik:Sound;
		var yereDus:Sound=new YereCarpmaSesi();

		private var suankiSeviyeNumarasi:int=-1;

		public function OyunBilgileri(oyun:Oyun) {
			this.oyun=oyun;
			var istek:URLRequest=new URLRequest("seviyeler.xml");
			yukleyici = new URLLoader();
			yukleyici.load(istek);
			yukleyici.addEventListener(Event.COMPLETE, oku);
			muzik = new OyunMuzigi();
			fonMuzigi=muzik.play();
		}


		public function kelimeBittiSes():void {
			baloncuk.play();
		}

		public function yereCarptiSes():void {
			yereDus.play();
		}

		public function muzikDur() {
			fonMuzigi.stop();
		}

		private function oku(event:Event) {
			var seviyeXML:XML=XML(yukleyici.data);

			// burada xml'den seviye bilgilerini okuyup seviyeler dizisine atacagiz.
			for (var i:uint = 0; i<seviyeXML.Seviye.length(); i++) {
				var dizi:Array=seviyeXML.Seviye[i].Kelimeler.split(",");
				var sev:Seviye=new Seviye(
				  dizi,
				  seviyeXML.Seviye[i].ToplamKelime,
				  seviyeXML.Seviye[i].KelimeFrekansi,
				  seviyeXML.Seviye[i].DusmeHizi,
				  seviyeXML.Seviye[i].Rasgele);
				seviyeler.push(sev);
			}
			oyun.basla();
		}

		public function yeniSeviye():Seviye {
			suankiSeviyeNumarasi++;
			if (suankiSeviyeNumarasi==seviyeler.length) {
				suankiSeviyeNumarasi=0;
			}
			var seviye:Seviye=seviyeler[suankiSeviyeNumarasi];
			return seviye;
		}

		public function seviyeKaldiMi():Boolean {
			if (suankiSeviyeNumarasi<seviyeler.length-1) {
				return true;
			} else 
				return false;
		}

		public function seviyeAdi():String {
			return new String(suankiSeviyeNumarasi+1) + ". Seviye";
		}

	}

}