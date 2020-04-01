# ISO8601DurationFormatter

A formatter for converting [ISO 8601 durations](https://en.wikipedia.org/wiki/ISO_8601#Durations) to DateComponents.

## Installation

### Swift Package Manager
Add the following to your Package.swift file's dependencies:
```swift
.package(url: "https://github.com/kkla320/ISO8601DurationFormatter.git", from: "1.1.0")
```
And then import wherever needed: `import ISO8601DurationFormatter`

## Example

### Converting a string to DateComponents

```swift
    let input = "PT40M"
    let dateComponents = formatter.dateComponents(from: input)
    if dateComponents != nil {
        print(dateComponents!.minute) // 40
    }
```

### Converting DateComponents to string

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

Special thanks to [Igor-Palaguta](https://github.com/Igor-Palaguta) for implementing the most in his project [YoutubeEngine](https://github.com/Igor-Palaguta/YoutubeEngine).
