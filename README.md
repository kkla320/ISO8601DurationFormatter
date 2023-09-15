# ISO8601DurationFormatter

A formatter for converting [ISO 8601 durations](https://en.wikipedia.org/wiki/ISO_8601#Durations) to DateComponents.

## Installation

### Swift Package Manager
Add the following to your Package.swift file's dependencies:
```swift
.package(url: "https://github.com/kkla320/ISO8601DurationFormatter.git", from: "2.0.0")
```
And then import wherever needed
```swift
import ISO8601DurationFormatter
```

## Example

### Using ISO8601DurationFormatter

#### Converting a string to DateComponents
```swift
let input = "PT40M"
let dateComponents = try formatter.dateComponents(from: input)
print(dateComponents.minute) // 40
```

#### Converting DateComponents to string
```swift
let dateComponents = DateComponents(year: 6,
                                    month: 2,
                                    day: 2,
                                    hour: 4,
                                    minute: 44,
                                    second: 22,
                                    weekOfYear: 2)
let iso8601DurationString = formatter.string(from: input)
print(iso8601DurationString) // P6Y2M2W2DT4H44M22S
```

### Using extension methods

#### Converting a string to DateComponents
```swift
let dateComponents = try DateComponents(iso8601DurationString: "PT40M")
print(dateComponents.minute) // 40
```

You can also use negative durations as defined by [ISO 8601-2:2019](https://www.iso.org/standard/70908.html).
```swift
let dateComponents = try DateComponents(iso8601DurationString: "-PT40M")
print(dateComponents.minute) // -40
```
Be aware, that this is defined in an extension of the standard. Other libaries could not work with negative values.

#### Converting DateComponents to string
```swift
let dateComponents = DateComponents(year: 6,
                                    month: 2,
                                    day: 2,
                                    hour: 4,
                                    minute: 44,
                                    second: 22,
                                    weekOfYear: 2)

let ISO8601DurationString = dateComponents.toISO8601Duration()
print(ISO8601DurationString) // P6Y2M2W2DT4H44M22S
```

You can also configure the behaviour of `toISO8601Duration` with the `omitZeroOrNilValues` parameter

```swift
let dateComponents = DateComponents(year: 0,
                                    month: 0,
                                    day: 2,
                                    hour: 4,
                                    minute: 44,
                                    second: nil,
                                    weekOfYear: 2)

let ISO8601DurationString = dateComponents.toISO8601Duration(omitZeroOrNilValues: true)
print(ISO8601DurationString) // P2W2DT4H44M
```

Special thanks to [Igor-Palaguta](https://github.com/Igor-Palaguta) for implementing the most in his project [YoutubeEngine](https://github.com/Igor-Palaguta/YoutubeEngine).
