import XCTest
@testable import PostsManagerApp

class UsersInteractorTests: XCTestCase {

    var sut: UsersInteractor!
    var presenterMock: PresenterUsersMock!
    var localDataManagerMock: LocalDataManagerUsersMock?
    var remoteDataManagerMock: RemoteDataManagerUsersMock?

    override func setUpWithError() throws {
        sut = UsersInteractor()
        presenterMock = PresenterUsersMock()
        localDataManagerMock = LocalDataManagerUsersMock()
        remoteDataManagerMock = RemoteDataManagerUsersMock()

        sut?.presenter = presenterMock
        sut?.localDataManager = localDataManagerMock
        sut?.remoteDataManager = remoteDataManagerMock
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
        localDataManagerMock = nil
        remoteDataManagerMock = nil
    }

    func tests_loadUsers() throws {
        sut?.loadUsers()
        XCTAssertTrue(presenterMock?.returnedUsers ?? false)
    }
}

class PresenterUsersMock: ViewToPresenterUsersProtocol {
    var presenter: InteractorToPresenterUsersProtocol?
    var returnedUsers: Bool = false

    func fetchUsers(users: [User]) {
        if let listUsers = users, users.count > 0 {
            self.returnedUsers = true
        } else {
            self.returnedUsers = false
        }
    }
}

class LocalDataManagerUsersMock: InteractorToLocalDataManagerUsersProtocol {
    var localRequestHandler: LocalDataManagerToInteractorUsersProtocol?
    var listUsersResponse: [User] = []

    func getLocalUsers() {       
        localRequestHandler.callBakLocalUsers(listUsersResponse)
    }
}

class RemoteDataManagerUsersMock: InteractorToPresenterUsersProtocol {
    var remoteRequestHandler: RemoteDataManagerToInteractorUsersProtocol?
    var listUsersResponse: [User] = []

    func getLocalUsers() {       
        remoteRequestHandler.callBakRemoteUsersSuccess(users: listUsersResponse)
    }
}
