# Yelfie

## Introduction

> This app display businesses near your  location. 
* App uses Yelp Fusion API for fetching the businesses and user reviews.
* App is written in MVP design pattern
* UI is done via storyboard, nibs and code
* Third party libraries are moya, kingfisher and lottie 
* Cocoapods for the dependency manager

## Code Samples

       let input = SearchInput(term: keyword,
                                latitude: myLocation.latitude,
                                longitude: myLocation.longitude,
                                sortBy: sort)
        
        cancellable?.cancel()
        cancellable = apiService.request(.search(input: input),
                    target: SearchResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.presentThumbnailables(thumbnailables: response.businesses)
        }

## Installation

1) Clone repo by running this on your terminal `git clone https://github.com/alvinjohntandoc/yelpie-bell.git`
1) Install cocoapods. https://cocoapods.org/
2) Go to the root directory and run pod install
3) Open (double click) Yelpie.xcworkspace
4) Build and run the app on any iOS simulator (iPhoneX up is recommended)
