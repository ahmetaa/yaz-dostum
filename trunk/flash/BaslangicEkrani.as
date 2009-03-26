package {

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	public class BaslangicEkrani extends MovieClip {
		public function BaslangicEkrani() {
			baslaDugmesi.addEventListener( MouseEvent.CLICK, onClickStart,false,0,true );
			yardimDugmesi.addEventListener(MouseEvent.CLICK, yardimDugmesineBasildi,false,0,true);
			addChild(new Kabarciklar());
			addChild(new Kabarciklar(0xee9977));
		}

		public function onClickStart( event:MouseEvent ):void {
			dispatchEvent( new NavigationEvent( NavigationEvent.START ) );
		}

		public function yardimDugmesineBasildi( event:MouseEvent ):void {
			dispatchEvent( new NavigationEvent (NavigationEvent.YARDIM));
		}

	}

}