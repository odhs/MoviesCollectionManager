# Movie Collection Manager

Movie Collection Manager allows you to choose your movies and put them in collections, share with friends and see which streaming services contain the movies.

## Use Cases 

User can:

- [x] See a _movies_ list.
- [x] Use a Search Bar to look for _movies_ in the list.
- [ ] Favorite a movie.
- [ ] See in which streaming services the movie is available to watch.
- [ ] See a **Collection** list.
- [ ] Manage **Collections**
  - [ ] Create a **Collection** of movies.
  - [ ] Change **Collection** properties.
  - [ ] Delete a **Collection**.
- [ ] Edit **Collections**
  - [ ] Select _movies_ and put into a **Collection** already created.
  - [ ] Remove _movies_ from a **Collection**.
  - [ ] Select _movies_ and put into a new **Collection**.
- [ ] Share **Collections** with friends.
- [ ] Share a link to a _movie_.

Future:

- [ ] Search a movie on the Internet
- [ ] Store search in cache
- [ ] Suggestions with Lasted Search
- [ ] Export list
- [ ] Save App data in a cloud of the user
- [ ] Retrieves App data 

## App Design

https://www.figma.com/file/p7dCXduT1B2EyMsqnPqnAX/Movies-Collection-Manager?node-id=51195%3A4667

## Simple Macro Road Map

- [x] App Design in Material You Design
	- [ ] Mobile Design
		- [x] Smartphone design
		- [ ] Tablet design
	- [ ] Desktop/TV Design

- [x] Architecture (_Clean Arch_)
- [x] Feature, Domain, Data, Use Cases, Core

- [x] Data Sources definition
- [x] Define model data to match the provided by the API
- [x] Infrastructure implementation and
- [ ] Infrastructure Tests
- [x] Use Cases Implementation
- [ ] Use Cases Test

- [ ] Refactoring
	- [x] Dependency Injection (_GetIt_)
	- [x] Functional Programming for Error Handling (_Dartz_)
	- [ ] Class Equality (_Equatable_)

### Controllers

- [ ] Definition of States
	- [ ] Implementation of States
	- [x] Implementation of Controllers
	- [x] Implementation of Services

- [ ] Cache in Persistent local database

### Views

- [ ] Implementation of screens
  - [ ] Mobile First
  	- [x] Screen navigation
    - [x] Movies Page
    - [x] Collections Page
    - [x] account Page
  	- [ ] Controllers
  
- [x] Implementation of Themes
	
- [x] Internationalizing Texts

- [ ] Responsive Layout Refactoring
  - [ ] Mobile Layout
  - [ ] Tablet Layout
  - [ ] Desktop Layout

- [ ] Adaptive Layout Refactoring
  - [ ] Keyboard
  - [ ] Mouse

### Tests

- [ ] Screen Tests 
	- [ ] Screen Tests by Code
	- [ ] Screen Tests in Emulators 
	- [ ] Screen Tests in Devices

### Publication

- [ ] Sign App
- [ ] App Icon
- [ ] Prepare _Google Play_ Art
- [ ] _Google Play_ Profile

## Future

- [ ] Prepare Code for other platforms
  - [ ] Code for iOS
  - [ ] Code for Windows
  - [ ] Code for Linux

- [ ] All the other things no planned yet

## Todo Later

- [ ] Refactor localization .arb files to a standard.
- [ ] ListTile in movies_page.dart is shrink

## Known issues 

- ListTile on MovieScreen is not memory adaptive
- Button "Try Again" in the no-internet message is not working
- Button "Filters" in search bar is not working

## Bugs Fix

- [x] No-Internet connection crashs the app when first run
- [x] No-Internet connection message when first run



