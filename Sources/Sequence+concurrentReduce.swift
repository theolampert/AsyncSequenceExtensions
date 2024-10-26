extension Sequence where Element: Sendable {
    func concurrentReduce<Result: Sendable>(
        _ initialResult: Result,
        _ nextPartialResult: @escaping @Sendable (Result, Element) async throws -> Result,
        priority: TaskPriority? = nil
    ) async rethrows -> Result {
        let tasks = map { element in
            Task(priority: priority) {
                try await nextPartialResult(initialResult, element)
            }
        }

        return try await tasks.asyncReduce(initialResult) { partialResult, task in
            return try await nextPartialResult(partialResult, task.value as! Element)
        }
    }
}
