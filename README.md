# ISO8601DurationFormatter

A formatter for converting ISO8601 durations to DateComponents.

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
