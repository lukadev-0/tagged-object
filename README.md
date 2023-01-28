# TaggedObject

Very simple utility to create objects bound to CollectionService tags.

## Installation

This package is available on Wally at [`lukadev-0/taggedobject`](https://wally.run/package/lukadev-0/taggedobject).

```toml
[dependencies]
TaggedObject = "lukadev-0/taggedobject@1.0.0"
```

## Usage

```lua
local TaggedObject = require(path.to.TaggedObject)

TaggedObject("MyTagName", function(instance, janitor)
  janitor:Add(
    RunService.Heartbeat:Connect(function(deltaTime)
      instance.CFrame *= CFrame.fromEulerAnglesXYZ(0, deltaTime * math.pi, 0)
    end)
  )
end)
```

The function is called everytime the tag is added, and for
every object which already has the tag.

- `instance` is the instance with the tag.
- `janitor` is a Janitor which is cleaned up when the tag is removed

TaggedObject uses [howmanysmall's janitor library](https://howmanysmall.github.io/Janitor/).
