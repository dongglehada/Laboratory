//
//  Provider.swift
//  Laboratory
//
//  Created by SeoJunYoung on 5/25/24.
//

import Foundation
import RxSwift

protocol Provider {
    /// 특정 responsable이 존재하는 request
    func request<R: Decodable, E: RequesteResponsable>(with endpoint: E) -> Observable<R> where E.Response == R
}

class ProviderImpl: Provider {
    
    private let disposeBag = DisposeBag()

    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    deinit {
        print(self, "deinit")
    }
    
    func request<R: Decodable, E: RequesteResponsable>(with endpoint: E) -> Observable<R> where R == E.Response {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else {
                observer.onError(NetworkError.unknownError)
                return Disposables.create()
            }
            
            do {
                let urlRequest = try endpoint.getUrlRequest()
                self.session.dataTask(with: urlRequest) { data, response, error in
                    self.checkError(with: data, response, error).subscribe { data in
                        let result: Observable<R> = self.decode(data: data)
                        result.subscribe { data in
                            observer.onNext(data)
                            observer.onCompleted()
                        } onError: { error in
                            observer.onError(error)
                        }
                        .disposed(by: self.disposeBag)
                        
                    } onError: { error in
                        observer.onError(error)
                    }
                    .disposed(by: self.disposeBag)
                }.resume()
            } catch {
                observer.onError(NetworkError.urlRequest(error))
            }
            return Disposables.create()
        }
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?) -> Observable<Data> {
        
        return Observable.create { observer in
            if let error = error {
                observer.onError(error)
                return Disposables.create()
            }
            
            guard let response = response as? HTTPURLResponse else {
                observer.onError(NetworkError.unknownError)
                return Disposables.create()
            }
            
            guard (200...299).contains(response.statusCode) else {
                observer.onError(NetworkError.invalidHttpStatusCode(response.statusCode))
                return Disposables.create()
            }
            
            guard let data = data else {
                observer.onError(NetworkError.emptyData)
                return Disposables.create()
            }
            
            observer.onNext(data)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func decode<T: Decodable>(data: Data) -> Observable<T> {
        
        return Observable.create { observer in
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                observer.onNext(decoded)
                observer.onCompleted()
            } catch {
                observer.onError(NetworkError.emptyData)
            }
            return Disposables.create()
        }
    }
}

protocol URLSessionable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionable {}
