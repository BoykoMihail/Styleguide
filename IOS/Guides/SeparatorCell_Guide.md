# Базовая ячейка с сепараторами

Для использования ячейки с сепараторами вам необходим [LeadKit](https://github.com/TouchInstinct/LeadKit) версии 0.6 и выше.

Для создания ячейки необходимо выполнить следующие шаги:

- унаследоваться от класса `SeparatorCell`

```swift
final class MyCell: SeparatorCell {}

extension BillTotalCell: ConfigurableCell {
    func configure(with viewModel: MyCellViewModel) {}
}
```

- после создания `TableRow`(с заданной вью-моделью), установить тип сепаратор. Пример показан ниже.

```swift
let row = TableRow<MyCell>(item: ВЬЮ_МОДЕЛЬ)
row.set(separatorType: НЕОБХОДИМЫЙ_ТИП_СЕПАРАТОРА)
```

- актуальные типы сепараторов приведены [здесь](https://github.com/TouchInstinct/LeadKit/blob/master/Sources/Classes/Views/SeparatorCell/CellSeparatorType.swift#L26)
