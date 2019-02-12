# Swift Template for OpenFaaS

## NOTICE

This README file is under constiant change as this project is built out, and as such not all information contained within will be up to date. Any issues will be resolved as soon as possible.

## Description

Allows the usage of Swift within OpenFaaS containers, offering support for the Swift Package Manager (SPM) to be used. This greatly widens what is possible within your Swift function while keeping your code at a minimum.

This template is based heavily on the work already in place by [Keiran Smith](https://github.com/affix) for using Swift within the OpenFaaS system. A fair portion of the code and basis for the Docker images were taken directly from [affix/openfaas-templates-affix](https://github.com/affix/openfaas-templates-affix).

## Usage

Usage of the Swift language template assumes that faas-cli is already installed on the development machine, for cli installation help please read the [documentation](https://docs.openfaas.com/cli/install/).

From the directory you want to house the function, enter the following commands in your terminal.

```bash
faas-cli template pull https://github.com/lorenalexm/swift-template-openfaas
faas-cli new {projectname} --lang swift
```

At this point you will have a directory which contains the _{projectname}.yml_ and _Package.swift_ files, along with the template directory OpenFaaS needs for knowing how to build the image, and a _{projectname}_ directory which contains the _handler.swift_ file where you will flesh out your function.

The _handler.swift_ file houses by default a single function _process(with: String)_ returning a [String](https://developer.apple.com/documentation/swift/string), wrapped in the _Handler_ class.

The argument passed into _process(with: String)_ might be more than a basic [String](https://developer.apple.com/documentation/swift/string) object, and could even be  [JSON](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON) presented to your function as a string; allowing you to use the [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder) together with a [Codable](https://developer.apple.com/documentation/swift/codable) struct.

Once your function is fleshed out and ready for use, and keeping with the simplicity of OpenFaaS, simply issue the following command from the base directory of your function. This will build the image for the function, push it to your container registry, and send it off to your OpenFaaS installation.

```bash
faas-cli up -f {projectname}.yml
```

## Examples

Barebones example, doing nothing more than returning a success message.

```swift
class Handler {
	func process(with: String) -> String {
	    return "success"
	}
}
```

A slightly more in-depth example, making use of the [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder) class and [Codable](https://developer.apple.com/documentation/swift/codable)

```swift
import Foundation

struct Person: Codable {
	var name: String
	var age: Int
}

class Handler {
	func process(with: String) -> String {
		guard let json = args.data(using: .utf8) else {
			return "Unable to encode string to data"
		}
		let decoder = JSONDecoder()
		if let person = try? decoder.decode(Person.self, from: json) {
			return "Hello \(person.name), you are \(person.age) years old."
		} else {
			return "Unable to decode string"
		}
	}
}
```


## License

This project is licensed under the MIT license, see LICENSE file for further details.
