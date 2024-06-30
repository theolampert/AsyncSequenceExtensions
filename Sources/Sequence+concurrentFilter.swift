extension Sequence {
    func concurrentFilter(
        _ isIncluded: @escaping (Element) async throws -> Bool,
        priority: TaskPriority? = nil
    ) async rethrows -> [Element] {
        return try await withThrowingTaskGroup(of: (Element, Bool).self) { group in
            for element in self {
                group.addTask(priority: priority) {
                    try (element, await isIncluded(element))
                }
            }

            var result = [Element]()
            for try await (element, isIncluded) in group {
                if isIncluded {
                    result.append(element)
                }
            }
            return result
        }
    }
}
