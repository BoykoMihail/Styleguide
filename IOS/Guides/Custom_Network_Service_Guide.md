# Как создать и настроить NetworkService на проекте

- [Как добавить в проект](#Как-добавить-в-проект)
  - [Подключение cocoa pod](#Подключение-cocoa-pod)
- [Кастомный NetworkService](#Кастомный-networkservice)
  - [Требования](#Требования)
  - [Реализация NetworkService](#Реализация-networkservice)
  - [Обработка ошибок маппинга при запросах](#Обработка-ошибок-маппинга-при-запросах)
  - [Обработка ошибок маппинга в UI](#Обработка-ошибок-маппинга-в-UI)
  - [Обработка ошибки 401](#Обработка-ошибки-401)

## Как добавить в проект
### Подключение cocoa pod
Для добавления в проект нужно подключить pod LeadKit версии 0.9.16 или выше:

```ruby
pod "LeadKit", '~> 0.9.16'
```

И api-generator 1.2.22 или выше:

```sh
. build-scripts/xcode/build_phases/api_generator.sh 1.2.22
```

## Кастомный NetworkService
Допустим, на вашем проекте из-за особенностей сервера заказчика или каких-либо требований с его стороны вам необходимо кастомизировать клиент-серверную коммуникацию.

### Требования
В примере будут следующие требования:

1. Необходимо использовать один из URL для доступа к апи в зависимости от флагов компиляции (aka `STAGING`, `PRODUCTION`)
2. Сервер может возвращать JSON ответ с HTTP кодом 422 или 500.
3. Необходимо отправлять дополнительные HTTP заголовки для аналитики и авторизации
4. Стандартное время ожидания ответа должно быть увеличено до 60 секунд
5. Максимальное кол-во одновременных запросов должно быть увеличено до 16
6. При ошибке с HTTP кодом 401 необходимо делать разлогин

### Реализация NetworkService
Итак, допустим на вашем проекте работает api-generator, тогда реализация этих требований в NetworkService'е будет выглядеть следующим образом:

```swift
extension NetworkServiceConfiguration {

    // Необходимо использовать один из URL для доступа к апи в зависимости от флагов компиляции (aka `STAGING`, `PRODUCTION`)
    static var staticBaseUrl: String {
        #if STAGING
            return "http://staging7.farmy.ch/api/"
        #else
            return FarmyNetworkService.apiBaseUrl
        #endif
    }

    // Необходимо отправлять дополнительные HTTP заголовки для аналитики и авторизации
    static var commonHeaders: HTTPHeaders {
        return ["X-Farmy-Mobile-App": "True"]
    }

    static var customConfiguration: NetworkServiceConfiguration {
        // Стандартное время ожидания ответа должно быть увеличено до 60 секунд
        var configuration = NetworkServiceConfiguration(baseUrl: NetworkServiceConfiguration.staticBaseUrl,
                                                        timeoutInterval: 60,
                                                        additionalHttpHeaders: NetworkServiceConfiguration.commonHeaders)

        // Сервер может возвращать JSON ответ с HTTP кодом 422 или 500.
        configuration.acceptableStatusCodes = SessionManager.defaultAcceptableStatusCodes.union([422, 500])
        // Максимальное кол-во одновременных запросов должно быть увеличено до 16
        configuration.sessionConfiguration.httpMaximumConnectionsPerHost = 16

        return configuration
    }

}

final class MyNetworkService: FarmyNetworkService, Singleton {

    static let shared = MyNetworkService()

    init() {
        super.init(configuration: .customConfiguration)
    }

    override func apiRequest<T: Decodable>(with parameters: ApiRequestParameters,
                                           additionalValidStatusCodes: Set<Int> = [],
                                           decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
        // При ошибке с HTTP кодом 401 необходимо делать разлогин
        return super.apiRequest(with: parameters, 
                                additionalValidStatusCodes: additionalValidStatusCodes, 
                                decoder: decoder)
            .on401Logout()
    }

    private var authHeaders: HTTPHeaders {
        if AuthorizationService.isLoggedIn {
            return ["Authorization": AuthorizationService.loggedInSession.token]
        } else {
            return [:]
        }
    }

    override func deferredApiRequestParameters(relativeUrl: String,
                                               method: HTTPMethod = .get,
                                               parameters: Parameters? = nil,
                                               requestEncoding: ParameterEncoding? = nil,
                                               requestHeaders: HTTPHeaders? = nil) -> Single<ApiRequestParameters> {
        return .deferred {
            // Необходимо отправлять дополнительные HTTP заголовки для авторизации
            let finalHeaders = (requestHeaders ?? [:]).merging(authHeaders) { current, _ in current }

            return super.deferredApiRequestParameters(relativeUrl: relativeUrl,
                                                      method: method,
                                                      parameters: parameters,
                                                      requestEncoding: requestEncoding,
                                                      requestHeaders: finalHeaders)
        }
    }

}
```

### Обработка ошибок маппинга при запросах
Если сервер возвращает нам модель ошибки вместо ожидаемой модели ответа, то для обработки можно использовать следующий метод:

```swift
extension Error {
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder()) throws -> T?
}
```

Для обработки сетевых запросов, которые реализованы с помощью RX, можно исползовать следующие методы:

- Observable
```swift
extension ObservableType {
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder(),
                                          handler: @escaping ParameterClosure<T>) -> Observable<E>
}
```
- Single
```swift
extension PrimitiveSequence where Trait == SingleTrait {
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder(),
                                          handler: @escaping ParameterClosure<T>) -> PrimitiveSequence<Trait, Element>
}
```
- Completable
```swift
extension PrimitiveSequence where Trait == CompletableTrait, Element == Never {
    func handleMappingError<T: Decodable>(with decoder: JSONDecoder = JSONDecoder(),
                                          handler: @escaping ParameterClosure<T>) -> Completable
}
```

В приведенных методах в качестве параметра передается блок handler, в котором можно получить необходимую модель.

### Обработка ошибок маппинга в UI

```swift
MyApiNetworkService.shared
    .ordersListing()
    .handleMappingError { (apiError: MyApiErrorModel) in
        // handle mapping-error model
    }
    .do(onSuccess: { orders in
        // handle success
    })
    .disposed(by: disposeBag)
```

### Обработка ошибки 401
Нужно создать extension к `RequestError`:

```swift
extension RequestError {

    var afError: AFError? {
        switch self {
        case .invalidResponse(let afError):
            return afError
        default:
            return nil
        }
    }

}
```
и к `Single`:

```swift
extension PrimitiveSequence where Trait == SingleTrait {

    func on401Logout() -> PrimitiveSequence<Trait, Element> {
        return `do`(onError: { error in
            if error.requestError?.afError?.responseCode == 401 {
                DispatchQueue.main.async {
                    AuthorizationService.logout()
                    NavigationService.makeLoginRootController()
                }
            }
        })
    }

}
```

И этот код использовать в `MyApiNetworkService` как показано в листинге этого класса.

