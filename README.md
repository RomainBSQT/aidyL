# iOS - Technical test subject - Lydia

Rendu pour le test technique

- Supporte iOS >= 15.0
- Réalisé sur XCode 14.2
- Fait en VIP
- Pas de libs externe
- Temps demandé : environ 3 jours

##### Comporte :
- Tests unitaire des couches `Presenter` et `Interactor`
- Échange avec l'API avec Combine
- GitHub workflow CI
  
## 🍎🔍 Subject

#### Build an app that fetches data from this service :
`randomuser.me`

####  Goal of the app:
- Use `https://randomuser.me/api/?results=10` to get 10 contacts for each api call
- Like most lists, implement infinite scroll
- Reload of the list of users should be possible
- The app must handles connectivity issues and displays the complete last
results received if it can't retrieve one at launch.
- Touching an item on the list should make appear a detail page listing
every attribute.

#### Technical implementation constraint:
- The app must be in Swift.
- Any third-party libraries are allowed but the choice must be justified.
- Controllers should be made without storyboard or any xib.
- SwiftUI is not allowed.

Do not stick to the subject, go beyond and let your imagination drive your work.\
The UI is not the most important part but will be taken into consideration though during the review of your project.\
Evaluate the time it should take before starting, and give it with your work, with the time it really took.

Good luck ! 🤙