//
//  AnimeFirestoreWorker.swift
//  AnimeCleanSwiftExample
//
//  Created by Saran Nonkamjan on 3/3/2566 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AnimeFirestoreWorker {
    func getBookmark(onSuccess: @escaping(_ bookmark: String) -> Void,
                     onFailure: @escaping(_ error: Error) -> Void)
    func updateBookmark(key: String,
                        onSuccess: @escaping(_ bookmark: String) -> Void,
                        onFailure: @escaping(_ error: Error) -> Void)
    func getFavoriteAnime(anime: Anime,
                          onSuccess: @escaping(_ isFavorite: Bool) -> Void,
                          onFailure: @escaping(_ error: Error) -> Void)
    func getFavoriteAnime(onSuccess: @escaping(_ response: [Anime]) -> Void,
                          onFailure: @escaping(_ error: Error) -> Void)
    func addFavoriteAnime(anime: Anime,
                          onSuccess: @escaping(_ response: [Anime]) -> Void,
                          onFailure: @escaping(_ error: Error) -> Void)
    func removeFavoriteAnime(anime: Anime,
                             onSuccess: @escaping(_ response: [Anime]) -> Void,
                             onFailure: @escaping(_ error: Error) -> Void)
}

final class AnimeFirestoreWorkerImpl: AnimeFirestoreWorker {
    private let db: Firestore
    private let auth: Auth

    init(db: Firestore = .firestore(),
         auth: Auth = .auth()) {
        self.db = db
        self.auth = auth
    }

    func getBookmark(onSuccess: @escaping (String) -> Void,
                     onFailure: @escaping (Error) -> Void) {
        guard let uid = auth.currentUser?.uid else { return }

        let documentRef: DocumentReference = db.collection("Bookmark").document(uid)
        documentRef.getDocument { snapshot, error in
            if let error = error {
                onFailure(error)
                return
            }

            let snapshotData = snapshot?.data()
            let key: String = snapshotData?["key"] as? String ?? "naruto"
            onSuccess(key)
        }
    }

    func updateBookmark(key: String,
                        onSuccess: @escaping (String) -> Void,
                        onFailure: @escaping (Error) -> Void) {
        guard let uid = auth.currentUser?.uid else { return }

        let collectionRef = db.collection("Bookmark")
        let documentRef: DocumentReference = collectionRef.document(uid)
        documentRef.setData([
            "key": key
        ]) { error in
            if let error = error {
                onFailure(error)
                return
            }

            onSuccess(key)
        }
    }

    func getFavoriteAnime(anime: Anime,
                          onSuccess: @escaping (Bool) -> Void,
                          onFailure: @escaping (Error) -> Void) {
        guard let uid = auth.currentUser?.uid,
              let malId = anime.malID else { return }

        let collectionRef = db.collection("Favorite")
        let query: Query = collectionRef
            .whereField("user", isEqualTo: uid)
            .whereField("mal_id", isEqualTo: malId)

        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                onFailure(error)
                return
            }

            guard let querySnapshot = querySnapshot?.documents else {
                onSuccess(false)
                return
            }

            return onSuccess(querySnapshot.count != 0)
        }
    }

    func getFavoriteAnime(onSuccess: @escaping ([Anime]) -> Void,
                          onFailure: @escaping (Error) -> Void) {
        guard let uid = auth.currentUser?.uid else { return }

        let collectionRef = db.collection("Favorite")
        let query: Query = collectionRef.whereField("user", isEqualTo: uid)

        query.getDocuments { querySnapshot, error in
            if let error = error {
                onFailure(error)
                return
            }

            guard let querySnapshot = querySnapshot?.documents else {
                onSuccess([])
                return
            }

            let animeList = querySnapshot.map { queryDocumentSnapshot -> Anime in
                let empty: Anime = .init(malID: nil, url: nil, images: nil, trailer: nil, approved: nil, titles: nil, title: nil, titleEnglish: nil, titleJapanese: nil, titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: nil, scoredBy: nil, rank: nil, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, themes: nil, demographics: nil)

                return queryDocumentSnapshot.data().map(Anime.self) ?? empty
            }

            onSuccess(animeList)
        }
    }

    func addFavoriteAnime(anime: Anime,
                          onSuccess: @escaping ([Anime]) -> Void,
                          onFailure: @escaping (Error) -> Void) {
        guard let uid = auth.currentUser?.uid else { return }
        guard var animeDic = anime.toDictionary() else { return }
        animeDic["user"] = uid

        let collectionRef = db.collection("Favorite")
        collectionRef.addDocument(data: animeDic) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                onFailure(error)
                return
            }

            self.getFavoriteAnime(onSuccess: onSuccess, onFailure: onFailure)
        }
    }

    func removeFavoriteAnime(anime: Anime,
                             onSuccess: @escaping ([Anime]) -> Void,
                             onFailure: @escaping (Error) -> Void) {
        guard let uid = auth.currentUser?.uid,
              let malId = anime.malID else { return }

        let collectionRef = db.collection("Favorite")
        let query = collectionRef
            .whereField("user", isEqualTo: uid)
            .whereField("mal_id", isEqualTo: malId)
        query.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }

            if let error = error {
                onFailure(error)
                return
            }

            guard let querySnapshot = querySnapshot?.documents else {
                onSuccess([])
                return
            }

            querySnapshot.forEach { queryDocumentSnapshot in
                self.removeFavoriteWith(documentID: queryDocumentSnapshot.documentID)
            }

            self.getFavoriteAnime(onSuccess: onSuccess, onFailure: onFailure)
        }
    }

    private func removeFavoriteWith(documentID: String) {
        let collectionRef = db.collection("Favorite")
        collectionRef.document(documentID).delete()
    }
}
