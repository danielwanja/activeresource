package test.models
{
	import active_resource.ActiveResource;
	
	dynamic public class Child extends ActiveResource
	{
		public function Child(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var name:String;
		public var favorite_food:String;
		
		/* static block */		
		resource("children", Child); 		
	}
}