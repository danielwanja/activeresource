# WARNING: not prime time ready...In fact I just started this project (August 15th 2011)

# flexonrails - An ActionScript Framework to integrate Flex with Ruby on Rails

A Flex/ActionScript Framework to integrate with Ruby on Rails. Provides Restful access to Rails including nested attributes.

## Installing:

### Rails app:

Add this line to Gemfile and run bundle install:
```ruby
gem 'flexonrails'
```

```ruby
	class Author < ActiveRecord::Base
      accepts_nested_attributes_for :posts, :allow_destroy => true
	end
	
	class Post < ActiveRecord::Base
      accepts_nested_attributes_for :comments, :allow_destroy => true
	end

	class Comment < ActiveRecord::Base
	end
	
```

### Flex App

Copy the flexonrails.swc to the lib folder of you application.

## Usage

First create a dynamic class that maps to q resource:

```javascript
	[RemoteClass(alias="Author")]
	public dynamic class Author extends ActiveResource
	{
		resource("authors", Author);   // associate resource class...Hope I can determine this based on RemoteClass tag.
		accepts_nested_attributes_for('posts')
	}

	[RemoteClass(alias="Post")]	
	public dynamic class Post extends ActiveResource {
		resource("posts", Post)		
		accepts_nested_attributes_for('comments')
	}
	
	[RemoteClass(alias="Comment")]	
	public dynamic class Comment extends ActiveResource {
		resource("comments", Comment);		
	}
```

Note that the accepts_nested_attributes_for is defined on the Flex side in order to identify which collections to send to the server as nested attributes. This allows in this case to update the author, it's posts and the associated comments in one server call.

Find all authors with posts and comments:

```ruby
	class AuthorController < ApplicationController

        def show  # FIXME: this example is wrong
          @author = Author.find(params[:id], :include => {:posts => :comments})

          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @author }
            format.xml  { render @author }
          end
        end
      
    end
```

You can then query these nested objects from ActionScript:

```javascript
    var call:AsyncToken = ActiveResource.find(Author, 1);
```

Add one post and comment to the author:

```javascript
	var post:Post = new Post()
	post.body = "Simple way to interact with Rails"
	post.comments = new ArrayCollection
	var comment:Comment = new Comment({content:'Using RDD - Readme Driven Development'})
	post.comments.addItem(comment)

    author.posts.addItem(post)
    author.save()  # save changes on author, post, and comments
```

To delete one post and it's comments:

```javascript
    author.posts.getItemAt(0)._delete = true
    author.save();
```


### RoadMap

1. setup test environment
2. create base ActiveResource class
3. find/create/update/delete
4. error handling
5. nested_attributes (with ActiveCollection)
5. authenticity_token
6. unify base classes with bulk_api_flex

...

### Credits

Thanks to Pinnacol Assurance for providing some of the base code and concepts on which this project is built.


### Community

Want to help? Contact Daniel Wanja d@n-so.com

Enjoy!
Daniel Wanja

