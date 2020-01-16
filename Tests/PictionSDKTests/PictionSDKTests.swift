import XCTest
import Moya
import Moya_ModelMapper
@testable import PictionSDK

final class PictionSDKTests: XCTestCase {
    var provider = MoyaProvider<UserAPI>()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testProjects() {
        let expectation = XCTestExpectation(description: "Request Test")

        PictionSDK.user.findOne(id: "piction", success: { response in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }, failure: { error in
            XCTFail()
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2)
    }

    func testTarget() {
        let expectation = XCTestExpectation(description: "Target Test")
        var responseData: UserModel?

        provider.request(.findOne(id: "piction")) { result in
            if case let .success(response) = result {
                responseData = try? response.map(to: UserModel.self)
                XCTAssertEqual(response.statusCode, 200)
                XCTAssertNotNil(responseData)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2)
    }

    static var allTests = [
        ("testProjects", testProjects),
        ("testTarget", testTarget)
    ]
}
