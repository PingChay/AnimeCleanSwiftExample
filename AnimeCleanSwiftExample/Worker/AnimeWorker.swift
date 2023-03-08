//
//  AnimeWorker.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import Moya

protocol AnimeWorker {
    func getAnime(request: GetAnimeRequest,
                  onSuccess: @escaping(_ response: GetAnimeResponse) -> Void,
                  onFailure: @escaping(_ response: ResponseFail) -> Void)
}

final class AnimeWorkerImpl: AnimeWorker {
    private let provider: MoyaProvider<AnimeProvider>

    init(provider: MoyaProvider<AnimeProvider> = .init()) {
        self.provider = provider
    }

    func getAnime(request: GetAnimeRequest,
                  onSuccess: @escaping(GetAnimeResponse) -> Void,
                  onFailure: @escaping(ResponseFail) -> Void) {
        provider.request(.getAnime(request: request)) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case let .success(response):
                    self.handleOnSuccess(response: response,
                                         onSuccess: onSuccess,
                                         onFailure: onFailure)
                case let .failure(error):
                    self.handleOnFail(error: error,
                                      onFailure: onFailure)
            }
        }
    }

    private func handleOnSuccess<T: Decodable>(response: Response,
                                               onSuccess: @escaping(T) -> Void,
                                               onFailure: @escaping(ResponseFail) -> Void) {
        do {
            let responseObject = try response.map(T.self)
            onSuccess(responseObject)
        } catch {
            onFailure(ResponseFail(status: nil,
                                   type: nil,
                                   message: "mapError",
                                   error: "mapError"))
        }
    }

    private func handleOnFail(error: MoyaError,
                              onFailure: @escaping(ResponseFail) -> Void) {
        do {
            guard let responseObject = try error.response?.map(ResponseFail.self) else {
                onFailure(ResponseFail(status: nil,
                                       type: nil,
                                       message: "no response",
                                       error: "no response"))
                return
            }
            onFailure(responseObject)
        } catch {
            onFailure(ResponseFail(status: nil,
                                   type: nil,
                                   message: "mapError",
                                   error: "mapError"))
        }
    }
}
