package test.active_resource
{
	import active_resource.ActiveResource;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.asserts.assertEquals;
	
	import test.models.Department;
	import test.models.Employee;

	public class NestedResourcesTest
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
		
		[Test]
		public function testNestedUrls():void {
			var employee:Employee = new Employee();
			employee.first_name = "employe one";
			
			var department:Department = new Department();	
			department.name = "department one";
			department.id = 1;
			
			assertRestCall(employee.save({nestedBy:department}),  "/departments/1/employees.json", "POST");
			
			employee.id = 3;
			assertRestCall(employee.save({nestedBy:department}),  "/departments/1/employees/3.json", "POST");
			assertRestCall(employee.destroy({nestedBy:department}),  "/departments/1/employees/3.json", "POST");
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
		
		protected function assertRestCall(call:AsyncToken, url:String, verb:String="GET"):void {
			assertEquals("http://localhost:3000"+url, lastHttpService.url);
			assertEquals(verb, lastHttpService.method);
		}		
		
	}
}