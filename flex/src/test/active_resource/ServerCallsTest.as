package test.active_resource
{
	import active_resource.ActiveResource;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import test.models.RcDataTypeTable;

	public class ServerCallsTest
	{	
		[Before(async)]
		public function setUp():void
		{
			// TODO: call factories controller to reset fixtures
			var fixtures:HTTPService = new HTTPService();
			fixtures.url = "http://localhost:3000/fixtures/reset";
			fixtures.contentType = "application/xml";
			invoke( fixtures.send(<fixtures><fixture>setup_data_type_table</fixture></fixtures>), proceed);			
		}
		
		[After]
		public function tearDown():void
		{
		}

		[Test(async)]
		public function testFindAll():void {
			assertCall(ActiveResource.findAll(RcDataTypeTable), function(result:Object):void {
				assertNotNull(result);
				assertTrue(result is ArrayCollection);
				assertEquals(1, result.length);
				assertTrue(result.getItemAt(0) is RcDataTypeTable);				
			})
		}
		
		//---------------------------------------------------------------------
		// HELPER METHODS
		//---------------------------------------------------------------------
	
		protected function assertCall(call:AsyncToken, assertionFunction:Function):void {
			call.addResponder(Async.asyncResponder(this, new AsyncResponder(resultHandler, faultHandler), 500));
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
		
		protected function proceed(event:AbstractEvent, token:Object=null):void {
			// do nothing
		}
		
	}
}