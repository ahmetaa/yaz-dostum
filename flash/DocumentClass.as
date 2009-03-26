package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class DocumentClass extends MovieClip {

		var oyun:Oyun;
		var oyunBittiEkrani:OyunBittiEkrani;
		var baslangicEkrani:BaslangicEkrani;
		var yardimEkrani:YardimEkrani;
		var yukleniyorEkrani:YukleniyorEkrani;

		// Initialization:
		public function DocumentClass() {
			yukleniyorEkrani = new YukleniyorEkrani();
			addChild(yukleniyorEkrani);
			loaderInfo.addEventListener( ProgressEvent.PROGRESS, yuklemeYapiliyor );			
			loaderInfo.addEventListener( Event.COMPLETE, herseyYuklendi );
		}

		public function yuklemeYapiliyor( progressEvent:ProgressEvent ):void {
			yukleniyorEkrani.guncelle( Math.floor( 100 * loaderInfo.bytesLoaded / loaderInfo.bytesTotal ) );
			trace( loaderInfo.bytesLoaded, loaderInfo.bytesTotal );
		}

		public function herseyYuklendi( event:Event ):void {
			gotoAndStop(3);
			baslangicMenusuGoster();
		}

		public function baslangicMenusuGoster() {
			baslangicEkrani = new BaslangicEkrani();
			baslangicEkrani.addEventListener( NavigationEvent.START, baslangicIstegi,false,0,true );
			baslangicEkrani.addEventListener( NavigationEvent.YARDIM,yardimIstegi,false,0,true );
			addChild(baslangicEkrani);
		}

		public function oyunBitti(olay:OyunOlayi):void {
			oyunBittiEkrani = new OyunBittiEkrani();
			oyunBittiEkrani.setPuan(oyun.getOyunDegerleri().puan);
			oyunBittiEkrani.setHata(oyun.getOyunDegerleri().hata);
			oyunBittiEkrani.addEventListener( NavigationEvent.RESTART, yenidenBaslaIstegi,false,0,true );
			addChild(oyunBittiEkrani);
			oyun=null;
		}
		
		public function oyunTamamlandi(olay:OyunOlayi):void {
			oyunBittiEkrani = new OyunBittiEkrani();
			oyunBittiEkrani.setPuan(oyun.getOyunDegerleri().puan);
			oyunBittiEkrani.setHata(oyun.getOyunDegerleri().hata);
			oyunBittiEkrani.setMesaj("Tebrikler! Tum seviyeler bitti!");			
			oyunBittiEkrani.efekt();
			oyunBittiEkrani.addEventListener( NavigationEvent.RESTART, yenidenBaslaIstegi,false,0,true );
			addChild(oyunBittiEkrani);
			oyun=null;
		}		

		public function yenidenBasla() {
			if (oyun!=null) {
				removeChild(oyun);
				oyun=null;
			}
			oyun = new Oyun();
			oyun.addEventListener( OyunOlayi.BITTI, oyunBitti,false,0,true  );
			oyun.addEventListener( OyunOlayi.TAMAMLANDI, oyunTamamlandi,false,0,true  );			
			addChild(oyun);
		}

		public function yenidenBaslaIstegi(navEvent:NavigationEvent) {
			yenidenBasla();
		}

		public function baslangicIstegi(navEvent:NavigationEvent) {
			yenidenBasla();
		}

		public function yardimIstegi(navEvent:NavigationEvent) {
			yardimEkrani = new YardimEkrani();
			yardimEkrani.addEventListener(NavigationEvent.BASA_DON,basaDonmeIstegi,false,0,true);
			addChild(yardimEkrani);
		}

		public function basaDonmeIstegi(navEvent:NavigationEvent) {
			if (yardimEkrani!=null) {
				removeChild(yardimEkrani);
			}
		}

		// Public Methods:
		// Protected Methods:
	}

}