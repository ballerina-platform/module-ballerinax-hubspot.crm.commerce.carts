## Batch of Carts Management

This use case demonstrates how the HubSpot CRM Commerce Carts API can be used to automate the process of managing multiple customer carts at once. By leveraging the endpoints for creating, retrieving, updating, and archiving carts in bulk, this example streamlines tasks that would otherwise be time-consuming if done individually.

## Prerequisites

### 1. Setup Hubspot developer account

Refer to the [Setup guide](https://github.com/module-ballerinax-hubspot.crm.commerce.carts/tree/main/ballerina/Package.md#setup-guide) to obtain necessary credentials (client Id, client secret, tokens).

### 2. Configuration

Create a `Config.toml` file in the example's root directory and, provide your Hubspot account related configurations as follows:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```