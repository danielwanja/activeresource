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
			var call:AsyncToken = ActiveResource.findAll(RcDataTypeTable);
			call.addResponder(Async.asyncResponder(this, new AsyncResponder(testFindAllResult, testFindAllFault), 500));	
		}
		
		private function testFindAllResult(resultEvent:ResultEvent, token:Object=null):void
		{
			trace("0:"+resultEvent);
			assertNotNull(resultEvent.result);
			assertTrue(resultEvent.result is ArrayCollection);
			assertEquals(1, resultEvent.result.length);
			assertTrue(resultEvent.result.getItemAt(0) is RcDataTypeTable);
			
		}
		
		private function testFindAllFault(faultEvent:FaultEvent, token:Object=null):void
		{
			// TODO Auto Generated method stub
			trace("1:"+faultEvent);
			
		}
		
		//---------------------------------------------------------------------
		// HELPER METHODS
		//---------------------------------------------------------------------
	

		protected function invoke(call:AsyncToken, responder:Function, timeout:Number=2000):void {
			call.addResponder(
				Async.asyncResponder(this, new AsyncResponder(responder, responder), timeout));			
		}		
		
		protected function proceed(event:AbstractEvent, token:Object=null):void {
			// do nothing
		}
		
	}
}