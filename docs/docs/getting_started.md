# Getting Started

## Installation

1. Install Dart
2. Activate the Liquidart CLI
   **`pub global activate liquidart`**
3. Create a new project.
   **`liquidart create my_project`**

Open the project directory in an [IntelliJ IDE](https://www.jetbrains.com/idea/download/), [Atom](https://atom.io/) or [Visual Studio Code](https://code.visualstudio.com/). All three IDEs have a Dart plugin.

## How to learn Liquidart

There are different approaches depending on how you prefer to learn.

- The [guided tutorial](https://liquidart.aldrinsartfactory.com/documentation/tut/getting-started/) is a hands-on walkthrough where you build an application while learning basic Liquidart concepts.
- The [example repository](https://github.com/stablekernel/liquidart_examples) contains a few deployable applications that you may review or tinker with.
- The guides (located in the menu on this website) dive deeply into the concepts of Liquidart and show example code.
- [Creating a new project](https://liquidart.aldrinsartfactory.com/documentation/getting_started/#creating-a-project) and using the [API reference](https://pub.dev/documentation/liquidart/latest/) to jump right in.

It is best to first understand how HTTP requests are responded to - the foundation of Liquidart - before moving on to topics such as the ORM and OAuth 2.0. Both the tutorial and the [HTTP guides](https://liquidart.aldrinsartfactory.com/documentation/http/) are the primary source of this information. A project created by the liquidart tool has example routes connected for modification, too.

## Creating a Project

The `liquidart create` command-line tool creates new Liquidart project directories. The default template contains the minimal project structure for running an Liquidart application. A project name must be *snake_case*.

```
liquidart create my_project_name
```

Other templates exist that contain foundational code for using Liquidart's ORM and OAuth 2.0 implementation. These templates can be listed:

```
liquidart create list-templates
```

You may provide the name of a template when creating a project to use that template:

```
liquidart create -t db my_project_name
```

## Using the Liquidart ORM

Liquidart's ORM uses **PostgreSQL**. During development, you will need a locally running instance of PostgreSQL. On macOS, installing [Postgres.app](https://postgresapp.com/) is a very convenient way to run PostgreSQL locally. For other platforms, see [PostgreSQL's downloads page](https://www.postgresql.org/download/).

When creating a project, use the db template. If adding to an existing project, see this guide.

To create a database, make sure PostgreSQL is running and open the command-line utility to connect to it.

`psql`

!!! danger "Warning"
    If you installed Postgres.app, `psql` is inside the application bundle. You can run this tool by selecting `Open psql` from the status bar item in the Finder.

Then, create a database that your application will connect to and a user that it will connect with:

```
CREATE DATABASE my_database_name;
CREATE USER dart_app WITH PASSWORD 'dart';
GRANT ALL ON DATABASE my_database_name TO dart_app;
```

An application must create a ManagedContext that handles the connection to this database:

```dart
class MyChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    var dataModel = new ManagedDataModel.fromCurrentMirrorSystem();
    var store = new PostgreSQLPersistentStore.fromConnectionInfo(
      "dart_app", "dart", "localhost", 5432, "my_database_name");
    context = new ManagedContext(dataModel, store);
  }

  ...
}
```

Once you have declared *`ManagedObjects`* in your application, generate the database schema by generating and executing migrations from your project's directory:

```
liquidart db generate
```

```
liquidart db upgrade --connect postgres://dart_app:dart@localhost:5432/my_database_name
```

See the guides on [connecting to a database](https://liquidart.aldrinsartfactory.com/documentation/db/connecting/) and [testing with a database](https://liquidart.aldrinsartfactory.com/documentation/testing/mixins/) for more details on configuring a database connection.