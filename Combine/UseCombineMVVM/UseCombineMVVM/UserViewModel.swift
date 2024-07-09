import Combine

class UserViewModel: ObservableObject {
    @Published var user: User
    @Published var name: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(user: User) {
        self.user = user
        self.name = user.name
        
        // Sync name changes with the user object
        $name
            .dropFirst() // Ignore the initial value
            .sink { [weak self] newName in
                self?.user.name = newName
            }
            .store(in: &cancellables)
    }
}
