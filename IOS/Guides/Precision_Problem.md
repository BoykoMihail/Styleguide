## Проблема с точностью в числах с плавающей запятой

### Проблемы с точностью в моделях апи-генератора
Если вы столкнулись с проблемой с точностью в числах с плавающей запятой при маппинге объекта в json, при этом проблема присутсвует и при использовании типа `Decimal`, и типа `Double`, то необходимо:
- Поключить [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- Для моделей, в которых возникает данная проблема, необходимо реализовать протокол `ImmutableMappable`
- Реализовать методы запросов

#### Пример:
Допустим, есть модель `Coordinates`:
```Swift
final class Coordinates: Codable {
    private enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
    }

    let longitude: NSDecimalNumber
    let latitude: NSDecimalNumber

    init(longitude: NSDecimalNumber, latitude: NSDecimalNumber) {
        self.longitude = longitude
        self.latitude = latitude
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        let longitude = try container.decode(Decimal.self, forKey: .longitude)
        self.longitude = NSDecimalNumber(decimal: longitude)
        let latitude = try container.decode(Decimal.self, forKey: .latitude)
        self.latitude = NSDecimalNumber(decimal: latitude)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(longitude.doubleValue, forKey: .longitude)
        try container.encode(latitude.doubleValue, forKey: .latitude)
    }
}
```
В которой есть проблема с точностью при конвертации в json.
В этом случае надо реализовать протокол `ImmutableMappable`:
```Swift
import ObjectMapper

extension Coordinates: ImmutableMappable {
    convenience init(map: Map) throws {
        self.init(longitude: try map.value("longitude", using: NSDecimalNumberTransform()),
                  latitude: try map.value("latitude", using: NSDecimalNumberTransform()))
    }

    func mapping(map: Map) {
        longitude >>> map["longitude"]
        latitude >>> map["latitude"]
    }
}
```
Далее нужно реализовать методы запроса:
```Swift
import Alamofire
import LeadKit
import ObjectMapper
import RxSwift

extension ProjectApiNetworkingProtocol {
    func getCoordinates() -> Single<Coordinates> {
        let parameters = deferredApiRequestParameters(url: url)

        return parameters.flatMap {
            self.rxDataRequest(with: $0).map { response, data -> Coordinates in
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    return try Coordinates(JSON: json)
                } catch {
                    throw RequestError.mapping(error: error, response: data)
                }
            }.asSingle()
        }
    }

    func postCoordinates(_ coordinates: Coordinates) -> Single<ResponseModel> {
        let parameters = deferredApiRequestParameters(relativeUrl: url,
                                                      method: .post,
                                                      parameters: coordinates.toJSON())

        return apiRequest(with: parameters, decoder: JSONDecoder())
    }
}
```
### Проблемы с точностью в проекте
Если вы столкнулись с проблемой с точностью в числах с плавающей запятой в проекте, тогда стоит использовать `Decimal`.
Если проблема с точностью возникает при округлении чисел, то необходимо использовать метод (из [LeadKit](https://github.com/TouchInstinct/LeadKit) версии 0.9.23 или выше) `roundValue(precision: UInt, roundingMode: NSDecimalNumber.RoundingMode)` у Double или Decimal.
Так же если при использовании `Double` возникают проблемы с точностью при делении или умножении, можно реализовать эти действия с использованием `Decimal`.
