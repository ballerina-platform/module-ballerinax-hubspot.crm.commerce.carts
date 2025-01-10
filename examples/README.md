# Examples

The `ballerinax/hubspot.crm.commerce.carts` connector provides practical examples illustrating usage in various scenarios. Explore these examples, covering use cases:

1. [Single Cart Management](./carts/) - Create, retrieve, update, search, and delete a single cart for a customer.

2. [Batch of Carts Management](./batch-of-carts/) - Create, retrieve, update, and archive a batch of carts for customers.


## Prerequisites

1. Generate Hubspot credentials to authenticate the connector as described in the [Setup guide](../ballerina/Package.md#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = "<client-id>"
    clientSecret = "<client-secret>"
    refreshToken = "<refresh-token>"
    ``` 

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
