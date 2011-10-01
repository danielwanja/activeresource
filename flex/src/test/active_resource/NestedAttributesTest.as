package test.active_resource
{
	import active_resource.ActiveResource;
	import active_resource.RailsEncoder;
	
	import com.adobe.serialization.json.JSONDecoder;
	
	import flashx.textLayout.debug.assert;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.AbstractEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.hasProperties;
	
	import test.helper.BaseServerTestCase;
	import test.models.Child;
	import test.models.Department;
	import test.models.Employee;
	import test.models.Job;
	import test.models.Parent;

	public class NestedAttributesTest extends BaseServerTestCase
	{		
		[Before(async)]
		public function setUp():void
		{
			loadFixtures("setup_departments");
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test(async)]
		public function testCreation():void {   
			var dept:Department = new Department();
			dept.name = "IS";
			dept.city = "Denver";
			dept.state = "CO";
			dept.employees = new ArrayCollection();
			var emp1:Employee = new Employee();
			emp1.first_name = "Daniel";
			emp1.last_name  = "Wanja"; 
			dept.employees.addItem(emp1);
			var emp2:Employee = new Employee();        
			emp2.first_name = "Dayle";
			emp2.last_name  = "Larson";
//			emp2.manager = emp1; // :-)   // FIXME: add test for these additional cases.
//			emp2.job = new Job();
//			emp2.job.name = "Job Name";
			dept.employees.addItem(emp2);   
			assertCall(dept.save({nestedAttributes:['employees','employees.job']}), function(result:Object):void {
				assertTrue(result is Department);
				var dept:Department = result as Department;
				assertEquals("IS", dept.name);
				assertNotNull(dept.employees) 
				assertEquals(2, dept.employees.length);
				var employeeNames:Array = [];
				dept.employees.source.forEach(function (item:*, index:int, array:Array):void {
					employeeNames.push(item.first_name);
				});
				assertThat(employeeNames, hasItems("Daniel", "Dayle"));
			});
		}
		
		//----------------------------------------
		// UPDATE
		//----------------------------------------
		
		[Test(async)]    
		public function testUpdate():void {
			assertCall(ActiveResource.find(Department, fixtures.department1.id), function (result:Object):void {
				var dept:Department = result as Department;
				dept.name = "UPDATED";
				dept.employees[0].last_name = "UPDATED";
				dept.employees[1]._destroy = true;	
				assertCall(dept.save({nestedAttributes:['employees','employees.job']}), function (result:Object):void {
					var dept:Department = result as Department;
					assertNotNull(dept);
					assertEquals("UPDATED", dept.name);
					assertEquals(2, dept.employees.length);
					assertEquals("UPDATED", dept.employees.getItemAt(0).last_name);
					assertEquals("last_3", dept.employees.getItemAt(1).last_name);					
				});
			});
		}
		
	}
}