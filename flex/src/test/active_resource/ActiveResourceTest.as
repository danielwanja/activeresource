package test.active_resource
{
	
	import active_resource.ActiveResource;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.hasProperties;
	
	import test.models.Department;
	import test.models.Employee;

	public class ActiveResourceTest
	{		
		[Before]
		public function setUp():void
		{
			ActiveResource.send = mockSendFunction;
		}
		
		[After]
		public function tearDown():void
		{
			lastHttpService = null;
			lastParams = null;
			lastOriginalData = null;
			ActiveResource.send = ActiveResource.sendImplementation;
		}
		
		private var lastHttpService:HTTPService;
		private var lastParams:Object;
		private var lastOriginalData:Object;
		
		protected function mockSendFunction(resourceClazz:Class, service:HTTPService, params:Object=null, originalData:Object=null):AsyncToken {
			this.lastHttpService = service;
			this.lastParams = params;
			this.lastOriginalData = originalData;
			return new AsyncToken;
		}
		
		[Test]
		public function testResourceName():void {
			assertEquals("departments", new Department().resourceName);
			assertEquals("employees", new Employee().resourceName);
		}
		
		[Test]
		public function testRestUrls():void {
			var department:Department = new Department();	
			
			//Index
			assertRestCall(ActiveResource.findAll(Department), 			"/departments.json", "GET");
			
			// Create
			assertRestCall(ActiveResource.create(Department, {}), 		"/departments.json", "POST");
			
			// Show
			assertRestCall(ActiveResource.find(Department, 1), 			"/departments/1.json", "GET");
			
			// Update
			assertRestCall(ActiveResource.update(Department, {id:1}), 	"/departments/1.json", "POST"); // PUT
			assertThat(lastHttpService.headers, hasProperties({X_HTTP_METHOD_OVERRIDE:'put'}));
			
			// Delete
			assertRestCall(ActiveResource.destroy(Department, {id:1}), 	"/departments/1.json", "POST"); // DELETE
			assertThat(lastHttpService.headers, hasProperties({X_HTTP_METHOD_OVERRIDE:'delete'}));
		}
		
		protected function assertRestCall(call:AsyncToken, url:String, verb:String="GET"):void {
			assertEquals("http://localhost:3000"+url, lastHttpService.url);
			assertEquals(verb, lastHttpService.method);
		}
		
	}
}