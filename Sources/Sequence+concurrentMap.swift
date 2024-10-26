extension Sequence where Element: Sendable {
    func concurrentMap<T: Sendable>(
        _ transform: @escaping @Sendable (Element) async throws -> T,
        priority: TaskPriority? = nil
    ) async rethrows -> [T] {
        let tasks = map { element in
            Task(priority: priority) {
                try await transform(element)
            }
        }

        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
}
