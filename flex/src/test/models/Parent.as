package test.models
{
	import active_resource.ActiveResource;
	
	import mx.collections.ArrayCollection;
	
	dynamic public class Parent extends ActiveResource
	{
		public function Parent(attributes:Object=null)
		{
			super(attributes);
		}
		
		public var id:*;
		public var name:String;
		public var favorite_food:String;
		public var children:ArrayCollection;
		/* static block */		
		resource("parents", Parent); 		
	}
}