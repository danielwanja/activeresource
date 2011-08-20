package test.active_resource
{
	import active_resource.ActiveResource;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import test.models.RcDataTypeTable;

	public class ServerCallsTest
	{	
		[Before]
		public function setUp():void
		{
			// TODO: call factories controller to reset fixtures
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
			// TODO: asset the results
			fail("Implement this next!");
			
		}
		
		private function testFindAllFault(faultEvent:FaultEvent, token:Object=null):void
		{
			// TODO Auto Generated method stub
			trace("1:"+faultEvent);
			
		}
		
	}
}