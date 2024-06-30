@testable import AsyncSequenceExtensions
import XCTest

final class AsyncSequenceExtensionsTests: XCTestCase {
    func testAsyncMap() async throws {
        let numbers = [1, 2, 3, 4, 5]
        let result = try await numbers.asyncMap { number in
            try await Task.sleep(nanoseconds: 1_000_000)
            return number * 2
        }

        XCTAssertEqual(result, [2, 4, 6, 8, 10])
    }

    func testConcurrentMap() async throws {
        let numbers = [1, 2, 3, 4, 5]
        let result = try await numbers.concurrentMap { number in
            try await Task.sleep(nanoseconds: 1_000_000)
            return number * 2
        }

        XCTAssertEqual(result, [2, 4, 6, 8, 10])
    }
}
