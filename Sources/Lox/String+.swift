extension String {
    func substring(from: Int, to: Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[fromIndex..<toIndex])
    }
}
