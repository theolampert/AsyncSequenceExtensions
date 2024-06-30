extension Sequence {
    func asyncFilter(
        _ isIncluded: (Element) async throws -> Bool
    ) async rethrows -> [Element] {
        var result = [Element]()
        for element in self {
            if try await isIncluded(element) {
                result.append(element)
            }
        }
        return result
    }
}
