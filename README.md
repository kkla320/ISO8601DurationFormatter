# ISO8601DurationFormatter

A formatter for converting ISO8601 durations to DateComponents.

## Installation

### Swift Package Manager
Add the following to your Package.swift file's dependencies:
```swift
.package(url: "https://github.com/kkla320/ISO8601DurationFormatter.git", from: "1.0.0")
```
And then import wherever needed: import ISO8601DurationFormatter

## Example

```swift
    let input = "PT40M"
    let dateComponents = formatter.dateComponents(from: input)
    if dateComponents != nil {
        print(dateComponents!.minute)
        // Should print 40
    }
```

Special thanks to [Igor-Palaguta](https://github.com/Igor-Palaguta) for implementing the most in his project [YoutubeEngine](https://github.com/Igor-Palaguta/YoutubeEngine).
