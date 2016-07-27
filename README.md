# NSURL+xattr

This is my humble attempt at making [@okla](https://github.com/okla)'s [swift-xattr](https://github.com/okla/swift-xattr) easier to use.

###Installation###

Just add `NSURL+xattr.swift` to your project.

###Usage###

```swift
let url = documentsDirectory.URLByAppendingPathComponent("example.txt")

url.setAttribute("com.example.color", value: "red")
url.setAttribute("com.example.user", value: "Daniel")

if let color = url.getAttribute("com.example.color") {
  print(color) // Prints "red"
}

if let attributes = url.attributes {
  print(attributes) // Prints ["com.example.color": "red", "com.example.user": "Daniel"]
}

url.removeAttribute("com.example.user")

if let attributes = url.attributes {
  print(attributes) // Prints ["com.example.color": "red"]
}
```
