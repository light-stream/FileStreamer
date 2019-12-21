import Foundation
/**
 * Reads data from a file (Continiously)
 */
public class FileStreamReader {
   /**
    * Reads data from filepath
    * ## Examples:
    * let filePath: String = NSString(string: "~/Desktop/del.txt").expandingTildeInPath
    * let data: Data = FileStreamReader.read(filePath: filePath, startIndex: 50, endIndex: 100)
    * Swift.print("\(String(data: data, encoding: .utf8))") // blalbslalballabalbla...
    * - Fixme: ⚠️️ Use UInt64 on endIndex
    * - Fixme: ⚠️️ Use Result type
    */
   public static func read(url: URL, startIndex: UInt64, endIndex: Int) throws -> Data {
      do {
         let file: FileHandle = try .init(forReadingFrom: url)
         file.seek(toFileOffset: startIndex)
         let length: Int = endIndex - Int(startIndex)
         let databuffer = file.readData(ofLength: length)
         file.closeFile()
         return databuffer
      }
      catch { throw NSError(domain: "Error: \(error) reading \(url.path)", code: 0) }
   }
}
/**
 * Helper
 */
extension FileStreamReader {
   /**
    * Support for filePath
    * - Fixme: ⚠️️ Use Result type
    */
   public static func read(filePath: String, startIndex: UInt64, endIndex: Int) throws -> Data {
      let url: URL = .init(fileURLWithPath: filePath)
      return try read(url: url, startIndex: startIndex, endIndex: endIndex)
   }
   /**
    * Read string
    * - Fixme: ⚠️️ Use Result type
    */
   static func read(filePath: String, start: UInt64, end: Int) throws -> String {
      let data: Data = try FileStreamReader.read(filePath: filePath, startIndex: start, endIndex: end)
      guard let string = String(data: data, encoding: .utf8) else { throw NSError(domain: "FileStreamReader.read() - Unable to get string from data data.count: \(data.count)", code: 0) }
      return string
   }
}
