# PokemonApp

Existing App has been revamped to contain UI Tests, Core Data, and CocoaPods
Project Folders have been added to segregate different modules the App uses

In order to make the project more testable, I have integrated TDD concepts into the project via:
Adding a ViewModel layer that does the API fetching
Adding API Protocol which an actual API and a MockAPI adheres to

In addition to that, the project can easily integrate future 3rd party libraries in the future via:
CocoaPods Integration

The project also now supports CoreData Layer so in the future, offline handling can be added.

The project also now has Unit Testing, particularly, Unit Testing has been added to the ViewModel layer in order to ensure that:
The ViewModel properly receives the relevant data from the API(Mock)
The ViewModel updates the data it supplies the ViewController correctly

For the issue regarding making sure the detail and list layers do not know about each other, if given more time to do this, a solution would be to 
update the architecture to use Coordinator Pattern. So that the Coordinator handles the passing of data in between Views
