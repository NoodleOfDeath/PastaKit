// Copyright (c) 2016 NoodleNation <noodlebox@noodlenation.net>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public let NSFileManagerErrorCodeCopyFailedFileAlreadyExists = 516

/// Convenience `NSFileManager` methods for directory creation
extension FileManager {

    open func createDirectoryAtURL(_ url: URL, withIntermediateDirectories createIntermediates: Bool = true) throws {
        do { 
            try createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: nil)
        } catch { throw error }
    }
    
    open func createDirectoryAtPath(_ path: String, withIntermediateDirectories createIntermediates: Bool = true) throws {
        do {
            try createDirectory(atPath: path, withIntermediateDirectories: createIntermediates, attributes: nil)
        } catch { throw error }
    }

}

/// Convenience `NSFileManager` methods for copying files
extension FileManager {
    
    open func copyItemAtURL(_ url: URL, toURL: URL, overwriteExisting: Bool) throws {
        if overwriteExisting { do { try removeItem(at: url) } catch {} }
        do {
            try copyItem(at: url, to: toURL)
        } catch { throw error }
    }
    
    open func copyItemAtPath(_ path: String, toPath: String, overwriteExisting: Bool) throws {
        if overwriteExisting { do { try removeItem(atPath: path) } catch {} }
        do {
            try copyItem(atPath: path, toPath: toPath)
        } catch { throw error }
    }
    
}

/// Convenience `NSFileManager` methods for getting directory contents
extension FileManager {
    
    open func contentsOfDirectoryAtURL(_ url: URL) throws -> [URL] {
        do {
            return try contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        } catch { throw error }
    }
    
}


