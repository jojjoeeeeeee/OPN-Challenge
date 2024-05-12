import Alamofire

class NetworkRequestRetrier: Retrier {
    init() {
        super.init() { request, session, error, completion in
            var retriedRequests: [String: Int] = [:]
            guard request.task?.response == nil, let url = request.request?.url?.absoluteString else {
                guard let url = request.request?.url?.absoluteString else { return }
                retriedRequests.removeValue(forKey: url)
                completion(.doNotRetry)
                return
            }
            
            guard let retryCount = retriedRequests[url] else {
                retriedRequests[url] = 1
                completion(.retryWithDelay(30))
                return
            }
            
            if retryCount <= 3 {
                retriedRequests[url] = retryCount + 1
                completion(.retryWithDelay(30))
            } else {
                guard let url = request.request?.url?.absoluteString else { return }
                retriedRequests.removeValue(forKey: url)
                completion(.doNotRetry)
            }
        }
    }
}
