# Movie Collection Manager

Movie Collection Manager allows you to choose your movies and put them in collections, share with friends and see which streaming services contain the movies.

The Project is collecting data of the API _The Movie Database_.
[The Movie Database](https://www.themoviedb.org/), better known by the acronym TMDb, is a free and open source database about movies and series.

![screenshot_home](https://user-images.githubusercontent.com/6653128/172750291-c38d5ef2-3fae-41c5-9c70-ca848cbe43f9.png)

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

## Known issues 

- ListTile on MovieScreen is not memory adaptive
- Button "Filters" in search bar is not working

## Bug Fix

- [x] No-Internet connection crashes the app when first run
- [x] No-Internet connection message when first run
- [x] Scroll Up/Down FAB not working on the end of the scroll

# FUTURE

To work in teams the project it will be divided as in the following image. To create a Multi-Repo in the future if necessary.

![micro_app_arch](https://user-images.githubusercontent.com/6653128/172748425-df751958-3b08-486e-b45b-b0e5012dd420.png)
