extension String {
    mutating func append(_ value: Int, suffix: String, emitZeroValues: Bool) {
        guard value != 0 || !emitZeroValues else {
            return
        }
        self.append("\(value)\(suffix)")
    }
}
