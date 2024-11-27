import Foundation

class MockURLSession: URLSession {
    var mockData: Data?
    var mockError: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(mockData, nil, mockError)
        return URLSessionDataTask()
    }
}