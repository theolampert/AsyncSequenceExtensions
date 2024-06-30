extension Sequence {
    func concurrentMap<T>(
        _ transform: @escaping (Element) async throws -> T,
        priority: TaskPriority? = nil
    ) async throws -> [T] {
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
