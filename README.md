# quizzSchool – a java howework
## a small java web app – JEE servlets and JSP, no framework.

This app offers a basic site (no complicated CSS styling required) allowing visitors to try to register to a school by passing a quizz selected on a list, where they are grouped by theme, and, once students, validate their course.

The quizzes and themes an user can see vary depending on several parameters (notable the user's status), actually hardcoded in some classes.


###these quizzes are categorizes on several criterias:
* their theme

* made exclusively of MCQ ("Multiple Choice Questions"),
or allowing questions with free-text answers ?

* constitued of a determined set of questions, or randomly build of a specified amount of questions picked from a pool of questions sharing a specific theme?


###some scarse technical details (let you just parse the code!):
- *no database abstraction layer; it targets MySql 5*.
  * Some of the (prepared) SQL statements are  not portable, such as the clause "**ORDER BY RAND()**"

- *rows in the DB are more-or-less represented by objects* (which can have more properties than their DB counterparts, such as the *Quizz* object),
 and foreign keys are traduced as objects references.

- **TODO:** talk about caching and data coherence.
    * between the time an user load a quizz page and send back data, the DB can change, quizzes and questions can be added/delete/altered. So we need extra steps to ensure the data send back will be corrected according to the original quizz, even if it was deleted in the meantime.  
    * The question is even more interesting with quizzes containing free-text answers, whose correction is not automatizable; in this case, answers from the (wannabe) student are stored in DB for future correction, as referenced objects in DB must be keep alive until the correction is done...
    
- *project structure:*
```
|_lib
|   ↑ store jar dependancies here
|_sql scripts
|   ↑ scripts for creating and filling the DB
|_src
|   |_org
|       |_monochrome
|           |_models
|           |    ↑ POJO objects backed to DB 
|           |_persistence
|           |    ↑ repositories (classes encapsulating DB access in method)
|           |_services
|                ↑ functionalities shared and/or abstracted away from other classes
|           |_ servlets
|                ↑ each servlet handle a subtree of the site map
|_ web
    |_css
    |_WEB-INF
        _views
           ↑ JSP pages are stored here
```


### how to install and use this app:
#### prerequites:
* the Java Development Kit, v8 or higher (although untested with java < 8, it could works...) for compiling this project
* a running MySQL-compatible server, local or distant.
  * a user and associated rights to access this DB.

####Installation:
**WARNING!**  
 this part is _**under construction. TODO!**_
* clone or donwload the sources.

* set up the database:
   * either source into your mysql client the script **DB creation script.sql**, if you want an empty database,  
 or create a empty database, and then populate it by sourcing the sql script **DB test data insertion script.sql** which will create and fill the tables.
    * eventually add an user to the database and give them the needed access rights on the created database.
    * modify the file src/org/monochrome/config/app.properties to reflect your configuration.

* copy under the _**lib/**_ folder these dependencies:  
    jstp-1.2.jar
    mysql-connector-java-8.0.13.jar
    protobuf-java-3.6.1.jar
* __TODO:__
  * import .idea: which directories?
  * must other libraries be copied under /lib (eg tomcat libs)?
  * write instructions for compiling a .war.
  * perhaps write instructions for deploying this file under the tomcat server?
  