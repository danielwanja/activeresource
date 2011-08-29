package test.helper
{
	import com.adobe.serialization.json.JSONDecoder;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;

	public class BaseServerTestCase
	{
		protected var fixtures:Object;

		protected function loadFixtures(name:String):void {
			var fixtures:HTTPService = new HTTPService();
			fixtures.url = "http://localhost:3000/fixtures/reset";
			fixtures.contentType = "application/xml";
			// FIXME: allow array of fixture names						
			invoke( fixtures.send(<fixtures><fixture>{name}</fixture></fixtures>), fixtureLoaded); 
		}
		protected function assertCall(call:AsyncToken, assertionFunction:Function, faultHandler:Function=null):void {
			if (faultHandler==null) faultHandler = this.faultHandler;
			call.addResponder(Async.asyncResponder(this, new AsyncResponder(resultHandler, faultHandler), 3000));
			call.assertionFunction = assertionFunction;
		}
		
		protected function resultHandler(resultEvent:ResultEvent, token:Object=null):void {
			resultEvent.token.assertionFunction(resultEvent.result);	
		}
		
		protected function faultHandler(faultEvent:FaultEvent, token:Object=null):void
		{
			fail("Expected resultEvent but got a faultEvent:"+faultEvent.toString());			
		}		
		
		protected function invoke(call:AsyncToken, responder:Function, timeout:Number=2000):void {
			call.addResponder(
				Async.asyncResponder(this, new AsyncResponder(responder, responder), timeout));			
		}		
		
		protected function fixtureLoaded(event:AbstractEvent, token:Object=null):void {
			fixtures = event is ResultEvent ? new JSONDecoder((event as ResultEvent).result as String, true).getValue() : null;
		}
	}
}