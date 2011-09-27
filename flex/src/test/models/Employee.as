package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Employee extends ActiveResource
	{
		
		public function Employee(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var first_name:String;
		public var last_name:String;
		public var job_id:Number;
		public var department_id:Number;
		public var manager_id:Number;
		public var hire_date:Date;
		public var salary:Number;
		public var created_at:Date;		
		public var updated_at:Date;
		
		/* static block */
		resource("employees", Employee); 		
	}
}