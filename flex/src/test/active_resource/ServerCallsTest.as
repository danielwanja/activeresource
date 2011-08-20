package test.active_resource
{
	import active_resource.ActiveResource;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	
	import test.models.RcDataTypeTable;

	public class ServerCallsTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
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
			assertNull(resultEvent.result);
			
		}
		
		private function testFindAllFault(faultEvent:FaultEvent, token:Object=null):void
		{
			// TODO Auto Generated method stub
			trace("1:"+faultEvent);
			
		}
		
	}
}