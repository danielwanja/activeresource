package test
{
	import active_resource.ActiveResource;
	
	import test.models.Department;

	public class TestActiveResource
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
		
		/*
		*                Verb    Url                      Action
		*      employees GET    /employees(.:format)      index
		*                POST   /employees(.:format)      create
		*       employee GET    /employees/:id(.:format)  show
		*                PUT    /employees/:id(.:format)  update
		*                DELETE /employees/:id(.:format)  delete
		*/
		[Test]
		public function testRestUrls():void {
			var resource:Department = new Department();
			
		}
		
		
	}
}