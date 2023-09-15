extension String {
    mutating func append(_ value: Int, suffix: String, omitZeroValues: Bool) {
        guard value != 0 || !omitZeroValues else {
            return
        }
        self.append("\(value)\(suffix)")
    }
}
