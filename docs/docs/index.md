# Welcome to Liquidart

![Liquidart](https://github.com/aldrinsartfactory/liquidart/raw/main/resources/images/liquidart.png)

**Liquidart** is an HTTP web server framework for building REST Applications written in Dart. We offer built-in support for PostgreSQL, a valuable open source database engine.

This is a revival of the Aqueduct project, which was abandoned by the StableKernel team. They did a great job with the Aqueduct package, but reached a point where they can no longer support its active development.

To download the latest version of the Liquidart package for Dart and Flutter, go to [Liquidart on pub.dev](https://pub.dev/packages/liquidart)

## How to Use this Documentation

The menu on the left contains a hierarchy documents. Those documents - and how you should use them - are described in the following table:

| Location       | Description  | Recommended Usage |
| :------------- | :----------: | ----------------: |
| Top-Level (e.g. Tour, Core Concepts) | Introductory and quick reference documents | Read these documents when you are new to Liquidart |
| Snippets | Example code snippets of common behaviors | Read these documents for examples and inspiration |
| Tutorial | A linear, guided tutorial to building your first application | A 1-3 hour long tutorial to learn Liquidart |
| Guides | A hierarchy of in-depth guides for the many facets of Liquidart | Refer to these documents often to understand concepts and usage of Liquidart |

In addition to these guides, be sure to use the [API Reference](https://pub.dev/documentation/liquidart/latest) to look up classes, methods, functions and other elements of the framework.

## Getting Started Tips

The best way to get started is to read the [Core Concepts](https://aldrinsartfactory.github.io/liquidart/core_concepts/) guide while working through the [tutorial](https://aldrinsartfactory.github.io/liquidart/tutorial/getting-started/). Then, add new features to the application created during the tutorial by looking up the classes you are using in the [API Reference](https://pub.dev/documentation/liquidart/latest), and implementing behavior not found in the tutorial.

Once you have the basic concepts down, start reading the guides in the left hand menu to take advantage of the many features of the framework. Check out the repository of examples here.

Import this file into IntelliJ IDEA for Liquidart file and code templates.

Liquidart is catered towards test-driven development - the best way to write an application is to write tests using a test harness and run those tests after implementing an endpoint. You may also run the command liquidart document client in your project directory to generate a web client for your application. This client can be opened in any browser and will execute requests against your locally running application.