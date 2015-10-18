# ThunderProject
Explore the Livecode development system as a way of deploying mobile clients on iOS and Android

Livecode is an IDE used to create Macintosh, Windows, iOS, Android and Server apps.  It is based on a language that I wrote the LALR grammar for back in my Apple days.  I am interested in exploring whether I can use Livecode to create user interfaces for fully decopled mobile apps.  The goal of my Thunder Project would be to release an iPhone, iPad and as a stretch goal, an Android front end for a simple app.

The client apps would either 
  1. talk JSON to the Sinatra/Rails server using the normal RESTful routes.  
  2. potentially talk websockets (what would the advantages be?)
  
In phase 1 and 2, I used TCP/IP sockets with Sinatra.  This was simpy because we hadn't learned routes and json.  Yet, websockets is an up and coming technology for de-coupled apps.  Why?

Ultimately our problem is this:  A web app pushes stateless pages to the client "UI Server" known as a web browser.  For the most part, the entire web page is redrawn each time.  A page is a terrible metaphor for an application. 

A mobile app is the reverse: everything is coded at the client and simple data requests are made of the server.  This makes sense but it potentially means tripling the cost and complexity of our jobs: we must write a web-app, an iOS app, and an Android on.  Phone Gap tries to avoid this by trying to create an application out of a document's CSS and HTML.  But that strikes me as using the weakest, most document centric part of a web app to build your mobile app from.   Other solutions try to write "mobile-first" web apps which are still just browser pages.  Neither of those are acceptable solutions.

I don't know what the answer is, but I will try to ask these questions:
  1. Can LiveCode be used to significantly reduce the pain and learning curve associated with mobile clients?
  2. Is there any way to compose pages on the server without having to learn two completely different environments but without sucumbing to stateless complete page redraws?  
  3. 
  
![Definition of Passion] (images/definition.png)
---

![Web/App Intersection] (images/PassionDiagram.png)

If you think about it, web apps and native apps seem to go about things in completely opposite ways.  The web server runs remotely and serves up pages; the native app runs locally and pulls down data.  One is written in Ruby, HTML, CSS and Javascript while the other is written in Swift or Java. 

Different architectures, different languages, yet it's the same app.  These days we must support both Web and Mobile. What can be done?  My passion project will implement each of the required technologies and then proceed to experiment with one or more ways to take them mobile or make it easy to do so.

---

###Mike Farr
michaelmfarr@gmail.com <br>
mikefarr@mac.com

####DBC sf-dragonflies-2015
---
<br><br><br>
###User Requirements:
* I want to use my apps via the web, my phone, my tablet and often on my PC/Mac.
* I don't want a lowest common denominator experience, each should exploit the best of it's platform
* I want my tablet and phone apps to feel like native apps
* I want my web experience to feel like a web experience when appropriate: if what I am doing is browsing and a page metaphore is appropriate, don't give me a fixed frame app.  When I resize a page of information, I want it to reflow.
* If the Internet is not available I should still have an app experience on my device using persistant data if appropriate.
 
###Developer Requirements:
* I don't want to have to write multiple separate apps
* I want to leverage MVC to keep the model and controller logic common while the view is free to change with output target
* I want to reduce the number of languages and frameworks I have to learn

###Background
In phase-1, we created several command line applications.  Taking advantage of the MVC paradigm one could swap out a vanilla command line view with something more interesting. Both my Sudoku solver and my Ruby Racer use this approach.  Here is RubyRacer (click to view video).

<a href="http://www.youtube.com/watch?feature=player_embedded&v=7eWvCm3l7pQ
" target="_blank"><img src="http://img.youtube.com/vi/7eWvCm3l7pQ/0.jpg" 
alt="Ruby Racer teaching example." width="560" height="315" border="10" /></a>

That's all well and good, but how far can this go? In the next video I replace the command-line View Module of our flashcard assignment with a RemoteView leaving the model and controller untouched.  The remote view manages a UI server I built as a native Macintosh application.  The UI server and the Ruby Flashcard app talk over sockets.  The UIServer is much like a browser except instead of HTML, it's Ruby objects that are indirectly being rendered. This is done through a RemoteView class leaving the rest of the program untouched.   
 
<a href="http://www.youtube.com/watch?feature=player_embedded&v=37ZlKUeJXfM
" target="_blank"><img src="http://img.youtube.com/vi/37ZlKUeJXfM/0.jpg" 
alt="Flashcard UI." width="560" height="315" border="10" /></a>

##The Application

The Web App I'd like to build to experiment with all this revolves around a sheet music database for the Men’s chorus I belong to at the St. Francis Yacht Club.  We have around 1,000 pieces of music with data on composer, lyricist, season (i.e. holiday), style, parts (i.e Tenor, Bass). We’d want to search on all those fields.  Additionally I think that storing the programs we sing gives the required many to many relation: Each song is in potentially many programs (think holiday favorites), each program contains many songs.  

####Minimum Viable Product
I have met several times with the stakeholders at the StFYC: the music director, the president of the SOTS, and the exec staff as well as the Director of Communications, IT manager and the General Manger.  We have agreed upon the following features for the initial release: 
<br>

1. Search the database on any of the fields (or combination thereof) below.  
2. CRUD on **songs**  
3. Retrieve a PDF of a song
4. Secure login
5. CRUD on **users**
	 
Relating performances to songs is more a factor of my need to deal with a many-to-many relationship so it is not in release 1.
	
  *Here is the initial schema. Users is an independant table.  Performances and Songs have a many to many relationship.  This is captured in the performances_songs table.
 <br>
###![Schema](schema.png)
    
Here is the information we’ll be storing for each of our...
####songs
* song_id		
* song_number		--the physical folder where the paper copy can be found.
* song_title
* composer
* larger_work		––if the song is part of a larger work: “King And I”    
* arranger1			
* arranger2
* voicing
* description
* pdf_url				
* created_at
* updated_at

The client has clarified that the description field is really a category.   A song can only be in one category so it doesn't need a separate table.  Below are the currently enumerated values but I expect they shall grow.  National anthems may be the next as the club hosts teams from all over the world.  Rather than use a db enumeration I'll probably enforce this initially by using a pop down menu. .

####Categories of songs
* Christmas
* Broadway
* Sea Chanty
* Spiritual
* Sacred
* Patriotic
* FolkSong
* Original
* Other
* 

###Users
* name
* username
* email 
* phone_number
* password_hash
* created_at
* updated_at

####Performances
* id
* title
* date
* performance_time
* call_time
* location
* created_at
* updated_at


####Songs_Performaces
*id
*performance_id
*song_id
* created_at
* updated_at


##Routes
Resource | CRUD        |HTTP Verb | Path     | User for 
--------|--------------|-------|-------------|-----------
**Users**| Create      | GET   | users/signup | requesting signup for a new user
      	| 	       | POST  | users/signup | create user
      	| Read         | GET   | /           | go to login
      	|              | GET  | /users/login | get user login info
      	|              | POST  | /           | authenticate, go to home page
      	|              | GET   | /users/show | display user's information
      	| Update       | GET   | /users/edit  | make changes in user profile
      	|              | POST  | /users/edit  | receive and save changes
      	| Delete       | DELETE| /user/delete| delete the currently logged in user's account
**Songs** | Create     | GET   | songs/create | put up form to create a new song in the db
       	| 	       | POST  | songs/create | create song record
      	| Read         | GET   | /songs/search   | request search page
      	|              | POST  | /songs/search   | search on params, return matching songs
      	|	       | GET | /songs/show/:id | display the PDF of the song, somehow
      	| Update       | GET   | /songs/edit  | request to make changes in a song
      	|              | POST  | /songs/edit  | receive and save changes
      	| Delete       | DELETE| /songs/delete| delete the currently logged in user's account

	

User
* Create
		1. sign_up
* Read
		2. login
		3. user_profile
* Update
		1. edit user_profile
* Delete
		1.
3. 


The club loaned me an intern who has around 800 pieces of sheet music scanned and we have meta data collected for about 500 of those.  

