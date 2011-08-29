package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Job extends ActiveResource
	{
		
		public function Job(attributes:Object=null)
		{
			super(attributes);
		}
		
		/* static block */
		resource("jobs", Job); 		
	}
}